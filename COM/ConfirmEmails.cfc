<cfcomponent displayname="WebEvents">
     
   <!--- lock name is the name used to wrap file io/data ops --->
	<cfset LOCK_NAME = "webevents_cfc">

	<!--- Constructor --->
	<cfset init()>
	
	<!--- Initialize datasources --->
	<cfset instance.ProjDsn = "PMS">
	
	<!--- Call the Utilities Component --->
	 <CFOBJECT COMPONENT="pms.com.Utilities"
	        NAME="Utilities">
   <!---------------------------- 
      Initialize the component 
     --------------------------->
			
   <cffunction name="init" output="true" returnType="boolean" access="public"
				hint="Handles initialization.">
	      <cfset instance.initialized = true>
	      <cfreturn instance.initialized />
   </cffunction>
   
   <!---------------------------- 
      Clean Screen Function 
     --------------------------->
   <cffunction name="CleanThisString" access="private" returnType="string">
     <cfargument name="StringToClean" type="string" required="yes">    
	 <cfargument name="AllowChr" type="string" required="no" default="">
	 	
	   <cfset CleanedString = Utilities.CleanString(Arguments.StringToClean, Arguments.AllowChr)>		
	 <cfreturn CleanedString />	
   </cffunction>
   
   <!---------------------------- 
      Get All Confirmations 
     --------------------------->
   <cffunction name="getAllConfirmations" access="public" returnType="query">
     
	 <cfset var allconfirm = "">
	 
	 <cfquery name="allConfirm" datasource="#instance.ProjDsn#">
	    Select *
		From ConfirmationEmail
		Order By ProjectCode, StartDate, ApprovalDate
	 </cfquery>
	 
	 <cfreturn allconfirm />
   </cffunction>
   
   <!---------------------------- 
      Get Confirmations by ConfirmID
     --------------------------->
   <cffunction name="getConfirmations" access="public" returnType="query">
     <cfargument name="confirmID" type="numeric" required="YES">
	 
	 <cfset var confirm = "">
	 
	 <cfquery name="confirm" datasource="#instance.ProjDsn#">
	    Select *
		From ConfirmationEmail
		Where ConfirmID = #Arguments.confirmID#
	 </cfquery>
	 
	 <cfreturn confirm />
   </cffunction>
   
   <!---------------------------- 
      Get Confirmations that are unapproved
     --------------------------->
   <cffunction name="getUnApprovedConfirms" access="public" returnType="query">
     
	 <cfset var unconfirm = "">
	 
	 <cfquery name="unconfirm" datasource="#instance.ProjDsn#">
	    Select C.*,
		  (Select first_name+' '+last_name as name
		     From User_ID
			 Where rowid =  C.CreatedBy) as CreatedByName
		From ConfirmationEmail C
		Where ApprovalDate IS NULL
		Order By C.ProjectCode, C.StartDate, C.ApprovalDate
	 </cfquery>
	 <cfreturn unconfirm />
   </cffunction>
   
   
   <!---------------------------- 
      get Confirmations that are Approved
     --------------------------->
   <cffunction name="getApprovedConfirms" access="public" returnType="query">
     
	 <cfset var confirm = "">
	 
	 <cfquery name="confirm" datasource="#instance.ProjDsn#">
	    Select C.*,
		  (Select First_name+' '+Last_name
		     From User_ID
			 Where rowid = C.ApprovedBy) as ApprovedName
		From ConfirmationEmail C
		Where ApprovalDate IS NOT NULL
		Order By ProjectCode, StartDate, ApprovalDate
	 </cfquery>
	 <cfreturn confirm />
   </cffunction>
   
   <!---------------------------- 
      Get Confirmations by Project Code
     --------------------------->
   <cffunction name="getProjConfirmations" access="public" returnType="query">
     <cfargument name="projectCode" type="string" required="YES">
	 
	 <cfset var projconfirm = "">
	 
	 <cfquery name="projconfirm" datasource="#instance.ProjDsn#">
	    Select *
		From ConfirmationEmail
		Where ProjectCode = '#Arguments.projectCode#'
	 </cfquery>
	 
	 <cfreturn projconfirm />
   </cffunction>
   
   
   <!---------------------------- 
      Insert a new Confirmation in the ConfirmationEmails Table,
	  and return the ID
     --------------------------->
   <cffunction name="InsertConfirm" access="public" returnType="numeric">
     <cfargument name="Title"        type="string" required="YES">
	 <cfargument name="projectCode"  type="string" required="YES">
	 <cfargument name="StartDate"    type="date" required="YES">
	 <cfargument name="EndDate"      type="Date" required="YES">
	 <cfargument name="CreatedBy"    type="numeric" required="YES">
	 
	 <cfset var projinsert = "">
	 
	 <cfquery name="projinsert" datasource="#instance.ProjDsn#">
	    set nocount on;

	    Insert ConfirmationEmail(
		    ConfirmTitle, 
			ProjectCode, 
			StartDate, 
			Enddate, 
			CreatedBy
			)
		Values(
		    '#Arguments.Title#',
			'#Arguments.ProjectCode#',
			#CreateODBCDateTime(Arguments.StartDate)#,
			#CreateODBCDateTime(Arguments.EndDate)#,
			#Arguments.CreatedBy#
		)
		
		select scope_identity() as NewID;
        set nocount off;
	 </cfquery>
	 
	 <cfreturn projinsert.newID /> 
   </cffunction>
   
   <!---------------------------- 
      Update the Confirmation Email
     --------------------------->
   <cffunction name="UpdateEmail" access="public" returnType="void">
     <cfargument name="ConfirmID"    type="Numeric" required="YES">
	 <cfargument name="Title"        type="string"  required="YES">
	 <!--- <cfargument name="projectCode"  type="string"  required="YES"> --->
	 <cfargument name="StartDate"    type="date"    required="YES">
	 <cfargument name="EndDate"      type="Date"    required="YES">
	 <cfargument name="FromEmail"      type="String"  required="YES">
	 <cfargument name="Subject"      type="String"  required="YES">
	 <cfargument name="MsgContent"   type="String"  required="YES">
	 <cfargument name="UpdatedBy"    type="Numeric" required="YES">
	 
	 
	 <cfquery name="projconfirm" datasource="#instance.ProjDsn#">
	    UPDATE ConfirmationEmail
		  SET ConfirmTitle   = '#Arguments.Title#',
			  <!--- ProjectCode    = '#Arguments.ProjectCode#', --->
			  StartDate      = #CreateODBCDateTime(Arguments.StartDate)#, 
			  Enddate        = #CreateODBCDateTime(Arguments.EndDate)#,
			  FromAddress    = '#Arguments.FromEmail#',
			  ConfirmSubject = '#Arguments.Subject#',
			  ConfirmText    = '#Arguments.MsgContent#',
			  UpdatedBy      = #Arguments.UpdatedBy#,
			  LastUpdated	 = #CreateODBCDateTime(Now())#
       WHERE ConfirmID = #Arguments.ConfirmID#
	 </cfquery>
	 
   </cffunction>
   
   <!---------------------------- 
      Update the Approval Code for a Confirmation Email
   --------------------------->  
   <cffunction name="UpdApproval" access="public" returnType="void">
     <cfargument name="ConfirmID" type="numeric" required="YES">
	 <cfargument name="ApprovedBy" type="numeric" required="YES">
	 
	<cfquery name="projconfirm" datasource="#instance.ProjDsn#">
	    UPDATE ConfirmationEmail
		  SET ApprovedBy   = #Arguments.ApprovedBy#,
		      ApprovalDate = #CreateODBCDateTime(Now())#
		WHERE ConfirmID = #Arguments.ConfirmID#	   
	 </cfquery>
	 
   </cffunction>
   
   <!---------------------------- 
      Update the Approval Code for a Confirmation Email to Inactive
   --------------------------->  
   <cffunction name="UpdInActive" access="public" returnType="void">
      <cfargument name="projectCode"  type="string" required="YES">
	  <cfargument name="ConfirmID" type="numeric" required="YES">
	  <cfargument name="UpdatedBY" type="numeric" required="YES">
	  
	 
	<cfquery name="projconfirm" datasource="#instance.ProjDsn#">
	    UPDATE ConfirmationEmail
		  SET ApprovedBy   = NULL,
		      ApprovalDate = NULL,
			  UpdatedBY    = #Arguments.UpdatedBY#,
			  LastUpdated  = #CreateODBCDateTime(Now())#
		WHERE ConfirmID <> #Arguments.ConfirmID#
		AND ProjectCode = '#Arguments.ProjectCode#' 	   
	 </cfquery>
	 
   </cffunction>
   
    <cffunction name="UpdtestEmailSent" access="public" returnType="void">
     <cfargument name="ConfirmID" type="numeric" required="YES">
	 
	<cfquery name="projconfirm" datasource="#instance.ProjDsn#">
	    UPDATE ConfirmationEmail
		  SET TestEmailSent  = #CreateODBCDateTime(Now())#
		WHERE ConfirmID = #Arguments.ConfirmID#	   
	 </cfquery>
	 
   </cffunction>
   
   <!---------------------------- 
      Update the Approval Code for a Confirmation Email to Inactive
   --------------------------->  
   <cffunction name="AddSendLog" access="public" returnType="void">
      <cfargument name="projectCode"  type="string" required="YES">
	  <cfargument name="PHID" type="numeric" required="YES">
	  <cfargument name="ConfirmID" type="numeric" required="YES">
	  
	 
	<cfquery name="projconfirm" datasource="#instance.ProjDsn#">
	    Insert into ConfirmEmailsSent(ProgramID, PHID, CIRowID, DateSent)  
		Values('#arguments.projectCode#', #arguments.Phid#, #arguments.confirmID#, #CreateODBCDateTime(Now())#)
	 </cfquery>
	 
   </cffunction>
   
 </cfcomponent>  
