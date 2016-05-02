Focal Plane Electronics Software Testing for TESS
-------------------------------------------------

© 2015 John P. Doty &amp; Matthew P. Wampler-Doty, Noqsi Aerospace Ltd.

[![Build Status](https://travis-ci.org/TESScience/tessfpe.svg?branch=master)](https://travis-ci.org/TESScience/tessfpe)

This project contains the design specification for the focal plane electronics for the [Transiting Exoplanet Survey Satellite (TESS)](http://space.mit.edu/TESS/TESS/TESS_Overview.html).

Installation
------------

### Global Installation

To install the latest revision, type at a command line:

```bash
# pip install git+git://github.com/TESScience/tessfpe.git@6.2.6
```

Here `6.2.12` is the latest tagged release.  For more information on releases, see:

[https://github.com/TESScience/tessfpe/releases](https://github.com/TESScience/tessfpe/releases)

### Development Installation

It is convenient to make a local installation for development testing.  To make a local installation in the `testsuite` directory of this repository, type:

```bash
# git clone https://github.com/TESScience/tessfpe.git
# make -C tessfpe install_testsuite
```

For more information, see the wiki documentation:

[https://github.com/TESScience/tessfpe/wiki/CLI-tessfpe-Documentation#development-installation](https://github.com/TESScience/tessfpe/wiki/CLI-tessfpe-Documentation#development-installation)

Assuming an Observatory Simulator is hooked up, you can run the testsuite on it by typing (in the BASH shell):

```bash
# source testsuite/tessfpe/bin/activate
# testsuite/testsuite.sh
```

Documentation
-------------

You can read the latest documentation, including software tutorials, can be found on our GitHub wiki:

[https://github.com/TESScience/tessfpe/wiki](https://github.com/TESScience/tessfpe/wiki)


Testing
-------

To run the tests (which do sanity checks on the python module) type:

```bash
# make test
```

Release
-------

To make a release, first create a [git tag](https://git-scm.com/book/en/v2/Git-Basics-Tagging) conforming to the following convention:

<center>*A.B.C*</center>

Where:

  - *A* is the major revision number
  - *B* is the minor revision number
  - *C* is the review release number
