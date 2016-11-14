<!---
	*****************************************************************************************
	Name:		meeting_time_edit_popup.cfm
	Function:	Allows user to edit a meeting speaker or moderator.
	History:	Matt Eaves -- Initial Code -- 10/11/02
				Ben Jurevicius - 2005/01/14 - added notes editting

	*****************************************************************************************
--->

<CFSET year = #URL.year#>
<CFSET month = #URL.month#>
<CFSET day = #URL.day#>
<CFSET Row_ID = #URL.uniqueID#>
<CFSET ModeratorID = #URL.modID#>
<CFSET ModeratorRowID = #URL.modRowID#>
<CFSET SpeakerID = #URL.spkrID#>
<CFSET SpeakerRowID = #URL.spkrRowID#>
<CFSET CivTime = #URL.time#>
<CFSET MilitaryBegin = #URL.beginM#>
<CFSET MilitaryEnd = #URL.EndM#>
<CFSET meeting_use = #URL.meeting_use#>
<CFSET meeting_code = #URL.meeting_code#>
<CFSET sequence = #URL.sequence#>


<HTML>
<HEAD>
<LINK REL=STYLESHEET HREF="/includes/styles/main.css" TYPE="TEXT/CSS">
<TITLE>Meeting Time</TITLE>
<SCRIPT LANGUAGE="JavaScript">

function doIT()
{
	if(checkModSpkr())
	{
		frm1.submit();
	}
	else
	{
		return false;
	}
}

function GoBack()
{
	<cfoutput>
	url2="meeting_time_add.cfm?no_menu=1&refresh=0&day=#Day#&month=#month#&year=#year#"
	</cfoutput>
	window.open(url2, "_self");
}

function checkModSpkr()
{
	if(document.frm1.GetModerators.value != "NULL")
	{
		if(document.frm1.GetSpeakers.value != "NULL")
		{
			return true;
		}
		else
		{
			alert("Please Select a Speaker.");
			return false;
		}

	}
	else
	{
		alert("Please Select a Moderator.");
		return false;
	}
}
</script>
</HEAD>

<cfif speakerID NEQ ''>
<!--- pull speakers by client and availability --->
<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetSpeakers">
	SELECT a.id, a.rowid, st.firstname, st.lastname, st.speaker_id, st.type, sc.client_code, sc.rowid as spkrrow, sc.fee
	FROM availability a, spkr_table st, speaker_clients sc
	WHERE active = 'ACT' AND a.id = sc.owner_id
	AND sc.client_code = '#Left(session.project_code, 5)#'
	AND a.id = st.speaker_id
	AND a.year=#year#
	AND a.month=#month#
	AND a.x#day#=1
	AND st.type='SPKR'
	ORDER BY st.lastname, st.firstname;
</CFQUERY>
</cfif>


<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="GetModerators">
	SELECT a.id, a.rowid, st.firstname, st.lastname, st.speaker_id, st.type, sc.client_code, sc.rowid as moderrow, sc.fee
	FROM availability a, spkr_table st, speaker_clients sc
	WHERE active = 'ACT' AND a.id = sc.owner_id
	AND sc.client_code = '#Left(session.project_code, 5)#'
	AND a.id = st.speaker_id
	AND a.year=#year#
	AND a.month=#month#
	AND a.x#day#=1
	AND st.type='MOD'
	ORDER BY st.lastname, st.firstname;
</CFQUERY>

<CFQUERY DATASOURCE="#application.projdsn#" NAME="GetNotes">
	SELECT remarks
	FROM schedule_meeting_time
	WHERE rowid = #URL.uniqueID#
</CFQUERY>

<BODY BGCOLOR="#FFFFFF" ALIGN="center">
<FORM NAME="frm1" method="post" action="meeting_time_edit_action.cfm?no_menu=1">
<cfoutput>
	<input type="hidden" name="meeting_code" value="#Meeting_code#">
	<input type="hidden" name="UniqueID" value="#Row_ID#">
	<input type="hidden" name="sequence" value="#sequence#">
	<input type="hidden" name="txtYear" value="#year#">
	<input type="hidden" name="txtMonth" value="#month#">
	<input type="hidden" name="txtDay" value="#day#">
	<input type="hidden" name="ModerID" value="#ModeratorID#">
	<input type="hidden" name="SpkerID" value="#SpeakerID#">
	<input type="hidden" name="MilitaryTimeBegin" value="#MilitaryBegin#">
	<input type="hidden" name="MilitaryTimeEnd" value="#MilitaryEnd#">
</cfoutput>
<CENTER>
<div style="font-size: 14px; font-family: arial; font-weight: bold; padding-bottom: 5px; color: navy;" width="100%">Update Meeting for <CFOUTPUT>#URL.month#/#URL.day#/#URL.year#</CFOUTPUT></div>
<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="0" width="100%" style="text-align: center;">
	<TR>
		<TD>&nbsp;</TD>
		<TD>&nbsp;</TD>
		<TD>&nbsp;</TD>
	</TR>
	<TR>
		<TD style="padding-bottom: 3px; border-bottom: solid 1px navy;"><B>Meeting Time</B></TD>
		<TD style="padding-bottom: 3px; border-bottom: solid 1px navy;"><B>Sequence</B></TD>
		<TD style="padding-bottom: 3px; border-bottom: solid 1px navy;"><B>Moderator</B></TD>
		<TD style="padding-bottom: 3px; border-bottom: solid 1px navy;"><B>Speaker</B></TD>
		<TD style="padding-bottom: 3px; border-bottom: solid 1px navy;"><B>Cancel Meeting?</B></TD>
	</TR>
	<TR>
		<TD style="padding-top: 4px;">
			<cfoutput>#CivTime#</cfoutput>
		</TD>
		<TD style="padding-top: 4px;">
			<SELECT NAME="GetSequence">
				<option value="A" <cfif url.sequence EQ 'A'>selected</cfif>>A
				<option value="B" <cfif url.sequence EQ 'B'>selected</cfif>>B
				<option value="C" <cfif url.sequence EQ 'C'>selected</cfif>>C
				<option value="D" <cfif url.sequence EQ 'D'>selected</cfif>>D
				<option value="E" <cfif url.sequence EQ 'E'>selected</cfif>>E
				<option value="F" <cfif url.sequence EQ 'F'>selected</cfif>>F
			</SELECT>
		</TD>
		<TD style="padding-top: 4px;">
			<SELECT NAME="GetModerators">
				<option value="NULL">(Select Moderator)
				<option value="0" <cfif url.modRowID EQ 0>selected</cfif>>TBD
				<CFOUTPUT QUERY="GetModerators">
					<option value="#GetModerators.moderrow#" <cfif #GetModerators.moderrow# EQ #ModeratorRowID#>selected</cfif>>#GetModerators.lastname#, #GetModerators.firstname# - #DollarFormat(GetModerators.fee)#
				</CFOUTPUT>
			</SELECT>
		</TD>
		<TD style="padding-top: 4px;">
		<cfif SpeakerID EQ ''>
			N/A <input type="hidden" name="GetSpeakers" value="1">
		<cfelse>
		<SELECT NAME="GetSpeakers">
			<option value="NULL">(Select Speaker)
			<option value="0" <cfif url.spkrRowID EQ 0>selected</cfif>>TBD
			<CFOUTPUT QUERY="GetSpeakers">
				<option value="#GetSpeakers.spkrrow#" <cfif #GetSpeakers.spkrrow# EQ #SpeakerRowID#>selected</cfif>>#GetSpeakers.lastname#, #GetSpeakers.firstname# - #DollarFormat(GetSpeakers.fee)#
			</CFOUTPUT>
		</SELECT>
		</cfif>
		</TD>
		<TD style="padding-top: 4px;">
		<SELECT NAME="Cancel">
			<option value="0">No
			<option value="1">Yes
		</SELECT>
		</TD>
	</TR>
	<tr><td colspan="4">&nbsp;</td></tr>
	<tr>
		<td colspan="4"><strong>Is this meeting for training purposes only?</strong>
		<input class="invis" type="radio" value="0" name="meeting_use"<cfif meeting_use EQ 0> checked</cfif>>No
		<input class="invis" type="radio" value="1" name="meeting_use"<cfif meeting_use EQ 1> checked</cfif>>Yes
		</td>
	</tr>
	<tr>
		<td>Notes</td>
		<cfoutput>
		<td colspan="3" align="left">
			<textarea name="notes" rows="3" cols="75" wrap="soft">#trim(getNotes.remarks)#</textarea>

		</td>
		</cfoutput>
	</tr>
</TABLE>
<p>&nbsp;</p>
<INPUT TYPe="button" VALUE="Save Changes" NAME="send_text" onclick="doIT();">&nbsp; &nbsp;
<INPUT TYPe="button" VALUE="   Go Back   " NAME="" onclick="GoBack()">
</CENTER>
</FORM>

</BODY>
</HTML>