SELECT * FROM LOS_CA ;
--ID
--2019073000013351
--2019080100013356
--2019080100013358


create or replace NONEDITIONABLE PROCEDURE DOCGEN_XML(
    output       OUT TYPES.cursor_type,
    in_application_id IN NUMBER
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
                        (
                            SELECT
                                XMLELEMENT(
                                    "customer",
                                    XMLELEMENT("thaisalutationcodedesc", (SELECT entry_name FROM common_code_category_entry where entry_code = indv.th_salu_code and category_code = 'SALUTATION')),
                                    XMLELEMENT("thainame", indv.th_name_line_2),
                                    XMLELEMENT("thaisurname", indv.th_name_line_1),
                                    (
                                        SELECT XMLELEMENT(
                                            "addresslist",
                                            XMLELEMENT("address", (SELECT 'dummy data' FROM dual))
                                        )
                                        FROM dual
                                    ),
                                    XMLELEMENT("applywithccflag", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("birthdateformatted", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("bonusyearlyformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("businesssubtypedesc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("businesstypedesc", (SELECT 'dummy data' FROM dual)),
                                    (
                                        SELECT XMLELEMENT(
                                            "ccdetails",
                                            XMLELEMENT("campaigncode", (SELECT 'dummy data' FROM dual)),
                                            XMLELEMENT("campaignname", (SELECT 'dummy data' FROM dual)),
                                            XMLELEMENT("debitaccountname", (SELECT 'dummy data' FROM dual)),
                                            XMLELEMENT("debitaccountno", (SELECT 'dummy data' FROM dual)),
                                            XMLELEMENT("existcardcreditlimitformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                            XMLELEMENT("existcardnumber", (SELECT 'dummy data' FROM dual)),
                                            XMLELEMENT("mailingpreferencedesc", (SELECT 'dummy data' FROM dual)),
                                            XMLELEMENT("newcreditlimitformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                            XMLELEMENT("paymentmethod", (SELECT 'dummy data' FROM dual)),
                                            XMLELEMENT("producttypedesc", (SELECT 'dummy data' FROM dual))
                                        )
                                        FROM dual
                                    ),
                                    XMLELEMENT("contractempenddateformatted", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("contractemployedflag", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("contractempstartdateformatted", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("currentemployercodedesc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("email", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("emailstatementflag", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("employmentbiznaturedesc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("employmentfaxno", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("employmentmonth", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("employmentname", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("employmentoccupationdesc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("employmentstatus", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("employmenttelephoneextno", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("employmenttelephoneno", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("employmentyear", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("expirydateformatted", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("exttelephoneno", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("hostcifno", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("idissuectry1desc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("idno1", (SELECT 'dummy data' FROM dual)),
                                    
                                    XMLELEMENT("idtype1desc", (SELECT 'dummy data' FROM dual)),
                                    
                                    XMLELEMENT("incomebankaccoutnumber", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("incomebankname", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("incomebasicsalaryformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("incomeextraotherformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("incomeotherincomeformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("incomesharedholderpercentformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("incometotallastmthcreditacct1formattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("incometotallastmthcreditacct2formattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("incometypedesc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("insidercodedesc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("issueddateformatted", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("lifetimeflag", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("mailingpreferencedesc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("maritalstatus", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("maritalstatusdesc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("mobileno", (SELECT 'dummy data' FROM dual)),
                                    
                                    XMLELEMENT("nameline1", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("nameline2", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("nationality2desc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("nationalitydesc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("placeofbirthdesc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("professionalcodedesc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("registerexttelephoneno", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("registertelephoneno ", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("residenttypedesc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("rmwealthflag", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("salutationcodedesc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("sourcefromcountrydesc", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("telephoneno", (SELECT 'dummy data' FROM dual)),
                                    XMLELEMENT("thainame", (SELECT 'dummy data' FROM dual)),
                                    
                                    XMLELEMENT("thaisalutationcodedesc", (SELECT 'dummy data' FROM dual)),
                                    
                                    XMLELEMENT("thaisurname", (SELECT 'dummy data' FROM dual)),
                                    (
                                        SELECT XMLELEMENT(
                                            "facilitylist",
                                            XMLELEMENT("facility", (SELECT 'dummy data' FROM dual)),
                                            (
                                                SELECT XMLELEMENT(
                                                    "facility",
                                                    XMLELEMENT("cacampaigncode", (SELECT 'dummy data' FROM dual)),
                                                    XMLELEMENT("campaignname", (SELECT 'dummy data' FROM dual)),
                                                    XMLELEMENT("disbaccountname", (SELECT 'dummy data' FROM dual)),
                                                    XMLELEMENT("disbaccountnumber", (SELECT 'dummy data' FROM dual)),
                                                    XMLELEMENT("disbbankcodedesc", (SELECT 'dummy data' FROM dual)),
                                                    XMLELEMENT("existlimitformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                                    XMLELEMENT("facilitycode", (SELECT 'dummy data' FROM dual)),
                                                    XMLELEMENT("limitappliedformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                                    XMLELEMENT("payaccountname", (SELECT 'dummy data' FROM dual)),
                                                    XMLELEMENT("payaccountnumber", (SELECT 'dummy data' FROM dual)),
                                                    XMLELEMENT("paymethod", (SELECT 'dummy data' FROM dual)),
                                                    XMLELEMENT("productcode", (SELECT 'dummy data' FROM dual))
                                                )
                                                FROM dual
                                            )
                                        )
                                        FROM dual
                                    )
                                    
                                )
                            from los_cif_indv indv where indv.ca_id = ca.id and indv.cif_rel_code = 'M' and ROWNUM = 1
                        ),
                        -- document/application/applicationreferenceno
                        -- document/application/applicationtype
                        XMLELEMENT("applicationreferenceno",(SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("applicationtype",(SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("bookbranchcode",(SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("bookbranchcodedesc",(SELECT 'dummy data' FROM dual)),
                        
                        -- document/application/collaterallist/collateral/developercode
                        -- document/application/collaterallist/collateral/developercodedesc
                        -- document/application/collaterallist/collateral/developername
                        -- document/application/collaterallist/collateral/projectid
                        -- document/application/collaterallist/collateral/projectiddesc
                        (
                            SELECT XMLELEMENT(
                                "collaterallist",
                                (
                                    SELECT XMLELEMENT(
                                        "collateral",
                                        XMLELEMENT("developercode", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("developercodedesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("developername", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("projectid", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("projectiddesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("projectname", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("purchasepriceformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("resaddprovincedesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("securitysubtypecodedesc", (SELECT 'dummy data' FROM dual))
                                        
                                    )
                                    FROM dual
                                ) 
                            )
                            from dual
                        ), 
                        -- document/application/jointcustomerlist/customer
                        (
                            SELECT XMLELEMENT(
                                "jointcustomerlist",
                                XMLELEMENT("customer", (SELECT 'dummy data' FROM dual)),
                                --document/application/jointcustomerlist/customer/ccdetails/producttypedesc
                                --document/application/jointcustomerlist/customer/employmentfaxno
                                (
                                    SELECT XMLELEMENT(
                                        "customer",
                                        (
                                            SELECT XMLELEMENT(
                                                "ccdetails",
                                                XMLELEMENT("producttypedesc", (SELECT 'dummy data' FROM dual))
                                            )
                                            FROM dual
                                        ),
                                        XMLELEMENT("employmentfaxno", (SELECT 'dummy data' FROM dual))
                                    )
                                    FROM dual
                                )
                            )
                            FROM dual
                        ),
                        XMLELEMENT("referralstaffname",(SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("referralstaffno",(SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("requestnature",(SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("requestnaturedesc",(SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("salescontactnumber",(SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("salesdesc",(SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("salesstaffcode",(SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("salesstaffname",(SELECT 'dummy data' FROM dual))
                    )
                from los_ca ca where ca.id = in_application_id
            )
        ).getClobVal() as xml_str
    from dual;
END DOCGEN_XML;