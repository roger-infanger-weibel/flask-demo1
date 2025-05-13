       IDENTIFICATION DIVISION.
       PROGRAM-ID.  CAO1.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       *> Include the communication area copybook (CAM1)
       COPY CAM1.

       *> Include the communication area copybook (BAM1)
       COPY BAM1.

       77  WS-RESP                         PIC S9(8) COMP.  

       PROCEDURE DIVISION.
       MAIN-PROCESS.
           EXEC CICS RECEIVE
               INTO(CAM1-COMM-AREA)
               LENGTH(LENGTH OF CAM1-COMM-AREA)
               RESP(WS-RESP)
               END-EXEC

           PERFORM INITIALIZE-COMM-AREA
           PERFORM CALL-CAM1
           PERFORM HANDLE-RETURN-CODE

           EXEC CICS SEND
               FROM(CAM1-COMM-AREA)
               LENGTH(LENGTH OF CAM1-COMM-AREA)
               END-EXEC

           EXEC CICS RETURN END-EXEC.

       INITIALIZE-COMM-AREA.
           MOVE 'CAO1' TO MAIN-NAME.
           MOVE SPACES TO ERROR-MESSAGE.
           MOVE 'CICSUSR' TO USER-ID.     *> User ID of the caller     
           MOVE '1234567891' TO CUSTOMER-ID. *> Example trans ID
           MOVE 0 TO RETURN-CODE.
           MOVE SPACES TO CUSTOMER-STATUS.

       CALL-CAM1.
           DISPLAY "Calling module CAM1 from CICS..."
           CALL 'CAM1' USING CAM1-COMM-AREA
           ON EXCEPTION
               DISPLAY "Error: Unable to call CAM1."
               MOVE -1 TO RETURN-CODE
           END-CALL.

       HANDLE-RETURN-CODE.
           IF RETURN-CODE = 0
               DISPLAY "CAM1 completed successfully."
               MOVE 'S' TO CUSTOMER-STATUS
           ELSE
               DISPLAY "CAM1 encountered an error."
               DISPLAY "Error Message: " ERROR-MESSAGE
               DISPLAY "Return Code: " RETURN-CODE
               MOVE 'E' TO   CUSTOMER-STATUS.