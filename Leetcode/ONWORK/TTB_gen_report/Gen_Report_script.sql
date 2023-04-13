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
                        XMLELEMENT("salesstaffname",(SELECT 'dummy data' FROM dual)),

                        -- PART 2: COLLECT from : Appointment_Confirmation_Form.xsl
                        --document/application/allapplicantname
                        XMLELEMENT("allapplicantname",(SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("officernamegendoc",(SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("officerphonegendoc",(SELECT 'dummy data' FROM dual)),

                        -- document/application/registrationrequestfacilitylist/registrationrequestfacility
                        (
                            SELECT XMLELEMENT(
                                "registrationrequestfacilitylist",
                                XMLELEMENT("registrationrequestfacility", (SELECT 'dummy data' FROM dual))
                            )
                            FROM dual
                        ),
                        -- document/application/registrationrequestlist/registrationrequest/appointmenttimedesc
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
                                    
                                    --P3 :COLLECT from : Cheque_Issuance_Form.xsl
                                        XMLELEMENT("grandtotalamountformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("mcissueby", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("mcissuebydesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("mcissuedate", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("mortgagesigningdate", (SELECT 'dummy data' FROM dual))

                                    )
                                    FROM dual
                                )
                            )
                            FROM dual
                        ),

                        -- P4 : COLLECT from : Fixing_Document_Cover_Page.xsl
                        XMLELEMENT("applicationtype", (SELECT 'dummy data' FROM dual)),

                        XMLELEMENT("grandtotalamountformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("applicationstatus", (SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("applicationstatusdesc", (SELECT 'dummy data' FROM dual)),
                        
                        (
                            SELECT XMLELEMENT(
                                "approvalmemo",
                                XMLELEMENT("approvedcreditlimit", (SELECT 'dummy data' FROM dual))
                            )
                            FROM dual
                        ),

                        XMLELEMENT("approveddate", (SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("branchname", (SELECT 'dummy data' FROM dual)),
                        
                        -- document/application/collaterallist/collateral/resaddamphur
                        -- document/application/collaterallist/collateral/resaddtumbol
                        (
                            SELECT XMLELEMENT(
                                "collaterallist",
                                (
                                    SELECT XMLELEMENT(
                                        "collateral",
                                        XMLELEMENT("resaddamphur", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("resaddtumbol", (SELECT 'dummy data' FROM dual))
                                    )
                                    FROM dual
                                )
                            )
                            FROM dual
                        ),
                        XMLELEMENT("combotoapprefnodesc", (SELECT 'dummy data' FROM dual)),
                        (
                            SELECT XMLELEMENT(
                                "customer",
                                XMLELEMENT("ccdetails", (SELECT 'dummy data' FROM dual)),
                                 (
                                    SELECT XMLELEMENT(
                                        "ccdetails",
                                        XMLELEMENT("customersegmentdesc", (SELECT 'dummy data' FROM dual))
                                    )
                                    FROM dual
                                ),
                                XMLELEMENT("excludeincomedebtflagcount", (SELECT 'dummy data' FROM dual))
                            )
                            FROM dual
                        ),

                        (
                            SELECT XMLELEMENT(
                                "facilitylist",
                                (
                                    SELECT XMLELEMENT(
                                        "facility",
                                        XMLELEMENT("cbpurposecodedesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("contractdatedesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("customersegmentdesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("existingacctno", (SELECT 'dummy data' FROM dual))
                                    )
                                    FROM dual
                                )
                            )
                            FROM dual
                        ),
                        XMLELEMENT("holderdate17", (SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("resubmitappno", (SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("reusedocreason", (SELECT 'dummy data' FROM dual)),
                        XMLELEMENT("wfversion", (SELECT 'dummy data' FROM dual)),

                    -- P5 : COLLECT from : NCB_Consent_Form.xsl
                    -- document/application/customer/birthdate 
                    -- document/application/customer/idtype1
                    -- document/application/customer/idno1_formatted

                        (
                            SELECT XMLELEMENT(
                                "customer",
                                XMLELEMENT("birthdate", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("idtype1", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("idno1_formatted", (SELECT 'dummy data' FROM dual))
                            )
                            FROM dual
                        ),

                        -- P6 : COLLECT from : SB_Appointment_Confirmation_Form.xsl
                        (
                            SELECT XMLELEMENT(
                                "registrationrequestlist",
                                (
                                    SELECT XMLELEMENT(
                                        "registrationrequest",
                                        XMLELEMENT("totalfacinstallmentamountformattedwithdecimal", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("mlrrate", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("morrate", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("mrrrate", (SELECT 'dummy data' FROM dual)), 
                                        XMLELEMENT("tdrate", (SELECT 'dummy data' FROM dual))   
                                    )
                                    FROM dual
                                )
                            )
                            FROM dual
                        ),

                        --P7 COLLECT from : SB_Cheque_Issuance_Form.xsl
                        --document/application/sbbranchcode
                        XMLELEMENT("sbbranchcode", (SELECT 'dummy data' FROM dual)),

                        -- P8 : COLLECT from : SM_HL_HE_Application_Form.xsl
                        -- document/application/customer/genderdesc
                        (
                            SELECT XMLELEMENT(
                                "customer",
                                XMLELEMENT("genderdesc", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("issueddate", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("expirydate", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("age", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("mobileno", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("sameregisteraddressflag", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("residenttypedesc", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("educationleveldesc", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("noofdependent", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("spsalutationcodedesc", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("spthainame", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("spthaisurname", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("spidtypedesc", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("spidno", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("spbirthdate", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("sourceofassetdesc", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("estimatedassetvaluedesc", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("employmentstatusdesc", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("currentjobtitle", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("employmentdept", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("employmentstaffid", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("empjointdatedesc", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("workingaddrcopyfrom", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("employmenttelephonedirectno", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("customerlevel", (SELECT 'dummy data' FROM dual))

                            )
                            FROM dual
                        ),

                        (
                            SELECT XMLELEMENT(
                                "collaterallist",
                                    XMLELEMENT("collateral", (SELECT 'dummy data' FROM dual))
                            )
                            from dual
                        ),
                        --  document/application/jointcustomerlist/customer/registertelephoneno
                        --  document/application/jointcustomerlist/customer/registerexttelephoneno
                        (
                            SELECT XMLELEMENT(
                               "jointcustomerlist",
                                (
                                    SELECT XMLELEMENT(
                                        "customer",
                                        XMLELEMENT("registertelephoneno", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("registerexttelephoneno", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("mobileno", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("telephoneno", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("employmenttelephoneno", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("employmenttelephoneextno", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("employmenttelephonedirectno", (SELECT 'dummy data' FROM dual))
                                    )
                                    FROM dual
                                ),
                                (
                                    SELECT XMLELEMENT(
                                        "customer[1]",
                                        XMLELEMENT("thaisalutationcodedesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("thainame", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("thaisurname", (SELECT 'dummy data' FROM dual))
                                    )
                                    FROM dual
                                ),
                                (
                                    SELECT XMLELEMENT(
                                        "customer[2]",
                                        XMLELEMENT("thaisalutationcodedesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("thainame", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("thaisurname", (SELECT 'dummy data' FROM dual))
                                    )
                                    FROM dual
                                )
                            )
                            FROM dual
                        ),

                        -- P9: COLLECT from : SP_New_staff_Application_Form.xsl
                        XMLELEMENT("branchcode", (SELECT 'dummy data' FROM dual)),
                        (
                            SELECT XMLELEMENT(
                                "customer",
                                XMLELEMENT("employmentemail", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("mobilenotwo", (SELECT 'dummy data' FROM dual)),
                                XMLELEMENT("racedesc", (SELECT 'dummy data' FROM dual))
                            )
                            FROM dual
                        ),

                        -- document/application/facilitylist/facility/hostproductcode
                        -- document/application/facilitylist/facility/hostprojectcode
                        (
                            SELECT XMLELEMENT(
                               "facilitylist",
                                (
                                    SELECT XMLELEMENT(
                                        "facility",
                                        XMLELEMENT("hostproductcode", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("hostprojectcode", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("mailingpreferencedesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("paymethoddesc", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("tenure", (SELECT 'dummy data' FROM dual))
                                    )
                                    FROM dual
                                )
                            )
                            FROM dual
                        ),

                        -- P10 : COLLECT from : SP_Old_staff_and_TMBCare_Staff_Application_Form.xsl
                        -- document/application/facilitylist/facility/hostAcfNo
                        -- document/application/facilitylist/facility/producttypedesc
                        (
                            SELECT XMLELEMENT(
                               "facilitylist",
                                (
                                    SELECT XMLELEMENT(
                                        "facility",
                                        XMLELEMENT("hostAcfNo", (SELECT 'dummy data' FROM dual)),
                                        XMLELEMENT("producttypedesc", (SELECT 'dummy data' FROM dual))
                                    )
                                    FROM dual
                                )
                            )
                            FROM dual
                        ),
                        -- P11: COLLECT from : SP_Old_staff_and_TMBCare_Topup_Agreement.xsl
                        XMLELEMENT("applicationdate",(SELECT 'dummy data' FROM dual)),

                        --document/application/customer/addresslist/address/addressline1
                         (
                            SELECT XMLELEMENT(
                                "customer",
                                (
                                    SELECT XMLELEMENT(
                                    "addresslist",
                                        (
                                            SELECT XMLELEMENT(
                                                "address",
                                                XMLELEMENT("addressline1", (SELECT 'dummy data' FROM dual)),
                                                XMLELEMENT("amphur", (SELECT 'dummy data' FROM dual)),
                                                XMLELEMENT("provincedesc", (SELECT 'dummy data' FROM dual)),
                                                XMLELEMENT("road", (SELECT 'dummy data' FROM dual)),
                                                XMLELEMENT("streetname", (SELECT 'dummy data' FROM dual)),
                                                XMLELEMENT("tumbol", (SELECT 'dummy data' FROM dual))
                                            )
                                            FROM dual
                                        )
                                    )
                                    FROM dual
                                )
                            )
                            FROM dual
                        )


                    )
                from los_ca ca where ca.id = in_application_id
            ),

            -- PART : COLLECT from : Appointment_Confirmation_Form.xsl
            --document/xmlgenerationdate
            XMLELEMENT("xmlgenerationdate",(SELECT 'dummy data' FROM dual))


        ).getClobVal() as xml_str
    from dual;
END DOCGEN_XML;