# Note: You don't need to declare all struct attributes.
# (as long as the name the the struct is matched to mdgx.h)
# You can use alias, e.g. AmberPrmtop "prmtop"

cdef extern from "mdgx.h":
    ctypedef struct AmberPrmtop "prmtop":
        pass
    ctypedef struct Coordinates "coord":
        int natom
        int isortho
        int* atmid
        double* loc
        double* prvloc
        double* scrloc
        double* vel
        double* prvvel
        double* frc
        double* prvfrc
        double* scrfrc
        double gdim[1]
        double hgdim[1]
        # dmat U
        # dmat invU
        # dmat fcnorm
                        
    ctypedef struct PotentialFunction "uform":
        pass

    ctypedef struct TrajectoryControlData "trajcon":
        int mode
        int nsys
        int MySystemCount
        int ntop
        long long int nstep
        long long int nfistep
        long long int currstep
        int currfi
        int RemoveMomentum
        int irest
        int ntwr
        int ntwx
        int ntwv
        int ntwf
        int ntpr
        int ioutfm
        int OverwriteOutput
        int Reckless
        int igseed
        int SyncRNG
        int MaxRattleIter
        int topchk
        int ntt
        int ntp
        int barostat
        int vrand
        int MCBarostatFreq
        int TI
        int mxorder
        int nsynch
        long int rndcon
        double mxA
        double mxB
        double dmxA
        double dmxB
        double starttime
        double currtime
        double dt
        double rattletol
        double Ttarget
        double Tinit
        double BerendsenTCoupl
        double BerendsenPTime
        double BerendsenPCoupl
        double MCBarostatFac[1]
        double mcdVmax
        double Ptarget
        double mdgx_lambda "lambda"
        double EMinStep0
        double EMinStep
        double EMinTol
        # choov npth
        # lnbath lnth
        # rstrcon Leash
        # prmcorr prc
        int DMPcrd
        int DMPbond
        int DMPangl
        int DMPdihe
        int DMPdelec
        int DMPrelec
        int DMPvdw
        int DMPall
        char DMPvar[1]
        char inpname[1]
        # cmat ipcname
        char dumpname[1]
        char rsrptname[1]
        char parmfile[1]
        char fmodfile[1]
        # cmat rstbase
        # cmat trjbase
        # cmat velbase
        # cmat frcbase
        char outbase[1]
        # cmat rstsuff
        # cmat trjsuff
        # cmat velsuff
        # cmat frcsuff
        char outsuff[1]
        # cmat inptext
        char* inpline
        int tid
        int nthreads
        int nCPUcluster
        # lgrp* CPUcluster
        # imat SystemCPUs
        int* MySystemDomain

    Coordinates ReadRst(AmberPrmtop *tp, char* source);

    cdef struct CellBlockGrid:
        int nsend
        int nrecv
        int MyCellCount
        int sysID
        int tid
        int nthreads
        int MasterHalfLoad
        int* nexp
        int* maxexp
        int* maximp
        int* MyCellDomain
        int* CrdPoolSize
        # atomb** pexport
        # atombv** Vimport
        # atombv** Vexport
        # atombx** Ximport
        # atombx** Xexport
        # atombx** CrdPool
        # dcplan DirCommPlan
        int maxatom
        int ncell
        int ng[1]
        double dbng[1]
        double celldim[1]
        # cell* data
        # cell*** mgdx_map
        # gsplc* MeshCommPlan
        # imat AtmGPS

    ctypedef CellBlockGrid cellgrid

    ctypedef struct Energy "Energy":
        double delec
        double relec
        double vdw12
        double vdw6
        double bond
        double angl
        double dihe
        double kine
        double P
        double V
        double T
        double dVdL
        double elec
        double eptot
        double etot
        double AVEdelec
        double AVErelec
        double AVEvdw
        double AVEbond
        double AVEangl
        double AVEdihe
        double AVEkine
        double AVEelec
        double AVEeptot
        double AVEetot
        double AVEP
        double AVEV
        double AVET
        double AVEVir
        double AVEdVdL
        double RMSdelec
        double RMSrelec
        double RMSvdw
        double RMSbond
        double RMSangl
        double RMSdihe
        double RMSkine
        double RMSelec
        double RMSeptot
        double RMSetot
        double RMSP
        double RMSV
        double RMST
        double RMSVir
        double RMSdVdL
        int updateU
        int updateV
        int nUdc
        int Esummed

    ctypedef struct MolecularDynamicsSystem "mdsys":
        Coordinates crd
        cellgrid CG
        Energy sysUV
        # execon etimers


cdef extern from "getmdgxfrc.c":
    # use get_mdgx_force.c to include c source code
    # so we don't need to build .so file 
    int get_mdgx_force "getmdgxfrc" (const double *phenix_coords,
                       double* target,
                       double * gradients,
                       PotentialFunction* U, 
                       TrajectoryControlData* tjptr,
                       MolecularDynamicsSystem* MDptr)
    
    TrajectoryControlData create_trajcon_ "CreateTrajCon"()
    PotentialFunction load_topology_ "LoadTopology"(const char *tpname, TrajectoryControlData* tj)
    MolecularDynamicsSystem create_mdsystem_ "CreateMDSys" (const char *crdname, PotentialFunction* U)
    void destroy_MolecularDynamicsSystem "DestroyMDSys"(MolecularDynamicsSystem* mdsysptr)
    void destroy_Uform "DestroyUform"(PotentialFunction* uptr, MolecularDynamicsSystem* mdsysptr)
