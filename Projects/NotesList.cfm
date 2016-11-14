<!--------------------------------------------------------------------------------
	NotesList.cfm
	List any available notes for a project code.
	Allows the user to add new notes if none exist or add, change, delete notes
	if notes do exist.
	
	bj020901 - converted from Tango
	lb101501 - copied over from Solvay
----------------------------------------------------------------------------------
--->	
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<cfoutput>
<cfif IsDefined("client_code")>
	<cfset session.client_code = #client_code#>
</cfif>
<cfif IsDefined("project_code")>
	<cfset session.project_code = #project_code#>
</cfif>
</cfoutput>
<TITLE>Project Notes</TITLE>
<LINK REL="stylesheet" HREF="piw1style1.css" TYPE="text/css">
<SCRIPT language=javascript>
<!-- 
function Closeme() {
        flyout=window.close()
	}
// -->
</SCRIPT>
</HEAD>
<!--- get info from the notes table --->
<CFQUERY DATASOURCE="#application.projdsn#" NAME="qgetnotes">
	select n.note_type, n.note_data, n.entry_date, n.entry_time, n.entry_userid, n.rowid, n.subject
	from piw_notes n
	where n.project_code = '#session.project_code#'
</cfquery>
<!--- <cfoutput><BODY background="images/blue_stripe.jpg"></cfoutput> --->
<cfif qgetnotes.recordcount LT 1>
	<cfoutput>
	<TABLE WIDTH="400" BORDER="0" CELLSPACING="0" CELLPADDING="0">	
	<TR>
		<TD bgcolor="##eeeecc" colspan=2 align=center>
			<br><b>There are no Notes for Project: #session.project_code#<br><br>
		</td>
	</tr>
	<tr bgcolor="##eeeecc"><td height=25 colspan=2>&nbsp;</td></tr>
	<TR>
		<TD bgcolor="##eeeecc" align=center valign=center>
			<FORM METHOD="POST" ACTION="NotesAdd.cfm?#Rand()#&no_menu=1">
			<INPUT TYPE="submit" NAME="add" VALUE="Add Note">
			<!--- <INPUT NAME="submit" TYPE="image" src="images/Addbtn.gif"><br>Add a Note --->
			</form>
		</TD>
		<TD bgcolor="##eeeecc" align=center valign=center>
			<FORM METHOD="POST" onClick="Closeme();">
			<INPUT TYPE="submit" NAME="close" VALUE=" Close ">
			<!--- <INPUT NAME="submit" TYPE="image" src="images/Backbtn.gif"><br>Close Window --->
			</form>
		</TD>
	</tr>
	</TABLE>
	</cfoutput>
<cfelse>
	<cfoutput>
	<TABLE BORDER=0 CELLSPACING=2 CELLPADDING=2  style="border: 1px solid black;">
	<TR BGCOLOR="##fbf9eb" ALIGN=CENTER>
		<TD COLSPAN=3><B>Notes for Project: #session.project_code#</B></FONT></TD>
	</TR>
	<TR BGCOLOR="##eeeecc">
		<TD COLSPAN=3>Click on a note subject to display the entire note.</TD>
	</TR>
	<TR HEIGHT="20"><TD colspan=3></TD></TR>
	<TR VALIGN=TOP ALIGN=LEFT>
		<TD><B><U>Subject:</U></B></TD>
		<TD><B><U>Created by:</U></B></TD>
		<TD><B><U>Date:</U></B></TD>
	</TR>
	</cfoutput>
	<cfoutput query="qgetnotes">
	<cfif qgetnotes.currentrow MOD 2 EQ 1>
		<TR VALIGN=TOP BGCOLOR="##CCCCCC">
	<cfelse>
		<tr>
	</cfif>
			<TD><A HREF="NotesDetail.cfm?rowid=#qgetnotes.rowid#&no_menu=1"><B>#qgetnotes.subject#</B></A></TD>

	<!--- Pull user name --->
	<CFQUERY DATASOURCE="#session.login_dbs#" NAME="quser" USERNAME="#session.login_dbu#" PASSWORD="#session.login_dbp#">
		SELECT rowid, first_name, last_name
		FROM user_id
		WHERE rowid = #qgetnotes.entry_userid#
		ORDER BY last_name, first_name
		</CFQUERY>	
			<TD>#Trim(quser.first_name)# #Trim(quser.last_name)#</TD>
			<TD>#dateFormat(qgetnotes.entry_time, "mm/dd/yyyy")#</TD>
		</TR>
	</cfoutput>
	<cfoutput>
	<TR><TD HEIGHT="20" colspan=3></TD></TR>
	</TABLE>
	<TABLE width=400 BORDER=0 CELLSPACING=2 CELLPADDING=2>
	<TR>
		<TD width=200>
			<FORM METHOD="POST" ACTION="NotesAdd.cfm?#Rand()#&no_menu=1">
			<INPUT TYPE="submit" NAME="add" VALUE="Add Note">
			<!--- <INPUT TYPE=image src="images/btn_add.gif" name=add><br>New Note --->
			</form>
		</TD>
		<TD width=200>
			<FORM>
			<INPUT TYPE="submit" NAME="close" VALUE=" Close " onclick="Closeme()">
			<!--- <INPUT onclick="Closeme()" TYPE=image src="images/btn_cancel.gif" name=cancel><br>Close Window --->
			</form>
		</TD>
	</TR>
	</TABLE>
	</FORM>
	</cfoutput>
</cfif>
</BODY>
</HTML>
