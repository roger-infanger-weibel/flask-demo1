       IDENTIFICATION DIVISION.
       PROGRAM-ID. BAO1.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       *> Include the communication area copybook (BAM1)
       COPY BAM1.

       77  WS-RESP                         PIC S9(8) COMP.  

       PROCEDURE DIVISION.
       MAIN-PROCESS.
           EXEC CICS RECEIVE
               INTO(BAM1-COMM-AREA)
               LENGTH(LENGTH OF BAM1-COMM-AREA)
               RESP(WS-RESP)
               END-EXEC

           PERFORM INITIALIZE-COMM-AREA
           PERFORM CALL-BAM1
           PERFORM HANDLE-RETURN-CODE

           EXEC CICS SEND
               FROM(BAM1-COMM-AREA)
               LENGTH(LENGTH OF BAM1-COMM-AREA)
               END-EXEC

           EXEC CICS RETURN END-EXEC.

       INITIALIZE-COMM-AREA.
           MOVE 'BAO1' TO MAIN-NAME.
           MOVE SPACES TO ERROR-MESSAGE.
           MOVE 'CICSUSR' TO USER-ID.     *> User ID of the caller     
           MOVE '1234567891' TO TRANSACTION-ID. *> Example trans ID
           MOVE 0 TO RETURN-CODE.
           MOVE SPACES TO TRANSACTION-STATUS.

       CALL-BAM1.
           DISPLAY "Calling module BAM1 from CICS..."
           CALL 'BAM1' USING BAM1-COMM-AREA
           ON EXCEPTION
               DISPLAY "Error: Unable to call BAM1."
               MOVE -1 TO RETURN-CODE
           END-CALL.

       HANDLE-RETURN-CODE.
           IF RETURN-CODE = 0
               DISPLAY "BAM1 completed successfully."
               MOVE 'S' TO TRANSACTION-STATUS
           ELSE
               DISPLAY "BAM1 encountered an error."
               DISPLAY "Error Message: " ERROR-MESSAGE
               DISPLAY "Return Code: " RETURN-CODE
               MOVE 'E' TO TRANSACTION-STATUS.