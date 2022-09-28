--create
CREATE TABLE HK_CMS_FACILITY_MASTER AS SELECT * FROM CMS_FACILITY_MASTER WHERE rownum = -1;
CREATE TABLE HK_CMS_FAC_RELATIONSHIP  AS SELECT * FROM CMS_FAC_RELATIONSHIP  WHERE rownum = -1;
CREATE TABLE HK_CMS_FAC_MULTI_TIER_FINANCING AS SELECT * FROM CMS_FAC_MULTI_TIER_FINANCING WHERE rownum = -1;
CREATE TABLE HK_CMS_FAC_PREPAYMENT_LIST AS SELECT * FROM CMS_FAC_PREPAYMENT_LIST WHERE rownum = -1;
CREATE TABLE HK_CMS_FAC_REDUCTION_SCHEDULE AS SELECT * FROM CMS_FAC_REDUCTION_SCHEDULE WHERE rownum = -1;
CREATE TABLE HK_CMS_LSP_APPR_DRAWING_CURR AS SELECT * FROM CMS_LSP_APPR_DRAWING_CURR WHERE rownum = -1;
CREATE TABLE HK_CMS_FAC_MESSAGE AS SELECT * FROM CMS_FAC_MESSAGE WHERE rownum = -1;
CREATE TABLE HK_CMS_FAC_INCREMENTAL AS SELECT * FROM CMS_FAC_INCREMENTAL WHERE rownum = -1;

CREATE TABLE HK_CMS_FAC_GENERAL  AS SELECT * FROM CMS_FAC_GENERAL  WHERE rownum = -1;
CREATE TABLE HK_CMS_FAC_INTEREST AS SELECT * FROM CMS_FAC_INTEREST WHERE rownum = -1;
CREATE TABLE HK_CMS_FAC_ADDITIONAL AS SELECT * FROM CMS_FAC_ADDITIONAL WHERE rownum = -1;
CREATE TABLE HK_CMS_FAC_FEE_CHARGE AS SELECT * FROM CMS_FAC_FEE_CHARGE WHERE rownum = -1;
CREATE TABLE HK_CMS_FAC_BNM_CODES AS SELECT * FROM CMS_FAC_BNM_CODES WHERE rownum = -1;
CREATE TABLE HK_CMS_FAC_ISLAMIC_MASTER AS SELECT * FROM CMS_FAC_ISLAMIC_MASTER WHERE rownum = -1;
CREATE TABLE HK_CMS_FAC_BBA_VARI_PACKAGE AS SELECT * FROM CMS_FAC_BBA_VARI_PACKAGE WHERE rownum = -1;
CREATE TABLE HK_CMS_FAC_RENTAL_RENEWAL AS SELECT * FROM CMS_FAC_RENTAL_RENEWAL WHERE rownum = -1;
CREATE TABLE HK_CMS_FAC_SECURITY_DEPOSIT AS SELECT * FROM CMS_FAC_SECURITY_DEPOSIT WHERE rownum = -1;
CREATE TABLE HK_CMS_FAC_TSPR AS SELECT * FROM CMS_FAC_TSPR WHERE rownum = -1;
CREATE TABLE HK_CMS_SECURITY AS SELECT * FROM CMS_SECURITY WHERE rownum = -1;
CREATE TABLE HK_cms_cash_deposit  AS SELECT * FROM cms_cash_deposit  WHERE rownum = -1;
CREATE TABLE HK_sci_sec_pldgr_map AS SELECT * FROM sci_sec_pldgr_map WHERE rownum = -1;
CREATE TABLE HK_cms_ca_collateral_map AS SELECT * FROM cms_ca_collateral_map WHERE rownum = -1;
CREATE TABLE HK_CMS_CHARGE_DETAIL AS SELECT * FROM CMS_CHARGE_DETAIL WHERE rownum = -1;
CREATE TABLE HK_CMS_LIMIT_CHARGE_MAP  AS SELECT * FROM CMS_LIMIT_CHARGE_MAP  WHERE rownum = -1;
CREATE TABLE HK_cms_limit_security_map AS SELECT * FROM cms_limit_security_map WHERE rownum = -1;
CREATE TABLE HK_CMS_ASSET AS SELECT * FROM CMS_ASSET WHERE rownum = -1;
CREATE TABLE HK_CMS_CASH AS SELECT * FROM CMS_CASH WHERE rownum = -1;
CREATE TABLE HK_CMS_ASSET_PDC AS SELECT * FROM CMS_ASSET_PDC WHERE rownum = -1;
CREATE TABLE HK_CMS_VALUATION AS SELECT * FROM CMS_VALUATION WHERE rownum = -1;
CREATE TABLE HK_CMS_INSURANCE AS SELECT * FROM CMS_INSURANCE WHERE rownum = -1;
CREATE TABLE HK_CMS_INSURANCE_CDS AS SELECT * FROM CMS_INSURANCE_CDS WHERE rownum = -1;
CREATE TABLE HK_CMS_MARKETABLE_SEC AS SELECT * FROM CMS_MARKETABLE_SEC WHERE rownum = -1;
CREATE TABLE HK_CMS_PORTFOLIO_ITEM AS SELECT * FROM CMS_PORTFOLIO_ITEM WHERE rownum = -1;
CREATE TABLE HK_CMS_DOCUMENT AS SELECT * FROM CMS_DOCUMENT WHERE rownum = -1;
CREATE TABLE HK_CMS_OTHERS AS SELECT * FROM CMS_OTHERS WHERE rownum = -1;
CREATE TABLE HK_CMS_GUARANTEE AS SELECT * FROM CMS_GUARANTEE WHERE rownum = -1;
CREATE TABLE HK_CMS_PROPERTY AS SELECT * FROM CMS_PROPERTY WHERE rownum = -1;
CREATE TABLE HK_CMS_INSURANCE_POLICY AS SELECT * FROM CMS_INSURANCE_POLICY WHERE rownum = -1;
CREATE TABLE HK_CMS_ASSET_AIRCRAFT AS SELECT * FROM CMS_ASSET_AIRCRAFT WHERE rownum = -1;
CREATE TABLE HK_CMS_ASSET_GOLD AS SELECT * FROM CMS_ASSET_GOLD WHERE rownum = -1;

CREATE TABLE HK_CMS_ASSET_PLANT_EQUIP AS SELECT * FROM CMS_ASSET_PLANT_EQUIP WHERE rownum = -1;
CREATE TABLE HK_CMS_ASSET_TRADE_IN AS SELECT * FROM CMS_ASSET_TRADE_IN WHERE rownum = -1;
CREATE TABLE HK_CMS_ASSET_VEHICLE AS SELECT * FROM CMS_ASSET_VEHICLE WHERE rownum = -1;
CREATE TABLE HK_CMS_ASSET_VESSEL AS SELECT * FROM CMS_ASSET_VESSEL WHERE rownum = -1;
CREATE TABLE HK_cms_checklist AS SELECT * FROM cms_checklist WHERE rownum = -1;
CREATE TABLE HK_cms_checklist_item AS SELECT * FROM cms_checklist_item WHERE rownum = -1;
CREATE TABLE HK_cms_cust_doc AS SELECT * FROM cms_cust_doc WHERE rownum = -1;
CREATE TABLE HK_cms_cust_doc_item AS SELECT * FROM cms_cust_doc_item WHERE rownum = -1;
CREATE TABLE HK_TRANSACTION AS SELECT * FROM TRANSACTION WHERE rownum = -1;
CREATE TABLE HK_TRANS_HISTORY AS SELECT * FROM TRANS_HISTORY WHERE rownum = -1;
CREATE TABLE HK_CMS_STG_FACILITY_MASTER AS SELECT * FROM CMS_STG_FACILITY_MASTER WHERE rownum = -1;
CREATE TABLE HK_CMS_STG_FAC_RELATIONSHIP  AS SELECT * FROM CMS_STG_FAC_RELATIONSHIP  WHERE rownum = -1;
CREATE TABLE HK_CMS_STG_FAC_MULTI_TIER_FINANCI AS SELECT * FROM CMS_STG_FAC_MULTI_TIER_FINANCI WHERE rownum = -1;
CREATE TABLE HK_CMS_STG_FAC_PREPAYMENT_LIST AS SELECT * FROM CMS_STG_FAC_PREPAYMENT_LIST WHERE rownum = -1;
CREATE TABLE HK_CMS_STG_FAC_REDUCTION_SCHEDULE AS SELECT * FROM CMS_STG_FAC_REDUCTION_SCHEDULE WHERE rownum = -1;
CREATE TABLE HK_CMS_STG_LSP_APPR_DRAWING_CURR AS SELECT * FROM CMS_STG_LSP_APPR_DRAWING_CURR WHERE rownum = -1;
CREATE TABLE HK_CMS_STG_FAC_MESSAGE AS SELECT * FROM CMS_STG_FAC_MESSAGE WHERE rownum = -1;
CREATE TABLE HK_CMS_STG_FAC_INCREMENTAL AS SELECT * FROM CMS_STG_FAC_INCREMENTAL WHERE rownum = -1;

CREATE TABLE HK_CMS_STG_FAC_GENERAL  AS SELECT * FROM CMS_STG_FAC_GENERAL  WHERE rownum = -1;
CREATE TABLE HK_CMS_STG_FAC_INTEREST AS SELECT * FROM CMS_STG_FAC_INTEREST WHERE rownum = -1;
CREATE TABLE HK_CMS_STG_FAC_ADDITIONAL AS SELECT * FROM CMS_STG_FAC_ADDITIONAL WHERE rownum = -1;
CREATE TABLE HK_CMS_STG_FAC_FEE_CHARGE AS SELECT * FROM CMS_STG_FAC_FEE_CHARGE WHERE rownum = -1;
CREATE TABLE HK_CMS_STG_FAC_BNM_CODES AS SELECT * FROM CMS_STG_FAC_BNM_CODES WHERE rownum = -1;
CREATE TABLE HK_CMS_STG_FAC_ISLAMIC_MASTER AS SELECT * FROM CMS_STG_FAC_ISLAMIC_MASTER WHERE rownum = -1;
CREATE TABLE HK_CMS_STG_FAC_BBA_VARI_PACKAGE AS SELECT * FROM CMS_STG_FAC_BBA_VARI_PACKAGE WHERE rownum = -1;
CREATE TABLE HK_CMS_STG_FAC_RENTAL_RENEWAL AS SELECT * FROM CMS_STG_FAC_RENTAL_RENEWAL WHERE rownum = -1;
CREATE TABLE HK_CMS_STG_FAC_SECURITY_DEPOSIT AS SELECT * FROM CMS_STG_FAC_SECURITY_DEPOSIT WHERE rownum = -1;
CREATE TABLE HK_CMS_STG_FAC_TSPR AS SELECT * FROM CMS_STG_FAC_TSPR WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_SECURITY AS SELECT * FROM CMS_STAGE_SECURITY WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_cash_deposit  AS SELECT * FROM CMS_STAGE_cash_deposit  WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_CHARGE_DETAIL AS SELECT * FROM CMS_STAGE_CHARGE_DETAIL WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_LIMIT_CHARGE_MAP  AS SELECT * FROM CMS_STAGE_LIMIT_CHARGE_MAP  WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_limit_security_map AS SELECT * FROM CMS_STAGE_limit_security_map WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_ASSET AS SELECT * FROM CMS_STAGE_ASSET WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_CASH AS SELECT * FROM CMS_STAGE_CASH WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_ASSET_PDC AS SELECT * FROM CMS_STAGE_ASSET_PDC WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_VALUATION AS SELECT * FROM CMS_STAGE_VALUATION WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_INSURANCE AS SELECT * FROM CMS_STAGE_INSURANCE WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_INSURANCE_CDS AS SELECT * FROM CMS_STAGE_INSURANCE_CDS WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_MARKETABLE_SEC AS SELECT * FROM CMS_STAGE_MARKETABLE_SEC WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_PORTFOLIO_ITEM AS SELECT * FROM CMS_STAGE_PORTFOLIO_ITEM WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_DOCUMENT AS SELECT * FROM CMS_STAGE_DOCUMENT WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_OTHERS AS SELECT * FROM CMS_STAGE_OTHERS WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_GUARANTEE AS SELECT * FROM CMS_STAGE_GUARANTEE WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_PROPERTY AS SELECT * FROM CMS_STAGE_PROPERTY WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_INSURANCE_POLICY AS SELECT * FROM CMS_STAGE_INSURANCE_POLICY WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_ASSET_AIRCRAFT AS SELECT * FROM CMS_STAGE_ASSET_AIRCRAFT WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_ASSET_GOLD AS SELECT * FROM CMS_STAGE_ASSET_GOLD WHERE rownum = -1;

CREATE TABLE HK_CMS_STAGE_ASSET_PLANT_EQUIP AS SELECT * FROM CMS_STAGE_ASSET_PLANT_EQUIP WHERE rownum = -1;
CREATE TABLE HK_STAGE_ASSET_TRADE_IN AS SELECT * FROM STAGE_ASSET_TRADE_IN WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_ASSET_VEHICLE AS SELECT * FROM CMS_STAGE_ASSET_VEHICLE WHERE rownum = -1;
CREATE TABLE HK_CMS_STAGE_ASSET_VESSEL AS SELECT * FROM CMS_STAGE_ASSET_VESSEL WHERE rownum = -1;
CREATE TABLE HK_STAGE_CHECKLIST AS SELECT * FROM STAGE_CHECKLIST WHERE rownum = -1;
CREATE TABLE HK_STAGE_CHECKLIST_ITEM AS SELECT * FROM STAGE_CHECKLIST_ITEM WHERE rownum = -1;
CREATE TABLE HK_cms_stage_cust_doc AS SELECT * FROM cms_stage_cust_doc WHERE rownum = -1;
CREATE TABLE HK_cms_stage_cust_doc_item AS SELECT * FROM cms_stage_cust_doc_item WHERE rownum = -1;
CREATE TABLE HK_sci_lsp_appr_lmts		 AS SELECT * FROM sci_lsp_appr_lmts WHERE rownum = -1;


--drop
DROP TABLE HK_CMS_FACILITY_MASTER;
DROP TABLE HK_CMS_FAC_RELATIONSHIP ;
DROP TABLE HK_CMS_FAC_MULTI_TIER_FINANCING;
DROP TABLE HK_CMS_FAC_PREPAYMENT_LIST;
DROP TABLE HK_CMS_FAC_REDUCTION_SCHEDULE;
DROP TABLE HK_CMS_LSP_APPR_DRAWING_CURR;
DROP TABLE HK_CMS_FAC_MESSAGE;
DROP TABLE HK_CMS_FAC_INCREMENTAL;
DROP TABLE HK_CMS_FAC_REDUCTION_SCHEDULE;
DROP TABLE HK_CMS_FAC_GENERAL ;
DROP TABLE HK_CMS_FAC_INTEREST;
DROP TABLE HK_CMS_FAC_ADDITIONAL;
DROP TABLE HK_CMS_FAC_FEE_CHARGE;
DROP TABLE HK_CMS_FAC_BNM_CODES;
DROP TABLE HK_CMS_FAC_ISLAMIC_MASTER;
DROP TABLE HK_CMS_FAC_BBA_VARI_PACKAGE;
DROP TABLE HK_CMS_FAC_RENTAL_RENEWAL;
DROP TABLE HK_CMS_FAC_SECURITY_DEPOSIT;
DROP TABLE HK_CMS_FAC_TSPR;
DROP TABLE HK_CMS_SECURITY;
DROP TABLE HK_cms_cash_deposit ;
DROP TABLE HK_sci_sec_pldgr_map;
DROP TABLE HK_cms_ca_collateral_map;
DROP TABLE HK_CMS_CHARGE_DETAIL;
DROP TABLE HK_CMS_LIMIT_CHARGE_MAP ;
DROP TABLE HK_cms_limit_security_map;
DROP TABLE HK_CMS_ASSET;
DROP TABLE HK_CMS_CASH;
DROP TABLE HK_CMS_ASSET_PDC;
DROP TABLE HK_CMS_VALUATION;
DROP TABLE HK_CMS_INSURANCE;
DROP TABLE HK_CMS_INSURANCE_CDS;
DROP TABLE HK_CMS_MARKETABLE_SEC;
DROP TABLE HK_CMS_PORTFOLIO_ITEM;
DROP TABLE HK_CMS_DOCUMENT;
DROP TABLE HK_CMS_OTHERS;
DROP TABLE HK_CMS_GUARANTEE;
DROP TABLE HK_CMS_PROPERTY;
DROP TABLE HK_CMS_INSURANCE_POLICY;
DROP TABLE HK_CMS_ASSET_AIRCRAFT;
DROP TABLE HK_CMS_ASSET_GOLD;

DROP TABLE HK_CMS_ASSET_PLANT_EQUIP;
DROP TABLE HK_CMS_ASSET_TRADE_IN;
DROP TABLE HK_CMS_ASSET_VEHICLE;
DROP TABLE HK_CMS_ASSET_VESSEL;
DROP TABLE HK_cms_checklist;
DROP TABLE HK_cms_checklist_item;
DROP TABLE HK_cms_cust_doc;
DROP TABLE HK_cms_cust_doc_item;
DROP TABLE HK_TRANSACTION;
DROP TABLE HK_TRANS_HISTORY;
DROP TABLE HK_CMS_STG_FACILITY_MASTER;
DROP TABLE HK_CMS_STG_FAC_RELATIONSHIP ;
DROP TABLE HK_CMS_STG_FAC_MULTI_TIER_FINANCI;
DROP TABLE HK_CMS_STG_FAC_PREPAYMENT_LIST;
DROP TABLE HK_CMS_STG_FAC_REDUCTION_SCHEDULE;
DROP TABLE HK_CMS_STG_LSP_APPR_DRAWING_CURR;
DROP TABLE HK_CMS_STG_FAC_MESSAGE;
DROP TABLE HK_CMS_STG_FAC_INCREMENTAL;

DROP TABLE HK_CMS_STG_FAC_GENERAL ;
DROP TABLE HK_CMS_STG_FAC_INTEREST;
DROP TABLE HK_CMS_STG_FAC_ADDITIONAL;
DROP TABLE HK_CMS_STG_FAC_FEE_CHARGE;
DROP TABLE HK_CMS_STG_FAC_BNM_CODES;
DROP TABLE HK_CMS_STG_FAC_ISLAMIC_MASTER;
DROP TABLE HK_CMS_STG_FAC_BBA_VARI_PACKAGE;
DROP TABLE HK_CMS_STG_FAC_RENTAL_RENEWAL;
DROP TABLE HK_CMS_STG_FAC_SECURITY_DEPOSIT;
DROP TABLE HK_CMS_STG_FAC_TSPR;
DROP TABLE HK_CMS_STAGE_SECURITY;
DROP TABLE HK_CMS_STAGE_cash_deposit ;
DROP TABLE HK_CMS_STAGE_CHARGE_DETAIL;
DROP TABLE HK_CMS_STAGE_LIMIT_CHARGE_MAP ;
DROP TABLE HK_CMS_STAGE_limit_security_map;
DROP TABLE HK_CMS_STAGE_ASSET;
DROP TABLE HK_CMS_STAGE_CASH;
DROP TABLE HK_CMS_STAGE_ASSET_PDC;
DROP TABLE HK_CMS_STAGE_VALUATION;
DROP TABLE HK_CMS_STAGE_INSURANCE;
DROP TABLE HK_CMS_STAGE_INSURANCE_CDS;
DROP TABLE HK_CMS_STAGE_MARKETABLE_SEC;
DROP TABLE HK_CMS_STAGE_PORTFOLIO_ITEM;
DROP TABLE HK_CMS_STAGE_DOCUMENT;
DROP TABLE HK_CMS_STAGE_OTHERS;
DROP TABLE HK_CMS_STAGE_GUARANTEE;
DROP TABLE HK_CMS_STAGE_PROPERTY;
DROP TABLE HK_CMS_STAGE_INSURANCE_POLICY;
DROP TABLE HK_CMS_STAGE_ASSET_AIRCRAFT;
DROP TABLE HK_CMS_STAGE_ASSET_GOLD;

DROP TABLE HK_CMS_STAGE_ASSET_PLANT_EQUIP;
DROP TABLE HK_STAGE_ASSET_TRADE_IN;
DROP TABLE HK_CMS_STAGE_ASSET_VEHICLE;
DROP TABLE HK_CMS_STAGE_ASSET_VESSEL;
DROP TABLE HK_STAGE_CHECKLIST;
DROP TABLE HK_STAGE_CHECKLIST_ITEM;
DROP TABLE HK_cms_stage_cust_doc;
DROP TABLE HK_cms_stage_cust_doc_item;
DROP TABLE HK_sci_lsp_appr_lmts;