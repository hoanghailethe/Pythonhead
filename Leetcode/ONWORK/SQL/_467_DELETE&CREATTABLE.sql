CREATE OR REPLACE PROCEDURE DeleteTable(tableName varchar2)
IS
 v_counter number := 0;   
begin      
    select count(*) into v_counter from user_tables where table_name = upper(ObjName);
    if v_counter > 0 then          
        execute immediate 'drop table ' || tableName || ' cascade constraints';        
    end if;   
END;

-- Copu table without data
https://stackoverflow.com/questions/233870/how-can-i-create-a-copy-of-an-oracle-table-without-copying-the-data
   DECLARE
    l_ddl   VARCHAR2 (32767);
BEGIN
    l_ddl      := REPLACE (
                      REPLACE (
                          DBMS_LOB.SUBSTR (DBMS_METADATA.get_ddl ('TABLE', 'ACTIVITY_LOG', 'OLDSCHEMA'))
                        , q'["OLDSCHEMA"]'
                        , q'["NEWSCHEMA"]'
                      )
                    , q'["OLDTABLSPACE"]'
                    , q'["NEWTABLESPACE"]'
                  );

    EXECUTE IMMEDIATE l_ddl;
END; 


create table xyz_new as select * from xyz where rownum = -1;

SELECT dbms_metadata.get_ddl( 'TABLE', 'MY_TABLE_NAME' ) FROM DUAL;

Using sql
CREATE TABLE "VBCMS"."HK_CMS_FAC_TSPR" 
   (	"CMS_FAC_MASTER_ID" NUMBER(19,0) NOT NULL ENABLE, 
	"SRC_FACILITY_ID" NVARCHAR2(60), 
	"CGC_FLAG" NVARCHAR2(3), 
	"CGC_REF_NO" NVARCHAR2(60), 
	"CGC_SCHEME" NVARCHAR2(60), 
	"BROAD_PROP_SEC_FLAG" NVARCHAR2(3), 
	"LSM_CODE" NVARCHAR2(60), 
	"RBS_PURP_CODE" NVARCHAR2(60), 
	"LIMIT_DESC" NVARCHAR2(60), 
	"SPE_RMK" NVARCHAR2(255), 
	"IS_TEMP_LINE" NVARCHAR2(1), 
	"AUTO_PURGE" NVARCHAR2(3), 
	"MTR" NVARCHAR2(3), 
	"MBG" NVARCHAR2(3), 
	"COMM_RATE" NUMBER(18,9), 
	"NOR_BASE_RATE_TYPE" NVARCHAR2(60), 
	"NOR_SPREAD" NUMBER(18,9), 
	"OVERD_BASE_RATE_TYPE" NVARCHAR2(60), 
	"OVERD_SPREAD" NUMBER(18,9), 
	"PENLT_BASE_RATE_TYPE" NVARCHAR2(60), 
	"PENLT_SPREAD" NUMBER(18,9), 
	"LMT_EXPRY_DATE" DATE, 
	"TSPR_LMT_ID" NVARCHAR2(60), 
	"TSPR_OUTER_LMT_ID" NVARCHAR2(60), 
	"TSPR_ROOT_LMT_ID" NVARCHAR2(60), 
	"MAINT_STATUS_CODE" NVARCHAR2(60), 
	 PRIMARY KEY ("CMS_FAC_MASTER_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "CMS_SMALL_DATA"  ENABLE, 
	 CONSTRAINT "HK_FK_FAC_TSPR" FOREIGN KEY ("CMS_FAC_MASTER_ID")
	  REFERENCES "VBCMS"."CMS_FACILITY_MASTER" ("ID") ENABLE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "CMS_SMALL_DATA" ;

  DROP TABLE "VBCMS"."HK_CMS_FAC_TSPR";

  --TEST done, successful create, delete