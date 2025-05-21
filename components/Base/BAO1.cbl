       IDENTIFICATION DIVISION.
       PROGRAM-ID. BAO1.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       *>77 WS-RESP                          PIC S9(8) COMP.

       COPY BAM1.
       01 BAM1-PGM                         PIC X(8) VALUE 'BAM1'.

       PROCEDURE DIVISION.

       MAIN-PROCESS.

           PERFORM CALL-BAM1
           GOBACK.

       *>INITIALIZE-COMM-AREA.
           *>EXEC CICS RECEIVE
           *>    INTO(BAM1-COMM-AREA)
           *>    LENGTH(LENGTH OF BAM1-COMM-AREA)
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