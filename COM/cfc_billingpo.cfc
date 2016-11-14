<cfcomponent>

	<cffunction name="getClients" access="remote" returntype="query" output="false">
		
		<CFQUERY DATASOURCE="PMS" NAME="qclients">
			SELECT DISTINCT client_code 
			FROM client_proj 
			ORDER BY client_code
		</CFQUERY>
		<cfreturn qclients>
	</cffunction>
	
	<cffunction name="getProjects" access="remote" returntype="query" output="false">
		<cfargument name="clientID" type="string" required="false">
		
		<CFQUERY DATASOURCE="PMS" NAME="qprojects">
			SELECT client_proj, description 
			FROM client_proj
			<cfif IsDefined("clientID")>
			WHERE client_code = '#arguments.clientID#'
			</cfif>
			ORDER BY client_proj
		</CFQUERY>
		<cfreturn qprojects>
	</cffunction>
	
	<cffunction name="getDescription" access="remote" returntype="query" output="false">
		<cfargument name="projectID" type="string" required="true">
		
		<CFQUERY DATASOURCE="Projman" NAME="qdescription" USERNAME="projman" PASSWORD="p926full">
			SELECT description 
			FROM client_proj
			WHERE client_proj = '#arguments.projectID#'
		</CFQUERY>	
		
		<cfreturn qdescription>
	</cffunction>
	
	<cffunction name="getAE" access="remote" returntype="query" output="false">
		<cfargument name="projectID" type="string" required="true">
		<cfquery name="qae" datasource="Projman" username="projman" password="p926full">
			SELECT p.account_exec, p.account_supr, s.repfirstname AS asfirstname, s.replastname AS aslastname, a.repfirstname AS aefirstname, a.replastname AS aelastname
			FROM piw p, sales_reps s, sales_reps a
			WHERE p.project_code = '#arguments.projectID#' AND p.account_supr = s.ID AND p.account_exec = a.ID
		</cfquery>
		<cfreturn qae>
	</cffunction>
	
	<cffunction name="getEvent" access="remote" returntype="query" output="false">
		<cfquery name="qevent" datasource="Projman" username="projman" password="p926full">
			SELECT type_id1, type_name1
			FROM other_charges_type
		</cfquery>
		<cfreturn qevent>
	</cffunction>
	
	<cffunction name="getEventCost" access="remote" returntype="query" output="false">
		<cfargument name="eventID" type="string" required="false">
		<cfquery name="qeventcost" datasource="Projman" username="projman" password="p926full">
			SELECT charge, charge_rate
			FROM other_charges_type
			<cfif IsDefined("eventID")>
			WHERE type_id1 = '#arguments.eventID#'
			</cfif>
		</cfquery>
		<cfreturn qeventcost>
	</cffunction>
	
	<cffunction name="getBillingSheet" access="remote" returntype="query" output="false">
		<cfargument name="projectID" type="string" required="true">
		<cfquery name="qgetbillingsheet" datasource="Projman" username="projman" password="p926full">
			SELECT o.project_code, o.charge_type, ot.type_name1, o.cost_amt, o.sell_amt, o.quantity, o.vendor, o.rowid
			FROM other_charges o, other_charges_type ot
			WHERE o.project_code = '#arguments.projectID#' AND o.charge_type = ot.type_id1
		</cfquery>
		<cfreturn qgetbillingsheet>
	</cffunction>
	
	<cffunction name="UpdateBillingSheet" access="remote" output="false">
		<cfargument name="maxi" type="numeric" required="true">
		<cfargument name="arrEvent" type="array" required="true">
		<cfargument name="arrVendor" type="array" required="true">
		<cfargument name="arrQuantity" type="array" required="true">
		<cfargument name="arrEachCost" type="array" required="true">
		<cfargument name="arrEachSell" type="array" required="true">
		<cfargument name="arrRowid" type="array" required="true">
		<cfoutput>		
		<cfloop from="1" to="#ArrayLen(arguments.arrEvent)#" step="1" index="x">
		<cfquery name="qupdatebillingsheet" datasource="Projman" username="projman" password="p926full">
			Update other_charges 
				Set  vendor='#arguments.arrVendor[x]#', quantity=#arguments.arrQuantity[x]#,
				cost_amt=#arguments.arrEachCost[x]#, sell_amt=#arguments.arrEachSell[x]#
				Where rowid = #arguments.arrRowid[x]#		
		</cfquery>
		</cfloop>
		</cfoutput>
	</cffunction>
	
</cfcomponent>