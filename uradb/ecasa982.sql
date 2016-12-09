REM ---------------------------------------------------------------------------
REM  NAME          : ECASA982.SQL
REM  Author        : Namal Welmillage
REM  Creation Date : 21-04-2015
REM  Run By        : ECASMGR
REM  Description   : SQL script to create store triggers. (C-ECAS-2014-020)
REM ---------------------------------------------------------------------------
REM  Change History:
REM  Changed By    : 
REM  Date          : 
REM  Remarks       :   
REM ---------------------------------------------------------------------------

SET HEADING OFF
SET ECHO OFF

SPOOL ECASA982.LOG

SELECT 'FILENAME: ECASA982.SQL' FROM DUAL;
SELECT 'DATE    : '||TO_CHAR(SYSDATE,'DD-MON-YYYY HH:MI AM') FROM DUAL;



PROMPT CREATING STORE TRIGGER B4INSERT_ecas_hdb_cp

CREATE OR REPLACE TRIGGER B4INSERT_ecas_hdb_cp
BEFORE INSERT
ON ecas_hdb_cp
FOR EACH ROW
BEGIN
   :NEW.cre_dt    := sysdate;
END;
/

SHOW ERROR;


PROMPT CREATING STORE TRIGGER B4UPDATE_ecas_hdb_cp

CREATE OR REPLACE TRIGGER B4UPDATE_ecas_hdb_cp
BEFORE UPDATE
ON ecas_hdb_cp
FOR EACH ROW
BEGIN
   :NEW.upd_dt    := sysdate;
END;
/

SHOW ERROR;


PROMPT CREATING STORE TRIGGER B4INSERT_ecas_hdb_cp_lot

CREATE OR REPLACE TRIGGER B4INSERT_ecas_hdb_cp_lot
BEFORE INSERT
ON ecas_hdb_cp_lot
FOR EACH ROW
BEGIN
   :NEW.date_time    := sysdate;
END;
/

SHOW ERROR;


PROMPT CREATING STORE TRIGGER B4UPDATE_ecas_hdb_cp_lot

CREATE OR REPLACE TRIGGER B4UPDATE_ecas_hdb_cp_lot
BEFORE UPDATE
ON ecas_hdb_cp_lot
FOR EACH ROW
BEGIN
   :NEW.date_time    := sysdate;
END;
/

SHOW ERROR;


SPOOL OFF
SET ECHO ON
