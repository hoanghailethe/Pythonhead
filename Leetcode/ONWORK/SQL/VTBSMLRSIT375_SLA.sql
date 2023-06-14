D:\Integro\Vietinbank\RLOS_VTB\src\com\integrosys\sml\los\app\ca\todo\CommonTaskManager.java

public List getCAToDoList(String column, String order,int currentPageNumber,long userID,String appType, String appNo,String applicantName,String applicantID,String status, long assignedToRole, String centreType, String branchCode,String teamCode, String departmentCode, String isReturned, Integer paginationSize) throws BusinessException, Exception
	{
	    List toDoList = new ArrayList();
	    
	    /*1. get to do list*/
	    toDoList = commonApplicationDAO.getCAToDoList(column, order, currentPageNumber, userID, appType, appNo,applicantName,applicantID,status, assignedToRole, centreType, branchCode , teamCode,departmentCode,isReturned, paginationSize);
	    

...

 for(int i=0;i<toDoList.size();i++)
            {
            	opApplication = (OBApplication) toDoList.get(i);
            
            	completeDueDate = opApplication.getCompleteDueDate();
    			
            	//add in logic to prevent null exception
            	if (completeDueDate != null)
            	{
            	    opApplication.setIsRed(completeDueDate.before(currentDate));
            	}


//set string type aging         	
            	Map durationMap = CalendarUtil.getInstance().getDurationMap(branchCode, opApplication.getAging(), new Date());
            	if (durationMap == null)
            	{
                    DefaultLogger.debug(this,"##########Calender data for branch "+ branchCode + " has not setup");
                    opApplication.setAgingStr("-");
            	}
            	else 
            	{
                    int day = (Integer)durationMap.get(CalendarUtil.DAY);
                    int hr = (Integer)durationMap.get(CalendarUtil.HOUR);
                    int week = 0;
                    if(durationMap.get(CalendarUtil.WEEK) != null)
                    	week = (Integer) durationMap.get(CalendarUtil.WEEK);

                    if(week > 0)
                    	day += (week * 7);
                    
                    opApplication.setAgingStr(day+"d"+hr+"h");
            	}


	<sql-query name="get.to.do.list.p1" resultset-ref="commonApp.todolist.p1" callable="true">
		{ call COMMON_APP_TODOLIST_P1 (?, :user_id_in,:page_in,:calculated_page_in,:record_per_page_in,:sort_column_in,:sort_order_in,:app_type_in,:app_no_in,:applicant_name_in,:applicant_id_in,:status_in,:assign_to_role,:centre_type,:br_code,:team_code,:department_code,:isReturned) }
    </sql-query>


	@Override
	public List getCAToDoList(String column, String order, int currentPageNumber,long userID, String appType, String appNo,String applicantName,String applicantID,String status, long assignedToRole, String centreType, String branchCode, String teamCode, String departmentCode,String isReturned, Integer paginationSize) 
	{	

		List queryList = new ArrayList();

		DefaultLogger.debug(this, "#################### getCAToDoList");
		appNo = CommonStringUtil.hasValue(appNo)? appNo.toUpperCase() + "%" : "%";


-- PROC
VW1.WF_CREATE_DATE AS AGING,
        VW1.COMPLETE_DUE_DATE AS COMPLETEDUEDATE,
        VW1.LOAN_CONTRACT_DATE AS LOANCONTRACTDATE,
        VW1.MO_SIGNING_DATE AS MOSIGNINGDATE,
        CASE
            WHEN VW1.DECISION = 'DECLINE' THEN 'REJECTED'
            WHEN VW1.DECISION = 'APPROVE' THEN 'APPROVED'
            ELSE '-'
        END AS RECOMMENDDECISION,
        VW1.REQ_NATURE,
        VW1.RETURN_CTR
      FROM
      (
        SELECT
            LOS_CA.APP_TYP,
      		LOS_CA.APP_SUB_TYP,
            LOS_CA.REQ_NATURE,
            LOS_CA.APP_REF_NO,
            LOS_WF_TASK.APP_STATUS,
            LOS_CA.CREATE_DATE AS CREATE_DATE,
            LOS_CA.ASSIGNED_DATE  AS ASSIGNED_DATE,
            LOS_CA.INTEGRATION_DATE_1,
            LOS_CA.INTEGRATION_STS_1,
            LOS_CA.INTEGRATION_STS_4,
            LOS_WF_TASK.TASK_ID,
            STS.ENTRY_NAME AS STATUS_DESC,
            LOS_CA.ID,
            NVL(LOS_CIF_INDV.ID_NO_1, '') AS APPLICANTID,
            NVL(LOS_CIF_INDV.LOCAL_NAME_LINE_2, '') || ' ' || NVL(LOS_CIF_INDV.LOCAL_NAME_LINE_1, '') AS APPLICANTNAME,
            NVL(LOS_USER.FIRST_NAME, '') || ' ' || NVL(LOS_USER.SURNAME, '') AS ASSIGNEE,
            LOS_WF_TASK.IS_RETURNED AS HAS_RETURNED,
            LOS_WF_TASK.CREATE_DATE AS WF_CREATE_DATE,
            LOS_WF_TASK.COMPLETE_DUE_DATE,
            LOS_REG_REQUEST.LOAN_CONTRACT_DATE AS LOAN_CONTRACT_DATE,
            LOS_REG_REQUEST.MO_SIGNING_DATE AS MO_SIGNING_DATE,
            (
              SELECT LOS_FAC_APPR.DECISION FROM LOS_CA XCA
              LEFT JOIN LOS_FAC ON LOS_FAC.CA_ID = XCA.ID AND LOS_FAC.STATUS = 'ACTIVE'
              LEFT JOIN LOS_FAC_APPR ON LOS_FAC_APPR.FAC_ID = LOS_FAC.ID AND LOS_FAC_APPR.FAC_APPR_TYPE = 'RECOMMEND' AND LOS_FAC_APPR.STATUS = 'ACTIVE'
              WHERE XCA.ID = LOS_CA.ID AND ROWNUM = 1
            ) AS DECISION,
            CASE
              WHEN UPPER(LOS_WF_TASK.WORKFLOW_TYPE) = 'FILENET' THEN
                ( SELECT COUNT(1) AS RETURN_CTR FROM LOS_WF_TASK_ARCHIVED WHERE APP_ID = LOS_CA.ID AND IS_RETURNED = 'Y' )
              ELSE
                ( SELECT COUNT(1) AS RETURN_CTR FROM LOS_WF_TASK WHERE APP_ID = LOS_CA.ID AND IS_RETURNED = 'Y' )
            END AS RETURN_CTR
          FROM LOS_CA
          INNER JOIN LOS_WF_TASK ON LOS_CA.ID = LOS_WF_TASK.APP_ID AND LOS_WF_TASK.TASK_STATUS = 0 AND NVL(LOS_WF_TASK.EDITABLE, 'Y') = 'Y'
          AND (LOS_WF_TASK.ORG_CODE = ORG_CODE_IN OR LOS_WF_TASK.ORG_CODE = TEAM_CODE_IN OR LOS_WF_TASK.ROUTING_BR_CODE = DEPT_CODE_IN)
          LEFT JOIN LOS_CIF_INDV ON LOS_CIF_INDV.CA_ID = LOS_CA.ID AND LOS_CIF_INDV.CIF_REL_CODE = 'M' AND LOS_CIF_INDV.STATUS = 'ACTIVE'
          LEFT JOIN LOS_USER ON LOS_USER.ID = LOS_CA.UPDATE_BY AND LOS_USER.STATUS = 'ACTIVE'
          LEFT JOIN LOS_REG_REQUEST ON  LOS_CA.ID = LOS_REG_REQUEST.CA_ID
          LEFT JOIN COMMON_CODE_CATEGORY_ENTRY STS ON STS.ENTRY_CODE = LOS_WF_TASK.APP_STATUS AND STS.CATEGORY_CODE = 'APP_STATUS'

          WHERE LOS_WF_TASK.USER_ID = USER_ID_IN AND
          LOS_WF_TASK.ROLETYPE_ID = ASSIGN_TO_ROLE_IN
          AND NVL(LOS_CA.IS_COMPLETED,'N') = 'N'
          AND LOS_CA.APP_REF_NO LIKE APP_NO_IN AND
          LOS_WF_TASK.APP_STATUS LIKE STATUS_IN AND
          LOS_CA.IS_RETURNED LIKE IS_RETURNED_IN AND
          NVL(LOS_CIF_INDV.ID_NO_1, ' ') LIKE APPLICANT_ID_IN
          AND (NVL(LOS_CA.INTEGRATION_STS_1,'N') = 'N' OR LOS_CA.INTEGRATION_STS_1 = 'F' OR LOS_CA.INTEGRATION_STS_1 = 'I' OR LOS_CA.INTEGRATION_STS_1 = 'G' OR LOS_CA.INTEGRATION_STS_1 = 'V' OR LOS_CA.INTEGRATION_STS_1 = 'Z')

       )VW1 
       WHERE VW1.APPLICANTNAME LIKE APPLICANT_NAME_IN


 LOS_WF_TASK.IS_RETURNED AS HAS_RETURNED,
            LOS_WF_TASK.CREATE_DATE AS WF_CREATE_DATE,
            LOS_WF_TASK.COMPLETE_DUE_DATE,
            LOS_REG_REQUEST.LOAN_CONTRACT_DATE AS LOAN_CONTRACT_DATE,
            LOS_REG_REQUEST.MO_SIGNING_DATE AS MO_SIGNING_DATE,

 FROM LOS_CA
          INNER JOIN LOS_WF_TASK ON LOS_CA.ID = LOS_WF_TASK.APP_ID AND LOS_WF_TASK.TASK_STATUS = 0 AND NVL(LOS_WF_TASK.EDITABLE, 'Y') = 'Y'
          AND (LOS_WF_TASK.ORG_CODE = ORG_CODE_IN OR LOS_WF_TASK.ORG_CODE = TEAM_CODE_IN OR LOS_WF_TASK.ROUTING_BR_CODE = DEPT_CODE_IN)

LEFT JOIN COMMON_CODE_CATEGORY_ENTRY STS ON STS.ENTRY_CODE = LOS_WF_TASK.APP_STATUS AND STS.CATEGORY_CODE = 'APP_STATUS'



COMPLETE_DUE_DATE : 30-AUG-18


if( processFlag == IWorkflowConst.startProcessFlag ) {
				workflowController.setPickupDate( new Date() );

				durationMap.put(CalendarUtil.HOUR, Integer.parseInt(completeDueTime.toString()));
				Date completeDueDate = workflowControllerManager.getDueDate(workflowController.getOrgCode(), workflowController.getPickupDate() == null ? new Date() : workflowController.getPickupDate(), durationMap);
				workflowController.setCompleteDueDate(completeDueDate);
			}




if( workflowController.getPickupDate() == null ) {
			workflowController.setPickupDate(new Date());

			Map<String, Integer> durationMap = new HashMap<String, Integer>();
			durationMap.put(CalendarUtil.HOUR, Integer.parseInt(completeDueTime.toString()));
			Date completeDueDate = workflowControllerManager.getDueDate(workflowController.getOrgCode(), workflowController.getPickupDate() == null ? new Date() : workflowController.getPickupDate(), durationMap);
			workflowController.setCompleteDueDate(completeDueDate);


src\com\integrosys\sml\los\app\workflow\activiti\engine\ACTIVITIProcessUtil.java
	public IWorkflowController forceStartTask(Map<String, Object> paramMap) throws BusinessException, Exception {
		Long taskId = (Long)paramMap.get(IWorkflowConst.VAR_TASK_ID);
		Long completeDueTime = (Long)paramMap.get(IWorkflowConst.VAR_COMPLETE_DUE_TIME);
		Long userId = (Long)paramMap.get(IWorkflowConst.VAR_USER_ID);
		Long applicationId = (Long)paramMap.get(IWorkflowConst.VAR_APP_ID);
		
		IWorkflowController workflowController = workflowControllerManager.getWorkflowController(taskId);
		if( workflowController.getPickupDate() == null ) {
			workflowController.setPickupDate(new Date());

			Map<String, Integer> durationMap = new HashMap<String, Integer>();
			durationMap.put(CalendarUtil.HOUR, Integer.parseInt(completeDueTime.toString()));
			Date completeDueDate = workflowControllerManager.getDueDate(workflowController.getOrgCode(), workflowController.getPickupDate() == null ? new Date() : workflowController.getPickupDate(), durationMap);
			workflowController.setCompleteDueDate(completeDueDate);

<sql-query name="getSLASequence">
	    <return-scalar column="sla_seq" type="string"/>
	    <![CDATA[
	    	select SLA_SEQ from los_wf_status_sla
			where app_type =:appType and app_status =:appStatus and SLA_SEQ is not null
	    ]]>
    </sql-query>


protected Long getCompleteDueTime( String applicationStatus,String appType ) throws BusinessException, Exception {
		OBSLA obSla = slaManager.getSLAByApplicationType(appType, ILOSConstant.DB_RECORD_STATUS_ACTIVE);
		String slaSeq = slaManager.getSLASequence(appType, applicationStatus);
				
		if( obSla != null && slaSeq != null ) {
			Long durNumber = Long.parseLong(slaSeq);
			if( durNumber != null ) {
				Method method = OBSLA.class.getMethod("getSLADur"+durNumber, (Class[])null);
				BigInteger value = (BigInteger)method.invoke(obSla, (Object[])null);
				if( value != null ) return value.longValue();
			}
		}
		return new Long(0);
	}


/* add by momo for work flow */
	@Override
	public OBSLA getSLAByApplicationType( String applicationType, String status )throws Exception {
		Session s = super.getCurrentSession();
		Query q = s.getNamedQuery("actual.sla.with.application.type")
			.setString("application_type", applicationType)
			.setString("status", status);
		return (OBSLA)q.uniqueResult();
	}

select ID, ENTRY_ID, APP_TYPE, APP_STATUS, DESCRIPTION, SLA_SEQ
		   	from los_wf_status_sla ;
			
<sql-query name="actual.sla.with.application.type" resultset-ref="sla.application.type">
    <![CDATA[
    	SELECT
    		ID,	APP_TYP,
    		SLA_DUR_1, SLA_DUR_2, SLA_DUR_3, SLA_DUR_4, SLA_DUR_5, SLA_DUR_6, SLA_DUR_7, SLA_DUR_8, SLA_DUR_9, SLA_DUR_10, 
    		SLA_DUR_11, SLA_DUR_12, SLA_DUR_13, SLA_DUR_14, SLA_DUR_15, SLA_DUR_16, SLA_DUR_17, SLA_DUR_18, SLA_DUR_19, SLA_DUR_20,
    		SLA_DUR_21, SLA_DUR_22, SLA_DUR_23, SLA_DUR_24, SLA_DUR_25, SLA_DUR_26, SLA_DUR_27, SLA_DUR_28, SLA_DUR_29, SLA_DUR_30,
    		SLA_DUR_31, SLA_DUR_32, SLA_DUR_33, SLA_DUR_34, SLA_DUR_35, SLA_DUR_36, SLA_DUR_37, SLA_DUR_38, SLA_DUR_39, SLA_DUR_40,
    		SLA_DUR_41, SLA_DUR_42, SLA_DUR_43, SLA_DUR_44, SLA_DUR_45, SLA_DUR_46, SLA_DUR_47, SLA_DUR_48, SLA_DUR_49, SLA_DUR_50, 
    		SLA_DUR_51, SLA_DUR_52, SLA_DUR_53, SLA_DUR_54, SLA_DUR_55, SLA_DUR_56, SLA_DUR_57, SLA_DUR_58, SLA_DUR_59, SLA_DUR_60,
    		SLA_DUR_61, SLA_DUR_62, SLA_DUR_63, SLA_DUR_64, SLA_DUR_65, SLA_DUR_66, SLA_DUR_67, SLA_DUR_68, SLA_DUR_69, SLA_DUR_70,
    		SLA_DUR_71, SLA_DUR_72, SLA_DUR_73, SLA_DUR_74, SLA_DUR_75, SLA_DUR_76, SLA_DUR_77, SLA_DUR_78, SLA_DUR_79, SLA_DUR_80
    	FROM LOS_SA_SLA
    	WHERE APP_TYP = :application_type and STATUS = :status
    ]]>
    </sql-query>


SELECT to_char(COMPLETE_DUE_DATE, 'mm/dd/yyyy hh24:mi:ss') FROM LOS_WF_TASK WHERE COMPLETE_DUE_DATE IS NOT NULL ; 

SELECT * FROM LOS_WF_TASK WHERE PICKUP_DUE_UNIT IS NOT NULL ;
SELECT * FROM LOS_WF_TASK WHERE PICKUP_DUE IS NOT NULL ;
SELECT * FROM LOS_WF_TASK WHERE COMPLETE_DUE_TIME IS NOT NULL ;

SELECT * FROM LOS_USER WHERE SURNAME LIKE '%B%'; 

SELECT CREATE_DATE FROM LOS_WF_TASK ;

SELECT COMPLETE_DUE_DATE FROM LOS_WF_TASK WHERE COMPLETE_DUE_DATE IS NOT NULL ;

select * from los_wf_status_sla
			where  SLA_SEQ is not null ;

-- BA rlos 03

-- TEST SLA create new app
The application with Reference No : 12498CC23000036
has been submitted to : BRANCH CHECKER
12/06/2023 16:06:30

SELECT * FROM LOS_CA WHERE APP_REF_NO = '12498CC23000036'; --20230612003377
12498CC23000037 

SELECT to_char(COMPLETE_DUE_DATE, 'mm/dd/yyyy hh24:mi:ss') FROM LOS_WF_TASK WHERE COMPLETE_DUE_DATE IS NOT NULL ; 

SELECT * FROM LOS_WF_TASK WHERE   APP_ID = '20230612003377';

SELECT to_char(COMPLETE_DUE_DATE, 'mm/dd/yyyy hh24:mi:ss') FROM LOS_WF_TASK WHERE COMPLETE_DUE_DATE IS NOT NULL AND  APP_ID = '20230612003377';
06/13/2023 13:11:03     
NOW: 12h21p
-- 12498CC23000036 	DO VAN THUONG  	008088000033 	12/06/2023 16:00:54	12/06/2023 16:06:28	At Branch Checker  	Rlos17 	- 	- 	Process


        select * from los_wf_status_sla
			where 
            app_type ='CC' and 
            app_status ='ABRCK' and 
            SLA_SEQ is not null ;
            
            SELECT * FROM LOS_CA WHERE APP_REF_NO = '12498CC23000036';
            SELECT * FROM LOS_WF_TASK WHERE   APP_ID = '20230612003377';
-- TEST DONE - oki 50 minutes
DRAFT