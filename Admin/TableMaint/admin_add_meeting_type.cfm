<!--- 
	*****************************************************************************************
	Name:		piw_admin_add_meeting_type.cfm
	
	Function:	
	History:	11/16/01 TJS Developed This Page
	
	*****************************************************************************************
--->
<cfparam name="URL.Action" default="">
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Add New Meeting Type" showCalendar="0">

<!--- <CFSET session.project_admin=0> --->
<CFSWITCH EXPRESSION="#URL.action#">

<!--- Case to perform edit action that was selected --->
	<CFCASE VALUE="add">
	
		
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="INSERTRECORD">
				INSERT meeting_type(meeting_type_value) 
				VALUES ('#Left(form.new_meeting_type, 2)#')
			</CFQUERY>
		<!--- <CFOUTPUT>
			<META HTTP-EQUIV="REFRESH" CONTENT="0; URL=#form.edit_action#">
		</CFOUTPUT> --->
		
	</CFCASE>

<!--- Default case to present edit selection form to user --->	
	<CFDEFAULTCASE>

			
				<!--- Query to all Meeting Type and Populate a list for the User's reference --->
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="info">
					SELECT meeting_type_value 
					FROM meeting_type
					ORDER BY meeting_type_value
				</CFQUERY>
				<FORM ACTION="piw_admin_add_meeting_type.cfm?action=add" METHOD="post">
					<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="60%">
						
						<TR>
							<TD>
								<!--- Table containing input fields --->
								<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="15" WIDTH="85%">
									<TR>
							    		<TD ALIGN="center" VALIGN="top">
											<strong>New Meeting Type : </strong><INPUT TYPE="text" name="new_meeting_type" CLASS="text">
										    <br><br><INPUT TYPE="submit" NAME="submit" VALUE="  Submit  ">
										</TD>
							    		<TD ALIGN="left">
											<TABLE STYLE="border: 1px solid black" CELLPADDING="2" CELLSPACING="2">
												<TR bgcolor="#eeeeee">
													<TD COLSPAN="4"><U><strong>Existing Meeting Types</strong></U></TD>
												</TR>
												<TR><CFSET i=0>
													<CFOUTPUT QUERY="info"><TD STYLE="border: 1px solid black">#meeting_type_value#<CFSET i=i+1></TD><CFIF i MOD 4 EQ 0></TR><TR></CFIF></CFOUTPUT></TD>
												</TR>
											</TABLE>

											<br>
											
										</TD>
									</TR>
								</TABLE>
							</TD>
						</TR>
					</TABLE>
				</FORM>

	</CFDEFAULTCASE>
</CFSWITCH>

<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

