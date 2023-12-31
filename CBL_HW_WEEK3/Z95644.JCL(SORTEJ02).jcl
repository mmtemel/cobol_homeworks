//QSAMBB JOB ' ',CLASS=A,MSGLEVEL=(1,1),MSGCLASS=X,NOTIFY=&SYSUID
//DELET100 EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  DELETE Z95644.QSAM.FF NONVSAM
  IF LASTCC LE 08 THEN SET MAXCC = 00
//SORT0200 EXEC PGM=SORT
//SYSOUT   DD SYSOUT=*
//SORTIN   DD *
00012949BURAK          KOZLUCA
00022840GAZI           SEPETCI
00032978AHMET          AKAYDIN
00041949FURKAN         TUNCER
00051840TUNAHAN        TURNA
00061978FURKAN         SOLAKOGLU
00002949MUSTAFA        YILMAZ
00002840MUSTAFA        YILMAZ
00002978MERT MUSA      TEMEL
00001949MEHMET         AYDIN
00001840MEHMET         AYDIN
//SORTOUT  DD DSN=Z95644.QSAM.FF,
//            DISP=(NEW,CATLG,DELETE),
//            SPACE=(TRK,(5,5),RLSE),
//            DCB=(RECFM=FB,LRECL=47)
//SYSIN    DD *
  SORT FIELDS=(1,8,CH,A)
  OUTREC FIELDS=(1,50)
//*
//DELET300 EXEC PGM=IEFBR14
//FILE01    DD DSN=&SYSUID..QSAM.BB,
//             DISP=(MOD,DELETE,DELETE),SPACE=(TRK,0)
//SORT0400 EXEC PGM=SORT
//SYSOUT   DD SYSOUT=*
//SORTIN   DD DSN=Z95644.QSAM.FF,DISP=SHR
//SORTOUT  DD DSN=Z95644.QSAM.BB,
//            DISP=(NEW,CATLG,DELETE),
//            SPACE=(TRK,(5,5),RLSE),
//            DCB=(RECFM=FB,LRECL=47)
//SYSIN DD *
  SORT FIELDS=COPY
    OUTREC FIELDS=(1,5,ZD,TO=PD,LENGTH=3,
                   6,3,ZD,TO=BI,LENGTH=2,
                   9,30)
