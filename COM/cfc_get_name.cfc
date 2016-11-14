

<cfcomponent>
	<cffunction name="getProjName" hint="Gets the Description of the Product/Client" access="public" output="true" returntype="string">
		<cfargument name="ProjCode" hint="The Project Code" type="string" required="true"/>
			
		<CFQUERY DATASOURCE="#session.dbs#" NAME="getDesc">
			SELECT description
			FROM client_proj
			WHERE client_proj = '#arguments.ProjCode#'
		</CFQUERY>
		
		<cfif getDesc.recordcount>
			<cfreturn #getDesc.description#>	
		<cfelse>
			<cfset temp = "Project isn't entered into the Database Correctly!">
			<cfreturn #temp#>
		</cfif>
	</cffunction>
	
	<cffunction name="getSpkrModName" hint="Gets the Speaker Moderator Name" access="public" output="true" returntype="string">
		<cfargument name="SpkrModCode" hint="Speaker/Moderator ID" type="numeric" required="true"/>
			
		<CFQUERY DATASOURCE="#session.spkrdbs#" NAME="getSpkrMod" USERNAME="#session.spkrdbu#" PASSWORD="#session.spkrdbp#">
			SELECT firstname,lastname
			FROM spkr_table
			WHERE speaker_id = #arguments.SpkrModCode#;
		</CFQUERY>
		
		<cfset temp = "#getSpkrMod.firstname# #getSpkrMod.lastname#">
		<cfreturn #temp#>	
		
	</cffunction>
		
</cfcomponent>
