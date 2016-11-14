 		 					<script type="text/javascript">
function openpopup3(popurl){
var winpops=window.open(popurl,"","top=200,left=300,width=650,height=610,scrollbars=yes,resizable=yes")
}
</script> 			
<script type="text/javascript">
function openpopup2(popurl){
var winpops=window.open(popurl,"","top=200,left=300,width=650,height=610,scrollbars=yes,resizable=yes")
}
</script> 
<cfparam name="confirmed_mod" default="">
  <cfparam name="confirmed_spkr" default="">
<cfparam name="url.month" default="#month(now())#" type="numeric">
<cfparam name="url.year" default="#year(now())#" type="numeric">
<cfparam name="url.day" default="#day(now())#" type="numeric">

<cfset month = url.month>
<cfset year = url.year>
<cfset day = url.day>

<cfset today = createdate(year, month, day)>
<cfset tomorrow = dateAdd('d', 1, today)>
<cfset yesterday = dateAdd('d', -1, today)>


<cfset firstDay = createDate(year,month,1)>
<cfset firstDOW = dayOfWeek(firstDay)>
<cfset dim = daysInMonth(firstDay)>

<cfset lastMonth = dateAdd("m",-1,firstDay)>
<cfset nextMonth = dateAdd("m",1,firstDay)>

<cfif month(now()) EQ month>
  <cfset IsCurrentMonth = true>
<cfelse>
  <cfset IsCurrentMonth = false>  
</cfif> 

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
		  Where meetingdate = '#month#/#day#/#year#'
		  Order By MtgStartTime, Status
	  </cfquery>
	  
<cfobject component="PMS.COM.Scheduling" name="Schedule"> 
<cfset getactiveProj = Schedule.getactiveProjects()>

<!--- Include special StyleSheet --->
  <link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />



<cfset dayList = "">


<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Master Schedule-Day View" bodyPassthrough="onLoad='init()'" doAjax="True">
<!--- Ajax Javascript --->
<script type="text/javascript">
  function init(){
  }
  
  function toggle( targetId ) {
	 xPos = event.screenX
     yPos = event.screenY
	 target = document.getElementById( targetId );
	 target.style.display = "block";
	 target.style.top = yPos; 
	}
	function closeedit( targetId ) {
			   
	  target = document.getElementById( targetId );
	  target.style.display = "none";
			
	}

</script>

<cfoutput><div id="maintemplate" class="maintemplate">
	<div id="maintitle" class="maintitle"><strong style="font-size:14px;">Global Calendar</strong></div>
	<div id="viewnav" class="viewNav">View:&nbsp;Day&nbsp;|&nbsp;<a href="dsp_globalscheduleWeek.cfm?month=#month#&Year=#year#"><u>Week</u></a>&nbsp;|&nbsp;<a href="dsp_globalschedule.cfm?month=#month#&Year=#year#"><u>Month</u></a>&nbsp;|&nbsp;<a href="dsp_globalscheduleYear.cfm?month=#month#&Year=#year#"><u>Year</u></a>&nbsp;|&nbsp;<a href="javascript:openpopup3('new_meeting.cfm?month=#url.month#&year=#url.year#')"><u>Add a New Meeting</u></a>
&nbsp;|&nbsp;<a href="javascript:history.go(0)"><u>Refresh Page</u></a>

</cfoutput>
   
   <br><br>

 <table border="0" cellpadding="0" cellspacing="0">
       <tr>
		  <td width="1">
<cfoutput><a href="scheduleasExcel.cfm?day_excel=yes&begin_date=#url.month#/#url.day#/#url.year#&end_date=#url.month#/#url.day#/#url.year#"><img src="/Images/excelico.gif" alt="Download Spreadsheet" width="16" height="16" border="0" align="middle" hspace="2"></a></td>
<td>
<a href="scheduleasExcel.cfm?day_excel=yes&begin_date=#url.month#/#url.day#/#url.year#&end_date=#url.month#/#url.day#/#url.year#">Download Day as Spreadsheet</a>
</cfoutput>

</td></tr></table>

	<div id="daycalendar" class="daycalendar">
	  <cfoutput>
	     <br><br>
	  <table border="0" cellpadding="3" cellspacing="0" width="100%">
		   <tr>
		       <td valign="top" width="150">
				    <table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="##e7e7e7">
					   <tr>
					       <td bgcolor="##ffffff"><cfmodule template="#Application.TagPath#/ctags/CalendarWorkON.cfm" month="#Month#" year="#Year#"></td>
					      </tr>
					   </table>            
				  </td>
		       <td>    
			  <table border="0" cellpadding="0" cellspacing="0" width="100%">
		       <tr class="caltop">
				  <td colspan="7" align="center">
				     <table border="0" cellpadding="0" cellspacing="0">
				        <tr>
				           <td align="center" class="calmonth"><a href="dsp_globalScheduleDay.cfm?month=#month(yesterday)#&Day=#Day(yesterday)#&year=#year(yesterday)#"><img src="/Images/arrow_L.gif" width="10" height="10" alt="" border="0"></a>&nbsp;&nbsp;#monthAsString(month)# #Day(today)# #year#&nbsp;&nbsp;<a href="dsp_globalScheduleDay.cfm?month=#month(tomorrow)#&Day=#Day(tomorrow)#&year=#year(tomorrow)#"><img src="/Images/arrow_r.gif" width="10" height="10" alt="" border="0"></a></td>
				       </tr>
				   </table>           
				  </td>
				</tr>
		      </table>     			  
			  
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
	  <a href="javascript:openpopup2('edit_Schedule.cfm?day=#url.day#&month=#url.month#&year=#url.year#&meetingcode=#getDayList2.meetingcode#')">
	   
<!--- <a href="edit_Schedule.cfm?day=#url.day#&month=#url.month#&year=#url.year#&meetingcode=#getDayList2.meetingcode#"> ---><span 

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
	   
		  <!--- <cfif #getDayList2.SpeakerExists# EQ 0>&nbsp;
		<cfelse>  --->
	<cfquery name="get_selected_speakers" datasource="#application.projdsn#"> 
Select 
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
		  sp.speakerid = #get_selected_speakers.speakerid#
			
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

</table>
			  
			   <!---  <table border="0" cellpadding="3" cellspacing="1" width="90%" align="center">
			   <tr  class="dayviewtable">
						   <td align="left"><font face="verdana" size="1"><strong>Time</strong></font></td>	
						   <td align="left"><font face="verdana" size="1"><strong>Project</strong></font></td>							   
				   					<td align="left" nowrap><font face="verdana" size="1"><strong>Status</strong></font></td>
				
									   </tr>  
					 <tr>
			       
						
		                      <cfloop query="getDayList2">
		                         <tr>
								 <td>#TimeFormat(getDayList2.MtgStartTime, 'hh:mm tt')#</td>
								 <td>
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

<a href="javascript:openpopup2('edit_Schedule.cfm?day=#url.day#&month=#url.month#&year=#url.year#&meetingcode=#getDayList2.meetingcode#&time=#getDayList2.MtgStartTime#')"><span 

<cfif getDayList2.status IS 'CPS'>
class="meeting_canceled"
<cfelseif getDayList2.status IS 'CPA'>class="meeting_canceled"<cfelseif getDayList2.status IS 'CPI'>class="meeting_canceled"<cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_spkr# is 'yes' AND #confirmed_mod# is 'yes'>class="fullystaffed"<cfelseif #Right(getDayList2.projectCode, 2)# is 'CT' AND getDayList2.ModeratorExists GT 0 AND #confirmed_mod# is 'yes'>class="fullystaffed"<cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_spkr# is 'yes' AND #confirmed_mod# is 'no'>class="nomoderator"<cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_mod# is 'yes'>class="nospeaker"<cfelseif getDayList2.status IS 'C'>class="meeting_canceled"
<cfelse>class="nostaff"</cfif>>
<font face="verdana" size="1"><u>#getDayList2.projectCode#</u></span></a></font> 
</td> <td>#getDayList2.Status#</td>
							  
							  </tr>  </cfloop>	
		                          
					    </td>
					 </tr>	
					
		      </table>
	     </td>
        </tr>
      </table> --->
	    </cfoutput>        
	</div>
	<div id="addeventlink" class="addeventlink">
	 <cfoutput>
	  <form>
	    <strong>Filter by Project:</strong>
	    <select name="project">
		   <option value="">--ALL--</option>
		   <cfloop query="getactiveProj">
	        <option value="#getactiveProj.Project_Code#">#getactiveProj.Project_Code#</option>
		   </cfloop>
	    </select>
	  </form>
	  </cfoutput>
	</div>
	<hr size="1">
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
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">  