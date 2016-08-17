# pymdgx

[![Build Status](https://travis-ci.org/hainm/pymdgx.svg?branch=master)](https://travis-ci.org/hainm/pymdgx)

Playground with mdgx python interface. This repo is for developer.

Nothing is serious yet.

Examples
--------

```python
import mdgx

prmtop = 'vAla3.prmtop'
rst7 = 'vAla3.rst7'

context = mdgx.setup(prmtop, rst7)

# get energies and forces
mdgx_ene, mdgx_forces = context.energy_forces()

# set positions
context.positions = new_positions
```

Install
-------

```bash
amber.python setup.py install --prefix=$AMBERHOME

# or
# make
```

Require
-------

- cython
- numpy
- AmberTools >= 16

Compare to sander energy and force
----------------------------------
```bash
make test
```
