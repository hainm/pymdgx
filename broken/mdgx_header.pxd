cdef extern from "mdgx.h":

    ctypedef BSplineCoeff bcof

    cdef struct IMatrix:
        int row
        int col
        int* data
        int** mgdx_map

    ctypedef IMatrix imat

    cdef struct DMatrix:
        int row
        int col
        int pfft
        double* data
        double** mgdx_map

    ctypedef DMatrix dmat

    cdef struct CMatrix:
        int row
        int col
        char* data
        char** mgdx_map "map"

    ctypedef CMatrix cmat

    cdef struct FloatBook:
        int pag
        int row
        int col
        int isortho
        double orig[1]
        dmat U
        dmat invU
        dmat L
        dmat invL
        float* data
        float*** mgdx_map

    ctypedef FloatBook fbook

    cdef struct DoubleBook:
        int pag
        int row
        int col
        int pfft
        double* data
        double*** mgdx_map

    ctypedef DoubleBook dbook

    cdef struct ProcessCellGroup:
        int ncell
        int partner
        int BaseID
        int* cellpt

    ctypedef ProcessCellGroup pcgrp

    cdef struct AtomSharePlan:
        int nsend
        int nrecv
        int* slist
        int* rlist
        pcgrp* send
        pcgrp* recv
        pcgrp selfrecv

    ctypedef AtomSharePlan ashr

    cdef struct DirectCommPlan:
        ashr mvshr[1]
        ashr frcmg[1]

    ctypedef DirectCommPlan dcplan

    cdef struct GridSplice:
        int npag
        int ncol
        int npc
        int* pagl
        int* coll
        int* pcl

    ctypedef GridSplice gsplc

    cdef struct AtomInCell:
        int id
        int lj
        double q
        double loc[1]
        double frc[1]

    ctypedef AtomInCell atomc

    ctypedef AtomBuffer atomb

    ctypedef AtomBufferPlusVelocity atombv

    ctypedef AtomBufferPlusAllInfo atombx

    ctypedef RangeBuffer rngbuff

    cdef struct CellBlock:
        int nexp
        int nimp
        int maxatom
        int CGRank
        int pmordr[1]
        int gbin[1]
        int nFscr
        int* nr
        int* nsr
        int* ljIDbuff
        int* qIDbuff
        int* GPSptr
        rngbuff* ljr2buff
        rngbuff* qr2buff
        imat ordr
        imat supordr
        double orig[1]
        double midp[1]
        bcof* xcof
        bcof* ycof
        bcof* zcof
        atomc* atmscr
        atomc* data
        atomc** mgdx_map
        fbook* Fscr
        atomb* pexport
        atombv* Vimport
        atombv* Vexport
        atombx* Ximport
        atombx* Xexport

    ctypedef CellBlock cell

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
        atomb** pexport
        atombv** Vimport
        atombv** Vexport
        atombx** Ximport
        atombx** Xexport
        atombx** CrdPool
        dcplan DirCommPlan
        int maxatom
        int ncell
        int ng[1]
        double dbng[1]
        double celldim[1]
        cell* data
        cell*** mgdx_map
        gsplc* MeshCommPlan
        imat AtmGPS

    ctypedef CellBlockGrid cellgrid

    cdef struct bndangdihe:
        int nbond
        int nangl
        int ndihe

    ctypedef bndangdihe bah

    ctypedef bondidx bond

    ctypedef bondcommand bondcomm

    ctypedef atombondlist bondlist

    ctypedef BondDef bonddef

    ctypedef anglidx angle

    ctypedef anglecommand anglcomm

    ctypedef atomanglelist angllist

    ctypedef AngleDef angldef

    ctypedef diheidx dihedral

    ctypedef dihedralcommand dihecomm

    ctypedef dihedrallist dihelist

    ctypedef DihedralDef dihedef

    ctypedef ConstraintCommand cnstcomm

    cdef struct SettleParameters:
        double ra
        double rb
        double rc
        double mO
        double mH

    ctypedef SettleParameters settleparm

    ctypedef ExtraPoint expt

    ctypedef ExtraPointRule eprule

    ctypedef ConnectorMatrix map1234

    ctypedef ListOfGroup lgrp

    ctypedef NB14Pair nixpr

    ctypedef AuxiliaryElimination auxelim

    cdef struct ambprmtop:
        int natom
        int nres
        int ntypes
        int nhparm
        int nparm
        int tnexcl
        int natyp
        int nphb
        int ifpert
        int ifbox
        int nmxrs
        int ifcap
        int iptres
        int iptatom
        int nspm
        int nspsol
        int natcap
        int blank
        int rattle
        int settle
        int nwat
        int ncnst
        int ndf
        int nprtcl
        int ljbuck
        int qshape
        int neprule
        int nxtrapt
        int maxtrapt
        int numextra
        int ncopy
        int ngrp
        int EPInserted
        int norigatom
        int nclingrule
        int RattleGrpMax
        int AtomsNoElec
        int AtomsNoLJ
        int ExclMarked
        double cutcap
        double xcap
        double ycap
        double zcap
        double lj14fac
        double elec14fac
        double TotalMass
        double initq
        bah withH
        bah woH
        bah woHC
        bah nBAH
        bah pert
        bah wpert
        int* LJIdx
        int* NExcl
        int* ConExcl
        int* ExclList
        int* NBParmIdx
        int* ResLims
        int* Join
        int* Rotat
        int* Nsp
        int* OldAtomNum
        int* MobileAtoms
        double* Charges
        double* Masses
        double* InvMasses
        double* BondK
        double* BondEq
        double* AnglK
        double* AnglEq
        double* DiheK
        double* DiheN
        double* DihePhi
        double* scee
        double* scnb
        double* LJA
        double* LJB
        double* LJC
        double* lVDWc
        double* SolA
        double* SolB
        double* HBCut
        double* Radii
        double* Screen
        char RadSet[1]
        char vstamp[1]
        char WaterName[1]
        char* AtomNames
        char* ResNames
        char* AtomTypes
        char* TreeSymbols
        char* rattlemask
        char* norattlemask
        double gdim[1]
        bond* BIncH
        bond* BNoH
        angle* AIncH
        angle* ANoH
        dihedral* HIncH
        dihedral* HNoH
        bondlist* BLC
        angllist* ALC
        dihelist* HLC
        bonddef* BParam
        angldef* AParam
        dihedef* HParam
        cnstcomm* SHL
        eprule* eprules
        expt* xtrapts
        lgrp* lgrps
        map1234* nb1234
        auxelim* ElimPair
        lgrp* FR1Idx
        dmat LJftab
        dmat LJutab
        settleparm FWtab
        char source[1]
        char eprulesource[1]

    ctypedef ambprmtop prmtop

    ctypedef UniqueBondList ublist

    cdef struct PrmtopCorrespondence:
        int relate
        int vdw
        int vdw14
        int elec
        int elec14
        int bond
        int angl
        int dihe
        int appear
        int disappear
        int nxdf
        int nxprtcl
        int uniA
        int uniB
        int comAB
        int* matchA
        int* matchB
        int* corrA
        int* corrB
        double* dQ
        ublist* SubBondA
        ublist* AddBondB
        ublist* SubAnglA
        ublist* AddAnglB
        ublist* SubDiheA
        ublist* AddDiheB
        prmtop* tpA
        prmtop* tpB

    ctypedef PrmtopCorrespondence prmcorr

    ctypedef RestraintData nail

    ctypedef CubicSpline CSpln

    cdef struct ForceTable:
        int nbin
        double rmax
        double dr
        double ivdr
        CSpln* SD
        CSpln* dSD
        int FitType
        double fmaxerr
        double fmaxerrloc
        double fmaxrelerr
        double fmaxrelerrloc
        double umaxerr
        double umaxerrloc
        double umaxrelerr
        double umaxrelerrloc

    ctypedef ForceTable FrcTab

    cdef struct Coordinates:
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
        dmat U
        dmat invU
        dmat fcnorm

    ctypedef Coordinates coord

    ctypedef GridToGridMap g2gmap

    ctypedef EquivAtomGroup eagrp

    ctypedef ExtendedAtomDef xatomdef

    ctypedef ExtendedBondDef xbonddef

    ctypedef ExtendedHBondDef xhb1012def

    ctypedef ExtendedAngleDef xangldef

    ctypedef TorsionTerm torterm

    ctypedef BondIndex bidx

    ctypedef AnglIndex aidx

    ctypedef TorsionIndex hidx

    cdef struct BondMap:
        int nbond
        bidx* id
        double* val
        double* Ukernel
        double* Ucontrib
        double* Fkernel
        double* Fcontrib

    ctypedef BondMap bondmap

    cdef struct AngleMap:
        int nangl
        aidx* id
        double* val
        double* Ukernel
        double* Ucontrib
        double* Fkernel
        double* Fcontrib

    ctypedef AngleMap anglmap

    cdef struct TorsionMap:
        int ntterm
        hidx* id
        double* val
        double* Ukernel
        double* Ucontrib
        double* Fkernel
        double* Fcontrib

    ctypedef TorsionMap tormap

    ctypedef AtomTypeSwitch typeswitch

    ctypedef AtomTypeBranch typebranch

    ctypedef MMSystem mmsys

    cdef struct pmeDirectControlData:
        int LRvdw
        double Ecut
        double Vcut
        double Mcut
        double MaxDens
        double invMcut
        double invEcut
        double ewcoeff
        double sigma
        double Dtol
        double lkpspc

    ctypedef pmeDirectControlData dircon

    cdef struct pmeRecipControlData:
        int ordr[1]
        int* ng
        double S
        int nlev
        int nslab
        int nstrip
        int ggordr
        int PadYZ[1]
        double cfac[1]
        g2gmap* SPrv
        g2gmap* SPcv
        dbook* Urec
        dbook* QL

    ctypedef pmeRecipControlData reccon

    cdef struct BCMeshKit:
        int plans
        double SelfEcorr
        double* Bx
        double* By
        double* Bz
        double* mx
        double* my
        double* mz
        double* mxs
        double* mys
        double* mzs
        double* Ex
        double* Ey
        double* Ez

    ctypedef BCMeshKit bckit

    ctypedef ElectronDensityGaussian edgauss

    cdef struct RestraintControls:
        int active
        int usegrid
        int usebelly
        int XpandGrid
        double GridScale
        char* GridFile
        char* GridDefsFile
        char* BellyMask
        char* FrozenMask
        fbook Rgrd

    ctypedef RestraintControls rstrcon

    cdef struct ExecutionControl:
        timeval t0
        timeval tC
        timeval tti
        timeval ttf
        double bonds
        double cellcomm
        double nbInt
        double nbDirAll
        double nbBsp
        double nbPtM
        double nbFFT
        double nbCnv
        double nbMtP
        double nbMtM
        double nbRecAll
        double Setup
        double Integ
        double Write
        double Constraints
        double Barostat
        double Thermostat

    ctypedef ExecutionControl execon

    cdef struct CoupledHoover:
        double pmass
        double qmass
        double chi
        double eta
        double sigma
        double TauT
        double TauP

    ctypedef CoupledHoover choov

    cdef struct LangevinThermostat:
        double gamma_ln
        double c_implic
        double c_explic
        double sdfac

    ctypedef LangevinThermostat lnbath

    cdef struct TrajectoryControlData:
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
        choov npth
        lnbath lnth
        rstrcon Leash
        prmcorr prc
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
        cmat ipcname
        char dumpname[1]
        char rsrptname[1]
        char parmfile[1]
        char fmodfile[1]
        cmat rstbase
        cmat trjbase
        cmat velbase
        cmat frcbase
        char outbase[1]
        cmat rstsuff
        cmat trjsuff
        cmat velsuff
        cmat frcsuff
        char outsuff[1]
        cmat inptext
        char* inpline
        int tid
        int nthreads
        int nCPUcluster
        lgrp* CPUcluster
        imat SystemCPUs
        int* MySystemDomain

    ctypedef TrajectoryControlData trajcon

    cdef struct EnergyTracker:
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
        double Vir[1]
        double* BondUdc
        int updateU
        int updateV
        int nUdc
        int Esummed

    ctypedef EnergyTracker Energy

    cdef struct PotentialFunction:
        prmtop tp
        dircon dcinp
        FrcTab Etab
        FrcTab EHtab
        reccon rcinp
        bckit PPk

    ctypedef PotentialFunction uform

    cdef struct MolecularDynamicsSystem:
        coord crd
        cellgrid CG
        Energy sysUV
        execon etimers

    ctypedef MolecularDynamicsSystem mdsys

    void FreeTopology(prmtop* tp)

    coord ReadRst(prmtop* tp, char* source)

    void DestroyCoord(coord* crd)

    void FreeFrcTab(FrcTab* F)

    cellgrid CreateCellGrid(coord* crd, dircon* dcinp, reccon* rcinp, prmtop* tp, trajcon* tj, int sysnum)

    void PrepPME(cellgrid* CG, reccon* rcinp, coord* crd)

    bckit CreateBCKit(reccon* rcinp, dbook* Q, coord* crd, prmtop* tp, int DoPlan)

    void InitHistory(coord* crd)

    void InitBasicTrajcon(trajcon* tj)

    void InitExecon(execon* tm)

    uform InitPotential(char* topsrc, double NBcut, trajcon* tj)

    void MMForceEnergy(uform* U, mdsys* MD, trajcon* tj)

    void AtomsToCells(coord* crd, cellgrid* CG, prmtop* tp)

    void ImageBondedGroups(coord* crd, prmtop* tp)

    void DestroyTrajCon(trajcon* tj)

    void DestroyCellGrid(cellgrid* CG)

    void DestroyAdvancedRecCon(reccon* rcinp, cellgrid* CG)

    void DestroyBCKit(bckit* PPk)

    void DestroyEnergyTracker(Energy* sysUV)
