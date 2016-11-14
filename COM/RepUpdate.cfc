<cfcomponent displayname="repupdate" output="No">
   
   <!--- lock name is the name used to wrap file io/data ops --->
	<cfset LOCK_NAME = "repupdate_cfc">

	<!--- Constructor --->
	<cfset init()>
	
	<!--- Initialize datasources --->
	<cfset instance.rosterdsn = "CBARoster">
	
	<cfsetting requesttimeout="1000">
   <!---------------------------- 
      Initialize the component 
     --------------------------->
   <cffunction name="init" output="true" returnType="boolean" access="public"
				hint="Handles initialization.">
	      <cfset instance.initialized = true>
	      <cfreturn instance.initialized />
   </cffunction>
     <!----------------------------- 
      Get The Rep Update Config Information
	  : This Function returns the stored procedure that needs to be run 
	    in order to update the correct   
   -----------------------------> 
  <cffunction name="GetAllRepConfig" access="remote" returntype="query">
	
    <cfquery name="GetAllRepConfig" datasource="#instance.rosterdsn#">
	  Select * 
	  From RepUpdateConfig
	  order by processType, LastUpdated, DateAdded
	</cfquery>
	
    <cfreturn GetAllRepConfig />
  </cffunction>
  
  <!----------------------------- 
      Get The Rep Update Config Information
	  : This Function returns the stored procedure that needs to be run 
	    in order to update the correct   
   -----------------------------> 
  <cffunction name="GetRepConfig" access="remote" returntype="string">
    <cfargument name="ProgramCode" type="string" required="yes">
	<cfargument name="UpdateType" type="string" required="yes">
	
    <cfquery name="GetRepConfig" datasource="#instance.rosterdsn#">
	  Select StoredProcTxt 
	  From RepUpdateConfig
	  Where ProgramCode = <cfqueryparam value="#Arguments.ProgramCode#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">
	  And ProcessType = <cfqueryparam value="#Arguments.UpdateType#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">
	  and StoredProcTxt IS NOT NULL
	  
	</cfquery>
	
    <cfreturn GetRepConfig.storedProcTxt />
  </cffunction>
  
    <!----------------------------- 
      Call the Passed Stored Procedure and Update the RepTables 
	  : This Function will return either successful update (true) 
	  or unsuccessful update (false)
   -----------------------------> 
  <cffunction name="UpdateRepTables" access="remote" returntype="boolean">
    <cfargument name="ProgramCode" type="string" required="yes">
	<cfargument name="StoredProc" type="string" required="yes">
	<cfargument name="BeginDate" type="string" required="yes">
	<cfargument name="EndDate" type="string" required="yes">
	<cfargument name="UpdateType" type="string" required="yes">
	
	<cfset success = true>
	<cftry> 
		<cfstoredproc procedure="#Arguments.StoredProc#" datasource="#instance.rosterdsn#">
		   <cfprocparam type="In" cfsqltype="CF_SQL_VARCHAR" 
		        dbvarname="@meetingcode" value="#Arguments.ProgramCode#" 
				maxlength="20" null="No"> 
		   <cfprocparam type="In" cfsqltype="CF_SQL_varchar" 
		        dbvarname="@startdate" value="#Arguments.begindate#" 
				null="No"> 
		   <cfprocparam type="In" cfsqltype="CF_SQL_varchar" 
		        dbvarname="@enddate" value="#Arguments.enddate#" 
				null="No"> 		
		</cfstoredproc>
	    <cfquery name="UpdateProc" datasource="#instance.rosterdsn#">
		  Update RepUpdateConfig
		   Set LastRun = #CreateODBCDateTime(now())# 
		  Where ProgramCode = '#Arguments.ProgramCode#'
		  AND StoredProcTxt = '#Arguments.StoredProc#'
		  AND ProcessType = '#Arguments.UpdateType#'
		</cfquery>
	    <cfcatch type="Database">
		    <cfset success = false>
			<cfset Msg = "Error Occured while running #Arguments.StoredProc#<br>DETAIL:#CFCatch.Detail#<br>NATIVE:#CFCATCH.NativeErrorCode#<br>SQLSATE:#CFCATCH.SQLState#">
			<cf_AuditLog action="REP UPD PROC" message="#Msg#" Status="FAILED" User="0">
		    <cfset Sendmail = SendEmail(Arguments.ProgramCode, Msg)>
		</cfcatch> 
	</cftry>
	<cfset Msg = "#Arguments.StoredProc# Ran Sucessfully">
	<cf_AuditLog action="REP UPD PROC" message="#Msg#" Status="OK" User="0">
    <cfreturn Success />
  </cffunction>
  <cffunction name="SendEmail" access="Private" returntype="Void">
     <cfargument name="ProgramCode" type="string" required="YES">
     <cfargument name="msg" type="string" required="YES">
	 
	 <cfmail from="rsloan@pharmakonllc.com" to="rsloan@pharmakonllc.com" cc="bjurevicius@pharmakonllc.com, sfrohlich@pharmakonllc.com, ajenneges@pharmakonllc.com" subject="Rep Update Failed for #Arguments.ProgramCode#!">
The Rep Update Failed for #Arguments.ProgramCode# with the following error Message.
--------------------
#msg#
	 </cfmail>
  </cffunction>
  
  <cffunction name="Checkdup" access="public" returntype="boolean">
     <cfargument name="ProgramCode" type="string" required="YES">
     <cfargument name="ProgramType" type="string" required="YES">
	 
	 <cfset var checkdupSP = false> 
	 
	  <cfquery name="getdup" datasource="#instance.rosterdsn#">
		  Select StoredProcTxt 
		  From RepUpdateConfig
		  Where ProgramCode = <cfqueryparam value="#Arguments.ProgramCode#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">
		  And ProcessType = <cfqueryparam value="#Arguments.ProgramType#" cfsqltype="CF_SQL_VARCHAR" maxlength="20"> 
	  </cfquery>
	 
	  <cfif getdup.recordcount GT 0>
	    <cfset checkdupSP = true>
	  <cfelse>
	    <cfset checkdupSP = false> 
	  </cfif>
	  
	 <cfreturn checkdupSP />
  </cffunction>
  
  <cffunction name="AddConfig" access="public" returntype="Void">
     <cfargument name="ProgramCode" type="string" required="YES">
     <cfargument name="StoredProc" type="string" required="YES">
	 <cfargument name="ProgramType" type="string" required="YES">
	 <cfargument name="USERID" type="numeric" required="YES">
	 
	 
	  <cfquery name="InsertRec" datasource="#instance.rosterdsn#">
		  Insert into RepUpdateConfig(
		    ProgramCode, 
		    StoredProcTxt, 
			ProcessType, 
			DateAdded, 
			AddedBy
			)
		  Values(
		    '#Arguments.programCode#',
			'#Arguments.StoredProc#',
			'#Arguments.programType#',
			 #CreateODBCDateTime(now())#,
			 #Arguments.userID#
		  )
		</cfquery>
  </cffunction>
  <cffunction name="UpdateConfig" access="public" returntype="Void">
     <cfargument name="ProgramCode" type="string" required="YES">
     <cfargument name="StoredProc" type="string" required="YES">
	 <cfargument name="ConfigID" type="Numeric" required="YES">
	 
	 
	  <cfquery name="UpdRec" datasource="#instance.rosterdsn#">
		  Update RepUpdateConfig
		   Set ProgramCode   = '#Arguments.programCode#',
		       StoredProcTxt = '#Arguments.StoredProc#', 
               LastUpdated   = #CreateODBCDateTime(now())#
		   Where RepConfigID = #Arguments.ConfigID# 

		</cfquery>
  </cffunction>
   <cffunction name="DeleteConfig" access="public" returntype="Void">
     <cfargument name="ConfigID" type="Numeric" required="YES">
	 
	  <cfquery name="DelRec" datasource="#instance.rosterdsn#">
		  Delete From RepUpdateConfig
		  Where RepConfigID = #Arguments.ConfigID#
		</cfquery>
  </cffunction>
  
</cfcomponent>