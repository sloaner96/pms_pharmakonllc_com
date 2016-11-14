<cfsilent>
<!---
    $Id: ,v 1.0 2006/04/06 rsloan Exp $
    Copyright (c) 2006 Pharmakon, LLC.

    Description: This is the main monthly calendar for the schedule.
        
    Usage:Everything will happen here with the ajax interface.
        
        
--->


<cfparam name="url.month" default="#month(now())#" type="numeric">
<cfparam name="url.day" default="#day(now())#" type="numeric">
<cfparam name="url.year" default="#year(now())#" type="numeric">

<cfset month = url.month>
<cfset day = url.day>
<cfset year = url.year>

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

<!--- Invoke Component and Call Methods --->
<cfobject component="PMS.COM.Scheduling" name="Schedule"> 
<cfset getactiveProj = Schedule.getactiveProjects()>
<cfset getHourData = Schedule.getTimeProjects(month, day, year)>

<cfset dayList = "">

</cfsilent>
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
<!--- Include special StyleSheet --->
	 <link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Master Schedule- List View" bodyPassthrough="" doAjax="True">
<div id="maintemplate" class="maintemplate">
	<div id="maintitle" class="maintitle"><strong style="font-size:14px;">Global Calendar</strong></div>
	<cfoutput>
	<div id="viewnav" class="viewNav">View:&nbsp;<a href="dsp_globalscheduleDay.cfm?month=#month#&Year=#year#">Day</a>&nbsp;|&nbsp;<a href="dsp_globalScheduleWeek.cfm?month=#month#&Year=#year#">Week</a>&nbsp;|&nbsp;<a href="dsp_globalschedule.cfm">Month</a>&nbsp;|&nbsp;<a href="dsp_globalScheduleyear.cfm?Year=#year#">Year</a>&nbsp;|&nbsp;LIST</div>
    </cfoutput>
	<div id="filterproj" class="filterproj">
	 <cfoutput>
	  <form method="POST">
	    <strong>Filter by Project:</strong>
	    <select name="projectfilter" onchange="this.form.submit();">
		   <option value="">--ALL--</option>
		   <cfloop query="getactiveProj">
	        <option value="#getactiveProj.Project_Code#">#getactiveProj.Project_Code#</option>
		   </cfloop>
	    </select>
	  </form>
	  </cfoutput>
	</div>
	<div id="maincalendar" class="maincalendar">
	<table border="0" cellpadding="4" cellspacing="0" width="100%">
       <tr>
          <td valign="top" width="150">
		    <table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#e7e7e7">
			   <tr>
			       <td bgcolor="#ffffff"><cfmodule template="#Application.TagPath#/ctags/CalendarWorkON.cfm" month="#Month#" year="#Year#"></td>
			      </tr>
			   </table>            
		  </td>
		  <td valign="top">
		     <table border="0" cellpadding="0" cellspacing="0" width="100%">
		       <tr class="caltop">
				  <td colspan="7" align="center">
				     <cfoutput>
					 <table border="0" cellpadding="0" cellspacing="0">
				        <tr>
				           <td align="center" class="calmonth"><a href="dsp_globalList.cfm?month=#month(yesterday)#&Day=#Day(yesterday)#&year=#year(yesterday)#"><img src="/Images/arrow_L.gif" width="10" height="10" alt="" border="0"></a>&nbsp;&nbsp;#monthAsString(month)# #Day(today)# #year#&nbsp;&nbsp;<a href="dsp_globalList.cfm?month=#month(tomorrow)#&Day=#Day(tomorrow)#&year=#year(tomorrow)#"><img src="/Images/arrow_r.gif" width="10" height="10" alt="" border="0"></a></td>
				       </tr>
				     </table>  
				     </cfoutput>       
				  </td>
				</tr>
		      </table>  
		     <table border="0" cellpadding="4" cellspacing="0" width="100%">
               <tr bgcolor="#999966">
                  <td><strong>Program Schedule List</strong></td>
               </tr>
             </table>
			 <br>
			 <table border="0" cellpadding="4" cellspacing="1" width="100%">
              <cfoutput query="getHourData" group="MtgStartTime">
				   <tr bgcolor="##939393">
	                  <td colspan="3"><strong>#TimeFormat(getHourData.MtgStartTime, 'hh:mm tt')#</strong></td>
	               </tr>
				   <tr bgcolor="##b7b7b7">
	                  <td>Meetingcode</td>
					  <td>Moderator</td>
					  <td>Speaker</td>
	               </tr>
				   <cfoutput>
				      <tr <cfif getHourData.currentrow MOD(2) EQ 1>bgcolor="##eeeeee"</cfif>>
	                    <td valign="top">#getHourData.projectcode#</td>
					    <td valign="top"><cfif getHourData.ModeratorExists NEQ "">
						      <cfset getMod = Schedule.getMtgMods(getHourData.ScheduleID)>
							  <cfloop query="getMod">
							    #Trim(getMod.ModName)#-#getMod.StaffDesc#<br>
							  </cfloop>
							  
							</cfif>
						</td>
					    <td><cfif getHourData.SpeakerExists NEQ "">
						      <cfset getSpkr = Schedule.getMtgSpkr(getHourData.ScheduleID)>
							  <cfloop query="getSpkr">
							    #Trim(getSpkr.SpkrName)#-#getSpkr.StaffDesc#<br>
							  </cfloop>
							</cfif></td>
	                 </tr>
				   </cfoutput>
				   <tr>
				     <td colspan="3">&nbsp;</td>
				   </tr>
			   </cfoutput>
             </table>           
		  </td>
        </tr>
    </table>           
	</div>
</div>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">  