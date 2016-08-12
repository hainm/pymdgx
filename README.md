# pymdgx
my playground with mdgx python interface.

Nothing is serious yet.

Install
-------

```bash
make
```

Examples
--------

```python
import cutil

prmtop = 'vAla3.prmtop'
rst7 = 'vAla3.rst7'

context = cutil.setup(prmtop, rst7)

# trigger force and energy calculation
context.positions = context.positions

# get energies and forces
mdgx_ene, mdgx_forces = context.energy_forces()
```
