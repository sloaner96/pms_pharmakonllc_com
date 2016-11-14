 		 					<script type="text/javascript">
function openpopup3(popurl){
var winpops=window.open(popurl,"","top=200,left=300,width=650,height=610,scrollbars=yes,resizable=yes")
}
</script> 				   	
							
							<script type="text/javascript">
function openpopup(popurl){
var winpops=window.open(popurl,"","top=200,left=300,width=600,height=610,scrollbars=yes,resizable=yes")
}
</script> 

 		   	<script type="text/javascript">
function openpopup5(popurl){
var winpops=window.open(popurl,"","top=200,left=300,width=420,height=370,scrollbars=yes,resizable=yes")
}
</script>

<cfparam name="url.month" default="#month(now())#" type="numeric">
<cfparam name="url.year" default="#year(now())#" type="numeric">
<cfparam name="url.day" default="#day(now())#" type="numeric">

<cfset month = url.month>
<cfset year = url.year>
<cfset day = url.day>

<cfset today = createdate(year, month, day)>
<cfset tomorrow = dateAdd('d', 1, today)>
<cfset yesterday = dateAdd('d', -1, today)>

<!--- Include special StyleSheet --->
  <link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Scheduling Main Page" bodyPassthrough="onLoad='init()'" doAjax="True">
<br><br>


 <table width="100%" border="1" cellspacing="0" cellpadding="8" align="center" frame="below" frame="rhs">
       <tr><td valign="top" nowrap>
<strong>New Data</strong>
<br><br>

<li><a href="refresh_database.cfm?excel=yes&grid=no"><u>Refresh Excel Schedule Data</u></a></li><br><br>
<li><a href="javascript:openpopup3('new_meeting.cfm')"><u>Add a New Meeting</u></a></li><br><br>




</td><td valign="top">
<strong>View/Edit Current Meetings</strong>
<br><br>
<li><a href="dsp_globalScheduleDay.cfm"><u>Edit by Day View</u></a></li><br><br>
<li><a href="dsp_globalScheduleWeek.cfm"><u>Edit by Week View</u></a></li><br><br>
<li><a href="dsp_globalSchedule.cfm"><u>Edit by Month View</u></a></li><br><br>
<li><a href="dsp_globalScheduleYear.cfm"><u>Edit by Year View</u></a></li><br><br>
<li><a href="http://ravel/grid/index.cfm" target="_blank"><u><font color="FF0000">Dynamic Spreadsheet</font></u></a></li>
<br>


</td><td valign="top">
<strong>Moderators/Speakers</strong>
<br><br>

<li><a href="../speakers/dsp_AddSpeaker.cfm"><u>Add a Speaker</u></a></li><br><br>
<li><a href="../Moderators/mod_AddMod.cfm"><u>Add a Moderator</u></a></li><br><br>
<li><a href="javascript:openpopup5('add_spker2.cfm')"><u>Associate New Speaker to Project</u></a></li><br><br>
<li><a href="javascript:openpopup5('add_mod2.cfm')"><u>Associate New Moderator to Project</u></a></li><br><br>
<li><a href="..//reports/report_modspkr_calendar.cfm"><u>Moderator/Speaker Schedules</u></a></li>

<cfoutput><cfquery name="getactivespkr" datasource="#application.speakerDSN#">
		SELECT DISTINCT speakerid, 
		                lastname, 
						firstname
						From Speaker
						Where type ='SPKR' 						
						order by lastname
						</cfquery> 
 <form method="POST" action="../Speakers/spkr_details.cfm">
	    <font face="verdana" size="1"><strong>Edit/View Speaker Profiles:</strong></font><br>
	    <select name="all_spker" onchange="this.form.submit();">	
		 <option value="">-SELECT-</option>	   
		   <cfloop query="getactivespkr">
	        <option value="#getactivespkr.speakerid#">#getactivespkr.lastname#, #getactivespkr.firstname#</option>
		   </cfloop>
	    </select>
	  </form>
<cfquery name="getactivemod" datasource="#application.speakerDSN#">
		SELECT DISTINCT speakerid, 
		                lastname, 
						firstname
						From Speaker
						Where type ='MOD' 						
						order by lastname
						</cfquery> 
 <form method="POST" action="../Moderators/mod_details.cfm">
	    <font face="verdana" size="1"><strong>Edit/View Moderator Profiles:</strong></font><br>
	    <select name="all_mod" onchange="this.form.submit();">		
		 <option value="">-SELECT-</option>	   
		   <cfloop query="getactivemod">
	        <option value="#getactivemod.speakerid#">#getactivemod.lastname#, #getactivemod.firstname#</option>
		   </cfloop>
	    </select>
	  </form>
</cfoutput>

</td><td valign="top">
<strong>Attendance/Payment</strong>
<br><br>
<li><a href="attendee_client_select.cfm"><u>Post Attendance</u></a></li><br><br>
<li><a href="payments.cfm"><u>Payments</u></a></li><!--- <br><br>
<li><a href="change_notes.cfm"><u>Change Passwords</u></a></li> --->



</td>
</tr>
</table>

<br><br>

<cfmodule template="#Application.tagpath#/ctags/footer.cfm">  
