//COBHW03J JOB 1,NOTIFY=&SYSUID
//***************************************************/
//* Copyright Contributors to the COBOL Programming Course
//* SPDX-License-Identifier: CC-BY-4.0
//***************************************************/
//COBRUN  EXEC IGYWCL
//COBOL.SYSIN  DD DSN=Z95644.CBL(COBHW03),DISP=SHR
//LKED.SYSLMOD DD DSN=Z95644.LOAD(COBHW03),DISP=SHR
//***************************************************/
// IF RC < 5 THEN
//***************************************************/
//RUN       EXEC PGM=COBHW03
//STEPLIB   DD DSN=Z95644.LOAD,DISP=SHR
//ACCTREC   DD DSN=Z95644.VSAM.AA,DISP=SHR
//IDXREC    DD DSN=Z95644.QSAM.INP,DISP=SHR
//PRTLINE   DD DSN=&SYSUID..QSAM.OUT,
//             DISP=(NEW,CATLG,DELETE),
//             UNIT=SYSDA,
//             SPACE=(TRK,(5,5),RLSE),
//             DCB=(RECFM=FB,LRECL=38,BLKSIZE=0)
//SYSOUT    DD SYSOUT=*,OUTLIM=15000
//CEEDUMP   DD DUMMY
//SYSUDUMP  DD DUMMY
//***************************************************/
// ELSE
// ENDIF
