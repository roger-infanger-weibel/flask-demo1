       IDENTIFICATION DIVISION.
       PROGRAM-ID.  PAB1.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       *> Include the communication area copybook (PAM1)
       COPY PAM1.

       PROCEDURE DIVISION.
       MAIN-PROCESS.
           PERFORM INITIALIZE-COMM-AREA
           PERFORM CALL-PAM1
           PERFORM HANDLE-RETURN-CODE
           STOP RUN.

       INITIALIZE-COMM-AREA.
           MOVE SPACES TO PAM1-COMM-AREA.
           MOVE 'PAB1' TO MAIN-NAME. *> Name of the calling module
           MOVE 'BATCHUSR' TO USER-ID.     *> User ID of the caller     
           MOVE '1234567890' TO    PAYMENT-ID. *> Example trans ID
           MOVE SPACES TO ERROR-MESSAGE.
           MOVE 0 TO RETURN-CODE.
           MOVE SPACES TO PAYMENT-STATUS.

       CALL-PAM1.
           DISPLAY "Calling module PAM1..."
           CALL 'PAM1' USING PAM1-COMM-AREA
           ON EXCEPTION
               DISPLAY "Error: Unable to call PAM1."
               MOVE -1 TO RETURN-CODE
           END-CALL.

       HANDLE-RETURN-CODE.
           IF RETURN-CODE = 0
               DISPLAY "PAM1 completed successfully."
               DISPLAY "PAYMENT Status: " PAYMENT-STATUS
           ELSE
               DISPLAY "PAM1 encountered an error."
               DISPLAY "Error Message: " ERROR-MESSAGE
               DISPLAY "Return Code: " RETURN-CODE.