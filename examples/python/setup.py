from setuptools import setup

setup(
    name="helloworld_python",
    version="0.1",
    py_modules=["helloworld_python"],
    entry_points={
        'console_scripts': [
            'helloworld_python = helloworld_python:main',
        ],
    },
)
