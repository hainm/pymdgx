cdef extern from "mdgx.h":
    ctypedef struct AmberPrmtop "prmtop":
        pass
    ctypedef struct Coordinates "coord":
        pass
                        
    ctypedef struct PotentialFunction "uform":
        pass

    ctypedef struct MDSystem "mdsys":
        pass

    ctypedef struct TrajectoryControlData "trajcon":
        pass

    Coordinates ReadRst(AmberPrmtop *tp, char* source);


cdef extern from "getmdgxfrc.c":
    # use get_mdgx_force.c to include c source code
    # so we don't need to build .so file 
    int get_mdgx_force "getmdgxfrc" (const double *phenix_coords,
                       double* target,
                       double * gradients,
                       PotentialFunction* U, 
                       TrajectoryControlData* tjptr,
                       MDSystem* MDptr)
    
    TrajectoryControlData create_trajcon_ "CreateTrajCon"()
    PotentialFunction load_topology_ "LoadTopology"(const char *tpname, TrajectoryControlData* tj)
    MDSystem create_mdsystem_ "CreateMDSys" (const char *crdname, PotentialFunction* U)
    void destroy_MDSystem "DestroyMDSys"(MDSystem* mdsysptr)
    void destroy_Uform "DestroyUform"(PotentialFunction* uptr, MDSystem* mdsysptr)


def test_load(tname, cname):
    import parmed as pmd
    import numpy as np
    import sander

    parm = pmd.load_file(tname, cname)
    natom = len(parm.atoms) 

    cdef TrajectoryControlData tcon
    cdef PotentialFunction myu
    cdef MDSystem mys
    cdef Coordinates coord_
    cdef AmberPrmtop top

    cdef double[:] phenix_coords = parm.coordinates.flatten()
    cdef double[:] target = np.zeros(10)
    cdef double[:] gradients = np.zeros(natom*3)

    tcon = create_trajcon_()
    myu = load_topology_(tname, &tcon)
    mys = create_mdsystem_(cname, &myu)

    get_mdgx_force(&phenix_coords[0], &target[0], &gradients[0], &myu, &tcon, &mys)
    print('target', np.array(target))
    print('gradients', np.array(gradients))

    with sander.setup(tname, cname, parm.box, sander.pme_input()) as context:
        ene, frc = context.energy_forces()
        print('sander gradients', frc)

if __name__ == '__main__':
    test_load('vAla3.prmtop', 'vAla3.rst7')
