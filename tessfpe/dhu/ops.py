#!/usr/bin/env python2.7
"""
This module contains object for handling setting operating parameters for the FPE.

Usage
-----

To create an operating parameter object, type (for example):

>>> op = OperatingParameter("ccd4_parallel_low", \
 {"address": 89, \
  "high": -13.2, \
  "low": 0.0, \
  "range_high": -13.2, \
  "range_low": 0.0, \
  "unit": "V", \
  "relative_to": "", \
  "default": -5.0})

You can read the supplied info by simply accessing the values like so:

>>> op.name
'ccd4_parallel_low'
>>> op.address
89
>>> op.high
-13.2
>>> op.low
0.0
>>> op.unit
'V'
>>> op.default
-5.0

Every operating parameter has a value, which is set to the specified default value by default.

>>> op.value == op.default
True
>>> op.value
-5.0

When trying to set a parameter, a bounds check is performed.  If the value is set out of bounds, an `Exception` is raised.

>>> op.value = 9
Traceback (most recent call last):
...
Exception: Attempting to set value out of bounds.
value: 9
name: ccd4_parallel_low
address: 89
low: 0.0
high: -13.2

*Note the signs of high and low can be flipped.*

Associated with each set value is a `twelve_bit_value` quantization.

This is an unsigned, 12 bit integer.

Setting an `OperatingParameter`'s `value` to the specified `low` value
makes the `twelve_bit_value` zero:
>>> op.value = op.low
>>> op.twelve_bit_value
0

Setting an `OperatingParameter`'s `value` to the specified `low` value
makes the `twelve_bit_value` equal to `2**12 - 1 == 4095`:
>>> op.value = op.high
>>> op.twelve_bit_value
4095

Symmetrically, the `twelve_bit_value` may be set, and the `value` is adjusted to reflect the change.
>>> op.twelve_bit_value = 0
>>> op.value == op.low
True

The values set are only approximate; they can only match the declared high and low values up to an epsilon tolerance:
>>> op.twelve_bit_value = 0xFFF
>>> abs(op.value - op.high) < 0.01
True

One can also create a *collection* of operating parameters, like so:

>>> ops = OperatingParameters()

This object has two important attributes: `defaults` and `values`

These attributes are maps which have the same keys.

>>> ops.defaults.keys() == ops.values.keys()
True

Provided that `/tmp/operator_parameter_settings.json` does not exist, these attributes should be equal

>>> import os
>>> os.path.isfile('/tmp/operator_parameter_settings.json') or ops.defaults == ops.values
True

Operating parameters controlled by this object can be accessed two different ways:
  - You can use `ops.address` to set an operating parameter at a particular address
  - You can use `ops.<name>` to set an operating parameter with a particular name

>>> ops.address[50].name
'ccd4_input_gate_2'
>>> ops.ccd4_input_gate_2 = -5.0
>>> ops.address[50].value
-5.0

TODO: talk about derived parameters

"""

import collections
import binary_files

OperatingParameterInfo = \
    collections.namedtuple('OperatingParameterInfo',
                           ['name', 'address', 'high', 'low', 'range_low', 'range_high', 'unit', 'default',
                            'relative_to'])


class OperatingParameter(object):
    """An operating parameter object for the FPE Data Handling Unit (DHU) object"""

    def __init__(self, name, info):
        self.info = OperatingParameterInfo(name=name, **info)
        self._twelve_bit_value = None
        self._value = None
        self.value = self.info.default

    # Delegation Pattern https://en.wikipedia.org/wiki/Delegation_pattern
    @property
    def name(self):
        """The name of the parameter"""
        return self.info.name

    @property
    def address(self):
        """The address of the parameter"""
        return self.info.address

    @property
    def high(self):
        """The high value of the parameter"""
        return self.info.high

    @property
    def low(self):
        """The low value of the parameter"""
        return self.info.low

    @property
    def range_high(self):
        """The high value of the parameter"""
        if '_offset' in self.name:
            return self.high
        else:
            return self.info.range_high

    @property
    def range_low(self):
        """The low value of the parameter"""
        if '_offset' in self.name:
            return self.low
        else:
            return self.info.range_low

    @property
    def unit(self):
        """The units of the parameter"""
        return self.info.unit

    @property
    def default(self):
        """The default value of the parameter"""
        return self.info.default

    # Set the value, do bounds checks
    @property
    def value(self):
        """The value of the operating parameter"""
        return self._value

    @value.setter
    def value(self, x):
        actual_low = self.low
        actual_high = self.high
        if actual_high <= actual_low:
            (actual_low, actual_high) = (actual_high, actual_low)
        epsilon = 10**-5
        if not (actual_low - epsilon) <= x <= (actual_high + epsilon):
            raise Exception("Attempting to set value out of bounds.\n" +
                            "value: {}\n".format(x) +
                            "name: {}\n".format(self.name) +
                            "address: {}\n".format(self.address) +
                            "low: {}\n".format(self.low) +
                            "high: {}".format(self.high))
        self._value = x
        self._twelve_bit_value = int((x - self.low) / float(self.high - self.low) * (2 ** 12 - 1))

    @property
    def twelve_bit_value(self):
        """The value of the operating parameter as a 12 bit unsigned integer"""
        return self._twelve_bit_value

    @twelve_bit_value.setter
    def twelve_bit_value(self, x):
        if not (type(x) is int and 0 <= x < 2 ** 12):
            raise Exception(
                "Attempting to set 12 bit unsigned integer value that is either not an integer or out of bounds.\n" +
                "twelve bit value: {}\n".format(x) +
                "name: {}\n".format(self.name) +
                "address: {}\n".format(self.address) +
                "low: {}\n".format(self.low) +
                "high: {}".format(self.high))
        self._twelve_bit_value = x
        self._value = (self.high - self.low) / float(2 ** 12) * x + self.low

    def __eq__(self, other):
        if isinstance(other, self.__class__):
            return self.twelve_bit_value == other.twelve_bit_value
        else:
            return False

    def __ne__(self, other):
        return not self.__eq__(other)


class DerivedOperatingParameter(object):
    """An operating parameter object that is derived from two operating parameter objects"""

    def __init__(self, base, offset):
        self._base = base
        self._offset = offset

    def __eq__(self, other):
        if isinstance(other, self.__class__):
            # Strict equality, could pretend other parametrization are the same but let's not
            return self._base == other._base and self._offset == other._offset
        else:
            return False

    def __ne__(self, other):
        return not self.__eq__(other)

    @property
    def low(self):
        actual_offset_low = self._offset.info.low \
            if self._offset.info.low <= self._offset.info.high else self._offset.info.high
        actual_offset_range_low = self._offset.info.range_low \
            if self._offset.info.range_low <= self._offset.info.range_high else self._offset.info.range_high
        return max(self._base.value + actual_offset_low, actual_offset_range_low)

    @property
    def range_low(self):
        return self.low

    @property
    def high(self):
        actual_offset_high = self._offset.info.high \
            if self._offset.info.low <= self._offset.info.high else self._offset.info.low
        actual_offset_range_high = self._offset.info.range_high \
            if self._offset.info.range_low <= self._offset.info.range_high else self._offset.info.range_low
        return min(self._base.value + actual_offset_high, actual_offset_range_high)

    @property
    def range_high(self):
        return self.high

    @property
    def default(self):
        return self._base.default + self._offset.default

    @property
    def value(self):
        return self._base.value + self._offset.value

    @value.setter
    def value(self, x):
        self._offset.value = x - self._base.value


def values_to_5328(values):
    """Convert the value list to AD5328 codes.
       The value list is ordered by (chip address)(address within the chip).
       Each group of 8 values goes to a single chip.
       The address within the chip must appear as bits 14 through 12 of the
       code sent to the DAC. Bit 15 must be zero.
       Assuming that values is a list of 128 integers in the range 0-4095,
       ordered as above, this expression tags on the necessary bits."""
    for v in values:
        if not (type(v) is int and (0 <= v < 2 ** 12)):
            raise Exception("Value must be a unsigned 12 bit integer, was: {}".format(v))
    if len(values) != 128:
        raise Exception("Should have 128 values, had: {}".format(len(values)))
    return map(lambda x, y: x + y, list(values), 16 * range(0, 8 * 4096, 4096))


def values_from_5328(values):
    """Convert AD5328 codes to 12 bit values.
       The value list is ordered by (chip address)(address within the chip).
       Each group of 8 values goes to a single chip.
       The address within the chip must appear as bits 14 through 12 of the
       code sent to the DAC. Bit 15 must be zero.
       Assuming that values is a list of 128 integers in the range 0-4095,
       ordered as above, this expression strips off the extra bits."""
    for v in values:
        if not (type(v) is int and (0 <= v < 2 ** 15)):
            raise Exception("Value must be a unsigned 15 bit integer, was: {}".format(v))
    if len(values) != 128:
        raise Exception("Should have 128 values, had: {}".format(len(values)))
    return map(lambda x: x & 0xFFF, list(values))


class OperatingParameters(object):
    def __init__(self, fpe=None, *args, **kwargs):
        import re
        from ..data.operating_parameters import default_operating_parameters
        super(OperatingParameters, self).__init__(*args, **kwargs)
        # The underscore here is used as sloppy "private" memory
        self._fpe = fpe
        self.address = 128 * [None]
        self._operating_parameters = {}

        # Set ordinary Operating Parameters
        for (name, data) in default_operating_parameters.iteritems():
            op = OperatingParameter(name, data)
            self.address[op.address] = op
            self._operating_parameters[name] = op

        # Set Derived Operating Parameters
        self._derived_operating_parameters = {}
        for name in default_operating_parameters:
            if 'offset' in name:
                offset_name = name
                derived_parameter_name = name.replace('_offset', '')
                if 'low' in derived_parameter_name:
                    base_name = derived_parameter_name.replace('low', 'high')
                    self._derived_operating_parameters[derived_parameter_name] = \
                        DerivedOperatingParameter(self[base_name], self[offset_name])
                if 'high' in derived_parameter_name:
                    base_name = derived_parameter_name.replace('high', 'low')
                    self._derived_operating_parameters[derived_parameter_name] = \
                        DerivedOperatingParameter(self[base_name], self[offset_name])
                if 'output_drain' in derived_parameter_name:
                    base_name = re.sub(r'output_drain_._offset$', 'reset_drain', offset_name)
                    self._derived_operating_parameters[derived_parameter_name] = \
                        DerivedOperatingParameter(self[base_name],
                                                  self[offset_name])

                super(OperatingParameters, self).__setattr__(
                    derived_parameter_name,
                    self._derived_operating_parameters[derived_parameter_name])

        if fpe:
            self.set_values_from_fpe()

    def __eq__(self, other):
        if isinstance(other, self.__class__):
            return all(a == b for a, b in zip(self.address, other.address))
        else:
            return False

    def __ne__(self, other):
        return not self.__eq__(other)

    def set_values_from_fpe(self):
        """Get the operating parameters from the FPE and set them"""
        if not self._fpe:
            return self
        for idx, val in enumerate(self._fpe.cam_clv()):
            if self.address[idx]:
                self.address[idx].twelve_bit_value = val
        return self

    def keys(self):
        return self._operating_parameters.keys() + self._derived_operating_parameters.keys()

    @property
    def defaults(self):
        return {k: self[k].default for k in self.keys()}

    @property
    def values(self):
        return {k: self[k].value for k in self.keys()}

    def __getitem__(self, item):
        if item in self._operating_parameters:
            return self._operating_parameters[item]
        elif item in self._derived_operating_parameters:
            return self._derived_operating_parameters[item]
        else:
            return super(OperatingParameters, self).__getitem__(item)

    def __setattr__(self, name, value):
        if "_operating_parameters" in self.__dict__ and name in self._operating_parameters:
            self._operating_parameters[name].value = value
        elif "_derived_operating_parameters" in self.__dict__ and name in self._derived_operating_parameters:
            self._derived_operating_parameters[name].value = value
        else:
            super(OperatingParameters, self).__setattr__(name, value)

    @property
    def raw_values(self):
        """The 12-bit unsigned values of the operating parameters"""
        return [0 if x is None else x.twelve_bit_value
                for x in self.address]

    def read_clvmem(self, file_name):
        """Reads the given CLV file into internal memory"""
        vals = values_from_5328(binary_files.read_clvmem(file_name))
        for ii, val in enumerate(vals):
            if self.address[ii]:
                self.address[ii].twelve_bit_value = val

    def write_clvmem(self, file_name=None):
        """Write the clock level voltage memory; contains values for programming FPE clock level voltages
           (also known as *operating parameters*) via DACs."""
        return binary_files.write_clvmem(values_to_5328(self.raw_values), file_name)

    def send(self):
        """Send the current DAC values to the hardware."""
        # Get the frames status, restore it after we are done uploading the operating parameters
        if self._fpe is None:
            return True
        frames_status = self._fpe.frames_running_status
        self._fpe.cam_stop_frames()
        try:
            return self._fpe.upload_operating_parameter_memory(
                self.write_clvmem())
        finally:
            new_parameters = OperatingParameters(self._fpe)
            if self != new_parameters:
                self._fpe.frames_running_status = frames_status
                raise Exception("Could not set operating parameters")
            else:
                self.set_values_from_fpe()
                self._fpe.frames_running_status = frames_status

    def reset_to_defaults(self):
        """Reset the operating parameters to the defaults"""
        for a in self.address:
            if a is None:
                continue
            a.value = a.default
        return self.send()


if __name__ == "__main__":
    import doctest
    from binary_files import write_clvmem
    from sys import exit

    print write_clvmem(values_to_5328(OperatingParameters().raw_values))
    exit(0 if doctest.testmod().failed == 0 else 1)
