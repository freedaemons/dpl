CREATE OR REPLACE TRIGGER "AFTER_INS_ECAS_LTA_PTE_CP_RATES" 
AFTER INSERT
ON ECAS_LTA_PTE_CP_RATES
FOR EACH ROW

BEGIN
	INSERT INTO ECAS_LTA_PTE_CP_RATES_ARCHIVE (carpark_rate_id, carpark_id, carpark_name, category, weekday_rate1, weekday_rate2, saturday_rate, sunday_PH_rate, summary, latitude, longitude, flag, source_cre_dt)
	VALUES (:NEW.carpark_rate_id, :NEW.carpark_id, :NEW.carpark_id, :NEW.carpark_name, :NEW.category, :NEW.weekday_rate1,:NEW.weekday_rate2,:NEW.saturday_rate,:NEW.sunday_PH_rate,:NEW.summary,:NEW.latitude,:NEW.longitude,:NEW.flag,:NEW.source_cre_dt);
END;

/

CREATE OR REPLACE TRIGGER "AFTER_INS_ECAS_LTA_PTE_CP_VACANT_LOT" 
AFTER INSERT
ON ECAS_LTA_PTE_CP_VACANT_LOT
FOR EACH ROW

BEGIN
	INSERT INTO ECAS_HDB_CP_LOT_ARCHIVE (carpark_id, area, development, lots, Summary, latitude, longitude, distance, flag,source_cre_dt)
	VALUES (:NEW.carpark_id, :NEW.area, :NEW.development, :NEW.lots, :NEW.Summary, :NEW.latitude, :NEW.longitude, :NEW.distance, :NEW.flag, :NEW.souce_cre_dt);	
END;
