<cfparam name="attributes.month" default="#month(now())#">
<cfparam name="attributes.year" default="#year(now())#">
<cfparam name="attributes.daylist" default="0">
<cfparam name="attributes.CalTopBground" default="##f7f7f7">
<cfparam name="attributes.CalBground" default="##ffffff">
<cfparam name="attributes.Calwidth" default="150">

<cfoutput>
	 <style type="text/css">
			.calendar_table{
				font-family: verdana;
				font-size: 10px;
				text-align: center;
				background-color: #Attributes.CalBground#;
				width: 100%;
			}
			.caltop{
				font-family: verdana;
				font-size: 11px;
				background-color: #Attributes.CalTopBground#;
				font-weight: bold;
				border-bottom-style: solid;
				border-bottom-width: 1px;
				border-bottom-color: Silver;
				padding-top: 3px;
				padding-bottom: 5px;

			}
			.caltoday{
				background-color: ##eeeeee;
				font-family: verdana;
				font-size: 10px;
			}
			.calbusy{
				background-color: ##ffcc00;
				font-family: verdana;
				font-size: 10px;
			}
</style>
<script>
  function change_status_day(celldate){
     getelementbyid(celldate).class = calbusy;
  }
</script>
</cfoutput>

<cfset month = Attributes.Month>
<cfset year = Attributes.Year>



<cfset dayList = attributes.Daylist>

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

<!--- <cfoutput>
	<div class="calendartop" align="center">
		<a href="/Events/ListEvents.cfm?mode=month&month=#month(lastMonth)#&year=#year(lastMonth)#">&lt;&lt;</a>
		<a href="/Events/ListEvents.cfm?mode=month&month=#month#&year=#year#">#monthAsString(month)# #year#</a>
		<a href="/Events/ListEvents.cfm?mode=month&month=#month(nextMonth)#&year=#year(nextMonth)#">&gt;&gt;</a>
	</div>
</cfoutput> --->



<!--- figure out the pad, ie, how many blank days before 1st --->
<cfset dayCounter = 1>
<cfoutput>

<center><table border=0 class="calendar_table">
<tr class="caltop">
  <td colspan="7" align="center">
     <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
		   <td align="left"><strong><<</strong></td>
           <td align="center">#monthAsString(month)# #year#</td>
		   <td align="right"><strong>>></strong></td></td>
       </tr>
   </table>           
  </td>
</tr>
<tr><td>Sun</td><td>Mon</td><td>Tue</td><td>Wed</td><td>Thu</td><td>Fri</td><td>Sat</td></tr>
</cfoutput>
<!--- loop until 1st --->
<cfoutput><tr></cfoutput>
<cfloop index="x" from=1 to="#firstDOW-1#">
	<cfoutput><td>&nbsp;</td></cfoutput>
</cfloop>
<cfloop index="x" from="#firstDOW#" to="7">
	<cfoutput><td id="calday_#month##daycounter##year#" <cfif daycounter EQ now()>class="caltoday"</cfif>>#dayCounter#</td></cfoutput>
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
		<td id="calday_#month##daycounter##year#">#x#</td>
  </cfoutput>
	<cfset rowCounter = rowCounter + 1>
	<cfif rowCounter is 8>
		<cfoutput></tr></cfoutput>
		<cfset rowCounter = 1>
	</cfif>
</cfloop>
<!--- now finish up last row --->
<cfloop index="x" from="#rowCounter#" to=7>
	<cfoutput><td>&nbsp;</td></cfoutput>
</cfloop>
<cfoutput></tr></table></center></cfoutput>