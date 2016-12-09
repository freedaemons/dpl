REM ---------------------------------------------------------------------------
REM  NAME          : ecasa979.SQL
REM  Author        : Namal Welmillage
REM  Creation Date : 16-04-2015
REM  Run By        : ECASMGR
REM  Description   : CREATE TABLES for storing 
REM                  C-ECAS-2014-020 (ecas_ts for UAT and LIVE TS) (ecas_ndx_ts)
REM ---------------------------------------------------------------------------

column script_file format a30
column run_date format a30
column database format a30
set pagesize 66
set linesize 100
set feedback off

spool ecasa979.log

select 	'Log of ecasa979.sql run in : ' script_file,global_name||' on ' database,
	 to_char(sysdate, 'dd-Mon-yyyy hh:mi A.M.') run_date, ' by '||user username
	 from	global_name;

set heading  on
set feedback on


PROMPT ----- CREATE TABLE ecas_hdb_cp ...  

CREATE TABLE ecas_hdb_cp (
	carpark_no                 VARCHAR2(5) NOT NULL,
	blk_no                     VARCHAR2(40),
	street_name                VARCHAR2(40),
	x_coordinate               NUMBER(9,4) NOT NULL,
	y_coordinate               NUMBER(9,4) NOT NULL,
	carpark_type               VARCHAR2(60),
	carpark_system             VARCHAR2(60),
	short_term_desc            VARCHAR2(60),
	free_park_desc             VARCHAR2(60),
	night_park_desc            VARCHAR2(60),
	park_ride_desc             VARCHAR2(60),
	upd_dt					   DATE,
	cre_dt					   DATE
)
  TABLESPACE ECAS_TS
  STORAGE (
    INITIAL    1024 K
    NEXT       1024 K
    MINEXTENTS    1
    MAXEXTENTS UNLIMITED
    PCTINCREASE   0
  )
/

PROMPT ----- CREATE PRIMARY KEY FOR ecas_hdb_cp ... 

ALTER TABLE ecas_hdb_cp
  ADD CONSTRAINT hdb_cp_pk PRIMARY KEY (
    carpark_no
  )
  USING INDEX
    TABLESPACE ECAS_NDX_TS
    STORAGE (
      INITIAL      64 K
      NEXT       1024 K
      MINEXTENTS    1
      MAXEXTENTS UNLIMITED
      PCTINCREASE   0
    )
/


PROMPT ----- CREATE TABLE ecas_hdb_cp_lot ...  

CREATE TABLE ecas_hdb_cp_lot (
	carpark_no              VARCHAR2(5) NOT NULL,
	lot_type                VARCHAR2(1) NOT NULL,
	lot_available           NUMBER(5,0) NOT NULL,
	date_time               DATE NOT NULL
)
  TABLESPACE ECAS_TS
  STORAGE (
    INITIAL    1024 K
    NEXT       1024 K
    MINEXTENTS    1
    MAXEXTENTS UNLIMITED
    PCTINCREASE   0
  )
/

PROMPT ----- CREATE PRIMARY KEY FOR ecas_hdb_cp_lot ... 

ALTER TABLE ecas_hdb_cp_lot
  ADD CONSTRAINT hdb_cp_lot_pk PRIMARY KEY (
    carpark_no
  )
  USING INDEX
    TABLESPACE ECAS_NDX_TS
    STORAGE (
      INITIAL      64 K
      NEXT       1024 K
      MINEXTENTS    1
      MAXEXTENTS UNLIMITED
      PCTINCREASE   0
    )
/


spool off