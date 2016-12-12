CREATE TABLE "ECAS_HDB_CP_ARCHIVE" (
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
  TABLESPACE APPL_DATA
  STORAGE (
    INITIAL    1024 K
    NEXT       1024 K
    MINEXTENTS    1
    MAXEXTENTS UNLIMITED
    PCTINCREASE   0
  )
/
ALTER TABLE "ECAS_HDB_CP_ARCHIVE"
  ADD CONSTRAINT hdb_cp_pk PRIMARY KEY (
    carpark_no
  )
  USING INDEX
    TABLESPACE APPL_DATA
    STORAGE (
      INITIAL      64 K
      NEXT       1024 K
      MINEXTENTS    1
      MAXEXTENTS UNLIMITED
      PCTINCREASE   0
    )
/
CREATE TABLE "ECAS_HDB_CP_LOT_ARCHIVE" (
	carpark_no              VARCHAR2(5) NOT NULL,
	lot_type                VARCHAR2(1) NOT NULL,
	lot_available           NUMBER(5,0) NOT NULL,
	date_time               DATE NOT NULL
)
  TABLESPACE APPL_DATA
  STORAGE (
    INITIAL    1024 K
    NEXT       1024 K
    MINEXTENTS    1
    MAXEXTENTS UNLIMITED
    PCTINCREASE   0
  )
/
ALTER TABLE "ECAS_HDB_CP_LOT_ARCHIVE"
  ADD CONSTRAINT hdb_cp_lot_pk PRIMARY KEY (
    carpark_no
  )
  USING INDEX
    TABLESPACE APPL_DATA
    STORAGE (
      INITIAL      64 K
      NEXT       1024 K
      MINEXTENTS    1
      MAXEXTENTS UNLIMITED
      PCTINCREASE   0
    )


CREATE OR REPLACE TRIGGER B4_INS_ECAS_HDB_CP_ARCHIVE
BEFORE INSERT
ON ECAS_HDB_CP_ARCHIVE
FOR EACH ROW
BEGIN
   :NEW.cre_date    := SYSDATE;
END;

/
ALTER TRIGGER B4_INS_ECAS_HDB_CP_ARCHIVE ENABLE;

CREATE OR REPLACE TRIGGER B4_UPD_ECAS_HDB_CP_ARCHIVE
BEFORE UPDATE
ON ECAS_HDB_CP_ARCHIVE
FOR EACH ROW
BEGIN
   :NEW.UPD_DATE    := SYSDATE;
END;

/
ALTER TRIGGER B4_UPD_ECAS_HDB_CP_ARCHIVE ENABLE;

/*CREATE OR REPLACE TRIGGER AFTER_INS_ECAS_HDB_CP_ARCHIVE
AFTER INSERT
ON ECAS_HDB_CP_ARCHIVE
FOR EACH ROW
	DECLARE
	CNT NUMBER (3);

	BEGIN

		SELECT COUNT(*) INTO CNT FROM ECAS_SP_REALTIME WHERE CARPARK_NO = :NEW.CARPARK_NO AND LOT_TYPE = :NEW.LOT_TYPE;

		IF (CNT = 0) THEN
			INSERT INTO ECAS_SP_REALTIME (CARPARK_NO, LOT_TYPE, LOTS_AVAILABLE, TOTAL_OPER_LOTS)
			VALUES (:NEW.CARPARK_NO, :NEW.LOT_TYPE, :NEW.LOTS_AVAILABLE, :NEW.TOTAL_OPER_LOTS);
		END IF;

		IF (CNT > 0) THEN
			UPDATE ECAS_SP_REALTIME
			SET LOTS_AVAILABLE = :NEW.LOTS_AVAILABLE, TOTAL_OPER_LOTS = :NEW.TOTAL_OPER_LOTS
			WHERE CARPARK_NO = :NEW.CARPARK_NO AND 
			LOT_TYPE = :NEW.LOT_TYPE;
		END IF;
		
	END;
/
ALTER TRIGGER AFTER_INS_ECAS_HDB_CP_ARCHIVE ENABLE;*/

CREATE OR REPLACE TRIGGER B4_INS_ECAS_HDB_CP_LOT_ARCHIVE
BEFORE INSERT
ON ECAS_HDB_CP_LOT_ARCHIVE
FOR EACH ROW
BEGIN
   :NEW.CRE_DATE    := SYSDATE;
END;

/
ALTER TRIGGER B4_INS_ECAS_HDB_CP_LOT_ARCHIVE ENABLE;

CREATE OR REPLACE TRIGGER B4_UPD_ECAS_HDB_CP_LOT_ARCHIVE
ON ECAS_HDB_CP_LOT_ARCHIVE
FOR EACH ROW
BEGIN
   :NEW.UPD_DATE    := SYSDATE;
END;

/
ALTER TRIGGER B4_INS_ECAS_HDB_CP_LOT_ARCHIVE ENABLE;

/*CREATE OR REPLACE TRIGGER AFTER_INS_ECAS_HDB_CP_LOT_ARCHIVE
AFTER INSERT
ON ECAS_HDB_CP_LOT_ARCHIVE
FOR EACH ROW
  DECLARE
  CNT NUMBER (3);

  BEGIN

    SELECT COUNT(*) INTO CNT FROM ECAS_SP_REALTIME WHERE CARPARK_NO = :NEW.CARPARK_NO AND LOT_TYPE = :NEW.LOT_TYPE;

    IF (CNT = 0) THEN
      INSERT INTO ECAS_SP_REALTIME (CARPARK_NO, LOT_TYPE, LOTS_AVAILABLE, TOTAL_OPER_LOTS)
      VALUES (:NEW.CARPARK_NO, :NEW.LOT_TYPE, :NEW.LOTS_AVAILABLE, :NEW.TOTAL_OPER_LOTS);
    END IF;

    IF (CNT > 0) THEN
      UPDATE ECAS_SP_REALTIME
      SET LOTS_AVAILABLE = :NEW.LOTS_AVAILABLE, TOTAL_OPER_LOTS = :NEW.TOTAL_OPER_LOTS
      WHERE CARPARK_NO = :NEW.CARPARK_NO AND 
      LOT_TYPE = :NEW.LOT_TYPE;
    END IF;
    
  END;
/
ALTER TRIGGER AFTER_INS_ECAS_HDB_CP_LOT_ARCHIVE ENABLE;*/
