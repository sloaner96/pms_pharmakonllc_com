<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Change Speaker Notes" showCalendar="0">


<table>



<cfloop index = "i" from = #form.startCounter# to = #form.endCounter#>

<cfset checkbox = "form.c" & #i#>
<cfif isdefined(checkbox)>


	<tr>

		<cfset rowid = #form["iRowid" & i]#>
		<cfset temp = rowid.indexOf(",") + 1>
		<cfset temp2 = len(rowid)>
		<cfset newRowid = right(rowid, #temp2# - #temp#)>

		<td><cfoutput>#newRowid#</cfoutput></td>

		<td><cfoutput>#form["inputArea" & i]#</cfoutput></td>

		<td>Updated!</td>
		 <CFQUERY DATASOURCE="#application.WeeklyRptDSN#" NAME="qGetMeetingInfo">
			update PMSProd.dbo.schedule_meeting_time
			set remarks = <cfif form["inputArea" & i] GT 0>'#form["inputArea" & i]#'<cfelse>NULL</cfif>,
			    moderator_id = <cfif Len(Trim(Evaluate("form.GetModerators_#i#"))) GT 0>#Evaluate("form.GetModerators_#i#")#<cfelse>0</cfif>,
				speaker_id = <cfif Len(Trim(Evaluate("form.GetSpeakers_#i#"))) GT 0>#Evaluate("form.GetSpeakers_#i#")#<cfelse>0</cfif>
			where rowid = #newRowid#
		</CFQUERY> 

	</tr>

</cfif>
</cfloop>
</table><br>
You have successfully updated these records <a href="change_notes.cfm">go back</a> to update more<br>
<a href="/inbox.cfm">Home</a>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

