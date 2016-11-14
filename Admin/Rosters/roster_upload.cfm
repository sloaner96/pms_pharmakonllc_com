<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Project Management System || Roster Upload</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK REL=stylesheet HREF="piw1style.css" TYPE="text/css">
<script Language="JavaScript">

function checkbox_checker()
{
	var theForm = document.forms[0]
	var checkbox_choices = 0;
   	for(i=0; i<theForm.elements.length; i++)
	{
		var alertText = ""
		alertText += "Element Type: " + theForm.elements[i].type + "\n"
		if(theForm.elements[i].type == "checkbox")
		{
			alertText += "Element Checked? " + theForm.elements[i].checked + "\n"
			if(theForm.elements[i].checked == true)
			{
				checkbox_choices++;
			}
		}
   }
//alert(checkbox_choices)
	if (checkbox_choices < 1 )
	{
	// If there were less then selections made display an alert box
	alert("Please select at least one Meeting Code To Upload.");
	return (false);
	}
	return true;
}


function checkAll(theForm) {
    for (i=0,n=theForm.elements.length;i<n;i++)
        if (theForm.elements[i].name.indexOf('meetingCode') !=-1)
            theForm.elements[i].checked = true;
}

function CheckFile(oForm)
{

	oForm.hiddenFilename.value = oForm.filename.value;
	var ASCIICode = oForm.filename.value.charCodeAt();
	if(oForm.filename.value == "" || ASCIICode == 32)
	{
		alert("Please select a file to upload.");
		return false;
	}
	else
	{
		return true;
	}
}
</script>


</head>

<body>
<cfif isDefined("URL.takeaction")>

	<cfif #URL.takeaction# EQ "step1">

		 <cffile action="upload" filefield="filename" destination="C:\INETPUB\WWWROOT\pms.pharmakonllc.com\cgi-bin\rosters" nameconflict="overwrite">
		<cfset FullFilePath = #CFFILE.serverDirectory# & "\" & #CFFILE.serverFile#>

		<cfset session.FilePath = #FullFilePath#>
		<cfset session.Decision = #form.decision#>

		<cfscript>
			oUploadRoster = createObject("component","cfc_upload_rosters");
			oInitiateUpload = oUploadRoster.Main(sFilePath="#FullFilePath#",sUserDecision="#form.decision#",iStep="1");
			aAllMeetings = oUploadRoster.GetAllMeetings();
		</cfscript>
		<div id="displayMeetingCodes" style="visibility: visible; width: 575px; margin-left: 15%;position:absolute;">
		<form method="post" action="roster_upload.cfm?takeaction=step2" name="formname"  onsubmit="return checkbox_checker()">
		<TABLE ALIGN="Center" BORDER="0" WIDTH="550px" CELLSPACING="0" CELLPADDING="0" style="border: solid 1px navy;">
			<input type="hidden" name="hiddenFilename" value="<cfoutput>#form.hiddenFilename#</cfoutput>">
			<TR>
				<TD ALIGN="Center" class="tdheader" colspan="2" style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Roster Upload</strong></TD>
			</TR>
			<TR>
				<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px; font-size: 12px;" colspan="2">
					<span style="color:red;"><b>Attention!!!</b> The Logic of this application has changed.</span>
					<br>
					<br><B>CHECK ANY MEETINGS YOU WISH TO BE UPLOADED</B>.
					<br>
					Any meetings NOT checked will NOT be uploaded!
					<!--- The following meetings are contained in the roster.  Please check any meeting that you DO NOT want to upload to
					the Roster database.  Any meetings not checked will be uploaded. --->
				</td>
			</tr>
			<cfscript>aDistictCurrentMeetings = arrayNew(1);</cfscript>
				<cfset strCurrentMeeting = "">
				<cfloop index="p" from="1" to="#ArrayLen(aAllMeetings)#" step="1">
					<cfif #aAllMeetings[p]# NEQ #strCurrentMeeting#>
						<cfoutput>
							<TR>
								<TD ALIGN="right" style="padding-top: 4px; padding-bottom: 4px; padding-right: 5px;" width="300px">
									<input type="checkbox" name="meetingCode" value="#aAllMeetings[p]#">
								</td>
								<TD ALIGN="left" style="padding-top: 4px; padding-bottom: 4px; padding-left: 5px; font-size: 12px;" width="300px" valign="center">
									&nbsp; #aAllMeetings[p]#
								</td>
							</tr>
							<cfscript>
							aDistictCurrentMeetings[arrayLen(aDistictCurrentMeetings) + 1] = #aAllMeetings[p]#;
							</cfscript>

						</cfoutput>
						<cfset strCurrentMeeting = #aAllMeetings[p]#>
					</cfif>
				</cfloop>
				<cfset lDistictCurrentMeetings = ArrayToList(aDistictCurrentMeetings)>
				<input type="hidden" name="allMeetingCodes" value="<cfoutput>#lDistictCurrentMeetings#</cfoutput>">


			<tr>
				<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px;" colspan="2">
				<INPUT type="reset" value=" UnCheck All ">
				<INPUT onclick="checkAll(formname)" type="button" value="    Check all    ">
				<input type="submit" value="<cfif #session.decision# eq 0> Test Roster <cfelse> Upload Roster </cfif>">
				<br><br>
				</td>
			</tr>
		</table>
		</form>
		</div>
	<cfelseif #URL.takeaction# EQ "step2">
<script language="JavaScript"><!--
function show(object) {
  if (document.getElementById) {
    document.getElementById(object).style.visibility = 'visible';
  }
  else if (document.layers && document.layers[object]) {
    document.layers[object].visibility = 'visible';
  }
  else if (document.all) {
    document.all[object].style.visibility = 'visible';
  }
}

function hide(object) {
  if (document.getElementById) {
    document.getElementById(object).style.visibility = 'hidden';
  }
  else if (document.layers && document.layers[object]) {
    document.layers[object].visibility = 'hidden';
  }
  else if (document.all) {
    document.all[object].style.visibility = 'hidden';
  }
}
//--></script>

<div id="loadingFlashmovie" style="visibility: visible; width: 550px; margin-left: 15%; position:absolute;">

<TABLE ALIGN="Center" BORDER="0"  WIDTH="550px" CELLSPACING="0" CELLPADDING="0" style="border: solid 1px navy;">
			<TR>
				<TD ALIGN="Center" class="tdheader" style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Roster Upload</strong></TD>
			</TR>
			<TR>
				<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px;">

				<cfif #session.decision# eq 0>

				<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
 codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
 WIDTH="120" HEIGHT="100" id="rosterUploadLoader" ALIGN="">
 <PARAM NAME=movie VALUE="rosterTestingUploadLoader.swf"> <PARAM NAME=quality VALUE=high> <PARAM NAME=bgcolor VALUE=#FFFFFF> <EMBED src="rosterTestingUploadLoader.swf" quality=high bgcolor=#FFFFFF  WIDTH="120" HEIGHT="100" NAME="rosterTestingUploadLoader" ALIGN=""
 TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer"></EMBED>
</OBJECT>
				<cfelse>

				<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
 codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
 WIDTH="120" HEIGHT="100" id="rosterUploadLoader" ALIGN="">
 <PARAM NAME=movie VALUE="rosterUploadLoader.swf"> <PARAM NAME=quality VALUE=high> <PARAM NAME=bgcolor VALUE=#FFFFFF> <EMBED src="rosterUploadLoader.swf" quality=high bgcolor=#FFFFFF  WIDTH="120" HEIGHT="100" NAME="rosterUploadLoader" ALIGN=""
 TYPE="application/x-shockwave-flash" PLUGINSPAGE="http://www.macromedia.com/go/getflashplayer"></EMBED>
</OBJECT>
				</cfif>
				</TD>
			</TR>
		</table>
</div>
		<cfscript>
			oUploadRoster = createObject("component","cfc_upload_rosters");
			oInitiateUpload = oUploadRoster.Main(sFilePath="#session.FilePath#",sUserDecision="#session.Decision#",iStep="2");
		</cfscript>
		<cfoutput>

		<cfif isDefined("form.meetingCode") AND isDefined("form.allMeetingCodes")>
		<cfset aAllCodes = ListToArray(#form.allMeetingCodes#)>

		<cfscript>
		aUnwantedMeetings = arrayNew(1);
		lUnwantedMeetings = "";
		j = 1; // unwanted mmeeting counter
		for(i = 1; i LTE arrayLen(aAllCodes) ; i=i+1)
		{
				if(ListContains(form.meetingCode, aAllCodes[i]) EQ 0)
				{
					//writeOutput(aAllCodes[i]);
					//writeOutput(",");
					aUnwantedMeetings[j] = aAllCodes[i];
					j=j+1;
				}

		}

		/*
		for(i = 1; i LTE arrayLen(aUnwantedMeetings) ; i=i+1)
		{
			writeOutput(aUnwantedMeetings[i]);
			writeOutput(",");
		}
		*/
		form.meetingCode = ArrayToList(aUnwantedMeetings);


		oUploadRoster.RemoveUnwantedMeetings(aCheckedMeetings="#form.meetingCode#");

		strFileName = oUploadRoster.GetFileName();
		oUploadRoster.UploadData();
		bPerformUpload = oUploadRoster.DisplayMessage();

		aLength = oUploadRoster.getErrorArrayLength();

		iMax = 0;
		iTotalRows = 0;

		if(#session.decision# eq 1)
		{
			iMax = oUploadRoster.getMaxId();
			iTotalRows = oUploadRoster.getTotalRows();
		}

		</cfscript>

		</cfif>
		</cfoutput>

<script language="JavaScript">
	// HIDE THE FLASH LAYER AFTER UPLOADING IS FINISHED
	hide('loadingFlashmovie');
</script>

		<cfif NOT bPerformUpload>
		<cfif #session.decision# eq 0><br><br></cfif>
			<div id="displaySuccess" style="visibility: visible; width: 550px; margin-left: 15%;position:absolute;">
			<TABLE ALIGN="Center" BORDER="0" WIDTH="550px" CELLSPACING="0" CELLPADDING="0" style="border: solid 1px navy;">
				<TR>
					<TD ALIGN="Center" class="tdheader" style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Roster Upload</strong></TD>
				</TR>
				<TR>
					<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px;">
					<h2><cfif #session.decision# eq 0>Testing Successful!<cfelse>Upload Successful!</cfif></h2>
					<cfoutput><cfif #session.decision# eq 1>#iTotalRows# Rows Tested! <br> #iMax# is the Max(rowid)</cfif></cfoutput>
					 <br><br>
					 <center><input type="button" value=" Back to Roster Upload Page " onclick="document.location.href='roster_upload.cfm?<cfif #session.decision# eq 0>filebox=<cfoutput>#URLEncodedFormat(form.hiddenFilename)#</cfoutput></cfif>'"></center>

					</TD>
				</TR>
			</table>
			</div>
			<cfif #session.decision# eq 0><br><br></cfif>
		<cfelse>

			<div id="displayErrors" style="visibility: visible; width: 550px; margin-left: 15%;position:absolute;">
				<TABLE ALIGN="Center" BORDER="0" WIDTH="550px" CELLSPACING="0" CELLPADDING="0" style="border: solid 1px navy;">
				<TR>
					<TD ALIGN="Center" class="tdheader" style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Roster Upload</strong></TD>
				</TR>
				<TR>
					<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px;">
						<h2><cfif aLength LT 1>A </cfif>Fatal Error<cfif aLength GT 1>s</cfif> <cfif aLength GT 1>have<cfelse>has</cfif> occured!</h2>
						<cfscript>
						oUploadRoster.DisplayErrors();
						</cfscript>
						<hr>
						The roster contained fatal <cfif aLength LT 1>a </cfif> error<cfif aLength GT 1>s</cfif>.
						<br>
						<p><center><input type="button" value=" Back to Roster Upload Page " onclick="document.location.href='roster_upload.cfm'"></center></p>
					</TD>
				</TR>
			</table>
			</div>
		</cfif>

	</cfif>

<cfelse>
	<!---Delete the session variable if it exsists--->
	<cfif isDefined("session.FilPath")>
		<cfset structDelete(session, "FilPath")>
	</cfif>
	<cfif isDefined("session.decision")>
		<cfset structDelete(session, "decision")>
	</cfif>
	<div id="selectFile" style="visibility: visible; width: 550px; margin-left: 15%;position:absolute;">
	<form action="roster_upload.cfm?takeaction=step1" method="post" enctype="multipart/form-data" onsubmit="return CheckFile(this)">
		<TABLE ALIGN="Center" BORDER="0" WIDTH="550px" CELLSPACING="0" CELLPADDING="0" style="border: solid 1px navy;">
			<input type="hidden" name="hiddenFilename" value="">
			<TR>
				<TD ALIGN="Center" class="tdheader" style="border-bottom: solid 1px navy; padding-top: 2px; padding-bottom: 2px;"><strong>Roster Upload</strong></TD>
			</TR>
			<TR>
				<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px;">
					<br>

					<cfif ISdefined("URL.filebox")><cfoutput><cfset session.filebox = "#URLDecode(URL.FileBox)#">
					For Reference: The file were testing/uploading is located @ <br><br> #session.filebox#</cfoutput></cfif>
					<br><br>
					<input type="file" name="filename" size="60">
				</td>
			</tr>
			<TR>
				<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px;">
					<input type="radio" name="decision" value="0" checked> &nbsp; Show Data w/No Upload<br>
					<br>
					<input type="radio" name="decision" value="1"> &nbsp; Upload Data to Database<br>
				</td>
			</tr>
			<TR>
				<TD ALIGN="Center" style="padding-top: 4px; padding-bottom: 4px;">
				<input type="submit" value=" Upload to Database ">
				<br><br>
				</TD>
			</TR>
		</table>
	</form>
	</div>
</cfif>
<!--- <h2><span style="color: red;">This page is being worked on. Talk to Matt Eaves if you need to run rosters.</span></h2> --->
</body>
</html>
