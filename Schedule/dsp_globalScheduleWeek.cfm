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
<cfset nextweek  = dateAdd('d', 7, today)> 
<cfset lastweek  = dateAdd('d', -7, today)> 


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

<cfobject component="PMS.COM.Scheduling" name="Schedule"> 
<cfset getactiveProj = Schedule.getactiveProjects()>

<!--- Include special StyleSheet --->
  <link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />



<cfset dayList = "">


<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Master Schedule-Week View" bodyPassthrough="onLoad='init()'" doAjax="True">
<!--- Ajax Javascript --->
<script type="text/javascript">
  function init(){
  }
  
  function toggle( targetId ) {
	   if ( document.getElementById ) {
	    target = document.getElementById( targetId );
	    if ( target.style.display == "none" ) {
	     target.style.display = "block";
	    } else {
	     target.style.display = "none";
	    }
	   }
	}

</script>
<cfoutput>
<div id="maintemplate" class="maintemplate">
	<div id="maintitle" class="maintitle"><strong style="font-size:14px;">Global Calendar</strong></div>
	<div id="viewnav" class="viewNav">View:&nbsp;<a href="dsp_globalScheduleDay.cfm?month=#url.month#&year=#url.year#"><u>Day</u></a>&nbsp;|&nbsp;Week&nbsp;|&nbsp;<a href="dsp_globalschedule.cfm?month=#url.month#&year=#url.year#"><u>Month</u></a>
&nbsp;|&nbsp;<a href="dsp_globalScheduleYear.cfm?month=#url.month#&year=#url.year#"><u>Year</u></a>&nbsp;|&nbsp;<a href="javascript:openpopup3('new_meeting.cfm?month=#url.month#&year=#url.year#')"><u>Add a New Meeting</u></a>&nbsp;|&nbsp;<a href="javascript:history.go(0)"><u>Refresh Page</u></a>
</cfoutput>
<br><br>

 <table border="0" cellpadding="0" cellspacing="0">
       <tr>
		  <td width="1"><cfoutput>
<a href="excel_set.cfm?month=#url.month#&year=#url.year#"><img src="/Images/excelico.gif" alt="Download Spreadsheet" width="16" height="16" border="0" align="middle" hspace="2"></a></td>
<td><a href="excel_set.cfm?month=#url.month#&year=#url.year#">Download Week as Spreadsheet</a></cfoutput></td></tr></table>

	<div id="daycalendar" class="daycalendar">
	  <cfoutput>
	  <table border="0" cellpadding="0" cellspacing="0" width="100%">
       <tr class="caltop">
		  <td colspan="7" align="center">
		     <table border="0" cellpadding="0" cellspacing="0">
		        <tr>
		           <td align="center" class="calmonth"><a href="dsp_globalScheduleWeek.cfm?month=#month(lastweek)#&Day=#Day(lastweek)#&year=#year(lastweek)#"><img src="/Images/arrow_L.gif" width="10" height="10" alt="" border="0"></a>&nbsp;&nbsp;#DateFormat(today, 'DDD MMM D YYYY')# - #DateFormat(dateadd('d', 6, today), 'DDD MMM D YYYY')# &nbsp;&nbsp;<a href="dsp_globalScheduleWeek.cfm?month=#month(nextweek)#&Day=#Day(nextweek)#&year=#year(nextweek)#"><img src="/Images/arrow_r.gif" width="10" height="10" alt="" border="0"></a></td>
		       </tr>
		   </table>           
		  </td>
		</tr>
      </table>  
	  
	  	  
	           
	  <table border="1" cellpadding="3" cellspacing="1" width="100%">
		     <tr>
			   <td bgcolor="##eeeeee" align="left" valign="top" width="14%"><strong>#DateFormat(today, 'DDD mmm D')#</strong><hr size="2">
			   	
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
		  Where M.meetingdate = '#DateFormat(today, 'm/dd/yyyy')#'
		  Order By MtgStartTime, Status	 	  
		</cfquery>

				<cfloop query="getDayList2">
				
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
	   
	   
	   
<cfset zoom_day = "#DateFormat(today, "dd")#">
<cfset zoom_month = "#DateFormat(today, "mm")#">
<cfset zoom_year = "#DateFormat(today, "yyyy")#">  
	   
<span style="color:##5f5f5f;">#TimeFormat(getDayList2.MtgStartTime, 'hh:mm tt')#</span><br>

<a href="javascript:openpopup2('zoom_Schedule.cfm?day=#zoom_day#&month=#zoom_month#&year=#zoom_year#')">
<span 
<cfif getDayList2.status IS 'CPS'>
class="meeting_canceled"
<cfelseif getDayList2.status IS 'CPA'>class="meeting_canceled"<cfelseif getDayList2.status IS 'CPI'>class="meeting_canceled"<cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_spkr# is 'yes' AND #confirmed_mod# is 'yes'>class="fullystaffed"<cfelseif #Right(getDayList2.projectCode, 2)# is 'CT' AND getDayList2.ModeratorExists GT 0 AND #confirmed_mod# is 'yes'>class="fullystaffed"<cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_spkr# is 'yes' AND #confirmed_mod# is 'no'>class="nomoderator"<cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_mod# is 'yes'>class="nospeaker"<cfelseif getDayList2.status IS 'C'>class="meeting_canceled"
<cfelse>class="nostaff"</cfif>><u>#getDayList2.projectCode#</u></span></a><br><br>

</cfloop>  		   			   
			   		      
			  			   
			 <cfloop index="x" from="1" to="6">
			   <td bgcolor="##eeeeee" align="left" valign="top" width="14%"><strong>#DateFormat(dateadd('d', x, today), 'DDD mmm D')#</strong><hr size="2">		 
			 
		
		
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
		  Where M.meetingdate = '#DateFormat(dateadd('d', x, today), 'm/dd/yyyy')#' 
		  Order By MtgStartTime, Status
		</cfquery>
		
	 			<cfloop query="getDayList2">
				
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
	   
<cfset zoom_day = "#DateFormat(dateadd('d', x, today), 'dd')#">
<cfset zoom_month = "#DateFormat(dateadd('d', x, today), 'mm')#">
<cfset zoom_year = "#DateFormat(dateadd('d', x, today), 'yyyy')#">  
	   
<span style="color:##5f5f5f;">#TimeFormat(getDayList2.MtgStartTime, 'hh:mm tt')#</span><br>

 <a href="javascript:openpopup2('zoom_Schedule.cfm?day=#zoom_day#&month=#zoom_month#&year=#zoom_year#')">
<span 
<cfif getDayList2.status IS 'CPS'>
class="meeting_canceled"
<cfelseif getDayList2.status IS 'CPA'>class="meeting_canceled"<cfelseif getDayList2.status IS 'CPI'>class="meeting_canceled"<cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_spkr# is 'yes' AND #confirmed_mod# is 'yes'>class="fullystaffed"<cfelseif #Right(getDayList2.projectCode, 2)# is 'CT' AND getDayList2.ModeratorExists GT 0 AND #confirmed_mod# is 'yes'>class="fullystaffed"<cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_spkr# is 'yes' AND #confirmed_mod# is 'no'>class="nomoderator"<cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_mod# is 'yes'>class="nospeaker"<cfelseif getDayList2.status IS 'C'>class="meeting_canceled"
<cfelse>class="nostaff"</cfif>>
<u>#getDayList2.projectCode#</u>

</span></a><br><br>

</cfloop>  
				
				</td>
				</cfloop>
						</tr>	 				
	  </table>
	  
	    <table border="0" cellpadding="3" cellspacing="2" align="right">
	          <tr>
	            <td colspan="2"><strong>LEGEND:</strong></td>
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
	  
	  
	  
	    </cfoutput>        
	</div>

<cfmodule template="#Application.tagpath#/ctags/footer.cfm">  