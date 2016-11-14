
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<cfoutput>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

	<link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />
</head>
	<body>

	<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Moderator Master Schedule" showCalendar="1">
	
		<br>
	 <a href="act_MasterSchedule_b.cfm?begin_date=#FORM.begin_date#&end_date=#FORM.end_date#"><img src="/Images/excelico.gif" alt="Download Spreadsheet" width="16" height="16" border="0" align="middle" hspace="2"></a>&nbsp;
<a href="act_MasterSchedule_b.cfm?begin_date=#FORM.begin_date#&end_date=#FORM.end_date#"><u>Download as Spreadsheet</u></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="dsp_MasterSchedule.cfm"><u>Enter Different Dates</u></a>
	<br><br>
	
									<cfoutput>
									<center><font face="Verdana,Helvetica,Arial" size="2">
										<b>Moderator Master Schedule for Events Between:</b><br><br> <font color="800000"><b>#dateFormat(FORM.begin_date, "mm/dd/yy")#</font> and <font color="800000">#dateFormat(FORM.end_date, "mm/dd/yy")#</font></b>
									</font></center>
									</cfoutput>
								
	<br><br>
	
		<cfquery name="getactivemod" datasource="#application.speakerDSN#">
		SELECT DISTINCT speakerid, 
		                lastname, 
						firstname
						From Speaker
						Where type ='MOD' 
						and active ='yes'
						order by firstname
						</cfquery> 
						<hr size="1" color="000000">
	 <table border="0" cellspacing="0" cellpadding="8" align="center" frame="border" rules="all">
		 <cfset bg= 'white'>
       <cfloop query="getactivemod">
	   <tr bgcolor ="#bg#">
	   <td align="left" valign="top" nowrap>
	   <strong>#getactivemod.firstname# #getactivemod.lastname#</strong>
	   </td>
<cfquery name="meetings" datasource="#application.projdsn#"> 
Select * 
From ScheduleSpeaker
Where 
speakerid = '#getactivemod.speakerid#' and 
meetingdate between '#form.begin_date#' and '#form.end_date#'
order by meetingdate, MtgStartTime
 </cfquery>
 
 <cfset date = ''>
 <cfset i =1>
	  <cfloop query="meetings">	  
	  
	<cfif #DateFormat(meetings.meetingdate, "m/d/yyyy")# is '#date#'> 
	<br>#Left(meetings.meetingcode, 9)# - #TimeFormat(meetings.MtgStartTime, "h:mm tt")#
	<cfelse>
	<cfif #i# is not '1'></td></cfif>
	  <td align="left" valign="top" nowrap>
	   <font color="800000">#DateFormat(meetings.meetingdate, "m/d/yyyy")#</font><br>
	   #Left(meetings.meetingcode, 9)# - #TimeFormat(meetings.MtgStartTime, "h:mm tt")#	  
	   	   <cfset date = '#DateFormat(meetings.meetingdate, "m/d/yyyy")#'>	 
		  </cfif>
		
		<cfset i = #i#+1>    
	   </cfloop>
	   </tr>
	   <cfif #bg# is 'white'>
	   <cfset bg =  'd3d3d3'>
	   <cfelse>
	   <cfset bg =  'white'>
	   </cfif>
	   </cfloop>
		
			<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
	</body>
	
</html></cfoutput>