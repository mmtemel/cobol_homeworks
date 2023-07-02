# AKBANK COBOL BOOTCAMP HOMEWORK WEEK 3

# COBHW03

This repository contains a COBOL program named COBHW03 that performs operations on files.

## Author
Mert Musa TEMEL

## Files
The program operates on the following files:

### ACCT-REC
* File Name: ACCTREC
* Organization: Indexed
* Access: Random
* Record: ACCT-KEY
* Status: ACCT-ST

### IDX-REC
* File Name: IDXREC
* Status: IDX-ST

### PRINT-LINE
* File Name: PRTLINE
* Status: PRT-ST

## Data Structure

The program uses the following data structure:

### ACCT-REC
* File Description: VSAM File
* Record Length: 50 characters

```
01 ACCT-FIELDS.
   03 ACCT-KEY.
      05 ACCT-ID     PIC S9(05) COMP-3.
      05 ACCT-CUR    PIC S9(03) COMP.
   03 ACCT-NAME      PIC X(15).
   03 ACCT-SURNAME   PIC X(15).
   03 FILLER         PIC X(12) VALUE SPACES.
```

### IDX-REC

* Recording Mode: F

```
01 IDX-FIELDS.
   05 IDX-ID         PIC X(05).
   05 IDX-CUR        PIC X(03).
```

### PRINT-LINE

* Recording Mode: F

```
01 PRINT-REC.
   05 PRT-ID         PIC X(05).
   05 PRT-CUR        PIC X(03).
   05 PRT-NAME       PIC X(15).
   05 PRT-SURNAME    PIC X(15).
```

### Procedure

The program follows the following procedure:

* Open the necessary files and check the status.
* Enter the main loop and perform the processing until the end of the IDX-REC file is reached.
* Exit the program.

## Program Logic
The program consists of the following logic:

### 0000-MAIN

* Perform the necessary setup and enter the main loop.
* Exit the program when the loop is completed.

### H100-OPEN-FILES

* Open the ACCT-REC, IDX-REC, and PRINT-LINE files.
* Check the status of each file and exit the program if any of them fail to open.
* Read the first record from IDX-REC.

### H200-PROCESS

* Initialize the PRINT-REC.
* If there is no invalid key, move data from ACCT-REC to PRINT-REC and write it.
* If there is an invalid key, display an error message and reset the INVALID-KEY flag.
* Read the next record from IDX-REC.


### H300-CLOSE-FILES

* Close the ACCT-REC, PRINT-LINE, and IDX-REC files.

### H999-PROGRAM-EXIT

* Perform the necessary cleanup by closing the files.
* Stop the execution of the program.

## Conclusion
This COBOL program performs operations on files, reading data from ACCT-REC based on the keys stored in IDX-REC and writing the results to PRINT-LINE. Please refer to the code for more details and specific implementation.
