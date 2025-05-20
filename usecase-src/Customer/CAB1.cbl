       IDENTIFICATION DIVISION.
       PROGRAM-ID.  CAB1.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       *> Include the communication area copybook (CAM1)
       COPY CAM1.

       PROCEDURE DIVISION.
       MAIN-PROCESS.
           PERFORM INITIALIZE-COMM-AREA
           PERFORM CALL-CAM1
           PERFORM HANDLE-RETURN-CODE
           STOP RUN.

       INITIALIZE-COMM-AREA.
           MOVE SPACES TO CAM1-COMM-AREA.
           MOVE 'CAB1' TO MAIN-NAME. *> Name of the calling module
           MOVE 'BATCHUSR' TO USER-ID.     *> User ID of the caller     
           MOVE '1234567890' TO TRANSACTION-ID. *> Example trans ID
           MOVE SPACES TO ERROR-MESSAGE.
           MOVE 0 TO RETURN-CODE.
           MOVE SPACES TO TRANSACTION-STATUS.

       CALL-CAM1.
           DISPLAY "Calling module    CAM1..."
           CALL 'CAM1' USING CAM1-COMM-AREA
           ON EXCEPTION
               DISPLAY "Error: Unable to call CAM1."
               MOVE -1 TO RETURN-CODE
           END-CALL.

       HANDLE-RETURN-CODE.
           IF RETURN-CODE = 0
               DISPLAY "CAM1 completed successfully."
               DISPLAY "Transaction Status: " TRANSACTION-STATUS
           ELSE
               DISPLAY "CAM1 encountered an error."
               DISPLAY "Error Message: " ERROR-MESSAGE
               DISPLAY "Return Code: " RETURN-CODE.