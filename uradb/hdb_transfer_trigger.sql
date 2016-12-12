CREATE OR REPLACE TRIGGER "AFTER_INS_ECAS_HDB_CP" 
AFTER INSERT
ON ECAS_HDB_CP
FOR EACH ROW

BEGIN
	INSERT INTO ECAS_HDB_CP_ARCHIVE (CARPARK_NO, blk_no, street_name, x_coordinate, y_coordinate, carpark_type, carpark_system, short_term_desc, free_park_desc, night_park_desc, park_ride_desc)
	VALUES (:NEW.CARPARK_NO, :NEW.blk_no, :NEW.street_name, :NEW.x_coordinate, :NEW.y_coordinate, :NEW.carpark_type,:NEW.carpark_system,:NEW.short_term_desc,:NEW.free_park_desc,:NEW.night_park_desc,:NEW.park_ride_desc,);
END;

/

CREATE OR REPLACE TRIGGER "AFTER_INS_ECAS_HDB_CP_LOT" 
AFTER INSERT
ON ECAS_HDB_CP_LOT
FOR EACH ROW

BEGIN
	INSERT INTO ECAS_HDB_CP_LOT_ARCHIVE (CARPARK_NO, LOT_TYPE, LOTS_AVAILABLE)
	VALUES (:NEW.CARPARK_NO, :NEW.LOT_TYPE, :NEW.LOTS_AVAILABLE);	
END;
