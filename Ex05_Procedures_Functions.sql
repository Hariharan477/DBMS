-- Ex No: 5
-- Procedure

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE Sum_Numbers(a IN NUMBER, b IN NUMBER) IS
    c NUMBER;
BEGIN
    c := a + b;
    DBMS_OUTPUT.PUT_LINE('Sum of two nos = ' || c);
END Sum_Numbers;
/

-- Function

CREATE OR REPLACE FUNCTION Sum_Numbers_Func(a IN NUMBER, b IN NUMBER) 
RETURN NUMBER IS
    c NUMBER;
BEGIN
    c := a + b;
    RETURN c;
END;
/

-- Example calls:
-- EXEC Sum_Numbers(10, 20);
-- SELECT Sum_Numbers_Func(5, 5) FROM DUAL;
