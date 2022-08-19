/*
 * Copyright Integro Technologies Pte Ltd
 * $HeadURL: https://svn.integrosys.com/projects/vbclos/trunk/src/com/integrosys/sml/los/host/CMS/manager/SystemInterfaceManagerImpl.java $
 */
package com.integrosys.sml.los.host.CMS.manager;

import java.io.File;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

import com.integrosys.base.techinfra.propertyfile.PropertyManager;
import org.apache.log4j.LogManager;
import org.apache.log4j.rolling.RollingFileAppender;

import com.integrosys.base.hs.techinfra.support.context.BeanHouse;
import com.integrosys.base.techinfra.logger.DefaultLogger;
import com.integrosys.base.techinfra.util.DateUtil;
import com.integrosys.base.techinfra.util.StringUtils;
import com.integrosys.cms.host.eai.acknowledgement.bus.FacilityList;
import com.integrosys.sml.app.customer.ICustomer;
import com.integrosys.sml.app.customer.ICustomerBO;
import com.integrosys.sml.app.customer.exception.CustomerNotFoundException;
import com.integrosys.sml.app.facility.vo.OBFacility;
import com.integrosys.sml.app.financialpackage.IFinancialPackage;
import com.integrosys.sml.app.financialpackage.IFinancialPackageBO;
import com.integrosys.sml.app.financialpackage.IFinancialPackageMin;
import com.integrosys.sml.app.financialpackage.vo.OBCADownload;
import com.integrosys.sml.app.financialpackage.vo.OBFinancialPackage;
import com.integrosys.sml.app.user.ILoginUser;
import com.integrosys.sml.app.variation.vo.CASearchVariationResult;
import com.integrosys.sml.los.app.common.ILOSConstant;
import com.integrosys.sml.los.app.common.ILOSConstant.STPStatus;
import com.integrosys.sml.los.common.exception.BusinessException;
import com.integrosys.sml.los.host.CMS.ICADownloadDAO;
import com.integrosys.sml.los.host.CMS.ILOStoCMSConstant;
import com.integrosys.sml.los.host.CMS.ISystemInterfaceDAO;
import com.integrosys.sml.los.host.CMS.bus.LOSCreditApplication;
import com.integrosys.sml.los.host.CMS.exception.NotFoundException;
import com.integrosys.sml.los.host.base.helper.TimeOutException;
import com.integrosys.sml.ui.los.financialpackage.FinancialPackageHelper;
import com.integrosys.sml.ui.los.variation.CaSearchVariationCriteria;

/**
 * Describe this class
 * Purpose: 
 * Description:
 *
 * @author $Author: thang.pham $
 * @version $Revision: 19019 $
 * @since $Date: 2022-03-28 11:33:53 +0700 (Mon, 28 Mar 2022) $
 * Tag : $Name$
 */
public class SystemInterfaceManagerImpl implements ISystemInterfaceManager {
	
    private static final String CAR_NUMBER_SEPARATOR = "/";
	private static final String MIGRATION_INDICATOR = "9";
	
	private ICustomerBO customerBO;	
	private IFinancialPackageBO financialPackageBO;
	
    private ICADownloadDAO caDownloadDAO;    
    private ISystemInterfaceDAO systemInterfaceDAO;
    private ICMSMessageManager messageManager;

    public void setCustomerBO(ICustomerBO customerBO) {
        this.customerBO = customerBO;
    }

    public void setFinancialPackageBO(IFinancialPackageBO financialPackageBO) {
        this.financialPackageBO = financialPackageBO;
    }

    public void setCaDownloadDAO(ICADownloadDAO caDownloadDAO) {
        this.caDownloadDAO = caDownloadDAO;
    }

    public void setSystemInterfaceDAO(ISystemInterfaceDAO systemInterfaceDAO) {
        this.systemInterfaceDAO = systemInterfaceDAO;
    }

    public void setMessageManager(ICMSMessageManager messageManager) {
        this.messageManager = messageManager;
    }

    public void updateStatusAfterSendingToCMS() {

    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void finishSTPProcess(String appRefNo, Vector facilities) throws Exception {

        DefaultLogger.debug(this, "An Message was recieved from CMS CA Number: " + appRefNo);

        Set integrationStatusSet = new HashSet();
        String integrationStatus1 = "";
        try {

            Long fpId = (Long) financialPackageBO.getFinancialPackageIdByCaNoModified(appRefNo);
            if (fpId == null) {
                DefaultLogger.debug(this, "No Such application associate with CA Number: " + appRefNo);
                throw new Exception("No Such application associate with CA Number  " + appRefNo);
            }

			IFinancialPackage financialPackage = 
			    (IFinancialPackage) financialPackageBO.getFinancialPackageWithoutSubList(fpId);
			
            // check whether the application STP sucessfull
            if (financialPackage != null && 
                !ILOSConstant.STPStatus.INTEGRATION_STATUS1_STP_SUCCESSFUL.equalsIgnoreCase(
                    financialPackage.getIntegrationStatus1())) {

                if (facilities != null && facilities.size() > 0) {
                    for (Iterator iter = facilities.iterator(); iter.hasNext();) {
                        FacilityList facilityTemp = (FacilityList) iter.next();

                        // add facility status
                        integrationStatusSet.add(facilityTemp.getFacilityStatus());
                    }
                }	
	
                // update integration status
                if (integrationStatusSet.contains(ILOSConstant.STPFacilityStatus.CMS_FACILTY_APPROVED)) {
                    integrationStatus1 = ILOSConstant.STPStatus.INTEGRATION_STATUS1_STP_SUCCESSFUL;
                } else if (integrationStatusSet.contains(ILOSConstant.STPFacilityStatus.CMS_FACILTY_CANCELLED)) {
                    integrationStatus1 = ILOSConstant.STPStatus.INTEGRATION_STATUS1_CANCELLED;
                } else if (integrationStatusSet.contains(ILOSConstant.STPFacilityStatus.CMS_FACILITY_REJECTED)) {
                    integrationStatus1 = ILOSConstant.STPStatus.INTEGRATION_STATUS1_REJECTED;
                } else {
                    integrationStatus1 = ILOSConstant.STPStatus.INTEGRATION_STATUS1_STP_SUCCESSFUL;
                }
				
                if (integrationStatus1 != null && !"".equalsIgnoreCase(integrationStatus1)) {
                    financialPackage.setIntegrationStatus1(integrationStatus1);
                    financialPackage.setIntegrationDate1(new Date());
                    financialPackage.setIntegrationStatus1ResultDesc(null);
                    financialPackageBO.updateFinancialPackage(financialPackage, false, false);
                }
			}	
        } catch (Exception e) {
            DefaultLogger.debug(this, e);
            throw e;
        }
		
        DefaultLogger.debug(this, 
            "Finish process AC002 Sucessfully for CA Number: " + appRefNo + " STP Status is: " + integrationStatus1);
	}
	
    public OBFacility getParentFacilityById(Long facilityId) throws Exception {
        return new OBFacility();
    }
	
    public OBFinancialPackage getApplicationDetailsForSTP(Long applicationId) throws Exception {
        IFinancialPackageBO financialPackageBO = (IFinancialPackageBO) BeanHouse.get("financialPackageBO");
        
        return (OBFinancialPackage) financialPackageBO.getFinancialPackageWithoutSubList(applicationId);
    }

    public String fireSTPStatusByStage(Long applicationId, String stage) throws Exception {
        IFinancialPackage ob = (IFinancialPackage) financialPackageBO.getFinancialPackageWithoutSubList(applicationId);

        Date current = new Date();
        String stpStep = "";

        if (ILOStoCMSConstant.STP_FIRE_STAGE_POST_APPROVAL.equalsIgnoreCase(stage)) {
            stpStep = ILOStoCMSConstant.MESSAGE_AA;
        }

        ob.setIntegrationStatus1(STPStatus.INTEGRATION_STATUS1_INITIAL);
        ob.setIntegrationDate1(current);
        ob.setIntegrationStatus3(stpStep);
        ob.setIntegrationDate3(current);
        ob.setIntegrationStatus1ResultDesc("");

        ob.setIntegrationHost1(getIntegrationHost());

        financialPackageBO.updateFinancialPackage(ob, false, false);

        return "";
    }

    public List<IFinancialPackageMin> getSTPInitialApplicationList(String integrationHost) throws Exception {
        return getSTPInitialApplicationList(false, integrationHost);
    }

    public List<IFinancialPackageMin> getSTPInitialApplicationList(boolean isLocalOnly, String integrationHost) 
        throws Exception 
    {
        return systemInterfaceDAO.findApplicationBasedOnIntegrationStatus(
            isLocalOnly, InetAddress.getLocalHost().getHostName(), integrationHost);
    }

    public void sendSTP(LOSCreditApplication losCreditApplication) throws Exception {
        ICMSMessageManager messageManager = CMSMessageManagerFactory.createCMSMessageManager();
        messageManager.callBackUploadCreditApplication(losCreditApplication);

        // only update status if the message sent to CMS successfully
        if (losCreditApplication.isStpMessageFiringCompletionIndicator()) {
            // update the integration status (3) when finished each message
            OBFinancialPackage obApp = losCreditApplication.getFinancialPackage();

            IFinancialPackage app = financialPackageBO.getFinancialPackageWithoutSubList(obApp.getId());

            app.setIntegrationStatus3(losCreditApplication.getStpMessageFiringIndicator());
            financialPackageBO.updateFinancialPackage(app, false, false);
        }
    }

    public void updateSTPStatus(Long caId, String status) throws Exception {
        if(caId != null && caId.longValue() > 0) {
            financialPackageBO.updateSTPStatus(caId, status, getIntegrationHost());
        }
    }
	
    public void updateSTPStatus(Long caId, String status, String description) {
        if(caId != null && caId.longValue() > 0) {
            financialPackageBO.updateSTPStatus(caId, status, description, getIntegrationHost());
        }
    }

    public void updateSTPStatus(Long caId, String status, String messageId, String description) {
        if(caId != null && caId.longValue() > 0) {
            financialPackageBO.updateSTPStatus(caId, status, messageId, description, getIntegrationHost());
        }
    }

    public void recordFirstSTPStatus(Long caId, String status, String description) {
        if(caId != null && caId.longValue() > 0) {
            financialPackageBO.recordFirstSTPStatus(caId, status, description, getIntegrationHost());
        }
    }

    @Deprecated
    public void recordFirstSTPStatus(Long caId, String status, String messageId, String description) throws Exception {
        IFinancialPackage ob = (IFinancialPackage) financialPackageBO.getFinancialPackageWithoutSubList(caId);

        ob.setIntegrationStatus4(status);
        ob.setIntegrationDate4(DateUtil.getDate());
        ob.setIntegrationStatus4ResultDesc(messageId);
        ob.setIntegrationHost4(getIntegrationHost());
        
        financialPackageBO.updateFinancialPackage(ob, false, false);
    }
	
    public void recordSTPCMSIdDownloadStatus(Long caId, String status, String description) {
        if(caId != null && caId.longValue() > 0) {
            financialPackageBO.recordSTPCMSIdDownloadStatus(caId, status, description);
        }
    }
	
    public ICustomer getCustomer(long idCustomer) throws CustomerNotFoundException {
        try {
            DefaultLogger.debug(this, "[getCustomer] idCustomer = " + idCustomer);
            return customerBO.getCustomer(idCustomer, false);
        } catch (CustomerNotFoundException cnfe) {
            throw cnfe;
        }
    }
	
    @SuppressWarnings({ "rawtypes" })
    public List searchVariation(CaSearchVariationCriteria searchCriteria) throws Exception {
        List<CASearchVariationResult> listAA = null;
        List<CASearchVariationResult> returnAAs = new ArrayList<CASearchVariationResult>();

        try {
            ICMSMessageManager messageManager = CMSMessageManagerFactory.createCMSMessageManager();
            listAA = messageManager.searchVariation(searchCriteria);

            if (listAA != null && !listAA.isEmpty()) {
                for (int i = 0; i < listAA.size(); i++) {
                    CASearchVariationResult caSearchVariationResult = (CASearchVariationResult) listAA.get(i);
    
                    if (caSearchVariationResult.getLosAaNumber() != null) {
                        if (!caSearchVariationResult.getLosAaNumber().startsWith("FEA")) {
                            returnAAs.add(caSearchVariationResult);
                        }
                    }
                }
                returnAAs = listAA;
            }
        } catch (TimeOutException to) {
            throw new BusinessException(to.getMessage(), to.getMessage());
        } catch (NotFoundException ne) {
            throw ne;
        } catch (Exception e) {
            throw e;
        }
        
        return returnAAs;
    }
	
    public List<CASearchVariationResult> fillAvailabilityOfVariationResult(
        List<CASearchVariationResult> variationResults, ICustomer customer, String appRequestType) throws Exception
    {
    	boolean isVariationAllowed;
    	
        if (variationResults == null) {
            variationResults = new ArrayList<CASearchVariationResult>();
        }

        for (CASearchVariationResult variationResult : variationResults) {

            boolean isMigratedCAR = isMigratedCAR(variationResult);

            if (variationResult != null && variationResult.getLosAaNumber() != null && isMigratedCAR) {
                variationResult.setAvailability(ILOStoCMSConstant.FLAG_YES);
            } else if (variationResult != null && variationResult.getLosAaNumber() != null && !isMigratedCAR) {

                String availability = financialPackageBO.getApplicationAvailabilityByCARNo(variationResult.getLosAaNumber());
                if(ILOStoCMSConstant.FLAG_YES.equals(availability)){
                    boolean normalizationFullcancel = 
                        financialPackageBO.checkNormalizationFullCancel(
                            variationResult.getLosAaNumber(), variationResult.getHostCifNo());
                    if (normalizationFullcancel) {
                        availability = ILOStoCMSConstant.FLAG_NO;
                    }
                }
                variationResult.setAvailability(availability);
            }
    		
            if (ILOStoCMSConstant.FLAG_YES.equals(variationResult.getAvailability())) {
                isVariationAllowed = isVariationInLOSAllowed(variationResult, customer, appRequestType, isMigratedCAR);
                variationResult.setAvailability(
                    isVariationAllowed ? ILOStoCMSConstant.FLAG_YES : ILOStoCMSConstant.FLAG_NO);
            }

        }

        return variationResults;
    }
    
    /**
     * This method will check if multiple variation is allowed for this CAR
     * @param variationResult The CAR variation item result from CLIMS.
     * @param appRequestType The CAR application request type.
     * @param isMigratedCAR true if CAR is migrated case; false, otherwise.
     * 
     * @return true if allowed to do the variation; false, otherwise.
     */
    private boolean isVariationInLOSAllowed(
        CASearchVariationResult variationResult, ICustomer customer, String appRequestType, boolean isMigratedCAR)
    {
        if (FinancialPackageHelper.isMultipleCarIndicatorAllowedPerCustomer()) {
            if (isMigratedCAR) {
                return !(financialPackageBO.checkIfAlreadyVARCarInPendingStatusExistForMigration(
                    customer.getId(), variationResult.getLosAaNumber()));
            } else if (!isMigratedCAR) {
                return !(financialPackageBO.checkIfAlreadyVARCarInPendingStatusExist(
                    customer.getId(), variationResult.getLosAaNumber(), appRequestType));
            }
        }

        return true;
    }
    
    /**
     * convenience method to check if the CAR listed
     * is a migrated CAR or not by parsing the CA Number
     * CAR/XX/XXXX/XXXXX/9XXXXXX-YYY
     * @param variationResult
     * @return
     */
    private boolean isMigratedCAR(CASearchVariationResult variationResult) {
        if (variationResult.getLosAaNumber() != null) {
            if (variationResult.getLosAaNumber().contains("-")) {
                String[] referenceNumbers = variationResult.getLosAaNumber().split(CAR_NUMBER_SEPARATOR);

                if (referenceNumbers[4].startsWith(MIGRATION_INDICATOR)) {
                    return true;
                }
            } else {
                String[] referenceNumbers = variationResult.getLosAaNumber().split(CAR_NUMBER_SEPARATOR);

                if (referenceNumbers[2].startsWith(MIGRATION_INDICATOR)) {
                    return true;
                }
            }
        }

        return false;
    }
    
    public boolean isVariationWithNegativeEndStates(Long carId) throws Exception {
        if (carId != null) {
            try {
                return financialPackageBO.isVariationWithNegativeEndStates(carId);
            } catch (Exception e) {
                DefaultLogger.debug(this, e);
            }
        }

        return false;
    }
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public HashMap receiveAADetailfromCMS(CaSearchVariationCriteria searchCriteria, ICustomer customer)
        throws Exception {
        return receiveAADetailFromCMS(searchCriteria);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public HashMap receiveAADetailFromCMS(CaSearchVariationCriteria searchCriteria) throws Exception {
        DefaultLogger.debug(this, "receiveAADetailfromCMS START");

        HashMap dataMap = new HashMap();
        try {
            ICMSMessageManager messageManager = CMSMessageManagerFactory.createCMSMessageManager();
            Map dataReceived = messageManager.findApplicationDetail(searchCriteria);

            String hostCifNo = (String) dataReceived.get(ILOStoCMSConstant.DownloadAA.MAIN_APPLICANT_HOSTCIFNO);
            OBFinancialPackage obFinancialPackage = (OBFinancialPackage) dataReceived
                    .get(ILOStoCMSConstant.DownloadAA.APPLICATION_OB);

            dataMap.put("financialPackageObj", obFinancialPackage);
            dataMap.put("dataReceived", dataReceived);
            dataMap.put("mainHostCifNo", hostCifNo);

        } catch (TimeOutException timeOut) {
            DefaultLogger.error(this, "receiveAADetailfromCMS " + timeOut);
            throw new BusinessException(timeOut.getMessage(), timeOut.getMessage());
        } catch (Exception e) {
            DefaultLogger.error(this, "receiveAADetailfromCMS " + e);
            e.printStackTrace();
            throw e;
        }
        DefaultLogger.debug(this, "receiveAADetailfromCMS FIN ");
        return dataMap;
    }

    public HashMap receiveAndSaveAADetailFromCMS(String losAANumber, long customerId) throws Exception {
        HashMap dataMap = getAADetailsFromCMSByAANumber(losAANumber);
        insertCADownload(dataMap, customerId);

        return dataMap;
    }

    public HashMap receiveAndSaveAADetailWithFacilityFromCMS(String losAANumber, long customerId) throws Exception {
        HashMap dataMap = getAADetailsWithFacilityFromCMSByAANumber(losAANumber);
        insertCADownload(dataMap, customerId);

        return dataMap;
    }

    private HashMap getAADetailsFromCMSByAANumber(String losAANumber) throws Exception {
        CaSearchVariationCriteria searchCriteria = new CaSearchVariationCriteria();
        searchCriteria.setAaSource("CLOS");
        searchCriteria.setLosAANo(losAANumber);
        searchCriteria.setIsFacilityIncluded(false);

        return receiveAADetailFromCMS(searchCriteria);
    }

    private HashMap getAADetailsWithFacilityFromCMSByAANumber(String losAANumber) throws Exception {
        CaSearchVariationCriteria searchCriteria = new CaSearchVariationCriteria();
        searchCriteria.setAaSource("CLOS");
        searchCriteria.setLosAANo(losAANumber);
        searchCriteria.setIsFacilityIncluded(true);

        return receiveAADetailFromCMS(searchCriteria);
    }

    private void insertCADownload(HashMap dataMap, long customerId) throws Exception {
        HashMap dataReceived = (HashMap) dataMap.get("dataReceived");

        List facilityDownloadList = new ArrayList();
        List covenantDownloadList = new ArrayList();

        List cmsFacilityList = (List) dataReceived.get(ILOStoCMSConstant.DownloadAA.FACILITY_LIST);
        facilityDownloadList.add(cmsFacilityList);

        if (!facilityDownloadList.isEmpty()) {
            dataReceived.put(ILOStoCMSConstant.DownloadAA.FACILITY_DOWNLOAD_LIST, facilityDownloadList);
        }

        if (!covenantDownloadList.isEmpty()) {
            dataReceived.put(ILOStoCMSConstant.DownloadAA.COVENANT_DOWNLOAD_LIST, covenantDownloadList);
        }

        OBCADownload obCADownload = new OBCADownload();
        obCADownload.setId(customerId);

        IFinancialPackage financialPackageObj = (IFinancialPackage) dataMap.get("financialPackageObj");
        if (financialPackageObj != null && financialPackageObj.getOldLOSAANumber() != null) {
            obCADownload.setLosAANo(financialPackageObj.getOldLOSAANumber());
        }

        obCADownload.setCreateBy(new Long(99999));
        obCADownload.setCreateDate(new Date());
        obCADownload.setStatus("ACTIVE");

        insertCADownload(obCADownload, dataReceived); // Save AA info received from CMS to blob field in database
    }

    @SuppressWarnings("rawtypes")
    public void insertCADownload(OBCADownload obCADownload, HashMap dataReceived) throws Exception {
        caDownloadDAO.insertCADownload(obCADownload, dataReceived);
    }

    public void deleteCADownloadInfo(ICustomer customer) throws Exception {
        caDownloadDAO.deleteCADownload(customer.getId(), customer.getLosAANo());
    }

    @SuppressWarnings("rawtypes")
    public Map getCADownloadInfo(ICustomer customer) throws Exception {
        return (Map) caDownloadDAO.getContentByCaIdLosAANo(customer.getId(), customer.getLosAANo());
    }

    public String refireSTP(OBFinancialPackage obfp) throws Exception {

        OBFinancialPackage serverSideOB = getApplicationDetailsForSTP(obfp.getId());

        if (serverSideOB != null && serverSideOB.getId() > 0) {
            serverSideOB.setIntegrationStatus1(obfp.getIntegrationStatus1());
            serverSideOB.setIntegrationStatus3(obfp.getIntegrationStatus3());

            financialPackageBO.updateFinancialPackage(serverSideOB, false, false);

            return "1";
        } else {
            return "0";
        }
    }

    public Long getCaIdStpCandidateByIntegrationHostOwner(String integrationHost) {
        return financialPackageBO.getCaIdStpCandidateByIntegrationHostOwner(integrationHost);
    }

    @Deprecated
    public int updateIntegrationHost(
        String integrationHost, String cmsUrl, int maxApplicationCount, int minFacCountInCar, int maxFacCountInCar)
    {
        int count = 0;
        
        List<IFinancialPackageMin> carList = 
            systemInterfaceDAO.findCandidateApplication(maxApplicationCount, minFacCountInCar, maxFacCountInCar);
        if (carList != null && !carList.isEmpty()) {
            for (IFinancialPackageMin fpMin : carList) {
                count += financialPackageBO.updateIntegrationHost(fpMin, integrationHost, cmsUrl);
            }
        }

        return count;
    }

    public Long updateIntegrationHostAndReturnCaIdCandidate(String integrationHost,
                                                            String cmsUrl,
                                                            int minNumOfFacilitiesInCar,
                                                            int maxNumOfFacilitiesInCar) {
        Long caId = null;
        try {
            int affectedRows = financialPackageBO.updateIntegrationHost(integrationHost, cmsUrl,
                    minNumOfFacilitiesInCar, maxNumOfFacilitiesInCar);
//CHANGE HERE
            boolean isPickupSuperCarOnly = PropertyManager.getBoolean("pick.up.stp.super.car.only", true);
            //Cases when all super cars are already processed, will grab regular car instead set isPickupSuperCarOnly = false
            if(!isPickupSuperCarOnly && minNumOfFacilitiesInCar > 0  && affectedRows == 0) {
                financialPackageBO.updateIntegrationHost(integrationHost, cmsUrl,
                        0, (minNumOfFacilitiesInCar - 1));
            }
            caId = financialPackageBO.getCaIdStpCandidateByIntegrationHostOwner(integrationHost);

        } catch (Exception ex) {
            DefaultLogger.error(this, "Error encountered upon owning a CAR for STP..");
            ex.printStackTrace();
        }
        return caId;
    }

    public int releaseIntegrationHost(String integrationHost) {
        return financialPackageBO.releaseIntegrationHost(integrationHost);
    }
    
    public void saveCollateralFacility(ICustomer customer, IFinancialPackage financialPackage, ILoginUser loginUser)
        throws Exception
    {
        financialPackage = updateDownloadCmsFacilityCollateralIntegrationStatus(
                financialPackage,
                ILOSConstant.DownloadStatus.INTEGRATION_STATUS2_SAVE_COL_FAC_QUEUED);

        receiveAndSaveAADetailWithFacilityFromCMS(customer.getLosAANo(), customer.getId());

        @SuppressWarnings("rawtypes")
        Map dataReceivedMap = this.getCADownloadInfo(customer);
        if (dataReceivedMap != null) {
            messageManager.saveCollateralFacility(customer, financialPackage, loginUser, dataReceivedMap);
        }

        updateDownloadCmsFacilityCollateralIntegrationStatus(
                financialPackage,
                ILOSConstant.DownloadStatus.INTEGRATION_STATUS2_SAVE_COL_FAC_MAPPING);
    }
    
    public String getServerProfileName() throws Exception {
        try {
            File logFile = new File(
                ((RollingFileAppender) LogManager.getRootLogger().getAppender("appFileAppender")).getFile());
            if (logFile != null && !StringUtils.isEmpty(logFile.getAbsolutePath())) {
                String serverPath = 
                    logFile.getAbsolutePath().substring(0, logFile.getAbsolutePath().indexOf(logFile.getPath()));
                
                String delimitor = serverPath.charAt(serverPath.length() - 1) + "";
                if ("\\".equals(delimitor)) {
                    delimitor = "\\\\";
                }
                String[] serverPathArray = serverPath.split(delimitor);
                
                return serverPathArray[serverPathArray.length - 1];
            }

            return null;
        } catch (Exception e) {
            throw e;
        }
    }
    
    public String getIntegrationHost() {
        try {
            InetAddress localInetAddress = InetAddress.getLocalHost();            
            String serverIpAddress = localInetAddress.getHostAddress();
            String serverHostName = localInetAddress.getHostName();
            String serverProfileName = this.getServerProfileName();
            
            if (StringUtils.isEmpty(serverProfileName)) {
                return serverIpAddress + ":" + serverHostName;
            } else {
                return serverIpAddress + ":" + serverHostName + "-" + serverProfileName;
            }
        } catch (Exception e) {
            DefaultLogger.warn(this,e);
        }
        
        return "";
    }

    public boolean havePendingCarFlowToCms(String carNumber) {
    	return financialPackageBO.havePendingCarFlowToCms(carNumber);
    }

    public int updateDownloadCmsFacilityCollateralIntegrationHost (
            String integrationHost, String cmsUrl, int maxApplicationCount, int minFacCountInCar, int maxFacCountInCar)
    {
        int count = 0;

        List<IFinancialPackageMin> carList =
                systemInterfaceDAO.findCandidateApplicationForDownloadCmsFacilityCollateral(maxApplicationCount, minFacCountInCar, maxFacCountInCar);
        if (carList != null && !carList.isEmpty()) {
            for (IFinancialPackageMin fpMin : carList) {
                count += financialPackageBO.updateDownloadCmsFacilityCollateralIntegrationHost(fpMin, integrationHost, cmsUrl);
            }
        }

        return count;
    }

    public int releaseDownloadCmsFacilityCollateralIntegrationHost(String integrationHost) {
        return financialPackageBO.releaseDownloadCmsFacilityCollateralIntegrationHost(integrationHost);
    }

    public IFinancialPackage getApplicationForDownloadCmsFacilityCollateral(Long applicationId) throws Exception {
        IFinancialPackage financialPackage = null;
        if(applicationId != null && applicationId.longValue() > 0) {
            IFinancialPackageBO financialPackageBO = (IFinancialPackageBO) BeanHouse.get("financialPackageBO");
            financialPackage = financialPackageBO.getFinancialPackageWithoutSubList(applicationId);
        }
        return financialPackage;
    }

    public List<IFinancialPackageMin> getDownloadCmsFacilityCollateralInitialApplicationList(String integrationHost) throws Exception {
        return getDownloadCmsFacilityCollateralInitialApplicationList(false, integrationHost);
    }

    public List<IFinancialPackageMin> getDownloadCmsFacilityCollateralInitialApplicationList(boolean isLocalOnly, String integrationHost)
            throws Exception
    {
        return systemInterfaceDAO.findApplicationForDownloadCmsFacilityCollateral(
                isLocalOnly, InetAddress.getLocalHost().getHostName(), integrationHost);
    }

    public void updateDownloadCmsFacilityCollateralIntegrationStatus(Long caId, String status) {
        updateDownloadCmsFacilityCollateralIntegrationStatus(caId, status, null);
    }

    public void updateDownloadCmsFacilityCollateralIntegrationStatus(Long caId, String status, String description) {

        if(caId != null && caId.longValue() > 0) {
            financialPackageBO.updateDownloadCmsFacilityCollateralIntegrationStatus(caId, status, description, getIntegrationHost());
        }
    }

    public IFinancialPackage updateDownloadCmsFacilityCollateralIntegrationStatus(IFinancialPackage financialPackage, String status) {

        if(financialPackage != null) {
            return updateDownloadCmsFacilityCollateralIntegrationStatus(financialPackage, status, null);
        }
        return null;
    }

    public IFinancialPackage updateDownloadCmsFacilityCollateralIntegrationStatus(IFinancialPackage financialPackage, String status, String description) {

        if(financialPackage != null) {
            Date now = new Date();
            financialPackage.setIntegrationStatus2(status);
            financialPackage.setIntegrationDate2(now);
            financialPackage.setIntegrationStatus2ResultDesc(description);
            financialPackage.setIntegrationHost1(getIntegrationHost());

            if(ILOSConstant.DownloadStatus.INTEGRATION_STATUS2_SAVE_COL_FAC_INITIATE.equals(status)){
                financialPackage.setIntegrationHost2(null); //CMS instance
                financialPackage.setIntegrationHost5(null); //CLOS instance
            }
            return financialPackageBO.updateFinancialPackage(financialPackage, false, false);
        }
        return null;
    }
}
