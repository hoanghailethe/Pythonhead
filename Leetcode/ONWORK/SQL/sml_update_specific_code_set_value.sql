CREATE OR REPLACE PROCEDURE UPDATE_SPECIFIC_CODE_SET_VALUE (common_code_name varchar2 ) IS

--for code_set
v_cc common_code_category.CATEGORY_CODE%type;
v_active_status common_code_category.active_status%type;
v_category_name common_code_category.category_name%type;
v_ref_category_code common_code_category.ref_category_code%type;
v_category_type common_code_category.category_type%type;
--for code_value
v_entry_code common_code_category_entry.entry_code%type; 
v_active_status_en common_code_category_entry.active_status%type; 
v_entry_name common_code_category_entry.entry_name%type; 
v_entry_source common_code_category_entry.entry_source%type; 
v_country common_code_category_entry.country%type; 
v_ref_entry_code common_code_category_entry.ref_entry_code%type; 
v_LOCALE_NAME1  common_code_category_entry.LOCALE_NAME1%type; 
v_display_order CODE_VALUE.DISPLAY_ORDER%type; 

i number(19,0) ;
v_count number(19,0);
v_count_type1 number(19,0);
v_count_type2 number(19,0);
v_count_type3 number(19,0);
v_count_type4 number(19,0);
v_count_typen number(19,0);
CURSOR cc_entry IS 
    SELECT EN.entry_code , EN.active_status, EN.entry_name, EN.entry_source, EN.country, EN.ref_entry_code , EN.LOCALE_NAME1
    --into v_active_status_en, v_entry_name,v_entry_source,v_country, v_ref_entry_code
    FROM common_code_category_entry EN ,common_code_category COM
    WHERE EN.category_code = COM.category_code
    AND COM.CATEGORY_CODE = v_cc
    and   COM.category_code  NOT IN
                                          (   SELECT  category_code
                                              FROM   common_code_category
                                              GROUP BY   category_code
                                              HAVING   COUNT(category_code) >  1);

BEGIN
  v_count := 0;
  v_count_type1 := 0;
  v_count_type2 := 0;
  v_count_type3 := 0;
  v_count_type4 := 0;      
  i:= 0; 
  v_cc := trim(common_code_name);
  si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 1);
  COMMIT;
  -- error if common_code_name = null
   if v_cc is null then
      si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 991);
      COMMIT;
      return;
   end if ;
   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 2);
   COMMIT;
   
   -- 1. FOR CODE_SET 
   begin
     -- check in  clim
     --if not have in  clim then DELETE in clos
     --if have  in clim then check / INSERT/ UPDATE in clos
        select active_status ,category_name,ref_category_code ,category_type into v_active_status, v_category_name, v_ref_category_code ,v_category_type
        FROM   common_code_category cc WHERE   cc.category_code = v_cc
        and   category_code  NOT IN
                                              (   SELECT  category_code
                                                  FROM   common_code_category
                                                  GROUP BY   category_code
                                                  HAVING   COUNT(category_code) >  1);
        si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 3);
        COMMIT;
               
 
                                     
      -- update clos if found in clim  and CLOS.SOURCE == ‘CMS’ 
        UPDATE   code_set cs
        SET
            version_time = 1,
            last_update_by = 'SYSTEM',
            last_update_date = CURRENT_TIMESTAMP,
            deprecated = decode(v_active_status,'D' ,'Y' ,'N' ),
            status = decode(v_active_status,'D' ,'DELETED' ,'ACTIVE' ),
            name = v_category_name,
            maintenance_ind = 'N',
            source = 'CMS',
            code_set_parent_code = v_ref_category_code,
            category_type = v_category_type         
        WHERE   cs.source = 'CMS'
        and code = v_cc;

        si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 4);
        COMMIT;        
        
        select count(*) into v_count from code_set where code = v_cc and master_id IS NULL;
        if v_count = 0 then
            -- insert into code_set if not found in code_set - master
            INSERT INTO code_set (id ,
                                 version_time ,
                                 create_by ,
                                 creation_date ,
                                 last_update_by,
                                 last_update_date,
                                 deprecated ,
                                 status,
                                 code,
                                 name ,
                                 maintenance_ind ,
                                 source ,
                                 code_set_parent_code ,
                                 category_type )
           SELECT   code_set_id_seq.NEXTVAL,
                    0,
                    'SYSTEM',
                    CURRENT_TIMESTAMP,
                    'SYSTEM',
                    CURRENT_TIMESTAMP,
                    decode(v_active_status,'D' ,'Y' ,'N' ),
                    decode(v_active_status,'D' ,'DELETED' ,'ACTIVE' ),
                    v_cc ,
                    v_category_name,
                    'N',
                    'CMS',
                    v_ref_category_code,
                    v_category_type
              FROM   dual;          
        end if;
        si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 5);
        COMMIT;
        
        select count(*) into v_count from code_set where code = v_cc and master_id IS NOT NULL;
        if v_count = 0 then
            INSERT INTO code_set (id,
                             version_time,
                             create_by,
                             creation_date,
                             last_update_by,
                             last_update_date,
                             deprecated,
                             status,
                             code,
                             name,
                             maintenance_ind,
                             source,
                             code_set_parent_code,
                             category_type,
                             master_id)
            SELECT   code_set_id_seq.NEXTVAL,
                    0,
                    'SYSTEM',
                    CURRENT_TIMESTAMP,
                    'SYSTEM',
                    CURRENT_TIMESTAMP,
                    decode(v_active_status,'D' ,'Y' ,'N' ),
                    decode(v_active_status,'D' ,'DELETED' ,'ACTIVE' ),
                    v_cc,
                    v_category_name,
                    'N',
                    'CMS',
                    v_ref_category_code,
                    v_category_type,
                    (SELECT   id
                     FROM   code_set cs1
                     WHERE       cs1.code = v_cc
                              AND source = 'CMS'
                              AND cs1.master_id IS NULL)
            FROM   dual cc;
        end if;  
        si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 6);
        COMMIT;
                            
   exception
   -- update clos to deleted if not found in clim and CLOS.SOURCE is ‘CMS’ 
   when no_data_found then
       UPDATE   code_set cs
          SET   last_update_by = 'SYSTEM',
                last_update_date = CURRENT_TIMESTAMP,
                deprecated = 'Y',
                status = 'DELETED'
        WHERE   cs.code = v_cc
                AND cs.source = 'CMS'
                AND cs.deprecated = 'N';

       si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 7);
       COMMIT;
   when others then
      si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 992);
      COMMIT;
      return;
   end;

   
  -- 2. FOR CODE_VALUE   
  OPEN cc_entry; 
  LOOP 
  FETCH cc_entry INTO v_entry_code,v_active_status_en, v_entry_name,v_entry_source,v_country, v_ref_entry_code, v_LOCALE_NAME1; 
  EXIT WHEN cc_entry%NOTFOUND; 
  
    --2.1 CHECK
   
    -- check type in clim then update base on specail column
    select count(*) into v_count_type1 from common_code_category_entry where category_code = v_cc and entry_code = v_entry_code;
    select count(*) into v_count_type2 from common_code_category_entry where category_code = v_cc and entry_code = v_entry_code and ref_entry_code = v_ref_entry_code;
    select count(*) into v_count_type3 from common_code_category_entry where category_code = v_cc and entry_code = v_entry_code and entry_name = v_entry_name;
    select count(*) into v_count_type4 from common_code_category_entry where category_code = v_cc and entry_code = v_entry_code and entry_name = v_entry_name and ref_entry_code = v_ref_entry_code;             

    --check is map to display order
    begin
        if trim(v_ref_entry_code) is not null then
            v_display_order := to_number(v_ref_entry_code);
        else
            v_display_order :=999;
        end if;
    exception
    when others then
        v_display_order :=999;
    end;
    
    
    --2.2 INSERT / UPDATE 
    --TYPE 1 : category_code , entry_code 
     If v_count_type1 = 1 then  

        MERGE INTO   code_value
        USING
        (
            select 
                 cs.id cs_id ,
                 'SYSTEM' create_by,
                 CURRENT_TIMESTAMP creation_date,
                 'SYSTEM' last_update_by,
                 CURRENT_TIMESTAMP last_update_date ,
                 decode (v_active_status_en , '0' ,'Y' , 'N') deprecated ,
                 decode (v_active_status_en , '0' ,'DELETED' , 'ACTIVE') status ,
                 v_entry_name code_value ,
                 v_LOCALE_NAME1 CODE_VALUE_EN,
                 v_entry_source entry_source ,
                 v_country country,
                 v_ref_entry_code code_value_parent_code ,
                 v_display_order display_order,
                 'CMS' source    
            from code_set cs
            where cs.code = v_cc
            and cs.source = 'CMS'           
        )
        ce_input
        ON   
        (
            code_value.code = v_entry_code         
            AND code_value.code_set_value_id = ce_input.cs_id
        )
        WHEN MATCHED
            THEN     
            UPDATE SET   
                 version_time = '1',
                 last_update_by = ce_input.last_update_by,
                 last_update_date =  ce_input.last_update_date,
                 deprecated =  ce_input.deprecated ,
                 status =  ce_input.status ,
                 code_value =  ce_input.code_value ,
                 CODE_VALUE_EN = ce_input.CODE_VALUE_EN,
                 entry_source =  ce_input.entry_source ,
                 country =  ce_input.country ,
                 code_value_parent_code  =  ce_input.code_value_parent_code ,
                 display_order =  ce_input.display_order ,
                 source  =  ce_input.source             
        WHEN NOT MATCHED
            THEN
            INSERT
            (  id,
               version_time,
               create_by,
               creation_date,
               last_update_by,
               last_update_date,
               deprecated,
               status,
               code,
               code_value,
               CODE_VALUE_EN,
               code_set_value_id,
               display_order,
               source,
               entry_source,
               country,
               code_value_parent_code
            ) 
            VALUES
            ( 
                code_value_id_seq.NEXTVAL,
                '0',
                ce_input.create_by,
                ce_input.creation_date,
                ce_input.last_update_by,
                ce_input.last_update_date,
                ce_input.deprecated,
                ce_input.status,
                v_entry_code,          --ce_input.code,
                ce_input.code_value,
                ce_input.CODE_VALUE_EN,
                ce_input.cs_id ,
                ce_input.display_order,
                ce_input.source,
                ce_input.entry_source,
                ce_input.country,
                ce_input.code_value_parent_code            
            ) ;       
        
    --TYPE 2: category_code , entry_code , ref_entry_code   
     ELSIF v_count_type1 > 1 and v_count_type2 = 1 then
        -- check in clos 
        select count(*) into v_count from code_value cv, code_set cs
        where CV.code_set_value_id = cs.id 
        and cs.code = v_cc 
        and cs.source = 'CMS' 
        and ( cv.code_value_parent_code   = v_ref_entry_code  or CV.DISPLAY_ORDER = v_DISPLAY_ORDER )
        and cv.code = v_entry_code ;   
        if v_count = 0 then
           INSERT into code_value
                                   (id,
                                   version_time,
                                   create_by,
                                   creation_date,
                                   last_update_by,
                                   last_update_date,
                                   deprecated,
                                   status,
                                   code,
                                   code_value,
                                   CODE_VALUE_EN,
                                   code_set_value_id,
                                   display_order,
                                   source,
                                   entry_source,
                                   country,
                                   code_value_parent_code)
            select
                                    code_value_id_seq.NEXTVAL,
                                    0,
                                    'SYSTEM',
                                    CURRENT_TIMESTAMP,
                                    'SYSTEM',
                                    CURRENT_TIMESTAMP,
                                    decode (v_active_status_en , '0' ,'Y' , 'N') ,
                                    decode (v_active_status_en , '0' ,'DELETED' , 'ACTIVE')  ,
                                    v_entry_code,
                                    v_entry_name,
                                    v_LOCALE_NAME1,
                                    cs.id,
                                    v_display_order,
                                    'CMS',
                                    v_entry_source,
                                    v_country,
                                    v_ref_entry_code
            from code_set cs where CS.CODE = v_cc ;         
        else
            update code_value cv
            set
            (
             version_time,
             last_update_by,
             last_update_date ,
             deprecated ,
             status ,
             code_value ,
             CODE_VALUE_EN,
             entry_source ,
             country,
             code_value_parent_code ,
             display_order,
             source 
            ) =
            (SELECT 
             1,
             'SYSTEM',
             CURRENT_TIMESTAMP,
             decode (v_active_status_en , '0' ,'Y' , 'N') ,
             decode (v_active_status_en , '0' ,'DELETED' , 'ACTIVE') ,
             v_entry_name,
             v_LOCALE_NAME1,
             v_entry_source,
             v_country,
             v_ref_entry_code,
             v_display_order,
             'CMS'
             from code_set cs  where cs.id = cv.code_set_value_id and cs.source = 'CMS' and cs.code = v_cc  
            )
            where
            cv.code = v_entry_code 
            and CV.code_value_parent_code = v_ref_entry_code;                          
        end if;    
     
          
    --TYPE 3: category_code , entry_code , entry_name        
     ELSIF v_count_type1 > 1 and v_count_type3 = 1 then
        -- check in clos 
        select count(*) into v_count from code_value cv, code_set cs
        where CV.code_set_value_id = cs.id
        and cs.code = v_cc
        and cs.source = 'CMS' 
        and cv.code = v_entry_code 
        and cv.code_value = v_entry_name ;     
        if v_count = 0 then
           INSERT into code_value
                                   (id,
                                   version_time,
                                   create_by,
                                   creation_date,
                                   last_update_by,
                                   last_update_date,
                                   deprecated,
                                   status,
                                   code,
                                   code_value,
                                   CODE_VALUE_EN,
                                   code_set_value_id,
                                   display_order,
                                   source,
                                   entry_source,
                                   country,
                                   code_value_parent_code)
            select
                                    code_value_id_seq.NEXTVAL,
                                    0,
                                    'SYSTEM',
                                    CURRENT_TIMESTAMP,
                                    'SYSTEM',
                                    CURRENT_TIMESTAMP,
                                    decode (v_active_status_en , '0' ,'Y' , 'N') ,
                                    decode (v_active_status_en , '0' ,'DELETED' , 'ACTIVE')  ,
                                    v_entry_code,
                                    v_entry_name,
                                    v_LOCALE_NAME1,
                                    cs.id,
                                    v_display_order,
                                    'CMS',
                                    v_entry_source,
                                    v_country,
                                    v_ref_entry_code
            from code_set cs where CS.CODE = v_cc ;         
        else
            update code_value cv
            set
            (
             version_time,
             last_update_by,
             last_update_date ,
             deprecated ,
             status ,
             code_value ,
             CODE_VALUE_EN,
             entry_source ,
             country,
             code_value_parent_code ,
             display_order,
             source 
            ) =
            (SELECT 
             1,
             'SYSTEM',
             CURRENT_TIMESTAMP,
             decode (v_active_status_en , '0' ,'Y' , 'N') ,
             decode (v_active_status_en , '0' ,'DELETED' , 'ACTIVE') ,
             v_entry_name,
             v_LOCALE_NAME1 ,
             v_entry_source,
             v_country,
             v_ref_entry_code,
             v_display_order,
             'CMS'
             from code_set cs  where cs.id = cv.code_set_value_id and cs.source = 'CMS' and cs.code = v_cc 
            )
            where
            cv.code = v_entry_code 
            and cv.code_value = v_entry_name      ;             
        end if;     
   
        
    --TYPE 4: category_code , entry_code ,entry_name, ref_entry_code        
     ELSIF v_count_type1 > 1 and v_count_type4 = 1 then
        -- check in clos 
        select count(*) into v_count from code_value cv, code_set cs
        where CV.code_set_value_id = cs.id
        and cs.code = v_cc
        and cs.source = 'CMS' 
        and cv.code = v_entry_code 
        and cv.code_value = v_entry_name 
        and ( cv.code_value_parent_code   = v_ref_entry_code  or CV.DISPLAY_ORDER = v_DISPLAY_ORDER );     
        if v_count = 0 then
           INSERT into code_value
                                   (id,
                                   version_time,
                                   create_by,
                                   creation_date,
                                   last_update_by,
                                   last_update_date,
                                   deprecated,
                                   status,
                                   code,
                                   code_value,
                                   CODE_VALUE_EN,
                                   code_set_value_id,
                                   display_order,
                                   source,
                                   entry_source,
                                   country,
                                   code_value_parent_code)
            select
                                    code_value_id_seq.NEXTVAL,
                                    0,
                                    'SYSTEM',
                                    CURRENT_TIMESTAMP,
                                    'SYSTEM',
                                    CURRENT_TIMESTAMP,
                                    decode (v_active_status_en , '0' ,'Y' , 'N') ,
                                    decode (v_active_status_en , '0' ,'DELETED' , 'ACTIVE')  ,
                                    v_entry_code,
                                    v_entry_name,
                                    v_LOCALE_NAME1 ,
                                    cs.id,
                                    v_display_order,
                                    'CMS',
                                    v_entry_source,
                                    v_country,
                                    v_ref_entry_code
            from code_set cs where CS.CODE = v_cc ;         
        else
            update code_value cv
            set
            (
             version_time,
             last_update_by,
             last_update_date ,
             deprecated ,
             status ,
             code_value ,
             CODE_VALUE_EN,
             entry_source ,
             country,
             code_value_parent_code ,
             display_order,
             source 
            ) =
            (SELECT 
             1,
             'SYSTEM',
             CURRENT_TIMESTAMP,
             decode (v_active_status_en , '0' ,'Y' , 'N') ,
             decode (v_active_status_en , '0' ,'DELETED' , 'ACTIVE') ,
             v_entry_name,
             v_LOCALE_NAME1,
             v_entry_source,
             v_country,
             v_ref_entry_code,
             v_display_order,
             'CMS'
             from code_set cs  where cs.id = cv.code_set_value_id and cs.source = 'CMS' and cs.code = v_cc 
            )
            where
            cv.code = v_entry_code 
            and cv.code_value = v_entry_name     
            and CV.code_value_parent_code = v_ref_entry_code;                
        end if;  
                    
     else 
        si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 993);
        COMMIT;
        return;
     end if;                                    
               
    i := i+1;
  END LOOP; 
  CLOSE cc_entry; 


  --  If CLOS.CODE  (exist) and CLIMS.CODE(not exists) and CLOS.SOURCE is ‘CMS’ then  Deprecate CLOS 
  if i = 0 then
   UPDATE   code_value CV
   SET
            last_update_by = 'SYSTEM',
            last_update_date = CURRENT_TIMESTAMP,
            deprecated = 'Y',
            status = 'DELETED'
   WHERE   CV.code_set_value_id IN
                  ( SELECT   id
                    FROM   code_set
                    WHERE   code = v_cc
                    AND source = 'CMS')
   AND CV.source = 'CMS'
   AND CV.deprecated = 'N';
   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 9);
   COMMIT;
     
  end if;
  
    -- DEPRECATED MISSING CODE_VALUE THAT NOT FOUND IN CLIMS
    UPDATE CODE_VALUE CV SET LAST_UPDATE_BY = 'SYSTEM', LAST_UPDATE_DATE = CURRENT_TIMESTAMP, DEPRECATED = 'Y', STATUS = 'DELETED'
    WHERE CV.SOURCE = 'CMS' AND CV.DEPRECATED = 'N' AND CV.CODE_SET_VALUE_ID IN ( SELECT ID FROM CODE_SET WHERE CODE = V_CC AND SOURCE = 'CMS' )
    AND NOT EXISTS (
        SELECT EN.ENTRY_CODE FROM COMMON_CODE_CATEGORY_ENTRY EN, COMMON_CODE_CATEGORY COM
        WHERE EN.ENTRY_CODE = CV.CODE AND EN.CATEGORY_CODE = COM.CATEGORY_CODE AND COM.CATEGORY_CODE = V_CC AND COM.CATEGORY_CODE NOT IN 
        ( SELECT CATEGORY_CODE FROM COMMON_CODE_CATEGORY GROUP BY CATEGORY_CODE HAVING COUNT(CATEGORY_CODE) > 1 )
    );

    
END UPDATE_SPECIFIC_CODE_SET_VALUE;
/


EXIT;