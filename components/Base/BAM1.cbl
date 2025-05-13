       IDENTIFICATION DIVISION.
       PROGRAM-ID. BAM1.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       DATA DIVISION.

       *> Include the dclgen Db2 layouts
       COPY BAD1SQL.
 
       WORKING-STORAGE SECTION.

       *> Include the Db2 host fields
       COPY BAD1REC.

       *> Include the communication area copybook
       COPY BAM1.

       EXEC SQL INCLUDE SQLCA END-EXEC.

       PROCEDURE DIVISION.
       MAIN-PROCESS.
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