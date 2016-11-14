 		 					<script type="text/javascript">
function openpopup3(popurl){
var winpops=window.open(popurl,"","top=200,left=300,width=650,height=610,scrollbars=yes,resizable=yes")
}
</script> 		
<cfparam name="url.month" default="#month(now())#" type="numeric">
<cfparam name="url.year" default="#year(now())#" type="numeric">
<cfparam name="url.day" default="#day(now())#" type="numeric">


<cfset year = url.year>
<cfset FirstdayofYear = CreateDate(url.year, 1, 1)>

<cfset NextYear = DateAdd('yyyy', 1, FirstdayofYear)>
<cfset LastYear = DateAdd('yyyy', -1, FirstdayofYear)>

<!--- Include special StyleSheet --->
	 <link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />



<cfset dayList = "">

<!--- Ajax Javascript --->
<script type="text/javascript">
  function init(){
    return true;
  }  

</script>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Master Schedule-Year View" bodyPassthrough="onLoad='init()'" doAjax="True">


<div id="maintemplate" class="maintemplate">
	<div id="maintitle" class="maintitle"><strong style="font-size:14px;">Calendar List</strong></div>
	<cfoutput>
	<div id="viewnav" class="viewNav">View:&nbsp;<a href="dsp_globalscheduleDay.cfm?month=#url.month#&year=#url.year#"><u>Day</u></a>&nbsp;|&nbsp;<a href="dsp_globalScheduleWeek.cfm?month=#url.month#&year=#url.year#"><u>Week</u></a>&nbsp;|&nbsp;<a href="dsp_globalSchedule.cfm?month=#url.month#&year=#url.year#"><u>Month</u></a>&nbsp;|&nbsp;Year&nbsp;|&nbsp;<a href="javascript:openpopup3('new_meeting.cfm?month=#url.month#&year=#url.year#')"><u>Add a New Meeting</u></a>&nbsp;|&nbsp;<a href="javascript:history.go(0)"><u>Refresh Page</u></a>

<br><br>

<table border="0" cellpadding="0" cellspacing="0">
       <tr>
		  <td width="1">
	  
 <a href="scheduleasExcel.cfm?year_excel=yes&begin_date=01/01/#url.year#&end_date=12/31/#url.year#"><img src="/Images/excelico.gif" alt="Download Spreadsheet" width="16" height="16" border="0" align="middle" hspace="2">

</a></td>
<td> <a href="scheduleasExcel.cfm?year_excel=yes&begin_date=01/01/#url.year#&end_date=12/31/#url.year#"><u> Download Year as Spreadsheet</u></a></td></tr></table>

    </cfoutput>
	<div id="maincalendar" class="maincalendar">
	  <table border="0" cellpadding="4" cellspacing="0" width="95%">
        <cfoutput>
		<tr>
		  <td colspan="3" align="center"><a href="dsp_globalScheduleYear.cfm?year=#year(LastYear)#"><img src="/Images/arrow_L.gif" width="10" height="10" alt="" border="0"></a>&nbsp;&nbsp;<strong class="calmonth">#YEAR#</strong>&nbsp;&nbsp;<a href="dsp_globalScheduleyear.cfm?year=#year(NextYear)#"><img src="/Images/arrow_r.gif" width="10" height="10" alt="" border="0"></a></td>
		</tr>
		</cfoutput>
		<tr>
                
		  <cfloop index="i" from="1" to="12">
			   <cfset dayCounter = 1>
			   <cfset rowCounter = 0>
			   
				<cfoutput>
				    <cfset thismonth = i>
					<cfset firstDay = createDate(year,thismonth,1)>
			        <cfset firstDOW = dayOfWeek(firstDay)>
			        <cfset dim = daysInMonth(firstDay)>
					
					
					
					  <td>
					<center><table border=0 class="calendar_tableyear">
					<tr class="caltopyear">
					  <td colspan="7" align="center">
					     <table border="0" cellpadding="0" cellspacing="0">
					        <tr>
					           <td align="center" class="calmonthyear"><a href="dsp_globalSchedule.cfm?month=#i#&year=#url.year#"><strong><u> #monthAsString(thismonth)#</u></strong></a></td>
					       </tr>
					   </table>           
					  </td>
					</tr>
					<tr>
					  <td class="caldayofweekyear">Sun</td>
					  <td class="caldayofweekyear">Mon</td>
					  <td class="caldayofweekyear">Tue</td>
					  <td class="caldayofweekyear">Wed</td>
					  <td class="caldayofweekyear">Thu</td>
					  <td class="caldayofweekyear">Fri</td>
					  <td class="caldayofweekyear">Sat</td>
					</tr>
					</cfoutput>
					<!--- loop until 1st --->
					<cfoutput><tr></cfoutput>
					<cfloop index="x" from=1 to="#firstDOW-1#">
						<cfoutput><td class="blankcellyear">&nbsp;</td></cfoutput>
					</cfloop>
					<cfloop index="x" from="#firstDOW#" to="7">
						<cfoutput><td <cfif month(now()) EQ thismonth><cfif daycounter EQ day(now())>class="caltodayyear"<cfelse>class="caldayyear"<</cfif><cfelse>class="caldayyear"</cfif> valign="top" align="left"><a href="dsp_globalScheduleDay.cfm?month=#i#&day=#dayCounter#&year=#url.year#">#dayCounter#</a><br></td></cfoutput>
						<cfset dayCounter = dayCounter + 1>
					</cfloop>
					<cfoutput></tr></cfoutput>
					<!--- now loop until month days --->
					<cfset rowCounter = 1>
					<cfloop index="x" from="#dayCounter#" to="#dim#">
						<cfif rowCounter is 1>
							<cfoutput><tr></cfoutput>
						</cfif>
						<cfoutput>
							<td  <cfif month(now()) EQ thismonth><cfif x EQ day(now())>class="caltodayyear"<cfelse>class="caldayyear"<</cfif><cfelse>class="caldayyear"</cfif> valign="top" align="left"><a href="dsp_globalScheduleDay.cfm?month=#i#&day=#x#&year=#url.year#">#x#</a><br></td>
					  </cfoutput>
						<cfset rowCounter = rowCounter + 1>
						<cfif rowCounter is 8>
							<cfoutput></tr></cfoutput>
							<cfset rowCounter = 1>
						</cfif>
					</cfloop>
					<!--- now finish up last row --->
					<cfloop index="x" from="#rowCounter#" to=7>
						<cfoutput><td class="blankcellyear">&nbsp;</td></cfoutput>
					</cfloop>
					<cfoutput></tr></table></center></cfoutput>
					</td>
					
					<cfif thismonth MOD(3) EQ 0></tr><tr><td colspan="3">&nbsp;</td></tr><tr></cfif>
			</cfloop>
	  </table> 	
	</div>

<cfmodule template="#Application.tagpath#/ctags/footer.cfm">  
