
<cfcomponent>
	<cffunction hint="updates total meetings in meeting_summary for this project" name="updateSummary" access="public">
		<cfargument hint="update insert or delete" name="action" type="string" required="true"/>
		<cfargument hint="stores project code" name="project_code" type="string" required="true"/>
		<cfargument hint="stores meeting date" name="meeting_date" type="date" required="true"/>
		<cfargument hint="stores meeting year" name="meeting_year" type="numeric" required="true"/>
		
		<!--- if a meeting is being added, set number of meetings to 1. if a
		meeting is being deleted, set number of meetings to -1 --->
		<cfset jmeeting_date = DayOfYear(#arguments.meeting_date#)>
		<cfif arguments.action EQ "update">
			<cfset num_mtgs = 1>
		<cfelseif arguments.action EQ "delete">
			<cfset num_mtgs = "-1">
		</cfif>
		
		<!--- pull number of meetings existing for this day --->
		<CFQUERY DATASOURCE="#session.dbs#" NAME="qprojects" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
		SELECT [#jmeeting_date#], grand_total 
		FROM meeting_summary
		WHERE project_code = '#arguments.project_code#' AND year = #arguments.meeting_year#
		</cfquery>
		
		<!--- if a row exists, update the number of meetings. if a row does not exist,
		insert a new row with one meeting for this day --->
		<cfif qprojects.recordcount>
		
			<cfset new_total = #Evaluate("qprojects.#jmeeting_date#")# + #num_mtgs#>
			<cfset new_grand_total = #qprojects.grand_total# + #num_mtgs#>
		
			<CFQUERY DATASOURCE="#session.dbs#" NAME="qupdate" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			UPDATE meeting_summary
			SET [#jmeeting_date#] = #new_total#, grand_total = #new_grand_total#
			WHERE project_code = '#arguments.project_code#' AND year = #arguments.meeting_year#
			</cfquery>
		<cfelse>
			<CFQUERY DATASOURCE="#session.dbs#" NAME="qinsert" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			Insert into meeting_summary (project_code, year, [#jmeeting_date#], grand_total)  
	Values('#arguments.project_code#',  
		#arguments.meeting_year#, #num_mtgs#, #num_mtgs#)
			</cfquery>
		</cfif>
		
		<!--- After the update is complete, pull all days and recalculate the number of 
		meetings for the year --->
		<!--- <CFQUERY DATASOURCE="#session.dbs#" NAME="qgrand_total" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
		SELECT * 
		FROM meeting_summary
		WHERE project_code = '#arguments.project_code#' AND year = #arguments.meeting_year#
		</cfquery>
		
		<cfset new_grandtotal = 0>
		<cfset firstday = 1>
		<cfloop from="1" to="366" step="1" index="i">
			<cfset new_grandtotal = new_grandtotal + #Evaluate("qgrand_total.#firstday#")#>
				<cfset firstday = firstday + 1>
		</cfloop>
		
		<CFQUERY DATASOURCE="#session.dbs#" NAME="qupdategt" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
			UPDATE meeting_summary
			SET grand_total = #new_grandtotal#
			WHERE project_code = '#arguments.project_code#' AND year = #arguments.meeting_year#
		</cfquery> --->
		
					
	</cffunction>
				
	
</cfcomponent>
