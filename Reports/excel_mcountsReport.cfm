<!---
	*****************************************************************************************
	Name:		excel_attendance_report.cfm

	Function:	The function of this page is to translate the Attendee Report from html
				to excel.

	History:	ts20040518 - finalized code

	*****************************************************************************************
--->

<cfset excel_report_path = "#application.REPORTPATH#\rpt_temp.htm">

<cfif NOT isDefined("URL.report")>
	<cfabort>
</cfif>

<html>
<head>
<title></title>
<style>TD {font-family:Andale Mono; font-size:7pt; border:.5pt solid windowtext;}</style>
</head>

<cfinvoke component="pms.com.cfc_mcounts" method="getCounts" returnVariable="MCounts" cfcMCode="#URL.clientcode#">


<body>
<p>&nbsp;</p>
<cfif MCounts.recordcount>
		<cfset OutputArray = ArrayNew(1)>
		<cfset count = 1>

		<cfset OutputArray[count] = "<html><head></head><body><TABLE BORDER='1' CELLSPACING='0' CELLPADDING='0'><TR><td><strong>Meeting_Code</strong></td><td><strong>Date_Time</strong></td><td><strong>Time_Zone</strong></td><td><strong>Speaker</strong></td><td><strong>Seats_Filled</strong></td><td><strong>Seats_Remain</strong></td></tr>">
		<cfset count = #count# + 1>

		<cfoutput query="MCounts">

		<cfset OutputArray[count] = "<tr><td>#trim(MCounts.eventkey)#&nbsp;</td><td>#trim(MCounts.eventdatetime)#&nbsp;</td><td>#trim(MCounts.timezone)#&nbsp;</td><td>#trim(MCounts.speakername)#&nbsp;</td><td>#trim(MCounts.event_count)#&nbsp;</td><td>#trim(MCounts.diff)#&nbsp;</td></tr>">

			<cfset count = #count# + 1>

		</cfoutput>

		<cfset OutputArray[count] = "</table>">
		<cfset count = #count# + 1>


		<cfset temp = #ArrayToList(OutputArray, " ")#>

		<cftry>
		<cffile action="write" file="#excel_report_path#" nameconflict="overwrite" output="#temp#">
		<cfcontent type="application/vnd.ms-excel" deletefile="NO" file="#excel_report_path#">
		</cfcontent>
		<cfcatch type="any">wrong</cfcatch>
		</cftry>

<cfelse>
&nbsp; &nbsp; <strong>No matching records were found.</strong>
</cfif>
<br><br>
<center>
<input type="button"  value=" Go Back " onclick="document.location.href='report_mcounts.cfm'"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="button"  value=" Print " onclick="javascript: window.print();"></center>
</body>
</html>
