      *> COBOL Copybook for Module Calls (PAM1)
      *> Contains basic fields for inter-module communication
       01  PAM1-COMM-AREA.
           05  MAIN-NAME            PIC X(8).    
           *> Name of the calling module
           05  RETURN-CODE          PIC S9(4) COMP. 
           *> Return code from called module
           05  ERROR-MESSAGE        PIC X(100).  
           *> Error message, if any
           05  PAYMENT-ID          PIC X(10).   
           *> PAYMENT identifier
           05  PAYMENT-STATUS      PIC X(1).    
           *> Status of the PAYMENT ('S' for success, 'E' for error)
           05  USER-ID              PIC X(8).    
           *> UserID of person initiating call
           05  TIMESTAMP            PIC X(20).   
           *> Timestamp of the trans (formatted as YYYY-MM-DD HH:MM:SS)
           05  RESERVED-FIELDS      PIC X(50).   
           *> Reserved for future use