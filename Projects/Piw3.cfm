<!--- 
	*****************************************************************************************
	Name:		piw3.cfm
	
	Function:	This page is a replica if the paper PIW form, PIW 3 is section 3 
				(Billing/Finance) from the paper PROJECT INTIATION FORM
	History:	tjs071801, finalized code
				bj0802901 - modified screen form layout
	
	*****************************************************************************************
--->

<!--- CFSWITCH statement to allow entering and saving of data in same CF form file --->
<CFSWITCH EXPRESSION="#URL.action#">
			
	<!--- Saves all data inputted from the above form --->
	<CFCASE VALUE="save">
	
		<!--- <CFIF IsDefined("form.piwadminedit_note")> --->
		<CFIF IsDefined("session.project_status") AND session.project_status EQ 'active'>
			<!--- Saves/Updates data in the database, note; record is INSERTED into database in PIWadd.cfm so an update may be used --->
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="piwnotecheck">
				SELECT *
				FROM piw_notes
				WHERE piw_id = '#session.rowid#' AND note_type = 'PIW3';
			</CFQUERY>
			
			<CFIF piwnotecheck.recordcount EQ 0>
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="INSERTRECORD">
				INSERT piw_notes(piw_id,note_type,note_data) 
				VALUES ('#session.rowid#','PIW3','#Left(form.piwadminedit_note, 500)#')
			</CFQUERY>
			<CFELSE>
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
				UPDATE piw_notes
				SET piw_id='#session.rowid#', 
					note_type ='PIW3',
					note_data='#Left(form.piwadminedit_note, 500)#',
					entry_date = #createodbcdate(Now())#,
					entry_time = #createodbctime(Now())#,
					entry_userid = #session.userinfo.rowid#
				WHERE piw_id = '#session.rowid#' AND note_type = 'PIW3'
			</CFQUERY>
			</CFIF>
		</CFIF>
		
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
		UPDATE billing_info
			SET project_code = '#session.project_code#',
				cost_per_attendee = '#Left(form.cost_per_attendee,50)#', 
				direct_mail_costs = '#Left(form.direct_mail_costs,50)#',
				additional_costs = '#Left(form.additional_costs,50)#', 
				finance_notes = '#Left(form.finance_notes,255)#',
				client_ap_contact = '#Left(form.client_ap_contact,50)#', 
				client_ap_phone_fax = '#Left(form.client_ap_phone_fax,50)#',
				billing_schedule = '#Left(form.billing_schedule,50)#'			
			WHERE project_code = '#session.project_code#';
		</CFQUERY>
		
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
			UPDATE piw 
			SET piw_update = #createodbcdate(Now())#,
				piw_update_user = #session.userinfo.rowid#
			WHERE project_code = '#session.project_code#';
		</CFQUERY>
		
		<CFOUTPUT>
			<META HTTP-EQUIV="refresh" CONTENT="0; Url=piw#URL.next_page#.cfm">
		</CFOUTPUT>
		
	</CFCASE>

	<CFDEFAULTCASE>
	
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="FORM_THREE">
			SELECT * FROM billing_info WHERE project_code = '#session.project_code#';
		</CFQUERY>
		
		<CFOUTPUT>
			<HEAD>
				<TITLE>Project Information Form - Billing/Finance</TITLE>
				<LINK REL="stylesheet" HREF="piw1style.css" TYPE="text/css">
				<SCRIPT SRC="PIW3checker.js"></SCRIPT>
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
						if( way == '4')
						{
							form.action = "piw3.cfm?action=save&next_page=4";
							if(validate(form))
							{	
								form.submit();
							}
						}
						else
						{
							form.action = "piw3.cfm?action=save&next_page=2";
							if(validate(form))
							{	
								form.submit();
							}
						}
						
						
					}
				</SCRIPT>
			</HEAD>
			
			<BODY BGCOLOR="FFFFFF">
			<div id="overDiv" style="position:absolute; visibility:hide;z-index:1;"></div>
			<SCRIPT LANGUAGE="JavaScript" SRC="overlib.js"></SCRIPT>
			<FORM NAME="form" ACTION="" METHOD="post">
			<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="600">
			<TR>
				<TD CLASS="tdheader">Project Initiation Form - BILLING/FINANCE</TD>
			</TR>
			<TR>
				<TD>
				<!--- Table containing input fields --->
				<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="15" WIDTH="600">									
				<TR>
					<TD align=right WIDTH="166"><SPAN CLASS="required"><B>Cost Per Attendee:</B></SPAN>&nbsp;</td>
					<td><INPUT CLASS="text"  NAME="cost_per_attendee" VALUE="#Trim(form_three.cost_per_attendee)#" TYPE="text" SIZE="10" MAXLENGTH="10"></TD>
				</TR>
				<TR>
					<TD align=right><SPAN CLASS="required"><B>Direct Mail Occuring Costs:</B></SPAN>&nbsp;</td>
					<td><INPUT CLASS="text" NAME="direct_mail_costs" VALUE="#Trim(form_three.direct_mail_costs)#" TYPE="text" SIZE="50" MAXLENGTH="50"></TD>
				</TR>
				<TR>
					<TD align=right><SPAN CLASS="required"><B>Additional Upfront Costs:</B></SPAN>&nbsp;</td>
					<td><INPUT CLASS="text" NAME="additional_costs" VALUE="#Trim(form_three.Additional_costs)#" TYPE="text" SIZE="50" MAXLENGTH="50"></TD>
				</TR>
				<TR>
					<TD align=right><SPAN CLASS="required"><B>Any Special Notes to Finance:</B></SPAN>&nbsp;</td>
					<td><TEXTAREA NAME="finance_notes" COLS="51" ROWS="4">#form_three.finance_notes#</TEXTAREA></TD>
				</TR>
				<TR> 
					<TD align=right><SPAN CLASS="required"><B>Client Accounts Payable Contact:</B></SPAN>&nbsp;</td>
					<td><INPUT CLASS="text" NAME="client_ap_contact" VALUE="#Trim(form_three.client_ap_contact)#" TYPE="text" SIZE="50" MAXLENGTH="50"></TD>
				</TR>
				<TR> 
					<TD align=right><SPAN CLASS="required"><B>Accounts Payable Phone/Fax Number:</B></SPAN>&nbsp;</td>
					<td><INPUT CLASS="text" NAME="client_ap_phone_fax" VALUE="#Trim(form_three.client_ap_phone_fax)#" TYPE="text" SIZE="50" MAXLENGTH="50"></TD>
				</TR>
				<TR> 
					<TD align=right><SPAN CLASS="required"><B>Schedule for Billing Client:</B></SPAN>&nbsp;</td>
					<td><INPUT CLASS="text" NAME="billing_schedule" VALUE="#Trim(form_three.billing_schedule)#" TYPE="text" SIZE="50" MAXLENGTH="50"></TD>
				</TR>
			</CFOUTPUT>
			
			<CFIF IsDefined ("session.project_status") AND (session.project_status EQ "active")>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="piwnotecheck">
					SELECT *
					FROM piw_notes
					WHERE piw_id = '#session.rowid#' AND note_type = 'PIW3'
				</CFQUERY>
										
				<TR>
					<TD align=right STYLE="vertical-align : middle;"><SPAN CLASS="required"><B>EDIT PIW COMMENTS:</B></SPAN>&nbsp;</TD>
					<TD COLSPAN="5"><TEXTAREA STYLE="vertical-align : middle;" NAME="piwadminedit_note" COLS="60" ROWS="4"><CFIF IsDefined ("session.project_status") AND piwnotecheck.recordcount NEQ 0><CFOUTPUT>#TRIM(piwnotecheck.note_data)#</CFOUTPUT></CFIF></TEXTAREA></TD>
					<CFOUTPUT><INPUT TYPE="hidden" VAlue="session.rowid" NAME="rowid"></CFOUTPUT>
				</TR>
			</CFIF>
				<TR>
						<TD colspan=6>
							<TABLE BORDER="0" WIDTH="100%">
								<TR>
									<TD ALIGN="LEFT" COLSPAN="4"><BR></td>
								</TR>
								<TR>
									<td><b><SCRIPT LANGUAGE="JavaScript">
	  <!-- Begin print button
	  if (window.print) {
	  document.write('<form>'
	  + '<input type=button  name=print value="  Print  " '
	  + 'onClick="javascript:window.print()"></form>');
	  }
	  // End print button-->
	  </script></b></td>
								
									<TD ALIGN="RIGHT" WIDTH="45%"><input TYPE="Button"  NAME="prev_page" VALUE="Previous Page" onCLick="whichway(2)"></td>
									<TD WIDTH="10%">&nbsp;</TD>
									<TD ALIGN="LEFT" WIDTH="45%"><input TYPE="Button"  NAME="next_page" VALUE="Next Page" onCLick="whichway(4)"></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
				</TABLE>
			</TD>
		</TR>
		</FORM>
		</TABLE>
	</BODY>
	</HTML>
	
	</CFDEFAULTCASE>
</CFSWITCH>
