<cfoutput>
<cfif IsDefined("url.month_excel")>
<cfset form.begin_date ='#DateFormat(url.begin_date, "mm/dd/yyyy")#'>
<cfset form.end_date ='#DateFormat(url.end_date, "mm/dd/yyyy")#'>
</cfif>

<cfif IsDefined("url.day_excel")>
<cfset form.begin_date ='#DateFormat(url.begin_date, "mm/dd/yyyy")#'>
<cfset form.end_date ='#DateFormat(url.end_date, "mm/dd/yyyy")#'>
</cfif>

<cfif IsDefined("url.year_excel")>
<cfset form.begin_date ='#DateFormat(url.begin_date, "mm/dd/yyyy")#'>
<cfset form.end_date ='#DateFormat(url.end_date, "mm/dd/yyyy")#'>
</cfif>

 <cfquery name="getSchedule" datasource="#application.projdsn#"> 
	   Select left(meetingCode, 9) as projectCode, MtgStartTime, MtgEndTime, ScheduleID, Status, password, Remarks, DateAdded, LastUpdated, DateAdded, meetingCode, UpdatedBy, MeetingDate,
		   (Select CodeDesc
		      From Lookup
			  Where CodeGroup = 'MTGSTATUS'
			  AND CodeValue = M.Status) as MtgStatus,
		   (Select speaker_listenins
		      From PIW
			  Where project_code = left(M.meetingCode, 9)) as ListenIN,
		   (Select helpline
		     From PIW
			  Where project_code = left(M.meetingCode, 9)) as DialIN,	     	
		   (Select Top 1 SpeakerID
		      From ScheduleSpeaker
			  Where ScheduleID = M.ScheduleID
			  AND Type = 'MOD') as ModeratorExists,
		   (Select Top 1 SpeakerID
		      From ScheduleSpeaker
			  Where ScheduleID = M.ScheduleID
			  AND Type = 'SPKR') as SpeakerExists			  
		  From ScheduleMaster M
		  
		  Where meetingdate BETWEEN '#form.begin_date#' AND '#form.end_date#'
		  		 
		  Order By MeetingDate, MtgStartTime, Status
	  </cfquery>

</cfoutput>
<br><br>


<cfsavecontent variable="savefordownload">
<table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolor="000000">
  <tr bgcolor="silver">
      <td nowrap><font face="verdana" size="1"><strong>Project</strong></font></td> 
	  <td nowrap><font face="verdana" size="1"><strong>Meeting Code</strong></font></td>
	  <td nowrap><font face="verdana" size="1"><strong>Meeting Status</strong></font></td>
	  <td nowrap><font face="verdana" size="1"><strong>Date</strong></font></td>
	  <td nowrap><font face="verdana" size="1"><strong>Time</strong></font></td>
	  <td nowrap><font face="verdana" size="1"><strong>Speakers</strong></font></td>	 
	  <td nowrap><font face="verdana" size="1"><strong>Moderators</strong></font></td>	 
	  <td nowrap><font face="verdana" size="1"><strong>Speaker/Listen In Number</strong></font></td>
	  <td nowrap><font face="verdana" size="1"><strong>Participant Dial In Number</strong></font></td>
	  <td nowrap><font face="verdana" size="1"><strong>Meeting Notes</strong></td> 
  </tr>
  <cfoutput query="getSchedule">
     <tr>
     <td nowrap><font face="verdana" size="1">
<cfquery name="get_desc" datasource="#application.projdsn#"> 
Select project_code, product
		     From PIW
			Where project_code = '#getSchedule.projectCode#'
			 </cfquery> 
	 
	 #get_desc.product#
	 
	 </td> 
	  <td nowrap><font face="verdana" size="1">#getSchedule.ProjectCode#</font></td>
	  <td nowrap><font face="verdana" size="1">#getSchedule.status#</font></td>
	  <td nowrap><font face="verdana" size="1">#DateFormat(getSchedule.MeetingDate, "mmm, dd yyyy")#</font></td>
	  <td nowrap><font face="verdana" size="1">#TimeFormat(getSchedule.MtgStartTime, "hh:mm tt")#</font></td>
	  <td nowrap><font face="verdana" size="1">
	  <cfquery name="get_spkrs_ids" datasource="#application.projdsn#"> 
	  Select ScheduleID, speakerid		 	    	  
		  From 
		  ScheduleSpeaker 	  
		  Where 	 	
		  ScheduleID = '#getSchedule.ScheduleID#'
		  and type = 'SPKR'
	  </cfquery>  
	  <cfloop query="get_spkrs_ids">
	<cfquery name="get_spkrs_names" datasource="#application.speakerDSN#">
	  Select 
		  sp.firstname, 
		  sp.lastname		    	  
		  From 
		  Speaker sp		  
		  Where 	 	
		  sp.speakerid = '#get_spkrs_ids.speakerid#'
		  and sp.type = 'SPKR'
	  </cfquery> 
	  <cfif get_spkrs_names.recordcount is 0><cfelse>#get_spkrs_names.firstname# #get_spkrs_names.lastname#	<br></cfif>
	  </cfloop>
	  </font></td> 
	                                         	  
		<td nowrap><font face="verdana" size="1">
	  <cfquery name="get_mods_ids" datasource="#application.projdsn#"> 
	  Select ScheduleID, speakerid		 	    	  
		  From 
		  ScheduleSpeaker 	  
		  Where 	 	
		  ScheduleID = '#getSchedule.ScheduleID#'
		  and type = 'MOD'
	  </cfquery>  
	  <cfloop query="get_mods_ids">
	<cfquery name="get_mods_names" datasource="#application.speakerDSN#">
	  Select 
		  sp.firstname, 
		  sp.lastname		    	  
		  From 
		  Speaker sp		  
		  Where 	 	
		  sp.speakerid = '#get_mods_ids.speakerid#'
		  and sp.type = 'MOD'
	  </cfquery> 
	  <cfif get_mods_names.recordcount is 0><cfelse>#get_mods_names.firstname# #get_mods_names.lastname#	<br></cfif>
	  </cfloop>
	  </font></td>              
	  <td nowrap><font face="verdana" size="1">#getSchedule.ListenIN#</font></td>
	  <td nowrap><font face="verdana" size="1">#getSchedule.DialIN#</font></td>
	  <td nowrap><font face="verdana" size="1">#getSchedule.Remarks#</font></td> 
  </tr>
  </cfoutput>
</table>
</cfsavecontent>


<cfset yourFileName="Schedule_#form.begin_date#-#form.end_date#.xls">
<cfcontent type="application/msexcel">
<cfheader name="Content-Disposition" value="inline; filename=#yourFileName#">
<cfoutput>#savefordownload#</cfoutput>           

</body>
</html>