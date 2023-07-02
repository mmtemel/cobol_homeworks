       IDENTIFICATION DIVISION.
       PROGRAM-ID.    COBHW02.
       AUTHOR.        MERT MUSA TEMEL.
      *This COBOL program processes account records.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *    Define file names and statuses for file handling.
           SELECT PRINT-LINE ASSIGN  PRTLINE
                             STATUS  PRT-ST.
           SELECT ACCT-REC   ASSIGN  ACCTREC
                             STATUS  ACCT-ST.
       DATA DIVISION.
       FILE SECTION.
      *    Define the structure of the PRINT-LINE file.
       FD  PRINT-LINE RECORDING MODE F.
       01  PRINT-REC.
           05  PRINT-SEQ            PIC X(04).
           05  PRINT-AD             PIC X(15).
           05  PRINT-SOYAD          PIC X(15).
           05  PRINT-DTAR           PIC 9(08).
           05  PRINT-TODAY          PIC 9(08).
           05  PRINT-FARK           PIC 9(05).
      *    Define the structure of the ACCT-REC file.
       FD  ACCT-REC RECORDING MODE F.
       01  ACCT-FIELDS.
           05  ACCT-SEQ            PIC X(04).
           05  ACCT-AD             PIC X(15).
           05  ACCT-SOYAD          PIC X(15).
           05  ACCT-DTAR           PIC 9(08).
           05  ACCT-TODAY          PIC 9(08).
      *
       WORKING-STORAGE SECTION.
       01  WS-WORK-AREA.
           05 PRT-ST            PIC 9(02).
      *       Flag indicating successful operation on PRINT-LINE file.
              88 PRT-SUCCESS               VALUE 00 97.
           05 ACCT-ST           PIC 9(02).
      *       Flag indicating end-of-file on ACCT-REC file.
              88 ACCT-EOF                  VALUE 10.
      *       Flag indicating successful operation on ACCT-REC file.
              88 ACCT-SUCCESS              VALUE 00 97.
      *    Intermediate variable for date calculation.
           05 WS-INT-D          PIC 9(07).
      *    Intermediate variable for date calculation.
           05 WS-INT-T          PIC 9(07).
       PROCEDURE DIVISION.
       0000-MAIN.
           PERFORM H100-OPEN-FILES.
           PERFORM H200-PROCESS UNTIL ACCT-EOF.
           PERFORM H999-PROGRAM-EXIT.
       H100-OPEN-FILES.
      *    Open the ACCT-REC file for input.
           OPEN INPUT  ACCT-REC.
      *    Check if the file opening was successful.
           IF (ACCT-ST NOT = 0) AND (ACCT-ST NOT = 97)
              DISPLAY 'UNABLE TO OPEN FILE: ' ACCT-ST
              MOVE ACCT-ST TO RETURN-CODE
              PERFORM H999-PROGRAM-EXIT
           END-IF.
      *    Open the PRINT-LINE file for output.
           OPEN OUTPUT PRINT-LINE.
      *    Check if the file opening was successful.
           IF (PRT-ST NOT = 0) AND (ACCT-ST NOT = 97)
              DISPLAY 'UNABLE TO OPEN FILE: ' PRT-ST
              MOVE PRT-ST TO RETURN-CODE
              PERFORM H999-PROGRAM-EXIT
           END-IF.
      *    Read the first record from the ACCT-REC file.
           READ ACCT-REC.
      *    Check if the read operation was successful.
           IF (ACCT-ST NOT = 0) AND (ACCT-ST NOT = 97)
              DISPLAY 'UNABLE TO READ FILE: ' ACCT-ST
              MOVE ACCT-ST TO RETURN-CODE
              PERFORM H999-PROGRAM-EXIT
           END-IF.
       H100-END. EXIT.
      *
       H200-PROCESS.
           COMPUTE WS-INT-D = FUNCTION INTEGER-OF-DATE(ACCT-DTAR)
      *    WS-INT-D is computed as the integer 
      *    representation of the ACCT-DTAR date.
           COMPUTE WS-INT-T = FUNCTION INTEGER-OF-DATE(ACCT-TODAY)
      *    WS-INT-T is computed as the integer 
      *    representation of the ACCT-TODAY date.
           INITIALIZE PRINT-REC
      *    The PRINT-REC record is initialized.
           MOVE ACCT-SEQ       TO PRINT-SEQ
           MOVE ACCT-AD        TO PRINT-AD
           MOVE ACCT-SOYAD     TO PRINT-SOYAD
           MOVE ACCT-DTAR      TO PRINT-DTAR
           MOVE ACCT-TODAY     TO PRINT-TODAY
      *    Data from the ACCT-REC fields is moved to 
      *    the corresponding PRINT-REC fields.
           COMPUTE PRINT-FARK = WS-INT-T - WS-INT-D
      *    The date difference between ACCT-TODAY and ACCT-DTAR
      *    is computed and stored in PRINT-FARK.
           WRITE PRINT-REC.
      *    The PRINT-REC is written to the output file.
           READ ACCT-REC.
      *    The next ACCT-REC is read for further processing.
       H200-END. EXIT.
      *
       H300-CLOSE-FILES.
           CLOSE ACCT-REC
                 PRINT-LINE.
       H300-END. EXIT.
      *
       H999-PROGRAM-EXIT.
           PERFORM H300-CLOSE-FILES.
           STOP RUN.
       H999-END. EXIT.
