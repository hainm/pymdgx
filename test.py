import cutil
import sander
import parmed as pmd
from numpy.testing import assert_almost_equal as aa_eq

log = True
def print_(x, log=log):
    if log:
        print(x)

prmtop = 'vAla3.prmtop'
rst7 = 'vAla3.rst7'

context = cutil.setup(prmtop, rst7)

context.positions = context.positions + 1E-6
mdgx_ene, mdgx_forces = context.energy_forces()
print_(mdgx_ene)

pme_input = sander.pme_input()
parm = pmd.load_file(prmtop, rst7)

with sander.setup(prmtop, rst7, box=parm.box, mm_options=pme_input):
    ene, _ = sander.energy_forces()
    sander_enegies = dict((att, getattr(ene, att)) for att in dir(ene) if not
            att.startswith('_'))

print_(sander_enegies)

print_("potential energy")
print_(mdgx_ene['eptot'])
print_(sander_enegies['tot'])
