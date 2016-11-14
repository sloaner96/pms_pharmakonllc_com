<!--------------------------------------------------------------------------------
	NotesAdd.cfm
	Allows addition of new notes.

	bj030501 - converted from Tango
----------------------------------------------------------------------------------
--->	
<HTML>
<HEAD><TITLE>Add New Note</TITLE>
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
<FORM METHOD="POST" ACTION="NotesAdd2.cfm?#Rand()#&no_menu=1">
<TABLE WIDTH=400 CELLSPACING=2 cellpadding=2>
<TR BGCOLOR="##fbf9eb" ALIGN=CENTER>
	<TD COLSPAN=2><B>Add a Note for Meeting: #session.client_code#</B>
</TR>
<TR HEIGHT=10><TD colspan=2>&nbsp;</TD></TR>
<TR>
	<TD WIDTH=100>Subject:</TD>
	<TD WIDTH=300>
		<INPUT TYPE="TEXT" NAME="subject" SIZE="50" maxlength=66>
	</TD>	
</TR>
<tr><td colspan=2>Enter Note Text Below (255 character max)</td></tr>
<TR>
	<TD COLSPAN="2">
		<TEXTAREA NAME="note_text" COLS="50" ROWS="5"></TEXTAREA>
	</TD>
</TR>
<tr><td colspan=2>&nbsp;</td></tr>
</table>
<TABLE WIDTH=400 CELLSPACING=2 cellpadding=2>
<TR>
	<TD width=200>
		<INPUT TYPE="submit" NAME="add" VALUE="Add New Note">
		<!--- <INPUT TYPE=image src="images/btn_submit.gif" name=submit><br>New Meeting Note --->
		</FORM>
	</TD>
	<TD WIDTH=200>
		<FORM METHOD="POST" ACTION="NotesList.cfm?#Rand()#&no_menu=1">
		<INPUT TYPE="submit" NAME="return" VALUE="Cancel (No Note Added)">
		<!--- <INPUT TYPE=image src="images/btn_return.gif" name=return><br>to Note Summary<br>(no note added) --->
		</FORM>
	</TD>
</TR>
</TABLE>
</cfoutput>
</BODY>
</HTML>
	