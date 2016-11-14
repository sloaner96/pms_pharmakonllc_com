<cfcomponent displayname="WebEvents">
     
   <!--- lock name is the name used to wrap file io/data ops --->
	<cfset LOCK_NAME = "webevents_cfc">

	<!--- Constructor --->
	<cfset init()>
	
	<!--- Initialize datasources --->
	<cfset instance.webEventsDsn = "webEvents">
	
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
   
   <cffunction name="errorTrap" access="private" returnType="struct">
     <cfargument name="ErrorStruct" required="YES" type="struct">
	 <cfset Session.Error = Arguments.ErrorStruct>
   </cffunction>
   
   <cffunction name="CleanThisString" access="private" returnType="string">
     <cfargument name="StringToClean" type="string" required="yes">    
	 <cfargument name="AllowChr" type="string" required="no" default="">
	 	
	   <cfset CleanedString = Utilities.CleanString(Arguments.StringToClean, Arguments.AllowChr)>		
	 <cfreturn CleanedString />	
   </cffunction>
   
   <cffunction name="getConfig" returnType="query" access="public">
      <cfargument name="ProgramCode" type="string" required="yes">
	  <cfargument name="UploadType" type="string" required="yes">
	  <cfquery name="GetConfig" datasource="#instance.webEventsDsn#">
	    Select *
		From UploadConfig
		Where programCode = <cfqueryparam value="#Arguments.ProgramCode#" cfsqltype="CF_SQL_VARCHAR" maxlength="25">
		AND UploadType = <cfqueryparam value="#Arguments.UploadType#" cfsqltype="CF_SQL_VARCHAR" maxlength="6">
	  </cfquery> 
	 <cfreturn GetConfig />
   </cffunction>
   
   <cffunction name="excel2Query" returnType="query" access="public">
     <cfargument name="thisFile" required="YES" type="String">
	 <cfargument name="FirstRowISHeader" required="NO" type="boolean" default="false">
	 <cfargument name="SheetName" required="NO" type="String">
	 <cfargument name="SheetNum" required="NO" type="String">
	 <cfargument name="StartRow" required="NO" type="String" default="1">
	 <cfargument name="MaxRow" required="NO" type="String">
	 <cfargument name="LongNames" required="NO" type="boolean" default="true">
	 
     <cfx_excel2query
        file="#Arguments.thisfile#"
        firstRowIsHeader="#Arguments.FirstRowISHeader#"
        startRow="#Arguments.StartRow#"
        longNames="#Arguments.LongNames#"
        r_qResults="ThisOBJ"> 
	  
      <cfreturn thisOBJ />
   </cffunction>
   
   <cffunction name="csv2Query" returnType="query" access="public">
      <cfargument name="thisFile" required="YES" type="String">
	  <cfargument name="FirstRowISHeader" required="YES" type="String">
	  <cfargument name="SheetName" required="YES" type="String">
	  <cfargument name="SheetNum" required="YES" type="String">
	  <cfargument name="StartRow" required="YES" type="String">
	  <cfargument name="MaxRow" required="YES" type="String">
	  <cfargument name="LongNames" required="YES" type="String">
	 
      <cfx_excel2query
        file="#Arguments.thisfile#"
        firstRowIsHeader="#Arguments.FirstRowISHeader#"
        sheet_name="#Arguments.SheetName#"
        sheet_num="#Arguments.SheetNum#"
        startRow="#Arguments.StartRow#"
        maxRows="#Arguments.MaxRow#"
        longNames="#Arguments.LongNames#"
        r_qResults="ThisOBJ"> 
	  
      <cfreturn thisOBJ />
   </cffunction>
   	 
   <cffunction name="CILoad" returnType="boolean" access="public">
     <cfargument name="ProgramCode" required="yes" type="String">
	 <cfargument name="queryobj" required="yes" type="query">
	 
	 <cfset TmpTable = "tmpTab#ProgramCode#1">
	 <cfset dataobj = arguments.queryobj>
	 <cfset CommitIt = true>
	 
	<!---  <cftransaction action="BEGIN">
	   <cftry>  --->
		 <cfloop query="dataobj">
		   <cfquery name="CiLoad" datasource="#instance.webEventsDsn#">
		      Insert INTO #tmpTable#(
			     DateSet,
				 EventKey,
				 EventDateTime,
				 EventDate,
				 EventTime,
				 FirstName,
				 LastName,
				 Degree,
				 OfficePhone,
				 EventPhone,
				 Fax,
				 Email,
				 OfficeAdd1,
				 OfficeAdd2,
				 OfficeCity,
				 OfficeState,
				 OfficeZip,
				 ShipAdd1,
				 ShipAdd2,
				 ShipCity,
				 ShipState,
				 ShipZip,
				 Other_Nom,
				 Rep_Nom,
				 User1,
				 User2,
				 User6,
				 Phid,
				 isdupe,
				 isnewphid
			  )
			  Values(
			     '#dataobj.DateSet#',
				 '#dataobj.eventKey#',
				 '#DateFormat(CreateODBCDate(dataobj.EventDateTime), "mm/dd/yyyy")# #TimeFormat(CreateODBCDateTime(dataobj.EventDateTime), "hh:mm tt")#',
				 '#DateFormat(CreateODBCDate(dataobj.EventDateTime), "mm/dd/yyyy")#',
				 '#TimeFormat(CreateODBCDateTime(dataobj.EventDateTime), "hh:mm tt")#',
				 '#ReReplacenoCase(dataobj.Firstname, "[^[:print:]]", "", "ALL")#',
				 '#ReReplacenoCase(dataobj.Lastname, "[^[:print:]]", "", "ALL")#',
				 '#ReReplacenoCase(dataobj.Degree, "[^[:print:]]", "", "ALL")#',
				 '#ReReplacenoCase(dataobj.OfficePhone, "[^[:print:]]", "", "ALL")#',
				 '#ReReplacenoCase(dataobj.EventPhone, "[^[:print:]]", "", "ALL")#',
				 '#ReReplacenoCase(dataobj.Fax, "[^[:print:]]", "", "ALL")#',
				 '#dataobj.Email#',
				 '#ReReplacenoCase(dataobj.OfficeAdd1, "[^[:print:]]", "", "ALL")#',
				 '#ReReplacenoCase(dataobj.OfficeAdd2, "[^[:print:]]", "", "ALL")#',
				 '#ReReplacenoCase(dataobj.OfficeCity, "[^[:print:]]", "", "ALL")#',
				 '#ReReplacenoCase(dataobj.OfficeState, "[^[:print:]]", "", "ALL")#',
				 '#ReReplacenoCase(dataobj.OfficeZip, "[^[:print:]]", "", "ALL")#',
				 '#ReReplacenoCase(dataobj.ShipAdd1, "[^[:print:]]", "", "ALL")#',
				 '#ReReplacenoCase(dataobj.ShipAdd2, "[^[:print:]]", "", "ALL")#',
				 '#ReReplacenoCase(dataobj.ShipCity, "[^[:print:]]", "", "ALL")#',
				 '#ReReplacenoCase(dataobj.ShipState, "[^[:print:]]", "", "ALL")#',
				 '#ReReplacenoCase(dataobj.ShipZip, "[^[:print:]]", "", "ALL")#',
				 <cfif IsDefined("dataobj.Other_Nom")>'#ReReplacenoCase(dataobj.Other_Nom, "[^[:print:]]", "", "ALL")#'<cfelseif IsDefined("dataobj.OtherNom")>'#ReReplacenoCase(dataobj.OtherNom, "[^[:print:]]", "", "ALL")#'<cfelse>NULL</cfif>,
				 <cfif IsDefined("dataobj.Rep_Nom")>'#ReReplacenoCase(dataobj.Rep_Nom, "[^[:print:]]", "", "ALL")#'<cfelseif IsDefined("dataobj.RepNom")>'#ReReplacenoCase(dataobj.RepNom, "[^[:print:]]", "", "ALL")#'<cfelse>NULL</cfif>,
				 '#ReReplacenoCase(dataobj.user1, "[^[:print:]]", "", "ALL")#',
				 '#ReReplacenoCase(dataobj.User2, "[^[:print:]]", "", "ALL")#',
				 '#ReReplacenoCase(dataobj.User6, "[^[:print:]]", "", "ALL")#',
				 '#ReReplacenoCase(dataobj.Phid, "[^[:print:]]", "", "ALL")#',
				 0,
				 0)
		   </cfquery>
		 </cfloop>
		 <!--- <cfcatch type="any">
		   <cfset CommitIt = false>
		   
		   <cfset Session.Error.Detail = CFCATCH.Detail>
		   <cfif IsDefined("Cfcatch.SqlState")>
		    <cfset Session.Error.SQLError = CFCATCH.SQLState>
		   </cfif>
		   <cfset Session.Error.Diagnostic = CFCATCH.Message>
		   
		 </cfcatch>
	   </cftry>	 
	   
	   <cfif CommitIT>
	     <cftransaction action="Commit" />
	   <cfelse>
	     <cftransaction action="RollBack" />
	   </cfif>
	   
	 </cftransaction> --->
	 <cfreturn CommitIT />
   </cffunction>
   
   <cffunction name="REGLoad" returnType="boolean" access="public">
     <cfreturn true />
   </cffunction>
   
</cfcomponent>