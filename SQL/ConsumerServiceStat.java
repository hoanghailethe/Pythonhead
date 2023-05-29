
// Template and Draft
class ConsumerServiceStat {

    @Autowired OrderRepository orderRepository ;
    @Autowired DailyStatisticRepository dailyStatisticRepository ;

    //all event available 
    static final Integer INCREASE_REVENUE_FROM_NEW_ORDER_EVENT_CODE = 1;
    static final Integer RESTRUCTURE_REVENUE_COMPONENT_CODE = 2;
    static final Integer INCREASE_REVENUE_FROM_ADJUSTMENT_EVENT_CODE = 3;
    static final Integer DEDUCE_REVENUE_FROM_ADJUSTMENT_EVENT_CODE = 4;
    static final Integer NO_CHANGE_REVENUE_EVENT = 5;


    // PUB SUB CALCULATION STAT SERVICE
    public void processMsg (Json msg) throws Exception, OrderNotFoundException {

        //calculation from pub message

        // Get info from Msg - extract order infomation
        Long oId = msg.getOrderId() ;
        Integer newStatusCode = msg.getStatusCode() ;

        // GET existing Order from DB
        Order orderDb = orderRepository.getReferenceById(oId).orElseThrow() ;
        Integer prevStatusCode = orderDb.getStatusCode() ; 

        //All Case cause CHANGE TOTAL REV and HANDING
        Integer evenCode = NO_CHANGE_REVENUE_EVENT ;
        evenCode = renenueEventFromOrderStatusChange(prevStatusCode, newStatusCode) ;
        switch (evenCode) {
            case INCREASE_REVENUE_FROM_NEW_ORDER_EVENT_CODE: 
                Double newRevenue = inscreaseRevenue() ;
            
                break ;
            case RESTRUCTURE_REVENUE_COMPONENT_CODE: break ;
            case INCREASE_REVENUE_FROM_ADJUSTMENT_EVENT_CODE: break ;
            case DEDUCE_REVENUE_FROM_ADJUSTMENT_EVENT_CODE: break ;
            default: ;

        }







    }

}