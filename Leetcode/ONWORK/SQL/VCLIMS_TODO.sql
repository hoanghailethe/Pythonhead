src\com\integrosys\cms\app\transaction\CMSTransactionOracleDAO.java
Search todo MAKER SYS 
		String sql = this.getQuery(criteria, paramList, false);
		DefaultLogger.info(this, sql);
		DefaultLogger.info(this, "paramList: "+paramList);
		try {
			return (SearchResult) getJdbcTemplate().query(sql, paramList.toArray(), new ResultSetExtractor() {

				public Object extractData(ResultSet rs) throws SQLException,
						org.springframework.dao.DataAccessException {
					return processTrxResultSet(criteria, rs, true, false);
				}
			});
		}

-- ROLE SÝCHECKER
--Param
 size = 5
    7   20130523000000008   20130523000000005   20130523000000005   20130523000000003

SELECT 
  * 
FROM 
  (
    SELECT 
      row_number() over(
        partition by a.transaction_id 
        order by 
          a.transaction_id
      ) rownum1, 
      a.trx_reference_id, 
      a.transaction_id, 
      a.cur_trx_history_id, 
      a.reference_id, 
      a.transaction_type, 
      a.transaction_subtype, 
      a.status, 
      a.legal_id, 
      a.limit_profile_id, 
      a.limit_profile_ref_num, 
      a.legal_name AS lname, 
      a.customer_name AS cname, 
      a.customer_id, 
      a.transaction_date, 
      a.trx_origin_country, 
      a.user_info, 
      a.cur_maker, 
      a.cur_checker, 
      a.TEAM_MEMBERSHIP_ID, 
      b.user_action, 
      b.url, 
      b.totrack_url, 
      f2.user_state, 
      f2.user_trx_type, 
      f.stateid, 
      (
        SELECT 
          country_name 
        FROM 
          country 
        WHERE 
          country_iso_code = a.trx_origin_country
      ) country_name, 
      sp.lsp_id, 
      mp.lmp_le_id, 
      sp.lsp_short_name AS customer_name, 
      mp.lmp_long_name AS legal_name, 
      UPPER (mp.lmp_long_name) AS upper_legal_name, 
      ' ' AS task_flag, 
      a.deal_no, 
      lmt.LOS_BCA_REF_NUM, 
      SEC.SECURITY_NO, 
      SEC.SCI_REFERENCE_NOTE AS ACTUAL_SCI_REFERENCE_NOTE, 
      STSEC.SCI_REFERENCE_NOTE AS STAGE_SCI_REFERENCE_NOTE, 
      SEC.SCI_SECURITY_DTL_ID 
    FROM 
      CMS_STATEMATRIX_ACTION b, 
      TR_STATE_MATRIX f, 
      CMS_TRX_TOTRACK f2, 
      CMS_TEAM c, 
      CMS_TEAM_TYPE_MEMBERSHIP e, 
      TRANSACTION a 
      LEFT OUTER JOIN SCI_LE_SUB_PROFILE sp ON sp.CMS_LE_SUB_PROFILE_ID = a.CUSTOMER_ID 
      LEFT OUTER JOIN SCI_LSP_LMT_PROFILE lmt ON lmt.CMS_LSP_LMT_PROFILE_ID = a.LIMIT_PROFILE_ID 
      LEFT OUTER JOIN SCI_LE_MAIN_PROFILE mp ON mp.CMS_LE_MAIN_PROFILE_ID = sp.CMS_LE_MAIN_PROFILE_ID 
      LEFT OUTER JOIN CMS_SECURITY SEC ON SEC.CMS_COLLATERAL_ID = A.REFERENCE_ID 
      AND A.TRANSACTION_TYPE = 'COL' 
      LEFT OUTER JOIN CMS_STAGE_SECURITY STSEC ON STSEC.CMS_COLLATERAL_ID = A.STAGING_REFERENCE_ID 
      AND A.TRANSACTION_TYPE = 'COL' 
    WHERE 
      b.TEAM_MEMBERSHIP_TYPE_ID = 7 
      AND a.TRANSACTION_TYPE = f2.TRANSACTION_TYPE 
      AND a.STATUS = f2.CURR_STATE 
      AND (
        a.FROM_STATE = f2.FROM_STATE 
        OR f2.FROM_STATE IS NULL
      ) 
      AND a.TRANSACTION_TYPE = f.STATEINS 
      AND (
        a.TRANSACTION_SUBTYPE = f2.TRANSACTION_SUBTYPE 
        OR (
          a.TRANSACTION_SUBTYPE IS NULL 
          AND f2.TRANSACTION_SUBTYPE IS NULL
        )
      ) 
      AND f.FROMSTATE = a.STATUS 
      AND f.STATEID = b.STATE_ID 
      AND a.TEAM_ID = c.TEAM_ID 
      AND b.TEAM_MEMBERSHIP_TYPE_ID = e.TEAM_TYPE_MEMBERSHIP_ID 
      AND e.TEAM_TYPE_ID = c.TEAM_TYPE_ID 
      AND (
        (
          a.USER_ID <> 20130523000000008 
          AND a.team_membership_id <> 20130523000000005
        ) 
        OR (a.team_membership_id = 20130523000000005)
      ) 
      AND A.TEAM_ID = 20130523000000003 
    ORDER BY 
      TRANSACTION_DATE DESC, 
      TRANSACTION_ID
  ) 
WHERE 
  rownum1 = 1

  SELECT * FROM (SELECT row_number() over(partition by a.transaction_id order by a.transaction_id) rownum1, 		  a.trx_reference_id, a.transaction_id, a.cur_trx_history_id,       a.reference_id, a.transaction_type, a.transaction_subtype, a.status,       a.legal_id, a.limit_profile_id, a.limit_profile_ref_num, a.legal_name AS lname,       a.customer_name AS cname, a.customer_id, a.transaction_date,       a.trx_origin_country, a.user_info, a.cur_maker, a.cur_checker, a.TEAM_MEMBERSHIP_ID, b.user_action, b.url, b.totrack_url,       f2.user_state, f2.user_trx_type, f.stateid,	      (SELECT country_name FROM country WHERE country_iso_code = a.trx_origin_country) country_name,	      sp.lsp_id, mp.lmp_le_id, sp.lsp_short_name AS customer_name,       mp.lmp_long_name AS legal_name,       UPPER (mp.lmp_long_name) AS upper_legal_name, ' ' AS task_flag, a.deal_no, lmt.LOS_BCA_REF_NUM,        SEC.SECURITY_NO, SEC.SCI_REFERENCE_NOTE AS ACTUAL_SCI_REFERENCE_NOTE, STSEC.SCI_REFERENCE_NOTE AS STAGE_SCI_REFERENCE_NOTE, SEC.SCI_SECURITY_DTL_ID  FROM CMS_STATEMATRIX_ACTION b,    TR_STATE_MATRIX f,    CMS_TRX_TOTRACK f2,    CMS_TEAM c,    CMS_TEAM_TYPE_MEMBERSHIP e,    TRANSACTION a LEFT OUTER JOIN     SCI_LE_SUB_PROFILE sp ON sp.CMS_LE_SUB_PROFILE_ID = a.CUSTOMER_ID LEFT OUTER JOIN     SCI_LSP_LMT_PROFILE lmt ON lmt.CMS_LSP_LMT_PROFILE_ID = a.LIMIT_PROFILE_ID LEFT OUTER JOIN     SCI_LE_MAIN_PROFILE mp ON mp.CMS_LE_MAIN_PROFILE_ID = sp.CMS_LE_MAIN_PROFILE_ID    LEFT OUTER JOIN CMS_SECURITY SEC ON SEC.CMS_COLLATERAL_ID = A.REFERENCE_ID AND A.TRANSACTION_TYPE ='COL'    LEFT OUTER JOIN CMS_STAGE_SECURITY STSEC ON STSEC.CMS_COLLATERAL_ID = A.STAGING_REFERENCE_ID AND A.TRANSACTION_TYPE ='COL' WHERE a.TRANSACTION_TYPE = f2.TRANSACTION_TYPE       AND a.STATUS = f2.CURR_STATE       AND (a.FROM_STATE = f2.FROM_STATE OR f2.FROM_STATE IS NULL)       AND a.TRANSACTION_TYPE = f.STATEINS       AND (a.TRANSACTION_SUBTYPE = f2.TRANSACTION_SUBTYPE OR (a.TRANSACTION_SUBTYPE IS NULL AND f2.TRANSACTION_SUBTYPE IS NULL))       AND f.FROMSTATE = a.STATUS       AND f.STATEID = b.STATE_ID       AND a.TEAM_ID = c.TEAM_ID       AND b.TEAM_MEMBERSHIP_TYPE_ID = e.TEAM_TYPE_MEMBERSHIP_ID       AND e.TEAM_TYPE_ID = c.TEAM_TYPE_ID 		 AND ((a.USER_ID <> ? AND a.team_membership_id <> ?)      OR  (a.team_membership_id = ?)) AND A.TEAM_ID = ?  ORDER BY TRANSACTION_DATE DESC, TRANSACTION_ID )  WHERE rownum1 = 1

  SCCC999006 USER -- CHECK