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

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
	table.border{border:1px solid black;}
	th.border{border-bottom:1px solid black;border-right:1px solid black;}
	td.getWeeks{font-size:10pt;border-right:1px solid black;border-bottom:1px solid black;text-align:center}
	td.data{font-size:10px;font-family:Verdana, sans-serif;border-right:1px solid black;border-bottom:1px solid black;text-align:center}
	a.weekLinks:link {color: blue; text-decoration: underline; }
	a.weekLinks:active {color: blue; text-decoration: underline; }
	a.weekLinks:visited {color: blue; text-decoration: underline; }
	a.weekLinks:hover {color: black; text-decoration: underline; }
</style>


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
					form.submit();

			} //END if

		}//end IF
	}
}


function loadDates()
{

<cfoutput>
var stringTodaysDate = '#dateFormat(Now(), 'mm/dd/yy')#'
document.form.fiStartDate.value = stringTodaysDate;
document.form.fiEndDate.value = stringTodaysDate;
</cfoutput>

}
</script>


</head>
	<body onload="loadDates();">



<form name="form" method="post" action="">
<table align="center" width="720" cellspacing="0" cellpadding="0" border="0">
<tr height="10"><td colspan="2">&nbsp;</td></tr>
<tr>
	<td align="left" class="ContentCell" colspan="2">
		<p><font size="2"><b>- Project Report -</b></font></p>
		Enter or select the beginning and end dates for the meetings you wish to review, then click the Submit button.
	</td>
</tr>
<tr height="10"><td colspan="2">&nbsp;</td></tr>
<tr valign="top">
	<td align="left">
		<CFINCLUDE TEMPLATE="fla_dateChooser.html">
	</td>
	<td align="left">
		<input TYPE="Button" NAME="next_page" VALUE=" Submit " onClick="whichway(1)">
	</td>
</tr>
<tr height="10" colspan="2"><td>&nbsp;</td></tr>
</table>
</form>

		</body>



	</CFDEFAULTCASE>
</CFSWITCH>
