       IDENTIFICATION DIVISION.
       PROGRAM-ID.  PAO1.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       *>77 WS-RESP                          PIC S9(8) COMP.

       COPY BAM1.
       01  BAM1-PGM                         PIC X(8) VALUE 'BAM1'.

       COPY CAM1.
       01  CAM1-PGM                         PIC X(8) VALUE 'CAM1'.

       COPY PAM1.
       01  PAM1-PGM                         PIC X(8) VALUE 'PAM1'.

       PROCEDURE DIVISION.

       MAIN-PROCESS.

           *>PERFORM INITIALIZE-COMM-AREA
           PERFORM CALL-BAM1
           PERFORM CALL-CAM1
           PERFORM CALL-PAM1
           GOBACK.

       *>INITIALIZE-COMM-AREA.
           *>EXEC CICS RECEIVE
           *>    INTO(CAM1-COMM-AREA)
           *>    LENGTH(LENGTH OF CAM1-COMM-AREA)
           *>    RESP(WS-RESP)
           *>    END-EXEC
           *>EXEC CICS SEND
           *>    FROM(CAM1-COMM-AREA)
           *>    LENGTH(LENGTH OF CAM1-COMM-AREA)
           *>    END-EXEC
           *>EXEC CICS RETURN END-EXEC.

       CALL-BAM1.

           DISPLAY "Calling module BAM1 from CICS..."
           CALL BAM1-PGM   USING BAM1-COMM-AREA
              ON EXCEPTION
                  DISPLAY "Error: Unable to call BAM1."
              END-CALL.

       CALL-CAM1.

           DISPLAY "Calling module CAM1 from CICS..."
           CALL CAM1-PGM   USING CAM1-COMM-AREA
              ON EXCEPTION
                  DISPLAY "Error: Unable to call CAM1."
              END-CALL.

       CALL-PAM1.

           DISPLAY "Calling module PAM1 from CICS..."
           CALL PAM1-PGM   USING PAM1-COMM-AREA
              ON EXCEPTION
                  DISPLAY "Error: Unable to call CAM1."
              END-CALL.

