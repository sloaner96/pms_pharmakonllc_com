<!------------------------------------------------------------------------------
	act_ExportTakedaEvents.cfm
	Speaker events Export functions.  This progam pulls scheduled speaker
	events and prepares them for export

	HISTORY:
		bj20060502 - initial code.
		bj20060906 - modified to fit new Speaker and PMS database format.
-------------------------------------------------------------------------------->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Export Takeda Speaker Events" showCalendar="1">
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
		buildEvents = dataObj.buildTakedaSpeakerEvents(ProjectID, DBate, EDate);
	</cfscript>
	<!--- if table build was sucessful, update the table with more info --->
	<cfif #buildEvents.eventCount# NEQ 0>
		<cfscript>
			bRtn = dataObj.updateTakedaSpeakerEvents();
		</cfscript>
	</cfif>

<!--- run exception report --->
<cfscript>
	expList = dataObj.expTakedaSpeakerEvents();
</cfscript>

<cfif #expList.recordcount# GT 0>
<form action="dsp_ExportTakedaEvents.cfm" method="post">
	<table border="0" cellspacing="1" cellpadding="1" width="800" align="center">
		<tr align="center">
			<td align="center">Speaker</td>
			<td align="center">Meeting</td>
			<td align="center">Date</td>
			<td align="center">Time</td>
			<td align="center">No Takeda ID</td>
			<td align="center">No Title</td>
			<td align="center">No Speaker Phone</td>
			<td align="center">No Honorarium</td>
		<tr>
		<cfoutput query="expList">
		<tr align="center">
			<td align="center">#expList.FirstName# #expList.LastName#</td>
			<td align="center">#expList.EventID#</td>
			<td align="center">#DateFormat(expList.StartDate, "mm/dd/yy")#</td>
			<td align="center">#TimeFormat(expList.StartTime, "hh:mm tt")#</td>
			<td align="center"><cfif #expList.NoSpeakerClientID# EQ 1><b>X</b></cfif></td>
			<td align="center"><cfif #expList.NoEventTitle# EQ 1><b>X</b></cfif></td>
			<td align="center"><cfif #expList.NoEventPhone# EQ 1><b>X</b></cfif></td>
			<td align="center"><cfif #expList.NoHonorarium# EQ 1><b>X</b></cfif></td>
		</tr>
		</cfoutput>
		<tr height="10"><td colspan="8"></td></tr>
		<tr align="center">
			<td align="left" colspan="8">
				The exceptions noted above must be corrected before Takeda Speaker data can be exported<br>
				<ul>
					<li> for missing Takeda Speaker IDs update the Speaker's profile.</li>
					<li> for missing Title update the PIW</li>
					<li> for missing Speaker Phone update the 'Speaker Listen-in' field in the PIW</li>
					<li> for missing Honorarium update Speaker Assignment record for the meeting</li>
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
	<form action="act_ExportTakedaEvents.cfm?a=export" method="post">
	<table border="0" cellspacing="1" cellpadding="2" width="700" align="center">
		<tr align="center">
			<td colspan="6" class="ContentCell">
				<cfoutput>
				<u>No exceptions</u> were found for the Takeda Speakers selected for events<br>
				between #dateFormat(trim(form.BDate), "mm/dd/yyyy")# and #dateFormat(trim(form.EDate), "mm/dd/yyyy")#
				<br>
				<br>There are a total of #buildEvents.eventCount# records ready for export.
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
			<td align="center" valign="top">
				<INPUT TYPE="hidden" NAME="BDate" VALUE="#dateFormat(trim(form.BDate), 'mm/dd/yyyy')#">
				<INPUT TYPE="hidden" NAME="EDate" VALUE="#dateFormat(trim(form.EDate), 'mm/dd/yyyy')#">
				<INPUT TYPE="hidden" NAME="Project" VALUE="#trim(form.project)#">
				<INPUT TYPE="submit"  NAME="Export" VALUE=" Export Data ">
			</td>
		</tr>
		</cfoutput>
	</table>
	</form>
</cfif>
</cfcase>


<!---
	CASE: EXPORT
--->
<cfcase value="export">
	<cfscript>
		sList = dataObj.getPostedSpeakerEvents();
		sEventList = #QuotedValueList(sList.Eventid)#;
	</cfscript>
	<!--- export selected rows --->
	<cfset sDate = "#dateFormat(Now(), 'mmddyy')#">
	<cfset fname="CBECK_EVENT_" & #sDate# & ".csv">
	<cfset fpath = "C:\Inetpub\wwwroot\TakedaSpeakerData\">
	<cfset oFile = #fpath# & #fname#>
	<cfset Comma = Chr(44)>
	<!--- output the heading line --->
	<cffile action="write" file="#oFile#" nameconflict="overwrite"
		output="Event ID#Comma#Product ID#Comma#Start Date#Comma#Start Time#Comma#End Date#Comma#End Time#Comma#Time Zone#Comma#Title#Comma#Program Manager First Name#Comma#Program Manager Middle Name#Comma#Program Manager Last Name#Comma#Program Manager Phone Number#Comma#Program Manager Fax Number#Comma#Program Manager E-Mail#Comma#Program Manager Company#Comma#Sales Rep First Name#Comma#Sales Rep Middle Name#Comma#Sales Rep Last Name#Comma#Sales Rep Phone Number#Comma#Sales Rep Fax Number#Comma#Sales Rep E-Mail#Comma#Takeda Speaker ID#Comma#Event Speaker Status#Comma#Honorarium#Comma#Event Type#Comma#Event Location#Comma#Event Address 1#Comma#Event Address 2#Comma#Event City#Comma#Event State#Comma#Event Zip#Comma#Teleconference Phone Number#Comma#Teleconference Access Code">
	<!--- output the report rows --->
	<cfoutput query="sList">
			<cffile action="append" file="#oFile#" nameconflict="overwrite"
				output="#EventID##Comma##ProductID##Comma##dateFormat(StartDate, 'mm/dd/yyyy')##Comma##timeFormat(StartTime, 'hh:mm tt')##Comma##dateFormat(EndDate, 'mm/dd/yyyy')##Comma##timeFormat(EndTime, 'hh:mm tt')##Comma##TimeZone##Comma##Replace(EventTitle, ',', '', 'ALL')##Comma##ProgramMgrFirstname##Comma##Comma##ProgramMgrLastname##Comma##ProgramMgrPhone##Comma##ProgramMgrFax##Comma##ProgramMgrEmail##Comma#CBECK#Comma##Comma##Comma##Comma##Comma##Comma##Comma##SpeakerClientID##Comma##EventStatus##Comma##Honorarium##Comma##EventType##Comma##Comma##Comma##Comma##Comma##Comma##Comma##EventPhone##Comma##EventPhoneCode#">
	</cfoutput>

	<cfscript>
		cfcType = "EVENTS";
		cfcBDate = #dateFormat(FORM.BDate, "mm/dd/yyyy")#;
		cfcEDate = #dateFormat(FORM.EDate, "mm/dd/yyyy")#;
		cfcProject = #FORM.project#;
		cfcNumRows = #sLIst.recordcount#;
		cfcFilename = #fname#;
		bLog = dataObj.writeEventLog(cfcType, cfcBDate, cfcEDate, cfcProject, cfcNumRows, cfcFilename);
	</cfscript>


<form action="../index.cfm" method="post">
	<table border="0" cellspacing="1" cellpadding="2" width="700" align="center">
		<tr align="center">
			<td colspan="6" class="ContentCell">
				<b>Export Events</b><br>
				Export Completed Succesfully<br>
				<cfoutput>
				#sList.recordcount# events were exported to file:<br>#fname#
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
<form action="dsp_ExportTakedaEvents.cfm" method="post">
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
