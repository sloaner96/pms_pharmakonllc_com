<!--- 
	*****************************************************************************************
	Name:		piw7.cfm
	
	Function:	This page is a replica if the paper PIW form, PIW 7 is section 7 
				(Special Roster Needs) from the paper PROJECT INTIATION FORM
	History:	tjs071801 - finalized code
				bj083001 - revised screen form layout.
	
	*****************************************************************************************
--->
<CFSWITCH EXPRESSION="#URL.action#">
			
	<!--- Saves all data inputted from the above form --->
	<CFCASE VALUE="save">
		<!--- <CFIF IsDefined("form.piwadminedit_note")> --->
		<CFIF IsDefined("session.project_status") AND session.project_status EQ 'active'>
			<!--- Saves/Updates data in the database, note; record is INSERTED into database in PIWadd.cfm so an update may be used --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="piwnotecheck">
				SELECT *
				FROM piw_notes
				WHERE piw_id = '#session.rowid#' AND note_type = 'PIW7';
			</CFQUERY>
			
			<CFIF piwnotecheck.recordcount EQ 0>
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="INSERTRECORD">
				INSERT piw_notes(piw_id,note_type,note_data) 
				VALUES ('#form.rowid#','PIW7','#RTrim(form.piwadminedit_note)#')
			</CFQUERY>
			<CFELSE>
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
				UPDATE piw_notes
				SET piw_id='#form.rowid#', 
					note_type ='PIW1 General Info',
					note_data='#RTrim(form.piwadminedit_note)#'
				WHERE piw_id = '#session.rowid#' AND note_type = 'PIW7'
			</CFQUERY>
			</CFIF>
		</CFIF>
		
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
			UPDATE roster_info 
			SET	roster_notes = '#RTrim(form.roster_notes)#'
			WHERE project_code = '#session.project_code#';
		</CFQUERY>
		
		<CFOUTPUT>
			<META HTTP-EQUIV="refresh" CONTENT="0; Url=#URL.next_page#.cfm">
		</CFOUTPUT>
		
	</CFCASE>

	<CFDEFAULTCASE>
		<CFINCLUDE TEMPLATE="report_piw.cfm">
		
		<!--- <CFQUERY DATASOURCE="#application.projdsn#" NAME="form_seven">
			SELECT roster_notes 
			FROM roster_info 
			WHERE project_code = '#session.project_code#';
		</CFQUERY>
		<CFOUTPUT>
			<HTML>
				<HEAD>
					<TITLE>Project Initiation Form - Special Roster Needs</TITLE>
					<LINK REL="stylesheet" HREF="piw1style.css" TYPE="text/css">
					<!--- <SCRIPT SRC="confirm.js"></SCRIPT>
					<SCRIPT SRC="textareacheck.js"></SCRIPT> --->
					
					<SCRIPT>
						// Determines which page to load based on what button was selected at bottom of page
						function whichway(way)
						{
							<CFIF IsDefined ("session.project_status") AND (session.project_status EQ "active")>	
								if (!form.piwadminedit_note.value)
								{
								alert("Please justify the editing of this form.");
								return false;
								}
							</CFIF>
							if( way == '8')
							{
								form.action = "piw7.cfm?action=save&next_page=index";
							}
							else
							{
								form.action = "piw7.cfm?action=save&next_page=piw6";
							}
							
							form.submit();
						}
					</SCRIPT>
				</HEAD>
			
				<BODY BGCOLOR="white">
				<FORM NAMe="form" ACTION="" METHOD="post">
				<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="600">
				<TR>
					<TD CLASS="tdheader">Project Initiation Form - SPECIAL ROSTER NEEDS</TD>
				</TR>
				<TR>
					<TD>
					<!--- Table containing input fields --->
					<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="0" WIDTH="600">								
					<TR><TD COLSPAN="3">&nbsp;</TD></TR>
					<TR><TD COLSPAN="3">&nbsp;</TD></TR>
					<TR>
						<TD WIDTH="50">&nbsp;</TD>
						<TD WIDTH="162" VALIGN="Middle" ALIGN="right"><B>Special Roster Needs:</B></TD>
						<TD WIDTH="500"><TEXTAREA NAME="roster_notes" COLS="75" ROWS="10">#form_seven.roster_notes#</TEXTAREA></TD>
					</TR>
					<TR>
						<TD>&nbsp;</TD>
						<TD>&nbsp;</TD>
						<TD>*This section is to be completed by the MIS Group</TD>
					</TR>
					<TR><TD COLSPAN="3">&nbsp;</TD></TR>
					<TR><TD COLSPAN="3">&nbsp;</TD></TR>
					<TR><TD COLSPAN="3">&nbsp;</TD></TR>
					<TR><TD COLSPAN="3">&nbsp;</TD></TR>
					<TR> 
						<TD ALIGN="Center" COLSPAN="3">
							<input TYPE="Button"  NAME="prev_page" VALUE="Previous Page" onCLick="whichway(6)">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input TYPE="Button"  NAME="next_page" VALUE="Finish Request" onCLick="whichway(8)">
						</TD>
					</TR>
					<TR><TD COLSPAN="3">&nbsp;</TD></TR>
					</TABLE>
				</TD>
			</TR>
			</TABLE>
			</BODY>
			</HTML>
		</CFOUTPUT> --->
	</CFDEFAULTCASE>
</CFSWITCH>
