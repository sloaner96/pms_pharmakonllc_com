<cfcomponent>
	<cffunction hint="pulls project codes belonging to a specific client for select box" name="getProjects" access="public" returntype="query">
		<cfargument hint="stores 5 digit client code" name="client_code" type="string" required="true"/>
		<cfquery name="qproject_codes" datasource="#session.dbs#" dbtype="ODBC" username="#session.dbu#" password="#session.dbp#">
			SELECT cp.client_proj
			FROM client_proj cp
			WHERE LEFT(cp.client_proj,5) = '#arguments.client_code#'
		</CFQUERY>	
		<cfreturn qproject_codes>	
	</cffunction>
	
	<cffunction hint="pulls honoraria types for select box" name="getHonotype" access="public" returntype="query">
		<cfquery name="qhonoraria_type" datasource="#session.dbs#" dbtype="ODBC" username="#session.dbu#" password="#session.dbp#">
			SELECT honoraria_id, honoraria_name 
			FROM honoraria_type 
			ORDER BY honoraria_name
		</CFQUERY>	
		<cfreturn qhonoraria_type>	
	</cffunction>
	
	<cffunction hint="pulls meeting rate types for select box" name="getMeetingRatetype" access="public" returntype="query">
		<cfquery name="qrate_type" datasource="#session.dbs#" dbtype="ODBC" username="#session.dbu#" password="#session.dbp#">
			SELECT rate_id, rate_name 
			FROM rate_type 
			ORDER BY rate_name 
		</cfquery>	
		<cfreturn qrate_type>	
	</cffunction>
	
	<cffunction hint="pulls other types for select box" name="getOthertype" access="public" returntype="query">
		<cfquery name="qother_type" datasource="#session.dbs#" dbtype="ODBC" username="#session.dbu#" password="#session.dbp#">
			SELECT type_id1, type_name1, charge, charge_rate
			FROM other_charges_type 
			ORDER BY type_name1, charge 
		</cfquery>	
		<cfreturn qother_type>	
	</cffunction>
	
	<cffunction hint="pulls cost/sell unit types for select box" name="getUnitstype" access="public" returntype="query">
		<cfquery name="qunits" datasource="#session.dbs#" dbtype="ODBC" username="#session.dbu#" password="#session.dbp#">
			SELECT type_id, type_name
			FROM po_markup_type
			ORDER BY type_name 
		</cfquery>	
		<cfreturn qunits>	
	</cffunction>	
	
</cfcomponent>
