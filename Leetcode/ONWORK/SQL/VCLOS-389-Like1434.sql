--DES: duplicate collacteral / sec in cms cause this err: 
-- Solution: check dup by query and then deplete script

-- CLOS
SELECT * FROM SML_SECURITY WHERE ID = '202306020006250597';

SELECT * FROM SML_CHARGE_DETAIL WHERE COLLATERAL_ID = '202306020006250597' ;

-- CMS
SELECT * FROM CMS_SECURITY_SOURCE WHERE SOURCE_SECURITY_ID = '202306020006250597' AND SOURCE_ID = 'CLOS';
SELECT s.cms_collateral_id,s.* FROM cms_security s WHERE s.los_security_dtl_id = '202306020006250597' AND s.source_id = 'CLOS' ;

SELECT * FROM CMS_SECURITY WHERE cms_collateral_id= '20230601007555959' ;

SELECT * FROM cms_ca_collateral_map ;


--query 2: 
SELECT * FROM CMS_SECURITY_SOURCE WHERE SOURCE_SECURITY_ID = '202306020006250597' AND SOURCE_ID = 'CLOS';
SELECT s.cms_collateral_id,s.* FROM cms_security s WHERE s.los_security_dtl_id = '202306020006250597' AND s.source_id = 'CLOS' ;
SELECT * FROM CMS_SECURITY_SOURCE WHERE SOURCE_SECURITY_ID = '202306020006250597' AND SOURCE_ID = 'CLOS';
SELECT s.cms_collateral_id,s.* FROM cms_security s WHERE s.los_security_dtl_id = '202306020006250597' AND s.source_id = 'CLOS' ;
SELECT * FROM CMS_SECURITY_SOURCE WHERE SOURCE_SECURITY_ID = '202306020006250597' AND SOURCE_ID = 'CLOS';
SELECT s.cms_collateral_id,s.* FROM cms_security s WHERE s.los_security_dtl_id = '202306020006250597' AND s.source_id = 'CLOS' ;

-- CLOS
SELECT * FROM SML_SECURITY WHERE ID = '202306020006250597';

-- CMS
SELECT * FROM CMS_SECURITY_SOURCE WHERE SOURCE_SECURITY_ID = '202306020006250597' AND SOURCE_ID = 'CLOS';
SELECT s.cms_collateral_id,s.* FROM cms_security s WHERE s.los_security_dtl_id = '202306020006250597' AND s.source_id = 'CLOS' ;

--QUERY 3 :
--CLOS UAT
SELECT * FROM SML_CHARGE_DETAIL WHERE COLLATERAL_ID = '202306020006250597' ;
-- CMS UAT
SELECT * FROM CMS_SECURITY WHERE cms_collateral_id= '20230601007555959' ;
SELECT * FROM cms_ca_collateral_map WHERE los_bca_ref_num = 'CAR/23/9001/00343/01304689';
SELECT * FROM cms_ca_collateral_map WHERE SECURITY_NO = 'PT202306010006250570';

-- UP HERE STILL FINE:
-- QUERY 4: 
SELECT * FROM SML_SECURITY COLL WHERE COLL.ID IN
 (SELECT COLLATERAL_ID FROM SML_CA_COLLATERAL WHERE CA_ID = 
 (SELECT ID FROM sml_ca ca where ca.ca_number = 'CAR/23/9001/00343/01304689')) ;

SELECT * FROM SML_CHARGE_DETAIL WHERE COLLATERAL_ID IN 
(SELECT COLLATERAL_ID FROM SML_CA_COLLATERAL WHERE CA_ID = 
 (SELECT ID FROM sml_ca ca where ca.ca_number = 'CAR/23/9001/00343/01304689')) ;


--VCLOSPRODA 1434
DELETE FROM CMS_SECURITY WHERE CMS_COLLATERAL_ID = 20220525020185210;
DELETE FROM SCI_SEC_PLDGR_MAP WHERE CMS_SEC_PLDGR_MAP_ID = 20220525041131831;
DELETE FROM CMS_CASH WHERE CMS_COLLATERAL_ID = 20220525020185210;
DELETE FROM CMS_CASH_DEPOSIT WHERE CMS_COLLATERAL_ID = 20220525020185210;
DELETE FROM TRANSACTION WHERE transaction_type = 'COL' and reference_id = 20220525020185210 ;
COMMIT ;


-- CLOS investivate
public List<IChargeDetail> getAllChargeDetailsByCollateralID(long collateralID){
        DetachedCriteria criteria = DetachedCriteria.forClass(OBChargeDetail.class);
        criteria.add(Restrictions.eq("collateralID", collateralID));
        List<IChargeDetail> chargeDetailList = findByCriteria(criteria);

        return chargeDetailList == null ? new ArrayList<IChargeDetail>() : chargeDetailList;
    }

-- note
    if (caCollateral != null && caCollateral.getCollateral() != null) {
                        List<IChargeDetail> chargeDetailList =
                                chargeDetailDAO.getAllChargeDetailsByCollateralID(caCollateral.getCollateral().getId());


--CHECK MORE CHECK LIST: 
cms
if (DocumentConstants.CHECKLIST_TYPE_COLLATERAL.equalsIgnoreCase(checklistType)) {
			SCChecklist sc = checkList.getScChecklist();

			if (sc.getCmsCollateralID() > 0){
				ApprovedSecurity sec = getDocumentJdbcDao().getCollateralByID(sc.getCmsCollateralID());
				if (sec == null) {
					throw new NoSuchSecurityException(checkList.getScChecklist().getCmsCollateralID());
				}
//				sc.setCmsCollateralID(sec.getCMSSecurityId());
				origCountry = sec.getSecurityLocation().getLocationCountry();
				origOrganisation = sec.getSecurityLocation().getLocationOrganisation();
			} 

        