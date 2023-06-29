SELECT 
  id, 
  status, 
  name, 
--  activation_date, 
--  deactivation_date, 
  product_code, 
--  category,
consumption_type_of_loan ,
  (
    select 
      cv.code_value_en 
    from 
      code_value cv 
    where 
      cv.id = consumption_type_of_loan
  ) consumption_type_of_loan2 
FROM 
  SML_PRODUCT 
WHERE 
  category = 188
  AND
  (
    (
      status = 'ACTIVE' 
      AND master_Id is not null
    ) 
    OR (
      (
        status = 'ND' 
        OR status = 'PENDING_APPROVAL' 
        OR status = 'DECLINED'
      ) 
      AND master_Id is null
    )
  ) 
--  AND product_code = '801' 
order by 
  product_code , consumption_type_of_loan2, name ASC ;
  
  SELECT consumption_type_of_loan FROM SML_PRODUCT WHERE ID IN( 20150107001557, 20150107001558, 201510220000001598) ;
  201603240000001726
201603220000001669
201606290000001978
201603220000001671
201603280000001781
  UPDATE SML_PRODUCT SET NAME = 'A-Consumer Loans' WHERE ID = 201603280000001781 ;
 UPDATE SML_PRODUCT SET NAME = 'B-Consumer Loans' WHERE ID = 201603220000001671 ;
 UPDATE SML_PRODUCT SET NAME = 'C-Consumer Loans' WHERE ID = 201606290000001978 ;
 UPDATE SML_PRODUCT SET NAME = 'D-Consumer Loans' WHERE ID = 201603220000001669 ;
 UPDATE SML_PRODUCT SET NAME = 'E-Consumer Loans' WHERE ID = 201603240000001726 ;
COMMIT ;

