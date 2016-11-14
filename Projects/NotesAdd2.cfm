<!--------------------------------------------------------------------------------
	NotesAdd2.cfm
	Inserts new note into the 'notes' table.

	bj030501 - converted from Tango
----------------------------------------------------------------------------------
--->	
<HTML>
<HEAD><TITLE>Insert New Note</TITLE>
<LINK REL="stylesheet" HREF="piw1style1.css" TYPE="text/css">
<SCRIPT language=javascript>
<!-- 
function Closeme() {
        flyout=window.close()
	}
// -->
</SCRIPT>
</HEAD>

<!--- insert info into the notes table --->
<cfquery DATASOURCE="#application.projdsn#" name="qinsertnotes">
	insert into piw_notes (project_code, note_type, subject, note_data, entry_date, entry_time, entry_userid)
	values ('#session.project_code#', 'GEN', '#trim(left(form.subject, 65))#', 
			'#trim(left(form.note_text, 255))#', '#dateFormat(now(), "mm/dd/yyyy")#', '#dateFormat(now(), "mm/dd/yyyy")#', '#session.userinfo.rowid#' )
</cfquery>
<!--- --->
<cfoutput>
<BODY background="images/blue_stripe.jpg">
<FORM METHOD="POST" ACTION="NotesList.cfm?#Rand()#&no_menu=1">
<TABLE WIDTH=400 CELLSPACING=2 cellpadding=2>
<TR BGCOLOR="##eeeecc" ALIGN=CENTER>
	<TD COLSPAN=2>
		Your new note was added successfully!<br><br>
		Click the <b><i>Return</i></b> key to return to the notes summary page.<br><br>
	</td>
</TR>
<TR HEIGHT=10><TD colspan=2>&nbsp;</TD></TR>
<TR>
	<TD width=200>
		<INPUT TYPE="submit" NAME="return" VALUE="Return to Note Summary">
		<!--- <INPUT TYPE=image src="images/btn_return.gif" name=return><br>to Note Summary --->
		</FORM>
	</TD>
	<TD WIDTH=200>
		<FORM>
		<INPUT TYPE="submit" NAME="close" VALUE="Close Window" onClick="Closeme()">
		<!--- <INPUT onClick="Closeme()" TYPE=image src="#session.appfilepath#images/btn_cancel.gif" name=cancel><br>Close Window --->
		</FORM>
	</TD>
</TR>
</TABLE>
</cfoutput>
</BODY>
</HTML>	