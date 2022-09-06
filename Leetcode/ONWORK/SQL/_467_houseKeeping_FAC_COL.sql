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
cms_checklist  <= ( CHECKLIST_ID ) = cms_checklist_item    
									 

             