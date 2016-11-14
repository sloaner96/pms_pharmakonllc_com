<!--------------------------------------------------------------------------------
	NotesEdit2.cfm
	Updates a note editted in NotesEdit.cfm

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
<cfoutput><BODY background="images/blue_stripe.jpg"></cfoutput>
<cfif isDefined("form.rowid")>
	<!--- get some email info from the notes table --->
	<cfquery DATASOURCE="#application.projdsn#" name="qupdatenotes">
	update piw_notes 
		set subject = '#trim(left(form.subject, 65))#',
		note_data = '#trim(left(form.note_text, 255))#', 
		entry_date = '#dateFormat(now(), "mm/dd/yyyy")#',
		entry_time =  '#dateFormat(now(), "mm/dd/yyyy")#',
		entry_userid = '#session.userinfo.rowid#' 
	where rowid = #form.rowid#
	</cfquery>
	<!--- --->
	<cfoutput>
	<FORM METHOD="POST" ACTION="NotesList.cfm?#Rand()#&no_menu=1">
	<TABLE WIDTH=400 CELLSPACING=2 cellpadding=2>
	<TR BGCOLOR="##fbf9eb" ALIGN=CENTER>
		<TD COLSPAN=2>
			<b>Your note was updated successfully!</b><br><br>
			Click the <b><i>Return</i></b> key to return to the notes summary page.<br><br>
		</td>
	</TR>
	<TR HEIGHT=10><TD colspan=2>&nbsp;</TD></TR>
	<TR>
		<TD width=200>
			<INPUT TYPE="submit" NAME="return" VALUE="Return to Notes List">
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
<cfelse>
	<cfoutput>
	<FORM METHOD="POST" ACTION="NotesList.cfm?#Rand()#&no_menu=1">
	<TABLE WIDTH=400 CELLSPACING=2 cellpadding=2>
	<TR BGCOLOR="##fbf9eb" ALIGN=CENTER>
		<TD COLSPAN=2>
			<b>Your note was <u>not</u> updated!</b><br><br>
			Click the <b><i>Return</i></b> key to return to the notes summary page.<br><br>
		</td>
	</TR>
	<TR HEIGHT=10><TD colspan=2>&nbsp;</TD></TR>
	<TR>
		<TD width=200>
		<INPUT TYPE="submit" NAME="return" VALUE="Return to Notes List">
			<!--- <INPUT TYPE=image src="#session.appfilepath#images/btn_return.gif" name=return><br>to Note Summary --->
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
</cfif>
</BODY>
</HTML>	