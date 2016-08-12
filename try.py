import cutil
import sander
import parmed as pmd
from numpy.testing import assert_almost_equal as aa_eq

prmtop = 'vAla3.prmtop'
rst7 = 'vAla3.rst7'

data = cutil.test_load('vAla3.prmtop', 'vAla3.rst7')

context = cutil.setup(prmtop, rst7)

context.positions = context.positions + 1E-8
mdgx_ene = context.get_energies()
print(mdgx_ene)

pme_input = sander.pme_input()
parm = pmd.load_file(prmtop, rst7)

with sander.setup(prmtop, rst7, box=parm.box, mm_options=pme_input):
    ene, _ = sander.energy_forces()
    sander_enegies = dict((att, getattr(ene, att)) for att in dir(ene) if not
            att.startswith('_'))

print(sander_enegies)

print("potential energy")
print(mdgx_ene['eptot'])
print(sander_enegies['tot'])
