
--change CIF in CLIMS   SCI_PLEDGOR_DTL.PLG_LE_ID is CIF
	SELECT dtl.CMS_PLEDGOR_DTL_ID, dtl.PLG_LE_ID 
FROM  SCI_PLEDGOR_DTL dtl, SCI_SEC_PLDGR_MAP, CMS_SECURITY
WHERE dtl.CMS_PLEDGOR_DTL_ID = SCI_SEC_PLDGR_MAP.CMS_PLEDGOR_DTL_ID 
	AND SCI_SEC_PLDGR_MAP.CMS_COLLATERAL_ID = CMS_SECURITY.CMS_COLLATERAL_ID 
    AND cms_security.CMS_COLLATERAL_ID IN ( SELECT CMS_COLLATERAL_ID FROM CMS_CA_COLLATERAL_MAP WHERE LOS_BCA_REF_NUM = 'CAR/13/0001/00106/0000802-004' ) ;

        -- 20170331000057360	3013861030
    UPDATE SCI_PLEDGOR_DTL SET PLG_LE_ID = -1234566 WHERE CMS_PLEDGOR_DTL_ID = 20170331000057360 ;
    COMMIT;

    -- ngay 9192022
SELECT * FROM SCI_LSP_LMT_PROFILE WHERE 

SELECT * FROM SCI_PLEDGOR_DTL WHERE CMS_PLEDGOR_DTL_ID = 20170331000057360 ;

SELECT cms_collateral_id FROM sci_sec_pldgr_map WHERE CMS_PLEDGOR_DTL_ID = 20170331000057360 ; -- 20170331000057360

SELECT * FROM cms_limit_security_map WHERE cms_collateral_id IN (SELECT cms_collateral_id FROM sci_sec_pldgr_map WHERE CMS_PLEDGOR_DTL_ID = 20170331000057360)  ;

SELECT * FROM sci_lsp_lmt_profile WHERE cms_lsp_lmt_profile_id IN  (
SELECT cms_lsp_lmt_profile_id FROM cms_limit_security_map WHERE cms_collateral_id IN (SELECT cms_collateral_id FROM sci_sec_pldgr_map WHERE CMS_PLEDGOR_DTL_ID = 20170331000057360)) 
-- RESSULT
-- CMS_LSP_LMT_PROFILE_ID  LLP_LE_ID         
-- 20170331000011048		3013861030	1	31-MAR-18
-- 20181228000011284		3013861030	1	19-FEB-20

VAR new CAR

query CLIMS 
-- CAR/17/0001/00122/00008522
 
 SELECT * FROM sci_lsp_lmt_profile WHERE CMS_LSP_LMT_PROFILE_ID IN ( SELECT CMS_LSP_LMT_PROFILE_ID FROM CMS_CA_COLLATERAL_MAP WHERE LOS_BCA_REF_NUM = 'CAR/15/0001/00122/00005087' ); 
-- PROFILE_ID = 20151105000008293      LLP_ID = 994

	SELECT dtl.CMS_PLEDGOR_DTL_ID, dtl.PLG_LE_ID 
FROM  SCI_PLEDGOR_DTL dtl, SCI_SEC_PLDGR_MAP, CMS_SECURITY
WHERE dtl.CMS_PLEDGOR_DTL_ID = SCI_SEC_PLDGR_MAP.CMS_PLEDGOR_DTL_ID 
	AND SCI_SEC_PLDGR_MAP.CMS_COLLATERAL_ID = CMS_SECURITY.CMS_COLLATERAL_ID 
    AND cms_security.CMS_COLLATERAL_ID IN ( SELECT CMS_COLLATERAL_ID FROM CMS_CA_COLLATERAL_MAP WHERE LOS_BCA_REF_NUM = 'CAR/15/0001/00122/00005087' ) ;
-- 20140228000021266	0000000002700000013
   UPDATE SCI_PLEDGOR_DTL SET PLG_LE_ID = -1234566 WHERE CMS_PLEDGOR_DTL_ID = 20140228000021266 ;
    COMMIT;

    UPDATE sci_lsp_lmt_profile SET LLP_LE_ID = -34455667 WHERE CMS_LSP_LMT_PROFILE_ID = 20151105000008293 ;
    COMMIT; 

-- CMS_FAC_RELATIONSHIP
UPDATE


 CAR/16/0001/00122/90007992-001 
  CAR/18/0001/00122/00008956 

  1 CAR/15/0001/00122/00005087 H? so tín d?ng thông thu?ng - SXKD   [2015110500010656]  	 
2 CAR/15/0001/00122/00005095 H? so tín d?ng thông thu?ng - SXKD   [2015110500010657]  	 
3 CAR/15/0001/00122/00005093 H? so tín d?ng thông thu?ng - SXKD   [2015110600010660]  	 
4 CAR/15/0001/00122/00004882 H? so tín d?ng thông thu?ng - SXKD   [2015102800010614]  	 
5 CAR/15/0001/00122/00005185 H? so tín d?ng thông thu?ng - SXKD   [2015111100010767]  	 
6 CAR/15/0001/00122/00005196 H? so tín d?ng thông thu?ng - SXKD   [2015111200010799]  	 
7 CAR/15/0001/00122/00005299 H? so tín d?ng thông thu?ng - SXKD   [2015111900010885]  	 
8 CAR/15/0001/00122/00004968 H? so tín d?ng thông thu?ng - SXKD   [2015101500010572]  	 
9 CAR/15/0001/00122/00005323 H? so tín d?ng thông thu?ng - SXKD   [2015112300010912]  	 
10 CAR/16/0001/00122/00006544 H? so tín d?ng thông thu?ng - SXKD   [2016051900012637, 2016051900012638]  	 
11 CAR/16/0001/00122/00007022 H? so tín d?ng thông thu?ng - SXKD   [2016062700013077]  	 
12 CAR/15/0001/00122/00004993 H? so tín d?ng thông thu?ng - SXKD   [2015102200010586]  	 
13 CAR/15/0001/00122/00004983 H? so tín d?ng thông thu?ng - SXKD   [2015102100010577]  	 
14 CAR/15/0001/00122/00005012 H? so tín d?ng thông thu?ng - SXKD   [2015102600010604]  	 
15 CAR/15/0001/00122/00005073 H? so tín d?ng thông thu?ng - SXKD   []  	 
16 CAR/15/0001/00122/00005085 H? so tín d?ng thông thu?ng - SXKD   [2015110500010655]  	 
17 CAR/15/0001/00122/00005126 H? so tín d?ng thông thu?ng - SXKD   [2015110900010680]  	 
18 CAR/16/0001/00122/00006677 H? so cho vay theo s?n ph?m d?c thù   [2016060300012748]  	 
19 CAR/15/0001/00122/00005070 H? so tín d?ng thông thu?ng - SXKD   [2015110300010643]  	 
20 CAR/15/0001/00122/00005103 H? so tín d?ng thông thu?ng - SXKD   [2015110400010653]  	 
21 CAR/15/0001/00122/00005119 H? so tín d?ng thông thu?ng - SXKD   [2015110900010679]  	 
22 CAR/15/0001/00122/00005237 H? so tín d?ng thông thu?ng - SXKD   [2015111600010825]  	 
23 CAR/15/0001/00122/00005224 H? so tín d?ng thông thu?ng - SXKD   [2015111300010812]  	 
24 CAR/16/0001/00122/00005728 

COM CUS2


-- 9/21/22
Q CLIMSquery CLIMS 
ACC: RMTL: rmklinh001
-- CAR/16/0001/00122/00006228
 
 -- Khach hang TEST 14042016
 SELECT * FROM sci_lsp_lmt_profile WHERE CMS_LSP_LMT_PROFILE_ID IN ( SELECT CMS_LSP_LMT_PROFILE_ID FROM CMS_CA_COLLATERAL_MAP WHERE LOS_BCA_REF_NUM = 'CAR/16/0001/00122/00006228' ); 
-- 20160414000009284		77173

SELECT * FROM CMS_FAC_RELATIONSHIP WHERE cif_number LIKE '%77173%';
20160414000010813	20160414000028154			RELATIONSHIP	2	77173
20160414000010815	20160414000028156			RELATIONSHIP	2	77173
20160414000010831	20160414000028172			RELATIONSHIP	2	77173
20160414000010889	20160414000028218			RELATIONSHIP	2	77173
20160415000011068	20160414000028155	20160415000011066		RELATIONSHIP	2	77173
20160415000011083	20160415000028331			RELATIONSHIP	2	77173
20160415000011125	20160415000028349			RELATIONSHIP	2	77173
20160415000011126	20160414000028154			RELATIONSHIP	2	77173
20160415000011127	20160414000028155			RELATIONSHIP	2	77173
20160415000011129	20160415000028331			RELATIONSHIP	2	77173
20190213000019424	20190213000034830			RELATIONSHIP	1	77173
20190213000019426	20190213000034832			RELATIONSHIP	1	77173
20190213000019428	20190213000034834			RELATIONSHIP	1	77173

UPDATE CMS_FAC_RELATIONSHIP SET cif_number = '77173xxx' WHERE cif_number = '77173';
COMMIT;
