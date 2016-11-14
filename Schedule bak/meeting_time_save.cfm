<!--- 
	*****************************************************************************************
	Name:		meeting_time_save.cfm
	
	Function:	Saves the meeting time for a specified date
	History:	8/7/01, CJL
	
	*****************************************************************************************
--->

<!--- Set the variables needed to make meeting entry in database --->
<CFSET year = URL.year>
<CFSET month = URL.month>
<CFSET day = URL.day>
<CFSET time_from = URL.time_from>
<CFSET time_to = URL.time_to>
<CFSET Moderator_id = URL.Moderator_id>
<CFSET Speaker_id = Speaker_id>

<!--- Save changes for month that was edited right before comming to this page --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="Save_Schedule2">
	UPDATE schedule_meeting_time
	SET<CFLOOP INDEX="count" FROM=1 TO=30 STEP=1> x#count# = '#Evaluate("form.Day#count#")#',</CFLOOP> x31 = '#form.Day31#'
	WHERE month = '#URL.savemonth#' AND year = '#URL.saveyear#' AND Project_code = '#session.Project_code#';
</CFQUERY>