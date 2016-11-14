<!--------------------------------------------------------------------------------
	NotesDelete.cfm
	Inserts new note into the 'notes' table.

	bj030501 - converted from Tango
----------------------------------------------------------------------------------
--->	
<HTML>
<HEAD><TITLE>Delete A Note</TITLE>
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
<FORM METHOD="POST" ACTION="NotesList.cfm?#Rand()#&no_menu=1">
</cfoutput>
<!--- delete the selected note --->
<cfif isDefined("URL.rowid")>
	<cfquery DATASOURCE="#application.projdsn#" name="qdeletenotes">
		delete from piw_notes where rowid = #URL.rowid#
	</cfquery>
	<!--- --->
	<cfoutput>
	<TABLE WIDTH=400 CELLSPACING=2 cellpadding=2>
	<TR BGCOLOR="##fbf9eb" ALIGN=CENTER>
		<TD COLSPAN=2>
			<b>The selected note was delete successfully!</b><br><br>
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
	<TABLE WIDTH=400 CELLSPACING=2 cellpadding=2>
	<TR BGCOLOR="##fbf9eb" ALIGN=CENTER>
		<TD COLSPAN=2>
			<b>Unable to delete the selected item...</b><br><br>
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
		<!--- 	<INPUT onClick="Closeme()" TYPE=image src="#session.appfilepath#images/btn_cancel.gif" name=cancel><br>Close Window --->
			</FORM>
		</TD>
	</TR>
	</TABLE>
	</cfoutput>
</cfif>
</BODY>
</HTML>	