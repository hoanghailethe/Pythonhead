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

SELECT * FROM SML_DOC WHERE CA_ID IN ((SELECT ID FROM sml_ca ca where ca.ca_number = 'CAR/23/9001/00343/01304689')) ; 

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

        
-- CLOS before send: 
List collDocList = documentationBO.getUpdateCollDocList(caId);
				List cncDocList = documentationBO.getCNCDocList(caId);
				documents.addAll(cncDocList);
				documents.addAll(collDocList);

update.coll.doc.list

sql :
SELECT doc.id AS id,
                                           doc.version_time AS version_time,
                                           doc.app_typ AS app_type,
                                           doc.los_fac_id AS los_fac_id,
                                           doc.los_coll_id AS los_coll_id,
                                           coll.source_security_sub_type AS coll_code,
                                           (SELECT type_code
                                              FROM sml_sec_type
                                             WHERE id = coll.type_id)
                                              AS sec_typ_code,
                                           (SELECT subtype_code
                                              FROM sml_sec_sub_type
                                             WHERE id = coll.subtype_id)
                                              AS sec_sub_typ_code,
                                           coll.security_location AS country_code,
                                           cou.ctr_cntry_name AS country_dscp
                                      FROM    sml_doc doc
                                           INNER JOIN
                                                 sml_security coll
                                              INNER JOIN
                                                 sci_country cou
                                              ON coll.security_location = cou.ctr_cntry_iso_code 
                                           ON     doc.los_coll_id = coll.id
                                              AND doc.ca_id = :ca_id_in
                                              AND doc.checklist_type = :checklist_type_in
                                              AND (coll.status != 'DELETED'
                                                   OR coll.status IS NULL)
                                                   WHERE (SELECT COUNT (1) FROM sml_doc_item di WHERE di.DOC_ID = doc.id AND di.CMS_NO IS NULL) > 0


update.cnc.doc.list:
    <class name="com.integrosys.sml.app.documentation.vo.OBDoc"
        table="SML_DOC" lazy="false" entity-name="docListByIdOrderByDesc">
