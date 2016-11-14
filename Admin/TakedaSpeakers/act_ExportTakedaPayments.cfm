<!------------------------------------------------------------------------------
	act_ExportTakedaPayments.cfm
	Speaker events Export functions.  This progam pulls scheduled speaker
	events and prepares them for export

	HISTORY:
		bj20060502 - initial code.
		bj20060906 - modified to fit new Speaker and PMS database format.
-------------------------------------------------------------------------------->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Export Takeda Speaker Payments" showCalendar="1">
<cfparam name="URL.a" default="">

<!--- create a data object for the cfc functions for Takeda Speaker handling --->
<cfscript>dataObj = createObject("component","components/TakedaDataHandler");</cfscript>

<!---<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Export Takeda Speaker Events" showCalendar="1">--->
<cfswitch expression="#URL.a#">
<!---
	CASE: BUILD
--->
<cfcase value="build">
	<cfscript>
		ProjectID = trim(#form.project#);
		DBate = #dateFormat(trim(form.BDate), "mm/dd/yyyy")#;
		EDate = #dateFormat(trim(form.EDate), "mm/dd/yyyy")#;
		buildEvents = dataObj.buildTakedaSpeakerPayments(ProjectID, DBate, EDate);
	</cfscript>
	<!--- if table build was sucessful, update the table with more info --->
	<cfif #buildEvents.eventCount# NEQ 0>
		<cfscript>
			bRtn = dataObj.updateTakedaSpeakerPayments();
		</cfscript>
	</cfif>

<!--- run exception report --->
<cfscript>
	expList = dataObj.expTakedaSpeakerPayments();
</cfscript>

<cfif #expList.recordcount# GT 0>
<form action="dsp_ExportTakedaPayments.cfm" method="post">
	<table border="0" cellspacing="1" cellpadding="1" width="700" align="center">
		<tr align="center">
			<td align="center">Speaker</td>
			<td align="center">Meeting</td>
			<td align="center">Date</td>
			<td align="center">Time</td>
			<td align="center">No Takeda ID</td>
		<tr>
		<cfoutput query="expList">
		<tr align="center">
			<td align="center">#expList.FirstName# #expList.LastName#</td>
			<td align="center">#expList.EventID#</td>
			<td align="center">#DateFormat(expList.StartDate, "mm/dd/yy")#</td>
			<td align="center">#TimeFormat(expList.StartTime, "hh:mm tt")#</td>
			<td align="center"><cfif #expList.NoSpeakerClientID# EQ 1><b>X</b></cfif></td>
		</tr>
		</cfoutput>
		<tr height="10"><td colspan="5"></td></tr>
		<tr align="center">
			<td align="left" colspan="5">
				The exceptions noted above must be corrected before Takeda Speaker Payment data can be exported<br>
				<ul>
					<li> for missing Takeda Speaker IDs update the Speaker's profile.</li>
				</ul>
			</td>
		</tr>
	</table>
	 <br>
	<table border="0" cellpadding="5" align="center">
		<tr>
			<td align="center" valign="top"><INPUT TYPE="submit"  NAME="Continue" VALUE=" Continue "></td>
		</tr>
	</table>
	</form>
<cfelse>
	<!--- Exclude any rows which have no amount or check number --->
	<cfquery name="countSpeakerPayments" datasource="#application.speakerDSN#">
		select count(*) as paymentCount
		from speaker.dbo.TakedaSpeakerPayments
		where checkamount > 0
			and checkamount is not null
			and checknumber is not null
			and checknumber <> 0
			and paymentdate is not null
	</cfquery>

	<cfif #countSpeakerPayments.paymentCount# EQ 0>
		<form action="dsp_ExportTakedaPayments.cfm?a=export" method="post">
		<table border="0" cellspacing="1" cellpadding="2" width="700" align="center">
			<tr align="center">
				<td colspan="6" class="ContentCell">
					<cfoutput>
					No payment records were found for the Takeda Speakers selected for events<br>
					between #dateFormat(trim(form.BDate), "mm/dd/yyyy")# and #dateFormat(trim(form.EDate), "mm/dd/yyyy")#
					<br>
					</cfoutput>
					<br>
					<br>
					Click the <i><b>Continue</b></i> button to try again.
				</td>
			</tr>
		</table>
		 <br>
		<table border="0" cellpadding="5" align="center">
			<tr>
				<td align="center" valign="top"><INPUT TYPE="submit"  NAME="Continue" VALUE=" Continue "></td>
			</tr>
		</table>
		</form>
	<cfelse>
		<form action="act_ExportTakedaPayments.cfm?a=export" method="post">
		<table border="0" cellspacing="1" cellpadding="2" width="700" align="center">
			<tr align="center">
				<td colspan="6" class="ContentCell">
					<cfoutput>
					<u>No exceptions</u> were found for the Takeda Speakers selected for events<br>
					between #dateFormat(trim(form.BDate), "mm/dd/yyyy")# and #dateFormat(trim(form.EDate), "mm/dd/yyyy")#
					<br>
					<br>There are a total of #countSpeakerPayments.paymentCount# records ready for export.
					</cfoutput>
					<br>
					<br>
					Click the <i><b>Export Data</b></i> button to export the event data.
				</td>
			</tr>
		</table>
		 <br>
		<table border="0" cellpadding="5" align="center">
			<cfoutput>
			<tr>
				<INPUT TYPE="hidden" NAME="BDate" VALUE="#dateFormat(trim(form.BDate), 'mm/dd/yyyy')#">
				<INPUT TYPE="hidden" NAME="EDate" VALUE="#dateFormat(trim(form.EDate), 'mm/dd/yyyy')#">
				<INPUT TYPE="hidden" NAME="Project" VALUE="#trim(form.project)#">
				<td align="center" valign="top"><INPUT TYPE="submit"  NAME="Export" VALUE=" Export Data "></td>
			</tr>
			</cfoutput>
		</table>
		</form>
	</cfif>
</cfif>
</cfcase>


<!---
	CASE: EXPORT
--->
<cfcase value="export">
	<cfscript>
		sList = dataObj.getPostedSpeakerPayments();
		sEventList = #QuotedValueList(sList.Eventid)#;
	</cfscript>
	<!--- export selected rows --->
		<cfset sDate = "#dateFormat(Now(), 'mmddyy')#">
		<cfset fname="CBECK_PAYMENT_" & #sDate# & ".csv">
		<cfset fpath = "c:\Inetpub\wwwroot\TakedaSpeakerData\">
		<cfset oFile = #fpath# & #fname#>
		<cfset Comma = Chr(44)>
		<!--- output the heading line --->
		<cffile action="write" file="#oFile#" nameconflict="overwrite"
			output="Event ID#Comma#Takeda Speaker ID#Comma#Payment Type#Comma#Check Amount#Comma#Check Number#Comma#Mailed Date">
		<!--- write the report rows --->
		<cfoutput query="sList">
			<cffile action="append" file="#oFile#" nameconflict="overwrite"
				output="#EventID##Comma##SpeakerClientID##Comma##PaymentType##Comma##CheckAmount##Comma##CheckNumber##Comma##dateFormat(PaymentDate, 'mm/dd/yyyy')#">
	</cfoutput>

	<cfscript>
		cfcType = "PAYMENTS";
		cfcBDate = #dateFormat(FORM.BDate, "mm/dd/yyyy")#;
		cfcEDate = #dateFormat(FORM.EDate, "mm/dd/yyyy")#;
		cfcProject = #FORM.project#;
		cfcNumRows = #sList.recordcount#;
		cfcFilename = #fname#;
		bLog = dataObj.writeEventLog(cfcType, cfcBDate, cfcEDate, cfcProject, cfcNumRows, cfcFilename);
	</cfscript>

<form action="../index.cfm" method="post">
	<table border="0" cellspacing="1" cellpadding="2" width="700" align="center">
		<tr align="center">
			<td colspan="6" class="ContentCell">
				<b>Export Payments</b><br>
				Export Completed Succesfully<br>
				<cfoutput>
				#sList.recordcount# payments were exported to file:<br>#fname#
				</cfoutput>
			</td>
		</tr>
	</table>
	 <br>
	<table border="0" cellpadding="5" align="center">
		<tr>
			<td align="center" valign="top"><INPUT TYPE="submit"  NAME="Finished" VALUE=" Finished "></td>
		</tr>
	</table>
	</form>
</cfcase>
<!---
	DEFAULT CASE
--->
<cfdefaultcase>
<form action="dsp_ExportTakedaPayments.cfm" method="post">
	<table border="0" cellspacing="1" cellpadding="2" width="700" align="center">
		<tr align="center">
			<td colspan="6" class="ContentCell">
				<b>Export Takeda Events</b><br>
				The Export Function was Unsuccessful, Please try again<br>
			</td>
		</tr>
	</table>
	 <br>
	<table border="0" cellpadding="5" align="center">
		<tr>
			<td align="center" valign="top"><INPUT TYPE="submit"  NAME="Continue" VALUE=" Continue "></td>
		</tr>
	</table>
	</form>

</cfdefaultcase>
</cfswitch>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
