CMS_SECURITY
CMS_STAGE_SECURITY
CMS_LIMIT_SECURITY_MAP
CMS_STAGE_SECURITY_MAP

--18/10/22
SELECT * FROM CMS_SECURITY WHERE LOS_SECURITY_DTL_ID LIKE '%202206060022159950%';
SELECT * FROM CMS_STAGE_SECURITY WHERE LOS_SECURITY_DTL_ID LIKE '%202206060022159950%';


SELECT * FROM CMS_LIMIT_SECURITY_MAP WHERE CMS_COLLATERAL_ID IN (SELECT CMS_COLLATERAL_ID FROM CMS_SECURITY WHERE LOS_SECURITY_DTL_ID LIKE '%202206060022159950%') ;
SELECT * FROM CMS_STAGE_LIMIT_SECURITY_MAP WHERE CMS_COLLATERAL_ID IN (SELECT CMS_COLLATERAL_ID FROM CMS_STAGE_SECURITY WHERE LOS_SECURITY_DTL_ID LIKE '%202206060022159950%') ;


SELECT * FROM CMS_LIMIT_CHARGE_MAP WHERE CMS_COLLATERAL_ID IN (SELECT CMS_COLLATERAL_ID FROM CMS_SECURITY WHERE LOS_SECURITY_DTL_ID LIKE '%202206060022159950%') ;
SELECT * FROM CMS_STAGE_LIMIT_CHARGE_MAP WHERE CMS_COLLATERAL_ID IN (SELECT CMS_COLLATERAL_ID FROM CMS_STAGE_SECURITY WHERE LOS_SECURITY_DTL_ID LIKE '%202206060022159950%') ;

--19/10/22
SELECT * FROM CMS_SECURITY WHERE CMS_COLLATERAL_ID LIKE '%20220323019759604%';
SELECT * FROM CMS_STAGE_SECURITY WHERE CMS_COLLATERAL_ID LIKE '%20220323019759604%';

SELECT * FROM CMS_SECURITY WHERE SECURITY_NO LIKE '%PT20140903725907%';

SELECT * FROM CMS_LIMIT_SECURITY_MAP WHERE CMS_COLLATERAL_ID LIKE '%20220323019759604%';
SELECT * FROM CMS_STAGE_LIMIT_SECURITY_MAP WHERE CMS_COLLATERAL_ID LIKE '%20220323019759604%';

SELECT * FROM CMS_LIMIT_CHARGE_MAP WHERE CMS_COLLATERAL_ID LIKE '%20220323019759604%' ;
SELECT * FROM CMS_STAGE_LIMIT_CHARGE_MAP WHERE CMS_COLLATERAL_ID LIKE '%20220323019759604%' ;

SELECT * FROM CMS_PROPERTY WHERE  CMS_COLLATERAL_ID LIKE '%20220323019759604%' ;
SELECT * FROM CMS_STAGE_PROPERTY WHERE CMS_COLLATERAL_ID LIKE '%20220323019759604%';

SELECT * FROM CMS_CA_COLLATERAL_MAP WHERE SECURITY_NO IN ('PT20140903725907', 'PT202203230021586339' );

20220323019759604
--20/10
SELECT * FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00610/05021749%' ;
SELECT existing_ind,cc.* FROM SML_CA_COLLATERAL cc WHERE CA_ID IN (SELECT ID FROM SML_CA WHERE CA_NUMBER LIKE '%CAR/22/9002/00610/05021749%'  );
SELECT * FROM CODE_VALUE WHERE CODE LIKE '%VARIATION_AA%';

