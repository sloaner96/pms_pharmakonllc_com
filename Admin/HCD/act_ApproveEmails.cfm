<!---
    $Id: ,v 1.0 2000/00/00 rsloan Exp $
    Copyright (c) 2005 Pharmakon, LLC.

    Description:
        
    Parameters:
        
    Usage:
        
    Documentation:
        
    Based on:
        
--->
<cfparam name="URL.CID" default="0" type="numeric">


<!--- <cftry> --->
	<cfinvoke component="pms.com.CONFIRMEMAILS" method="UpdApproval">
	  <cfinvokeargument name="ConfirmID" value="#URL.CID#">
	  <cfinvokeargument name="ApprovedBy" value="#Session.UserInfo.RowID#">
	</cfinvoke>
<!---   <cfcatch type="Any">
    <cflocation url="dsp_ApproveEmails.cfm?e=99" addtoken="NO">
  </cfcatch> 
</cftry>--->

<cflocation url="dsp_MaintainEmails.cfm" addtoken="NO">

