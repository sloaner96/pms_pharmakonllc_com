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


<CFHEADER NAME="Expires" VALUE="Sun, 06 Nov 1994 08:49:37 GMT">
<CFHEADER NAME="Pragma" VALUE="no-cache">
<CFHEADER NAME="cache-control" VALUE="no-cache, no-store, must-revalidate">

<cfset PageTitle = "Meeting Counts Report">
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="#PageTitle#" showCalendar="0">

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

<cfinvoke component="pms.com.cfc_mcounts" method="getCounts" returnVariable="MCounts" cfcMCode="#form.clientcode#">
<table style="margin-left:10px;">
<tr><td><font face="Geneva, Arial, Helvetica">Meeting Counts for <cfoutput>#form.clientcode#</cfoutput> as of <cfoutput>#DateFormat("#Now()#", "mm/dd/yy")#</cfoutput></font></td></tr>



<cfif MCounts.RecordCount GT 0>
<tr><td>
	<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
	 codebase=""
	 width=700 height=400 id="myFlash">
		<param name=movie value="datagrid.swf">
		<param name=quality value=high>

		<embed src="datagrid.swf" quality=high width=700 height=400 type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" name="myFlash" swLiveConnect="true">
		</embed>
	  </object>
</td></tr>

	<SCRIPT LANGUAGE=JavaScript>
	<!--
	var xmlString = "";

		<cfoutput query="MCounts">
		xmlString = xmlString + "<meetingcodereport><eventkey>#trim(MCounts.eventkey)#</eventkey><eventdatetime>#trim(MCounts.eventdatetime)#</eventdatetime><timezone>#trim(MCounts.timezone)#</timezone><speakername>#trim(MCounts.speakername)#</speakername><eventcounts>#trim(MCounts.event_count)#</eventcounts><diff>#trim(MCounts.diff)#</diff></meetingcodereport>";
		xmlString = xmlString + "";
		</cfoutput>

	window.document.myFlash.SetVariable("xmlString", xmlString);
	//-->
	</SCRIPT>

<tr><td>
	<table align="center" width="720" cellspacing="0" cellpadding="0" border="0" class="data">
	<tr height="10"><td colspan="2">&nbsp;</td></tr>
	<tr>

	<td align="center" class="ContentCell" colspan="2">
	<cfoutput>
	<form name="oForm" action="excel_mcountsReport.cfm?report=Excel&clientcode=#form.clientcode#" method="post">
	</cfoutput>
	<font size="2"><b>Project Report for <cfoutput>#form.clientcode#</cfoutput>: </b>
		<input type="submit"  value=" Generate EXCEL Report ">
	</font>
	</form>
	</td>

	</tr>
	</table>
</td></tr>
<cfelse>
<tr><td>No Records Have Been Found! Please try again. <a class="NavLink" href="report_mcounts.cfm?rn=<cfoutput>#rand()#</cfoutput>">Meeting Counts Report</a></td></tr>
</cfif>

</table>
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

<script>

function whichway(way)
{

	//alert(document.getElementById('clientcode').value);
	if( way == '1' && document.getElementById('clientcode').value != '')
	{
		form.action = "report_mcounts.cfm?action=viewReports";
		form.submit();
	}
	else
	{
		alert("Select a Client Code!");
	}
}
</script>

<SCRIPT LANGUAGE=JavaScript>
<!--
var InternetExplorer = navigator.appName.indexOf("Microsoft") != -1;
function myFlash_DoFSCommand(command, args)                {

var myFlashObj = InternetExplorer ? myFlash : document.myFlash;
document.getElementById('clientcode').value = args;

}
if (navigator.appName && navigator.appName.indexOf("Microsoft") != -1 &&
  navigator.userAgent.indexOf("Windows") != -1 && navigator.userAgent.indexOf("Windows 3.1") == -1) {
  document.write('<SCRIPT LANGUAGE=VBScript\> \n');
  document.write('on error resume next \n');
  document.write('Sub myFlash_FSCommand(ByVal command, ByVal args)\n');
  document.write(' call myFlash_DoFSCommand(command, args)\n');
  document.write('end sub\n');
  document.write('</SCRIPT\> \n');
}
//-->
</SCRIPT>
</head>

<CFQUERY DATASOURCE="#application.projdsn#" NAME="q1">
	SELECT CodeDesc AS status_description,  CodeValue as status_code
	FROM lookup
	</CFQUERY>

	<CFQUERY DATASOURCE="#application.projdsn#" NAME="q2">
	SELECT Distinct(rtrim(cc.client_code)) as client_code, ltrim(cc.client_code_description) as client_code_description, cp.status
	FROM client_code cc, client_proj cp
	WHERE cc.client_code = cp.client_code and cc.client_code != 'czzzz'
	order by cc.client_code_description
	</CFQUERY>

<body>

<table align="center"><tr><td>
<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
 codebase=""
 width=375 height=225 id="myFlash">
    <param name=movie value="client_code_selector.swf">
    <param name=quality value=high>
    <embed src="client_code_selector.swf" quality=high width=375 height=225 type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" name="myFlash" swLiveConnect="true">
    </embed>
  </object>
</td><td valign="top"><br>
<form method="post" name="form" action="rpt_mcounts.cfm"><input type="hidden" name="clientcode">
<input TYPE="Button" NAME="next_page" VALUE=" Submit " onClick="whichway(1)">
</form>
</td></tr>

</table>



<SCRIPT LANGUAGE=JavaScript>
<!--
var status_xmlString = "";
var client_xmlString = "";
var clientProj_xmlString = "";

	<cfoutput query="q1">
	status_xmlString = status_xmlString + "<statuscode><name>#status_description#</name><value>#status_code#</value></statuscode>";
	</cfoutput>
	status_xmlString = status_xmlString + "";

	<cfoutput query="q2">
	client_xmlString = client_xmlString + "<client><clientcode>#client_code#</clientcode><clientdesc>#client_code_description#</clientdesc><status>#status#</status></client>";
	</cfoutput>
	client_xmlString = client_xmlString + "";

	window.document.myFlash.SetVariable("status_xmlString", status_xmlString);
	window.document.myFlash.SetVariable("client_xmlString", client_xmlString);
//-->
</SCRIPT>



	</CFDEFAULTCASE>
</CFSWITCH>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
