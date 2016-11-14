<cfcomponent name="utilities" output="NO" displayname="utilities">

   <!--- lock name is the name used to wrap file io/data ops --->
	<cfset LOCK_NAME = "util_cfc">

	<!--- Constructor --->
	<cfset init()>
	
	<!--- Initialize datasources --->
	<cfset instance.projdsn = "pms">
   <!--------------------------- 
     Initialize the component 
	 --------------------------->
   <cffunction name="init" output="true" returnType="boolean" access="public"
				hint="Handles initialization.">
	      <cfset instance.initialized = true>
	      <cfreturn instance.initialized />
   </cffunction>	
   
 <!----------------------------------- 
    Get State Information
   ----------------------------------->  
  <cffunction name="getStates" returntype="query"
              access="Public" displayname="getStates" 
			  hint="This function retrieves state name and abbr.">
		
		<cfargument name="stateID" required="NO" type="string">		
		  
		<CFQUERY NAME="getstate" DATASOURCE="#instance.projdsn#">
			SELECT CodeValue as StateAbbr, CodeDesc as StateDesc
			FROM Lookup
			Where Codegroup = 'STATES'
			<cfif IsDefined("arguments.StateID")>
			  WHERE codeGroup = '#arguments.StateID#'
			</cfif>
			order By Codevalue
	   </CFQUERY>			  
  
    <cfreturn getstate />
  </cffunction>
  
  <!----------------------------- 
     Get User Information 
	---------------------------->
  <cffunction name="getUser" returntype="query"
              access="Public" displayname="getUser" 
			  hint="This function retrieves user info">
		
		<cfargument name="userID" required="NO" type="numeric">		
		  
		<cfquery name="getuser" datasource="HourDay">
			SELECT *
			FROM user_id
			<cfif isDefined("arguments.userid")>
			 WHERE rowid = #arguments.userID#
			</cfif>
			ORDER BY last_name, first_name
		</cfquery>			  
  
    <cfreturn getUser />
  </cffunction>
  
  <!-----------------------------
     Get Pharmakon Company Info 
	----------------------------->
  <cffunction name="getCompany" returntype="query" access="public">
     <cfargument name="companyCode" required="NO" type="String">
     
		<cfquery name="getcompany" datasource="#instance.projdsn#">
			SELECT * 
			FROM corp
			<cfif IsDefined("arguments.companyCode")>
			 Where  Corp_ID = #Arguments.CompanyCode#
			</cfif>
			ORDER BY corp_value
		</cfquery>
		
		<cfreturn getCompany />
  </cffunction>
   
    <!-----------------------------
     Get Pharmakon Company Info 
	----------------------------->
  <cffunction name="getCompanyClients" returntype="query" access="Public">
     <cfargument name="companyCode" required="NO">
     
		<cfquery name="getcompanyClients" datasource="#instance.projdsn#">
			SELECT Distinct client_abbrev, C.client_name
			FROM client_proj CP, Clients C
			Where SubString(CP.client_Code, 2, 2) = C.client_abbrev
			<cfif IsDefined("Arguments.CompanyCode")>
		    AND  Left(Client_code, 1) = '#Arguments.CompanyCode#'
			</cfif>
			ORDER BY Client_Name, Client_abbrev
		</cfquery>
		
		<cfreturn getcompanyClients />
  </cffunction>
  
   <cffunction name="getClients" returntype="query" access="Public">
     <cfargument name="companyCode" required="NO">
		<cfquery name="getClientsInfo" datasource="#instance.projdsn#">
			SELECT C.client_abbrev, C.client_name
			FROM Clients C
			Where Status = 1
			ORDER BY Client_Name, Client_abbrev
		</cfquery>
		
		<cfreturn getClientsInfo />
  </cffunction>
  
  <!-----------------------------
     Get Project Status Codes
	----------------------------->
  <cffunction name="getProjStatusCodes" returntype="query" access="Public">
      <cfargument name="StatusID" type="numeric" required="NO">  
		<cfset var getprojstat = "">
		<cfquery name="getprojstat" datasource="#instance.projdsn#">
		<!---cachedwithin="#CreateTimeSpan(0,0,20,0)#">--->
			Select *
			From Lookup
			Where CodeGroup = 'PROJECTSTATUS'
			<cfif IsDefined("arguments.StatusID")>
			  AND CodeValue = '#arguments.StatusID#'
			</cfif>
			Order by Ranking, CodeValue
		</cfquery>
		
		<cfreturn getprojstat />
  </cffunction>
  
  <!-----------------------------
     Get products by Client
	----------------------------->
  <cffunction name="getClientProducts" returntype="query" access="Public">
     <cfargument name="ClientCode" required="NO">
        
		<cfset var getprod = "">
		<cfquery name="getProd" datasource="#instance.projdsn#">
			Select *
			From products
			Where Client_Abbrev = '#arguments.ClientCode#'
			Order By product_description
		</cfquery>
		
		<cfreturn getProd />
  </cffunction>
      <!----------------------------- 
      Check that the Stored Procedure exists
	  : This Function will look up to make sure it exists
   -----------------------------> 
  <cffunction name="CheckProcedure" access="Public" returntype="boolean">
	    <cfargument name="StoredProc" type="string" required="yes">
		<cfargument name="Datasource" type="string" required="yes">
		
		
	    <cfquery name="GetStoredProc" datasource="#arguments.datasource#">
	      select * 
		  from dbo.sysobjects 
		  where id = object_id(N'[dbo].[#Arguments.StoredProc#]') 
		  and OBJECTPROPERTY(id, N'IsProcedure') = 1
		</cfquery>
		
		<cfif getStoredProc.recordcount GT 0>
		   <cfset SPValid = true>
		<cfelse>
		   <cfset SPValid = false>
		</cfif>
	    <cfreturn SPValid />
  </cffunction>
  
  <cffunction name="CleanString" access="Public" returntype="String">
    <cfargument name="StringToClean" type="string" required="yes">
	<cfargument name="AllowList" type="string" required="no">
	  <cfset var str = arguments.StringToClean>  
	  <cfset var excludelist = "~,`,!,@,##,$,%,^,&,*,(,),-,_,=,+,{,},[,],\,|,;,:,',?,/,.,>,<,#chr(32)#,#chr(34)#,#chr(44)#,#chr(145)#,#chr(146)#,#chr(147)#,#chr(148)#">
	  <cfset var allowtmp = arguments.AllowList>
	  <cfset var allowString = ListToArray(allowtmp)>
	  <cfoutput>
	  <cfif isDefined("Arguments.AllowList")>
		  <cfset allowList = Arguments.AllowList>
		  <cfif ArrayLen(allowString) GT 1>
			  <cfloop index="x" from="1" to="#ArrayLen(AllowString)#">
			     <cfset excludelist = ListDeleteAt(excludelist, ListFindnocase(excludelist, allowString[x], ","),",")>
			  </cfloop>
		  <cfelse>
		     <cfset excludelist = ListDeleteAt(excludelist, ListFindnocase(excludelist, allowtmp, ","),",")>
		  </cfif>
	  </cfif> 
	  </cfoutput>
	  <cfset CleanString = REReplace(str, "[^[:print:]]", "", "ALL")>
	  <cfset CleanString = ReplaceList(CleanString, ExcludeList, "")>
	
	<cfreturn CleanString />
  </cffunction>
</cfcomponent>