--TOPIC: RE-TEST VAR CAR FROM CLOS tO CMS

SELECT * FROM SCI_LSP_AA_PROFILE WHERE APPROVAL_EXCEPTION IS NOT NULL ;
-- 20221021000005926	3013861030	CAR/22/0001/00122/00009314

SELECT * FROM STAGE_AA_PROFILE WHERE APPROVAL_EXCEPTION IS NOT NULL ;

-- MAP SUCCESUFL TO CMS UI

-- CLOS VAR CAR
-- CAR/22/0001/00122/00009314
-- rmklink001


Như vậy là CLOS khi EDIT AA không SAVE AP mới do đó mất.

SELECT * FROM SML_CA WHERE ca_number LIKE '%CAR/23/0001/00122/00009338%'; -- ID : 201905140000023561
SELECT * FROM SML_AA_LIMIT WHERE CA_ID LIKE '%201905140000023561%';  -- id = 201905140000020815
SELECT * FROM SML_AA_LIMIT_BANK_PROP WHERE aa_limit_id =201905140000020815 ;
UPDATE SML_AA_LIMIT_BANK_PROP SET approval_exception = 'Ex1,Ex3' WHERE ID =  201905140000020815;

--QUERY UAT data
SELECT * FROM SML_CA WHERE ca_number = 'CAR/23/9001/00343/01304654';
a thử query giúp e trên UAT CLos với ạ

với câu này trên CMS UAT nữa ạ 
SELECT * FROM  SCI_LSP_AA_PROFILE WHERE los_bca_ref_num='CAR/23/9001/00343/01304654';