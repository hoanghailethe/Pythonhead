-- fAc and COL related
<class entity-name="actualLimitGeneral" name="com.integrosys.cms.host.eai.limit.bus.LimitGeneral" table="SCI_LSP_APPR_LMTS" lazy="false">
    <class entity-name="actualLimitGeneral" name="com.integrosys.cms.host.eai.limit.bus.LimitGeneral" table="SCI_LSP_APPR_LMTS" lazy="false">
        <id name="cmsId" column="CMS_LSP_APPR_LMTS_ID" type="long">
        
select m.id, l.CMS_LSP_APPR_LMTS_ID, l.LMT_OUTER_LMT_ID, 0, t.status " +
                        "from sci_lsp_appr_lmts l, transaction t, cms_facility_master m " +
                        "where m.id = t.reference_id " +
                          "and t.transaction_type = 'FACILITY' " +
                          "and l.CMS_LSP_APPR_LMTS_ID = m.CMS_LSP_APPR_LMTS_ID " +
                          "and l.CMS_LSP_APPR_LMTS_ID = ? " +
                        "union all " +
                        "select m.id, l.CMS_LSP_APPR_LMTS_ID, l.LMT_OUTER_LMT_ID, case when y.CMS_LSP_APPR_LMTS_ID = l.CMS_LSP_APPR_LMTS_ID then 1 else 0 end, t.status " +
                         "from sci_lsp_appr_lmts l, transaction t, cms_facility_master m, tempTable y " +
                         "where m.id = t.reference_id " +
                           "and t.transaction_type = 'FACILITY' " +
                           "and l.CMS_LSP_APPR_LMTS_ID = m.CMS_LSP_APPR_LMTS_ID " +
                           "and l.LMT_OUTER_LMT_ID = y.CMS_LSP_APPR_LMTS_ID and stop = 0


select l.CMS_LSP_APPR_LMTS_ID, l.LMT_OUTER_LMT_ID from sci_lsp_appr_lmts l " +
				"where l.CMS_LSP_APPR_LMTS_ID = ? " +
				"union all " +
				"select l.CMS_LSP_APPR_LMTS_ID, l.LMT_OUTER_LMT_ID from sci_lsp_appr_lmts l, tempTable y, CMS_FACILITY_MASTER f, CMS_FAC_GENERAL g " +
				"where L.CMS_LSP_APPR_LMTS_ID= F.CMS_LSP_APPR_LMTS_ID and F.ID= G.CMS_FAC_MASTER_ID and G.FAC_STATUS_CODE_VALUE ='A' " +
				"and l.CMS_LSP_APPR_LMTS_ID = y.LMT_OUTER_LMT_ID 


                 sql.append("select g.FAC_STATUS_CODE_VALUE, lmt.LMT_OUTER_LMT_ID, lmt.cms_lsp_appr_lmts_id ")
        .append("from SCI_LSP_APPR_LMTS lmt, cms_stg_facility_master fac, transaction t, CMS_STG_FAC_GENERAL g ")
        .append("where fac.id = t.staging_reference_id ")
        .append("and lmt.cms_lsp_appr_lmts_id = fac.cms_lsp_appr_lmts_id ")
        .append("and t.transaction_type = 'FACILITY' ")
        .append("and g.CMS_FAC_MASTER_ID = fac.id ")
        .append("and t.transaction_id = ? ");

        D:\VTBCLIMS\config\hibernate\EAI-Facility.hbm.xml
            <class entity-name="actualFacMaster" name="FacilityMaster" table="CMS_FACILITY_MASTER" lazy="false" polymorphism="explicit">
            --related to other tables

-- FACILITY 
            CMS_FAC_MASTER_ID  ==> MS_FAC_RELATIONSHIP, CMS_FAC_MULTI_TIER_FINANCING, CMS_FAC_PREPAYMENT_LIST, CMS_FAC_REDUCTION_SCHEDULE,
                        CMS_LSP_APPR_DRAWING_CURR , CMS_FAC_MESSAGE , actualFacIncremental , CMS_FAC_REDUCTION_SCHEDULE, 
                join        CMS_FAC_GENERAL, CMS_FAC_INTEREST , CMS_FAC_ADDITIONAL , CMS_FAC_FEE_CHARGE, CMS_FAC_BNM_CODES , CMS_FAC_ISLAMIC_MASTER,
                        CMS_FAC_BBA_VARI_PACKAGE , CMS_FAC_RENTAL_RENEWAL , CMS_FAC_SECURITY_DEPOSIT , CMS_FAC_SECURITY_DEPOSIT ,
                        CMS_FAC_TSPR , CMS_STG_FAC_GENERAL , CMS_STG_FAC_INTEREST , CMS_STG_FAC_ADDITIONAL , CMS_STG_FAC_FEE_CHARGE, 
                        CMS_STG_FAC_BNM_CODES , CMS_STG_FAC_PAYMENT , CMS_STG_FAC_ISLAMIC_MASTER , CMS_STG_FAC_BBA_VARI_PACKAGE ,
                        CMS_STG_FAC_RENTAL_RENEWAL , CMS_STG_FAC_SECURITY_DEPOSIT, CMS_STG_FAC_TSPR 


           -- COL --SECURITY - DOC
CLIMS MESSAGE HADLER
				<entry key="SECURITY" value-ref="securityMessageHandler" />
				<entry key="SECURITY.INQUIRY" value-ref="securityInquiryMessageHandler" />
				<entry key="SECURITY.INQUIRY.C" value-ref="securityListingInquiryMessageHandler" />

                <entry key="DOCUMENT.INQUIRY" value-ref="docChecklistInquiryMessageHandler" />
				<entry key="DOCUMENT" value-ref="documentInputMessageHandler" />
D:\VTBCLIMS\src\com\integrosys\cms\app\collateral\bus\SBCollateralBusManagerBean.java

public ICollateral createCollateral(ICollateral collateral) throws CollateralException {
		collateral = super.createCollateral(collateral);

		try {
			EBCollateralHome ejbHome = getEBCollateralHome();
			EBCollateral theEjb = ejbHome.create(collateral);

			theEjb.createDependants(collateral, theEjb.getVersionTime(), true);

			ICollateral latestCol = theEjb.getValue(collateral);

			if (!(collateral instanceof com.integrosys.cms.app.collateral.bus.type.nocollateral.INoCollateral)) {
				EBCollateralDetailHome detHome = getEBCollateralDetailHome(latestCol);
				EBCollateralDetail detEjb = detHome.create(latestCol);
				latestCol = detEjb.getValue(latestCol);
			}
			return setDerivedFields(latestCol);

CMS_SECURITY
cms_limit_security_map    collateral_id = lsm.cms_collateral_id
cms_cash_deposit d  where s.cms_collateral_id = d.CMS_COLLATERAL_ID
cms_guarantee g 
sci_sec_pldgr_map
cms_property p  where s.cms_collateral_id = p.cms_collateral_id
CMS_LIMIT_CHARGE_MAP  MAP1  MAP1.CMS_COLLATERAL_ID = SEC.CMS_COLLATERAL_ID 


D:\VTBCLIMS\src\com\integrosys\cms\host\eai\document\actualtrxhandler\CheckListPersistentHandler.java

goto COLLATERALDAO
	private static String SELECT_COLLATERAL_WITH_AA = "SELECT cms_security.SCI_SECURITY_DTL_ID, cms_security.CMS_COLLATERAL_ID "
			+ "FROM cms_security_sub_type, cms_security_source SOURCE, cms_limit_security_map lsm, "
			+ "sci_lsp_appr_lmts lmt, sci_lsp_lmt_profile aa, cms_security "
			+ "LEFT OUTER JOIN sci_sec_pldgr_map "
			+ "ON sci_sec_pldgr_map.cms_collateral_id = cms_security.cms_collateral_id "
			+ "LEFT OUTER JOIN sci_pledgor_dtl "
			+ "ON sci_sec_pldgr_map.cms_pledgor_dtl_id = sci_pledgor_dtl.cms_pledgor_dtl_id "
			+ "WHERE source.CMS_COLLATERAL_ID = cms_security.CMS_COLLATERAL_ID "
			+ "AND cms_security_sub_type.SECURITY_SUB_TYPE_ID = cms_security.SECURITY_SUB_TYPE_ID "
			+ "AND cms_security.cms_collateral_id = lsm.cms_collateral_id "
			+ "AND lsm.cms_lsp_appr_lmts_id = lmt.cms_lsp_appr_lmts_id "
			+ "AND lmt.cms_limit_profile_id = aa.cms_lsp_lmt_profile_id ";


            from cms_security s, cms_cash_deposit d
						where s.cms_collateral_id = d.CMS_COLLATERAL_ID
						and d.STATUS = 'ACTIVE'
						and s.status = 'ACTIVE'
						and s.SOURCE_SECURITY_TYPE = 'DEP'

                        from cms_security s, cms_guarantee g, sci_sec_pldgr_map spm, sci_pledgor_dtl p
						where s.cms_collateral_id = g.cms_collateral_id 
						and s.cms_collateral_id = spm.CMS_COLLATERAL_ID
						and spm.CMS_PLEDGOR_DTL_ID = p.CMS_PLEDGOR_DTL_ID
						and spm.UPDATE_STATUS_IND <> 'D'
						and p.UPDATE_STATUS_IND <> 'D'
						and s.status = 'ACTIVE'
						and s.SOURCE_SECURITY_TYPE = 'LG'
						and s.sci_security_dtl_id is not null

                        from cms_security s, cms_guarantee g
						where s.cms_collateral_id = g.cms_collateral_id
						and s.status = 'ACTIVE'
						and s.SOURCE_SECURITY_TYPE = 'LC'
						and s.sci_security_dtl_id is not null

                        from cms_security s, cms_property p
						where s.cms_collateral_id = p.cms_collateral_id
						and s.status = 'ACTIVE'
						and s.SOURCE_SECURITY_TYPE = 'RE'
						and s.sci_security_dtl_id is not null

                        "LEFT OUTER JOIN  cms_checklist_item parent_item  "
			+ "ON  cms_checklist_item.parent_checklist_item_ref  = parent_item.doc_item_ref, "
			+ "sci_le_main_profile  RIGHT OUTER JOIN  sci_le_sub_profile  "
			+ "ON  sci_le_main_profile.cms_le_main_profile_id  = sci_le_sub_profile.cms_le_main_profile_id   "
			+ "RIGHT OUTER JOIN  cms_checklist  ON  sci_le_sub_profile.cms_le_sub_profile_id  = cms_checklist.cms_lmp_sub_profile_id, "
			+ "cms_security, "

            FROM sci_pledgor_dtl," + "  sci_sec_pldgr_map,"
			+ "  cms_security," + "  cms_limit_security_map," + "  sci_lsp_appr_lmts "
			+ "WHERE sci_pledgor_dtl.cms_pledgor_dtl_id = sci_sec_pldgr_map.cms_pledgor_dtl_id"
			+ "  AND sci_sec_pldgr_map.cms_collateral_id = cms_security.cms_collateral_id"
			+ "  AND cms_security.cms_collateral_id = cms_limit_security_map.cms_collateral_id"
			+ "  AND cms_limit_security_map.cms_lsp_appr_lmts_id = sci_lsp_appr_lmts.cms_lsp_appr_lmts_id

            FROM CMS_SECURITY sec, CMS_LIMIT_SECURITY_MAP map "
                + "     WHERE sec.CMS_COLLATERAL_ID = map.CMS_COLLATERAL_ID

                FROM SCI_LSP_APPR_LMTS LMT1, CMS_LIMIT_CHARGE_MAP  MAP1, " + "CMS_SECURITY SEC "
                + "WHERE LMT1.CMS_LSP_APPR_LMTS_ID = ? AND "
                + "LMT1.CMS_LSP_APPR_LMTS_ID = MAP1.CMS_LSP_APPR_LMTS_ID AND " + "MAP1.STATUS = 'ACTIVE' AND "
                + "MAP1.CMS_COLLATERAL_ID = SEC.CMS_COLLATERAL_ID AND " + "SEC.STATUS = 'ACTIVE'

                SELECT LMT1.LCL_ID, SEC.CMS_COLLATERAL_ID, "
                + "CONVERT_AMT(SEC.FSV_BALANCE, SEC.FSV_BALANCE_CCY, SEC.FSV_CURRENCY), SEC.FSV_CURRENCY "
                + "FROM SCI_LSP_CO_BORROW_LMT LMT1, CMS_LIMIT_CHARGE_MAP  MAP1, " + "CMS_SECURITY SEC "
                + "WHERE LMT1.CMS_LSP_CO_BORROW_LMT_ID = ? AND "
                + "LMT1.CMS_LSP_CO_BORROW_LMT_ID = MAP1.CMS_LSP_CO_BORROW_LMT_ID AND " + "MAP1.STATUS = 'ACTIVE' AND "
                + "MAP1.CMS_COLLATERAL_ID = SEC.CMS_COLLATERAL_ID AND " + "SEC.STATUS = 'ACTIVE'


FROM cms_price_feed pf, cms_security sec, cms_portfolio_item pi
				WHERE sec.cms_collateral_id = pi.cms_collateral_id


-- HO SO TSDB
sci_lsp_appr_lmts limits
cms_checklist
cms_checklist_item    CHECKLIST_ID

-- tim them qua cms colateral ID
 FROM   cms_portfolio_item portfolio
          WHERE  portfolio.cms_collateral_id = sec.cms_collateral_id

          FROM   cms_cash_deposit deposit
          WHERE  deposit.cms_collateral_id = sec.cms_collateral_id

        SELECT COUNT(*) FROM CMS_FACILITY_MASTER;
        SELECT COUNT(*) FROM CMS_DOCUMENT;
        SELECT COUNT(*) FROM CMS_FACILITY_MASTER;
        SELECT COUNT(*) FROM CMS_FACILITY_MASTER;



-- 9/6/2022 CONCLUDED

-- FACILITY 
CMS_FACILITY_MASTER <= ( CMS_FAC_MASTER_ID ) = MS_FAC_RELATIONSHIP, CMS_FAC_MULTI_TIER_FINANCING, CMS_FAC_PREPAYMENT_LIST, CMS_FAC_REDUCTION_SCHEDULE,
												CMS_LSP_APPR_DRAWING_CURR , CMS_FAC_MESSAGE , CMS_FAC_INCREMENTAL , CMS_FAC_REDUCTION_SCHEDULE, 
												CMS_FAC_GENERAL, CMS_FAC_INTEREST , CMS_FAC_ADDITIONAL , CMS_FAC_FEE_CHARGE, CMS_FAC_BNM_CODES , CMS_FAC_ISLAMIC_MASTER,
												CMS_FAC_BBA_VARI_PACKAGE , CMS_FAC_RENTAL_RENEWAL , CMS_FAC_SECURITY_DEPOSIT , CMS_FAC_SECURITY_DEPOSIT ,
												CMS_FAC_TSPR , CMS_STG_FAC_GENERAL , CMS_STG_FAC_INTEREST , CMS_STG_FAC_ADDITIONAL , CMS_STG_FAC_FEE_CHARGE, 
												CMS_STG_FAC_BNM_CODES , CMS_STG_FAC_PAYMENT , CMS_STG_FAC_ISLAMIC_MASTER , CMS_STG_FAC_BBA_VARI_PACKAGE ,
												CMS_STG_FAC_RENTAL_RENEWAL , CMS_STG_FAC_SECURITY_DEPOSIT, CMS_STG_FAC_TSPR 

-- COL (TSBĐ)
CMS_SECURITY  <= ( cms_collateral_id ) = cms_limit_security_map, cms_cash_deposit , cms_guarantee , sci_sec_pldgr_map, cms_property ,cms_checklist , cms_ca_collateral_map
										 CMS_LIMIT_CHARGE_MAP     <=  ( CMS_LSP_APPR_LMTS_ID ) = SCI_LSP_APPR_LMTS 

-- HO SO TSBĐ
cms_checklist  <= ( CHECKLIST_ID ) = cms_checklist_item  stage_checklist_item   <= ( doc_item_ref == checklist_item_ref_id ) = cms_cust_doc_item
stage_checklist						 cms_cust_doc 																				stage_cust_doc_item

									cms_stage_cust_doc			<= ( custodian_doc_id) =	  stage_cust_doc_item

cms_stage_cust_doc <= ( custodian_doc_id == staging_reference_id ) = TRANSACTION
								TRANSACTION_TYPE = 'CUSTODIAN'
STAGE_CHECKLIST_ITEM <= ( CHECKLIST_ID == staging_reference_id ) = TRANSACTION
								TRANSACTION_TYPE = 'CHECKLIST'

cms_stage_cust_doc_item

SELECT stage_cust_doc_item.checklist_item_ref_id, "
				+ "			 		    	MAX(stage_cust_doc_item.custodian_doc_item_id) custodian_doc_item_id "
				+ "		   			 FROM  cms_stage_cust_doc stage_cust_doc, "
				+ "			 			   cms_stage_cust_doc_item stage_cust_doc_item  "
				+ "		  			 WHERE  stage_cust_doc.custodian_doc_id  = stage_cust_doc_item.custodian_doc_id
				GROUP BY  stage_cust_doc_item.checklist_item_ref_id  "
				+ "	        ) max_stage_cust_doc  "


				+ "	  WHERE TRANSACTION.transaction_type  = 'CUSTODIAN' "
				+ "	   AND  TRANSACTION.staging_reference_id  = cms_stage_cust_doc.custodian_doc_id "
				+ "	   AND  cms_stage_cust_doc.custodian_doc_id  = cms_stage_cust_doc_item.custodian_doc_id "
				+ "	   AND  cms_stage_cust_doc_item.custodian_doc_item_id  = max_stage_cust_doc.custodian_doc_item_id "
				+ "    AND  TRANSACTION.status  <> 'CLOSED' "
				+ " ) custodian_trx  ON  cms_checklist_item.doc_item_ref  = custodian_trx.checklist_item_ref_id  , "
				+ "	stage_checklist_item  "
				+ "WHERE cms_checklist.checklist_id  = cms_checklist_item.checklist_id "
				+ "AND	 cms_checklist_item.is_deleted  = 'N' "
                + "AND   (cms_checklist_item.status = 'COMPLETED' OR cms_checklist_item.status = 'DEFERRED') "
//				+ "AND	(cms_checklist_item.status  <> 'DELETED' OR (cms_checklist_item.status  = 'DELETED' AND	custodian_trx.status  IS NOT NULL)) "
				+ "AND	stage_checklist_item.doc_item_id  = (SELECT MAX(stage_chklist_item.doc_item_id) "
				+ "		                             FROM  stage_checklist_item stage_chklist_item  "
				+ "		                             WHERE stage_chklist_item.doc_item_ref  = cms_checklist_item.doc_item_ref) 

				SELECT stage.custodian_doc_item_barcode "
   	     + " FROM CMS_STAGE_CUST_DOC_ITEM stage, transaction t "
   	     + " WHERE CUSTODIAN_DOC_ID = t.STAGING_REFERENCE_ID "
   	     + " AND t.TRANSACTION_TYPE = 'CUSTODIAN' AND t.STATUS IN ('PENDING_CREATE','PENDING_UPDATE') "
   	     + " AND stage.status NOT IN ('RECEIVED', 'PERM_UPLIFTED') "
   	     + " AND stage.sec_envelope_barcode IS NOT NULL AND stage.sec_envelope_barcode in ("
   	     + " select EI.SEC_ENVELOPE_ITEM_BARCODE  from TRANSACTION t, "
   	     + " CMS_SEC_ENVELOPE_ITEM ei where T.TRANSACTION_TYPE = 'SEC_ENVELOPE' and T.TRANSACTION_ID = ? "
   	     + " and EI.SEC_ENVELOPE_ID= T.REFERENCE_ID "
   	     + " minus "
   	     + " select SEI.SEC_ENVELOPE_ITEM_BARCODE from "
   	     + " TRANSACTION t, CMS_STAGE_SEC_ENVELOPE_ITEM sei "
   	     + " where T.TRANSACTION_TYPE=  'SEC_ENVELOPE' and T.TRANSACTION_ID = ? "
   	     + " and SEI.SEC_ENVELOPE_ID= T.STAGING_REFERENCE_ID)

 "left outer join  cms_cust_doc ON cms_checklist.checklist_id  = cms_cust_doc.checklist_id\n" +
  "cms_checklist_item \n" +
            "LEFT OUTER JOIN  cms_cust_doc_item  ON \n" +
            "cms_checklist_item.doc_item_ref  = cms_cust_doc_item.checklist_item_ref_id \n" +

			FROM stage_checklist_item s LEFT OUTER JOIN CMS_CUST_DOC_ITEM cust ON cust.CHECKLIST_ITEM_REF_ID = s.DOC_ITEM_REF, "
				+ "       cms_checklist_item citem, " + "       TRANSACTION t, " + "       sci_lsp_lmt_profile, "
				+ "       sci_le_sub_profile, " + "       sci_le_main_profile, " + "       stage_checklist, "

				AND t.transaction_type = 'CHECKLIST' "
				+ "  	AND t.status NOT IN ('OBSOLETE', 'CLOSED', 'PENDING_CREATE') "
				+ "   AND t.staging_reference_id = stage_checklist.checklist_id "
				+ "   AND t.reference_id = citem.checklist_id " + "   AND citem.expiry_date IS NOT NULL "
				+ "   AND s.doc_item_ref = citem.doc_item_ref "

				Transaction 
TRANSACTION

 FROM TRANSACTION trans 
                             WHERE trans.TRANSACTION_TYPE = 'COL' 
                             AND trans.REFERENCE_ID = pt.CMS_COLLATERAL_ID

SELECT DISTINCT(transaction_type) FROM TRANSACTION;


			+ " FROM CMS_DOCUMENT_GLOBALLIST, CMS_DOC_LOAN_APP_TYPE , TRANSACTION WHERE CMS_DOCUMENT_GLOBALLIST.DOCUMENT_ID = TRANSACTION.REFERENCE_ID "
			+ " AND CMS_DOC_LOAN_APP_TYPE.DOCUMENT_ID = CMS_DOCUMENT_GLOBALLIST.DOCUMENT_ID "
			+ " AND TRANSACTION.TRANSACTION_TYPE = 'DOCITEM'"

			FROM CMS_DOCUMENT_GLOBALLIST, CMS_DOC_LOAN_APP_TYPE , TRANSACTION WHERE CMS_DOCUMENT_GLOBALLIST.DOCUMENT_ID = TRANSACTION.REFERENCE_ID "
			+ " AND CMS_DOC_LOAN_APP_TYPE.DOCUMENT_ID = CMS_DOCUMENT_GLOBALLIST.DOCUMENT_ID "
			+ " AND TRANSACTION.TRANSACTION_TYPE = 'DOCITEM'";

			stg_chk.DOC_ORIG_COUNTRY " + "FROM TRANSACTION trx, "
			+ "     STAGE_CHECKLIST_ITEM stg_chk_item, " + "     SCI_LSP_LMT_PROFILE lp, "
			+ "     SCI_LE_SUB_PROFILE sp, " + "     STAGE_CHECKLIST stg_chk LEFT OUTER JOIN  "
			+ "       CMS_SECURITY sec ON sec.CMS_COLLATERAL_ID = stg_chk.CMS_COLLATERAL_ID "
			+ "WHERE trx.STAGING_REFERENCE_ID = stg_chk_item.CHECKLIST_ID "
			+ "      AND stg_chk.CHECKLIST_ID = stg_chk_item.CHECKLIST_ID "
			+ "      AND trx.TRANSACTION_TYPE = 'CHECKLIST' "
			+ "      AND stg_chk.CMS_LSP_LMT_PROFILE_ID = lp.CMS_LSP_LMT_PROFILE_ID "
			+ "      AND lp.CMS_CUSTOMER_ID = sp.CMS_LE_SUB_PROFILE_ID " + "      AND stg_chk_item.doc_item_ref";


-- COL
-- check CLOS
8 loại TSBĐ
AB , CS, DC, GT, IN, MS, OP, PT 

--find table Sec_subtype
SELECT * FROM user_tables where table_name like '%ASSET%';
SELECT * FROM user_tables where table_name like '%CASH%';



SELECT * FROM CMS_SECURITY WHERE CMS_COLLATERAL_ID IN ( 20220726020559087, 20220726020559085);
SELECT * FROM CMS_ASSET;
SELECT * FROM CMS_CASH;
SELECT * FROM SCI_PLEDGOR_DTL;
SELECT * FROM SCI_SEC_PLDGR_MAP;


SELECT * FROM user_tables where table_name like '%ASSET%';
SELECT * FROM CMS_ASSET_VEHICLE WHERE cms_collateral_id IN (20220726020559087, 20220726020559085) ;

SELECT * FROM CMS_STAGE_ASSET_VEHICLE WHERE cms_collateral_id IN (20220726020559087, 20220726020559085) ;

SELECT* FROM CMS_SECURITY_SUB_TYPE;

-- add thí for case 1438
SELECT * FROM CMS_ASSET_VEHICLE WHERE cms_collateral_id IN (20220726020559087, 20220726020559085) ;


--cms ASSET
"FROM CMS_ASSET A, CMS_SECURITY COL " + "WHERE A.CMS_COLLATERAL_ID = ? "
				+ "AND A.CMS_COLLATERAL_ID = COL.CMS_COLLATERAL_ID";

				FROM CMS_ASSET_PDC WHERE CMS_COLLATERAL_ID = 

			+ "           FROM cms_asset asst LEFT OUTER JOIN cms_asst_gc_debtor dbt  "
			+ "           ON asst.cms_collateral_id = dbt.cms_collateral_id, " + "                cms_security sec "
			+ "          WHERE sec.security_sub_type_id = 'AB100' "
			+ "            AND sec.cms_collateral_id = asst.cms_collateral_id " + "            AND NOT EXISTS ( "


			+ "           FROM cms_asset asst LEFT OUTER JOIN cms_asst_gc_debtor dbt  "
			+ "               ON asst.cms_collateral_id = dbt.cms_collateral_id, "
			+ "                cms_security sec, cms_asst_gc_stock stk "
			+ "          WHERE sec.security_sub_type_id = 'AB100' "
			+ "            AND sec.cms_collateral_id = asst.cms_collateral_id "
			+ "            AND asst.cms_collateral_id = stk.cms_collateral_id "

					buf.append("FROM cms_asset asset LEFT OUTER JOIN cms_asset_vehicle veh ON ");
		buf.append("asset.cms_collateral_id = veh.cms_collateral_id WHERE asset.cms_collateral_id IN (");

		buf.append("FROM cms_asset asset LEFT OUTER JOIN cms_asset_aircraft aircraft ON ");
		buf.append("asset.cms_collateral_id = aircraft.cms_collateral_id WHERE asset.cms_collateral_id IN (");


		buf.append("SELECT asset.cms_collateral_id, type_of_asset, manufacture_year, model_no, plantequip.serial_no ");
		buf.append("FROM cms_asset asset LEFT OUTER JOIN cms_asset_plant_equip plantequip ON ");
		buf.append("asset.cms_collateral_id = plantequip.cms_collateral_id WHERE asset.cms_collateral_id IN (");

		                "from cms_asset_gold gd, cms_security sec " +
                "where gd.cms_collateral_id = sec.cms_collateral_id " +

-- FIND DOWN MORE ON 9/14/2022
ERROR_HOST_APP_FAIL_DOWNLOAD_FACILITY_COLLATERAL_MESSAGE

No Such Customer Exists with CIF Number 


        if(ICMSConstant.STATE_DELETED.equals(tmpSec.getCMSStatus()) || ICMSConstant.STATE_PENDING_DELETE.equals(tmpSec.getCMSStatus())){
                    tmpSec.setCMSStatus(ICMSConstant.STATE_ACTIVE);
                    if(CommonUtil.isEmpty(tmpSec.getCoreSecurityId()) 
                    		&& ICMSConstant.HOST_COL_STATUS_DELETED.equals(tmpSec.getCollateralStatus())) {
                    	tmpSec.setCollateralStatus(ICMSConstant.HOST_COL_STATUS_ACTIVE);
                    	colStatus = ICMSConstant.HOST_COL_STATUS_ACTIVE;


 protected String getCustodianPrintReversalMemoQuery(CustodianSearchCriteria aCustodianSearchCriteria) {

final String selectPart = "\n" +


protected ApprovedSecurity updateSecurity(ApprovedSecurity security, Vector valuationList, boolean isVariation) {
		String messageSource = EAIMessageSynchronizationManager.getMessageSource();
		if (!helper.isShareSecurity(security)) {
			// check CMS_SECURITY table for security_id + source_id to allow
			// only owner of security can update security record
			checkSecurityOwner(security);

protected ApprovedSecurity storeSecurity(ApprovedSecurity security, Vector valuationList, boolean isVariation)
			throws EAIMessageValidationException {
		if (helper.isCreate(security)) {



--- SQL 
SELECT DISTINCT(INTEGRATION_STS_2_RESULT_DESC) FROM sml_ca_history ;

SELECT DISTINCT(INTEGRATION_STS_2_RESULT_DESC) FROM sml_ca ;

SELECT DISTINCT(INTEGRATION_STS_1_RESULT_DESC)  FROM sml_ca WHERE INTEGRATION_STS_1_RESULT_DESC LIKE '%No Such Customer Exists%';

--ApprovedSecurity
SELECT DISTINCT(STATUS) FROM CMS_SECURITY ; -- CMSStatus
SELECT DISTINCT(COLLATERAL_STATUS) FROM CMS_SECURITY ; --collateralStatus

--no OF LINKAGE to COL
public Long getNumberOfLinkageByCollateral(long collateralId) throws CollateralException {
		String sql = " SELECT count(1) as numberOfLinkage"
				+	" FROM CMS_LIMIT_SECURITY_MAP ls"
				+	" WHERE LS.CMS_COLLATERAL_ID = ?"
				+ 	" AND LS.UPDATE_STATUS_IND <> 'D'";
		return doGetNumberOfLinkageByCollateral(sql, collateralId);
	}


1. Ảnh hưởng khi xóa
- DATA integrity giữa 3 Hệ thống CMS, CLOS : phải xóa đồng bộ
		VD: Change Reqest - create new

2. Xóa case Active COL ảnh hưởng gì
	- ảnh hưởng duy nhất hiện tại tìm ra là Lquan đến 1 cái BATCH chạy validation - calculate để SAVE data vào CMS_VALIDATION
	- Ko ảnh hưởng nhiều, đều có thể work around nhưng ko khuyến khích xóa ACTIVE vì có thể TIỀM ẨN phát sinh lỗi vấn phát sinh sự cố ngoài mong muốn vì bất đồng bộ dự liêu
		giữa data trên các hệ thống . VD trigger change của COL
	- các data liên quan bị COL bị xóa => ko ảnh hưởng logic trên cùng hệ thống

	- LƯu trữ ở đâu. Xuất file dump để import ra hệ thống khác hay là tạo BẢNG MỚI để lữu trữ DATA cũ, giữ nguyên các mqh và thay tên thôi?
	- Nếu dọn trên CLIMS thì cũng nên DỌN trên CLOS tương ứng để tránh trường hợp các DATA cũ STP sang bị lỗi
	- ?Có xóa các CAR liên quan hay không? 


3. Có xóa CAR ko nếu xóa hết COL

FAC and COL relationship la gi 

facBuf = new StringBuffer();
						facBuf.append("UPDATE cms_stg_facility_master SET date_instructed = ? ");
						facBuf.append("WHERE id IN (SELECT staging_reference_id ");
						facBuf.append("FROM transaction WHERE reference_id IN ( ");
						facBuf.append("SELECT id FROM cms_facility_master WHERE cms_lsp_appr_lmts_id IN ( ");
						facBuf.append("SELECT cms_lsp_appr_lmts_id FROM sci_lsp_appr_lmts ");
						facBuf.append("WHERE cms_limit_profile_id = ?)) AND transaction_type = ?) ");
						facBuf.append("AND date_instructed IS NULL");

	"select l.CMS_LSP_APPR_LMTS_ID, l.LMT_OUTER_LMT_ID from sci_lsp_appr_lmts l, tempTable y, CMS_FACILITY_MASTER f, CMS_FAC_GENERAL g " +
				"where L.CMS_LSP_APPR_LMTS_ID= F.CMS_LSP_APPR_LMTS_ID and F.ID= G.CMS_FAC_MASTER_ID and G.FAC_STATUS_CODE_VALUE ='A' " +
				"and l.CMS_LSP_APPR_LMTS_ID = y.LMT_OUTER_LMT_ID ) select count(1) as levl from temptable";

-- check FAC CONDITION STATUS AND date
 //16-5-2011 kc chin trade spring, for tspr type, stp_master_trans will have 2 entry as 1 for arbs another for tspr. existing query unable to take care on it and will return 2 status instead of 1
        //modify existing query as for double entry record, take the record with latest last_submission_date to derive the status

        StringBuffer buf1 = new StringBuffer();
		buf1.append("SELECT fac_trx.from_state, fac_trx.status, fac.to_be_cancelled_ind, fac.CANCEL_DELETE_IND,  ");
		buf1.append("facgen.fac_status_code_value fac_status, fac.cms_lsp_appr_lmts_id, ");
		buf1.append("m.is_stp_ready, stp_trx.status stp_status, fac_trx.transaction_subtype ");
		buf1.append("FROM cms_facility_master fac, cms_fac_general facgen, transaction fac_trx ");
		buf1.append("LEFT OUTER JOIN cms_stp_ready_status_map m ");
		buf1.append("ON fac_trx.transaction_id = m.transaction_id AND fac_trx.transaction_type = m.transaction_type ");
		buf1.append("LEFT OUTER JOIN (select master_trx_id, status, transaction_id from (select master_trx_id, s.status, transaction_id, RANK() ");
        buf1.append("OVER (PARTITION BY transaction_id ORDER BY last_submission_date DESC) rank from stp_master_trans s, ");
        buf1.append("cms_facility_master m where s.REFERENCE_ID = m.ID AND m.cms_lsp_appr_lmts_id  ");
        //CommonUtil.buildSQLInList(cmsLimitIds, buf, argList);
        StringBuffer buf2 = new StringBuffer();
        buf2.append(")  b where rank = 1) stp_trx ");
        buf2.append("ON fac_trx.transaction_id = stp_trx.transaction_id ");
        buf2.append("WHERE fac_trx.REFERENCE_ID = fac.ID AND fac_trx.status <> 'CLOSED' ");
        buf2.append("and fac_trx.transaction_type = 'FACILITY' ");
		buf2.append("AND fac.id = facgen.cms_fac_master_id AND fac.cms_lsp_appr_lmts_id ");

		String buf = "SELECT fac_trx.from_state, fac_trx.status, fac.to_be_cancelled_ind, fac.CANCEL_DELETE_IND,  facgen.fac_status_code_value fac_status,                   "
        		+" fac.cms_lsp_appr_lmts_id, m.is_stp_ready, stp_trx.status stp_status, fac_trx.transaction_subtype                                                      "
        		+"FROM cms_facility_master fac,cms_fac_general facgen, transaction fac_trx                                                                               "
        		+" LEFT OUTER JOIN cms_stp_ready_status_map m ON fac_trx.transaction_id = m.transaction_id AND fac_trx.transaction_type = m.transaction_type             "
        		+" LEFT OUTER JOIN (select master_trx_id, status, transaction_id from                                                                                    "
        		+" (select master_trx_id, s.status, transaction_id, RANK() OVER (PARTITION BY transaction_id ORDER BY last_submission_date DESC)                         "
        		+" rank from stp_master_trans s, cms_facility_master m where s.REFERENCE_ID = m.ID AND m.cms_lsp_appr_lmts_id   IN                                       "
        		+" (select L.CMS_LSP_APPR_LMTS_ID from SCI_LSP_APPR_LMTS l where L.CMS_LIMIT_PROFILE_ID = ?))  b where rank = 1) stp_trx ON                              "
        		+" fac_trx.transaction_id = stp_trx.transaction_id                                                                                                       "
        		+"WHERE fac_trx.REFERENCE_ID                                                                                                                             "
        		+" = fac.ID AND fac_trx.status <> 'CLOSED' and fac_trx.transaction_type = 'FACILITY' AND fac.id = facgen.cms_fac_master_id AND fac.cms_lsp_appr_lmts_id  "
        		+" IN (select L.CMS_LSP_APPR_LMTS_ID from SCI_LSP_APPR_LMTS l where L.CMS_LIMIT_PROFILE_ID = ?)     


				"WITH tempTable (id, CMS_LSP_APPR_LMTS_ID, LMT_OUTER_LMT_ID, stop) as " +
                        "(select m.id, l.CMS_LSP_APPR_LMTS_ID, l.LMT_OUTER_LMT_ID, 0 " +
                        "from sci_lsp_appr_lmts l, transaction t, cms_facility_master m " +
                        "where m.id = t.reference_id " +
                          "and t.transaction_type = 'FACILITY' " +
                          "and l.CMS_LSP_APPR_LMTS_ID = m.CMS_LSP_APPR_LMTS_ID " +
                          "and l.CMS_LSP_APPR_LMTS_ID = ? " +
                        "union all " +
                        "select m.id, l.CMS_LSP_APPR_LMTS_ID, l.LMT_OUTER_LMT_ID, case when y.CMS_LSP_APPR_LMTS_ID = l.CMS_LSP_APPR_LMTS_ID then 1 else 0 end " +
                         "from sci_lsp_appr_lmts l, transaction t, cms_facility_master m, tempTable y " +
                         "where m.id = t.reference_id " +
                           "and t.transaction_type = 'FACILITY' " +
                           "and l.CMS_LSP_APPR_LMTS_ID = m.CMS_LSP_APPR_LMTS_ID " +
                           "and l.LMT_OUTER_LMT_ID = y.CMS_LSP_APPR_LMTS_ID and stop = 0) " +
                         "select id, CMS_LSP_APPR_LMTS_ID from temptable where CMS_LSP_APPR_LMTS_ID != ?",

		sqlBuf.append("UPDATE " + facilityMasterTableNameStage + " ");
  		sqlBuf.append("SET  MAIN_FACILITY_AA_NUM = ? , MAIN_FACILITY_CODE = ? , MAIN_FACILITY_SEQ = ? , STANDBY_LINE = ?, LEVL = ? ");
  		sqlBuf.append("WHERE ID = ( select T.STAGING_REFERENCE_ID from TRANSACTION t where T.TRANSACTION_TYPE='FACILITY' and T.REFERENCE_ID = ");
  		sqlBuf.append(" ( select ID from CMS_FACILITY_MASTER where CMS_LSP_APPR_LMTS_ID = ?  ) )");"

-- procedure COPY and DELETE

Dọn cần ĐK : xem có đồng bộ dữ liệu hay không => y/c chi nhánh đồng bộ
image.png => REPORT

	- B1: quyets hợp lệ 
		+ RUlE để check hợp lệ có khớp hay không? - fac ko còn liên kết tsđb nào, tsbd còn liên kết hồ sơ hay không
			- Liên kết -- 
		+ 


?? QUESTION 9/20
1. INPUT TYPE of PARAMETER
2.FAC CONDITION: CLOSED - not found in FACILITY_MASTER ? CHECk in TRANSACTON? but status is DELETED not CLOSED?
3. can directly CHANGE STATUS of FAC / COL in CLIMS or do it in CLOS => STP to CLIMS??? 
4. CHECK COL STATUS IN CMS_COLLATERAL OR TRANSACTION

-- sql 9/20  query in CLIMS

SELECT * FROM CMS_FACILITY_MASTER ; 
SELECT * FROM CMS_FAC_SECURITY_DEPOSIT ;  - no record
SELECT * FROM CMS_FAC_ISLAMIC_MASTER;

SELECT DISTINCT(STATUS) FROM CMS_STG_FACILITY_MASTER ; 
SELECT  DISTINCT(STATUS) FROM CMS_FAC_RELATIONSHIP ; 
SELECT  DISTINCT(STATUS) FROM CMS_FAC_MULTI_TIER_FINANCING ; 
SELECT  DISTINCT(STATUS) FROM CMS_FAC_ISLAMIC_MASTER ; 
SELECT  DISTINCT(STATUS) FROM CMS_FAC_TSPR ; 

select distinct(transaction_type) from TRANSACTION ;

select * from TRANSACTION WHERE transaction_type = 'FACILITY' ;
select * from TRANSACTION WHERE transaction_type = 'COL' ;

select distinct(status) from TRANSACTION WHERE transaction_type = 'FACILITY' ;
--ACTIVE
--PENDING_RETRY
--PENDING_UPDATE
--PENDING_PERFECTION_CANCEL
--REJECTED_UPDATE
--REJECTED_CANCELLATION
--DRAFT_CANCELLATION
--DELETED
--PENDING_RETRY_DELETE
--DRAFT
--PENDING_CANCELLATION
--LOADING
--PENDING_PERFECTION
--PENDING_PERFECTION_DELETE

SELECT DISTINCT(COLLATERAL_STATUS)    FROM CMS_SECURITY ; -- 0 , 1
SELECT DISTINCT(COLLATERAL_STATUS_BK)    FROM CMS_SECURITY ;  -- null 1 3

select distinct(status) from TRANSACTION WHERE transaction_type = 'COL' ;
-- ACTIVE
-- PENDING_RETRY
-- PENDING_UPDATE
-- REJECTED_CREATE
-- DELETED
-- NEW
-- DRAFT
-- REJECTED
-- PENDING_DELETE
-- LOADING
-- PENDING_PERFECTION


-- get out these infomation to check
SELECT FROM_STATE, TRANSACTION_TYPE, TRANSACTION_DATE, STATUS, reference_id
FROM TRANSACTION 
WHERE transaction_type = 'FACILITY';

-- LINK PL SQL
https://www.tutorialspoint.com/plsql/plsql_conditional_control.htm
https://www.oracletutorial.com/plsql-tutorial/

-- Compare date TIME

