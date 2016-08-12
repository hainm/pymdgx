import numpy as np

# Some notes
# - cython will auto convert simple C struct to python dict

cdef get_positions(MolecularDynamicsSystem mys):
    import numpy as np
    cdef int n_atoms = mys.crd.natom

    cdef double[:] arr = <double[:n_atoms*3]> mys.crd.loc

    return np.asarray(arr)

cdef set_positions(double[:] arr, MolecularDynamicsSystem mys):
    cdef int i
    for i in range(mys.crd.natom):
        mys.crd.loc[i] = arr[i]

cdef class setup:
    def __init__(self, prmtop, rst7):
        cdef PotentialFunction myu

        self._traj_control = create_trajcon_()
        self._myu = load_topology_(prmtop, &self._traj_control)
        self._mdsystem = create_mdsystem_(rst7, &self._myu)

    def __enter__(self):
        return self

    def __exit__(self, *args):
        # clean
        pass

    @property
    def n_atoms(self):
        return self._mdsystem.crd.natom

    def get_positions(self):
        # compat with pysander
        return self.positions

    def set_positions(self, arr):
        # compat with pysander
        self.positions = arr

    @property
    def positions(self):
        return get_positions(self._mdsystem).reshape(self.n_atoms, 3)

    @positions.setter
    def positions(self, arr):
        cdef double[:] arr_view = np.asarray(arr).flatten()
        load_coords_(&self._myu, &self._traj_control,
                      &arr_view[0], &self._mdsystem)
        InitExecon(&(self._mdsystem.etimers))
        MMForceEnergy(&self._myu, &self._mdsystem, &self._traj_control)
        
    def energy_forces(self):
        cdef Energy ene
        cdef cell* cell_ptr
        cdef int i, j, k
        cdef double[:] gradients = np.zeros(self.n_atoms*3)

        print('gradients', np.asarray(gradients))

        print('ncell', self._mdsystem.CG.ncell)
        for i in range(self._mdsystem.CG.ncell):
            cell_ptr = &(self._mdsystem.CG.data[i])
            k = cell_ptr.data[j].id
            print('k', k)
            print('data[j]', cell_ptr.data[j])

            for j in range(cell_ptr.nr[0]):
                gradients[k*3  ] = cell_ptr.data[j].frc[0]
                gradients[k*3+1] = cell_ptr.data[j].frc[1]
                gradients[k*3+2] = cell_ptr.data[j].frc[2]

        ene = self._mdsystem.sysUV
        return ene, np.asarray(gradients).reshape(self.n_atoms, 3)

    @property
    def mdin(self):
        return self._traj_control

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
    data['coords'] = get_positions(mys).copy()

    set_positions(np.zeros(mys.crd.natom*3), mys)
    data['coords2'] = get_positions(mys).copy()

    return data

if __name__ == '__main__':
    test_load('vAla3.prmtop', 'vAla3.rst7')
