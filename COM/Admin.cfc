<cfcomponent displayname="admin" output="No">
   
   <!--- lock name is the name used to wrap file io/data ops --->
	<cfset LOCK_NAME = "admin_cfc">

	
	<cfset instance = structNew()>			
	<!--- Initialize datasources --->
	<cfset instance.projdsn = "PMS">
	<cfset instance.rosterdsn = "CBARoster">
	
	<!--- Constructor --->
	<cfset init()>
	
   <!---************************* 
      Initialize the component 
     ************************--->
   <cffunction name="init" output="true" returnType="boolean" access="public"
				hint="Handles initialization.">
	      <cfset instance.initialized = true>
	      <cfreturn instance.initialized />
   </cffunction>
   
   <cffunction name="GetDistinctMtg" returnType="Query" access="public">
       <cfargument name="BeginDate" type="Date" required="Yes" />
	   
	   <cfset var GetMtg = "">
	   <cfquery name="GetMtg" datasource="#instance.rosterdsn#">
	      Select Distinct EventKey
		  From CI_DB
		  Where EventDate >= #CreateODBCDate(Arguments.BeginDate)#
		  and Status <> 'MTG CANCEL'
		  Order By EventKey
	   </cfquery>
	   
	   <cfreturn GetMtg />
   </cffunction>
   
   <cffunction name="GetMtgParticipants" returnType="Query" access="public">
       <cfargument name="EventKey" type="string" required="Yes" />
	   
	   <cfset var Getpeople = "">
	   <cfquery name="Getpeople" datasource="#instance.rosterdsn#">
	      Select FirstName, MiddleName, LastName, EventDate, EventTime, ci_load_date, status
		  From CI_DB
		  Where EventKey = '#Arguments.EventKey#'
		  AND CIStatus IN ('Scheduled', 'Rescheduled')
		  Order By Lastname,  Firstname, ci_load_date
	   </cfquery>
	   
	   <cfreturn Getpeople />
   </cffunction>
   
   <cffunction name="UpdateMtgStatus" returnType="VOID" access="public">
       <cfargument name="EventKey" type="string" required="Yes" />
	   
	   <cfquery name="updateStatus" datasource="#instance.rosterdsn#">
	      Update CI_DB
		  Set Status = 'MTG CANCEL'
		  Where EventKey = '#Arguments.EventKey#'
	   </cfquery>
	   
   </cffunction>
   
</cfcomponent>