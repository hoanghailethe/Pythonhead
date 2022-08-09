SELECT * FROM SML_SECURITY WHERE ASSESSMENT_OF_COLLATERAL IS NULL ;

SELECT SEC.ID, A.CA_ID, 
    B.Title_Number_prefix, rawtohex(B.Title_Number_prefix),
    B. Lot_No, rawtohex(Lot_No),
    B.Lot_Number_prefix, rawtohex(Lot_Number_prefix),
    B.postcode, rawtohex(postcode),
    B.Phy_inspect_freq_unit, rawtohex(Phy_inspect_freq_unit),
    B.Property_Address, rawtohex(Property_Address),
    B.Assessment, rawtohex(Assessment),
    B.district, rawtohex(district),
    B.ABANDONED_PROJECT, rawtohex(ABANDONED_PROJECT),
    B.INDEPENDENT_VALUER_FLAG, rawtohex(INDEPENDENT_VALUER_FLAG),
    B.PROJECT_NAME, rawtohex(PROJECT_NAME),
	B.NON_PREFERRED_LOCATION, rawtohex(NON_PREFERRED_LOCATION),
    B.property_completion_stage, rawtohex(property_completion_stage),
    B.scheduled_location, rawtohex(scheduled_location),
    B.MORTGAGE_TYPE, rawtohex(MORTGAGE_TYPE),
    B.TENANT_TYPE, rawtohex(TENANT_TYPE),
    SEC.EXCHANGE_CONTROL_OBTAINED, rawtohex(EXCHANGE_CONTROL_OBTAINED),
    SEC.SCI_REFERENCE_NOTE,rawtohex(SCI_REFERENCE_NOTE),
    SEC.SCI_SECURITY_CCY, rawtohex(SCI_SECURITY_CCY),
    SEC.SOURCE_ID, rawtohex(SEC.SOURCE_ID),
    SEC.COLLATERAL_DESCRIPTION, rawtohex(SEC.COLLATERAL_DESCRIPTION),
    SEC.COLLATERAL_NAME,rawtohex(SEC.COLLATERAL_NAME),
	SEC.ASSESSMENT_OF_COLLATERAL,rawtohex(SEC.ASSESSMENT_OF_COLLATERAL)
FROM 
SML_SECURITY SEC
LEFT JOIN sml_ca_collateral A ON SEC.ID = A.COLLATERAL_ID 
LEFT JOIN SML_SEC_PT B ON SEC.ID= B.ID 
LEFT JOIN sml_pledgor C ON C.COLLATERAL_ID = SEC.ID
LEFT JOIN sml_customer D ON D.ID = C.owner_id
LEFT JOIN SML_SEC_VALUATION E ON E.Collateral_id = sec.id 
WHERE A.CA_ID IN ( SELECT CA_ID FROM sml_ca_collateral WHERE COLLATERAL_ID  = 202207210022499345);

SELECT SEC.ID, ASSESSMENT_OF_COLLATERAL,rawtohex(ASSESSMENT_OF_COLLATERAL) FROM SML_SECURITY SEC 
WHERE SEC.ID IN(202207210022499345,202207210022499346,202207210022499407) AND rawtohex(ASSESSMENT_OF_COLLATERAL) like '%' || chr(0) || '%' ;
SELECT SEC.ID,  ASSESSMENT_OF_COLLATERAL,dump(ASSESSMENT_OF_COLLATERAL) str FROM SML_SECURITY SEC 
WHERE SEC.ID IN(202207210022499345,202207210022499346,202207210022499407) AND  dump(ASSESSMENT_OF_COLLATERAL) like '%' || chr(0) || '%' ;
SELECT SEC.ID,  COLLATERAL_DESCRIPTION,rawtohex(COLLATERAL_DESCRIPTION) FROM SML_SECURITY SEC 
WHERE SEC.ID IN(202207210022499345,202207210022499346,202207210022499407) AND rawtohex(COLLATERAL_DESCRIPTION) like '%' || chr(0) || '%' ;
SELECT SEC.ID, COLLATERAL_DESCRIPTION,dump(COLLATERAL_DESCRIPTION) str FROM SML_SECURITY SEC 
WHERE SEC.ID IN(202207210022499345,202207210022499346,202207210022499407) AND dump(ASSESSMENT_OF_COLLATERAL) like '%' || chr(0) || '%' ;

202109220020122773,202109220020122774,202101150018293277,202101150018293397,202108050019835748,202112140020846417,202105110019125128,202109280020164921,202201050021026193,202111010020454871,202202280021386990,202109170020089043,202110140020308140,202201190021158806,202112310021012388,202203280021615143,202206060022153587,202206060022155270,202111300020716616,202111300020716619,202112030020750294,202207080022419988,202112270020953685,202203170021530211,202203170021530129,202206280022328762,202207250022519902,202203110021483542,202207210022498357,202111170020593150,202112100020821045,202107160019701557,202112030020755692,202112030020755693,202110150020322774,202110250020390325,202110250020390326,202111050020504000,202112140020845710,202202070021258218,202203300021650584,202204120021747592,202202100021276280,202203180021542026,202202280021382631,202207080022419937,202206300022359823,202103250018753261,202203230021580673,202207210022498470,202203170021535464,202207280022551828,202201120021094941,202207210022494833,202108160019890297,202203020021402382,202202280021379276,202112100020813765,202112010020730961,202202100021273692,202204060021714176,202201190021152427,202201250021216038,202202100021276916,202202100021276393,202206060022159849,202206300022352929,202112160020861112,202207210022499346,202207070022410609,202207110022423510,


SEND to BANK - final:
UPDATE SML_SEC_PT 
SET ABANDONED_PROJECT = 'Y', INDEPENDENT_VALUER_FLAG='Y' 
WHERE ID IN (
    202109220020122773,202109220020122774,202101150018293277,202101150018293397,202108050019835748,202112140020846417,202105110019125128,202109280020164921,202201050021026193,202111010020454871,202202280021386990,202109170020089043,202110140020308140,202201190021158806,202112310021012388,202203280021615143,202206060022153587,202206060022155270,202111300020716616,202111300020716619,202112030020750294,202207080022419988,202112270020953685,202203170021530211,202203170021530129,202206280022328762,202207250022519902,202203110021483542,202207210022498357,202111170020593150,202112100020821045,202107160019701557,202112030020755692,202112030020755693,202110150020322774,202110250020390325,202110250020390326,202111050020504000,202112140020845710,202202070021258218,202203300021650584,202204120021747592,202202100021276280,202203180021542026,202202280021382631,202207080022419937,202206300022359823,202103250018753261,202203230021580673,202207210022498470,202203170021535464,202207280022551828,202201120021094941,202207210022494833,202108160019890297,202203020021402382,202202280021379276,202112100020813765,202112010020730961,202202100021273692,202204060021714176,202201190021152427,202201250021216038,202202100021276916,202202100021276393,202206060022159849,202206300022352929,202112160020861112,202207210022499346,202207070022410609,202207110022423510
);

== PREPARE SQL SEND
SELECT * FROM ... WHERE 


==SEND BANK QUERRY
--prepare
SELECT * FROM SML_SECURITY WHERE ASSESSMENT_OF_COLLATERAL IS NULL ;

SELECT SEC.ID, A.CA_ID, 
    B.Title_Number_prefix, rawtohex(B.Title_Number_prefix),
    B. Lot_No, rawtohex(Lot_No),
    B.Lot_Number_prefix, rawtohex(Lot_Number_prefix),
    B.postcode, rawtohex(postcode),
    B.Phy_inspect_freq_unit, rawtohex(Phy_inspect_freq_unit),
    B.Property_Address, rawtohex(Property_Address),
    B.Assessment, rawtohex(Assessment),
    B.district, rawtohex(district),
    B.ABANDONED_PROJECT, rawtohex(ABANDONED_PROJECT),
    B.INDEPENDENT_VALUER_FLAG, rawtohex(INDEPENDENT_VALUER_FLAG),
    B.PROJECT_NAME, rawtohex(PROJECT_NAME),
	B.NON_PREFERRED_LOCATION, rawtohex(NON_PREFERRED_LOCATION),
    B.property_completion_stage, rawtohex(property_completion_stage),
    B.scheduled_location, rawtohex(scheduled_location),
    B.MORTGAGE_TYPE, rawtohex(MORTGAGE_TYPE),
    B.TENANT_TYPE, rawtohex(TENANT_TYPE),
    SEC.EXCHANGE_CONTROL_OBTAINED, rawtohex(EXCHANGE_CONTROL_OBTAINED),
    SEC.SCI_REFERENCE_NOTE,rawtohex(SCI_REFERENCE_NOTE),
    SEC.SCI_SECURITY_CCY, rawtohex(SCI_SECURITY_CCY),
    SEC.SOURCE_ID, rawtohex(SEC.SOURCE_ID),
    SEC.COLLATERAL_DESCRIPTION, rawtohex(SEC.COLLATERAL_DESCRIPTION),
    SEC.COLLATERAL_NAME,rawtohex(SEC.COLLATERAL_NAME),
	SEC.ASSESSMENT_OF_COLLATERAL,rawtohex(SEC.ASSESSMENT_OF_COLLATERAL)
FROM 
SML_SECURITY SEC
LEFT JOIN sml_ca_collateral A ON SEC.ID = A.COLLATERAL_ID 
LEFT JOIN SML_SEC_PT B ON SEC.ID= B.ID 
LEFT JOIN sml_pledgor C ON C.COLLATERAL_ID = SEC.ID
LEFT JOIN sml_customer D ON D.ID = C.owner_id
LEFT JOIN SML_SEC_VALUATION E ON E.Collateral_id = sec.id 
WHERE A.CA_ID IN ( SELECT CA_ID FROM sml_ca_collateral WHERE COLLATERAL_ID  = 202207210022499345);

SELECT SEC.ID, ASSESSMENT_OF_COLLATERAL,rawtohex(ASSESSMENT_OF_COLLATERAL) FROM SML_SECURITY SEC 
WHERE SEC.ID IN(202207210022499345,202207210022499346,202207210022499407) AND rawtohex(ASSESSMENT_OF_COLLATERAL) like '%' || chr(0) || '%' ;
SELECT SEC.ID,  ASSESSMENT_OF_COLLATERAL,dump(ASSESSMENT_OF_COLLATERAL) str FROM SML_SECURITY SEC 
WHERE SEC.ID IN(202207210022499345,202207210022499346,202207210022499407) AND  dump(ASSESSMENT_OF_COLLATERAL) like '%' || chr(0) || '%' ;
SELECT SEC.ID,  COLLATERAL_DESCRIPTION,rawtohex(COLLATERAL_DESCRIPTION) FROM SML_SECURITY SEC 
WHERE SEC.ID IN(202207210022499345,202207210022499346,202207210022499407) AND rawtohex(COLLATERAL_DESCRIPTION) like '%' || chr(0) || '%' ;
SELECT SEC.ID, COLLATERAL_DESCRIPTION,dump(COLLATERAL_DESCRIPTION) str FROM SML_SECURITY SEC 
WHERE SEC.ID IN(202207210022499345,202207210022499346,202207210022499407) AND dump(ASSESSMENT_OF_COLLATERAL) like '%' || chr(0) || '%' ;


== FIND ALL : RAW TO HEX 00
SELECT SEC.ID, 
    B.ABANDONED_PROJECT, rawtohex(ABANDONED_PROJECT),
    B.INDEPENDENT_VALUER_FLAG, rawtohex(INDEPENDENT_VALUER_FLAG)
FROM 
SML_SECURITY SEC
LEFT JOIN SML_SEC_PT B ON SEC.ID= B.ID 
WHERE B.ABANDONED_PROJECT like '%' || chr(0) || '%' OR B.INDEPENDENT_VALUER_FLAG like '%' || chr(0) || '%';