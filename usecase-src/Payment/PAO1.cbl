       IDENTIFICATION DIVISION.
       PROGRAM-ID.  PAO1.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       *> Include the communication area copybook (PAM1)
       COPY PAM1.

       *> Include the communication area copybook (BAM1)
       COPY BAM1.

       77  WS-RESP                         PIC S9(8) COMP.  

       PROCEDURE DIVISION.
       MAIN-PROCESS.
           EXEC CICS RECEIVE
               INTO(PAM1-COMM-AREA)
               LENGTH(LENGTH OF PAM1-COMM-AREA)
               RESP(WS-RESP)
               END-EXEC

           PERFORM INITIALIZE-COMM-AREA
           PERFORM CALL-PAM1
           PERFORM HANDLE-RETURN-CODE

           EXEC CICS SEND
               FROM(PAM1-COMM-AREA)
               LENGTH(LENGTH OF PAM1-COMM-AREA)
               END-EXEC

           EXEC CICS RETURN END-EXEC.

       INITIALIZE-COMM-AREA.
           MOVE 'PAO1' TO PAM1-COMM-AREA.MAIN-NAME.
           MOVE SPACES TO PAM1-COMM-AREA.ERROR-MESSAGE.
           MOVE 'CICSUSR' TO PAM1-COMM-AREA.USER-ID.
           MOVE '1234567891' TO PAM1-COMM-AREA.PAYMENT-ID.
           MOVE 0 TO RETURN-CODE.
           MOVE SPACES TO PAM1-COMM-AREA.PAYMENT-STATUS.

       CALL-PAM1.
           DISPLAY "Calling module PAM1 from CICS..."
           CALL 'PAM1' USING PAM1-COMM-AREA
           ON EXCEPTION
               DISPLAY "Error: Unable to call PAM1."
               MOVE -1 TO RETURN-CODE
           END-CALL.

       HANDLE-RETURN-CODE.
           IF RETURN-CODE = 0
               DISPLAY "PAM1 completed successfully."
               MOVE 'S' TO PAYMENT-STATUS
           ELSE
               DISPLAY "PAM1 encountered an error."
               DISPLAY "Error Message: " ERROR-MESSAGE
               DISPLAY "Return Code: " RETURN-CODE
               MOVE 'E' TO PAYMENT-STATUS.