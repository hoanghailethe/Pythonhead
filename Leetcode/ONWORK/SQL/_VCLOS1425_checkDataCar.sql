-- VCLOSPRODA 1425 Querried
SELECT * FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00640/04911059%';
SELECT * FROM SML_FACILITY FAC INNER JOIN SML_CA CA ON FAC.CA_ID = CA.ID AND CA. CA_NUMBER LIKE '%CAR/22/9002/00640/04911059%' ;

select caColl.*
from SML_CA_COLLATERAL caColl, SML_CA ca, SML_SECURITY sec
where caColl.CA_ID = ( SELECT ID FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00640/04911059%') 
and caColl.CA_ID = ca.ID and caColl.COLLATERAL_ID = sec.ID;

select sec.*
from SML_CA_COLLATERAL caColl, SML_CA ca, SML_SECURITY sec
where caColl.CA_ID = ( SELECT ID FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00640/04911059%') 
and caColl.CA_ID = ca.ID and caColl.COLLATERAL_ID = sec.ID;

SELECT CHARGE_FACILITY.* FROM SML_CHARGE_FACILITY_MAP CHARGE_FACILITY
INNER JOIN SML_FACILITY FAC ON CHARGE_FACILITY.FACILITY_ID = FAC.ID
AND FAC.CA_ID = ( SELECT ID FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00640/04911059%') ;

SELECT CHARGE.* FROM SML_CHARGE_FACILITY_MAP CHARGE_FACILITY
INNER JOIN SML_FACILITY FAC ON CHARGE_FACILITY.FACILITY_ID = FAC.ID
INNER JOIN SML_CHARGE_DETAIL CHARGE ON CHARGE.ID = CHARGE_FACILITY.CHARGE_DETAIL_ID
AND FAC.CA_ID = ( SELECT ID FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00640/04911059%') ;

--8/29/2022
-- doc
SELECT doc.* FROM sml_doc doc WHERE doc.ca_id = ( SELECT ID FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00640/04911059%') ;


--COMPSING SQL from Data code
-- CV convenant
CMS_CONVENANT   CONVENANT_ID
CMS_CONVENANT_SUB_ITEM  CONVENANT_ID
STAGE_CONVENANT
STAGE_CONVENANT_SUB_ITEM
-- CLIMS 
"SELECT "
			+ " cms_convenant.convenant_id, "
            FROM "
			+ " cms_convenant LEFT OUTER JOIN cms_convenant_sub_item "
			+ "  ON cms_convenant.convenant_id = cms_convenant_sub_item.convenant_id "
			+ " cms_recurrent_doc, "
			+ " sci_lsp_lmt_profile "
            			+ " and cms_recurrent_doc.RECURRENT_DOC_ID = cms_convenant.recurrent_doc_id "
			+ " and cms_recurrent_doc.cms_lsp_lmt_profile_id = sci_lsp_lmt_profile.cms_lsp_lmt_profile_id";

--linkage
 public void updateChargeLinkage(long chargeID, String transactionID, long collateralID, String migratedInd, String updateInd) {
        String updateSql = "update CMS_LIMIT_SECURITY_MAP set IS_MIGRATED_IND = ?, UPDATE_STATUS_IND = ?, PLEDGE_PERCENTAGE_DIFF = 10 where CHARGE_ID = ? ";

        getJdbcTemplate().update(updateSql, new Object[] { migratedInd, updateInd, new Long(chargeID) });
        
        updateSql = "update CMS_STAGE_LIMIT_SECURITY_MAP a set IS_MIGRATED_IND = ?, UPDATE_STATUS_IND = ?, PLEDGE_PERCENTAGE_DIFF = 10 where "
        		+ "exists (select 1 from TRANSACTION b where B.TRANSACTION_ID = ? and B.REFERENCE_ID = ? "
        		+ "and B.TRANSACTION_TYPE = 'COL' and B.STAGING_REFERENCE_ID = A.CMS_COLLATERAL_ID) "
        		+ "and exists (select 1 from CMS_LIMIT_SECURITY_MAP c where C.CHARGE_ID = ? "
        		+ "and C.SCI_LAS_SYS_GEN_ID = A.SCI_LAS_SYS_GEN_ID)";
public String getActiveLinkages(long cmsLimitId) {
		String selectSql =  "select distinct S.SECURITY_NO  from  CMS_LIMIT_SECURITY_MAP m, CMS_SECURITY s where S.CMS_COLLATERAL_ID=M.CMS_COLLATERAL_ID and  m.UPDATE_STATUS_IND <> 'D' and m.CMS_LSP_APPR_LMTS_ID= ? ";"

	select lmts.*
    from cms_security s, cms_limit_security_map lsm, sci_lsp_appr_lmts lmts, 
        cms_charge_detail charge
    where s.cms_collateral_id = lsm.cms_collateral_id
        and lsm.CMS_LSP_APPR_LMTS_ID = lmts.CMS_LSP_APPR_LMTS_ID
        and s.cms_collateral_id = charge.CMS_COLLATERAL_ID
        AND appr.LOS_BCA_REF_NUM LIKE "%CAR/22/9002/00640/04911059%";

    FROM   SCI_LSP_LMT_PROFILE PROF
       LEFT OUTER JOIN SCI_LSP_APPR_LMTS LIMITS
         ON PROF.CMS_LSP_LMT_PROFILE_ID = LIMITS.CMS_LIMIT_PROFILE_ID
       LEFT OUTER JOIN CMS_LIMIT_SECURITY_MAP SEC_MAP
         ON LIMITS.CMS_LSP_APPR_LMTS_ID = SEC_MAP.CMS_LSP_APPR_LMTS_ID
       LEFT OUTER JOIN SCI_LSP_CO_BORROW_LMT
         ON LIMITS.CMS_LSP_APPR_LMTS_ID = SCI_LSP_CO_BORROW_LMT.CMS_LIMIT_ID
       LEFT OUTER JOIN CMS_SECURITY SEC
         ON SEC_MAP.CMS_COLLATERAL_ID = SEC.CMS_COLLATERAL_ID;
	

    select sec.*
	from cms_security sec, CMS_LIMIT_SECURITY_MAP lsm, sci_lsp_appr_lmts appr, sci_lsp_lmt_profile lmt
	where sec.CMS_COLLATERAL_ID = lsm.CMS_COLLATERAL_ID
	and lsm.CMS_LSP_APPR_LMTS_ID = appr.CMS_LSP_APPR_LMTS_ID
	and appr.CMS_LIMIT_PROFILE_ID = lmt.CMS_LSP_LMT_PROFILE_ID
    AND appr.LOS_BCA_REF_NUM LIKE "%CAR/22/9002/00640/04911059%";



--SQL 
-- doc
SELECT doc.* FROM sml_doc doc WHERE doc.ca_id = ( SELECT ID FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00640/04911059%') ;

--convenant
SELECT * FROM cms_convenant
LEFT JOIN cms_recurrent_doc ON cms_recurrent_doc.RECURRENT_DOC_ID = cms_convenant.recurrent_doc_id 
LEFT JOIN sci_lsp_lmt_profile ON cms_recurrent_doc.cms_lsp_lmt_profile_id = sci_lsp_lmt_profile.cms_lsp_lmt_profile_id
WHERE sci_lsp_lmt_profile.LOS_BCA_REF_NUM LIKE '%CAR/22/9002/00640/04911059%';

SELECT * FROM CMS_CONVENANT_SUB_ITEM
LEFT JOIN cms_convenant ON cms_convenant.convenant_id = cms_convenant_sub_item.convenant_id
LEFT JOIN cms_recurrent_doc ON cms_recurrent_doc.RECURRENT_DOC_ID = cms_convenant.recurrent_doc_id 
LEFT JOIN sci_lsp_lmt_profile ON cms_recurrent_doc.cms_lsp_lmt_profile_id = sci_lsp_lmt_profile.cms_lsp_lmt_profile_id
WHERE sci_lsp_lmt_profile.LOS_BCA_REF_NUM LIKE '%CAR/22/9002/00640/04911059%';

--linkage 1 
select lmts.*
    from cms_security s, cms_limit_security_map lsm, sci_lsp_appr_lmts lmts, 
        cms_charge_detail charge
    where s.cms_collateral_id = lsm.cms_collateral_id
        and lsm.CMS_LSP_APPR_LMTS_ID = lmts.CMS_LSP_APPR_LMTS_ID
        and s.cms_collateral_id = charge.CMS_COLLATERAL_ID
        AND lmts.LOS_BCA_REF_NUM LIKE "%CAR/22/9002/00640/04911059%";

select s.*
    from cms_security s, cms_limit_security_map lsm, sci_lsp_appr_lmts lmts, 
        cms_charge_detail charge
    where s.cms_collateral_id = lsm.cms_collateral_id
        and lsm.CMS_LSP_APPR_LMTS_ID = lmts.CMS_LSP_APPR_LMTS_ID
        and s.cms_collateral_id = charge.CMS_COLLATERAL_ID
        AND lmts.LOS_BCA_REF_NUM LIKE "%CAR/22/9002/00640/04911059%";

-- linkage 2
SELECT * FROM CMS_CHARGE_DETAIL chrg WHERE chrg.CMS_COLLATERAL_ID IN (SELECT CMS_COLLATERAL_ID FROM CMS_SECURITY WHERE LOS_SECURITY_DTL_ID = 202207260022523353 ) ;

SELECT * 
FROM CMS_FAC_RELATIONSHIP fac JOIN CMS_CHARGE_DETAIL cd
ON fac.CMS_REF_ID = cd.CMS_REF_ID
AND cd.CMS_COLLATERAL_ID IN (SELECT CMS_COLLATERAL_ID FROM CMS_SECURITY WHERE LOS_SECURITY_DTL_ID = 202207260022523353 ) ;

SELECT * 
FROM cms_facility_master fm
LEFT JOIN CMS_FAC_RELATIONSHIP fac
ON fm.ID = fac.CMS_FAC_MASTER_ID
JOIN CMS_CHARGE_DETAIL cd
ON fac.CMS_REF_ID = cd.CMS_REF_ID
AND cd.CMS_COLLATERAL_ID IN (SELECT CMS_COLLATERAL_ID FROM CMS_SECURITY WHERE LOS_SECURITY_DTL_ID = 202207260022523353 ) ;

--linkage 3
SELECT FAC.* FROM SML_CHARGE_FACILITY_MAP CHARGE_FACILITY
INNER JOIN SML_FACILITY FAC ON CHARGE_FACILITY.FACILITY_ID = FAC.ID
AND FAC.CA_ID = ( SELECT ID FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00640/04911059%') ;

SELECT CHARGE_FACILITY.* FROM SML_CHARGE_FACILITY_MAP CHARGE_FACILITY
INNER JOIN SML_FACILITY FAC ON CHARGE_FACILITY.FACILITY_ID = FAC.ID
AND FAC.CA_ID = ( SELECT ID FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00640/04911059%') ;

SELECT CHARGE.* FROM SML_CHARGE_FACILITY_MAP CHARGE_FACILITY
INNER JOIN SML_FACILITY FAC ON CHARGE_FACILITY.FACILITY_ID = FAC.ID
INNER JOIN SML_CHARGE_DETAIL CHARGE ON CHARGE.ID = CHARGE_FACILITY.CHARGE_DETAIL_ID
AND FAC.CA_ID = ( SELECT ID FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00640/04911059%') ;

-- LE_SUB_ MAIN_PROFILE
SELECT sci_le_sub_profile.*
FROM cms_checklist
    LEFT OUTER JOIN cms_cust_doc ON cms_checklist.checklist_id = cms_cust_doc.checklist_id
    LEFT OUTER JOIN sci_le_sub_profile ON sci_le_sub_profile.CMS_LE_SUB_PROFILE_ID = cms_checklist.CMS_LMP_SUB_PROFILE_ID
    JOIN cms_security ON cms_checklist.cms_collateral_id = cms_security.cms_collateral_id
WHERE cms_security.CMS_COLLATERAL_ID IN (
        select CMS_COLLATERAL_ID
        from cms_ca_collateral_map map
        where map.los_bca_ref_num LIKE '%CAR/22/9002/00640/04911059%'
    );
SELECT sci_le_main_profile.*
FROM cms_checklist
    LEFT OUTER JOIN cms_cust_doc ON cms_checklist.checklist_id = cms_cust_doc.checklist_id
    LEFT OUTER JOIN sci_le_sub_profile ON sci_le_sub_profile.CMS_LE_SUB_PROFILE_ID = cms_checklist.CMS_LMP_SUB_PROFILE_ID
    LEFT OUTER JOIN sci_le_main_profile ON sci_le_main_profile.CMS_LE_MAIN_PROFILE_ID = sci_le_sub_profile.CMS_LE_MAIN_PROFILE_ID
    JOIN cms_security ON cms_checklist.cms_collateral_id = cms_security.cms_collateral_id
WHERE cms_security.CMS_COLLATERAL_ID IN (
        select CMS_COLLATERAL_ID
        from cms_ca_collateral_map map
        where map.los_bca_ref_num LIKE '%CAR/22/9002/00640/04911059%'
    );


-- SEND BANK


-- AGAIN 8292022 / CLOS
-- doc
SELECT doc.* FROM sml_doc doc WHERE doc.ca_id = ( SELECT ID FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00640/04911059%') ;

-- convenant
SELECT * FROM SML_FP_TNC tnc 
where tnc.CA_ID IN (SELECT ID FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00640/04911059%');

--linkage
SELECT CHARGE_FACILITY.* FROM SML_CHARGE_FACILITY_MAP CHARGE_FACILITY
INNER JOIN SML_FACILITY FAC ON CHARGE_FACILITY.FACILITY_ID = FAC.ID
INNER JOIN SML_CHARGE_DETAIL CHARGE ON CHARGE.ID = CHARGE_FACILITY.CHARGE_DETAIL_ID
AND FAC.CA_ID = ( SELECT ID FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00640/04911059%') ;

SELECT FAC.* FROM SML_CHARGE_FACILITY_MAP CHARGE_FACILITY
INNER JOIN SML_FACILITY FAC ON CHARGE_FACILITY.FACILITY_ID = FAC.ID
INNER JOIN SML_CHARGE_DETAIL CHARGE ON CHARGE.ID = CHARGE_FACILITY.CHARGE_DETAIL_ID
AND FAC.CA_ID = ( SELECT ID FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00640/04911059%') ;

--facility
SELECT * FROM SML_FACILITY FAC INNER JOIN SML_CA CA ON FAC.CA_ID = CA.ID AND CA. CA_NUMBER LIKE '%CAR/22/9002/00640/04911059%' ;
