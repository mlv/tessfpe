from setuptools import setup, find_packages
import subprocess
import glob
VERSION = "6.2.8"
setup (
  name = 'tessfpe',
  packages = find_packages(),
  package_data = {
      'tessfpe': [
                  'data/files/*.tsv',                      # Add all of the TSV files in the package
                  'data/files/*.fpe',                      # Add all of the preconfigured FPE programs in the package
                  'data/files/*.defaults',                 # Add all of the default settings to the package
                  'data/files/*.sequences',                # Add all of the preconfigured sequences to the package
                  'dhu/MemFiles/*.bin',                    # Add all of the binary files to be uploaded to the FPE
                  'sequencer_dsl/tikz/Makefile.template',  # Add Makefile template used for compiling TikZ timing diagrams
                 ],
  },
  version = VERSION,
  description = 'Software to accompany the Focal Plane Electronics (FPE) for the Transiting Exoplanet Survey Satellite (TESS)',
  author = 'Matthew Wampler-Doty Doty',
  author_email = 'matthew.wampler.doty@gmail.com',
  url = 'https://github.com/TESScience/tessfpe', # use the URL to the github repo
  download_url = 'https://github.com/TESScience/tessfpe/tarball/{VERSION}'.format(VERSION=VERSION),
  scripts = glob.glob('scripts/*'),
  install_requires=[
      'grako==3.6.7',
      'pandas>=0.17.1',
      'sh>=1.11',
      'matplotlib>=1.5.0',
      'termcolor>=1.1.0'
  ],
)
