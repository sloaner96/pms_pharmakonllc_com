<!---
	*****************************************************************************************
	Name:		rpt_attendee.cfm

	Function:	The function of this page is to provide an Attendee Report based on the
				date range that the user selects.

				Two Case Statements based on URL.ACTION

				CFDEFAULTCASE: Shows form elements, should show on page entry.

				CFCASE VALUE="viewReports": Show Results of Query in HTML. With
											Option to Export in Excel.

	History:	ts20040518 - finalized code

	*****************************************************************************************
--->

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Project Report" showCalendar="1">



<CFIF NOT ISDEFINED("URL.action")>
<CFSET url.action = "">
</CFIF>

<CFSWITCH EXPRESSION="#URL.action#">
</head>
	<!---
		*********************************************************
			CASE: viewReport

			Function: 	Calls cfc_getAttendees
						Which return a query variable with
						the name of qGetDateRangeAttendees.

						Then outputs it to a HTML table with
						option to export using excel.


		*********************************************************
	--->
	<CFCASE VALUE="viewReports">
<body>

<table align="center" width="720" cellspacing="0" cellpadding="0" border="0" class="data">
<tr height="10"><td colspan="2">&nbsp;</td></tr>
<tr><cfoutput>
	<td align="left" class="ContentCell" colspan="2">
		<p><font size="2"><b>- Project Report for #form.fiStartDate# to #form.fiEndDate# -</b></font></p>
<form name="oForm" action="excel_projectReport.cfm?report=Excel&no_menu=1&sSD=#form.fiStartDate#&sED=#form.fiEndDate#" method="post">
					<input type="submit"  value=" Generate EXCEL Report ">
				</form>
	</td></cfoutput>
</tr>
<tr height="10"><td colspan="2">&nbsp;</td></tr>
</table>
	</td>
</tr>
</table>


		</body>
	</CFCASE>



	<!---
		*********************************************************
			CASE: default
			Function: 	This case sets up the default
						functionality of this page. Just a
						Simple form to get start and end date.

		*********************************************************
	--->
	<CFDEFAULTCASE>


<script src="js_dateValidation.js"></script>
<script>

function whichway(way)
{
	if( way == '1')
	{
		form.action = "rpt_project.cfm?action=viewReports";

		a = document.form.fiStartDate.value;
		error = isThisWrong(a);

		if(error){
			alert('A problem has occured in the Start Date Field.\n\n Please use the format mm/dd/yy.');
		}
		else { //Start Date was correct. Now check End date
			a = document.form.fiEndDate.value;
			error = isThisWrong(a);
			if(error){
				alert('A problem has occured in the End Date Field.\n\n Please use the format mm/dd/yy.');
			}
			else {

			//SUCCESS
					this.form.submit();

			} //END if

		}//end IF
	}
}


function loadDates()
{

<cfoutput>

</cfoutput>

}
</script>
<cfscript>
 beginingdate = dateFormat(Now(), 'mm/dd/yy');
 endingdate  = dateAdd('m', 1, now());
</cfscript>



<form name="form" method="post" action="rpt_project.cfm?action=viewReports">
<table align="center" width="720" cellspacing="0" cellpadding="0" border="0">
<tr height="10"><td colspan="2">&nbsp;</td></tr>
<tr>
	<td align="left" class="ContentCell" colspan="2">
		Enter or select the beginning and end dates for the meetings you wish to review, then click the Submit button.
	</td>
</tr>
<tr height="10"><td colspan="2">&nbsp;</td></tr>
<tr valign="top">
	<td align="left">
		<B>Begin Date:</B>&nbsp;&nbsp;&nbsp;&nbsp;
						<cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
						          inputname="fiStartDate"
								  htmlID="begindate"
								  FormValue="#DateFormat(beginingdate, 'mm/dd/yyyy')#"
								  imgid="begindatebtn">
						 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<B>End Date:</B>&nbsp;&nbsp;&nbsp;&nbsp;
						<cfmodule template="#Application.tagpath#/ctags/calInput.cfm"
						          inputname="fiEndDate"
								  htmlID="enddate"
								  FormValue="#DateFormat(endingdate, 'mm/dd/yyyy')#"
								  imgid="enddatebtn">
	</td>
	<td align="left">
		<input TYPE="submit" NAME="submit" VALUE=" Submit ">
	</td>
</tr>
<tr height="10" colspan="2"><td>&nbsp;</td></tr>
</table>
</form>

	<cfmodule template="#Application.tagpath#/ctags/footer.cfm">




	</CFDEFAULTCASE>
</CFSWITCH>
