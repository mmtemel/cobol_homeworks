# AKBANK COBOL BOOTCAMP HOMEWORK WEEK 1

# COBHW01

This program is written in COBOL and is used to process account records. It reads records from the `ACCT-REC` file and writes formatted output records to the `PRINT-LINE` file.

## Author
MERT MUSA TEMEL

## Environment
The program expects two files to be present:
- `PRTLINE`: The output file for writing formatted records.
- `ACCTREC`: The input file containing account records.

## Data Division
The program defines the file structures and record layouts in this section.

### File Section
- `PRINT-LINE` file:
  - Record Format: Fixed-length (F)
  - Record Layout:
    - `ACCT-NO-O`: 8 characters (PIC X(8))
    - `ACCT-LIMIT-O`: Currency amount field with dollar sign and comma formatting
    - `ACCT-BALANCE-O`: Currency amount field with dollar sign and comma formatting
    - `LAST-NAME-O`: 20 characters (PIC X(20))
    - `FIRST-NAME-O`: 15 characters (PIC X(15))
    - `COMMENTS-O`: 50 characters (PIC X(50))

- `ACCT-REC` file:
  - Record Format: Fixed-length (F)
  - Record Layout:
    - `ACCT-NO`: 8 characters (PIC X(8))
    - `ACCT-LIMIT`: Packed decimal field with 7 digits and 2 decimal places (PIC S9(7)V99 COMP-3)
    - `ACCT-BALANCE`: Packed decimal field with 7 digits and 2 decimal places (PIC S9(7)V99 COMP-3)
    - `LAST-NAME`: 20 characters (PIC X(20))
    - `FIRST-NAME`: 15 characters (PIC X(15))
    - `CLIENT-ADDR`: Group item containing address details
      - `STREET-ADDR`: 25 characters (PIC X(25))
      - `CITY-COUNTY`: 20 characters (PIC X(20))
      - `USA-STATE`: 15 characters (PIC X(15))
    - `RESERVED`: 7 characters (PIC X(7))
    - `COMMENTS`: 50 characters (PIC X(50))

## Working-Storage Section
- `FLAGS`:
  - `LASTREC`: Single character flag initialized with a space character (PIC X VALUE SPACE)

## Procedure Division
This section contains the main logic of the program.

### OPEN-FILES
Opens the `ACCT-REC` file for input and the `PRINT-LINE` file for output.

### READ-NEXT-RECORD
Performs the following steps repeatedly until the end of the `ACCT-REC` file is reached:
1. Calls the `READ-RECORD` subroutine to read the next record.
2. Calls the `WRITE-RECORD` subroutine to format and write the record to the `PRINT-LINE` file.

### CLOSE-STOP
Closes the `ACCT-REC` and `PRINT-LINE` files and terminates the program.

### READ-RECORD
Reads the next record from the `ACCT-REC` file. If the end of file is reached, it sets the `LASTREC` flag to 'X'.

### WRITE-RECORD
Formats the fields from the current `ACCT-REC` record and moves them to the corresponding fields in the `PRINT-REC` record. Then it writes the `PRINT-REC` record to the `PRINT-LINE` file.


## Job Information
This job (COBHW01) is executed with the following parameters:
- Job ID: 1
- NOTIFY: &SYSUID

## License
This code is subject to the CC-BY-4.0 license. The contributors to the COBOL Programming Course hold the copyright.

## Compilation and Execution
To compile the COBOL program, execute the following steps:

1. Execute the IGYWCL utility.

//COBRUN EXEC IGYWCL

2. Specify the location of the source code in the COBOL.SYSIN DD statement.

//COBOL.SYSIN DD DSN=&SYSUID..CBL(COBHW01),DISP=SHR

3. Specify the location to store the load module in the LKED.SYSLMOD DD statement.

//LKED.SYSLMOD DD DSN=&SYSUID..LOAD(COBHW01),DISP=SHR

To execute the COBHW01 program, use the following job steps:

1. Check the return code (RC) from the compilation step. If RC = 0, proceed with the execution.

// IF RC = 0 THEN

2. Execute the COBHW01 program.

//RUN EXEC PGM=COBHW01

3. Provide the necessary input and output files:

- STEPLIB: Specify the location of the load module.

//STEPLIB DD DSN=&SYSUID..LOAD,DISP=SHR

- ACCTREC: Input file containing account records.

//ACCTREC DD DSN=&SYSUID..DATA,DISP=SHR

- PRTLINE: Output file for formatted records. If the file does not exist, it will be created. If it exists, its contents will be deleted.

//PRTLINE DD DSN=&SYSUID..HW01.OUTPUT,DISP=(NEW,CATLG,DELETE),
// SPACE=(CYL,(10,5))

4. Specify the destination for system output messages.

- SYSOUT: Output messages will be directed to the system output.

//SYSOUT DD SYSOUT=*,OUTLIM=15000

5. Specify DUMMY for dump datasets.

//CEEDUMP DD DUMMY
//SYSUDUMP DD DUMMY

6. Close the IF statement.

// ELSE
// ENDIF

**Note:** Make sure to update the dataset names (&SYSUID) with your appropriate values to ensure proper file access and allocation.
