create or replace NONEDITIONABLE PROCEDURE proc_update_code_set_value
AS
BEGIN
-- version_time = 0 when new records
-- version_time = 1 when the record got updated
-- no need to set the version when delete


   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 1);
   COMMIT;

   -- update code_set if found in common_code_category
   UPDATE   code_set cs
      SET
            (version_time,
            last_update_by,
            last_update_date,
            deprecated,
            status,
            name,
            maintenance_ind,
            source,
            code_set_parent_code,
            category_type
            ) =
               (SELECT   1,
                         'SYSTEM',
                          CURRENT_TIMESTAMP,
                          decode(active_status,'D' ,'Y' ,'N' ),
                          decode(active_status,'D' ,'DELETED' ,'ACTIVE' ),
                         category_name,
                        'N',
                        'CMS',
                         ref_category_code,
                         category_type
                FROM   common_code_category cc
                WHERE   cc.category_code = cs.code
                )
    WHERE   cs.source = 'CMS'
    AND EXISTS
          (SELECT   1
           FROM   common_code_category cc
           WHERE   cc.category_code = cs.code
           AND cc.category_code NOT IN
                             (  select code from code_set where source  IS  NULL  AND  master_id IS  NULL )
           AND cc.category_code NOT IN
                             (   --to not include duplicates
                                 SELECT    DISTINCT (category_code)
                                 FROM   common_code_category
                                 WHERE   category_code IN
                                              (   SELECT   category_code
                                                  FROM   common_code_category
                                                  GROUP BY   category_code
                                                  HAVING   COUNT(category_code) >  1))
           AND cs.source = 'CMS');


   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 2);
   COMMIT;

   -- insert into code_set if not found in code_set - master

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
                         category_type)
   (SELECT   code_set_id_seq.NEXTVAL,
             0,
            'SYSTEM',
             CURRENT_TIMESTAMP,
            'SYSTEM',
             CURRENT_TIMESTAMP,
             (CASE active_status WHEN 'D' THEN 'Y' ELSE 'N' END),
             (CASE active_status WHEN 'D' THEN 'DELETED' ELSE 'ACTIVE' END)
              b,
              category_code,
              category_name,
              'N',
              'CMS',
              ref_category_code,
              category_type
      FROM   common_code_category cc
      WHERE   cc.category_code NOT IN
                      (select code from code_set where source  IS  NULL AND master_id IS  NULL)
      AND cc.category_code NOT IN
                         ( --to not include duplicates
                          SELECT    DISTINCT (category_code)
                          FROM   common_code_category
                          WHERE   category_code IN
                                          (    SELECT   category_code
                                               FROM   common_code_category
                                               GROUP BY   category_code
                                               HAVING   COUNT (category_code) >
                                                         1)
                          )
      AND NOT EXISTS
                      (SELECT   '1'
                       FROM   code_set cs
                       WHERE       cc.category_code = cs.code
                                AND source = 'CMS'
                                AND master_id IS NULL)
       );



   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 3);
   COMMIT;

   -- insert into code_set if not found in code_set - active

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
      (SELECT   code_set_id_seq.NEXTVAL,
                0,
                'SYSTEM',
                CURRENT_TIMESTAMP,
                'SYSTEM',
                CURRENT_TIMESTAMP,
                (CASE active_status WHEN 'D' THEN 'Y' ELSE 'N' END),
                (CASE active_status WHEN 'D' THEN 'DELETED' ELSE 'ACTIVE' END)
                   b,
                category_code,
                category_name,
                'N',
                'CMS',
                ref_category_code,
                category_type,
                (SELECT   id
                 FROM   code_set cs1
                 WHERE       cs1.code = cc.category_code
                          AND source = 'CMS'
                          AND cs1.master_id IS NULL)
        FROM   common_code_category cc
        WHERE   cc.category_code NOT IN
                      (select code from code_set where source  IS  NULL AND master_id IS  NULL)
        AND cc.category_code NOT IN
                         (--to not include duplicates
                           SELECT    DISTINCT (category_code)
                           FROM   common_code_category
                           WHERE   category_code IN
                                          (  SELECT   category_code
                                             FROM   common_code_category
                                             GROUP BY   category_code
                                             HAVING   COUNT (category_code) >
                                                         1))
       AND NOT EXISTS
                      (  SELECT   '1'
                         FROM   code_set cs
                         WHERE       cc.category_code = cs.code
                         AND source = 'CMS'
                         AND master_id IS NOT NULL));
   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 4);
   COMMIT;

   -- update code_set to deleted if not found in common_code_category
   UPDATE   code_set cs
      SET   --version_time = 0,
            last_update_by = 'SYSTEM',
            last_update_date = CURRENT_TIMESTAMP,
            deprecated = 'Y',
            status = 'DELETED'
    WHERE   cs.code NOT IN (select code from code_set where source  IS  NULL AND master_id IS  NULL)
            AND cs.source = 'CMS'
            AND cs.deprecated = 'N'
            AND NOT EXISTS
                  (  SELECT   '1'
                     FROM   common_code_category cc
                     WHERE   cc.category_code = cs.code
                     AND cc.category_code NOT IN
                                     (select code from code_set where source  IS  NULL AND master_id IS  NULL)
                     AND cs.deprecated = 'N'
                  );

   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 5);
   COMMIT;

   UPDATE   code_set
      SET   code_set_parent_id =
               (SELECT   id
                  FROM   code_set p
                 WHERE   p.code = code_set_parent_code)
    WHERE   code_set_parent_code IS NOT NULL;



   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 6);
   COMMIT;

/*-------------------------------------------*/
   -- start update code_value table
/*-------------------------------------------*/
   --1.1)  unique key is entry_code , category_code : insert / update
   MERGE INTO   code_value
        USING   (SELECT   ce.entry_code AS code,
                          ce.category_code,
                          cs.id AS cs_id,                -- clos reference key
                          'SYSTEM' AS create_by,
                          CURRENT_TIMESTAMP AS creation_date,
                          'SYSTEM' AS last_update_by,
                          CURRENT_TIMESTAMP AS last_update_date,
                           decode(ce.active_status,'0','Y','N') AS deprecated,
                           decode(ce.active_status,'0','DELETED','ACTIVE')  AS status,
                          entry_name AS code_value,
                          LOCALE_NAME1 as CODE_VALUE_EN,
                          ce.entry_source AS entry_source,
                          ce.country AS country,
                          ce.ref_entry_code AS code_value_parent_code,
                          999 AS display_order,
                          'CMS' AS source
                  FROM      common_code_category_entry ce
                          INNER JOIN
                             code_set cs
                          ON cs.code = ce.category_code
                  WHERE
                  ce.category_code IN
                          (-- 1.base on special columns ;
                             -- key is entry_code , category_code , ref_entry_code
                            'APPROVAL_EXCEPTIONAL',
                            'EXCEPTIONAL_APPROVAL_FACILITY','EXCEPTIONAL_APPROVAL_AA'
                            )
                            --3.not convert to CLOS
                  and category_code NOT IN (select code from code_set where source  IS  NULL AND master_id IS  NULL and deprecated <> 'Y')
                  AND cs.source = 'CMS'
                )
                ce_input
           ON   (
                    code_value.code = ce_input.code
                    AND code_value.code_set_value_id = ce_input.cs_id

                )
   WHEN MATCHED
   THEN
      UPDATE SET
         version_time = 1,
         last_update_by = ce_input.last_update_by,
         last_update_date = ce_input.last_update_date,
         deprecated = ce_input.deprecated,
         status = ce_input.status,
         code_value = ce_input.code_value,
         CODE_VALUE_EN = ce_input.CODE_VALUE_EN,
         entry_source = ce_input.entry_source,
         country = ce_input.country,
         code_value_parent_code = ce_input.code_value_parent_code,
         display_order = ce_input.display_order,
         source = ce_input.source
   WHEN NOT MATCHED
   THEN
      INSERT              (id,
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
          VALUES   (code_value_id_seq.NEXTVAL,
                    0,
                    ce_input.create_by,
                    ce_input.creation_date,
                    ce_input.last_update_by,
                    ce_input.last_update_date,
                    ce_input.deprecated,
                    ce_input.status,
                    ce_input.code,
                    ce_input.code_value,
                    ce_input.CODE_VALUE_EN,
                    ce_input.cs_id,
                    ce_input.display_order,
                    ce_input.source,
                    ce_input.entry_source,
                    ce_input.country,
                    ce_input.code_value_parent_code);


   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 7);
   COMMIT;

   --1.2)  unique key is entry_code , category_code : delete
   --update code_value to deleted if not found in common_code_category_entry
    update code_value cv
    set
    version_time = 0,
    last_update_by = 'SYSTEM',
    last_update_date = CURRENT_TIMESTAMP,
    deprecated = 'Y',
    status = 'DELETED'
    where
    CV.CODE_SET_VALUE_ID not in
    (select CS.ID from code_set cs where cs.code in
                            (
                            -- base on special columns
                            'SOURCE_SEC_TYPE',
                            'SOURCE_CMS_SEC_TYPE_MAP',
                            'FAC_RATE',
                            'LOS_ROLE_ACCESS',
                            'STATE',
                            'AA_CAR_CODE_FLAG',
                            'SUB_PRODUCT_GROUP_MAPPING',
                            '27A',
                            'FAC_PRODUCT_MAP',
                            'FAC_SUB_PROD_RELATION' ,
                            'ID_TYPE'  ,
                            'OCCUP_TYPE',
                            'BUSINESS_TYPE_1',
                            'BUSINESS_TYPE_2',
                            '56',
                              --not convert to CLOS
                            'EVIDENCEOFINCOME_SELF_EMPLOYED',
                            'COUNTRY_LAW_MAP'
                            )
                            or
                            --not convert to CLOS
                            cs.code in (select code from code_set where source  IS  NULL AND master_id IS  NULL and deprecated <> 'Y')
    )
    and
    NOT EXISTS
                  (  SELECT   '1'
                     FROM   COMMON_CODE_CATEGORY_ENTRY cc, code_set cs
                     WHERE   cc.ENTRY_CODE = cv.code
                     and cc.CATEGORY_CODE = cs.code
                     and cs.id = cv.CODE_SET_VALUE_ID);

   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 8);
   COMMIT;
   -- 2.0)    unique key is entry_code , category_code witch special insert rule. : insert / update
   --         VCLOSSITA-282 : COMMON_CODE_CATEGORY_ENTRY.REF_ENTRY_CODE map to code_value.display_order
   MERGE INTO   code_value
        USING   (SELECT
                          'SYSTEM' AS create_by,
                          CURRENT_TIMESTAMP AS creation_date,
                          'SYSTEM' AS last_update_by,
                          CURRENT_TIMESTAMP AS last_update_date,
                          decode (ce.active_status , '0' ,'Y' , 'N')   AS deprecated,
                          decode (ce.active_status , '0' ,'DELETED' , 'ACTIVE')    AS status,
                          entry_name AS code_value,
                          LOCALE_NAME1 as CODE_VALUE_EN,                          
                          entry_source AS entry_source,
                          country,
                          --VCLOSSITA-282 :COMMON_CODE_CATEGORY_ENTRY.REF_ENTRY_CODE map to code_value.display_order
                          ref_entry_code AS display_order,
                          'CMS' AS source,
                          cs.id AS cs_id,
                          --VCLOSSITA-282 : COMMON_CODE_CATEGORY_ENTRY.REF_ENTRY_CODE  NOT map to code_value.code_value_parent_code
                          --ref_entry_code,
                          entry_code AS code
                   FROM   common_code_category_entry ce, code_set cs
                   WHERE   ce.category_code = cs.code
                   AND ce.category_code IN ('AA_TREASURY_TENOR','AA_PRODUCT_GROUP','AA_ISSUER_LIMIT_TENOR'))
                ce_update
           ON   (code_value.code = ce_update.code
                 AND code_value.code_set_value_id = ce_update.cs_id
                )
   WHEN MATCHED
   THEN
      UPDATE SET
         version_time = 1,
         last_update_by = ce_update.last_update_by,
         last_update_date = ce_update.last_update_date,
         deprecated = ce_update.deprecated,
         status = ce_update.status,
         code_value = ce_update.code_value,
         CODE_VALUE_EN = ce_update.CODE_VALUE_EN,          
         entry_source = ce_update.entry_source,
         country = ce_update.country,
         display_order = ce_update.display_order,
         source = ce_update.source
   WHEN NOT MATCHED
   THEN
   INSERT
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
                           --VCLOSSITA-282 : COMMON_CODE_CATEGORY_ENTRY.REF_ENTRY_CODE map to code_value.display_order
                           display_order,
                           source,
                           entry_source,
                           country

                           )
    VALUES
                           (
                            code_value_id_seq.NEXTVAL,
                            0,
                            ce_update.create_by,
                            ce_update.creation_date,
                            ce_update.last_update_by,
                            ce_update.last_update_date,
                            ce_update.deprecated,
                            ce_update.status,
                            ce_update.code,
                            ce_update.code_value,
                            ce_update.CODE_VALUE_EN,                                      
                            ce_update.cs_id,
                            --VCLOSSITA-282 : COMMON_CODE_CATEGORY_ENTRY.REF_ENTRY_CODE map to code_value.display_order
                            ce_update.display_order,
                            ce_update.source,
                            ce_update.entry_source,
                            ce_update.country
                            )  ;


   -- 2.1)   for common code unique key is entry_code , category_code , ref_entry_code : insert / update
   MERGE INTO   code_value
        USING   (SELECT
                          'SYSTEM' AS create_by,
                          CURRENT_TIMESTAMP AS creation_date,
                          'SYSTEM' AS last_update_by,
                          CURRENT_TIMESTAMP AS last_update_date,
                          decode (ce.active_status , '0' ,'Y' , 'N')   AS deprecated,
                          decode (ce.active_status , '0' ,'DELETED' , 'ACTIVE')    AS status,
                          entry_name AS code_value,
                          LOCALE_NAME1 as CODE_VALUE_EN,                          
                          entry_source AS entry_source,
                          country,
                          999 AS display_order,
                          'CMS' AS source,
                          cs.id AS cs_id,
                          ref_entry_code,
                          entry_code AS code
                   FROM   common_code_category_entry ce, code_set cs
                   WHERE   ce.category_code = cs.code
                   AND ce.category_code IN ('EXCEPTIONAL_APPROVAL_FACILITY','EXCEPTIONAL_APPROVAL_AA'))
                ce_update
           ON   (code_value.code = ce_update.code
                 AND code_value.code_set_value_id = ce_update.cs_id
                 AND code_value.code_value_parent_code =  ce_update.ref_entry_code)
   WHEN MATCHED
   THEN
      UPDATE SET
         version_time = 1,
         last_update_by = ce_update.last_update_by,
         last_update_date = ce_update.last_update_date,
         deprecated = ce_update.deprecated,
         status = ce_update.status,
         code_value = ce_update.code_value,
         CODE_VALUE_EN = ce_update.CODE_VALUE_EN,          
         entry_source = ce_update.entry_source,
         country = ce_update.country,
         --code_value_parent_code = ce_update.code_value_parent_code,
         display_order = ce_update.display_order,
         source = ce_update.source
   WHEN NOT MATCHED
   THEN
   INSERT
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
    VALUES
                           (
                            code_value_id_seq.NEXTVAL,
                            0,
                            ce_update.create_by,
                            ce_update.creation_date,
                            ce_update.last_update_by,
                            ce_update.last_update_date,
                            ce_update.deprecated,
                            ce_update.status,
                            ce_update.code,
                            ce_update.code_value,
                            ce_update.CODE_VALUE_EN,          
                            ce_update.cs_id,
                            ce_update.display_order,
                            ce_update.source,
                            ce_update.entry_source,
                            ce_update.country,
                            ce_update.ref_entry_code
                            )  ;


   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 9);
   COMMIT;

   -- 2.2)   for common code unique key is entry_code , category_code , ref_entry_code : delete
   -- update code_value to deleted if not found in common_code_category_entry
   UPDATE   code_value CV
   SET
            last_update_by = 'SYSTEM',
            last_update_date = CURRENT_TIMESTAMP,
            deprecated = 'Y',
            status = 'DELETED'
   WHERE   CV.code_set_value_id IN
                  ( SELECT   id
                    FROM   code_set
                    WHERE   code IN ('SOURCE_SEC_TYPE','SOURCE_CMS_SEC_TYPE_MAP','FAC_RATE','LOS_ROLE_ACCESS','STATE', 'AA_CAR_CODE_FLAG','FAC_SUB_PROD_RELATION','SUB_PRODUCT_GROUP_MAPPING','27A','ID_TYPE','OCCUP_TYPE','BUSINESS_TYPE_1','BUSINESS_TYPE_2','56') AND source = 'CMS')
   AND CV.source = 'CMS'
   AND CV.deprecated = 'N'
   AND NOT EXISTS
   (SELECT   '1'
   FROM   common_code_category_entry ce, code_set cs
   WHERE    ce.entry_code = CV.code
            AND ce.category_code = cs.code
            AND CV.code_set_value_id = cs.id
            AND ce.ref_entry_code = CV.code_value_parent_code
            AND ce.category_code IN ('SOURCE_SEC_TYPE','SOURCE_CMS_SEC_TYPE_MAP','FAC_RATE','LOS_ROLE_ACCESS','STATE', 'AA_CAR_CODE_FLAG','FAC_SUB_PROD_RELATION','SUB_PRODUCT_GROUP_MAPPING','27A','ID_TYPE','OCCUP_TYPE','BUSINESS_TYPE_1','BUSINESS_TYPE_2','56')
            AND cs.source = 'CMS'
            AND CV.source = 'CMS'
            AND CV.deprecated = 'N'
    );


   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 10);
   COMMIT;


   -- 3.1)   for common code unique key is entry_code  , category_code , entry_name , ref_entry_code ; insert / update
   MERGE INTO   code_value
        USING   (SELECT
                          'SYSTEM' AS create_by,
                          CURRENT_TIMESTAMP AS creation_date,
                          'SYSTEM' AS last_update_by,
                          CURRENT_TIMESTAMP AS last_update_date,
                          decode (ce.active_status , '0' ,'Y' , 'N')   AS deprecated,
                          decode (ce.active_status , '0' ,'DELETED' , 'ACTIVE')    AS status,
                          entry_name AS code_value,
                          LOCALE_NAME1 as CODE_VALUE_EN,                          
                          entry_source AS entry_source,
                          country,
                          999 AS display_order,
                          'CMS' AS source,
                          cs.id AS cs_id,
                          ref_entry_code,
                          entry_code AS code
                   FROM   common_code_category_entry ce, code_set cs
                   WHERE   ce.category_code = cs.code
                   AND ce.category_code IN ('FAC_PRODUCT_MAP'))
                ce_update
           ON   (code_value.code = ce_update.code
                 AND code_value.code_set_value_id = ce_update.cs_id
                 AND code_value.code_value_parent_code =  ce_update.ref_entry_code
                 AND code_value.code_value =  ce_update.code_value )
   WHEN MATCHED
   THEN
      UPDATE SET
         version_time = 1,
         last_update_by = ce_update.last_update_by,
         last_update_date = ce_update.last_update_date,
         deprecated = ce_update.deprecated,
         status = ce_update.status,
         --code_value = ce_update.code_value,
         entry_source = ce_update.entry_source,
         country = ce_update.country,
         --code_value_parent_code = ce_update.code_value_parent_code,
         display_order = ce_update.display_order,
         source = ce_update.source
   WHEN NOT MATCHED
   THEN
   INSERT
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
    VALUES
                           (
                            code_value_id_seq.NEXTVAL,
                            0,
                            ce_update.create_by,
                            ce_update.creation_date,
                            ce_update.last_update_by,
                            ce_update.last_update_date,
                            ce_update.deprecated,
                            ce_update.status,
                            ce_update.code,
                            ce_update.code_value,
                            ce_update.CODE_VALUE_EN,
                            ce_update.cs_id,
                            ce_update.display_order,
                            ce_update.source,
                            ce_update.entry_source,
                            ce_update.country,
                            ce_update.ref_entry_code
                            )  ;

   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 11);
   COMMIT;

   -- 3.2)   for common code unique key is entry_code  , category_code , entry_name , ref_entry_code ; delete
   -- update code_value to deleted if not found in common_code_category_entry
   UPDATE   code_value CV
      SET
            last_update_by = 'SYSTEM',
            last_update_date = CURRENT_TIMESTAMP,
            deprecated = 'Y',
            status = 'DELETED'
    WHERE   CV.code_set_value_id IN
                  ( SELECT   id
                    FROM   code_set
                    WHERE   code IN ('FAC_PRODUCT_MAP') AND source = 'CMS')
    AND CV.source = 'CMS'
    AND CV.deprecated = 'N'
    AND NOT EXISTS
          (SELECT   '1'
             FROM   common_code_category_entry ce, code_set cs
            WHERE       ce.entry_code = CV.code
                    AND ce.entry_name = CV.code_value
                    AND ce.category_code = cs.code
                    AND CV.code_set_value_id = cs.id
                    AND ce.ref_entry_code = CV.code_value_parent_code
                    AND ce.category_code IN ('FAC_PRODUCT_MAP')
                    AND cs.source = 'CMS'
                    AND CV.source = 'CMS'
                    AND CV.deprecated = 'N');


   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 12);
   COMMIT;



   -- update code value parent id
   UPDATE   code_value c
      SET   code_value_parent_id =
               (  SELECT   id
                  FROM   code_value p
                  WHERE   p.code = c.code_value_parent_code
                  AND p.code_set_value_id IN
                                  ( SELECT   id
                                    FROM   code_set
                                    WHERE   code = '31' AND master_id IS NULL))
    WHERE   c.code_value_parent_code IS NOT NULL
            AND c.code_set_value_id IN
                     (SELECT   id
                        FROM   code_set
                       WHERE   code = '54' AND master_id IS NULL);

   UPDATE   code_value c
      SET   code_value_parent_id =
               (SELECT   id
                  FROM   code_value p
                 WHERE   p.code = c.code_value_parent_code
                         AND p.code_set_value_id IN
                                  (SELECT   id
                                     FROM   code_set
                                    WHERE       code = '31'
                                            AND master_id IS NOT NULL
                                            AND status = 'ACTIVE'))
    WHERE   c.code_value_parent_code IS NOT NULL
            AND c.code_set_value_id IN
                     (SELECT   id
                        FROM   code_set
                       WHERE       code = '54'
                               AND master_id IS NOT NULL
                               AND status = 'ACTIVE');

   COMMIT;

   UPDATE   code_value c
      SET   code_value_parent_id =
               (SELECT   id
                  FROM   code_value p
                 WHERE   p.code = c.code_value_parent_code
                         AND p.code_set_value_id IN
                                  (SELECT   id
                                     FROM   code_set
                                    WHERE   code = '54' AND master_id IS NULL))
    WHERE   c.code_value_parent_code IS NOT NULL
            AND c.code_set_value_id IN
                     (SELECT   id
                        FROM   code_set
                       WHERE   code = 'SOURCE_CMS_SEC_TYPE_MAP'
                               AND master_id IS NULL);

   UPDATE   code_value c
      SET   code_value_parent_id =
               (SELECT   id
                  FROM   code_value p
                 WHERE   p.code = c.code_value_parent_code
                         AND p.code_set_value_id IN
                                  (SELECT   id
                                     FROM   code_set
                                    WHERE       code = '54'
                                            AND master_id IS NOT NULL
                                            AND status = 'ACTIVE'))
    WHERE   c.code_value_parent_code IS NOT NULL
            AND c.code_set_value_id IN
                     (SELECT   id
                        FROM   code_set
                       WHERE       code = 'SOURCE_CMS_SEC_TYPE_MAP'
                               AND master_id IS NOT NULL
                               AND status = 'ACTIVE');

   COMMIT;

   UPDATE   code_value c
      SET   code_value_parent_id =
               (SELECT   id
                  FROM   code_value p
                 WHERE   p.code = c.code_value_parent_code
                         AND p.code_set_value_id IN
                                  (SELECT   id
                                     FROM   code_set
                                    WHERE   code = 'VEHICLE_BRAND'
                                            AND master_id IS NULL))
    WHERE   c.code_value_parent_code IS NOT NULL
            AND c.code_set_value_id IN
                     (SELECT   id
                        FROM   code_set
                       WHERE   code = 'MODEL' AND master_id IS NULL);

   UPDATE   code_value c
      SET   code_value_parent_id =
               (SELECT   id
                  FROM   code_value p
                 WHERE   p.code = c.code_value_parent_code
                         AND p.code_set_value_id IN
                                  (SELECT   id
                                     FROM   code_set
                                    WHERE       code = 'VEHICLE_BRAND'
                                            AND master_id IS NOT NULL
                                            AND status = 'ACTIVE'))
    WHERE   c.code_value_parent_code IS NOT NULL
            AND c.code_set_value_id IN
                     (SELECT   id
                        FROM   code_set
                       WHERE       code = 'MODEL'
                               AND master_id IS NOT NULL
                               AND status = 'ACTIVE');

   COMMIT;

   UPDATE   code_value c
      SET   code_value_parent_id =
               (SELECT   id
                  FROM   code_value p
                 WHERE   p.code = c.code_value_parent_code
                         AND p.code_set_value_id IN
                                  (SELECT   id
                                     FROM   code_set
                                    WHERE   code = 'STATE'
                                            AND master_id IS NULL)
                         AND ROWNUM = 1)
    WHERE   c.code_value_parent_code IS NOT NULL
            AND c.code_set_value_id IN
                     (SELECT   id
                        FROM   code_set
                       WHERE   code = 'DISTRICT' AND master_id IS NULL);

   UPDATE   code_value c
      SET   code_value_parent_id =
               (SELECT   id
                  FROM   code_value p
                 WHERE   p.code = c.code_value_parent_code
                         AND p.code_set_value_id IN
                                  (SELECT   id
                                     FROM   code_set
                                    WHERE       code = 'STATE'
                                            AND master_id IS NOT NULL
                                            AND status = 'ACTIVE')
                         AND ROWNUM = 1)
    WHERE   c.code_value_parent_code IS NOT NULL
            AND c.code_set_value_id IN
                     (SELECT   id
                        FROM   code_set
                       WHERE       code = 'DISTRICT'
                               AND master_id IS NOT NULL
                               AND status = 'ACTIVE');

   COMMIT;

   UPDATE   code_value c
      SET   code_value_parent_id =
               (SELECT   id
                  FROM   code_value p
                 WHERE   p.code = c.code_value_parent_code
                         AND p.code_set_value_id IN
                                  (SELECT   id
                                     FROM   code_set
                                    WHERE   code = 'DISTRICT'
                                            AND master_id IS NULL))
    WHERE   c.code_value_parent_code IS NOT NULL
            AND c.code_set_value_id IN
                     (SELECT   id
                        FROM   code_set
                       WHERE   code = 'MUKIM' AND master_id IS NULL);

   UPDATE   code_value c
      SET   code_value_parent_id =
               (SELECT   id
                  FROM   code_value p
                 WHERE   p.code = c.code_value_parent_code
                         AND p.code_set_value_id IN
                                  (SELECT   id
                                     FROM   code_set
                                    WHERE       code = 'DISTRICT'
                                            AND master_id IS NOT NULL
                                            AND status = 'ACTIVE'))
    WHERE   c.code_value_parent_code IS NOT NULL
            AND c.code_set_value_id IN
                     (SELECT   id
                        FROM   code_set
                       WHERE       code = 'MUKIM'
                               AND master_id IS NOT NULL
                               AND status = 'ACTIVE');

   COMMIT;

   UPDATE   code_value c
      SET   code_value_parent_id =
               (SELECT   id
                  FROM   code_value p
                 WHERE   p.code = c.code_value_parent_code
                         AND p.code_set_value_id IN
                                  (SELECT   id
                                     FROM   code_set
                                    WHERE   code = 'STOCK_EXCHANGE'
                                            AND master_id IS NULL))
    WHERE   c.code_value_parent_code IS NOT NULL
            AND c.code_set_value_id IN
                     (SELECT   id
                        FROM   code_set
                       WHERE   code = 'SHARE_STATUS' AND master_id IS NULL);

   UPDATE   code_value c
      SET   code_value_parent_id =
               (SELECT   id
                  FROM   code_value p
                 WHERE   p.code = c.code_value_parent_code
                         AND p.code_set_value_id IN
                                  (SELECT   id
                                     FROM   code_set
                                    WHERE       code = 'STOCK_EXCHANGE'
                                            AND master_id IS NOT NULL
                                            AND status = 'ACTIVE'))
    WHERE   c.code_value_parent_code IS NOT NULL
            AND c.code_set_value_id IN
                     (SELECT   id
                        FROM   code_set
                       WHERE       code = 'SHARE_STATUS'
                               AND master_id IS NOT NULL
                               AND status = 'ACTIVE');

   COMMIT;

   UPDATE   code_value c
      SET   code_value_parent_id =
               (SELECT   id
                  FROM   code_value p
                 WHERE   p.code = c.code_value_parent_code
                         AND p.code_set_value_id IN
                                  (SELECT   id
                                     FROM   code_set
                                    WHERE   code = 'STOCK_EXCHANGE'
                                            AND master_id IS NULL))
    WHERE   c.code_value_parent_code IS NOT NULL
            AND c.code_set_value_id IN
                     (SELECT   id
                        FROM   code_set
                       WHERE   code = 'BOARD_TYPE' AND master_id IS NULL);

   UPDATE   code_value c
      SET   code_value_parent_id =
               (SELECT   id
                  FROM   code_value p
                 WHERE   p.code = c.code_value_parent_code
                         AND p.code_set_value_id IN
                                  (SELECT   id
                                     FROM   code_set
                                    WHERE       code = 'STOCK_EXCHANGE'
                                            AND master_id IS NOT NULL
                                            AND status = 'ACTIVE'))
    WHERE   c.code_value_parent_code IS NOT NULL
            AND c.code_set_value_id IN
                     (SELECT   id
                        FROM   code_set
                       WHERE       code = 'BOARD_TYPE'
                               AND master_id IS NOT NULL
                               AND status = 'ACTIVE');



   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 13);
   COMMIT;

   -- update the branch from deleted to active if reinstate from cms
   UPDATE   code_value CV
      SET
            (version_time,
            last_update_by,
            last_update_date,
            deprecated,
            status,
            code_value,
            entry_source,
            country,
            code_value_parent_code,
            display_order,
            source
            ) =
               (SELECT   0,
                     'SYSTEM',
                         CURRENT_TIMESTAMP,
                         (CASE ce.active_status
                             WHEN '0' THEN 'Y'
                             ELSE 'N'
                          END),
                         (CASE ce.active_status
                             WHEN '0' THEN 'DELETED'
                             ELSE 'ACTIVE'
                          END),
                         entry_name,
                         entry_source,
                         country,
                         ref_entry_code,
                         999,
                     'CMS'
                  FROM   common_code_category_entry ce, code_set cs
                 WHERE       ce.entry_code = CV.code
                         AND ce.category_code = cs.code
                         AND CV.code_set_value_id = cs.id
                         AND ce.category_code = '40'
                         AND cs.code = '40')
    WHERE   CV.source = 'CMS' AND CV.deprecated = 'Y'
            AND--ce.category_code in  ( select category_code from sml_common_code_req ) and
               EXISTS
                  (SELECT   '1'
                     FROM   code_value cv1, code_set cs1
                    WHERE       CV.code = cv1.code
                            AND CV.code_set_value_id = cv1.code_set_value_id
                            AND cv1.code_set_value_id = cs1.id
                            AND cs1.code = '40'
                            AND--cs1.code in  ( select category_code from sml_common_code_req ) and
                               cs1.source = 'CMS'
                            AND cv1.source = 'CMS'
                            AND cv1.deprecated = 'Y');



   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 14);
   COMMIT;

   --For common code that has issue in merging data
    MERGE INTO   code_value
        USING   (SELECT   0 AS version_time,
                      'SYSTEM' AS last_update_by,
                          CURRENT_TIMESTAMP AS last_update_date,
                          (CASE ce.active_status
                              WHEN '0' THEN 'Y'
                              ELSE 'N'
                           END)
                             AS deprecated,
                          (CASE ce.active_status
                              WHEN '0' THEN 'DELETED'
                              ELSE 'ACTIVE'
                           END)
                             AS status,
                          entry_name AS code_value,
                          entry_source AS entry_source,
                          country,
                          999 AS display_order,
                      'CMS' AS source,
                          cs.id AS cs_id,
                          ref_entry_code,
                          entry_code AS code
                   FROM   common_code_category_entry ce, code_set cs
                  WHERE   ce.category_code = cs.code
                          AND ce.category_code IN ('RANK'))
                ce_update
           ON   (code_value.code = ce_update.code
                 AND code_value.code_set_value_id = ce_update.cs_id)
   WHEN MATCHED
   THEN
      UPDATE SET
         version_time = ce_update.version_time,
         last_update_by = ce_update.last_update_by,
         last_update_date = ce_update.last_update_date,
         deprecated = ce_update.deprecated,
         status = ce_update.status,
         code_value = ce_update.code_value,
         entry_source = ce_update.entry_source,
         country = ce_update.country,
         display_order = ce_update.display_order,
         source = ce_update.source
      WHERE   code_value.status = 'ACTIVE';



   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 15);
   COMMIT;

   INSERT INTO code_value (id,
                           version_time,
                           create_by,
                           creation_date,
                           last_update_by,
                           last_update_date,
                           deprecated,
                           status,
                           code,
                           code_value,
                           code_set_value_id,
                           display_order,
                           source,
                           entry_source,
                           country,
                           code_value_parent_code)
      (SELECT   code_value_id_seq.NEXTVAL,
                0,
            'SYSTEM',
                CURRENT_TIMESTAMP,
            'SYSTEM',
                CURRENT_TIMESTAMP,
                (CASE active_status WHEN '0' THEN 'Y' ELSE 'N' END),
                (CASE active_status WHEN '0' THEN 'DELETED' ELSE 'ACTIVE' END),
                entry_code,
                entry_name,
                cs.id,
                999,
            'CMS',
                entry_source,
                country,
                ref_entry_code
         FROM      common_code_category_entry ce
                INNER JOIN
                   code_set cs
                ON cs.code = ce.category_code
        WHERE   ce.category_code IN ('RANK') AND cs.source = 'CMS'
                AND NOT EXISTS
                      (SELECT   '1'
                         FROM   code_value CV
                        WHERE   CV.code_set_value_id = cs.id
                                AND ce.entry_code = CV.code
                                AND CV.source = 'CMS'));



   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 16);
   COMMIT;

   -- update code_value to deleted if not found in common_code_category_entry
   UPDATE   code_value CV
      SET
            (version_time,
            last_update_by,
            last_update_date,
            deprecated,
            status
            ) =
               (SELECT   0,
                     'SYSTEM',
                         CURRENT_TIMESTAMP,
                     'Y',
                     'DELETED'
                  FROM   DUAL)
    WHERE   CV.code_set_value_id IN
                  (SELECT   id
                     FROM   code_set
                    WHERE   code IN ('RANK') AND source = 'CMS')
            AND CV.source = 'CMS'
            AND CV.deprecated = 'N'
            AND NOT EXISTS
                  (SELECT   '1'
                     FROM   common_code_category_entry ce, code_set cs
                    WHERE       ce.entry_code = CV.code
                            AND ce.category_code = cs.code
                            AND CV.code_set_value_id = cs.id
                            AND ce.category_code IN ('RANK')
                            AND cs.source = 'CMS'
                            AND CV.source = 'CMS'
                            AND CV.deprecated = 'N');



   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 17);
   COMMIT;

   -- delete the existing record with different last updated date
   DELETE FROM   sml_host_product_type l
         WHERE   EXISTS
                    (SELECT   1
                       FROM   host_product_type h
                      WHERE      NVL (l.loan_type, '0')
                              || NVL (l.currency, '1')
                              || NVL (l.sptf_loan_type, '2')
                              || NVL (l.concept_code, '3')
                             -- || NVL (l.interest_base, '4')
                              || NVL (l.source, '5') =
                                    NVL (h.loan_type, '0')
                                 || NVL (h.currency, '1')
                                 || NVL (h.sptf_loan_type, '2')
                                 || NVL (h.concept_code, '3')
                               --  || NVL (h.interest_base, '4')
                                 || NVL (h.source, '5')
                              AND l.last_updated_date <> h.last_updated_date);

   COMMIT;

   -- merge the record from cms host table
   MERGE INTO   sml_host_product_type l
        USING   (SELECT   loan_type,
                          descr,
                          group_code,
                          group_desc,
                          commercial_retail_ind,
                          currency,
                          min_int_rate,
                          max_int_rate,
                          rate_floor,
                          rate_ceiling,
                          staff_ind,
                          act_ind,
                          tier_loan_ind,
                          sptf_loan_type,
                          prime_rate_num,
                          max_loan_tenure,
                          min_loan_tenure,
                          source,
                          status,
                          interest_base,
                          concept_code,
                          product_group,
                          dealer_product_ind,
                          product_limit,
                          product_expiry_date,
                          product_age_limit,
                          payment_frequency,
                          payment_freq_code,
                          payment_code,
                          gratuity_financing,
                          interest_mode,
                          promo_package_code,
                          rebate_method_bank,
                          cal_installment_ind,
                          max_loan_tenure_code,
                          -- todo: add the following
                          -- maximum loan tenor
                          -- maximum loan tenor code
                          -- interest payment frequency
                          -- interest payment frequency code
                          last_updated_date
                   FROM   host_product_type) h
           ON   (   NVL (l.loan_type, '0')
                 || NVL (l.currency, '1')
                 || NVL (l.sptf_loan_type, '2')
                 || NVL (l.concept_code, '3')
                 --|| NVL (l.interest_base, '4')
                 || NVL (l.source, '5') =
                       NVL (h.loan_type, '0')
                    || NVL (h.currency, '1')
                    || NVL (h.sptf_loan_type, '2')
                    || NVL (h.concept_code, '3')
                    --|| NVL (h.interest_base, '4')
                    || NVL (h.source, '5'))
   WHEN MATCHED
   THEN
      UPDATE SET
         descr = h.descr,
         group_code = h.group_code,
         group_desc = h.group_desc,
         commercial_retail_ind = h.commercial_retail_ind,
         min_int_rate = h.min_int_rate,
         max_int_rate = h.max_int_rate,
         rate_floor = h.rate_floor,
         rate_ceiling = h.rate_ceiling,
         staff_ind = h.staff_ind,
         act_ind = h.act_ind,
         tier_loan_ind = h.tier_loan_ind,
         prime_rate_num = h.prime_rate_num,
         max_loan_tenure = h.max_loan_tenure,
         max_loan_tenure_code = h.max_loan_tenure_code,
         min_loan_tenure = h.min_loan_tenure,
         status = h.status,
         product_group = h.product_group,
         dealer_product_ind = h.dealer_product_ind,
         product_limit = h.product_limit,
         product_expiry_date = h.product_expiry_date,
         product_age_limit = h.product_age_limit,
         payment_frequency = h.payment_frequency,
         payment_freq_code = h.payment_freq_code,
         payment_code = h.payment_code,
         gratuity_financing = h.gratuity_financing,
         interest_mode = h.interest_mode,
         promo_package_code = h.promo_package_code,
         rebate_method_bank = h.rebate_method_bank,
         cal_installment_ind = h.cal_installment_ind,

         -- todo: add the following
         -- maximum loan tenor
         -- maximum loan tenor code
         -- interest payment frequency
         -- interest payment frequency code
         last_updated_date = h.last_updated_date,
         interest_base = h.interest_base
   WHEN NOT MATCHED
   THEN
      INSERT              (loan_type,
                           descr,
                           group_code,
                           group_desc,
                           commercial_retail_ind,
                           currency,
                           min_int_rate,
                           max_int_rate,
                           rate_floor,
                           rate_ceiling,
                           staff_ind,
                           act_ind,
                           tier_loan_ind,
                           sptf_loan_type,
                           prime_rate_num,
                           max_loan_tenure,
                           min_loan_tenure,
                           source,
                           status,
                           interest_base,
                           concept_code,
                           product_group,
                           dealer_product_ind,
                           product_limit,
                           product_expiry_date,
                           product_age_limit,
                           payment_frequency,
                           payment_freq_code,
                           payment_code,
                           gratuity_financing,
                           interest_mode,
                           promo_package_code,
                           rebate_method_bank,
                           cal_installment_ind,
                           max_loan_tenure_code,
                           -- todo: add the following
                           -- maximum loan tenor
                           -- maximum loan tenor code
                           -- interest payment frequency
                           -- interest payment frequency code
                           last_updated_date
                           )
          VALUES   (h.loan_type,
                    h.descr,
                    h.group_code,
                    h.group_desc,
                    h.commercial_retail_ind,
                    h.currency,
                    h.min_int_rate,
                    h.max_int_rate,
                    h.rate_floor,
                    h.rate_ceiling,
                    h.staff_ind,
                    h.act_ind,
                    h.tier_loan_ind,
                    h.sptf_loan_type,
                    h.prime_rate_num,
                    h.max_loan_tenure,
                    h.min_loan_tenure,
                    h.source,
                    h.status,
                    h.interest_base,
                    h.concept_code,
                    h.product_group,
                    h.dealer_product_ind,
                    h.product_limit,
                    h.product_expiry_date,
                    h.product_age_limit,
                    h.payment_frequency,
                    h.payment_freq_code,
                    h.payment_code,
                    h.gratuity_financing,
                    h.interest_mode,
                    h.promo_package_code,
                    h.rebate_method_bank,
                    h.cal_installment_ind,
                    h.max_loan_tenure_code,
                    -- todo: add the following
                    -- maximum loan tenor
                    -- maximum loan tenor code
                    -- interest payment frequency
                    -- interest payment frequency code
                    h.last_updated_date
                    );

   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 18);
   COMMIT;

   -- delete the existing record with different last updated date
   DELETE FROM   sml_host_facility_type l
         WHERE   EXISTS
                    (SELECT   1
                       FROM   host_facility_type h
                      WHERE   NVL (l.facility_code, '0')
                              || NVL (l.account_type, '1') =
                                 NVL (h.facility_code, '0')
                                 || NVL (h.account_type, '1')
                              AND l.last_updated_date <> h.last_updated_date);

   COMMIT;

   -- merge the record from cms host table
   MERGE INTO   sml_host_facility_type l
        USING   (SELECT   facility_code,
                          loan_type,
                          currency,
                          revolving_ind,
                          rev_os_bal_orgamt,
                          descr,
                          account_type,
                          status,
                          last_updated_date
                   FROM   host_facility_type) h
           ON   (NVL (l.facility_code, '0') || NVL (l.account_type, '1') =
                    NVL (h.facility_code, '0') || NVL (h.account_type, '1'))
   WHEN MATCHED
   THEN
      UPDATE SET
         loan_type = h.loan_type,
         currency = h.currency,
         revolving_ind = h.revolving_ind,
         rev_os_bal_orgamt = h.rev_os_bal_orgamt,
         descr = h.descr,
         status = h.status,
         last_updated_date = h.last_updated_date
   WHEN NOT MATCHED
   THEN
      INSERT              (facility_code,
                           loan_type,
                           currency,
                           revolving_ind,
                           rev_os_bal_orgamt,
                           descr,
                           account_type,
                           status,
                           last_updated_date)
          VALUES   (h.facility_code,
                    h.loan_type,
                    h.currency,
                    h.revolving_ind,
                    h.rev_os_bal_orgamt,
                    h.descr,
                    h.account_type,
                    h.status,
                    h.last_updated_date);

   COMMIT;

   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 19);
   COMMIT;

   -- merge the record from sml_host_product_type into sml_product
   MERGE INTO   sml_product p
        USING   (SELECT   hft.facility_code,
                          hpt.loan_type,
                          hpt.min_int_rate,
                          hpt.max_int_rate,
                          hpt.rate_floor,
                          hpt.rate_ceiling,
                          hpt.payment_code
                   FROM      sml_host_product_type hpt
                          INNER JOIN
                             sml_host_facility_type hft
                          ON hft.loan_type = hpt.loan_type
                             AND hft.currency = hpt.currency
                  WHERE       hpt.group_code IS NOT NULL
                          AND hpt.loan_type IS NOT NULL
                          AND hpt.min_int_rate IS NOT NULL
                          AND hpt.max_int_rate IS NOT NULL
                          --AND hpt.rate_floor IS NOT NULL
                          --AND hpt.rate_ceiling IS NOT NULL
                          AND hpt.payment_code IS NOT NULL) h
           ON   (p.code = h.facility_code AND p.product_code = h.loan_type)
   WHEN MATCHED
   THEN
      UPDATE SET
         p.min_int_rate = h.min_int_rate,
         p.max_int_rate = h.max_int_rate,
         p.rate_floor = h.rate_floor,
         p.rate_ceiling = h.rate_ceiling,
         p.payment_code = h.payment_code;

   si_log_proc_time ('PROC_UPDATE_CODE_SET_VALUE', 'CLOS', 20);
   COMMIT;

END;


begin
  proc_update_code_set_value();
end;

SELECT * FROM code_value ORDER BY last_update_date DESC ;

SELECT * FROM common_code_category_entry ce
WHERE
  ce.category_code IN
          (-- 1.base on special columns ;
             -- key is entry_code , category_code , ref_entry_code
            'APPROVAL_EXCEPTIONAL',
            'EXCEPTIONAL_APPROVAL_FACILITY','EXCEPTIONAL_APPROVAL_AA'
            ) ;


select * from code_set where status = 'ACTIVE' and code = 'EXCEPTIONAL_APPROVAL_AA';
select * from code_value where code_set_value_id = 155;