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

				