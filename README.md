# pymdgx
my playground with mdgx python interface.

Nothing is serious yet.

Install
-------

```bash
amber.python setup.py install --prefix=$AMBERHOME

# or
# make
```

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

Compare to sander energy and force
----------------------------------
```bash
make test
```
