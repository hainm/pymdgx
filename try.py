import cutil

prmtop = 'vAla3.prmtop'
rst7 = 'vAla3.rst7'

data = cutil.test_load('vAla3.prmtop', 'vAla3.rst7')

setup = cutil.setup(prmtop, rst7)
