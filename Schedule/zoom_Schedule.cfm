
 <cfoutput>
 
 <cfparam name="confirmed_mod" default="">
  <cfparam name="confirmed_spkr" default="">
   
 
 <link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />

 <!--------------------------- 
     get Projects for this Day 
	 --------------------------->
	  
	 <cfset thisMonth = "#url.month#">
	  <cfset thisday = "#url.day#">
	  <cfset thisMonth = "#url.year#"> 
	  
	  <cfset getdate = '#url.month#-#url.day#-#url.year#'> 
	  <cfset thisdate = '#DateFormat(getdate, "mm-dd-yyyy")#'> 
	  
			  <cfquery name="getDayList2" datasource="#application.projdsn#"> 
	     Select left(meetingCode, 9) as projectCode, MtgStartTime, MtgEndTime, ScheduleID, Status, meetingcode,
		   (Select Top 1 SpeakerID
		     From ScheduleSpeaker
			 Where ScheduleID = M.ScheduleID			 
			 AND Type = 'MOD') as ModeratorExists,
		   (Select Top 1 SpeakerID
		     From ScheduleSpeaker
			 Where ScheduleID = M.ScheduleID	
			 AND Type = 'SPKR') as SpeakerExists   
		  From ScheduleMaster M
		  Where meetingdate = '#thisdate#'
		  Order By MtgStartTime, Status
	  </cfquery>
	  
	  <font face="verdana" size="1">	  		
<a href="javascript:window.close();"><u>Close Window</u></a></font><br>
	  
	  
	  	<center><font face="verdana" size="2"> Schedule for  <strong>#thisdate#</strong></font><br></center>
		<div id="downloadxls" class="downloadxls">
	  <a href="scheduleasExcel.cfm?day_excel=yes&begin_date=#url.month#/#url.day#/#url.year#&end_date=#url.month#/#url.day#/#url.year#"&month=#month#&Year=#year#<cfif isDefined('form.projectfilter')><cfif Len(Trim(form.projectfilter)) GT 0>&project=#form.projectfilter#</cfif></cfif>" target="_blank"><img src="/Images/excelico.gif" alt="Download as Excel" width="16" height="16" border="0" align="middle" hspace="2"><font face="verdana" size="2"><u>Download Day as Excel</u></font></a>
	</div><br>
<!--- <font face="verdana" size="1" color="navy"><em>Click the meeting code to edit details</em></font> --->

	     <table border="1" cellpadding="2" cellspacing="0" width="100%">
		 <!--- <tr><td colspan ="6"><font face="verdana" size="2"><u><a href="add_Schedule.cfm">Add New Meeting</a></u></font><br><br></td></tr> --->
		 
		        <tr class="dayviewtable">
						   <td align="center"><font face="verdana" size="1"><strong>Status</strong></font></td>	
						   <td align="center"><font face="verdana" size="1"><strong>Project</strong></font></td>							   
				    <td align="center"><font face="verdana" size="1"><strong>Meeting</strong></font></td>
					<td align="center"  nowrap><font face="verdana" size="1"><strong>Time</strong></font></td>
					  <td align="center"><font face="verdana" size="1"><strong>Moderator</strong></font></td>
					 <td align="center"><font face="verdana" size="1"><strong>Speaker</strong></font></td>
								   
				</tr>  
				

<cfloop query="getDayList2">
<cfset grey_out='no'>
<tr>
<td valign="top"><font face="verdana" size="1" color="5f5f5f">#getDayList2.Status#</font></td>


<td valign="top"><font face="verdana" size="1" color="5f5f5f">

<cfquery name="get_desc" datasource="#application.projdsn#"> 
Select project_code, product
		     From PIW
			Where project_code = '#getDayList2.projectCode#'
			 </cfquery> 
			<font face="verdana" size="1" color="5f5f5f"><strong>#get_desc.product#</strong></font>
</td>

<td valign="top">

<!-------------------------------Look for Speaker Moderator Confirmation --->

<cfif  #getDayList2.SpeakerExists# is ''>
	   <cfset #getDayList2.SpeakerExists# = 0>
	   <cfelse>
	   	 <cfquery name="confirmed_spkr" datasource="#application.projdsn#"> 
Select
Confirmed   
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
 </cfif>
 
 <cfif  #getDayList2.ModeratorExists# is ''>
	   <cfset #getDayList2.ModeratorExists# = 0>
	   	   <cfelse>
	   	 <cfquery name="confirmed_mod" datasource="#application.projdsn#"> 
Select
Confirmed   
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
	   </cfif> 
	   <!----------------------------End Look for Speaker Moderator Confirmation --->
<a href="edit_Schedule.cfm?day=#url.day#&month=#url.month#&year=#url.year#&meetingcode=#getDayList2.meetingcode#"><span 

<cfif getDayList2.status IS 'CPS'>
class="meeting_canceled"
<cfelseif getDayList2.status IS 'CPA'>class="meeting_canceled"<cfelseif getDayList2.status IS 'CPI'>class="meeting_canceled"<cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_spkr# is 'yes' AND #confirmed_mod# is 'yes'>class="fullystaffed"<cfelseif #Right(getDayList2.projectCode, 2)# is 'CT' AND getDayList2.ModeratorExists GT 0 AND #confirmed_mod# is 'yes'>class="fullystaffed" <cfset grey_out = 'yes'><cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_spkr# is 'yes' AND #confirmed_mod# is 'no'>class="nomoderator"<cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_mod# is 'yes'>class="nospeaker"<cfelseif getDayList2.status IS 'C'>class="meeting_canceled"
<cfelse>class="nostaff"</cfif>>
<font face="verdana" size="1"><u>#getDayList2.projectCode#</u></span></a></font> </td>

<td nowrap valign="top">
<font face="verdana" size="1"><span style="color:##5f5f5f;">#TimeFormat(getDayList2.MtgStartTime, 'hh:mm tt')#</span></font></td>



  <td valign="top"> 
	   
		<!---   <cfif #getDayList2.ModeratorExists# EQ 0>&nbsp;
		<cfelse>   --->
 <cfquery name="get_selected_mods" datasource="#application.projdsn#"> 
Select
speakerid,
activityType,
Confirmed   
From ScheduleSpeaker
Where 
ScheduleID = '#getDayList2.ScheduleID#' and 
Type = 'MOD'
Order by activityType
 </cfquery> 	  
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
   <cfloop query="get_selected_mods">
		  <cfquery name="get_mods_names" datasource="#application.speakerDSN#">
	      Select
		  sp.speakerid, 
		  sp.firstname, 
		  sp.lastname
      	  From 
		  Speaker sp	  
		  
		  Where
		  sp.speakerid = #get_selected_mods.speakerid#
			
	  </cfquery> 	 
<tr>
						   <td align="left" valign="top" width="80%" nowrap>
<font face="verdana" size="1" color="5f5f5f">#get_mods_names.firstname# #get_mods_names.lastname#</font></td><td width="20%" valign="top"><font face="verdana" size="1" color="maroon"><em>#get_selected_mods.activityType#</em></td><td valign="top"><cfif get_selected_mods.Confirmed is 0><img src="../images/unconfirmed1.gif" alt="Unconfirmed Moderator" border="0"><cfelse><img src="../images/confirmed1.gif" alt="Confirmed Moderator" border="0"></cfif><br></font></td></tr>

</cfloop>
</table>
<!--- </cfif> ---></td> 
<cfif #grey_out# is 'yes'>
				 <td align="center" width="80%" valign="top" nowrap bgcolor="silver"><font face="verdana" size="2"><strong>NA</strong></font></td><cfelse>
 <td>	   
	   
		<!---   <cfif #getDayList2.SpeakerExists# EQ 0>&nbsp;
		<cfelse>  --->
	<cfquery name="get_selected_speakers" datasource="#application.projdsn#"> 
Select Distinct
speakerid,
activityType,
Confirmed   
From ScheduleSpeaker
Where 
ScheduleID = '#getDayList2.ScheduleID#' and 
Type = 'SPKR'
Order by activityType
 </cfquery> 	  
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
   <cfloop query="get_selected_speakers">
		  <cfquery name="get_speakers_names" datasource="#application.speakerDSN#">
	      Select
		  sp.speakerid, 
		  sp.firstname, 
		  sp.lastname
      	  From 
		  Speaker sp	  
		  
		  Where
		  sp.speakerid = '#get_selected_speakers.speakerid#'
			
	  </cfquery> 	 

		        <tr>
				
						   <td align="left" width="80%" valign="top" nowrap>
<font face="verdana" size="1" color="5f5f5f">#get_speakers_names.firstname# #get_speakers_names.lastname#</font></td><td width="20%" valign="top"><font face="verdana" size="1" color="maroon"><em>#get_selected_speakers.activityType#</em></td><td valign="top"><cfif get_selected_speakers.Confirmed is 0><img src="../images/unconfirmed1.gif" alt="Unconfirmed Moderator" border="0"><cfelse><img src="../images/confirmed1.gif" alt="Confirmed Moderator" border="0"></cfif></font></td>
               
               </tr>

</cfloop>
</table>
  <!--- </cfif> ---></cfif></td>  



</tr>

<cfset #speaker.speakerid# = 0>
<cfset #speaker.firstname# = ''>
<cfset #speaker.lastname# = ''>
<cfset #mod.speakerid# = 0>
<cfset #mod.firstname# = ''>
<cfset #mod.lastname# = ''>
</cfloop> 
<tr>
<td colspan="6" align="right">

<table border="0" cellpadding="3" cellspacing="2" align="right">
	          <tr>
	            <td colspan="2"> <font face="verdana" size="1"><strong>LEGEND:</strong></td>
	          </tr>
			  <tr>
			    <td width="4" bgcolor="006600"></td>
	            <td><font face="verdana" size="1">Fully Staffed</td>
	          </tr>
			  <tr>
			    <td width="4" bgcolor="660099"></td>
	            <td><font face="verdana" size="1">No Confirmed Moderator</td>
	          </tr>
			  <tr> 
			    <td width="4" bgcolor="cc9900"></td>
	            <td><font face="verdana" size="1">No ConfirmedSpeaker</td>
	          </tr>
			  <tr>
			    <td width="4" bgcolor="990000"></td>
	            <td><font face="verdana" size="1">No Confirmed Speaker and No Confirmed Moderator</td>
	          </tr>
			   <tr>
			    <td width="4" bgcolor="gray"></td>
	            <td><font face="verdana" size="1">Meeting Canceled</td>
	          </tr>
         </table>   
</td></tr>
</table>
</cfoutput>