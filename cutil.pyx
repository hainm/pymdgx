def test_load(tname, cname):
    import parmed as pmd
    import numpy as np
    import sander

    parm = pmd.load_file(tname, cname)
    natom = len(parm.atoms) 

    cdef TrajectoryControlData tcon
    cdef PotentialFunction myu
    cdef MolecularDynamicsSystem mys
    cdef Coordinates coord_
    cdef AmberPrmtop top

    cdef double[:] phenix_coords = parm.coordinates.flatten()
    cdef double[:] target = np.zeros(10)
    cdef double[:] gradients = np.zeros(natom*3)

    tcon = create_trajcon_()
    myu = load_topology_(tname, &tcon)
    mys = create_mdsystem_(cname, &myu)

    get_mdgx_force(&phenix_coords[0], &target[0], &gradients[0], &myu, &tcon, &mys)

    with sander.setup(tname, cname, parm.box, sander.pme_input()) as context:
        ene, frc = context.energy_forces()

    data = {}
    data['energy'] = mys.sysUV
    return data

if __name__ == '__main__':
    test_load('vAla3.prmtop', 'vAla3.rst7')
