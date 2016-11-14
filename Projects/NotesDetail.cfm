<!--------------------------------------------------------------------------------
	NotesDetail.cfm
	Detail display of selected note from NotesList.cfm
	
	bj030501 - converted from Tango
----------------------------------------------------------------------------------
--->	
<SCRIPT LANGUAGE="JavaScript">
<!-- 
function Closeme() {
    flyout=window.close()
	}

function verify() {
var ok = null;
	ok = confirm("Are you sure you want to delete this note?");
	if (ok == true) return true;
	else return false;	
}
// -->
</SCRIPT>
<HTML>
<HEAD><TITLE>Note Detail Page</TITLE>
<LINK REL="stylesheet" HREF="piw1style1.css" TYPE="text/css">
</HEAD>
<cfoutput><BODY background="images/blue_stripe.jpg"></cfoutput>
<!--- get some info from the notes table --->
<cfif isDefined("URL.rowid")>
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qgetnotes">
	select n.note_type, n.note_data, n.entry_date, n.entry_time, n.entry_userid, n.rowid, n.subject
		from piw_notes n
	where n.rowid = #url.rowid#
</cfquery>
	<cfoutput>
	<TABLE WIDTH=500 CELLSPACING=2 cellpadding=2>
	<TR BGCOLOR="##fbf9eb" ALIGN=CENTER>
		<TD COLSPAN=3><B>Note for Project: #session.project_code#</B>
	</TR>
	<TR HEIGHT="10"><TD colspan=2>&nbsp;</TD></TR>
	<TR>
	<!--- Pull user name --->
<CFQUERY DATASOURCE="#session.login_dbs#" NAME="quser" USERNAME="#session.login_dbu#" PASSWORD="#session.login_dbp#">
		SELECT rowid, first_name, last_name
		FROM user_id
		WHERE rowid = #qgetnotes.entry_userid#
		ORDER BY last_name, first_name
		</CFQUERY>	
		<TD WIDTH=100 align=right><B>Created by:</B></td>
		<td width=400 align=left>#trim(quser.first_name)# #trim(quser.last_name)#</TD>
	</tr>
	<tr>
		<TD WIDTH=100 align=right><B>Created on:</B></td>
		<td width=400 align=left>#dateFormat(qgetnotes.entry_date, "mm/dd/yyyy")#</TD>
	</TR>
	<TR>
		<TD width=100 align=right><B>Subject:</B></td>
		<td width=400 align=left>#trim(qgetnotes.subject)#</TD>
	</TR>
	<TR>
		<TD COLSPAN=3>#trim(qgetnotes.note_data)#</TD>
	</TR>
	<TR><TD HEIGHT=25>&nbsp;</TD></TR>
	</table>
	<TABLE WIDTH=500 CELLSPACING=2 cellpadding=2>
	<TR>
		<TD WIDTH=150>
			<FORM METHOD="POST" ACTION="NotesList.cfm?#Rand()#&no_menu=1">
			<INPUT TYPE="submit" NAME="return" VALUE="Return to Notes List">
			<!--- <INPUT TYPE=image src="#session.appfilepath#images/btn_return.gif" name=return><br>to Notes List --->
			</FORM>
		</TD>
		<TD WIDTH=150>
			<FORM METHOD="POST" onSubmit="return verify(this);" ACTION="NotesDelete.cfm?rowid=#qgetnotes.rowid#&#Rand()#&no_menu=1">
			<INPUT TYPE="submit" NAME="delete" VALUE="Delete Note">
			<!--- <INPUT TYPE=image src="images/btn_delete.gif" name=delete><br>This Note --->
			</FORM>
		</TD>
		<TD WIDTH=150>
			<FORM METHOD="POST" ACTION="NotesEdit.cfm?rowid=#qgetnotes.rowid#&#Rand()#&no_menu=1">
			<INPUT TYPE="submit" NAME="edit" VALUE="Edit Note">
			<!--- <INPUT TYPE=image src="images/btn_edit.gif" name=edit><br>This Note --->
			</FORM>
		</TD>
	</TR>
	<tr>
		<td width=150>
		<INPUT TYPE="submit" NAME="print" VALUE="  Print  " onClick="javascript:window.print()">
			<!--- <INPUT TYPE=image src="images/btn_print.gif" name=print onClick="javascript:window.print()"> --->
		</TD>
		<TD WIDTH=150>
			<FORM>
			<INPUT TYPE="submit" NAME="close" VALUE="Close Window" onClick="Closeme()">
			<!--- <INPUT onclick="Closeme()" TYPE=image src="images/btn_cancel.gif" name=cancel><br>Close Window --->
			</FORM>
		</TD>
		<td width=150>&nbsp;</td>
	</tr>
	</TABLE>
	</cfoutput>
<cfelse>
	<cfoutput>
	<TABLE WIDTH=400 CELLSPACING=2 cellpadding=2>
	<TR BGCOLOR="##eeeecc" ALIGN=CENTER>
		<TD COLSPAN=2>
			Unable to locate the client/project note selected, please try again...<br><br>
		</td>
	</TR>
	<TR HEIGHT="10"><TD colspan=2>&nbsp;</TD></TR>
	<TR>
		<TD WIDTH=200>
			<FORM METHOD="POST" ACTION="NotesList.cfm?#Rand()#">
			<INPUT TYPE="submit" NAME="try" VALUE="Try Again">
			<!--- <INPUT TYPE=image src="images/btn_tryagain.gif" name=tryagain> --->
			</FORM>
		</TD>
		<TD WIDTH=200>
			<FORM>
			<INPUT TYPE="submit" NAME="close" VALUE="Close Window" onClick="Closeme()">
			<!--- <INPUT onclick="Closeme()" TYPE=image src="#session.appfilepath#images/btn_cancel.gif" name=cancel><br>Close Window --->
			</FORM>
		</TD>
	</TR>
	</TABLE>
	</cfoutput>
</cfif>
</BODY>
</HTML>
	