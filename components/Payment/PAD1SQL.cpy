       EXEC SQL DECLARE PAD1 TABLE
       
           (
              PAYMENT_ID CHAR(10) NOT NULL,
           PAYMENT_DATE DATE NOT NULL,
           PAYMENT_USER CHAR(8) NOT NULL
           ) 
           END-EXEC.      