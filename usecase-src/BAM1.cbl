      ******************************************************************
      * Author: Roger Infanger Weibel
      * Date: 20.05.2025
      * Purpose: Wazi Deploy Demo Code
      * Application: Base
      ******************************************************************
       IDENTIFICATION DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       PROGRAM-ID. BAM1.
       ENVIRONMENT DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       CONFIGURATION SECTION.
      *-----------------------
       INPUT-OUTPUT SECTION.
      *-----------------------
       DATA DIVISION.
       COPY BAM1.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       FILE SECTION.
      *-----------------------
       WORKING-STORAGE SECTION.
       COPY BAD1REC.

      ** INCLUDING SQLCA COPYBOOK **************
       *EXEC SQL
       *    INCLUDE SQLCA
       *END-EXEC.
       COPY SQLCA.

      ** INCLUDING DCLGEN OF EMP TABLE*********
       *EXEC SQL
       *    INCLUDE BAD1SQL
       *END-EXEC.
       COPY BAD1SQL.

      *-----------------------
       PROCEDURE DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       MAIN-PROCEDURE.
      **
      * The main procedure of the program
      **
            DISPLAY "Hello world"
            STOP RUN.
      ** add other procedures here
       END PROGRAM BAM1.




           PERFORM INITIALIZE-COMM-AREA
           PERFORM PROCESS-TRANSACTION
           PERFORM RETURN-TO-CALLER
           STOP RUN.

       INITIALIZE-COMM-AREA.
           MOVE SPACES TO BAM1-COMM-AREA.
           MOVE 0 TO RETURN-CODE.
           MOVE SPACES TO ERROR-MESSAGE.

       PROCESS-TRANSACTION.

           EXEC SQL
               SELECT TRANSACTION_DATE, TRANSACTION_USER
               INTO :TRANSACTION-DATE, :TRANSACTION-USER
               FROM BAD1
               WHERE TRANSACTION_ID = :BAD1-REC.TRANSACTION-ID
           END-EXEC
           IF SQLCODE = 0
               MOVE 'S' TO TRANSACTION-STATUS
           ELSE
               MOVE 'E' TO TRANSACTION-STATUS
               MOVE SQLERRMC TO ERROR-MESSAGE
               MOVE SQLCODE TO RETURN-CODE.

       RETURN-TO-CALLER.
           DISPLAY "Module BAM1 ended with status: " TRANSACTION-STATUS.
           IF TRANSACTION-STATUS = 'E'
               DISPLAY "Error: " ERROR-MESSAGE.
