REM ---------------------------------------------------------------------------
REM  NAME          : ecasa933.SQL
REM  Author        : pik wai
REM  Creation Date : 07-08-2014
REM  Run By        : ECASMGR
REM  Description   : CREATE TABLES for storing 
REM                  C-ECAS-2014-038 
REM ---------------------------------------------------------------------------

column script_file format a30
column run_date format a30
column database format a30
set pagesize 66
set linesize 100
set feedback off

spool ecasa933.log

select 	'Log of ecasa932.sql run in : ' script_file,global_name||' on ' database,
	 to_char(sysdate, 'dd-Mon-yyyy hh:mi A.M.') run_date, ' by '||user username
	 from	global_name;

set heading  on
set feedback on

PROMPT ----- DROP TABLE ...  
DROP TABLE ecas_lta_pte_cp_rates CASCADE CONSTRAINTS;
DROP TABLE ecas_lta_pte_cp_vacant_lot CASCADE CONSTRAINTS;

PROMPT ----- CREATE TABLE ecas_lta_pte_cp_rates ...  

CREATE TABLE ecas_lta_pte_cp_rates (
  carpark_rate_id    	VARCHAR2(15)  NOT NULL,
  carpark_id    	VARCHAR2(15),
  carpark_name 		VARCHAR2(100)  NOT NULL,
  category		VARCHAR2(50),
  weekday_rate1		VARCHAR2(1000),
  weekday_rate2		VARCHAR2(1000),
  saturday_rate		VARCHAR2(1000),
  sunday_PH_rate	VARCHAR2(1000),
  summary			VARCHAR2(2000),
  latitude   		VARCHAR2(20),
  longitude  		VARCHAR2(20),
  flag  			VARCHAR2(1),
  source_cre_dt    	DATE,
  upd_dt			DATE,
  cre_dt			DATE  NOT NULL
 )
  TABLESPACE ecas_ts
  STORAGE (
    INITIAL    1024 K
    NEXT       1024 K
    MINEXTENTS    1
    MAXEXTENTS UNLIMITED
    PCTINCREASE   0
  )
/

PROMPT ----- CREATE PRIMARY KEY FOR ecas_lta_pte_cp_rates ... 

ALTER TABLE ecas_lta_pte_cp_rates
  ADD CONSTRAINT lta_pte_cp_rates_pk PRIMARY KEY (
    carpark_rate_id,
    cre_dt
  )
  USING INDEX
    TABLESPACE ecas_ndx_ts
    STORAGE (
      INITIAL      64 K
      NEXT       1024 K
      MINEXTENTS    1
      MAXEXTENTS UNLIMITED
      PCTINCREASE   0
    )
/


PROMPT ----- CREATE TABLE ecas_lta_pte_cp_vacant_lot ...  

CREATE TABLE ecas_lta_pte_cp_vacant_lot (
  carpark_id    	VARCHAR2(15)  NOT NULL,
  area	 			VARCHAR2(30)  NOT NULL,
  development		VARCHAR2(100),
  lots			NUMBER,
  Summary		VARCHAR2(200),
  latitude		VARCHAR2(20),
  longitude		VARCHAR2(20),
  distance		VARCHAR2(10),
  flag  		VARCHAR2(1),
  source_cre_dt    	DATE,
  upd_dt		DATE,
  cre_dt		DATE  NOT NULL
)
  TABLESPACE ecas_ts
  STORAGE (
    INITIAL    1024 K
    NEXT       1024 K
    MINEXTENTS    1
    MAXEXTENTS UNLIMITED
    PCTINCREASE   0
  )
/

PROMPT ----- CREATE PRIMARY KEY FOR ecas_lta_pte_cp_vacant_lot ... 

ALTER TABLE ecas_lta_pte_cp_vacant_lot
  ADD CONSTRAINT lta_pte_cp_vacant_lot_pk PRIMARY KEY (
    carpark_id,
    cre_dt
  )
  USING INDEX
    TABLESPACE ecas_ndx_ts
    STORAGE (
      INITIAL      64 K
      NEXT       1024 K
      MINEXTENTS    1
      MAXEXTENTS UNLIMITED
      PCTINCREASE   0
    )
/


spool off