create or replace NONEDITIONABLE PROCEDURE DOCGEN_XML(
    output       OUT TYPES.cursor_type,
    in_docgen_id IN NUMBER
) AS 
BEGIN
    OPEN output FOR
    SELECT
        XMLELEMENT(
            "document",
            (
                SELECT
                    XMLELEMENT(
                        "application",
                        --  DOCUMENT/ APPLICATION / ...
                        XMLELEMENT("applicationreferenceno", ca.app_ref_no),
                        XMLELEMENT("applicationtype",ca.app_typ),
                        XMLELEMENT("bookbranchcode", ca.book_br_code),
                        XMLELEMENT("bookbranchcodedesc", (select description from LOS_SA_BR_STRUC_BR where child_br_code = ca.book_br_code and ROWNUM = 1)),
                        XMLELEMENT("grandtotalamountformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("applicationstatus", wf.app_status),
                        XMLELEMENT("applicationstatusdesc", f_get_cce_value('APP_STATUS', wf.app_status)),
                        XMLELEMENT("approveddate", f_docgen_th_date((select complete_date from los_wf_task_archived where app_id = ca.id and app_status = '1STAP'))),
                        XMLELEMENT("branchname", (select description from LOS_SA_BR_STRUC_BR where child_br_code = ca.book_br_code and ROWNUM = 1)),
                        XMLELEMENT("combotoapprefnodesc", (SELECT 'combotoapprefnodesc' FROM dual)),
                        XMLELEMENT("holderdate17", f_docgen_th_date((select complete_date from los_wf_task_archived where app_id = ca.id and app_status = '1STRJ'))),
                        XMLELEMENT("resubmitappno", ca.resubmit_app_no),
                        XMLELEMENT("reusedocreason", ca.REUSE_DOC_REASON),
                        XMLELEMENT("wfversion", wf.wf_version),
                        XMLELEMENT("referralstaffname", ca.REFERRAL_STAFF_NAME),
                        XMLELEMENT("referralstaffno", ca.REFERRAL_STAFF_NO),
                        XMLELEMENT("requestnature", ca.req_nature),
                        XMLELEMENT("requestnaturedesc", f_get_cce_value('NATURE_REQUEST', ca.req_nature)),
                        XMLELEMENT("salescontactnumber", ca.SALES_CONTACT_NO),
                        XMLELEMENT("salesdesc", f_get_cce_value('CHANNEL', ca.sales)),
                        XMLELEMENT("salesstaffcode", ca.SALES_STAFF_CODE),
                        XMLELEMENT("salesstaffname", ca.SALES_STAFF_NAME),
                        XMLELEMENT("allapplicantname",(SELECT 'allapplicantname' FROM dual)),
                        XMLELEMENT("officernamegendoc", officer.surname),
                        XMLELEMENT("officerphonegendoc", officer.office_tel),
                        XMLELEMENT("applicationdate",(SELECT 'applicationdate' FROM dual)),
                        XMLELEMENT("branchcode", ca.br_code),
                        XMLELEMENT("sbbranchcode", (SELECT 'sbbranchcode' FROM dual)), 

                        -- DOCUMENT/ APPLICATION / CUSTOMER / ..  
                        (
                            SELECT
                                XMLELEMENT(
                                    "customer",
                                    XMLELEMENT("thaisalutationcodedesc", f_get_cce_value('SALUTATION', indv.th_salu_code)),
                                    XMLELEMENT("thainame", indv.th_name_line_2),
                                    XMLELEMENT("thaisurname", indv.th_name_line_1),
                                    XMLELEMENT("applywithccflag", indv.APPLY_WITH_CC_FLAG),
                                    XMLELEMENT("birthdateformatted", F_DOCGEN_TH_DATE(indv.birth_date)),
                                    XMLELEMENT("bonusyearlyformattedwithdecimal", indv.bonus_year),
                                    XMLELEMENT("businesssubtypedesc", f_get_cce_value('BUSINESS_SUB_TYPE', indv.BUSINESS_SUB_TYPE)),
                                    XMLELEMENT("businesstypedesc", f_get_cce_value('BUSINESS_TYPE', indv.BUSINESS_TYPE)),
                                    XMLELEMENT("excludeincomedebtflagcount", indv.EXCLUDE_IN_DEBT_FLAG),
                                    (
                                        SELECT XMLELEMENT(
                                            "addresslist",
                                            (
                                                SELECT XMLAGG(XMLELEMENT(
                                                    "address",
                                                    XMLELEMENT("addresstypecode", addr.addr_typ_code),
                                                    XMLELEMENT("addressline1", addr.addr_line_1),
                                                    XMLELEMENT("amphur", addr.amphur),
                                                    XMLELEMENT("provincedesc", f_get_cce_value('PROVINCE', addr.province)),
                                                    XMLELEMENT("road", addr.road),
                                                    XMLELEMENT("streetname", addr.street_name),
                                                    XMLELEMENT("tumbol", addr.tumbol),

                                                    --A
                                                    XMLELEMENT("buildingname", (SELECT 'buildingname' FROM dual) ),
                                                    XMLELEMENT("countrydesc", (SELECT 'countrydesc' FROM dual) ),
                                                    XMLELEMENT("floor", (SELECT 'floor' FROM dual) ),
                                                    XMLELEMENT("moo", (SELECT 'moo' FROM dual) ),
                                                    XMLELEMENT("postalcode", (SELECT 'postalcode' FROM dual) )

                                                ))
                                                FROM los_cif_addr addr where addr.cif_id = indv.cif_id
                                            )
                                        )
                                        FROM dual
                                    ),
                                    (
                                        SELECT XMLAGG(XMLELEMENT(
                                            "ccdetails",
                                            XMLELEMENT("campaigncode", cc.campaign_code),
                                            XMLELEMENT("campaignname", (SELECT 'dummy data' FROM dual)),
                                            XMLELEMENT("debitaccountname", cc.debit_acct_name),
                                            XMLELEMENT("debitaccountno", cc.debit_acct_no),
                                            XMLELEMENT("existcardcreditlimitformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                            XMLELEMENT("existcardnumber", (SELECT 'dummy data' FROM dual)),
                                            XMLELEMENT("mailingpreferencedesc", (SELECT 'dummy data' FROM dual)),
                                            XMLELEMENT("newcreditlimitformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                            XMLELEMENT("paymentmethod", (SELECT 'dummy data' FROM dual)),
                                            XMLELEMENT("producttypedesc", (SELECT 'dummy data' FROM dual)),
                                            XMLELEMENT("customersegmentdesc", (SELECT 'dummy data' FROM dual)),

                                            --A
                                            XMLELEMENT("approvedcreditlimitformattedwithdecimal", (SELECT 'approvedcreditlimitformattedwithdecimal' FROM dual)),
                                            XMLELEMENT("existproducttypedesc", (SELECT 'existproducttypedesc' FROM dual)),
                                            XMLELEMENT("productcode", (SELECT 'productcode' FROM dual)),
                                            XMLELEMENT("subproducttypedesc", (SELECT 'subproducttypedesc' FROM dual))
                                        ))
                                        FROM los_cc cc where cc.cif_id = indv.cif_id
                                    ),
                                    XMLELEMENT("contractempenddateformatted", f_docgen_th_date(indv.contract_emp_end_date)),
                                    XMLELEMENT("contractemployedflag", indv.contract_employed_flag),
                                    XMLELEMENT("contractempstartdateformatted", f_docgen_th_date(indv.contract_emp_start_date)),
                                    XMLELEMENT("currentemployercodedesc", f_get_cce_value('EMPLOYER', indv.cur_employ_code)),
                                    XMLELEMENT("email", indv.email),
                                    XMLELEMENT("emailstatementflag", indv.email_statement_flag),
                                    XMLELEMENT("employmentbiznaturedesc", f_get_cce_value('NATURE_BUSINESS', indv.emp_biz_nature)),
                                    XMLELEMENT("employmentfaxno", indv.emp_fax_no),
                                    XMLELEMENT("employmentmonth", indv.emp_month),
                                    XMLELEMENT("employmentname", indv.emp_name),
                                    XMLELEMENT("employmentoccupationdesc", f_get_cce_value('OCCUPATION', indv.emp_occupation)),
                                    XMLELEMENT("employmentstatus", indv.emp_status),
                                    XMLELEMENT("employmenttelephoneextno", indv.emp_tel_ext_no),
                                    XMLELEMENT("employmenttelephoneno", indv.emp_tel_no),
                                    XMLELEMENT("employmentyear", indv.emp_yr),
                                    XMLELEMENT("expirydateformatted", F_DOCGEN_TH_DATE(indv.id_expiry_date)),
                                    XMLELEMENT("exttelephoneno", indv.ext_phone_no),
                                    XMLELEMENT("hostcifno", indv.host_cif_no),
                                    XMLELEMENT("idissuectry1desc", f_get_cce_value('SCI_COUNTRY', indv.id_issue_ctry_1)),
                                    XMLELEMENT("idno1", indv.id_no_1),
                                    XMLELEMENT("idtype1desc", f_get_cce_value('ID_TYPE', indv.id_type_1)),
                                    XMLELEMENT("incomebankaccoutnumber", indv.in_bank_name),
                                    XMLELEMENT("incomebankname", f_get_cce_value('PAYROLL_BANK', indv.in_bank_name)),
                                    XMLELEMENT("incomebasicsalaryformattedwithdecimal", TO_CHAR(indv.in_basic_salary, 'fm999G999G999D00')),
                                    XMLELEMENT("incomeextraotherformattedwithdecimal", TO_CHAR(indv.in_extra_other, 'fm999G999G999D00')),
                                    XMLELEMENT("incomeotherincomeformattedwithdecimal", TO_CHAR(indv.in_other_income, 'fm999G999G999D00')),
                                    XMLELEMENT("incomesharedholderpercentformattedwithdecimal", indv.in_share_holder_percent),
                                    XMLELEMENT("incometotallastmthcreditacct1formattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("incometotallastmthcreditacct2formattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("incometypedesc", f_get_cce_value('INCOME_TYPE',indv.in_type)),
                                    XMLELEMENT("insidercodedesc", f_get_cce_value('INSIDER',indv.insider_code)),
                                    XMLELEMENT("issueddateformatted", F_DOCGEN_TH_DATE(indv.issued_date)),
                                    XMLELEMENT("lifetimeflag", NVL(indv.life_time_flag,'N')),
                                    XMLELEMENT("mailingpreferencedesc", f_get_cce_value('MAIL_PREFERENCE', indv.mailing_preference)),
                                    XMLELEMENT("maritalstatus", indv.marital_status),
                                    XMLELEMENT("maritalstatusdesc", f_get_cce_value('MARITAL_STATUS', indv.marital_status)),
                                    XMLELEMENT("mobileno", indv.mobile_no),
                                    XMLELEMENT("nameline1", indv.name_line_1),
                                    XMLELEMENT("nameline2", indv.name_line_2),
                                    XMLELEMENT("nationality2desc", f_get_cce_value('NATIONALITY', indv.nationality2)),
                                    XMLELEMENT("nationalitydesc", f_get_cce_value('NATIONALITY', indv.nationality)),
                                    XMLELEMENT("placeofbirthdesc", f_get_cce_value('NATIONALITY', indv.birth_place)),
                                    XMLELEMENT("professionalcodedesc", f_get_cce_value('PROFFESIONAL', indv.proffesional)),
                                    XMLELEMENT("registerexttelephoneno", indv.reg_ext_phone_no),
                                    XMLELEMENT("registertelephoneno ", indv.reg_telephone_no),
                                    XMLELEMENT("residenttypedesc", f_get_cce_value('RESIDENT_TYP', indv.resident_typ)),
                                    XMLELEMENT("rmwealthflag", indv.rm_wealth_flag),
                                    XMLELEMENT("salutationcodedesc", f_get_cce_value('SALUTATION_EN', indv.salu_code)),
                                    XMLELEMENT("sourcefromcountrydesc", f_get_cce_value('NATIONALITY', indv.source_from_country)),
                                    XMLELEMENT("telephoneno", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("birthdate", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("idtype1", indv.id_type_1),
                                    XMLELEMENT("idno1_formatted", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("genderdesc", f_get_cce_value('GENDER', indv.gender)),
                                    XMLELEMENT("issueddate", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("expirydate", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("age", (SELECT 'age' FROM dual)),
                                    XMLELEMENT("mobileno", (SELECT 'mobileno' FROM dual)),
                                    XMLELEMENT("sameregisteraddressflag", indv.same_residence_add_flag),
                                    XMLELEMENT("residenttypedesc", f_get_cce_value('RESIDENT_TYP', indv.resident_typ)),
                                    XMLELEMENT("educationleveldesc", f_get_cce_value('EDUCATION_LEVEL', indv.education_level)),
                                    XMLELEMENT("noofdependent", indv.no_of_dependent),
                                    XMLELEMENT("spsalutationcodedesc", f_get_cce_value('SALUTATION', indv.sp_salu_code)),
                                    XMLELEMENT("spthainame", indv.sp_th_name),
                                    XMLELEMENT("spthaisurname", indv.sp_th_surname),
                                    XMLELEMENT("spidtypedesc", f_get_cce_value('ID_TYPE', indv.sp_id_typ)),
                                    XMLELEMENT("spidno", indv.sp_id_no),
                                    XMLELEMENT("spbirthdate", f_docgen_th_date(indv.sp_birth_date)),
                                    XMLELEMENT("sourceofassetdesc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("estimatedassetvaluedesc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("employmentstatusdesc", f_get_cce_value('EMPLOYMENT_STATUS', indv.emp_status)),
                                    XMLELEMENT("currentjobtitle", indv.cur_job_title),
                                    XMLELEMENT("employmentdept", indv.emp_dept),
                                    XMLELEMENT("employmentstaffid", indv.emp_staff_id),
                                    XMLELEMENT("empjointdatedesc", f_docgen_th_date(indv.tmb_join_date)),
                                    XMLELEMENT("workingaddrcopyfrom", indv.WORKING_ADDR_COPY_FROM),
                                    XMLELEMENT("employmenttelephonedirectno", indv.emp_tel_direct_no),
                                    XMLELEMENT("customerlevel", indv.cif_level),
                                    XMLELEMENT("employmentemail", indv.emp_email),
                                    XMLELEMENT("mobilenotwo", indv.mobile_no_2),
                                    XMLELEMENT("racedesc", f_get_cce_value('ETHNIC', indv.race)),

                                    --A
                                    XMLELEMENT("employmentfinaltotalincomeformattedwithdecimal", (SELECT 'employmentfinaltotalincomeformattedwithdecimal' FROM DUAL)),
                                    XMLELEMENT("employmentprovincedesc", (SELECT 'employmentprovincedesc' FROM DUAL)),
                                    XMLELEMENT("incomedeclaredformattedwithdecimal", (SELECT 'incomedeclaredformattedwithdecimal' FROM DUAL)),
                                    XMLELEMENT("selfemployincomeextratotalformattedwithdecimal", (SELECT 'selfemployincomeextratotalformattedwithdecimal' FROM DUAL)),
                                    XMLELEMENT("selfemployincometotalformattedwithdecimal", (SELECT 'selfemployincometotalformattedwithdecimal' FROM DUAL)),
                                    XMLELEMENT("spcurrentjobtitle", (SELECT 'spcurrentjobtitle' FROM DUAL)),
                                    XMLELEMENT("spengsalutationcodedesc", (SELECT 'spengsalutationcodedesc' FROM DUAL)),
                                    XMLELEMENT("spexpirydate", (SELECT 'spexpirydate' FROM DUAL)),
                                    XMLELEMENT("spmobileno", (SELECT 'spmobileno' FROM DUAL)),
                                    XMLELEMENT("spnoofdependent", (SELECT 'spnoofdependent' FROM DUAL)),
                                    XMLELEMENT("spouseage", (SELECT 'spouseage' FROM DUAL))
                                )
                            from los_cif_indv indv where indv.ca_id = ca.id and indv.cif_rel_code = 'M' and ROWNUM = 1
                        ),
                        --DOCUMENT / APPLICATION / COLLATERALLIST / .... 
                        (
                            SELECT XMLELEMENT(
                                "collaterallist",
                                (
                                    SELECT XMLAGG(XMLELEMENT(
                                        "collateral",
                                        XMLELEMENT("developercode", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("developercodedesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("developername", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("projectid", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("projectiddesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("projectname", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("purchasepriceformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("resaddprovincedesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("securitysubtypecodedesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("resaddamphur", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("resaddtumbol", (SELECT 'dummy data' FROM dual))     ,

                                        --A
                                        XMLELEMENT("builtupareaunit", (SELECT 'builtupareaunit' FROM dual))     ,
                                        XMLELEMENT("resaddbuilding", (SELECT 'resaddbuilding' FROM dual))     ,
                                        XMLELEMENT("resaddfloor", (SELECT 'resaddfloor' FROM dual))     ,
                                        XMLELEMENT("resaddmoo", (SELECT 'resaddmoo' FROM dual))     ,
                                        XMLELEMENT("resaddno", (SELECT 'resaddno' FROM dual))     ,
                                        XMLELEMENT("resaddroad", (SELECT 'resaddroad' FROM dual))     ,
                                        XMLELEMENT("resaddsoi", (SELECT 'resaddsoi' FROM dual))     ,
                                        XMLELEMENT("resaddzipcode", (SELECT 'resaddzipcode' FROM dual))     ,
                                        XMLELEMENT("totalsqwah", (SELECT 'totalsqwah' FROM dual))     ,
                                        XMLELEMENT("typebuildingmaterialdesc", (SELECT 'typebuildingmaterialdesc' FROM dual))

                                    ))
                                    FROM los_coll coll where coll.ca_id = ca.id
                                ) 
                            )
                            from dual
                        ), 
                        --DOCUMENT / APPLICATION / JOINCUSTOMERLIST / .... 
                        (
                            SELECT XMLELEMENT(
                                "jointcustomerlist",
                                (
                                    SELECT XMLAGG(XMLELEMENT(
                                        "customer",
                                        (
                                            SELECT XMLELEMENT(
                                                "ccdetails",
                                                XMLELEMENT("producttypedesc", (SELECT 'dummy data' FROM dual))
                                            )
                                            FROM dual
                                        ),
                                        (
                                            SELECT XMLELEMENT(
                                                "addresslist",
                                                (
                                                    SELECT XMLAGG(XMLELEMENT(
                                                        "address",
                                                        XMLELEMENT("addresstypecode", addr.addr_typ_code),
                                                        XMLELEMENT("addressline1", addr.addr_line_1),
                                                        XMLELEMENT("amphur", addr.amphur),
                                                        XMLELEMENT("provincedesc", f_get_cce_value('PROVINCE', addr.province)),
                                                        XMLELEMENT("road", addr.road),
                                                        XMLELEMENT("streetname", addr.street_name),
                                                        XMLELEMENT("tumbol", addr.tumbol),

                                                        --A
                                                        XMLELEMENT("buildingname", (SELECT 'buildingname' FROM dual)),
                                                        XMLELEMENT("countrydesc", (SELECT 'countrydesc' FROM dual)),
                                                        XMLELEMENT("employmenttelephoneextno", (SELECT 'employmenttelephoneextno' FROM dual)),
                                                        XMLELEMENT("employmenttelephoneno", (SELECT 'employmenttelephoneno' FROM dual)),
                                                        XMLELEMENT("exttelephoneno", (SELECT 'exttelephoneno' FROM dual)),
                                                        XMLELEMENT("floor", (SELECT 'floor' FROM dual)),
                                                        XMLELEMENT("moo", (SELECT 'moo' FROM dual)),
                                                        XMLELEMENT("postalcode", (SELECT 'postalcode' FROM dual)),
                                                        XMLELEMENT("birthdate", (SELECT 'birthdate' FROM dual)),
                                                        XMLELEMENT("registerexttelephoneno", (SELECT 'registerexttelephoneno' FROM dual)),
                                                        XMLELEMENT("registertelephoneno", (SELECT 'registertelephoneno' FROM dual)),
                                                        XMLELEMENT("residenttypedesc", (SELECT 'residenttypedesc' FROM dual)),
                                                        XMLELEMENT("telephoneno", (SELECT 'telephoneno' FROM dual))

                                                    ))
                                                    FROM los_cif_addr addr where addr.cif_id = indv.cif_id
                                                )
                                            )
                                            FROM dual
                                        ),
                                        XMLELEMENT("thaisalutationcodedesc", f_get_cce_value('SALUTATION', indv.th_salu_code)),
                                        XMLELEMENT("thainame", indv.th_name_line_2),
                                        XMLELEMENT("thaisurname", indv.th_name_line_1),
                                        XMLELEMENT("nameline1", indv.name_line_1),
                                        XMLELEMENT("nameline2", indv.name_line_2),
                                        XMLELEMENT("nationality2desc", f_get_cce_value('NATIONALITY', indv.nationality2)),
                                        XMLELEMENT("nationalitydesc", f_get_cce_value('NATIONALITY', indv.nationality)),
                                        XMLELEMENT("employmentfaxno", indv.emp_fax_no),
                                        XMLELEMENT("registertelephoneno", indv.reg_telephone_no),
                                        XMLELEMENT("registerexttelephoneno", indv.reg_ext_phone_no),
                                        XMLELEMENT("mobileno", indv.mobile_no),
                                        XMLELEMENT("telephoneno", indv.telephone_no),
                                        XMLELEMENT("employmenttelephoneno", indv.emp_tel_no),
                                        XMLELEMENT("employmenttelephoneextno", indv.emp_tel_ext_no),
                                        XMLELEMENT("employmenttelephonedirectno", indv.emp_tel_direct_no),

                                        --A
                                        XMLELEMENT("birthdate", (SELECT 'birthdate' FROM dual)),
                                        XMLELEMENT("idno1", indv.id_no_1), 
                                        XMLELEMENT("idno1_formatted", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("thaisalutationcodedesc", f_get_cce_value('SALUTATION', indv.th_salu_code)),
                                        XMLELEMENT("thainame", indv.th_name_line_2),
                                        XMLELEMENT("thaisurname", indv.th_name_line_1),

                                        XMLELEMENT("age", (SELECT 'age' FROM dual)),
                                        XMLELEMENT("birthdate", (SELECT 'birthdate' FROM dual)),
                                        XMLELEMENT("birthdateformatted", (SELECT 'birthdateformatted' FROM dual)),
                                        XMLELEMENT("bonusyearlyformattedwithdecimal", (SELECT 'bonusyearlyformattedwithdecimal' FROM dual)),
                                        
                                        XMLELEMENT("contractempenddateformatted", (SELECT 'contractempenddateformatted' FROM dual)),
                                        XMLELEMENT("contractempstartdateformatted", (SELECT 'contractempstartdateformatted' FROM dual)),
                                        XMLELEMENT("currentemployercodedesc", (SELECT 'currentemployercodedesc' FROM dual)),
                                        XMLELEMENT("currentjobtitle", (SELECT 'currentjobtitle' FROM dual)),
                                        XMLELEMENT("educationleveldesc", (SELECT 'educationleveldesc' FROM dual)),
                                        XMLELEMENT("email", (SELECT 'email' FROM dual)),
                                        XMLELEMENT("employmentbiznaturedesc", (SELECT 'employmentbiznaturedesc' FROM dual)),
                                        XMLELEMENT("employmentdept", (SELECT 'employmentdept' FROM dual)),
                                        XMLELEMENT("employmentemail", (SELECT 'employmentemail' FROM dual)),
                                        XMLELEMENT("employmentfinaltotalincomeformattedwithdecimal", (SELECT 'employmentfinaltotalincomeformattedwithdecimal' FROM dual)),
                                        XMLELEMENT("employmentmonth", (SELECT 'employmentmonth' FROM dual)),
                                        XMLELEMENT("employmentname", (SELECT 'employmentname' FROM dual)),
                                        XMLELEMENT("employmentoccupationdesc", (SELECT 'employmentoccupationdesc' FROM dual)),
                                        XMLELEMENT("employmentprovincedesc", (SELECT 'employmentprovincedesc' FROM dual)),
                                        XMLELEMENT("employmentstaffid", (SELECT 'employmentstaffid' FROM dual)),
                                        XMLELEMENT("employmentstatusdesc", (SELECT 'employmentstatusdesc' FROM dual)),
                                        XMLELEMENT("employmentyear", (SELECT 'employmentyear' FROM dual)),
                                        XMLELEMENT("estimatedassetvaluedesc", (SELECT 'estimatedassetvaluedesc' FROM dual)),
                                        XMLELEMENT("excludeincomedebtflagcount", (SELECT 'excludeincomedebtflagcount' FROM dual)),
                                        XMLELEMENT("expirydate", (SELECT 'expirydate' FROM dual)),
                                        XMLELEMENT("expirydateformatted", (SELECT 'expirydateformatted' FROM dual)),
                                        XMLELEMENT("exttelephoneno", (SELECT 'exttelephoneno' FROM dual)),
                                        XMLELEMENT("genderdesc", (SELECT 'genderdesc' FROM dual)),
                                        XMLELEMENT("idissuectry1desc", (SELECT 'idissuectry1desc' FROM dual)),
                                        XMLELEMENT("idno1", (SELECT 'idno1' FROM dual)),
                                        XMLELEMENT("idno1_formatted", (SELECT 'idno1_formatted' FROM dual)),
                                        XMLELEMENT("idtype1desc", (SELECT 'idtype1desc' FROM dual)),
                                        XMLELEMENT("incomebankaccoutnumber", (SELECT 'incomebankaccoutnumber' FROM dual)),
                                        XMLELEMENT("incomebankname", (SELECT 'incomebankname' FROM dual)),
                                        XMLELEMENT("incomebasicsalaryformattedwithdecimal", (SELECT 'incomebasicsalaryformattedwithdecimal' FROM dual)),
                                        XMLELEMENT("incomedeclaredformattedwithdecimal", (SELECT 'incomedeclaredformattedwithdecimal' FROM dual)),
                                        XMLELEMENT("incomeextraotherformattedwithdecimal", (SELECT 'incomeextraotherformattedwithdecimal' FROM dual)),
                                        XMLELEMENT("incomeotherincomeformattedwithdecimal", (SELECT 'incomeotherincomeformattedwithdecimal' FROM dual)),
                                        XMLELEMENT("incomesharedholderpercentformattedwithdecimal", (SELECT 'incomesharedholderpercentformattedwithdecimal' FROM dual)),
                                        XMLELEMENT("incometotallastmthcreditacct1formattedwithdecimal", (SELECT 'incometotallastmthcreditacct1formattedwithdecimal' FROM dual)),
                                        XMLELEMENT("incometotallastmthcreditacct2formattedwithdecimal", (SELECT 'incometotallastmthcreditacct2formattedwithdecimal' FROM dual)),
                                        XMLELEMENT("incometypedesc", (SELECT 'incometypedesc' FROM dual)),
                                        XMLELEMENT("issueddate", (SELECT 'issueddate' FROM dual)),
                                        XMLELEMENT("issueddateformatted", (SELECT 'issueddateformatted' FROM dual)),
                                        XMLELEMENT("mailingpreferencedesc", (SELECT 'mailingpreferencedesc' FROM dual)),
                                        XMLELEMENT("maritalstatusdesc", (SELECT 'maritalstatusdesc' FROM dual)),
                                        XMLELEMENT("nameline1", (SELECT 'nameline1' FROM dual)),
                                        XMLELEMENT("nameline2", (SELECT 'nameline2' FROM dual)),
                                        XMLELEMENT("nationality2desc", (SELECT 'nationality2desc' FROM dual)),
                                        XMLELEMENT("nationalitydesc", (SELECT 'nationalitydesc' FROM dual)),
                                        XMLELEMENT("noofdependent", (SELECT 'noofdependent' FROM dual)),
                                        XMLELEMENT("placeofbirthdesc", (SELECT 'placeofbirthdesc' FROM dual)),
                                        XMLELEMENT("professionalcodedesc", (SELECT 'professionalcodedesc' FROM dual)),
                                        XMLELEMENT("relationwithmaindesc", (SELECT 'relationwithmaindesc' FROM dual)),
                                        XMLELEMENT("residenttypedesc", (SELECT 'residenttypedesc' FROM dual)),
                                        XMLELEMENT("salutationcodedesc", (SELECT 'salutationcodedesc' FROM dual)),
                                        XMLELEMENT("selfemployincomeextratotalformattedwithdecimal", (SELECT 'selfemployincomeextratotalformattedwithdecimal' FROM dual)),
                                        XMLELEMENT("selfemployincometotalformattedwithdecimal", (SELECT 'selfemployincometotalformattedwithdecimal' FROM dual)),
                                        XMLELEMENT("serialno", (SELECT 'serialno' FROM dual)),
                                        XMLELEMENT("sourcefromcountrydesc", (SELECT 'sourcefromcountrydesc' FROM dual)),
                                        XMLELEMENT("sourceofassetdesc", (SELECT 'sourceofassetdesc' FROM dual)),
                                        XMLELEMENT("spbirthdate", (SELECT 'spbirthdate' FROM dual)),
                                        XMLELEMENT("spsalutationcodedesc", (SELECT 'spsalutationcodedesc' FROM dual)),
                                        XMLELEMENT("spthainame", (SELECT 'spthainame' FROM dual)),
                                        XMLELEMENT("spthaisurname", (SELECT 'spthaisurname' FROM dual))

                                    ))
                                    from los_cif_indv indv where indv.ca_id = ca.id and indv.cif_rel_code = 'J'
                                )
                            )
                            FROM dual
                        ),
                        --DOCUMENT / APPLICATION / registrationrequestfacilitylist / .... 
                        (
                            SELECT XMLELEMENT(
                                "registrationrequestfacilitylist",
                                XMLELEMENT("registrationrequestfacility", (SELECT 'registrationrequestfacility' FROM dual)),

                                --A
                                (
                                    SELECT XMLELEMENT(
                                        "registrationrequestfacility",
                                        XMLELEMENT("approvedcreditlimitdescformattedwithdecimal", (SELECT 'approvedcreditlimitdescformattedwithdecimal' FROM dual)),
                                        XMLELEMENT("feecancellation", (SELECT 'feecancellation' FROM dual)),
                                        XMLELEMENT("feeprepayment", (SELECT 'feeprepayment' FROM dual)),
                                        XMLELEMENT("feestandardfontend", (SELECT 'feestandardfontend' FROM dual)),
                                        XMLELEMENT("installment", (SELECT 'installment' FROM dual)),
                                        XMLELEMENT("interestrateformattedwithdecimal", (SELECT 'interestrateformattedwithdecimal' FROM dual)),
                                        XMLELEMENT("mrtaamountformattedwithdecimal", (SELECT 'mrtaamountformattedwithdecimal' FROM dual)),
                                        XMLELEMENT("numberofcheque", (SELECT 'numberofcheque' FROM dual)),
                                        XMLELEMENT("percentsign", (SELECT 'percentsign' FROM dual)),
                                        XMLELEMENT("productcode", (SELECT 'productcode' FROM dual)),
                                        XMLELEMENT("producttypedesc", (SELECT 'producttypedesc' FROM dual)),
                                        XMLELEMENT("ratetype", (SELECT 'ratetype' FROM dual)),
                                        XMLELEMENT("serialno", (SELECT 'serialno' FROM dual)),
                                        XMLELEMENT("subproducttypedesc", (SELECT 'subproducttypedesc' FROM dual)),
                                        XMLELEMENT("sumamountformattedwithdecimal", (SELECT 'sumamountformattedwithdecimal' FROM dual)),
                                        XMLELEMENT("tenuredoc", (SELECT 'tenuredoc' FROM dual)),
                                        XMLELEMENT("totalappraisalfeeformattedwithdecimal", (SELECT 'totalappraisalfeeformattedwithdecimal' FROM dual)), 
                                        XMLELEMENT("totaldutystampfeeformattedwithdecimal", (SELECT 'totaldutystampfeeformattedwithdecimal' FROM dual)),
                                        XMLELEMENT("totalmortregistfeeformattedwithdecimal", (SELECT 'totalmortregistfeeformattedwithdecimal' FROM dual)),

                                        (
                                            SELECT XMLELEMENT(
                                                "facdetaillist",
                                                (
                                                    SELECT XMLAGG(XMLELEMENT(
                                                        "facdepositdetail",
                                                        XMLELEMENT("depositacname",  (SELECT 'depositacname' FROM dual) ),
                                                        XMLELEMENT("depositacno",  (SELECT 'depositacno' FROM dual) ),
                                                        XMLELEMENT("deposittramountdescformattedwithdecimal",  (SELECT 'deposittramountdescformattedwithdecimal' FROM dual) )
                                                    ))
                                                    FROM dual
                                                )
                                            )
                                            FROM dual
                                        ),

                                        (
                                            SELECT XMLELEMENT(
                                                "facdetaillist",
                                                (
                                                    SELECT XMLAGG(XMLELEMENT(
                                                        "facdetail",
                                                        XMLELEMENT("recipientnamecrosstypedesc",  (SELECT 'recipientnamecrosstypedesc' FROM dual) ),
                                                        XMLELEMENT("recipientnamepayeename",  (SELECT 'recipientnamepayeename' FROM dual) ),
                                                        XMLELEMENT("recipientnamepayeenamedesc",  (SELECT 'recipientnamepayeenamedesc' FROM dual) ),
                                                        XMLELEMENT("recipientnametotalamountdescformattedwithdecimal",  (SELECT 'recipientnametotalamountdescformattedwithdecimal' FROM dual) ),
                                                        XMLELEMENT("recipientnametotalamountformattedwithdecimal",  (SELECT 'recipientnametotalamountformattedwithdecimal' FROM dual) )
                                                    ))
                                                    FROM dual
                                                )
                                            )
                                            FROM dual
                                        ) 
                                    )
                                    FROM dual
                                )

                            )
                            FROM dual
                        ),
                        (
                            SELECT XMLELEMENT(
                                "registrationrequestlist",
                                (
                                    SELECT XMLELEMENT(
                                        "registrationrequest",
                                        XMLELEMENT("appointmenttimedesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("landdepartmentbranchdesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("landownername", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("loancontractdatedesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("mosigningdatedesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("totalapprovedcreditlimitformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("totaldutystampfeeamountformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("totalmortregistfeeamountformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("totalmrtaamountformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("grandtotalamountformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("mcissueby", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("mcissuebydesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("mcissuedate", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("mortgagesigningdate", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("totalfacinstallmentamountformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("mlrrate", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("morrate", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("mrrrate", (SELECT 'dummy data' FROM dual)), 
                                        XMLELEMENT("tdrate", (SELECT 'dummy data' FROM dual))
                                    )
                                    FROM los_reg_request reg where reg.ca_id = ca.id
                                )
                            )
                            FROM dual
                        ),
                        (
                            SELECT XMLELEMENT(
                                "approvalmemo",
                                XMLELEMENT("approvedcreditlimit", (SELECT 'dummy data' FROM dual)),

                                --A
                                XMLELEMENT("approvedcreditlimitformattedwithdecimal", (SELECT 'approvedcreditlimitformattedwithdecimal' FROM dual)),
                                XMLELEMENT("approvedmonthlyinstallment", (SELECT 'approvedmonthlyinstallment' FROM dual))

                            )
                            FROM dual
                        ),
                        (
                            SELECT XMLELEMENT(
                                "facilitylist",
                                (
                                    SELECT XMLAGG(XMLELEMENT(
                                        "facility",
                                        XMLELEMENT("facilitycode", fac.fac_code),
                                        XMLELEMENT("cbpurposecodedesc", f_get_cce_value('LOAN_PUR_CODE', fac.loan_pur_code)),
                                        XMLELEMENT("contractdatedesc", (SELECT 'dummy data1' FROM dual)),
                                        XMLELEMENT("customersegmentdesc", fac.customer_segment),
                                        XMLELEMENT("existingacctno", (SELECT 'dummy data1' FROM dual)),
                                        XMLELEMENT("hostproductcode", fac.host_product_code),
                                        XMLELEMENT("hostprojectcode", fac.host_project_code),
                                        XMLELEMENT("mailingpreferencedesc", (SELECT 'dummy data1' FROM dual)),
                                        XMLELEMENT("paymethoddesc", fac.pay_method),
                                        XMLELEMENT("tenure", fac.tenure),
                                        XMLELEMENT("hostAcfNo", fac.host_acf_no),
                                        XMLELEMENT("producttypedesc", f_get_cce_value('26', fac.fac_code)),
                                        XMLELEMENT("cacampaigncode", fac.ca_camp_code),
                                        XMLELEMENT("campaignname", (select CAMPAIGN_NAME from los_sa_camp where CAMPAIGN_CODE = fac.ca_camp_code and app_typ = ca.app_typ)),
                                        XMLELEMENT("disbaccountname", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("disbaccountnumber", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("disbbankcodedesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("existlimitformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("limitappliedformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("payaccountname", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("payaccountnumber", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("paymethod", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("productcode", fac.prod_code),

                                        --A
                                        (
                                            SELECT XMLELEMENT(
                                                "approvalmemolist",
                                                (
                                                    SELECT XMLELEMENT(
                                                        "applyapprovalmemo",
                                                        XMLELEMENT("apprmrtaamountformattedwithdecimal", (SELECT 'apprmrtaamountformattedwithdecimal' FROM dual)),
                                                        XMLELEMENT("limitappliedformattedwithdecimal", (SELECT 'limitappliedformattedwithdecimal' FROM dual)),
                                                        XMLELEMENT("tenure", (SELECT 'tenure' FROM dual))
                                                    )
                                                    FROM dual
                                                ),
                                                (
                                                    SELECT XMLELEMENT(
                                                        "recommentapprovalmemo",
                                                        
                                                        XMLELEMENT("apprinterestrateformatted", (SELECT 'apprinterestrateformatted' FROM dual)),
                                                        XMLELEMENT("apprlimitappliedformattedwithdecimal", (SELECT 'apprlimitappliedformattedwithdecimal' FROM dual)),
                                                        XMLELEMENT("apprmrtaamountformattedwithdecimal", (SELECT 'apprmrtaamountformattedwithdecimal' FROM dual)),
                                                        XMLELEMENT("interestrateformattedwithdecimal", (SELECT 'interestrateformattedwithdecimal' FROM dual)),
                                                        XMLELEMENT("limitappliedformattedwithdecimal", (SELECT 'limitappliedformattedwithdecimal' FROM dual)),
                                                        XMLELEMENT("tenure", (SELECT 'tenure' FROM dual)),
                                                        XMLELEMENT("grandtotalamountformattedwithdecimal", (SELECT 'dummy data' FROM dual))
                                                    )
                                                    FROM dual
                                                ),
                                                (
                                                    SELECT XMLELEMENT(
                                                        "recommentapprovalmemoinfo",
                                                        
                                                        XMLELEMENT("apprinstallmentamountformattedwithdecimal", (SELECT 'apprinstallmentamountformattedwithdecimal' FROM dual))
                                                    )
                                                    FROM dual
                                                )
                                            )
                                            FROM dual
                                        ),

                                        XMLELEMENT("facilitycodedesc", (SELECT 'facilitycodedesc' FROM dual)),
                                        XMLELEMENT("mrtaamountformattedwithdecimal", (SELECT 'mrtaamountformattedwithdecimal' FROM dual)),
                                        XMLELEMENT("mrtayrscoverage", (SELECT 'mrtayrscoverage' FROM dual)),
                                        XMLELEMENT("prdlimitappliedformattedwithdecimal", (SELECT 'prdlimitappliedformattedwithdecimal' FROM dual)),
                                        XMLELEMENT("productcodedesc", (SELECT 'productcodedesc' FROM dual)),
                                        XMLELEMENT("serialno", (SELECT 'serialno' FROM dual)),
                                        XMLELEMENT("subproducttypedesc", (SELECT 'subproducttypedesc' FROM dual))

                                    ))
                                    FROM los_fac fac where fac.ca_id = ca.id
                                )
                            )
                            FROM dual
                        )
                    )
                from los_docgen docgen
                left join los_ca ca on docgen.ca_id = ca.id
                left join los_user officer on docgen.generate_by = officer.id
                left join los_wf_task wf on wf.app_id = docgen.ca_id and wf.wf_routing_line = 'M'
                where docgen.id = in_docgen_id
            ),

            --document/xmlgenerationdate
            XMLELEMENT("xmlgenerationdate", F_DOCGEN_TH_DATE(SYSDATE))


        ).getClobVal() as xml_str
    from dual;
END DOCGEN_XML;