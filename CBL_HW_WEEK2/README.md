# AKBANK COBOL BOOTCAMP HOMEWORK WEEK 2

# COBHW02 Account Processing Program

This COBOL program processes account records by performing various operations on input and output files. It calculates the date difference between account dates and generates an output file with the processed data.

## File Structure

The program operates on two files: `ACCT-REC` and `PRINT-LINE`. Here is the structure of each file:

### ACCT-REC File
- `ACCT-SEQ`: Alphanumeric, 4 characters
- `ACCT-AD`: Alphanumeric, 15 characters
- `ACCT-SOYAD`: Alphanumeric, 15 characters
- `ACCT-DTAR`: Numeric, 8 digits
- `ACCT-TODAY`: Numeric, 8 digits

### PRINT-LINE File
- `PRINT-SEQ`: Alphanumeric, 4 characters
- `PRINT-AD`: Alphanumeric, 15 characters
- `PRINT-SOYAD`: Alphanumeric, 15 characters
- `PRINT-DTAR`: Numeric, 8 digits
- `PRINT-TODAY`: Numeric, 8 digits
- `PRINT-FARK`: Numeric, 5 digits

## Program Flow

The program follows the following main steps:

1. Open the `ACCT-REC` file for input and check if the file opening was successful.
2. Open the `PRINT-LINE` file for output and check if the file opening was successful.
3. Read the first record from the `ACCT-REC` file and check if the read operation was successful.
4. Enter the `H200-PROCESS` section and perform the following operations:
   - Compute the integer representation of the `ACCT-DTAR` date and store it in `WS-INT-D`.
   - Compute the integer representation of the `ACCT-TODAY` date and store it in `WS-INT-T`.
   - Initialize the `PRINT-REC` record.
   - Move data from the `ACCT-REC` fields to the corresponding `PRINT-REC` fields.
   - Compute the date difference between `ACCT-TODAY` and `ACCT-DTAR` and store it in `PRINT-FARK`.
   - Write the `PRINT-REC` to the `PRINT-LINE` file.
   - Read the next record from the `ACCT-REC` file.
5. Repeat step 4 until the end-of-file (`ACCT-EOF`) is reached.
6. Perform the `H999-PROGRAM-EXIT` section, which includes closing the files and stopping the program.

## Usage

Before executing the program, ensure that the input file (`ACCTREC`) and output file (`PRTLINE`) are properly set up and accessible for reading and writing, respectively. Run the program, and it will process the account records, calculate the date difference, and generate the output in the `PRINT-LINE` file.

Note: Make sure you have the necessary COBOL compiler and environment properly set up to execute COBOL programs.

# COBHW02 JCL Job

This JCL (Job Control Language) code represents a job that executes the COBHW02 COBOL program. It defines the necessary steps and input/output files required for the execution.

## Job Steps

The job consists of the following steps:

1. `COBRUN`: This step executes the IGYWCL utility program, which is responsible for compiling the COBOL source code.

   - `COBOL.SYSIN`: Specifies the dataset containing the COBOL source code (`&SYSUID..CBL(COBHW02)`). It is read with shared access.

   - `LKED.SYSLMOD`: Specifies the dataset where the load module (`COBHW02`) will be stored after compilation. It is read with shared access.

2. `RUN`: This step executes the compiled COBOL program (`COBHW02`).

   - `STEPLIB`: Specifies the dataset where the load module (`COBHW02`) is located. It is read with shared access.

   - `ACCTREC`: Specifies the input dataset containing account records. It is read with shared access.

   - `PRTLINE`: Specifies the output dataset where the processed data will be written. It is created as a new dataset with a catalog entry and will be deleted after execution. The dataset is allocated with 10 tracks and 5 secondary extents.

   - `SYSOUT`: Specifies the system output dataset where the program output will be directed. It is set to print to the system printer with a line limit of 15,000 characters.

   - `CEEDUMP` and `SYSUDUMP`: These DD statements are configured as DUMMY, indicating that no dump output will be generated.

## Condition Checking

The JCL includes a conditional statement to check the return code of the previous step:

- `IF RC < 5 THEN`: If the return code of the previous step is less than 5, the following steps will be executed.

- `ELSE`: If the return code is 5 or greater, the job will end without executing further steps.

## Usage

To execute this JCL job, ensure that the necessary datasets (`&SYSUID..CBL(COBHW02)`, `&SYSUID..LOAD(COBHW02)`, `&SYSUID..QSAM.BB`) are correctly set up and accessible. Submit the JCL job to the JES (Job Entry Subsystem) for execution.

Note: Make sure you have the necessary mainframe environment and access privileges to execute JCL jobs.

