SELECT CMS_COLLATERAL_ID
FROM CMS_VALUATION
WHERE valuation_date LIKE '%JAN-23%';
SELECT *
FROM cms_valuation
WHERE VALUATION_DATE IS NOT NULL
ORDER BY valuation_date DESC;
--20-OCT-22
SELECT CMS_COLLATERAL_ID
FROM CMS_VALUATION
WHERE valuation_date LIKE '%OCT-22%';
--count COLL
SELECT COUNT(1)
FROM CMS_SECURITY S,
	CMS_SECURITY_PARAMETER P,
	TRANSACTION T
WHERE S.SECURITY_LOCATION = P.COUNTRY_ISO_CODE
	AND S.SECURITY_SUB_TYPE_ID = P.SECURITY_SUB_TYPE_ID
	AND S.CMS_COLLATERAL_ID = T.REFERENCE_ID
	AND T.TRANSACTION_TYPE = 'COL'
	AND T.STATUS NOT IN ('PENDING_UPDATE', 'PENDING_RETRY')
	AND P.STATUS = 'ACTIVE'
	AND P.THRESHOLD_PERCENT IS NOT NULL
	AND P.VALUATION_FREQUENCY IS NOT NULL
	AND nvl(P.VALUATION_FREQUENCY, 0) > 0
	AND P.VALUATION_FREQUENCY_UNIT IS NOT NULL
	AND P.VALUATION_FREQUENCY_UNIT <> ' '
	AND (
		S.SECURITY_SUB_TYPE_ID NOT IN (
			'AB100',
			'AB103',
			'AB106',
			'AB107',
			'AB108',
			'CL001'
		)
		AND S.SECURITY_SUB_TYPE_ID NOT LIKE 'DC%'
	)
	AND (
		(NEXT_REMARGIN_DATE IS NULL)
		OR (
			NEXT_REMARGIN_DATE IS NOT NULL
			AND trunc(S.NEXT_REMARGIN_DATE) <= trunc(sysdate)
		)
	)
	AND (
		(VALUATED_DATE IS NULL)
		OR (
			VALUATED_DATE IS NOT NULL
			AND trunc(VALUATED_DATE) < trunc(sysdate)
		)
	)
	AND S.STATUS = 'ACTIVE';
-- PICK COL
SELECT S.CMS_COLLATERAL_ID,
	VALUATED_DATE,
	S.SCI_SECURITY_DTL_ID,
	S.SCI_SECURITY_TYPE_VALUE,
	S.SCI_SECURITY_SUBTYPE_VALUE,
	S.SECURITY_LOCATION,
	S.SCI_SECURITY_TYPE_VALUE
FROM CMS_SECURITY S,
	CMS_SECURITY_PARAMETER P,
	TRANSACTION T
WHERE S.SECURITY_LOCATION = P.COUNTRY_ISO_CODE
	AND S.SECURITY_SUB_TYPE_ID = P.SECURITY_SUB_TYPE_ID
	AND S.CMS_COLLATERAL_ID = T.REFERENCE_ID
	AND T.TRANSACTION_TYPE = 'COL'
	AND T.STATUS NOT IN ('PENDING_UPDATE', 'PENDING_RETRY')
	AND P.STATUS = 'ACTIVE'
	AND P.THRESHOLD_PERCENT IS NOT NULL
	AND P.VALUATION_FREQUENCY IS NOT NULL
	AND nvl(P.VALUATION_FREQUENCY, 0) > 0
	AND P.VALUATION_FREQUENCY_UNIT IS NOT NULL
	AND P.VALUATION_FREQUENCY_UNIT <> ' '
	AND (
		S.SECURITY_SUB_TYPE_ID NOT IN (
			'AB100',
			'AB103',
			'AB106',
			'AB107',
			'AB108',
			'CL001'
		)
		AND S.SECURITY_SUB_TYPE_ID NOT LIKE 'DC%'
	)
	AND (
		(NEXT_REMARGIN_DATE IS NULL)
		OR (
			NEXT_REMARGIN_DATE IS NOT NULL
			AND trunc(S.NEXT_REMARGIN_DATE) <= trunc(sysdate)
		)
	)
	AND (
		(VALUATED_DATE IS NULL)
		OR (
			VALUATED_DATE IS NOT NULL
			AND trunc(VALUATED_DATE) < trunc(sysdate)
		)
	)
	AND S.STATUS = 'ACTIVE'
FETCH FIRST 200 ROWS ONLY;
-- SEE COL ID re CAL 
SELECT CMS_COLLATERAL_ID
FROM CMS_VALUATION
WHERE valuation_date like '%JAN-23%';
-- void updateValuatedFlagForCollateral(long collateralId)
UPDATE cms_security
SET valuated_date = systimestamp
WHERE cms_collateral_id = ?
WHERE S.SECURITY_LOCATION = P.COUNTRY_ISO_CODE
	AND S.SECURITY_SUB_TYPE_ID = P.SECURITY_SUB_TYPE_ID
	AND S.CMS_COLLATERAL_ID = T.REFERENCE_ID
	AND T.TRANSACTION_TYPE = 'COL'
	AND T.STATUS NOT IN ('PENDING_UPDATE', 'PENDING_RETRY')
	AND P.STATUS = 'ACTIVE'
	AND P.THRESHOLD_PERCENT IS NOT NULL
	AND P.VALUATION_FREQUENCY IS NOT NULL
	AND nvl(P.VALUATION_FREQUENCY, 0) > 0
	AND P.VALUATION_FREQUENCY_UNIT IS NOT NULL
	AND P.VALUATION_FREQUENCY_UNIT <> ' '
	AND (
		S.SECURITY_SUB_TYPE_ID NOT IN (
			'AB100',
			'AB103',
			'AB106',
			'AB107',
			'AB108',
			'CL001'
		)
		AND S.SECURITY_SUB_TYPE_ID NOT LIKE 'DC%'
	)
	AND (
		(NEXT_REMARGIN_DATE IS NULL)
		OR (
			NEXT_REMARGIN_DATE IS NOT NULL
			AND trunc(S.NEXT_REMARGIN_DATE) <= trunc(sysdate)
		)
	)
	AND (
		(VALUATED_DATE IS NULL)
		OR (
			VALUATED_DATE IS NOT NULL
			AND trunc(VALUATED_DATE) < trunc(sysdate)
		)
	)
	AND S.STATUS = 'ACTIVE'
FETCH FIRST 200 ROWS ONLY;
-- SEE COL ID re CAL
SELECT CMS_COLLATERAL_ID
FROM CMS_VALUATION
WHERE valuation_date like '%JAN-23%';
-- void updateValuatedFlagForCollateral(long collateralId)
UPDATE cms_security
SET valuated_date = systimestamp
WHERE cms_collateral_id = ?
SELECT CMS_COLLATERAL_ID,
	valuated_date
FROM CMS_SECURITY
ORDER BY VALUATED_DATE DESC;
-- SIT not OKI
SELECT CMS_COLLATERAL_ID,
	valuated_date
FROM CMS_SECURITY
WHERE valuated_date IS NOT NULL
ORDER BY VALUATED_DATE DESC;
select *
from CMS_BATCH_JOB
where class_name like '%ValuationMain%'
order by start_date desc;
SELECT *
FROM cms_valuation
WHERE VALUATION_DATE IS NOT NULL
ORDER BY valuation_date DESC;


-- 2/6/ RUN TIME : NULL POINTER EXP ROLLBACK:
SELECT sec.cms_collateral_id,
	SEC.CMV_CURRENCY,
	SEC.CMV,
	SEC.SCI_SECURITY_CURRENCY,
	PR.POSTCODE,
	PR.STATE,
	PR.DISTRICT,
	PR.MUKIM,
	PR.LAND_AREA,
	PR.LAND_AREA_UOM,
	PR.BUILTUP_AREA,
	PR.BUILTUP_AREA_UOM,
	PR.SALE_PURCHASE_VALUE,
	PR.SALE_PURCHASE_DATE,
	PR.PROPERTY_TYPE,
	PR.PROPERTY_COMPLETION_STATUS,
	PR.CATEGORY_OF_LAND_USE
FROM CMS_SECURITY SEC,
	CMS_PROPERTY PR
WHERE SEC.CMS_COLLATERAL_ID IN (20200614000030066, 20200615000030068)
	AND SEC.CMS_COLLATERAL_ID = PR.CMS_COLLATERAL_ID;

--  06 Feb 2023 10:58:44,555:com.integrosys.cms.app.collateral.bus.valuation.dao.PropertyValuationOracleDAO -  MQ SQL REVALUATION : SELECT SOURCE_TYPE, VALUATION_DATE, VALUATION_CURRENCY, CMV, FSV, VALUER, HAIRCUT, REVAL_FREQ, REVAL_FREQ_UNIT  FROM ( SELECT SOURCE_TYPE, VALUATION_DATE, VALUATION_CURRENCY, CMV, FSV, VALUER, HAIRCUT, REVAL_FREQ, REVAL_FREQ_UNIT , row_number() over(ORDER BY VALUATION_DATE DESC, VALUATION_ID DESC) ROWNUM1  FROM CMS_VALUATION WHERE SOURCE_TYPE = ? AND CMS_COLLATERAL_ID = ?  UNION ALL SELECT SOURCE_TYPE, VALUATION_DATE, VALUATION_CURRENCY, CMV, FSV, VALUER, HAIRCUT, REVAL_FREQ, REVAL_FREQ_UNIT , row_number() over(ORDER BY VALUATION_DATE DESC, LOS_VALUATION_ID DESC, VALUATION_ID DESC) ROWNUM1  FROM CMS_VALUATION WHERE SOURCE_TYPE = ? AND CMS_COLLATERAL_ID = ?  UNION ALL SELECT SOURCE_TYPE, VALUATION_DATE, VALUATION_CURRENCY, CMV, FSV, VALUER, HAIRCUT, REVAL_FREQ, REVAL_FREQ_UNIT , row_number() over(ORDER BY VALUATION_DATE DESC, VALUATION_ID DESC) ROWNUM1  FROM CMS_VALUATION WHERE SOURCE_TYPE = ? AND CMS_COLLATERAL_ID = ?  ) WHERE ROWNUM1 = 1
-- 218813 [[ACTIVE] ExecuteThread: '6' for queue: 'weblogic.kernel.Default (self-tuning)'] WARN com.integrosys.cms.batch.valuation.ValuationMain - [UnknownError]   Security SubType [PT704]        Collateral ID [20200615000030068]       Security ID [null]      [Unexpected Error!! Please Trace!!]     [error encountered includes: Runtime Exception Encountered!; nested exception is java.lang.NullPointerException]
SELECT SOURCE_TYPE,
	VALUATION_DATE,
	VALUATION_CURRENCY,
	CMV,
	FSV,
	VALUER,
	HAIRCUT,
	REVAL_FREQ,
	REVAL_FREQ_UNIT
FROM (
		SELECT SOURCE_TYPE,
			VALUATION_DATE,
			VALUATION_CURRENCY,
			CMV,
			FSV,
			VALUER,
			HAIRCUT,
			REVAL_FREQ,
			REVAL_FREQ_UNIT,
			row_number() over(
				ORDER BY VALUATION_DATE DESC,
					VALUATION_ID DESC
			) ROWNUM1
		FROM CMS_VALUATION
		WHERE 
			-- SOURCE_TYPE = ? AND 
			CMS_COLLATERAL_ID = 20200615000030068
		UNION ALL
		SELECT SOURCE_TYPE,
			VALUATION_DATE,
			VALUATION_CURRENCY,
			CMV,
			FSV,
			VALUER,
			HAIRCUT,
			REVAL_FREQ,
			REVAL_FREQ_UNIT,
			row_number() over(
				ORDER BY VALUATION_DATE DESC,
					LOS_VALUATION_ID DESC,
					VALUATION_ID DESC
			) ROWNUM1
		FROM CMS_VALUATION
		WHERE 
			-- SOURCE_TYPE = ? AND 
			CMS_COLLATERAL_ID = 20200615000030068
		UNION ALL
		SELECT SOURCE_TYPE,
			VALUATION_DATE,
			VALUATION_CURRENCY,
			CMV,
			FSV,
			VALUER,
			HAIRCUT,
			REVAL_FREQ,
			REVAL_FREQ_UNIT,
			row_number() over(
				ORDER BY VALUATION_DATE DESC,
					VALUATION_ID DESC
			) ROWNUM1
		FROM CMS_VALUATION
		WHERE 
			-- SOURCE_TYPE = ? AND 
			CMS_COLLATERAL_ID = 20200615000030068
	)
WHERE ROWNUM1 = 1;

-- S	15-JUN-20	VND	111111		aa	33	2	3
-- S	15-JUN-20	VND	111111		aa	33	2	3
-- S	15-JUN-20	VND	111111		aa	33	2	3


-- XÁC ĐỊNH NGUYÊN NHÂN DO TRƯỜNG FSV BỊ NULL KHI XỬ LÝ TRONG CLASS: D:\VTBCLIMS\src\com\integrosys\cms\app\collateral\bus\valuation\dao\GenericValuationOracleDAO.java

SELECT * FROM CMS_VALUATION WHERE FSV IS NULL ; 
SELECT COUNT(*) FROM cms_valuation ;

--FSV NULL 
-- 20200614001442746	VND	02-JUN-20	Quoc Toan	111111	
-- 20200615001442752	VND	15-JUN-20	aa	111111	
-- 20200614001442748	VND	29-MAY-20	Quoc Toan Quoc Toan Quoc Toan Quoc Toan	111111	
-- 20200614001442750	VND	01-MAY-20	aa22	100000000	
-- 20200612001442744	VND	12-JUN-20	Quoc Toan	111111	
-- 20210819001442758	VND	19-AUG-21	ThangPC	1500000000	
-- 20210820001442760	VND	06-AUG-21	ThangPC	1500000000	

UPDATE CMS_VALUATION SET FSV = 1750000000 WHERE VALUATION_ID IN (20200614001442746,20200615001442752,20200614001442748,20200614001442750,20200612001442744,20210819001442758,20210820001442760);
UPDATE CMS_VALUATION SET FSV = NULL WHERE VALUATION_ID IN (20200614001442746,20200615001442752,20200614001442748,20200614001442750,20200612001442744,20210819001442758,20210820001442760);
COMMIT ;

SELECT * FROM CMS_VALUATION WHERE VALUATION_ID IN (20200614001442746,20200615001442752,20200614001442748,20200614001442750,20200612001442744,20210819001442758,20210820001442760);


SELECT * FROM CMS_VALUATION WHERE FSV IS NULL ORDER BY VALUATION_DATE ;
SELECT * FROM CMS_SECURITY WHERE CMS_COLLATERAL_ID IN (SELECT CMS_COLLATERAL_ID FROM CMS_VALUATION WHERE FSV IS NULL) AND STATUS='ACTIVE' ORDER BY VALUATED_DATE DESC ;

SELECT COUNT(1) FROM CMS_VALUATION WHERE FSV IS NULL ;
SELECT COUNT(1) FROM CMS_SECURITY WHERE CMS_COLLATERAL_ID IN (SELECT CMS_COLLATERAL_ID FROM CMS_VALUATION WHERE FSV IS NULL) AND STATUS='ACTIVE';



-- REPICK COL  GROUP BY

SELECT S.CMS_COLLATERAL_ID,
	VALUATED_DATE,
	S.SCI_SECURITY_DTL_ID,
	S.SCI_SECURITY_TYPE_VALUE,
	S.SCI_SECURITY_SUBTYPE_VALUE,
	S.SECURITY_LOCATION,
	S.SCI_SECURITY_TYPE_VALUE
FROM CMS_SECURITY S,
	CMS_SECURITY_PARAMETER P,
	TRANSACTION T
WHERE S.SECURITY_LOCATION = P.COUNTRY_ISO_CODE
	AND S.SECURITY_SUB_TYPE_ID = P.SECURITY_SUB_TYPE_ID
	AND S.CMS_COLLATERAL_ID = T.REFERENCE_ID
	AND T.TRANSACTION_TYPE = 'COL'
	AND T.STATUS NOT IN ('PENDING_UPDATE', 'PENDING_RETRY')
	AND P.STATUS = 'ACTIVE'
	AND P.THRESHOLD_PERCENT IS NOT NULL
	AND P.VALUATION_FREQUENCY IS NOT NULL
	AND nvl(P.VALUATION_FREQUENCY, 0) > 0
	AND P.VALUATION_FREQUENCY_UNIT IS NOT NULL
	AND P.VALUATION_FREQUENCY_UNIT <> ' '
	AND (
		S.SECURITY_SUB_TYPE_ID NOT IN (
			'AB100',
			'AB103',
			'AB106',
			'AB107',
			'AB108',
			'CL001'
		)
		AND S.SECURITY_SUB_TYPE_ID LIKE '%GT%'
	)
	AND (
		(NEXT_REMARGIN_DATE IS NULL)
		OR (
			NEXT_REMARGIN_DATE IS NOT NULL
			AND trunc(S.NEXT_REMARGIN_DATE) <= trunc(sysdate)
		)
	)
	AND (
		(VALUATED_DATE IS NULL)
		OR (
			VALUATED_DATE IS NOT NULL
			AND trunc(VALUATED_DATE) < trunc(sysdate)
		)
	)
	AND S.STATUS = 'ACTIVE'
FETCH FIRST 200 ROWS ONLY;

--CMS_COL ID   TYPE GT
--20160204000021621
--20160322000022064
--20160106000021550
--20160115000021594

SELECT * FROM CNS_SECURITY WHERE CMS_COLLATERAL_ID = 20160204000021621 ;
SELECT VALUATION_ID , FSV FROM CMS_VALUATION WHERE cms_collateral_id IN (20160204000021621) ;
--20161028000388827	6500000
UPDATE CMS_VALUATION SET FSV = NULL WHERE VALUATION_ID IN (SELECT VALUATION_ID FROM CMS_VALUATION WHERE cms_collateral_id IN (20160204000021621));
COMMIT ;

SELECT cms_collateral_id, security_sub_type_id, valuated_date
FROM CMS_SECURITY
WHERE valuated_date IS NOT NULL
AND security_sub_type_id LIKE '%GT%'
ORDER BY VALUATED_DATE DESC;
-- batch run success ??

-- PT not OKI , GT is OKI,
-- PT not OKI , GT is OKI, 
--ASSET BASED AB, DEPOSIT ?? cash Deposit - CS200 CS202 , GUARANTEE (GT), MARKETABLE SECURITY -MS , PT - property
SELECT DISTINCT(security_sub_type_id) FROM CMS_SECURITY ;
MS611,MS602,PT701,PT706,AB111,GT402,OT900,MS600,MS605,AB101,AB103,AB100,PT703,MS606,GT400,GT408,DC308,MS607,MS610,GT405,PT707,CS200,AB109,AB110,GT406,MS601,CS202,AB102,PT704,PT700,GT409,PT709

-- PICK MS

SELECT S.CMS_COLLATERAL_ID,
	VALUATED_DATE,
	S.SCI_SECURITY_DTL_ID,
	S.SCI_SECURITY_TYPE_VALUE,
	S.SCI_SECURITY_SUBTYPE_VALUE,
	S.SECURITY_LOCATION,
	S.SCI_SECURITY_TYPE_VALUE
FROM CMS_SECURITY S,
	CMS_SECURITY_PARAMETER P,
	TRANSACTION T
WHERE S.SECURITY_LOCATION = P.COUNTRY_ISO_CODE
	AND S.SECURITY_SUB_TYPE_ID = P.SECURITY_SUB_TYPE_ID
	AND S.CMS_COLLATERAL_ID = T.REFERENCE_ID
	AND T.TRANSACTION_TYPE = 'COL'
	AND T.STATUS NOT IN ('PENDING_UPDATE', 'PENDING_RETRY')
	AND P.STATUS = 'ACTIVE'
	AND P.THRESHOLD_PERCENT IS NOT NULL
	AND P.VALUATION_FREQUENCY IS NOT NULL
	AND nvl(P.VALUATION_FREQUENCY, 0) > 0
	AND P.VALUATION_FREQUENCY_UNIT IS NOT NULL
	AND P.VALUATION_FREQUENCY_UNIT <> ' '
	AND (
		S.SECURITY_SUB_TYPE_ID NOT IN (
			'AB100',
			'AB103',
			'AB106',
			'AB107',
			'AB108',
			'CL001'
		)
		AND S.SECURITY_SUB_TYPE_ID LIKE '%MS%'
	)
	AND (
		(NEXT_REMARGIN_DATE IS NULL)
		OR (
			NEXT_REMARGIN_DATE IS NOT NULL
			AND trunc(S.NEXT_REMARGIN_DATE) <= trunc(sysdate)
		)
	)
	AND (
		(VALUATED_DATE IS NULL)
		OR (
			VALUATED_DATE IS NOT NULL
			AND trunc(VALUATED_DATE) < trunc(sysdate)
		)
	)
	AND S.STATUS = 'ACTIVE'
FETCH FIRST 200 ROWS ONLY;

--20160303000021733	25-APR-19		MS	MS600	VN	MS
--20160307000021827	25-APR-19		MS	MS600	VN	MS
--20160311000021957	25-APR-19		MS	MS600	VN	MS
--20160628000025061	25-APR-19		MS	MS611	VN	MS
--20160414000022652	25-APR-19	844	MS	MS611	VN	MS
	-- CHANGE FSV
SELECT VALUATION_ID , FSV FROM CMS_VALUATION WHERE cms_collateral_id IN (20160303000021733,20160307000021827, 20160311000021957,20160414000022652) ; -- FSV 714840 0 1000000000
--20161028000388827	6500000
UPDATE CMS_VALUATION SET FSV = NULL WHERE VALUATION_ID IN (SELECT VALUATION_ID FROM CMS_VALUATION WHERE cms_collateral_id IN (20160303000021733,20160307000021827, 20160311000021957,20160414000022652));
COMMIT ;

--CHECk UPDATE
SELECT cms_collateral_id, security_sub_type_id, valuated_date
FROM CMS_SECURITY
WHERE valuated_date IS NOT NULL
AND security_sub_type_id LIKE '%MS%'
ORDER BY VALUATED_DATE DESC;

--20161104000028064	MS607	06-FEB-23
--20170220000028676	MS605	06-FEB-23
--20161118000028095	MS601	06-FEB-23
--20161118000028097	MS600	06-FEB-23
--20170714000029156	MS610	06-FEB-23
--20170712000029149	MS602	06-FEB-23
--20170801000029176	MS611	06-FEB-23
--20170713000029151	MS610	06-FEB-23
--20170512000029059	MS611	06-FEB-23
--20170831000029192	MS602	06-FEB-23
	--MS is OKI

-- PICK DEPOSIT CS

SELECT S.CMS_COLLATERAL_ID,
	VALUATED_DATE,
	S.SCI_SECURITY_DTL_ID,
	S.SCI_SECURITY_TYPE_VALUE,
	S.SCI_SECURITY_SUBTYPE_VALUE,
	S.SECURITY_LOCATION,
	S.SCI_SECURITY_TYPE_VALUE
FROM CMS_SECURITY S,
	CMS_SECURITY_PARAMETER P,
	TRANSACTION T
WHERE S.SECURITY_LOCATION = P.COUNTRY_ISO_CODE
	AND S.SECURITY_SUB_TYPE_ID = P.SECURITY_SUB_TYPE_ID
	AND S.CMS_COLLATERAL_ID = T.REFERENCE_ID
	AND T.TRANSACTION_TYPE = 'COL'
	AND T.STATUS NOT IN ('PENDING_UPDATE', 'PENDING_RETRY')
	AND P.STATUS = 'ACTIVE'
	AND P.THRESHOLD_PERCENT IS NOT NULL
	AND P.VALUATION_FREQUENCY IS NOT NULL
	AND nvl(P.VALUATION_FREQUENCY, 0) > 0
	AND P.VALUATION_FREQUENCY_UNIT IS NOT NULL
	AND P.VALUATION_FREQUENCY_UNIT <> ' '
	AND (
		S.SECURITY_SUB_TYPE_ID NOT IN (
			'AB100',
			'AB103',
			'AB106',
			'AB107',
			'AB108',
			'CL001'
		)
		AND S.SECURITY_SUB_TYPE_ID LIKE '%CS%'
	)
	AND (
		(NEXT_REMARGIN_DATE IS NULL)
		OR (
			NEXT_REMARGIN_DATE IS NOT NULL
			AND trunc(S.NEXT_REMARGIN_DATE) <= trunc(sysdate)
		)
	)
	AND (
		(VALUATED_DATE IS NULL)
		OR (
			VALUATED_DATE IS NOT NULL
			AND trunc(VALUATED_DATE) < trunc(sysdate)
		)
	)
	AND S.STATUS = 'ACTIVE'
FETCH FIRST 200 ROWS ONLY;

-- COL ID : 
--20160318000022054   CS200
--20151218000021397
--20151222000021441
--20160401000022532   CS202
--20160811000027183
--20160811000027185

	-- CHANGE FSV
SELECT * FROM CMS_VALUATION WHERE cms_collateral_id IN (20160318000022054,20151218000021397,20151222000021441,20160401000022532,20160811000027183,20160811000027185) ;
SELECT VALUATION_ID , FSV FROM CMS_VALUATION WHERE cms_collateral_id IN (20160318000022054,20151218000021397,20151222000021441,20160401000022532,20160811000027183,20160811000027185) ;
--20161227000471330	7000000
--20161227000471338	8.4
--20160318000376840	179.49
--20160322000376852	75.97
--20160318000376844	75.97
--20161227000471360	854.7
--20161227000471377	732000000
--20160811000386887	799100000
--20160811000386891	494100000
--20161227000471488	549000000
--20160811000386886	1037000000
--20160811000386894	549225882.76
--20160811000386890	549000000
--20161227000471489	610250980.84

UPDATE CMS_VALUATION SET FSV = NULL WHERE VALUATION_ID IN (SELECT VALUATION_ID FROM CMS_VALUATION WHERE cms_collateral_id IN (20160318000022054,20151218000021397,20151222000021441,20160401000022532,20160811000027183,20160811000027185));
COMMIT ;

--CHECk UPDATE
SELECT cms_collateral_id, security_sub_type_id, valuated_date
FROM CMS_SECURITY
WHERE valuated_date IS NOT NULL
AND security_sub_type_id LIKE '%CS%'
ORDER BY VALUATED_DATE DESC;

SELECT VALUATED_DATE FROM CMS_SECURITY WHERE cms_collateral_id = 20151218000021397 ;
--06-FEB-


--see all type PT
SELECT * FROM CMS_VALUATION 
WHERE cms_collateral_id IN ( SELECT CMS_COLLATERAL_ID FROM CMS_SECURITY WHERE SECURITY_SUB_TYPE_ID LIKE 'PT%' AND STATUS = 'ACTIVE')
AND FSV IS NULL ; 

SELECT * FROM CMS_VALUATION 
WHERE cms_collateral_id IN ( SELECT CMS_COLLATERAL_ID FROM CMS_SECURITY WHERE SECURITY_SUB_TYPE_ID LIKE 'PT%' AND STATUS = 'ACTIVE')
AND FSV IS NULL ; 
--CMS col : 20200615000030068
SELECT VALUATED_DATE FROM CMS_SECURITY WHERE cms_collateral_id = 20200615000030068 ;

SELECT * FROM CMS_VALUATION WHERE VALUATION_DATE IS NOT NULL ORDER BY VALUATION_DATE DESC ;

SELECT cms_collateral_id, security_sub_type_id, VALUATED_DATE FROM CMS_SECURItY WHERE security_sub_type_id LIKE 'PT%' AND VALUATED_DATE IS NOT NULL ORDER BY VALUATED_DATE DESC ;