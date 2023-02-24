--COPY CLOS COL - to SAUBMIT LIGHT CẢ with a COL
Search 'PT20130826007376'; --copy col

-- PROCESS: 
-- SEE FAC in CMS - all the INFORMATION
-- fill all the fields need to test LOST or not

-- GO RLOS-= pull DATA from CMS - Check if have that fields

-- Send back to CMS -

-- BEFORE and AFTER change code
-- EXPECTATION:
-- before : LOSSS DATA
-- after : NO LOSS

--CMS query
SELECT * FROM CMS_SECURITY WHERE SECURITY_NO = 'PT20130826007376' ;

SELECT * FROM CMS_SECURITY WHERE SECURITY_NO = 'PT20130826007376' ; -- 20130826000006887

SELECT * FROM CMS_PROPERTY WHERE cms_collateral_id = 20130826000006887 ;

-- then edit and save on UI

-- JS to add and select OPtion to UI valuerInGCMS
let z= document.getElementById('valuerInGCMS') ;
let y = document.getElementsByClassName("valuerInGCMS")[0];
let x = document.getElementsByName("valuerInGCMS")[0];
var option = document.createElement("option");
option.text = "Kiwi"; option.value="NH TCB";option.selected = 'selected';
x.add(option);

The transaction has been saved.
Your Transaction ID is 20230223000255518

-- done change CMS- RLOS on and pull




SELECT * FROM TRANSACTION tr WHERE tr.transaction_date > TRUNC(SYSDATE) ;

SELECT * FROM CMS_PROPERTY WHERE cms_collateral_id = 20140903002947915 ; 

SELECT * FROM CMS_STAGE_PROPERTY WHERE cms_collateral_id IN (SELECT STAGING_REFERENCE_ID FROM TRANSACTION WHERE TRANSACTION_TYPE = 'COL' AND REFERENCE_ID = 20140903002947915) ; 

-- NOT DONE SUCCESS
--RETEST 2 : 


-- COME to RLOS UI to SEE FIELD in CMS -> can EDIT or NOT
--TEST DONE SUCCESS
https://svn.integrosys.com/projects/vbcms/branches/CR2022
