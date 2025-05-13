       IDENTIFICATION DIVISION.
       PROGRAM-ID.  PAM1.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       DATA DIVISION.

       *> Include the dclgen Db2 layouts
       COPY PAD1SQL.
       COPY BAD1SQL.
 
       WORKING-STORAGE SECTION.

       *> Include the Db2 host fields
       COPY PAD1REC.
       COPY BAD1REC.

       *> Include the communication area copybook
       COPY PAM1.

       EXEC SQL INCLUDE SQLCA END-EXEC.

       PROCEDURE DIVISION.
       MAIN-PROCESS.
           PERFORM INITIALIZE-COMM-AREA
           PERFORM PROCESS-PAYMENT
           PERFORM RETURN-TO-CALLER
           STOP RUN.

       INITIALIZE-COMM-AREA.
           MOVE SPACES TO PAM1-COMM-AREA.
           MOVE 0 TO RETURN-CODE.
           MOVE SPACES TO ERROR-MESSAGE.

       PROCESS-PAYMENT.
           EXEC SQL
               SELECT PAYMENT_DATE,  PAYMENT_USER
               INTO :PAYMENT-DATE, :PAYMENT-USER
               FROM PAD1
               WHERE PAYMENT_ID = :PAD1-REC.PAYMENT-ID
           END-EXEC
           IF SQLCODE = 0
               MOVE 'S' TO PAYMENT-STATUS
           ELSE
               MOVE 'E' TO PAYMENT-STATUS
               MOVE SQLERRMC TO ERROR-MESSAGE
               MOVE SQLCODE TO RETURN-CODE.

       RETURN-TO-CALLER.
           DISPLAY "Module PAM1 ended with status: "    PAYMENT-STATUS.
           IF PAYMENT-STATUS = 'E'
               DISPLAY "Error: " ERROR-MESSAGE.