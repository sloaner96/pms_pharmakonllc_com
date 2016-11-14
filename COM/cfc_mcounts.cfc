<!---
---------------------------------------------------------------------------------------------
	cfc_mcounts.cfc
	FUNCTIONS:
		getMCounts   - fetches meeting count data based on meetingcode
	HISTORY:
		bj20040505   - initial code
---------------------------------------------------------------------------------------------
--->
<cfcomponent>
	<cffunction access="public" name="getCounts" returntype="query" displayname="Get Meeting Counts" output="false">
		<!--- meeting code required --->
		<cfargument name="cfcMCode" type="string" required="Yes">
	
		<!--- query the meeting_counts table for the appropriate meeting counts data --->
		<cftry>
		<CFQUERY DATASOURCE="#application.rosterDSN#" NAME="MCounts">
			SELECT eventkey,eventdatetime, timezone, speakername,event_count,diff 
			FROM meeting_counts_blitz
			WHERE eventkey LIKE '#arguments.cfcMCode#%' 
			ORDER BY eventdatetime
		</cfquery>
		<cfcatch type="database"><cfinclude template="error_db_abort.cfm"></cfcatch>
		<cfcatch type="any"><cfinclude template="error_db_abort.cfm"></cfcatch>
		</cftry>
		<!--- return the query result set --->
		<cfreturn MCounts>
	</cffunction>
</cfcomponent>