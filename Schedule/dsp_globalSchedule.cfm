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
<cfsilent>

<cfparam name="url.month" default="#month(now())#" type="numeric">
<cfparam name="url.year" default="#year(now())#" type="numeric">

<cfset month = url.month>
<cfset year = url.year>

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

<cfset dayList = "">

</cfsilent>

 <cfparam name="confirmed_mod" default="">
  <cfparam name="confirmed_spkr" default="">

<!--- Ajax Javascript --->
<!--- Include special StyleSheet --->
	 <link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Master Schedule-Month View" bodyPassthrough="" doAjax="True">
<cfoutput>


	<script type="text/javascript">
		   function openedit( targetId, dayclicked ) {
		
			   target = document.getElementById( targetId );
			   target.style.display = "block";
			   
			   var day = (dayclicked - 1);
			   var formvar = document.mtgedit.day; 
			   formvar.selectedIndex = day;
			
			}
			function closeedit( targetId ) {
			   
			   target = document.getElementById( targetId );
			   target.style.display = "none";
			
			}
			function showModForm(){
			   hide1  = document.getElementById('meetingform');
			   hidetab1 = document.getElementById('mtgtab');
			   hide2  = document.getElementById('SpkrScheduleForm');
			   hidetab2 = document.getElementById('spkrtab');
			   target = document.getElementById('ModScheduleForm');
			   targettab = document.getElementById('modtab');
			   warning = document.getElementById('opaquewindow');
			   
			   warning.style.display="block";
			   hide1.style.display = "none";
			   hidetab1.className = "taboff";
			   hide2.style.display = "none";
			   hidetab2.className = "taboff";
			   target.style.display = "block";
			   targettab.className = "tabon";
			   
			   
			}
			function showSpkrForm(){
			   hide1  = document.getElementById('meetingform');
			   hidetab1  = document.getElementById('mtgtab');
			   
			   hide2  = document.getElementById('ModScheduleForm');
			   hidetab2  = document.getElementById('modtab');
			   
			   target = document.getElementById('SpkrScheduleForm');
			   targettab = document.getElementById('spkrtab');
			   warning = document.getElementById('opaquewindow');
			   
			   warning.style.display="block";
			   hide1.style.display = "none";
			   hidetab1.className = "taboff";
			   hide2.style.display = "none";
			   hidetab2.className = "taboff";
			   target.style.display = "block";
			   targettab.className = "tabon";
			   
			   
			   
			}
			function showMtgForm(){
			   hide1  = document.getElementById('ModScheduleForm');
			   hidetab1  = document.getElementById('modtab');
			   
			   hide2  = document.getElementById('SpkrScheduleForm');
			   hidetab2  = document.getElementById('spkrtab');
			   
			   target = document.getElementById('meetingform');
			   targettab = document.getElementById('mtgtab');
			   warning = document.getElementById('opaquewindow');
			   
			   hide1.style.display = "none";
			   hidetab1.className = "taboff";
			   hide2.style.display = "none";
			   hidetab2.className = "taboff";
			   target.style.display = "block";
			   targettab.className = "tabon";
			   warning.style.display="none";
			   
			}
		    function setDayyesivity(day) {
		       var thisday = day
		       var cellid  = "calcell_" + thisday;
		       var daycell = document.getElementById(cellid);
			 
	  }
		</script>
</cfoutput>
<div id="maintemplate" class="maintemplate">
	<div id="maintitle" class="maintitle"><strong style="font-size:14px;">Global Calendar</strong></div>
	<cfoutput>
	<div id="viewnav" class="viewNav">View:&nbsp;<a href="dsp_globalscheduleDay.cfm?month=#month#&Year=#year#"><u>Day</u></a>&nbsp;|&nbsp;<a href="dsp_globalScheduleWeek.cfm?month=#month#&Year=#year#"><u>Week</u></a>&nbsp;|&nbsp;Month&nbsp;|&nbsp;<a href="dsp_globalScheduleYear.cfm?month=#url.month#&year=#url.year#"><u>Year</u></a>&nbsp;|&nbsp;<a href="javascript:openpopup3('new_meeting.cfm?month=#url.month#&year=#url.year#')"><u>Add a New Meeting</u></a>&nbsp;|&nbsp;<a href="javascript:history.go(0)"><u>Refresh Page</u></a><br><br>

 <table border="0" cellpadding="0" cellspacing="0">
       <tr>
		  <td width="1">
	  
 <a href="scheduleasExcel.cfm?month_excel=yes&begin_date=#url.month#/01/#url.year#&end_date=#url.month#/31/#url.year#"><img src="/Images/excelico.gif" alt="Download Spreadsheet" width="16" height="16" border="0" align="middle" hspace="2">

</a></td>
<td><a href="scheduleasExcel.cfm?month_excel=yes&begin_date=#url.month#/01/#url.year#&end_date=#url.month#/30/#url.year#"><u> Download Month Spreadsheet</u></a></td></tr></table>
    </cfoutput>
	<div id="filterproj" class="filterproj">
	 <cfoutput>
	  <form method="POST">
	    <strong>Filter by Project:</strong>
	    <select name="projectfilter" onchange="this.form.submit();">
		   <option value="">--ALL--</option>
		   <cfloop query="getactiveProj">
	        <option value="#getactiveProj.Project_Code#" <cfif isDefined("form.projectfilter")><cfif trim(form.projectfilter) EQ trim(getactiveProj.Project_Code)>Selected</cfif></cfif>>#getactiveProj.Project_Code#</option>
		   </cfloop>
	    </select>
	  </form>
	  </cfoutput><br>
	</div>
	<div id="maincalendar" class="maincalendar">
	   <cfset dayCounter = 1>
		<cfoutput>
		
		<center><table border=0 class="calendar_table" align="center">
		<tr class="caltop">
		  <td colspan="7" align="center">
		     <table border="0" cellpadding="0" cellspacing="0">
		        <tr>
		           <td align="center" class="calmonth"><a href="dsp_globalSchedule.cfm?month=#month(lastmonth)#&year=#year(lastmonth)#"><img src="/Images/arrow_L.gif" width="10" height="10" alt="" border="0"></a>&nbsp;&nbsp;#monthAsString(month)# #year#&nbsp;&nbsp;<a href="dsp_globalSchedule.cfm?month=#month(nextmonth)#&year=#year(nextmonth)#"><img src="/Images/arrow_r.gif" width="10" height="10" alt="" border="0"></a></td>
		       </tr>
		   </table>           
		  </td>
		</tr>
		<tr>
		  <td class="caldayofweek">Sun</td>
		  <td class="caldayofweek">Mon</td>
		  <td class="caldayofweek">Tue</td>
		  <td class="caldayofweek">Wed</td>
		  <td class="caldayofweek">Thu</td>
		  <td class="caldayofweek">Fri</td>
		  <td class="caldayofweek">Sat</td>
		</tr>
		</cfoutput>
		<!--- loop until 1st --->
		<cfoutput><tr></cfoutput>
		
		
		<cfloop index="x" from=1 to="#firstDOW-1#">
			<cfoutput><td class="blankcell">&nbsp;</td></cfoutput>
		</cfloop>
		
		
		
		 <cfloop index="x" from="#firstDOW#" to="7">
		   <cfif IsDefined("form.projectfilter")>
		     <cfif Len(Trim(form.projectfilter)) GT 0>
			    <cfset getDayList = Schedule.getDayProjects(month, dayCounter, year, Trim(form.ProjectFilter))>
		     <cfelse>
			    <cfset getDayList = Schedule.getDayProjects(month, dayCounter, year)>
			 </cfif>
		   <cfelse>
		     <cfset getDayList = Schedule.getDayProjects(month, dayCounter, year)>
		   </cfif>
		   
			<cfoutput><td <cfif month(now()) EQ month>
			                    <cfif daycounter EQ day(now())>
								   class="caltoday"
								<cfelse>
								   class="calday"
								</cfif>
						  <cfelse>
						     class="calday"
						  </cfif> 
						  id="calcell_#dayCounter#" 
						  valign="top" align="left">
						   <table border="0" cellpadding="0" cellspacing="0">
		        <tr>
		           <td align="left" valign ="top">
						#dayCounter#.&nbsp;</td><td>
							 
							  
<a href="javascript:openpopup2('zoom_Schedule.cfm?day=#dayCounter#&month=#url.month#&year=#url.year#')"><img src="/Images/glass.gif" alt="Zoom" border="0"></a></td></tr></table>
							 
							 <div class="daycontent" id="daycontent_#dayCounter#">
							   <cfloop query="getDayList">							   
							 <cfif  #getDayList.SpeakerExists# is ''>
	   <cfset #getDayList.SpeakerExists# = 0></cfif>
<cfif  #getDayList.ModeratorExists# is ''>
	   <cfset #getDayList.ModeratorExists# = 0></cfif>  


<br><span style="color:##5f5f5f;">#TimeFormat(getDayList.MtgStartTime, 'hh:mm tt')#</span>

<span 

<cfif getDayList.ModeratorExists GT 0 AND getDayList.SpeakerExists GT 0>class="fullystaffed"

<cfelseif getDayList.ModeratorExists EQ 0 AND getDayList.SpeakerExists GT 0>class="nomoderator"

<cfelseif getDayList.ModeratorExists GT 0 AND getDayList.SpeakerExists EQ 0>class="nospeaker"

<cfelse>class="nostaff"</cfif>>#Trim(getDayList.projectCode)#</span><br>
								  
							   </cfloop> 
							 </div>
					   </td>
					   </cfoutput>
			<cfset dayCounter = dayCounter + 1>
		</cfloop>
		
		
		
		</tr>
		<!--- now loop until month days --->
		<cfset rowCounter = 1>
		
		<cfloop index="x" from="#dayCounter#" to="#dim#">
		  <cfif IsDefined("form.projectfilter")>
		     <cfif form.projectfilter NEQ "">
			    <cfset getDayList2 = Schedule.getDayProjects(month, x, year, Trim(form.ProjectFilter))>
		     <cfelse> 
			    <cfset getDayList2 = Schedule.getDayProjects(month, x, year)>
			 </cfif>
		   <cfelse>
		     <cfset getDayList2 = Schedule.getDayProjects(month, x, year)>
		   </cfif>
		   
			<cfif rowCounter is 1>
				<cfoutput><tr></cfoutput>
			</cfif> 
			<cfoutput>
				<td 
<cfif month(now()) EQ month>
<cfif x EQ day(now())>class="caltoday"

<cfelse>class="calday"</cfif>

<cfelse>class="calday"</cfif> id="calcell_#x#" valign="top" align="left">

<table border="0" cellpadding="0" cellspacing="0">
		        <tr>
		           <td align="left" valign ="top">

<cfif Len(#x#) LT 2>#x#.&nbsp;<cfelse>#x#.</cfif></td>
<td align="left" valign ="top">
<!--- <cfloop query="getDayList2" startrow="1" endrow="1"> --->

<a href="javascript:openpopup2('zoom_Schedule.cfm?day=#x#&month=#url.month#&year=#url.year#')"><img src="/Images/glass.gif" alt="Zoom" border="0"></a></td></tr></table>
<!--- </cfloop> --->

<div class="daycontent" id="daycontent_#x#">

<cfloop query="getDayList2">
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
	   
<span style="color:##5f5f5f;">#TimeFormat(getDayList2.MtgStartTime, 'hh:mm tt')#</span><br><span 

<cfif getDayList2.status IS 'CPS'>
class="meeting_canceled"
<cfelseif getDayList2.status IS 'CPA'>class="meeting_canceled"<cfelseif getDayList2.status IS 'CPI'>class="meeting_canceled"<cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_spkr# is 'yes' AND #confirmed_mod# is 'yes'>class="fullystaffed"<cfelseif #Right(getDayList2.projectCode, 2)# is 'CT' AND getDayList2.ModeratorExists GT 0 AND #confirmed_mod# is 'yes'>class="fullystaffed"<cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_spkr# is 'yes' AND #confirmed_mod# is 'no'>class="nomoderator"<cfelseif getDayList2.ModeratorExists GT 0 AND getDayList2.SpeakerExists GT 0 AND #confirmed_mod# is 'yes'>class="nospeaker"<cfelseif getDayList2.status IS 'C'>class="meeting_canceled"
<cfelse>class="nostaff"</cfif>>#Trim(getDayList2.projectCode)#</span><br><br>

</cfloop>  

</div></td> 
		  </cfoutput>
			<cfset rowCounter = rowCounter + 1>
			<cfif rowCounter is 8>
				<cfoutput></tr></cfoutput>
				<cfset rowCounter = 1>
			</cfif>
		</cfloop>
		<!--- now finish up last row --->
		<cfloop index="x" from="#rowCounter#" to=7>
			<cfoutput><td class="blankcell">&nbsp;</td></cfoutput>
		</cfloop>
		<cfoutput></tr></table></center></cfoutput>
		
	</div>
	
	<div id="uploadcell" class="uploadcell">
	   <table border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
       <td valign="top">
	   
	  &nbsp;</td>
	   <td valign="top" align="right">
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
	   </td>
      </tr>
   </table>           
	  
	  </div>
	
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">  







