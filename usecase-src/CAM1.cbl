       IDENTIFICATION DIVISION.
       PROGRAM-ID. CAM1.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       DATA DIVISION.

       *> Include the dclgen Db2 layouts
       COPY CAD1SQL.
       COPY BAD1SQL.
 
       WORKING-STORAGE SECTION.

       *> Include the Db2 host fields
       COPY CAD1REC.
       COPY BAD1REC.

       *> Include the communication area copybook
       COPY CAM1.

       EXEC SQL INCLUDE SQLCA END-EXEC.

       PROCEDURE DIVISION.
       MAIN-PROCESS.
           PERFORM INITIALIZE-COMM-AREA
           PERFORM PROCESS-CUSTOMER
           PERFORM RETURN-TO-CALLER
           STOP RUN.

       INITIALIZE-COMM-AREA.
           MOVE SPACES TO CAM1-COMM-AREA.
           MOVE 0 TO RETURN-CODE.
           MOVE SPACES TO ERROR-MESSAGE.

       PROCESS-CUSTOMER.
           EXEC SQL
               SELECT CUSTOMER_DATE,  CUSTOMER_USER
               INTO :CUSTOMER-DATE, :CUSTOMER-USER
               FROM CAD1
               WHERE CUSTOMER_ID = :CAD1-REC.CUSTOMER-ID
           END-EXEC
           IF SQLCODE = 0
               MOVE 'S' TO CUSTOMER-STATUS
           ELSE
               MOVE 'E' TO CUSTOMER-STATUS
               MOVE SQLERRMC TO ERROR-MESSAGE
               MOVE SQLCODE TO RETURN-CODE.

       RETURN-TO-CALLER.
           DISPLAY "Module CAM1 ended with status: " CUSTOMER-STATUS.
           IF CUSTOMER-STATUS = 'E'
               DISPLAY "Error: " ERROR-MESSAGE.