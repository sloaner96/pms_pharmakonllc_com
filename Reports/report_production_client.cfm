<!--- *****************************************************************************************
	Name:		report_production_client.cfm
	
	Function:	This page displays the number of meetings per week, per project based on the 
				client and date range selected on report_production_select.cfm
	History:	lb111202 - complete
				lb111802 - added column totals
				lb111902 - moved loops and array code to cfinclude: incProductionSheet.cfm
	
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



<!--- Loops query and Creates the array for output --->
<cfinclude template="incProductionSheet.cfm">


<!--- <cfdump var="#dWeek#"> --->

<!--- ************************To excel********************************************************** --->
<cfset report_path = 'e:\inetpub\wwwroot\projects\cgi-bin\report_production_client2XL.htm'>
<cfset report_title_color = 'silver'>
<cfset report_col_color = 'white'>
<cfset report_columns = #num_elements#>
<cfset report_title = 'Client Meetings Report'>

<!--- write the headings --->
	<cfoutput>
		<cffile action="write" file="#report_path#" nameconflict="overwrite" output="<html><head><title></title></head>">
		<cffile action="append" file="#report_path#" nameconflict="overwrite" output="<body><table border=1>">
		<cffile action="append" file="#report_path#" nameconflict="overwrite" output="<tr bgcolor=#report_title_color#><td><font name=arial size=+2>#report_title# as of #dateFormat(Now(), 'mm/dd/yyyy')#</font></td></tr><tr bgcolor=#report_col_color#><font name=arial><td>&nbsp;</td>">
		<cfloop from='2' to='#num_elements#' index='e' step='2'>
		<cffile action="append" file="#report_path#" nameconflict="overwrite" output="<td>#dWeek[1][e]#</td>">
		</cfloop>

		<cffile action="append" file="#report_path#" nameconflict="overwrite" output="<td><strong>Total</strong></td></font></tr><TR>">


	<cfloop from='1' to='#ArrayLen(dWeek)#' step='1' index='i'>
		<cffile action="append" file="#report_path#" nameconflict="overwrite" output="<td>#dWeek[i][1]#</td>">
	<cfset totalmtgs = 0>
		<cfloop from='3' to='#num_elements#' index='d' step='2'>
	<cffile action="append" file="#report_path#" nameconflict="overwrite" output="<td>#dWeek[i][d]#</td>">
	<cfset totalmtgs = totalmtgs + #dWeek[i][d]#>
		</cfloop>
		
		
	<cffile action="append" file="#report_path#" nameconflict="overwrite" output="<td><strong>#totalmtgs#</strong></td></tr>">
	</cfloop>
	
	<cfset totalallcol = 0>
	<cffile action="append" file="#report_path#" nameconflict="overwrite" output="<tr><td>&nbsp;</td>">
		<cfloop from='3' to='#num_elements#' index='d' step='2'>
	<cfset totalcol = 0>
		<cfloop from='1' to='#ArrayLen(dWeek)#' step='1' index='i'>
			<cfset totalcol = totalcol + #dWeek[i][d]#>
			<cfset totalallcol = totalallcol + #dWeek[i][d]#>	
		</cfloop>
		<cffile action="append" file="#report_path#" nameconflict="overwrite" output="<td><strong>#totalcol#</strong></td>">
		
	</cfloop>	
	<cffile action="append" file="#report_path#" nameconflict="overwrite" output="<td><strong>#totalallcol#</strong></td></tr>">	
		
		
	</cfoutput>

	<cfoutput>
	<cffile action="append" file="#report_path#" nameconflict="overwrite" output="</table></body></html>">
	<!--- display the file --->
	<cfcontent type="application/vnd.ms-excel" deletefile="NO" file="#report_path#">
	</cfoutput>

 
<!--- <table align="center" border="0" cellpadding="3" cellspacing="0">
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
</table> --->	 
	
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
