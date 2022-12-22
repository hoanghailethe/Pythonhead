
/*
 * GENERAL_STRUCTURE:   CA_INFO | FAC_INFO | CUST_INFO | COLL_INFO
 * where: 
 *   CUST_INFO = PERSONAL_INFO | REG ADDRESS | RESI_ADDRESS | EMPLOYMENT_DETAILS | INCOME
 *   COLL_INFO = PARENT_COLL_INFO | CHILD_COLL_INFO(PT or FD)
 * 
 * Design:
 *   For MO and PL: Main cursor = RLOS.los_CIF(cif_rel_code=M) join RLOS.los_CA join RLOS.los_FAC 
 * 
 *   For CC: Main cursor = RLOS.los_CA join RLOS.los_CIF join RLOS.los_CC 
 * 
 *  
 * */
DECLARE
    SEP varchar2(1):='|';
    DASH varchar2(1):='-';
    v_joint_count number:=0;
	c number:=0;
	pt_count number :=0;
	
    CURSOR main_cursor IS
        SELECT 
        	CIF.CIF_ID,
        	CIF.CA_ID,
        	
			CA.APP_TYP,
			TO_CHAR(CA.CREATE_DATE ,'DD/MM/YYYY HH24:MI:SS' )as CREATE_DATE,			
			CA.APP_STATUS,
			CA.APP_REF_NO,
			CA.HOST_AA_NO,
			TO_CHAR(CA.APPLICATION_DATE ,'DD/MM/YYYY HH24:MI:SS' )as APPLICATION_DATE,
			CA.BOOK_BR_CODE,
			CA.SALES_STAFF_CODE,
			CA.APPROVED_DATE,
			CA.ER_RESULT,
            CA.SYS_PD,
            CA.SYS_PD_RESUT,
			CIF.TH_SALU_CODE,
			CIF.TH_NAME_LINE_2,
			CIF.TH_NAME_LINE_1,
			CIF.SALU_CODE,
			CIF.NAME_LINE_2,
			CIF.NAME_LINE_1,
			CIF.BIRTH_DATE,
			CIF.AGE,
			CIF.GENDER,
			CIF.NATIONALITY,
			CIF.MARITAL_STATUS,
			CIF.ID_NO_1,
			CIF.EDUCATION_LEVEL,
			CIF.TELEPHONE_NO,
			CIF.MOBILE_NO,
			CIF.RESIDENT_TYP,
			CIF.MAILING_PREFERENCE,
			CIF.EMP_STATUS,
			CIF.RM_OCCUPATION,
			CIF.EMP_YR,
			CIF.EMP_MONTH,
			CIF.EMP_IN_FIXED_TOTAL,
			CIF.EMP_IN_EXTRA_TOTAL,
			CIF.NO_OF_DEPENDENT,
			CIF.EMP_IN_OTHER_TOTAL,
			CIF.EMP_PROVINCE,
			CIF.EMP_NAME,	
			FAC.FAC_CODE,
			FAC.CB_PUR_CODE,
			FAC.PROD_CODE,
			FAC.LIMIT_APPLIED,
			FAC.OD_LIMIT,
			FAC.TENURE,
			FAC.PAY_METHOD,
			FAC.PAYMENT_DUE_DATE,
			--CR TMBRLOSPROD-17 24/02/2011 get more fields
			CA.REQ_NATURE,CA.RSN_CODE,CA.SALES_STAFF_NAME,CA.CREATE_BY
			--End CR
		FROM RLOS.los_cif_indv CIF 
		inner join RLOS.los_ca CA ON CIF.ca_id = CA.id AND CIF.cif_rel_code ='M'
		inner join RLOS.los_fac FAC ON FAC.ca_id = CA.id;
	
	-- for getting common code descriptions
	CURSOR cce_cursor(code varchar2, category varchar2,cce_langs varchar2) IS
        SELECT 
        	CASE        		
        		WHEN cce_langs ='TH' THEN CCE.ENTRY_CODE || DASH || CCE.ENTRY_NAME_2
        		ELSE CCE.ENTRY_CODE || DASH || CCE.ENTRY_NAME
        	END DISPLAY
        FROM RLOS.common_code_category_entry CCE
        WHERE CCE.entry_code = code and CCE.category_code = category and CCE.active_status=1;
    
    cce_record cce_cursor%ROWTYPE;
    
    -- for fetching Addresses
    CURSOR addr_cursor(cif_ids varchar2, typ varchar2) IS
        SELECT ADDR.PROVINCE,ADDR.POSTAL_CODE
        FROM RLOS.los_CIF_ADDR ADDR
        WHERE ADDR.cif_id = cif_ids and ADDR.ADDR_TYP_CODE = typ;
    
    addr_record addr_cursor%ROWTYPE;
	
	CURSOR addr_emp_cursor(cif_ids varchar2) IS
        SELECT ADDR.PROVINCE,ADDR.POSTAL_CODE
        FROM RLOS.los_CIF_ADDR ADDR
        WHERE ADDR.cif_id = cif_ids and  (ADDR.ADDR_TYP_CODE = 'O' OR ADDR.ADDR_TYP_CODE = 'E');
    
    addr_emp_record addr_emp_cursor%ROWTYPE;
    
    --for fetching collaterals
    CURSOR coll_cursor(cas_id varchar2) IS
        SELECT COLL.* 
        FROM RLOS.los_COLL COLL
        WHERE COLL.ca_id = cas_id;
    coll_record coll_cursor%ROWTYPE;
    
    --for fetching property collaterals
    CURSOR pt_cursor(coll_id varchar2) IS
        SELECT PT.* 
        FROM RLOS.los_COLL_PT PT
        WHERE PT.id = coll_id;
    pt_record pt_cursor%ROWTYPE;
    
    --for fetching fixed deposit collaterals
    CURSOR fd_cursor(coll_id varchar2) IS
        SELECT FD.* 
        FROM RLOS.los_COLL_FD FD
        WHERE FD.id = coll_id;
    fd_record fd_cursor%ROWTYPE;
    
    -- for fetching Main borrowers
    CURSOR cif_main_cursor(cas_id number) IS
        SELECT CIF.* 
        FROM RLOS.los_CIF_INDV CIF
        WHERE CIF.ca_id = cas_id and CIF.CIF_REL_CODE = 'M';    
    cif_record cif_main_cursor%ROWTYPE;
	
	-- for fetching Joint borrowers
	CURSOR cif_joint_cursor(cas_id number) IS
        SELECT CIF.* 
        FROM RLOS.los_CIF_INDV CIF
        WHERE CIF.ca_id = cas_id and CIF.CIF_REL_CODE = 'J';    
    cif_joint_record cif_joint_cursor%ROWTYPE;
    
    -- for CC data
    CURSOR cc_cursor IS
	    SELECT 
	    	CIF.CIF_ID,
        	CIF.CA_ID,
        	
			CA.APP_TYP,
			CA.APP_STATUS,
            CA.APPROVED_DATE,
			TO_CHAR(CA.CREATE_DATE ,'DD/MM/YYYY HH24:MI:SS' )as CREATE_DATE,
			CA.APP_REF_NO,
			CA.HOST_AA_NO,
			TO_CHAR(CA.APPLICATION_DATE ,'DD/MM/YYYY HH24:MI:SS' )as APPLICATION_DATE,
			CA.BOOK_BR_CODE,
			CA.SALES_STAFF_CODE,
			CA.ER_RESULT,
            CA.SYS_PD,
            CA.SYS_PD_RESUT,			
			CIF.TH_SALU_CODE,
			CIF.TH_NAME_LINE_2,
			CIF.TH_NAME_LINE_1,
			CIF.SALU_CODE,
			CIF.NAME_LINE_2,
			CIF.NAME_LINE_1,
			CIF.BIRTH_DATE,
			CIF.AGE,
			CIF.GENDER,
			CIF.NATIONALITY,
			CIF.MARITAL_STATUS,
			CIF.ID_NO_1,
			CIF.EDUCATION_LEVEL,
			CIF.TELEPHONE_NO,
			CIF.REG_EXT_PHONE_NO,
			CIF.MOBILE_NO,
			CIF.RESIDENT_TYP,
			CIF.MAILING_PREFERENCE,
			CIF.EMP_STATUS,
			CIF.RM_OCCUPATION,
			CIF.EMP_YR,
			CIF.EMP_MONTH,
			CIF.EMP_IN_FIXED_TOTAL,
			CIF.EMP_IN_EXTRA_TOTAL,
			CIF.NO_OF_DEPENDENT,
			CIF.EMP_IN_OTHER_TOTAL,
			CIF.EMP_PROVINCE,
			CIF.EMP_NAME,
			
			CC.PRODUCT_TYPE,
			CC.PAYMENT_METHOD,
			CC.PAYMENT_CRITERIA,
			CC.DEBIT_ACCT_NO,
			CC.CARD_DELIVERY_ADDRESS,
			CC.VIP_FLAG,
			--CR TMBRLOSPROD-17 24/02/2011 get more fields
			CA.REQ_NATURE,CA.RSN_CODE,CA.SALES_STAFF_NAME,CA.CREATE_BY
			--End CR
	    FROM RLOS.los_CA CA 
		inner join RLOS.los_CIF_INDV CIF ON CA.id = CIF.ca_id and CA.APP_TYP = 'CC' and CIF.CIF_REL_CODE = 'M'
		inner join RLOS.los_cc CC ON CC.cif_id = CIF.cif_id;

    --for fetching sup card info
	CURSOR cc_supp_cursor(cas_id number) IS
        SELECT CIF.RELATION_WITH_MAIN, CC.PRODUCT_TYPE
        FROM RLOS.los_CIF_INDV CIF ,RLOS.los_cc CC
        WHERE 1=1
		and CC.cif_id = CIF.cif_id
		and CIF.ca_id = cas_id and CIF.CIF_REL_CODE = 'J';    
    cc_supp_record cc_supp_cursor%ROWTYPE;	
		
	--for fetching user info
	CURSOR user_cursor(cas_id number) IS
        select UR.LOGIN_NAME as EMPLOYEE_ID ,ur.SURNAME
		from RLOS.LOS_WF_TASK WF , RLOS.los_user ur
		where 1=1
		and UR.ID = WF.USER_ID
		and WF.APP_STATUS = 'PENDINGCOANALYSIS'
		and WF.APP_ID = cas_id;  
    user_record user_cursor%ROWTYPE;
    
    -- for fetching branch info
    CURSOR branch_cursor(bbr_code varchar2) IS
        SELECT BR.DESCRIPTION
		FROM RLOS.LOS_SA_BR_STRUC_BR BR
		WHERE BR.CHILD_BR_CODE = bbr_code;  
    branch_record branch_cursor%ROWTYPE;
    
	--ELIGIBILITY_CHECKS_INFORMATION
	CURSOR eligibility_cursor(cas_id number,cifs_id number,des varchar2,typ varchar2) IS
        SELECT R.RESULT
		FROM RLOS.LOS_ELIBIGILITY_RULE R, RLOS.LOS_CIF_INDV INDV
		WHERE 1 = 1 
		AND R.CA_ID = INDV.CA_ID
		AND INDV.CIF_ID = R.CIF_ID
        AND R.CIF_ID = cifs_id 
		AND INDV.CIF_REL_CODE = typ
        AND R.CA_ID = cas_id AND R.DESCRIPTION LIKE des ;
    eligibility_record eligibility_cursor%ROWTYPE;
	
	--APPLICATION_ROUTING_INFORMATION
	CURSOR routing_cursor(ca_id number,typ varchar2) IS
        SELECT TO_CHAR(WF.CREATE_DATE ,'DD/MM/YYYY HH24:MI:SS' )as CREATE_DATE,WF.APP_STATUS 
		FROM RLOS.LOS_WF_TASK WF , RLOS.LOS_CA CA
		WHERE 1=1
		AND WF.APP_ID = CA.ID
		AND  CA.ID = ca_id
		AND WF.APP_STATUS = typ
		ORDER BY WF.CREATE_DATE DESC ;
    routing_record routing_cursor%ROWTYPE;
	
	-- for fetching income info
    CURSOR income_cursor(cif_ids varchar2,emp_sta varchar2) IS
        SELECT
			CASE                
				WHEN emp_sta = '01' AND CA.APP_TYP = 'MO' THEN nvl(CIF.IN_BASIC_SALARY,0)--(nvl(CIF.IN_BASIC_SALARY,0)+nvl(CIF.INCOME_FIX_AMNT,0))
				WHEN emp_sta = '02' AND CA.APP_TYP = 'MO' THEN nvl(CIF.IN_BASIC_SALARY,0)--((nvl(CIF.IN_DECLARED,0)*nvl(CIF.IN_SHARE_HOLDER_PERCENT,0))/100)
				WHEN emp_sta = '01' AND CA.APP_TYP = 'PL' THEN nvl(CIF.EMP_IN_FINAL_TOTAL,0)
				WHEN emp_sta = '02' AND CA.APP_TYP = 'PL' THEN 0
				WHEN emp_sta = '01' AND CA.APP_TYP = 'CC' THEN nvl(CIF.EMP_IN_FINAL_TOTAL,0)
				WHEN emp_sta = '02' AND CA.APP_TYP = 'CC' THEN 0
			ELSE 0
			END ANNUAL 
		FROM RLOS.LOS_CIF_INDV CIF , RLOS.LOS_CA CA
		WHERE 1=1
		AND CA.ID = CIF.CA_ID
		AND CIF.CIF_ID = cif_ids;  
    income_record income_cursor%ROWTYPE;
	
	--CR TMBRLOSPROD-17 24/02/2011 get more fields
	CURSOR aacc_check_cursor(app_ref_nos varchar2) IS
		SELECT NVL (SUM (AACC.INCOME), 0) INCOME,
		NVL (SUM (AACC.KNOWN_DEBT), 0) KNOWN_DEBT
		FROM RLOS.LOS_CIF_CHECK_AACC AACC
		WHERE 1 = 1
		AND AACC.CIF_ID IN
              (SELECT INDV.CIF_ID
                 FROM RLOS.LOS_CA CA, RLOS.LOS_CIF_INDV INDV
                WHERE CA.ID = INDV.CA_ID AND CA.APP_REF_NO = app_ref_nos);
	aacc_check_record aacc_check_cursor%ROWTYPE;
	
	CURSOR aacc_dsr_cursor(cif_id_nos varchar2,type_of_app varchar2) IS
		SELECT 
		CASE
		  WHEN type_of_app = 'MO' THEN NVL (AACC.DSR2_BY_TOTAL_RC, 0)
		  ELSE NVL (AACC.DSR2, 0)
		END
		  DSR
		FROM RLOS.LOS_CIF_CHECK_AACC AACC
		WHERE 1 = 1
		AND AACC.CIF_ID = cif_id_nos;
	aacc_dsr_record aacc_dsr_cursor%ROWTYPE;
	
	CURSOR staff_cursor(user_ids number) IS
		SELECT  nvl(UR.LOGIN_NAME,'') LOGIN_NAME,nvl(UR.SURNAME,'') SURNAME
		FROM RLOS.LOS_USER UR
		WHERE 1=1
		AND UR.ID = user_ids;
	staff_record staff_cursor%ROWTYPE;
	--End CR
	
	BEGIN
		DBMS_OUTPUT.ENABLE(null);
		/*
		DBMS_OUTPUT.PUT('Application Number' || SEP);
		DBMS_OUTPUT.PUT('Branch Application Number' || SEP);
		DBMS_OUTPUT.PUT('Application Date (Christian era)' || SEP);
		DBMS_OUTPUT.PUT('Branch code' || SEP);
		DBMS_OUTPUT.PUT('Branch name' || SEP);
		DBMS_OUTPUT.PUT('Staff ID of TMB staff member that referred the business' || SEP);
		DBMS_OUTPUT.PUT('Credit Officer Code' || SEP);
		DBMS_OUTPUT.PUT('CO User Name Assigned to Application (ชื่อเจ้าหน้าที่วิเคราะห์)' || SEP);
		--DBMS_OUTPUT.PUT('CO User Name Assigned to Application (ชื่อเจ้าหน้าที่วิเคราะห์)' || SEP);
		DBMS_OUTPUT.PUT('Ultimate Decision Date ' || SEP);
		DBMS_OUTPUT.PUT('Product Type Code' || SEP);
		DBMS_OUTPUT.PUT('Product Type Name' || SEP);
		DBMS_OUTPUT.PUT('Product Subtype Code' || SEP);
		DBMS_OUTPUT.PUT('Product Subtype Name' || SEP);
		DBMS_OUTPUT.PUT('Purpose of Loan' || SEP);
		DBMS_OUTPUT.PUT('Purpose of Loan' || SEP);
		DBMS_OUTPUT.PUT('Loan amount requested' || SEP);
		DBMS_OUTPUT.PUT('Overdraft Amount Requested' || SEP);
		DBMS_OUTPUT.PUT('Loan Term Requested (total months)' || SEP);
		DBMS_OUTPUT.PUT('Payment Type (Loan)' || SEP);
		DBMS_OUTPUT.PUT('Payment Type (Loan)' || SEP);
		DBMS_OUTPUT.PUT('Payment Due Date' || SEP);
		DBMS_OUTPUT.PUT('Application Status' || SEP);

		DBMS_OUTPUT.PUT('Card Type' || SEP);
		DBMS_OUTPUT.PUT('Supplementary Card Product Type' || SEP);
		DBMS_OUTPUT.PUT('Relationship to Principal' || SEP);
		DBMS_OUTPUT.PUT('Committee Card Level Offered' || SEP);
		DBMS_OUTPUT.PUT('Payment Type (Loan)' || SEP);
		DBMS_OUTPUT.PUT('Payment Condition (Credit Card)' || SEP);
		DBMS_OUTPUT.PUT('Direct Debit Account Number (Credit Card)' || SEP);
		DBMS_OUTPUT.PUT('Place to Send Credit Card' || SEP);
		DBMS_OUTPUT.PUT('VIP Flag' || SEP);

		DBMS_OUTPUT.PUT('Title A1(Thai)' || SEP);
		DBMS_OUTPUT.PUT('A1 Name (Thai)(use in BOT report)' || SEP);
		DBMS_OUTPUT.PUT('A1 Surname (Thai)(use in BOT report)' || SEP);
		DBMS_OUTPUT.PUT('Title A1(English)' || SEP);
		DBMS_OUTPUT.PUT('First Name A1(English)' || SEP);
		DBMS_OUTPUT.PUT('Surname A1(English)' || SEP);
		DBMS_OUTPUT.PUT('Date of Birth (Christian Era) A1' || SEP);
		DBMS_OUTPUT.PUT('Age (years) A1' || SEP);
		DBMS_OUTPUT.PUT('Sex A1' || SEP);
		DBMS_OUTPUT.PUT('Nationality A1' || SEP);
		DBMS_OUTPUT.PUT('Marital Status A1' || SEP);
		DBMS_OUTPUT.PUT('Citizen ID A1(use in BOT report)' || SEP);
		DBMS_OUTPUT.PUT('Highest Education A1' || SEP);
		DBMS_OUTPUT.PUT('Total Number of Dependents A1' || SEP);
		DBMS_OUTPUT.PUT('Address Province A1' || SEP);
		DBMS_OUTPUT.PUT('Address Zip Code A1' || SEP);
		DBMS_OUTPUT.PUT('Home Phone A1' || SEP);
		DBMS_OUTPUT.PUT('Home Phone Extension A1' || SEP);
		DBMS_OUTPUT.PUT('Mobile Phone A1' || SEP);
		DBMS_OUTPUT.PUT('Current Residential Status A1' || SEP);
		DBMS_OUTPUT.PUT('Letter Delivery Flag A1' || SEP);
		DBMS_OUTPUT.PUT('Main Occupation status A1' || SEP);
		DBMS_OUTPUT.PUT('Salary Occupation A1' || SEP);
		DBMS_OUTPUT.PUT('Time in Current Salary Employment (Years) A1' || SEP);
		DBMS_OUTPUT.PUT('Time in Current Salary Employment (Months) A1' || SEP);
		DBMS_OUTPUT.PUT('Monthly Salary/Pension A1 ' || SEP);
		DBMS_OUTPUT.PUT('Monthly Extra Income A1' || SEP);
		DBMS_OUTPUT.PUT('Source Extra Monthly Income A1' || SEP);
		DBMS_OUTPUT.PUT('Other income / variable income' || SEP);
		--DBMS_OUTPUT.PUT('Employment Province' || SEP);  del
		DBMS_OUTPUT.PUT('Employer Address Province A1' || SEP);
		DBMS_OUTPUT.PUT('Employer Address Zip-Code A1' || SEP);
		DBMS_OUTPUT.PUT('Final Income' || SEP);
		DBMS_OUTPUT.PUT('Employer Name A1' || SEP);
		--DBMS_OUTPUT.PUT('Business Name A1' || SEP);
		DBMS_OUTPUT.PUT('Business Net Monthly Income A1 (รายได้ต่อเดือนที่ลูกค้าแจ้ง ไม่รวมรายได้พิเศษ) ' || SEP);
		DBMS_OUTPUT.PUT('Percentage of Ownership of Business A1' || SEP);
		DBMS_OUTPUT.PUT('Title A2(Thai)' || SEP);
		DBMS_OUTPUT.PUT('A2 Name (Thai)(use in BOT report)' || SEP);
		DBMS_OUTPUT.PUT('A2 Surname (Thai)(use in BOT report)' || SEP);
		DBMS_OUTPUT.PUT('Title A2(English)' || SEP);
		DBMS_OUTPUT.PUT('First Name A2(English)' || SEP);
		DBMS_OUTPUT.PUT('Surname A2(English)' || SEP);
		DBMS_OUTPUT.PUT('Date of Birth (Christian Era) A2' || SEP);
		DBMS_OUTPUT.PUT('Age (years) A2' || SEP);
		DBMS_OUTPUT.PUT('Sex A2' || SEP);
		DBMS_OUTPUT.PUT('Nationality A2' || SEP);
		DBMS_OUTPUT.PUT('Marital Status A2' || SEP);
		DBMS_OUTPUT.PUT('Citizen ID A2(use in BOT report)' || SEP);
		DBMS_OUTPUT.PUT('Highest Education A2' || SEP);
		DBMS_OUTPUT.PUT('Total Number of Dependents A2' || SEP);
		DBMS_OUTPUT.PUT('Relationship with main customer' || SEP);
		DBMS_OUTPUT.PUT('Relationship with main customer' || SEP);
		DBMS_OUTPUT.PUT('Address Province A2' || SEP);
		DBMS_OUTPUT.PUT('Address Zip Code A2' || SEP);
		DBMS_OUTPUT.PUT('Home Phone A2' || SEP);
		DBMS_OUTPUT.PUT('Home Phone Extension A2' || SEP);
		DBMS_OUTPUT.PUT('Mobile Phone A2' || SEP);
		DBMS_OUTPUT.PUT('Current Residential Status A2' || SEP);
		DBMS_OUTPUT.PUT('Letter Delivery Flag A2' || SEP);
		DBMS_OUTPUT.PUT('Joint Occupation status A2' || SEP);
		DBMS_OUTPUT.PUT('Salary Occupation A2' || SEP);
		DBMS_OUTPUT.PUT('Time in Current Salary Employment (Years) A2' || SEP);
		DBMS_OUTPUT.PUT('Time in Current Salary Employment (Months) A2' || SEP);
		DBMS_OUTPUT.PUT('Monthly Salary/Pension A2 ' || SEP);
		DBMS_OUTPUT.PUT('Monthly Extra Income A2' || SEP);
		--DBMS_OUTPUT.PUT('Employment Province' || SEP);del
		DBMS_OUTPUT.PUT('Employer Address Province A2' || SEP);
		DBMS_OUTPUT.PUT('Employer Address Zip-Code A2' || SEP);
		DBMS_OUTPUT.PUT('Final Income' || SEP);
		DBMS_OUTPUT.PUT('Employer Name A2' || SEP);
		--DBMS_OUTPUT.PUT('Business Name A2' || SEP);
		DBMS_OUTPUT.PUT('Business Net Monthly Income A2 (รายได้ต่อเดือนที่ลูกค้าแจ้ง ไม่รวมรายได้พิเศษ) ' || SEP);
		DBMS_OUTPUT.PUT('Percentage of Ownership of Business A2' || SEP);
		DBMS_OUTPUT.PUT('Title A3(Thai)' || SEP);
		DBMS_OUTPUT.PUT('A3 Name (Thai)(use in BOT report)' || SEP);
		DBMS_OUTPUT.PUT('A3 Surname (Thai)(use in BOT report)' || SEP);
		DBMS_OUTPUT.PUT('Title A3(English)' || SEP);
		DBMS_OUTPUT.PUT('First Name A3(English)' || SEP);
		DBMS_OUTPUT.PUT('Surname A3(English)' || SEP);
		DBMS_OUTPUT.PUT('Date of Birth (Christian Era) A3' || SEP);
		DBMS_OUTPUT.PUT('Age (years) A3' || SEP);
		DBMS_OUTPUT.PUT('Sex A3' || SEP);
		DBMS_OUTPUT.PUT('Nationality A3' || SEP);
		DBMS_OUTPUT.PUT('Marital Status A3' || SEP);
		DBMS_OUTPUT.PUT('Citizen ID A3(use in BOT report)' || SEP);
		DBMS_OUTPUT.PUT('Highest Education A3' || SEP);
		DBMS_OUTPUT.PUT('Total Number of Dependents A3' || SEP);
		DBMS_OUTPUT.PUT('Relationship with main customer' || SEP);
		DBMS_OUTPUT.PUT('Relationship with main customer' || SEP);
		DBMS_OUTPUT.PUT('Address Province A3' || SEP);
		DBMS_OUTPUT.PUT('Address Zip Code A3' || SEP);
		DBMS_OUTPUT.PUT('Home Phone A3' || SEP);
		DBMS_OUTPUT.PUT('Home Phone Extension A3' || SEP);
		DBMS_OUTPUT.PUT('Mobile Phone A3' || SEP);
		DBMS_OUTPUT.PUT('Current Residential Status A3' || SEP);
		DBMS_OUTPUT.PUT('Letter Delivery Flag A3' || SEP);
		DBMS_OUTPUT.PUT('Joint Occupation status A3' || SEP);
		DBMS_OUTPUT.PUT('Salary Occupation A3' || SEP);
		DBMS_OUTPUT.PUT('Time in Current Salary Employment (Years) A3' || SEP);
		DBMS_OUTPUT.PUT('Time in Current Salary Employment (Months) A3' || SEP);
		DBMS_OUTPUT.PUT('Monthly Salary/Pension A3 ' || SEP);
		DBMS_OUTPUT.PUT('Monthly Extra Income A3' || SEP);
		--DBMS_OUTPUT.PUT('Employment Province' || SEP);del
		DBMS_OUTPUT.PUT('Employer Address Province A3' || SEP);
		DBMS_OUTPUT.PUT('Employer Address Zip-Code A3' || SEP);
		DBMS_OUTPUT.PUT('Final Income' || SEP);
		DBMS_OUTPUT.PUT('Employer Name A3' || SEP);
		--DBMS_OUTPUT.PUT('Business Name A3' || SEP);
		DBMS_OUTPUT.PUT('Business Net Monthly Income A3 (รายได้ต่อเดือนที่ลูกค้าแจ้ง ไม่รวมรายได้พิเศษ) ' || SEP);
		DBMS_OUTPUT.PUT('Percentage of Ownership of Business A3' || SEP);
		DBMS_OUTPUT.PUT('Title A4(Thai)' || SEP);
		DBMS_OUTPUT.PUT('A4 Name (Thai)(use in BOT report)' || SEP);
		DBMS_OUTPUT.PUT('A4 Surname (Thai)(use in BOT report)' || SEP);
		DBMS_OUTPUT.PUT('Title A4(English)' || SEP);
		DBMS_OUTPUT.PUT('First Name A4(English)' || SEP);
		DBMS_OUTPUT.PUT('Surname A4(English)' || SEP);
		DBMS_OUTPUT.PUT('Date of Birth (Christian Era) A4' || SEP);
		DBMS_OUTPUT.PUT('Age (years) A4' || SEP);
		DBMS_OUTPUT.PUT('Sex A4' || SEP);
		DBMS_OUTPUT.PUT('Nationality A4' || SEP);
		DBMS_OUTPUT.PUT('Marital Status A4' || SEP);
		DBMS_OUTPUT.PUT('Citizen ID A4(use in BOT report)' || SEP);
		DBMS_OUTPUT.PUT('Highest Education A4' || SEP);
		DBMS_OUTPUT.PUT('Total Number of Dependents A4' || SEP);
		DBMS_OUTPUT.PUT('Relationship with main customer' || SEP);
		DBMS_OUTPUT.PUT('Relationship with main customer' || SEP);
		DBMS_OUTPUT.PUT('Address Province A4' || SEP);
		DBMS_OUTPUT.PUT('Address Zip Code A4' || SEP);
		DBMS_OUTPUT.PUT('Home Phone A4' || SEP);
		DBMS_OUTPUT.PUT('Home Phone Extension A4' || SEP);
		DBMS_OUTPUT.PUT('Mobile Phone A4' || SEP);
		DBMS_OUTPUT.PUT('Current Residential Status A4' || SEP);
		DBMS_OUTPUT.PUT('Letter Delivery Flag A4' || SEP);
		DBMS_OUTPUT.PUT('Joint Occupation status A4' || SEP);
		DBMS_OUTPUT.PUT('Salary Occupation A4' || SEP);
		DBMS_OUTPUT.PUT('Time in Current Salary Employment (Years) A4' || SEP);
		DBMS_OUTPUT.PUT('Time in Current Salary Employment (Months) A4' || SEP);
		DBMS_OUTPUT.PUT('Monthly Salary/Pension A4 ' || SEP);
		DBMS_OUTPUT.PUT('Monthly Extra Income A4' || SEP);
		--DBMS_OUTPUT.PUT('Employment Province' || SEP);del
		DBMS_OUTPUT.PUT('Employer Address Province A4' || SEP);
		DBMS_OUTPUT.PUT('Employer Address Zip-Code A4' || SEP);
		DBMS_OUTPUT.PUT('Final Income' || SEP);
		DBMS_OUTPUT.PUT('Employer Name A4' || SEP);
		--DBMS_OUTPUT.PUT('Business Name A4' || SEP);
		DBMS_OUTPUT.PUT('Business Net Monthly Income A4 (รายได้ต่อเดือนที่ลูกค้าแจ้ง ไม่รวมรายได้พิเศษ) ' || SEP);
		DBMS_OUTPUT.PUT('Percentage of Ownership of Business A4' || SEP);
		--PT
		DBMS_OUTPUT.PUT('Collateral 1 Type' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Type of Building(use in BOT report)' || SEP);
		DBMS_OUTPUT.PUT('Lot Number of Collateral C1' || SEP);
		DBMS_OUTPUT.PUT('Land Number of Collateral C1' || SEP);
		DBMS_OUTPUT.PUT('Servey Page C1' || SEP);
		DBMS_OUTPUT.PUT('Selling Price of Project(use in BOT report)' || SEP);
		DBMS_OUTPUT.PUT('Housing Project Name and Location' || SEP);
		DBMS_OUTPUT.PUT('Name of Housing Project' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Property Right Type' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Title Deed Number' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Title Deed Book' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Title Deed Page' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Condominium Room Number' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Condominium Area in Square' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Land Area in Rai' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Land Area in Ngan' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Land Area in Square Wa' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Condominium Floor Number' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Address Number' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Address Moo' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Address Soi' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Address Road' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Address Sub District' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Address District' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Address Province' || SEP);
		DBMS_OUTPUT.PUT('Collateral 1 Address Zip Code' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Type' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Type of Building(use in BOT report)' || SEP);
		DBMS_OUTPUT.PUT('Lot Number of Collateral C2' || SEP);
		DBMS_OUTPUT.PUT('Land Number of Collateral C2' || SEP);
		DBMS_OUTPUT.PUT('Servey Page C2' || SEP);
		DBMS_OUTPUT.PUT('Selling Price of Project(use in BOT report) C2' || SEP);
		DBMS_OUTPUT.PUT('Housing Project Name and Location C2' || SEP);
		DBMS_OUTPUT.PUT('Name of Housing Project c2' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Property Right Type' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Title Deed Number' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Title Deed Book' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Title Deed Page' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Condominium Room Number' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Condominium Area in Square' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Land Area in Rai' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Land Area in Ngan' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Land Area in Square Wa' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Condominium Floor Number' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Address Number' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Address Moo' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Address Soi' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Address Road' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Address Sub District' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Address District' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Address Province' || SEP);
		DBMS_OUTPUT.PUT('Collateral 2 Address Zip Code' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Type' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Type of Building(use in BOT report)' || SEP);
		DBMS_OUTPUT.PUT('Lot Number of Collateral C3' || SEP);
		DBMS_OUTPUT.PUT('Land Number of Collateral C3' || SEP);
		DBMS_OUTPUT.PUT('Servey Page C3' || SEP);
		DBMS_OUTPUT.PUT('Selling Price of Project(use in BOT report) C3' || SEP);
		DBMS_OUTPUT.PUT('Housing Project Name and Location C3' || SEP);
		DBMS_OUTPUT.PUT('Name of Housing Project C3' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Property Right Type' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Title Deed Number' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Title Deed Book' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Title Deed Page' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Condominium Room Number' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Condominium Area in Square' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Land Area in Rai' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Land Area in Ngan' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Land Area in Square Wa' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Condominium Floor Number' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Address Number' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Address Moo' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Address Soi' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Address Road' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Address Sub District' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Address District' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Address Province' || SEP);
		DBMS_OUTPUT.PUT('Collateral 3 Address Zip Code' || SEP);
		--FD
		DBMS_OUTPUT.PUT('Collateral Bank Name' || SEP);
		DBMS_OUTPUT.PUT('Collateral Bank Account Number' || SEP);
		DBMS_OUTPUT.PUT('Collateral Bank Account Name' || SEP);
		DBMS_OUTPUT.PUT('Collateral Type of Deposit' || SEP);
		DBMS_OUTPUT.PUT('Collateral Pledge Amount' || SEP);
        --ELIGIBILITY_CHECKS_INFORMATION
		DBMS_OUTPUT.PUT('Main Applicant: Credit Assesment Rules :NCB DB' || SEP);
		DBMS_OUTPUT.PUT('Main Applicant: Credit Assesment Rules :IWS - Negative DB' || SEP);
		DBMS_OUTPUT.PUT('Main Applicant: Credit Assesment Rules :Credit Score' || SEP);
		DBMS_OUTPUT.PUT('Main Applicant: Credit Assesment Rules :Borrower Eligibility Rules' || SEP);
		DBMS_OUTPUT.PUT('Main Applicant: Credit Assesment Rules :NCB DSR' || SEP);
		DBMS_OUTPUT.PUT('Joint Applicant 1: Credit Assesment Rules :NCB DB' || SEP);
		DBMS_OUTPUT.PUT('Joint Applicant 1: Credit Assesment Rules :IWS - Negative DB' || SEP);
		DBMS_OUTPUT.PUT('Joint Applicant 1: Credit Assesment Rules :Credit Score' || SEP);
		DBMS_OUTPUT.PUT('Joint Applicant 1: Credit Assesment Rules :Borrower Eligibility Rules' || SEP);
		DBMS_OUTPUT.PUT('Joint Applicant 1: Credit Assesment Rules :NCB DSR' || SEP);
		DBMS_OUTPUT.PUT('Joint Applicant 2: Credit Assesment Rules :NCB DB' || SEP);
		DBMS_OUTPUT.PUT('Joint Applicant 2: Credit Assesment Rules :IWS - Negative DB' || SEP);
		DBMS_OUTPUT.PUT('Joint Applicant 2: Credit Assesment Rules :Credit Score' || SEP);
		DBMS_OUTPUT.PUT('Joint Applicant 2: Credit Assesment Rules :Borrower Eligibility Rules' || SEP);
		DBMS_OUTPUT.PUT('Joint Applicant 2: Credit Assesment Rules :NCB DSR' || SEP);
		DBMS_OUTPUT.PUT('Joint Applicant 3: Credit Assesment Rules :NCB DB' || SEP);
		DBMS_OUTPUT.PUT('Joint Applicant 3: Credit Assesment Rules :IWS - Negative DB' || SEP);
		DBMS_OUTPUT.PUT('Joint Applicant 3: Credit Assesment Rules :Credit Score' || SEP);
		DBMS_OUTPUT.PUT('Joint Applicant 3: Credit Assesment Rules :Borrower Eligibility Rules' || SEP);
		DBMS_OUTPUT.PUT('Joint Applicant 3: Credit Assesment Rules :NCB DSR' || SEP);
		DBMS_OUTPUT.PUT('Final Result' || SEP);
		DBMS_OUTPUT.PUT('Percentage of probability of default' || SEP);
		--APPLICATION_ROUTING_INFORMATION
		DBMS_OUTPUT.PUT('A Score Result' || SEP);
		DBMS_OUTPUT.PUT('Date/ Time Application in Draft Status' || SEP);
		DBMS_OUTPUT.PUT('Date/ Time Application in Pending NCB Consent Checks' || SEP);
		DBMS_OUTPUT.PUT('Date/ Time Application in Request AACC Report' || SEP);
		DBMS_OUTPUT.PUT('Date/ Time Application in Pending AACC Report Entry' || SEP);
		DBMS_OUTPUT.PUT('Date/ Time Application in Conditional Approval' || SEP);
		DBMS_OUTPUT.PUT('Date/ Time Application in Pending CO Analysis' || SEP);
		--CR
		Total Income
		Known Debt
		DSR2
		Reject Reason
		Nature of Request
		Sales Staff Name
		Log on Staff ID
		Log on Staff Name/ Surname
		--END CR
		DBMS_OUTPUT.NEW_LINE;
		*/
		/* ******************************************************
	     * MO and PL - because they have data in RLOS.los_FAC (and we used RLOS.los_FAC join RLOS.los_CA as our main cursor)
	     * ******************************************************
	     */
		FOR facility IN main_cursor
        LOOP
			v_joint_count := 0;			
        	--The line below is only for debugging
        	--DBMS_OUTPUT.PUT(facility.CA_ID || SEP);
        
	        /* ******************
	         * CA INFORMATION
	         * ******************
	         */
			DBMS_OUTPUT.PUT(facility.APP_REF_NO || SEP);
			DBMS_OUTPUT.PUT(facility.HOST_AA_NO || SEP);
			DBMS_OUTPUT.PUT(facility.APPLICATION_DATE || SEP);
			
			DBMS_OUTPUT.PUT(facility.BOOK_BR_CODE || SEP);			
			OPEN branch_cursor(facility.BOOK_BR_CODE);
                FETCH branch_cursor INTO branch_record;
				IF branch_cursor%NOTFOUND THEN
					DBMS_OUTPUT.PUT('' || SEP);
				ELSE
					DBMS_OUTPUT.PUT(branch_record.DESCRIPTION || SEP);
				END IF;                
            CLOSE branch_cursor;
            
			
			DBMS_OUTPUT.PUT(facility.SALES_STAFF_CODE || SEP);
			
			--creator / credit officer
			OPEN user_cursor(facility.CA_ID);
                FETCH user_cursor INTO user_record;
				IF user_cursor%NOTFOUND THEN
					DBMS_OUTPUT.PUT('' || SEP);
					DBMS_OUTPUT.PUT('' || SEP);
				ELSE
					DBMS_OUTPUT.PUT(user_record.EMPLOYEE_ID || SEP);                
					DBMS_OUTPUT.PUT(user_record.SURNAME || SEP);
				END IF;      
                
            CLOSE user_cursor;     
			
            DBMS_OUTPUT.PUT(facility.APPROVED_DATE || SEP);
			
			/* ******************
	         * FACILITY INFORMATION
	         * ******************
	         */
			DBMS_OUTPUT.PUT(NVL(facility.FAC_CODE,' ') || SEP);
			OPEN cce_cursor(facility.FAC_CODE, '26','TH');
                FETCH cce_cursor INTO cce_record;
				IF facility.FAC_CODE IS NULL THEN
					DBMS_OUTPUT.PUT('' || SEP);
				ELSE
					DBMS_OUTPUT.PUT(cce_record.DISPLAY || SEP);
				END IF;		
            CLOSE cce_cursor;
            
			DBMS_OUTPUT.PUT(NVL(facility.PROD_CODE,' ') || SEP);
			OPEN cce_cursor(facility.PROD_CODE, '27','TH');
                FETCH cce_cursor INTO cce_record;
                IF facility.PROD_CODE IS NULL THEN
					DBMS_OUTPUT.PUT('' || SEP);
				ELSE
					DBMS_OUTPUT.PUT(cce_record.DISPLAY || SEP);
				END IF;	                
            CLOSE cce_cursor;
            
			DBMS_OUTPUT.PUT(NVL(facility.CB_PUR_CODE,' ') || SEP);
			OPEN cce_cursor(facility.CB_PUR_CODE, 'LOAN_PUR_CODE','TH');
                FETCH cce_cursor INTO cce_record;
                IF facility.CB_PUR_CODE IS NULL THEN
					DBMS_OUTPUT.PUT('' || SEP);
				ELSE
					DBMS_OUTPUT.PUT(cce_record.DISPLAY || SEP);
				END IF;	                
            CLOSE cce_cursor;
            
			DBMS_OUTPUT.PUT(NVL(facility.LIMIT_APPLIED,'0') || SEP);
			DBMS_OUTPUT.PUT(NVL(facility.OD_LIMIT,'0') || SEP);
			DBMS_OUTPUT.PUT(NVL(facility.TENURE,'0') || SEP);
			
			DBMS_OUTPUT.PUT(NVL(facility.PAY_METHOD,' ') || SEP);
			OPEN cce_cursor(facility.PAY_METHOD, 'PYMT_TYP','TH');
                FETCH cce_cursor INTO cce_record;
                IF facility.PAY_METHOD IS NULL THEN
					DBMS_OUTPUT.PUT('' || SEP);
				ELSE
					DBMS_OUTPUT.PUT(cce_record.DISPLAY || SEP);
				END IF;	                
            CLOSE cce_cursor;
			
            DBMS_OUTPUT.PUT(facility.PAYMENT_DUE_DATE || SEP);
            DBMS_OUTPUT.PUT(facility.APP_STATUS || SEP);
			
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			
			/* ******************
	         * INDV INFORMATION
	         * ******************
	         */
			
			--===================
			--MAIN CUSTOMER
			--===================
			FOR CIF IN cif_main_cursor(facility.CA_ID)
			LOOP
				DBMS_OUTPUT.PUT(CIF.TH_SALU_CODE || SEP);
				DBMS_OUTPUT.PUT(CIF.TH_NAME_LINE_2 || SEP);
				DBMS_OUTPUT.PUT(CIF.TH_NAME_LINE_1 || SEP);
				DBMS_OUTPUT.PUT(CIF.SALU_CODE || SEP);
				DBMS_OUTPUT.PUT(CIF.NAME_LINE_2 || SEP);
				DBMS_OUTPUT.PUT(CIF.NAME_LINE_1 || SEP);
				DBMS_OUTPUT.PUT(CIF.BIRTH_DATE || SEP);
				DBMS_OUTPUT.PUT(CIF.AGE || SEP);
				DBMS_OUTPUT.PUT(CIF.GENDER || SEP);
				DBMS_OUTPUT.PUT(nvl(CIF.NATIONALITY,'TH') || SEP);
				DBMS_OUTPUT.PUT(CIF.MARITAL_STATUS || SEP);
				DBMS_OUTPUT.PUT(CIF.ID_NO_1 || SEP);
				DBMS_OUTPUT.PUT(CIF.EDUCATION_LEVEL || SEP);
				DBMS_OUTPUT.PUT(CIF.NO_OF_DEPENDENT || SEP);
								
				--residential address
				OPEN addr_cursor(CIF.CIF_ID, 'H');
	                FETCH addr_cursor INTO addr_record;
	                IF addr_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT(' ' || SEP || ' ' || SEP);		
					ELSE
						DBMS_OUTPUT.PUT(addr_record.PROVINCE || SEP || addr_record.POSTAL_CODE || SEP);
					END IF;                
	            CLOSE addr_cursor;
				
	            DBMS_OUTPUT.PUT(CIF.TELEPHONE_NO || SEP);
	            DBMS_OUTPUT.PUT(CIF.REG_EXT_PHONE_NO || SEP);
				DBMS_OUTPUT.PUT(CIF.MOBILE_NO || SEP);
				DBMS_OUTPUT.PUT(CIF.RESIDENT_TYP || SEP);
				DBMS_OUTPUT.PUT(CIF.MAILING_PREFERENCE || SEP);
				
				--employment information
				DBMS_OUTPUT.PUT(CIF.EMP_STATUS || SEP);
				DBMS_OUTPUT.PUT(CIF.RM_OCCUPATION || SEP);
				DBMS_OUTPUT.PUT(CIF.EMP_YR || SEP);
				DBMS_OUTPUT.PUT(CIF.EMP_MONTH || SEP);			
				OPEN income_cursor(CIF.CIF_ID, CIF.EMP_STATUS);
	                FETCH income_cursor INTO income_record;
					IF income_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('0'|| SEP);		
					ELSE
						DBMS_OUTPUT.PUT((income_record.ANNUAL) || SEP);-- income
					END IF;
	            CLOSE income_cursor;
				DBMS_OUTPUT.PUT(CIF.EMP_IN_EXTRA_TOTAL || SEP);
				DBMS_OUTPUT.PUT(CIF.EMP_STATUS || SEP);
				IF facility.APP_TYP = 'MO' THEN
					DBMS_OUTPUT.PUT(CIF.INCOME_FIX_AMNT || SEP);
				ELSE
					DBMS_OUTPUT.PUT(CIF.EMP_IN_OTHER_TOTAL || SEP);
				END IF;
									
				
				--working address
				IF facility.APP_TYP = 'MO' THEN
					DBMS_OUTPUT.PUT(CIF.EMP_PROVINCE || SEP || CIF.EMP_PROVINCE || SEP);
				ELSE
					OPEN addr_emp_cursor(CIF.CIF_ID);
						FETCH addr_emp_cursor INTO addr_emp_record;
						IF addr_emp_cursor%NOTFOUND THEN
							DBMS_OUTPUT.PUT(' ' || SEP || ' ' || SEP);		
						ELSE
							DBMS_OUTPUT.PUT(addr_emp_record.PROVINCE || SEP || addr_emp_record.POSTAL_CODE || SEP);
						END IF;
					CLOSE addr_emp_cursor;
				END IF;
				
				DBMS_OUTPUT.PUT(nvl(CIF.EMP_IN_FINAL_TOTAL,0) || SEP);--annual income
				/*OPEN income_cursor(CIF.CIF_ID, CIF.EMP_STATUS);
	                FETCH income_cursor INTO income_record;
					IF income_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('0'|| SEP);		
					ELSE
						DBMS_OUTPUT.PUT((income_record.ANNUAL) || SEP);--annual income
					END IF;
	            CLOSE income_cursor;*/
				
				DBMS_OUTPUT.PUT(NVL(CIF.EMP_NAME,'-') || SEP);			
				
				-- income
	            DBMS_OUTPUT.PUT(NVL(CIF.IN_DECLARED,0) || SEP); 
	            DBMS_OUTPUT.PUT(NVL(CIF.IN_SHARE_HOLDER_PERCENT,0) || SEP);
				
	             
			END LOOP; --Main Customer
			
            --===================
			--JOINT CUSTOMERS
			--===================
			OPEN cif_joint_cursor(facility.CA_ID);
				FETCH cif_joint_cursor INTO cif_joint_record;
			WHILE cif_joint_cursor%FOUND
			LOOP
			V_JOINT_COUNT := V_JOINT_COUNT + 1;
				DBMS_OUTPUT.PUT(cif_joint_record.TH_SALU_CODE || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.TH_NAME_LINE_2 || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.TH_NAME_LINE_1 || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.SALU_CODE || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.NAME_LINE_2 || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.NAME_LINE_1 || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.BIRTH_DATE || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.AGE || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.GENDER || SEP);
				DBMS_OUTPUT.PUT(nvl(cif_joint_record.NATIONALITY,'TH') || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.MARITAL_STATUS || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.ID_NO_1 || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.EDUCATION_LEVEL || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.NO_OF_DEPENDENT || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.RELATION_WITH_MAIN || SEP);
				OPEN cce_cursor(cif_joint_record.RELATION_WITH_MAIN, 'CUS_REL','TH');
	                FETCH cce_cursor INTO cce_record;
	                IF cif_joint_record.RELATION_WITH_MAIN IS NULL THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(cce_record.DISPLAY || SEP);
					END IF;	                     
	            CLOSE cce_cursor;
	            
				--residential address
				OPEN addr_cursor(cif_joint_record.CIF_ID, 'H');
	                FETCH addr_cursor INTO addr_record;
	                IF addr_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT(' ' || SEP || ' ' || SEP);		
					ELSE
						DBMS_OUTPUT.PUT(addr_record.PROVINCE || SEP || addr_record.POSTAL_CODE || SEP);
					END IF;               
	            CLOSE addr_cursor;
				
	            DBMS_OUTPUT.PUT(cif_joint_record.TELEPHONE_NO || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.REG_EXT_PHONE_NO || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.MOBILE_NO || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.RESIDENT_TYP || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.MAILING_PREFERENCE || SEP);
				
				--employment information
				DBMS_OUTPUT.PUT(cif_joint_record.EMP_STATUS || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.RM_OCCUPATION || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.EMP_YR || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.EMP_MONTH || SEP);			
				OPEN income_cursor(cif_joint_record.CIF_ID, cif_joint_record.EMP_STATUS);
	                FETCH income_cursor INTO income_record;
					IF income_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('0'|| SEP);		
					ELSE
						DBMS_OUTPUT.PUT((income_record.ANNUAL) || SEP);-- income
					END IF;
	            CLOSE income_cursor;
				DBMS_OUTPUT.PUT(cif_joint_record.EMP_IN_EXTRA_TOTAL || SEP);
				--DBMS_OUTPUT.PUT(cif_joint_record.EMP_PROVINCE || SEP); --this is only used by MO
				
				--working address
				IF facility.APP_TYP = 'MO' THEN
					DBMS_OUTPUT.PUT(cif_joint_record.EMP_PROVINCE || SEP || cif_joint_record.EMP_PROVINCE || SEP);
				ELSE
					OPEN addr_emp_cursor(cif_joint_record.CIF_ID);
						FETCH addr_emp_cursor INTO addr_emp_record;
						IF addr_emp_cursor%NOTFOUND THEN
							DBMS_OUTPUT.PUT(' ' || SEP || ' ' || SEP);		
						ELSE
							DBMS_OUTPUT.PUT(addr_emp_record.PROVINCE || SEP || addr_emp_record.POSTAL_CODE || SEP);
						END IF;
					CLOSE addr_emp_cursor;
				END IF;
				
				DBMS_OUTPUT.PUT(nvl(cif_joint_record.EMP_IN_FINAL_TOTAL,0) || SEP);--annual income
				/*OPEN income_cursor(cif_joint_record.CIF_ID, cif_joint_record.EMP_STATUS);
	                FETCH income_cursor INTO income_record;
					IF income_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('0'|| SEP);		
					ELSE
						DBMS_OUTPUT.PUT((income_record.ANNUAL) || SEP);--annual income
					END IF;
	            CLOSE income_cursor;*/
				
				DBMS_OUTPUT.PUT(NVL(cif_joint_record.EMP_NAME,'-') || SEP);			
				
				-- income
	            DBMS_OUTPUT.PUT(NVL(cif_joint_record.IN_DECLARED,0) || SEP); 
	            DBMS_OUTPUT.PUT(NVL(cif_joint_record.IN_SHARE_HOLDER_PERCENT,0) || SEP);

				
				FETCH cif_joint_cursor INTO cif_joint_record;
			END LOOP;
			CLOSE cif_joint_cursor;
			
			FOR i IN (V_JOINT_COUNT+1) .. 3 LOOP
				c :=0;
				for j in (c+1) .. 35 loop
					DBMS_OUTPUT.PUT('' || SEP);
				end loop;
			END LOOP;
			/* ******************
	         * COLLATERAL
	         * ******************
	         */
			 pt_count := 0;
			FOR collateral IN coll_cursor(facility.CA_ID)				
        	LOOP
			    pt_count := pt_count+1;
        		DBMS_OUTPUT.PUT(collateral.SEC_TYP_CODE || SEP);
        		DBMS_OUTPUT.PUT(collateral.SEC_SUB_TYP_CODE || SEP);
        		
        		--PT
				OPEN pt_cursor(collateral.id);
				
					FETCH pt_cursor INTO pt_record;
					IF pt_cursor%NOTFOUND THEN
					c :=0;
					for j in (c+1) .. 24 loop
						DBMS_OUTPUT.PUT('' || SEP);
					end loop;
											
					ELSE
						DBMS_OUTPUT.PUT(pt_record.LOT_CODE || SEP);
						DBMS_OUTPUT.PUT(pt_record.LOT_NO || SEP);
						DBMS_OUTPUT.PUT(pt_record.SURVEY_PAGE || SEP);
						DBMS_OUTPUT.PUT(pt_record.PURCHASE_PRICE || SEP);
						DBMS_OUTPUT.PUT(pt_record.PROJ_CODE || SEP);
						DBMS_OUTPUT.PUT(pt_record.PROJ_NM || SEP);
						DBMS_OUTPUT.PUT(pt_record.COLL_DOC || SEP);
						DBMS_OUTPUT.PUT(pt_record.TITLE_DEED_NO || SEP);
						DBMS_OUTPUT.PUT(pt_record.TITLE_DEED_BOOK || SEP);
						DBMS_OUTPUT.PUT(pt_record.TITLE_DEED_PAGE || SEP);
						DBMS_OUTPUT.PUT(pt_record.CONDO_NO || SEP);
						DBMS_OUTPUT.PUT(pt_record.BUILT_UP_AREA_UNIT || SEP);
						DBMS_OUTPUT.PUT(pt_record.RAI || SEP);
						DBMS_OUTPUT.PUT(pt_record.NGAN || SEP);
						DBMS_OUTPUT.PUT(pt_record.WAH || SEP);
						
						--PT address
						DBMS_OUTPUT.PUT(pt_record.FLOOR || SEP);
						DBMS_OUTPUT.PUT(pt_record.ADDR_NO || SEP);
						DBMS_OUTPUT.PUT(pt_record.MOO || SEP);
						DBMS_OUTPUT.PUT(pt_record.SOI || SEP);
						DBMS_OUTPUT.PUT(pt_record.ROAD || SEP);
						DBMS_OUTPUT.PUT(pt_record.TUMBOL || SEP);
						DBMS_OUTPUT.PUT(pt_record.AMPHUR || SEP);
						DBMS_OUTPUT.PUT(pt_record.PROVINCE || SEP);
						DBMS_OUTPUT.PUT(pt_record.POSTCODE || SEP);
						
					END IF;
				CLOSE pt_cursor;
        		        		        		        		
        	END LOOP; -- end LOOP Collaterals
			
			FOR i IN (pt_count+1) .. 3 LOOP
				c :=0;
				for j in (c+1) .. 26 loop
					DBMS_OUTPUT.PUT('' || SEP);
				end loop;
			END LOOP;
			
			--FD
			OPEN coll_cursor(facility.CA_ID)	;
				FETCH coll_cursor INTO coll_record;
				IF coll_cursor%NOTFOUND THEN
					DBMS_OUTPUT.PUT('' || SEP);
					DBMS_OUTPUT.PUT('' || SEP);
					DBMS_OUTPUT.PUT('' || SEP);
					DBMS_OUTPUT.PUT('' || SEP);
					DBMS_OUTPUT.PUT('' || SEP);
				ELSE
					OPEN fd_cursor(coll_record.id);
					
						FETCH fd_cursor INTO fd_record;
						IF fd_cursor%NOTFOUND THEN
							DBMS_OUTPUT.PUT('' || SEP);
							DBMS_OUTPUT.PUT('' || SEP);
							DBMS_OUTPUT.PUT('' || SEP);
							DBMS_OUTPUT.PUT('' || SEP);
							DBMS_OUTPUT.PUT('' || SEP);
						ELSE
							DBMS_OUTPUT.PUT(fd_record.BANK_NAME || SEP);
							DBMS_OUTPUT.PUT(fd_record.ACCOUNT_NUMBER || SEP);
							DBMS_OUTPUT.PUT(fd_record.ACCOUNT_NAME || SEP);
							DBMS_OUTPUT.PUT(fd_record.TYPE_OF_DEPOSIT || SEP);
							DBMS_OUTPUT.PUT(fd_record.PLEDGE_AMOUNT || SEP);
						END IF;
					CLOSE fd_cursor;
				END IF;
            close coll_cursor;
			
			/* ******************
        	 * Eligibility Main
			 * ********************/
			OPEN eligibility_cursor(facility.CA_ID,facility.CIF_ID ,'%NCB DB','M');
				
                FETCH eligibility_cursor INTO eligibility_record;
					IF eligibility_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(eligibility_record.RESULT || SEP);
					END IF;
			CLOSE eligibility_cursor;

			OPEN eligibility_cursor(facility.CA_ID,facility.CIF_ID ,'%IWS - Negative DB','M');
				
                FETCH eligibility_cursor INTO eligibility_record;
                	IF eligibility_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(eligibility_record.RESULT || SEP);
					END IF;
			CLOSE eligibility_cursor;
			
			OPEN eligibility_cursor(facility.CA_ID,facility.CIF_ID ,'%Credit Score','M');
				
                FETCH eligibility_cursor INTO eligibility_record;
                	IF eligibility_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(eligibility_record.RESULT || SEP);
					END IF;
			CLOSE eligibility_cursor;
			
			OPEN eligibility_cursor(facility.CA_ID,facility.CIF_ID ,'%Borrower Eligibility Rules','M');
				
                FETCH eligibility_cursor INTO eligibility_record;
                	IF eligibility_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(eligibility_record.RESULT || SEP);
					END IF;
			CLOSE eligibility_cursor;
			
			OPEN eligibility_cursor(facility.CA_ID,facility.CIF_ID ,'%DSR','M');
				
                FETCH eligibility_cursor INTO eligibility_record;
                	IF eligibility_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(eligibility_record.RESULT || SEP);
					END IF;
			CLOSE eligibility_cursor;
        	
			V_JOINT_COUNT := 0;
			
			/* ******************
        	 * Eligibility Joint
			 * ********************/
			OPEN cif_joint_cursor(facility.CA_ID);
				FETCH cif_joint_cursor INTO cif_joint_record;
			WHILE cif_joint_cursor%FOUND
			LOOP
			V_JOINT_COUNT := V_JOINT_COUNT + 1;
				OPEN eligibility_cursor(facility.CA_ID,cif_joint_record.CIF_ID ,'%NCB DB','J');
				
					FETCH eligibility_cursor INTO eligibility_record;
						IF eligibility_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(eligibility_record.RESULT || SEP);
					END IF;
				CLOSE eligibility_cursor;

				OPEN eligibility_cursor(facility.CA_ID,cif_joint_record.CIF_ID ,'%IWS - Negative DB','J');
					
					FETCH eligibility_cursor INTO eligibility_record;
						IF eligibility_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(eligibility_record.RESULT || SEP);
					END IF;
				CLOSE eligibility_cursor;
				
				OPEN eligibility_cursor(facility.CA_ID,cif_joint_record.CIF_ID ,'%Credit Score','J');
					
					FETCH eligibility_cursor INTO eligibility_record;
						IF eligibility_cursor%NOTFOUND THEN
							DBMS_OUTPUT.PUT('' || SEP);
						ELSE
							DBMS_OUTPUT.PUT(eligibility_record.RESULT || SEP);
						END IF;
				CLOSE eligibility_cursor;
				
				OPEN eligibility_cursor(facility.CA_ID,cif_joint_record.CIF_ID ,'%Borrower Eligibility Rules','J');
					
					FETCH eligibility_cursor INTO eligibility_record;
						IF eligibility_cursor%NOTFOUND THEN
							DBMS_OUTPUT.PUT('' || SEP);
						ELSE
							DBMS_OUTPUT.PUT(eligibility_record.RESULT || SEP);
						END IF;
				CLOSE eligibility_cursor;
				
				OPEN eligibility_cursor(facility.CA_ID,cif_joint_record.CIF_ID ,'%DSR','J');
					
					FETCH eligibility_cursor INTO eligibility_record;
						IF eligibility_cursor%NOTFOUND THEN
							DBMS_OUTPUT.PUT('' || SEP);
						ELSE
							DBMS_OUTPUT.PUT(eligibility_record.RESULT || SEP);
						END IF;
				CLOSE eligibility_cursor;
			
			FETCH cif_joint_cursor INTO cif_joint_record;
			END LOOP;
			CLOSE cif_joint_cursor;
			
			FOR i IN (V_JOINT_COUNT+1) .. 3 LOOP
				c :=0;
				for j in (c+1) .. 5 loop
					DBMS_OUTPUT.PUT('' || SEP);
				end loop;
			END LOOP;
			
			DBMS_OUTPUT.PUT(facility.ER_RESULT || SEP);
			DBMS_OUTPUT.PUT(facility.SYS_PD || SEP);
			DBMS_OUTPUT.PUT(facility.SYS_PD_RESUT || SEP);
			
			/* ******************
        	 * APPLICATION_ROUTING_INFORMATION
			 * ********************/
        	
			DBMS_OUTPUT.PUT(facility.CREATE_DATE|| SEP);
			
			OPEN routing_cursor(facility.CA_ID,'PENDINGNCBCHECK');
				
				FETCH routing_cursor INTO routing_record;
					IF routing_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(routing_record.CREATE_DATE || SEP);
					END IF;
			CLOSE routing_cursor;
			
			OPEN routing_cursor(facility.CA_ID,'REQUESTAACC');
				
				FETCH routing_cursor INTO routing_record;
					IF routing_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(routing_record.CREATE_DATE || SEP);
					END IF;
			CLOSE routing_cursor;
			
			OPEN routing_cursor(facility.CA_ID,'PENDINGAACCENTRY');
				
				FETCH routing_cursor INTO routing_record;
					IF routing_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(routing_record.CREATE_DATE || SEP);
					END IF;
			CLOSE routing_cursor;
			
			OPEN routing_cursor(facility.CA_ID,'CONDITIONAL-APPROVED');
				
				FETCH routing_cursor INTO routing_record;
					IF routing_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(routing_record.CREATE_DATE || SEP);
					END IF;
			CLOSE routing_cursor;
			
			OPEN routing_cursor(facility.CA_ID,'PENDINGCOANALYSIS');
				
				FETCH routing_cursor INTO routing_record;
					IF routing_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(routing_record.CREATE_DATE || SEP);
					END IF;
			CLOSE routing_cursor;
			
			--CR TMBRLOSPROD-17 24/02/2011 get more fields
			OPEN aacc_check_cursor(facility.APP_REF_NO);
				
				FETCH aacc_check_cursor INTO aacc_check_record;
					IF aacc_check_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('0' || SEP);
						DBMS_OUTPUT.PUT('0' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(aacc_check_record.INCOME || SEP);
						DBMS_OUTPUT.PUT(aacc_check_record.KNOWN_DEBT || SEP);
					END IF;
			CLOSE aacc_check_cursor;
			
			OPEN aacc_dsr_cursor(facility.CIF_ID,facility.APP_TYP);
				
				FETCH aacc_dsr_cursor INTO aacc_dsr_record;
					IF aacc_dsr_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('0' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(aacc_dsr_record.DSR || SEP);
					END IF;
			CLOSE aacc_dsr_cursor;
			
			
			IF facility.APP_STATUS = 'REJECTED' THEN
				DBMS_OUTPUT.PUT(facility.RSN_CODE || SEP);
			ELSE
				DBMS_OUTPUT.PUT('' || SEP);
			END IF;
			
			OPEN cce_cursor(facility.REQ_NATURE, 'NATURE_REQUEST','EN');
                FETCH cce_cursor INTO cce_record;
                IF cce_cursor%NOTFOUND THEN
					DBMS_OUTPUT.PUT('' || SEP);
				ELSE
					DBMS_OUTPUT.PUT(cce_record.DISPLAY || SEP);
				END IF;	                
            CLOSE cce_cursor;
			
			DBMS_OUTPUT.PUT(facility.SALES_STAFF_NAME || SEP);
									
			OPEN staff_cursor(facility.CREATE_BY);
                FETCH staff_cursor INTO staff_record;
                IF staff_cursor%NOTFOUND THEN
					DBMS_OUTPUT.PUT('' || SEP);
					DBMS_OUTPUT.PUT('' || SEP);
				ELSE
					DBMS_OUTPUT.PUT(staff_record.LOGIN_NAME || SEP);
					DBMS_OUTPUT.PUT(staff_record.SURNAME || SEP);
				END IF;	                
            CLOSE staff_cursor;
			--End CR
			
			DBMS_OUTPUT.NEW_LINE; 
        END LOOP; -- end LOOP Facilities
        
        /* ******************************************************
	     * CC - because CC doesn't have data in RLOS.los_FAC (CC details are stored per data in RLOS.los_CIF_INDV)
	     * ******************************************************
	     */
        FOR facility IN cc_cursor
        LOOP
			v_joint_count := 0;	
        	--The line below is only for debugging
        	--DBMS_OUTPUT.PUT(facility.CA_ID || SEP);
        
	        /* ******************
	         * CA INFORMATION
	         * ******************
	         */
			DBMS_OUTPUT.PUT(facility.APP_REF_NO || SEP);
			DBMS_OUTPUT.PUT(facility.HOST_AA_NO || SEP);
			DBMS_OUTPUT.PUT(facility.APPLICATION_DATE || SEP);
			DBMS_OUTPUT.PUT(facility.BOOK_BR_CODE || SEP);
			OPEN branch_cursor(facility.BOOK_BR_CODE);
                FETCH branch_cursor INTO branch_record;
				IF branch_cursor%NOTFOUND THEN
					DBMS_OUTPUT.PUT('' || SEP);
				ELSE
					DBMS_OUTPUT.PUT(branch_record.DESCRIPTION || SEP);
				END IF;                
            CLOSE branch_cursor;
			DBMS_OUTPUT.PUT(facility.SALES_STAFF_CODE || SEP);
			
			--creator / credit officer
			OPEN user_cursor(facility.CA_ID);
                FETCH user_cursor INTO user_record;
				IF user_cursor%NOTFOUND THEN
					DBMS_OUTPUT.PUT('' || SEP);
					DBMS_OUTPUT.PUT('' || SEP);
				ELSE
					DBMS_OUTPUT.PUT(user_record.EMPLOYEE_ID || SEP);                
					DBMS_OUTPUT.PUT(user_record.SURNAME || SEP);
				END IF;      
                
            CLOSE user_cursor;     
			
            DBMS_OUTPUT.PUT(facility.APPROVED_DATE || SEP);
			
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT('' || SEP);
			DBMS_OUTPUT.PUT(facility.APP_STATUS || SEP);
			
			/* ******************
	         * CC INFORMATION
	         * ******************
	         */
			DBMS_OUTPUT.PUT(facility.PRODUCT_TYPE || SEP);
			OPEN cc_supp_cursor(facility.CA_ID);
                FETCH cc_supp_cursor INTO cc_supp_record;
                IF cc_supp_cursor%NOTFOUND THEN
					DBMS_OUTPUT.PUT('' || SEP);
					DBMS_OUTPUT.PUT('' || SEP);
				ELSE
					DBMS_OUTPUT.PUT(cc_supp_record.PRODUCT_TYPE || SEP);
					DBMS_OUTPUT.PUT(cc_supp_record.RELATION_WITH_MAIN || SEP);
				END IF;	                
            CLOSE cc_supp_cursor;
			
			DBMS_OUTPUT.PUT(facility.PRODUCT_TYPE || SEP);
			DBMS_OUTPUT.PUT(facility.PAYMENT_METHOD || SEP);
			DBMS_OUTPUT.PUT(facility.PAYMENT_CRITERIA || SEP);
			DBMS_OUTPUT.PUT(facility.DEBIT_ACCT_NO || SEP);
			DBMS_OUTPUT.PUT(facility.CARD_DELIVERY_ADDRESS || SEP);
        	DBMS_OUTPUT.PUT(facility.VIP_FLAG || SEP);
			
			--===================
			--MAIN CUSTOMER
			--===================
			FOR CIF IN cif_main_cursor(facility.CA_ID)
			LOOP
				DBMS_OUTPUT.PUT(CIF.TH_SALU_CODE || SEP);
				DBMS_OUTPUT.PUT(CIF.TH_NAME_LINE_2 || SEP);
				DBMS_OUTPUT.PUT(CIF.TH_NAME_LINE_1 || SEP);
				DBMS_OUTPUT.PUT(CIF.SALU_CODE || SEP);
				DBMS_OUTPUT.PUT(CIF.NAME_LINE_2 || SEP);
				DBMS_OUTPUT.PUT(CIF.NAME_LINE_1 || SEP);
				DBMS_OUTPUT.PUT(CIF.BIRTH_DATE || SEP);
				DBMS_OUTPUT.PUT(CIF.AGE || SEP);
				DBMS_OUTPUT.PUT(CIF.GENDER || SEP);
				DBMS_OUTPUT.PUT(CIF.NATIONALITY || SEP);
				DBMS_OUTPUT.PUT(CIF.MARITAL_STATUS || SEP);
				DBMS_OUTPUT.PUT(CIF.ID_NO_1 || SEP);
				DBMS_OUTPUT.PUT(CIF.EDUCATION_LEVEL || SEP);
				DBMS_OUTPUT.PUT(CIF.NO_OF_DEPENDENT || SEP);
								
				--residential address
				OPEN addr_cursor(CIF.CIF_ID, 'H');
	                FETCH addr_cursor INTO addr_record;
	                IF addr_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT(' ' || SEP || ' ' || SEP);		
					ELSE
						DBMS_OUTPUT.PUT(addr_record.PROVINCE || SEP || addr_record.POSTAL_CODE || SEP);
					END IF;                
	            CLOSE addr_cursor;
				
	            DBMS_OUTPUT.PUT(CIF.TELEPHONE_NO || SEP);
	            DBMS_OUTPUT.PUT(CIF.REG_EXT_PHONE_NO || SEP);
				DBMS_OUTPUT.PUT(CIF.MOBILE_NO || SEP);
				DBMS_OUTPUT.PUT(CIF.RESIDENT_TYP || SEP);
				DBMS_OUTPUT.PUT(CIF.MAILING_PREFERENCE || SEP);
				
				--employment information
				DBMS_OUTPUT.PUT(CIF.EMP_STATUS || SEP);
				DBMS_OUTPUT.PUT(CIF.RM_OCCUPATION || SEP);
				DBMS_OUTPUT.PUT(CIF.EMP_YR || SEP);
				DBMS_OUTPUT.PUT(CIF.EMP_MONTH || SEP);			
				OPEN income_cursor(CIF.CIF_ID, CIF.EMP_STATUS);
	                FETCH income_cursor INTO income_record;
					IF income_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('0'|| SEP);		
					ELSE
						DBMS_OUTPUT.PUT((income_record.ANNUAL) || SEP);-- income
					END IF;
	            CLOSE income_cursor;
				DBMS_OUTPUT.PUT(CIF.EMP_IN_EXTRA_TOTAL || SEP);
				DBMS_OUTPUT.PUT(CIF.EMP_STATUS || SEP);
				DBMS_OUTPUT.PUT(CIF.EMP_IN_OTHER_TOTAL || SEP);
				--DBMS_OUTPUT.PUT(CIF.EMP_PROVINCE || SEP); --this is only used by MO
				
				--working address
				OPEN addr_emp_cursor(CIF.CIF_ID);
						FETCH addr_emp_cursor INTO addr_emp_record;
						IF addr_emp_cursor%NOTFOUND THEN
							DBMS_OUTPUT.PUT(' ' || SEP || ' ' || SEP);		
						ELSE
							DBMS_OUTPUT.PUT(addr_emp_record.PROVINCE || SEP || addr_emp_record.POSTAL_CODE || SEP);
						END IF;
				CLOSE addr_emp_cursor;

				DBMS_OUTPUT.PUT(nvl(CIF.EMP_IN_FINAL_TOTAL,0) || SEP);--annual income
				/*OPEN income_cursor(CIF.CIF_ID, CIF.EMP_STATUS);
	                FETCH income_cursor INTO income_record;
					IF income_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('0'|| SEP);		
					ELSE
						DBMS_OUTPUT.PUT((income_record.ANNUAL) || SEP);--annual income
					END IF;
	            CLOSE income_cursor;*/
				
				DBMS_OUTPUT.PUT(NVL(CIF.EMP_NAME,'-')|| SEP);			
				
				-- income
	            DBMS_OUTPUT.PUT(NVL(CIF.IN_DECLARED,0) || SEP); 
	            DBMS_OUTPUT.PUT(NVL(CIF.IN_SHARE_HOLDER_PERCENT,0) || SEP);
				
	             
			END LOOP; --Main Customer
			
			--===================
			--JOINT CUSTOMERS
			--===================
			OPEN cif_joint_cursor(facility.CA_ID);
				FETCH cif_joint_cursor INTO cif_joint_record;
			WHILE cif_joint_cursor%FOUND
			LOOP
			V_JOINT_COUNT := V_JOINT_COUNT + 1;
				DBMS_OUTPUT.PUT(cif_joint_record.TH_SALU_CODE || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.TH_NAME_LINE_2 || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.TH_NAME_LINE_1 || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.SALU_CODE || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.NAME_LINE_2 || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.NAME_LINE_1 || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.BIRTH_DATE || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.AGE || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.GENDER || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.NATIONALITY || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.MARITAL_STATUS || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.ID_NO_1 || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.EDUCATION_LEVEL || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.NO_OF_DEPENDENT || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.RELATION_WITH_MAIN || SEP);
				OPEN cce_cursor(cif_joint_record.RELATION_WITH_MAIN, 'CUS_REL','TH');
	                FETCH cce_cursor INTO cce_record;
	                IF cif_joint_record.RELATION_WITH_MAIN IS NULL THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(cce_record.DISPLAY || SEP);
					END IF;	                     
	            CLOSE cce_cursor;
	            
				--residential address
				OPEN addr_cursor(cif_joint_record.CIF_ID, 'H');
	                FETCH addr_cursor INTO addr_record;
	                IF addr_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT(' ' || SEP || ' ' || SEP);	
					ELSE
						DBMS_OUTPUT.PUT(addr_record.PROVINCE || SEP || addr_record.POSTAL_CODE || SEP);
					END IF;                
	            CLOSE addr_cursor;
				
	            DBMS_OUTPUT.PUT(cif_joint_record.TELEPHONE_NO || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.REG_EXT_PHONE_NO || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.MOBILE_NO || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.RESIDENT_TYP || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.MAILING_PREFERENCE || SEP);
				
				--employment information
				DBMS_OUTPUT.PUT(cif_joint_record.EMP_STATUS || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.RM_OCCUPATION || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.EMP_YR || SEP);
				DBMS_OUTPUT.PUT(cif_joint_record.EMP_MONTH || SEP);			
				OPEN income_cursor(cif_joint_record.CIF_ID, cif_joint_record.EMP_STATUS);
	                FETCH income_cursor INTO income_record;
					IF income_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('0'|| SEP);		
					ELSE
						DBMS_OUTPUT.PUT((income_record.ANNUAL) || SEP);-- income
					END IF;
	            CLOSE income_cursor;
				DBMS_OUTPUT.PUT(cif_joint_record.EMP_IN_EXTRA_TOTAL || SEP);
				--DBMS_OUTPUT.PUT(cif_joint_record.EMP_PROVINCE || SEP); --this is only used by MO
				
				--working address
				OPEN addr_emp_cursor(cif_joint_record.CIF_ID);
						FETCH addr_emp_cursor INTO addr_emp_record;
						IF addr_emp_cursor%NOTFOUND THEN
							DBMS_OUTPUT.PUT(' ' || SEP || ' ' || SEP);		
						ELSE
							DBMS_OUTPUT.PUT(addr_emp_record.PROVINCE || SEP || addr_emp_record.POSTAL_CODE || SEP);
						END IF;
				CLOSE addr_emp_cursor;

				DBMS_OUTPUT.PUT(nvl(cif_joint_record.EMP_IN_FINAL_TOTAL,0) || SEP);--annual income
				/*OPEN income_cursor(cif_joint_record.CIF_ID, cif_joint_record.EMP_STATUS);
	                FETCH income_cursor INTO income_record;
					IF income_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('0'|| SEP);		
					ELSE
						DBMS_OUTPUT.PUT((income_record.ANNUAL) || SEP);--annual income
					END IF;
	            CLOSE income_cursor;*/
				
				DBMS_OUTPUT.PUT(NVL(cif_joint_record.EMP_NAME,'-') || SEP);			
				
				-- income
	            DBMS_OUTPUT.PUT(NVL(cif_joint_record.IN_DECLARED,0) || SEP); 
	            DBMS_OUTPUT.PUT(NVL(cif_joint_record.IN_SHARE_HOLDER_PERCENT,0) || SEP);

				FETCH cif_joint_cursor INTO cif_joint_record;
			END LOOP;
			CLOSE cif_joint_cursor;
			
			FOR i IN (V_JOINT_COUNT+1) .. 3 LOOP
				c :=0;
				for j in (c+1) .. 35 loop
					DBMS_OUTPUT.PUT('' || SEP);
				end loop;
			END LOOP;
			
			--pt column
			c :=0;
				for j in (c+1) .. 78 loop
					DBMS_OUTPUT.PUT('' || SEP);
				end loop;
			
            --FD
			OPEN coll_cursor(facility.CA_ID)	;
				FETCH coll_cursor INTO coll_record;
				IF coll_cursor%NOTFOUND THEN
					DBMS_OUTPUT.PUT('' || SEP);
					DBMS_OUTPUT.PUT('' || SEP);
					DBMS_OUTPUT.PUT('' || SEP);
					DBMS_OUTPUT.PUT('' || SEP);
					DBMS_OUTPUT.PUT('' || SEP);
				ELSE
					OPEN fd_cursor(coll_record.id);
					
						FETCH fd_cursor INTO fd_record;
						IF fd_cursor%NOTFOUND THEN
							DBMS_OUTPUT.PUT('' || SEP);
							DBMS_OUTPUT.PUT('' || SEP);
							DBMS_OUTPUT.PUT('' || SEP);
							DBMS_OUTPUT.PUT('' || SEP);
							DBMS_OUTPUT.PUT('' || SEP);
						ELSE
							DBMS_OUTPUT.PUT(fd_record.BANK_NAME || SEP);
							DBMS_OUTPUT.PUT(fd_record.ACCOUNT_NUMBER || SEP);
							DBMS_OUTPUT.PUT(fd_record.ACCOUNT_NAME || SEP);
							DBMS_OUTPUT.PUT(fd_record.TYPE_OF_DEPOSIT || SEP);
							DBMS_OUTPUT.PUT(fd_record.PLEDGE_AMOUNT || SEP);
						END IF;
					CLOSE fd_cursor;
				END IF;
            close coll_cursor;
		   
		   
		    --Eligibility Main
			 
			OPEN eligibility_cursor(facility.CA_ID,facility.CIF_ID ,'%NCB DB','M');
				
                FETCH eligibility_cursor INTO eligibility_record;
                	IF eligibility_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(eligibility_record.RESULT || SEP);
					END IF;
			CLOSE eligibility_cursor;

			OPEN eligibility_cursor(facility.CA_ID,facility.CIF_ID ,'%IWS - Negative DB','M');
				
                FETCH eligibility_cursor INTO eligibility_record;
                	IF eligibility_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(eligibility_record.RESULT || SEP);
					END IF;
			CLOSE eligibility_cursor;
			
			OPEN eligibility_cursor(facility.CA_ID,facility.CIF_ID ,'%Credit Score','M');
				
                FETCH eligibility_cursor INTO eligibility_record;
                	IF eligibility_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(eligibility_record.RESULT || SEP);
					END IF;
			CLOSE eligibility_cursor;
			
			OPEN eligibility_cursor(facility.CA_ID,facility.CIF_ID ,'%Borrower Eligibility Rules','M');
				
                FETCH eligibility_cursor INTO eligibility_record;
                	IF eligibility_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(eligibility_record.RESULT || SEP);
					END IF;
			CLOSE eligibility_cursor;
			
			OPEN eligibility_cursor(facility.CA_ID,facility.CIF_ID ,'%DSR','M');
				
                FETCH eligibility_cursor INTO eligibility_record;
                	IF eligibility_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(eligibility_record.RESULT || SEP);
					END IF;
			CLOSE eligibility_cursor;
        	
			--Eligibility Joint
			V_JOINT_COUNT := 0;
			
			
			FOR i IN (V_JOINT_COUNT+1) .. 3 LOOP
				c :=0;
				for j in (c+1) .. 5 loop
					DBMS_OUTPUT.PUT('' || SEP);
				end loop;
			END LOOP;
			
			DBMS_OUTPUT.PUT(facility.ER_RESULT || SEP);
			DBMS_OUTPUT.PUT(facility.SYS_PD || SEP);
			DBMS_OUTPUT.PUT(facility.SYS_PD_RESUT || SEP);
			
			/* ******************
        	 * APPLICATION_ROUTING_INFORMATION
			 * ********************/
        	
			DBMS_OUTPUT.PUT(facility.CREATE_DATE|| SEP);
			
			OPEN routing_cursor(facility.CA_ID,'PENDINGNCBCHECK');
				
				FETCH routing_cursor INTO routing_record;
					IF routing_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(routing_record.CREATE_DATE || SEP);
					END IF;
			CLOSE routing_cursor;
			
			OPEN routing_cursor(facility.CA_ID,'REQUESTAACC');
				
				FETCH routing_cursor INTO routing_record;
					IF routing_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(routing_record.CREATE_DATE || SEP);
					END IF;
			CLOSE routing_cursor;
			
			OPEN routing_cursor(facility.CA_ID,'PENDINGAACCENTRY');
				
				FETCH routing_cursor INTO routing_record;
					IF routing_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(routing_record.CREATE_DATE || SEP);
					END IF;
			CLOSE routing_cursor;
			
			OPEN routing_cursor(facility.CA_ID,'CONDITIONAL-APPROVED');
				
				FETCH routing_cursor INTO routing_record;
					IF routing_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(routing_record.CREATE_DATE || SEP);
					END IF;
			CLOSE routing_cursor;
			
			OPEN routing_cursor(facility.CA_ID,'PENDINGCOANALYSIS');
				
				FETCH routing_cursor INTO routing_record;
					IF routing_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(routing_record.CREATE_DATE || SEP);
					END IF;
			CLOSE routing_cursor;
			
			--CR TMBRLOSPROD-17 24/02/2011 get more fields
			OPEN aacc_check_cursor(facility.APP_REF_NO);
				
				FETCH aacc_check_cursor INTO aacc_check_record;
					IF aacc_check_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('0' || SEP);
						DBMS_OUTPUT.PUT('0' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(aacc_check_record.INCOME || SEP);
						DBMS_OUTPUT.PUT(aacc_check_record.KNOWN_DEBT || SEP);
					END IF;
			CLOSE aacc_check_cursor;
			
			OPEN aacc_dsr_cursor(facility.CIF_ID,facility.APP_TYP);
				
				FETCH aacc_dsr_cursor INTO aacc_dsr_record;
					IF aacc_dsr_cursor%NOTFOUND THEN
						DBMS_OUTPUT.PUT('0' || SEP);
					ELSE
						DBMS_OUTPUT.PUT(aacc_dsr_record.DSR || SEP);
					END IF;
			CLOSE aacc_dsr_cursor;
			
			IF facility.APP_STATUS = 'REJECTED' THEN
				DBMS_OUTPUT.PUT(facility.RSN_CODE || SEP);
			ELSE
				DBMS_OUTPUT.PUT('' || SEP);
			END IF;
			
			OPEN cce_cursor(facility.REQ_NATURE, 'NATURE_REQUEST','EN');
                FETCH cce_cursor INTO cce_record;
                IF cce_cursor%NOTFOUND THEN
					DBMS_OUTPUT.PUT('' || SEP);
				ELSE
					DBMS_OUTPUT.PUT(cce_record.DISPLAY || SEP);
				END IF;	                
            CLOSE cce_cursor;
			
			DBMS_OUTPUT.PUT(facility.SALES_STAFF_NAME || SEP);
			
			OPEN staff_cursor(facility.CREATE_BY);
                FETCH staff_cursor INTO staff_record;
                IF staff_cursor%NOTFOUND THEN
					DBMS_OUTPUT.PUT('' || SEP);
					DBMS_OUTPUT.PUT('' || SEP);
				ELSE
					DBMS_OUTPUT.PUT(staff_record.LOGIN_NAME || SEP);
					DBMS_OUTPUT.PUT(staff_record.SURNAME || SEP);
				END IF;	                
            CLOSE staff_cursor;
			--End CR
			
        	DBMS_OUTPUT.NEW_LINE;
        END LOOP;
        
        
        
END;
/