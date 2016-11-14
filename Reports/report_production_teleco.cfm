<!--- *****************************************************************************************
	Name:		report_production_teleco.cfm
	
	Function:	This page displays the number of meetings per week, per project based on the 
				teleconference co. and date range selected on report_production_select.cfm
	History:	lb111402 - complete
				lb111802 - added column totals
				lb111902 - moved loops and array code to cfinclude: incProductionSheet.cfm
	
	*****************************************************************************************--->
<html>
<head>
<title>Teleconference Production Schedule</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK REL=STYLESHEET HREF="PIW1STYLE.CSS" TYPE="TEXT/CSS">

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


<!--- pull recruiting company name --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="getTele">
SELECT conf_company_name 
FROM conference_company
WHERE ID = '#session.select_criteria#'
</cfquery>

<!--- pull recruiting companies --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qtele_co">
SELECT conference_company, project_code 
FROM PIW
WHERE <cfif session.select_criteria NEQ 0>conference_company = '#session.select_criteria#'</cfif>
ORDER BY conference_company,  project_code
</cfquery>

<!--- Set project codes in an array and convert to list --->
<cfset RecArray = ArrayNew(1)>
<cfoutput query="qtele_co">
	<cfset TeleArray[currentrow] = "'#qtele_co.project_code#'">
</cfoutput>
<cfset TeleList = #ArrayToList(TeleArray, ",")#>



	<!--- REMOVE STATUS = 0 WHEN LIVE --->
<!--- pull rows from meeting summary table that match the projects pulled above --->
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qprojects">
	SELECT * 
	FROM meeting_summary
	WHERE project_code IN (#PreserveSingleQuotes(TeleList)#)
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



<!--- ************************To excel********************************************************** --->
<cfoutput>
<cfset report_path = 'e:\inetpub\wwwroot\projects\cgi-bin\report_production_client2XL.htm'>
<cfset report_title_color = 'silver'>
<cfset report_col_color = 'white'>
<cfset report_columns = #num_elements#>
<cfset report_title = '#getTele.conf_company_name# Meetings Report'>

<!--- write the headings --->
	
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

<!--- 
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
<cfdump var="#dWeek#"> --->--->
<cfelse>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>No records matched your criteria. Please try again.</strong>

</cfif>
	<form action="report_production_select.cfm" name="back">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE="submit" NAME="submit"  VALUE="  Search Again  ">
	</form>
</body>
</html>
