-- VCLOSPRODA 1438
DELETE FROM CMS_SECURITY WHERE CMS_COLLATERAL_ID  = 20220726020559085;
DELETE FROM CMS_ASSET WHERE CMS_COLLATERAL_ID = 20220726020559085;
DELETE FROM CMS_ASSET_VEHICLE WHERE CMS_COLLATERAL_ID = 20220726020559085;
DELETE FROM TRANSACTION WHERE transaction_type = 'COL' and reference_id = 20220726020559085 ;
COMMIT;