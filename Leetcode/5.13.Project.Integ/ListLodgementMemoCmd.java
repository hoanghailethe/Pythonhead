/**
 * Copyright Integro Technologies Pte Ltd
 * $Header: https://svn.integrosys.com/projects/vbcms/trunk/src/com/integrosys/cms/ui/custodian/ListLodgementMemoCmd.java Exp $
 */
package com.integrosys.cms.ui.custodian;

import com.integrosys.base.businfra.search.SearchResult;
import com.integrosys.base.techinfra.logger.DefaultLogger;
import com.integrosys.base.uiinfra.common.AbstractCommand;
import com.integrosys.base.uiinfra.common.ICommonEventConstant;
import com.integrosys.base.uiinfra.exception.CommandProcessingException;
import com.integrosys.base.uiinfra.exception.CommandValidationException;
import com.integrosys.cms.app.collateral.bus.ICollateral;
import com.integrosys.cms.app.collateral.proxy.CollateralProxyFactory;
import com.integrosys.cms.app.custodian.bus.ICustodianDocItemSearchResult;
import com.integrosys.cms.app.custodian.bus.ICustodianDocSearchResult;
import com.integrosys.cms.app.custodian.bus.OBCustodianDocItemSearchResult;
import com.integrosys.cms.app.custodian.bus.OBCustodianDocSearchResult;
import com.integrosys.cms.app.custodian.proxy.CustodianProxyManagerFactory;
import com.integrosys.cms.app.custodian.proxy.ICustodianProxyManager;
import com.integrosys.cms.app.customer.bus.ICMSCustomer;
import com.integrosys.cms.app.limit.bus.ILimitProfile;
import com.integrosys.cms.app.transaction.OBTrxContext;
import com.integrosys.cms.ui.common.constant.IGlobalConstant;
import com.integrosys.component.bizstructure.app.bus.ITeam;

import java.util.*;

/**
 * Command class to get the list of documents based on the document type set on
 * the search criteria
 *
 * @author $Author: joey.bugaay $<br>
 * @version $Revision: 1.7 $
 * @since $Date: 2019/07/15 07:53:46 $ Tag: $Name: $
 */
public class ListLodgementMemoCmd extends AbstractCommand implements ICommonEventConstant {
    /**
     * Default Constructor
     */
    public ListLodgementMemoCmd() {
    }

    /**
     * Defines an two dimensional array with the parameter list to be passed to
     * the doExecute method by a HashMap syntax for the array is
     * (HashMapkey,classname,scope) The scope may be request,form or service
     *
     * @return the two dimensional String array
     */
    public String[][] getParameterDescriptor() {
        return (new String[][]{
                {IGlobalConstant.GLOBAL_CUSTOMER_OBJ,
                        "com.integrosys.cms.app.customer.bus.ICMSCustomer", GLOBAL_SCOPE},
                {IGlobalConstant.GLOBAL_LIMITPROFILE_OBJ,
                        "com.integrosys.cms.app.limit.bus.ILimitProfile", GLOBAL_SCOPE},
                {"theOBTrxContext",
                        "com.integrosys.cms.app.transaction.OBTrxContext", FORM_SCOPE},
                { "pageNumber", "java.lang.String", REQUEST_SCOPE },
                { "losId", "java.lang.String", REQUEST_SCOPE },
                { "maxPerPage", "java.lang.String", REQUEST_SCOPE },
                { "checkSaved", "java.lang.String", REQUEST_SCOPE },
                { "isSecurityLodgementMemo", "java.lang.String", REQUEST_SCOPE },
                { "maxPerPage", "java.lang.String", REQUEST_SCOPE },
        });
    }

    /**
     * Defines an two dimensional array with the result list to be expected as a
     * result from the doExecute method using a HashMap syntax for the array is
     * (HashMapkey,classname,scope) The scope may be request,form or service
     *
     * @return the two dimensional String array
     */
    public String[][] getResultDescriptor() {
        return (new String[][]{
                {"docList", "com.integrosys.base.businfra.search.SearchResult", SERVICE_SCOPE},
                {"collateralList", "java.util.HashMap", REQUEST_SCOPE},
                {"collateralPledgor", "java.util.HashMap", REQUEST_SCOPE},
                { "pageNumber", "java.lang.Integer", REQUEST_SCOPE },
                { "losId", "java.lang.String", REQUEST_SCOPE },
                { "maxPerPage", "java.lang.String", REQUEST_SCOPE },
                { "startIndex", "java.lang.Integer", REQUEST_SCOPE },
                { "maxPage", "java.lang.Integer", REQUEST_SCOPE },
                { "checkSaved", "java.lang.String", REQUEST_SCOPE },
                { "checkedSet", "java.util.HashSet", REQUEST_SCOPE }
                ,{ "maxPerPage", "java.lang.String", REQUEST_SCOPE },
        });
    }

    /**
     * This method does the Business operations with the HashMap and put the
     * results back into the HashMap.Here creation for Company Borrower is done.
     *
     * @param map is of type HashMap
     * @return HashMap with the Result
     */
    Integer maxPage = 1;
    Integer startId = 0;
    Integer pageNumber = 1;
    Integer maxPerPage = 20 ;
    public HashMap doExecute(HashMap map) throws CommandProcessingException, CommandValidationException {
        HashMap returnMap = new HashMap();
        HashMap resultMap = new HashMap();
        HashMap collateralList = new HashMap();
        DefaultLogger.debug(this, "Begin doExecute()");

        ICMSCustomer cust = (ICMSCustomer) map.get(IGlobalConstant.GLOBAL_CUSTOMER_OBJ);
        ILimitProfile limitProfile = (ILimitProfile) map.get(IGlobalConstant.GLOBAL_LIMITPROFILE_OBJ);

        // Pagination and Search variable
        pageNumber = map.get("pageNumber") == null ? 1 : Integer.parseInt((String) map.get("pageNumber")) ;
        String losId = (String) map.get("losId");
        String checkSaved = map.get("checkSaved") == null ? "" : (String) map.get("checkSaved");
        Set<String> checkedSet = new HashSet<String>();
        Boolean isSecurityLodgementMemo = map.get("isSecurityLodgementMemo") == null ? false : Boolean.parseBoolean((String)map.get("isSecurityLodgementMemo")) ;
        maxPerPage = map.get("maxPerPage") == null ? 20 : Integer.parseInt((String) map.get("maxPerPage")) ;

        OBTrxContext theOBTrxContext = (OBTrxContext) map.get("theOBTrxContext");
        if ((theOBTrxContext != null) && (theOBTrxContext.getUser() != null)) {
            DefaultLogger.debug(this, "loginID=" + theOBTrxContext.getUser().getLoginID());
            ITeam team = theOBTrxContext.getTeam();
            DefaultLogger.debug(this, "Team abbreviation=" + team.getAbbreviation());
        } else {
            DefaultLogger.debug(this, "Login ID is null!");
        }

        try {
            ICustodianProxyManager proxy = CustodianProxyManagerFactory.getCustodianProxyManager();
            SearchResult sr = null;
            if (cust.getNonBorrowerInd()) {
                if (limitProfile != null) {
                    sr = proxy.getPendingLodgementListForNonBorrower(theOBTrxContext, limitProfile.getLimitProfileID(),
                            cust.getCustomerID());
                } else // if limit profile is null
                {
                    sr = proxy.getPendingLodgementListForNonBorrower(theOBTrxContext, cust.getCustomerID());
                }
            } else {
                DefaultLogger.debug(this, "searchCriteria = " + limitProfile.getLimitProfileID());

                                sr = proxy.getPendingLodgementList(null, limitProfile.getLimitProfileID());
//                20130701000000047
//                long testId = 20130619000000063L;
            }
            if (sr != null) {
                ArrayList<ICustodianDocSearchResult> custodianDocList = (ArrayList<ICustodianDocSearchResult>) sr.getResultList();
                for (ICustodianDocSearchResult custSearchResult : custodianDocList) {
                    if ("S".equals(custSearchResult.getCategory())) {
                        ICollateral collateral = CollateralProxyFactory.getProxy().getCollateral(custSearchResult.getCollateralID(), true);
                        collateralList.put(collateral.getCollateralID(), collateral);
                    }

                }
                DefaultLogger.debug(this, "collateralList size=" + collateralList.size());
                resultMap.put("collateralList", collateralList);
            }

            ArrayList l = (ArrayList) sr.getResultList();


            if (isSecurityLodgementMemo) {
//                Filter S category condition
                filterConditionDocResultTypeSecurity(l, collateralList);
            // Search function with l
                if(losId!=null && !"".equals(losId)) {
                    filterByLosId(l, losId);
                }
            //      pagination
                partition(l);

                //proccess and saved CheckBoxSaved
                String[] checked = checkSaved.split(",");

                checkedSet.addAll(Arrays.asList(checked));
                StringBuilder pen = new StringBuilder();

                Iterator<String> itr = checkedSet.iterator();
                while(itr.hasNext()){
                    pen.append(itr.next()) ;
                    if (itr.hasNext()) pen.append(",");
                }
                checkSaved = pen.toString();
            }
            resultMap.put("docList", sr);

        } catch (Exception e) {
            DefaultLogger.debug(this, "got exception " + e);
            e.printStackTrace();
            throw (new CommandProcessingException(e.getMessage(), e));
        }
        DefaultLogger.debug(this, "Going out of doExecute()");
        returnMap.put(ICommonEventConstant.COMMAND_RESULT_MAP, resultMap);
        resultMap.put("pageNumber", pageNumber);
        resultMap.put("maxPage", maxPage);
        resultMap.put("losId", losId);
        resultMap.put("startIndex", startId);
        resultMap.put("checkSaved", checkSaved);
        resultMap.put("checkedSet", checkedSet);
        resultMap.put("maxPerPage", maxPerPage);
        return returnMap;
    }



    private void filterByLosId(ArrayList listRS, String losId) {
//        ArrayList<ICustodianDocSearchResult>
        Iterator i = listRS.iterator();
        while(i.hasNext()) {
            ICustodianDocSearchResult ob = (ICustodianDocSearchResult) i.next();
            ICustodianDocItemSearchResult[] array = ob.getCustodianDocItems();
            ArrayList<ICustodianDocItemSearchResult> list = new ArrayList();
            for (ICustodianDocItemSearchResult element : array) {
                if (element != null && element.getDocNo() != null ) {
                    String id = element.getDocNo();
                    if (id.contains(losId)) {
                        list.add(element);
                    } else if( element.getDocItemRef() != 0 && Long.toString(element.getDocItemRef()).contains(losId) ) {
                        list.add(element);
                    }
                }
            }
            if(list.isEmpty()) {
                i.remove();
            }else
            {
                ICustodianDocItemSearchResult[] newArr = new ICustodianDocItemSearchResult[list.size()];
                ob.setCustodianDocItems(list.toArray(newArr));
            }
        }

    }

    private void partition(ArrayList list) {


        if (list == null || list.size() == 0) {
            return;
        }

        startId = maxPerPage * (pageNumber-1) ; // 1 = 0 , 2 = 20 , 3 = 40, 4 = 60 ...80 ...100
        int maxNextPages = 6; // handle Next button
        int maxItemsNextPage = maxPerPage * maxNextPages;

        //find the item startIndex
        Iterator i = list.iterator();
        int count = 0 ;
        DefaultLogger.debug(this, "err4.listLodge.size: before" + list.size());
        while(i.hasNext() && count < startId  + 1) {
            ICustodianDocSearchResult ob = (ICustodianDocSearchResult) i.next();

            ICustodianDocItemSearchResult[] array = ob.getCustodianDocItems();

            //find the First item >= start index
            count += array.length;
//            DefaultLogger.debug(this, "err4.listLodge: " + ob);
            if (count < startId  + 1 ) i.remove();
//            DefaultLogger.debug(this, "err4.listLodge is null ? ob: " + ob );
//            DefaultLogger.debug(this, "err4.listLodge is null ? i: " + i );

        }
//        list.removeAll(Collections.singleton(null));
        DefaultLogger.debug(this, "err4.listLodge.size: after 245" + list.size());

        // process the first Item on list
        if (count > startId + 1 && startId > 0) {  // only start From page 2
            ICustodianDocSearchResult ob = (ICustodianDocSearchResult) list.get(0);
            ICustodianDocItemSearchResult[] array = ob.getCustodianDocItems();

            int NumberOfLastItemsToTake = count - startId - 1;
            if ( NumberOfLastItemsToTake > 0 ) {
                ICustodianDocItemSearchResult[] newArr = new ICustodianDocItemSearchResult[NumberOfLastItemsToTake];
                for (int n = array.length - 1 , s = NumberOfLastItemsToTake - 1; n > 0 && s >= 0 ; n--) {
                    newArr[s--] = array[n];
//                DefaultLogger.debug(this, "err4.listLodge.size5: " + newArr[s--] == null);
                }
                ob.setCustodianDocItems(newArr);
            }
        }

        //put the number of ITEM just enough for current page
        // Exception when List size = 0 and startID > count
        if(startId+1 > count) {
            startId = (int) Math.floor( (double) count / (double) maxPerPage );
            maxPage = pageNumber ;
        }


        // find the min End index of NextPage to show
        int countLeftItem = 0;
        Iterator u = list.iterator();
        while(u.hasNext() ) {
            ICustodianDocSearchResult ob = (ICustodianDocSearchResult) u.next();
            ICustodianDocItemSearchResult[] array = ob.getCustodianDocItems();
            countLeftItem += array.length ;
            if ( countLeftItem >=  maxItemsNextPage -maxPerPage ) break ;   //minus page 1
        }
        maxPage = (int) Math.ceil( Math.min(maxItemsNextPage -maxPerPage, countLeftItem) / (float) maxPerPage) + pageNumber ;


        count = 0;
        int indexLayer1 = -1;
        while ( list.isEmpty() == false && count < maxPerPage) {
            for(Object ob : list) {
                ICustodianDocSearchResult obc = (ICustodianDocSearchResult) ob;
                ICustodianDocItemSearchResult[] array = obc.getCustodianDocItems();
                count += array.length;
                indexLayer1 ++ ;

                if ( count >  maxPerPage ) {
                    //process the last outbound ITem then break
                    int numberOfLastItemsRemove = count - maxPerPage;
                    ICustodianDocItemSearchResult[] newArr = new ICustodianDocItemSearchResult[array.length - numberOfLastItemsRemove ];
                    for (int n = 0 ; n < newArr.length ; n++) {
                        newArr[n] = array[n];
                    }
                    obc.setCustodianDocItems(newArr);
                    break;
                }
            }
        }
        // subList for the outer bound layer 1
        DefaultLogger.debug(this, "err4.listLodge.size 286: befoire" + list.size());
        if (indexLayer1 < list.size() -1) {
            list.subList(indexLayer1+1, list.size()).clear() ;
        }
        DefaultLogger.debug(this, "err4.listLodge.size 290: after" + list.size());
    }

    private void filterConditionDocResultTypeSecurity(ArrayList list , HashMap collateralMap ) {
        Iterator i = list.iterator();

        while(i.hasNext() ) {
            ICustodianDocSearchResult ob = (ICustodianDocSearchResult) i.next();
            if (!"S".equals(ob.getCategory())) {
                i.remove();
                continue;
            }


            ICustodianDocItemSearchResult[] itemArr = ob.getCustodianDocItems();
            boolean empty = true;

            ArrayList<ICustodianDocItemSearchResult> newArr = new ArrayList();

            for (int ind = 0; ind < itemArr.length; ind++) { //&& ob.getCheckListID() == checklistID
                ICustodianDocItemSearchResult item = itemArr[ind];
                if (item != null) empty = false;
                if (item!=null && item.getDocType()!= null && item.getDocType().equals(com.integrosys.cms.app.common.constant.ICMSConstant.DOC_TYPE_SECURITY)

                )
                {
                    newArr.add(item);
                }
            }
            if(empty) i.remove();
            else{
                ICustodianDocItemSearchResult[] newArray = new ICustodianDocItemSearchResult[newArr.size()];
                ob.setCustodianDocItems(newArr.toArray(newArray));
            }
        }
    }
}
