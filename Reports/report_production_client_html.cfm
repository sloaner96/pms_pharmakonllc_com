<!--- *****************************************************************************************
	Name:		report_production_client.cfm
	
	Function:	This page displays the number of meetings per week, per project based on the 
				client and date range selected on report_production_select.cfm
	History:	lb111202 - complete
	
	*****************************************************************************************--->
<html>
<head>
<title>Client Production Schedule</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK REL=STYLESHEET HREF="PIW1STYLE.CSS" TYPE="TEXT/CSS">

<!--- <cfset Julian = 291>
<cfset YearStart = #CreateDAte(2002,1,1)#>
<cfoutput>
The regular date is #DateFormat(DateAdd("d",Julian - 1,YearStart),"mm/dd/yy")#<br>
</cfoutput>

<cfoutput>
#DayOfYear("10/29/2002")#
</cfoutput>  --->

<!--- <CFQUERY DATASOURCE="#application.projdsn#" NAME="qupdate">
UPDATE meeting_summary
SET [302] = 1
WHERE project_code = 'CZZZZ00CT'
</cfquery> --->

	<!--- set variable with the 1st day of month, ex. 1/1 or 2/1 or 3/1 etc --->
	<cfset bdate = #session.begin_date#>
	<!--- finds what day of week first day of month is --->
	<cfset bday = DayOfWeek(#bdate#)>
	<!--- Subtract this day integer from six to find out how many days are needed to get to Sat. --->
	<cfset num_sat = 7 - bday>
	<!--- Add days to the 1st day of the month to find the first Sat. of the month --->
	<cfset sat = dateAdd("d",#num_sat# + 1,#bday#)>
	<!--- 1st day of the month in julian --->
	<cfset jbdate = DayOfYear(#bdate#)>
	<!--- set last month --->
	<cfset getLastDay = #session.end_date#>
	<!--- set last month in julian --->
	<cfset eday = DaysInMonth(#getLastDay#)>
	<!--- set last day of last month --->
	<cfset edate = CreateDate(#session.end_year#,#session.end_month#,#eday#)>
	<!--- last day of the month (of date range) in julian --->
	<cfset jedate = DayOfYear(#edate#)>



<!--- REMOVE STATUS = 0 WHEN LIVE --->
<!--- pull rows from meeting summary table for this client --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qprojects">
SELECT * 
FROM meeting_summary
WHERE <cfif session.select_criteria NEQ 0>left(project_code,5) = '#session.select_criteria#' AND</cfif> (year BETWEEN #session.begin_year# AND #session.end_year#)
ORDER BY project_code
</cfquery>
</head>

<body>
<cfif qprojects.recordcount>

<!--- set array to hold project code, date, number of meetings --->
	<cfset dWeek=ArrayNew(2)>

<!--- set variable with start date in julian --->
	<cfset juliancol = #jbdate#> 
<!--- x = dynamic week number --->
	<cfset x = 1>
<!--- i = array row --->
	<cfset i = 1>
<!--- d = array cell that holds the date --->
	<cfset d = 2>
<!--- e = array cell that holds the number of meetings --->
	<cfset e = 3>

<cfoutput>#juliancol# - #jedate#</cfoutput>

<cfoutput query="qprojects">
	<!--- loop the selected calendar for each project code --->
	<cfloop condition="(juliancol + 1) LT jedate">
		<!--- set the year --->
		<cfset YearDis = #CreateDate(#qprojects.year#,1,1)#>
		
		<!--- caculate the days for the week and add the meetings for that week --->
		 		<cfset "week#x#" = 0>
				<cfset dayadd = juliancol> 
			<cfloop from="1" to="#num_sat#" index="z">
				<cfset dayadd = dayadd + 1>
				<cfset "week#x#" = #Evaluate("week#x#")# + #Evaluate("qprojects.#dayadd#")#>
			</cfloop>	

			
			<!--- set cell 1 equal to project code, then create dynamic cells to hold number
			of meetings and week date --->
			<cfset dWeek[i][1] = #qprojects.project_code#>
			<cfset dWeek[i][e] = #Evaluate("week#x#")#>
			<cfset dWeek[i][d] = #DateFormat(DateAdd("d",dayadd - 1,YearDis),"mm/dd/yy")#>
			
			
			<!--- if the last day added is less than 358 set num_sat=7 
			(will loop seven days in above loop) --->
			<cfif dayadd LTE 358>
					<cfset juliancol = #dayadd#>
					<cfset num_sat = 7>
					<!--- s:#dayadd# --->
			<!--- if last date is the end of the calendar, set juliancol to 367 to stop loop --->		
			<cfelseif dayadd GTE 365>
				<cfset juliancol = 367>
				<!--- u:#dayadd# --->
			<!--- if day add is between 359 and 364, set num_sat to number of days til end of year --->	
			<cfelse>	
				<cfset num_sat = 365 - dayadd>
				<cfset juliancol = #dayadd#>
				<!--- t:#dayadd# --->
			</cfif>
					
			<!--- set the next cell number(plus 2 to alternate between the two dynamic sets) --->
			<cfset d = d + 2>
			<cfset e = e + 2>
	</cfloop>
			<!--- reset variables back to start to loop next project code --->
			<cfset juliancol = #jbdate#>
			<cfset num_elements = d - 1>
			<cfset d = 2>
			<cfset e = 3>
			<cfset x = x + 1>
			<cfset i = i + 1>
</cfoutput>


<table align="center" border="0" cellpadding="3" cellspacing="0">
<cfoutput>
	<tr>
		<td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF; background: ##F0F8FF">&nbsp;</td>
		<!--- display week dates on first row --->
		<cfloop from="2" to="#num_elements#" index="e" step="2">
		<td style="border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF; background: ##F0F8FF">#dWeek[1][e]#</td>
		</cfloop>
		<td style="border-right: solid 1px ##6699FF; border-left: solid 1px ##6699FF; border-top: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF; background: ##F0F8FF">total</td>
	</tr>
	<tr>
<!--- loop rows of array --->	
<cfloop from="1" to="#ArrayLen(dWeek)#" step="1" index="i">
		<td style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;">#dWeek[i][1]#</td>
		<!--- inner loop displays number of meetings --->
		<cfset totalmtgs = 0>
		<cfloop from="3" to="#num_elements#" index="d" step="2">
		<td style="border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;">#dWeek[i][d]#</td>
		<cfset totalmtgs = totalmtgs + #dWeek[i][d]#>
		</cfloop>
		<td style="border-right: solid 1px ##6699FF; border-left: solid 1px ##6699FF; border-bottom: solid 1px ##6699FF;">#totalmtgs#</td>
		</tr>
</cfloop>
	</tr>
	<!--- #qprojects.grand_total#, ---> 
</cfoutput>	
</table>	 
	
<!--- Dump
<cfdump var="#dWeek#"> --->
<cfelse>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>No records matched your criteria. Please try again.</strong>

</cfif>
	<form action="report_production_select.cfm" name="back">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE="submit" NAME="submit"  VALUE="  Search Again  ">
	</form>
</body>
</html>
