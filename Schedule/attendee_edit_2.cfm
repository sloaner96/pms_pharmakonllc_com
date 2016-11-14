<!--- 
	*****************************************************************************************
	Name:		attendee_edit.cfm
	Function:	Allows user to update attendance and cis for a meeting
	
	*****************************************************************************************
--->
<HTML>

	<HEAD>
		<TITLE>Attendee Edit 2</TITLE>
<cfoutput>		
<cfset spkr_edit_url = "attendee_client_results.cfm?project_code=#form.project_code#">

		<!--- create percentages for people who showed up and no shows --->
		<cfset show = (form.attendees / form.cis)>
		<cfset noshow = 1 - show>
				
		<!--- update attendee info --->
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="updateAttendees">
			UPDATE schedule_meeting_time
			SET cis = #form.cis#, attendees = #form.attendees#, show = #show#, noshow = #noshow# <cfif IsDefined("form.client_listen")>, client_listen='#Left(form.client_listen,100)#'<cfelse>, client_listen= Null</cfif><cfif IsDefined("form.mod_listen")>, mod_listen='#Left(form.mod_listen,100)#'<cfelse>, mod_listen= Null</cfif>
			WHERE rowid = #url.rowid#
		</cfquery>
	

<!--- go back to display, refresh and close popup --->		
<script language="JavaScript">
function redirect(){
window.opener.location.href="#spkr_edit_url#";
self.close();
}
</script>
</cfoutput>
	</HEAD>	

	<BODY onload="redirect();">
				
		
		
	</BODY>

</HTML>