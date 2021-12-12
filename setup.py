#!/usr/bin/env python3

"""Siriuspy setup script."""

import pkg_resources
from setuptools import find_packages, setup


def get_abs_path(relative):
    return pkg_resources.resource_filename(__name__, relative)


with open(get_abs_path("README.md"), "r") as _f:
    _long_description = _f.read().strip()

with open(get_abs_path("VERSION"), "r") as _f:
    __version__ = _f.read().strip()

with open(get_abs_path("requirements.txt"), "r") as _f:
    _requirements = _f.read().strip().split("\n")


setup(
    name="msxdev",
    version=__version__,
    author="Ximenes R. Resende",
    description="Development tools for MSX",
    long_description=_long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/xresende/msxdev",
    download_url="https://github.com/xresende/msxdev",
    license="GNU GPLv3",
    classifiers=[
        "Intended Audience :: Games/Leasure",
        "Programming Language :: Python",
        "Topic :: Programming/Engineering",
    ],
    packages=find_packages(),
    # package_dir="msxdev",
    install_requires=_requirements,
    package_data={"msxdev": ["disasm/*.asm"]},
    include_package_data=True,
    test_suite="",
    scripts=["scripts/msxdev-disasm-bios.py"],
    python_requires=">=3.6",
    zip_safe=False,
)
