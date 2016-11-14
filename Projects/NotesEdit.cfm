<!--------------------------------------------------------------------------------
	NotesEdit.cfm
	Allows editting of a note.

	bj030501 - converted from Tango
----------------------------------------------------------------------------------
--->	
<HTML>
<HEAD><TITLE>Edit A Note</TITLE>
<LINK REL="stylesheet" HREF="piw1style1.css" TYPE="text/css">
<SCRIPT language=javascript>
<!-- 
function Closeme() {
        flyout=window.close()
	}
// -->
</SCRIPT>
</HEAD>
<cfoutput>
<BODY background="images/blue_stripe.jpg">
</cfoutput>
<!--- get some email info from the notes table --->
<cfif isDefined("URL.rowid")>
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qgetnotes">
	select n.note_type, n.note_data, n.entry_date, n.entry_time, n.entry_userid, n.rowid, n.subject
	from piw_notes n
	where n.rowid = #url.rowid#
</cfquery>
	<cfoutput>
	<FORM METHOD="POST" ACTION="NotesEdit2.cfm?#Rand()#&no_menu=1">
	<TABLE WIDTH=400 CELLSPACING=2 cellpadding=2>
	<TR BGCOLOR="##fbf9eb" ALIGN=CENTER>
		<TD COLSPAN=2><B>Edit a Note for Client/Project: #session.client_code#</B>
	</TR>
	<TR HEIGHT=10><TD colspan=2>&nbsp;</TD></TR>
	<TR>
		<TD WIDTH=100>Subject:</TD>
		<TD WIDTH=300>
			<INPUT TYPE="TEXT" NAME="subject" SIZE="50" maxlength=66 value="#trim(qgetnotes.subject)#">
		</TD>	
	</TR>
	<tr><td colspan=2>Enter Note Text Below (255 character max)</td></tr>
	<TR>
		<TD COLSPAN="2">
			<TEXTAREA NAME="note_text" COLS="50" ROWS="5">#Trim(qgetnotes.note_data)#</TEXTAREA>
		</TD>
	</TR>
	<tr>
		<td colspan=2>
			<input type=hidden name=rowid value="#qgetnotes.rowid#">
		</td>
	</tr>
	</table>
	<TABLE WIDTH=400 CELLSPACING=2 cellpadding=2>
	<TR>
		<TD width=200>
			<INPUT TYPE="submit" NAME="change" VALUE=" Update ">
			<!--- <INPUT TYPE=image src="images/btn_update.gif" name=submit><br>Changes --->
			</FORM>
		</TD>
		<TD WIDTH=200>
			<FORM METHOD="POST" ACTION="NotesList.cfm?#Rand()#&no_menu=1">
			<INPUT TYPE="submit" NAME="return" VALUE="Return to Notes List - No changes">
			<!--- <INPUT TYPE=image src="images/btn_return.gif" name=return><br>to Note List<br>(no changes) --->
			</FORM>
		</TD>
	</TR>
	</TABLE>
	</cfoutput>
<cfelse>
	<cfoutput>
	<TABLE WIDTH=400 CELLSPACING=2 cellpadding=2>
	<TR BGCOLOR="##fbf9eb" ALIGN=CENTER>
		<TD COLSPAN=2><B>The select note could not be found!</B>
	</TR>
	<TR HEIGHT=10><TD colspan=2>&nbsp;</TD></TR>
	<TR>
		<TD WIDTH=200>
			<FORM METHOD="POST" ACTION="NotesList.cfm?#Rand()#&no_menu=1">
			<INPUT TYPE="submit" NAME="return" VALUE="Return to Notes List">
			<!--- <INPUT TYPE=image src="images/btn_return.gif" name=return><br>to Note List --->
			</FORM>
		</TD>
		<td width=200>&nbsp;</td>
	</TR>
	</TABLE>
	</cfoutput>
</cfif>
</BODY>
</HTML>
	