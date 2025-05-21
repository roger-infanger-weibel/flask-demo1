       IDENTIFICATION DIVISION.
       PROGRAM-ID. BAB1.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       COPY BAM1.
       01 BAM1-PGM                         PIC X(8) VALUE 'BAM1'.

       PROCEDURE DIVISION.

       MAIN-PROCESS.

           PERFORM CALL-BAM1
           GOBACK.

       CALL-BAM1.
           DISPLAY "Calling module BAM1..."
           CALL BAM1-PGM USING BAM1-COMM-AREA
              ON EXCEPTION
                  DISPLAY "Error: Unable to call BAM1."
              END-CALL.