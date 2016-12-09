REM ---------------------------------------------------------------------------
REM  NAME          : ECASA936.SQL
REM  Author        : Pik Wai
REM  Creation Date : 22-10-2001
REM  Run By        : ECASMGR
REM  Description   : SQL script to create store triggers.
REM ---------------------------------------------------------------------------
REM  Change History:
REM  Changed By    : 
REM  Date          : 
REM  Remarks       :   
REM ---------------------------------------------------------------------------

SET HEADING OFF
SET ECHO OFF

SPOOL ECASA936.LOG

SELECT 'FILENAME: ECASA936.SQL' FROM DUAL;
SELECT 'DATE    : '||TO_CHAR(SYSDATE,'DD-MON-YYYY HH:MI AM') FROM DUAL;



PROMPT CREATING STORE TRIGGER B4INSERT_ecas_lta_pte_cp_rates

CREATE OR REPLACE TRIGGER B4INSERT_ecas_lta_pte_cp_rates
BEFORE INSERT
ON ecas_lta_pte_cp_rates
FOR EACH ROW
BEGIN
   :NEW.cre_dt    := sysdate;
END;
/

SHOW ERROR;


PROMPT CREATING STORE TRIGGER B4UPDATE_ecas_lta_pte_cp_rates

CREATE OR REPLACE TRIGGER B4UPDATE_ecas_lta_pte_cp_rates
BEFORE UPDATE
ON ecas_lta_pte_cp_rates
FOR EACH ROW
BEGIN
   :NEW.upd_dt    := sysdate;
END;
/

SHOW ERROR;


PROMPT CREATING STORE TRIGGER B4INSERT_lta_pte_cp_vacant_lot

CREATE OR REPLACE TRIGGER B4INSERT_lta_pte_cp_vacant_lot
BEFORE INSERT
ON ecas_lta_pte_cp_vacant_lot
FOR EACH ROW
BEGIN
   :NEW.cre_dt    := sysdate;
END;
/

SHOW ERROR;


PROMPT CREATING STORE TRIGGER B4UPDATE_lta_pte_cp_vacant_lot

CREATE OR REPLACE TRIGGER B4UPDATE_lta_pte_cp_vacant_lot
BEFORE UPDATE
ON ecas_lta_pte_cp_vacant_lot
FOR EACH ROW
BEGIN
   :NEW.upd_dt    := sysdate;
END;
/

SHOW ERROR;


SPOOL OFF
SET ECHO ON
