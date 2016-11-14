<!--- 
	*****************************************************************************************
	Name:		project_status_update2.cfm 11/24/2003
	
	Function:  Updates project statuses that were changed on project_status_update.cfm
	
	*****************************************************************************************
--->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Active and Quoted Projects" showCalendar="0">

	

	<!--- set variable to validate if anything was updated --->
	<cfset check = 0>
<cfoutput>
<!--- loop the recordcount from from the fetch query on project_status_update.cfm --->
<cfloop from="1" to="#form.recordsreturned#" index="LoopIndex">
	<!--- if the status has changed, run update query and post message saying this was done --->
	<cfif Evaluate("form.status" & LoopIndex) NEQ Evaluate("form.originalstatus" & LoopIndex)>
			<!--- update check to 1 --->
			<cfset check = 1>
	
		<cfquery name="UpdateStatus" datasource="#application.projdsn#">
			Update client_proj 
				Set status = #Evaluate("form.status" & LoopIndex)#
				Where rowid = #Evaluate("form.rowid" & LoopIndex)#
		</cfquery>
		<!--- Pull the status name to display --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="pullStatus">
			SELECT codedesc as status_description
			FROM lookup s	
			WHERE s.codeGroup = 'PROJECTSTATUS'
			AND s.codevalue = '#Evaluate("form.status" & LoopIndex)#'
		</CFQUERY>
		
	
	&nbsp;&nbsp;<strong>#Evaluate("form.project" & LoopIndex)#</strong> status was updated to <strong>#pullStatus.status_description#.</strong><br>
	</cfif>
	
	
</cfloop>
	<!--- If no updates were made, display this information --->
	<cfif check NEQ 1>
		&nbsp;&nbsp;No updates were made.<br><br>
	</cfif>

	<!--- back button to go back to form --->
	<form action="project_status_update.cfm" method="post">
		<input type="submit" name="back" value="Back to Update">
	</form>
	
</cfoutput>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

