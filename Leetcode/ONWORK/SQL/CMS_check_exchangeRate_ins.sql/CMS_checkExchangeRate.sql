SELECT CMS_FOREX.FEED_ID, CMS_FOREX.BUY_CURRENCY, CMS_FOREX.SELL_CURRENCY, 
					 CMS_FOREX.BUY_RATE, CMS_FOREX.SELL_RATE, CMS_FOREX.BUY_UNIT, CMS_FOREX.SELL_UNIT, 
					 CMS_FOREX.MID_RATE, CMS_FOREX.DECIMAL_POSITION, CMS_FOREX.ROUND_TRUNCATE_CODE, 
					 CMS_FOREX.EFFECTIVE_DATE, CMS_FOREX.CURRENCY_DESC FROM  CMS_FOREX ;


                     SELECT CMS_FOREX.FEED_ID, CMS_FOREX.BUY_CURRENCY, CMS_FOREX.SELL_CURRENCY, "
					+ "CMS_FOREX.BUY_RATE, CMS_FOREX.SELL_RATE, CMS_FOREX.BUY_UNIT, CMS_FOREX.SELL_UNIT, "
					+ "CMS_FOREX.MID_RATE, CMS_FOREX.DECIMAL_POSITION, CMS_FOREX.ROUND_TRUNCATE_CODE, "
					+ "CMS_FOREX.EFFECTIVE_DATE, CMS_FOREX.CURRENCY_DESC FROM  CMS_FOREX


                     public double getConversionRate() {
        String rate = PropertyManager.getValue("conversion.rate.flag");
        double convRate = 0.00;

        if (BUY_RATE_CODE.equalsIgnoreCase(rate)) {
            convRate = getBuyRate();
        } else if (SELL_RATE_CODE.equalsIgnoreCase(rate)) {
            convRate = getSellRate();
        } else if (MID_RATE_CODE.equalsIgnoreCase(rate)) {
            convRate = getMidRate();
        }
        return convRate;
    }