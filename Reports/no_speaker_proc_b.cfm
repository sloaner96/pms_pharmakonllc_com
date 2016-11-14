	  <cfoutput>
	  <cfset FORM.begin_date = '#url.begin_date#'>
<cfset FORM.end_date = '#url.end_date#'> 
	<cfcontent type="application/vnd.ms-excel">  
		   	
				<cfquery name="getDayList2" datasource="#application.projdsn#"> 
		Select left(meetingCode, 9) as projectCode, MtgStartTime, MtgEndTime, ScheduleID, Status, meetingcode, meetingdate,
		   (Select Top 1 SpeakerID
		     From ScheduleSpeaker
			 Where ScheduleID = M.ScheduleID			 
			 AND Type = 'MOD') as ModeratorExists,
		   (Select Top 1 SpeakerID
		     From ScheduleSpeaker
			 Where ScheduleID = M.ScheduleID	
			 AND Type = 'SPKR') as SpeakerExists   
		  From ScheduleMaster M		      
		  Where M.meetingdate between '#dateFormat(FORM.begin_date, "mm/dd/yy")#' and '#dateFormat(FORM.end_date, "mm/dd/yy")#'  
		  Order By meetingdate, MtgStartTime 	  
		</cfquery>
<cfset the_date = ''>

<cfloop query="getDayList2">
				
<cfquery name="confirmed_spkr" datasource="#application.projdsn#"> 
Select
Confirmed, speakerid   
From ScheduleSpeaker
Where 
ScheduleID = '#getDayList2.ScheduleID#' and 
Type = 'SPKR' and Confirmed = '1'
</cfquery>

 

<cfif confirmed_spkr.recordcount is 0>
<cfset confirmed_spkr = 'no'>
<cfelse>
<cfset confirmed_spkr = 'yes'>
</cfif>

<cfquery name="confirmed_mod" datasource="#application.projdsn#"> 
Select
Confirmed, speakerid  
From ScheduleSpeaker
Where 
ScheduleID = '#getDayList2.ScheduleID#' and 
Type = 'MOD' and Confirmed = '1'
 </cfquery>
 
<cfif confirmed_mod.recordcount is 0>
<cfset confirmed_mod = 'no'>
<cfelse>
<cfset confirmed_mod = 'yes'>
</cfif>

	   
<cfset zoom_day = "#DateFormat(getDayList2.meetingdate, "dd")#">
<cfset zoom_month = "#DateFormat(getDayList2.meetingdate, "mm")#">
<cfset zoom_year = "#DateFormat(getDayList2.meetingdate, "yyyy")#">    

 <table border="0" cellpadding="3" cellspacing="1" width="100%">
		     <tr>
			 
			   <td align="left" valign="top" width="25%">
			   <cfif the_date is '#DateFormat(getDayList2.meetingdate, "dddd, mmmmm dd, yyyy")#'>
	<cfelse>	
		<tr><td colspan="4"><hr color="000000"><br><br> </td></tr>  
		<tr><td align="left" valign="top" width="25%">
<strong><font color="808080">#DateFormat(getDayList2.meetingdate, "dddd, mmmmm dd, yyyy")#</font></strong></td>
</cfif>
<td align="left" valign="top" width="15%">
<span style="color:##5f5f5f;">#TimeFormat(getDayList2.MtgStartTime, 'hh:mm tt')#</span></td>

<td align="left" valign="top" width="10%">
<a href="javascript:openpopup2('zoom_Schedule.cfm?day=#zoom_day#&month=#zoom_month#&year=#zoom_year#')">
<a href="javascript:openpopup2('../Schedule/edit_Schedule.cfm?day=#zoom_day#&month=#zoom_month#&year=#zoom_year#&meetingcode=#getDayList2.meetingcode#')">
<span 
<cfif getDayList2.status IS 'CPS'>
class="meeting_canceled"
<cfelseif getDayList2.status IS 'CPA'>class="meeting_canceled"<cfelseif getDayList2.status IS 'CPI'>class="meeting_canceled"<cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_spkr# is 'yes' AND #confirmed_mod# is 'yes'>class="fullystaffed"<cfelseif #Right(getDayList2.projectCode, 2)# is 'CT' AND getDayList2.ModeratorExists GT 0 AND #confirmed_mod# is 'yes'>class="fullystaffed"<cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_spkr# is 'yes' AND #confirmed_mod# is 'no'>class="nomoderator"<cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_mod# is 'yes'>class="nospeaker"<cfelseif getDayList2.status IS 'C'>class="meeting_canceled"
<cfelse>class="nostaff"</cfif>><u>#getDayList2.projectCode#</u></span></a>
</td>

<cfquery name="confirmed_spkr" datasource="#application.projdsn#"> 
Select
Confirmed, speakerid   
From ScheduleSpeaker
Where 
ScheduleID = '#getDayList2.ScheduleID#' and 
Type = 'SPKR' and Confirmed = '1'
 </cfquery> 
 <cfif #confirmed_spkr.recordcount# is '0'><td align="left" valign="top" width="30%" bgcolor="red"><font color="FFFFFF">No Speaker</font></td>
<cfelseif #Right(getDayList2.projectCode, 2)# is 'CT'>
<td align="left" valign="top" width="30%" bgcolor="silver"><font color="black">No Speaker Needed</font></td>

	 <cfelse>
<td align="left" valign="top" width="30%" nowrap>
<cfloop query="confirmed_spkr">
 
 <cfquery name="get_spkr_names" datasource="#application.speakerDSN#">
	      Select
		  sp.speakerid, 
		  sp.firstname, 
		  sp.lastname
      	  From 
		  Speaker sp	  
		  
		  Where
		  sp.speakerid = #confirmed_spkr.speakerid#
			
	  </cfquery> 	
	  <cfif #get_spkr_names.recordcount# is '0'>
	  <font color="FF0000"><strong>Speaker ID -'#confirmed_spkr.speakerid#' not Found!</strong></font>
	  <cfelse>
#get_spkr_names.firstname# #get_spkr_names.lastname#<br></cfif>
</cfloop>
</td>
</cfif>
<cfset the_date = '#DateFormat(getDayList2.meetingdate, "dddd, mmmmm dd, yyyy")#'>
</cfloop>	
</cfcontent>       
	    </cfoutput>        
