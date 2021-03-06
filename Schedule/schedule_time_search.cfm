<!--- 	Search for availability times for speakers and moderators
		
--->   
<cfparam name="URL.action" default="">                  
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Moderator/Speaker Available Time" showCalendar="0">

			
	<CFSWITCH EXPRESSION="#URL.action#">
	<!--- Case for submitting a new project code to be added --->
		<CFCASE VALUE="search">
			
			<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="find_speakers">
				SELECT *
				FROM Speaker
				WHERE active = 'yes'
				<CFIF Len("form.lastname") GT 0>AND lastname LIKE '#trim(form.lastname)#%'</CFIF>
				<CFIF Len("form.firstname") GT 0>
					AND firstname LIKE '#trim(form.firstname)#%'</CFIF>
				ORDER BY type, lastname, firstname;
			</CFQUERY>
			<CFSET bg_color = "E0E0E0">
			
			<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="100%">
					
					<TR> 
						<TD>	<!--- Table containing input fields --->
							<TABLE WIDTH="99%" BORDER="0" CELLSPACING="2" CELLPADDING="3">
								<TR>
									<TD>&nbsp;</TD>
								</TR>
								
								<TR><CFOUTPUT>
									<TD STYLE="background-color:#bg_color#;" WIDTH="20%"><B>Name</B></TD>
								</CFOUTPUT></TR>

								<CFOUTPUT QUERY="Find_Speakers">
									<TR>
									  <TD STYLE="background-color:#bg_color#;"><A HREF="schedule_time_list.cfm?&id=#trim(speakerid)#">#lastname#, #firstname#</A> - #type#</TD>
										
									</TR>
								
								</CFOUTPUT>
								<TR>
									<TD>&nbsp;</TD>
								</TR>
<form action="schedule_time_search.cfm?action=0" method="post">
	<TR>
		<TD><INPUT TYPE="submit"  VALUE="Search Again"></TD>
	</TR>
</form>
							</TABLE>
						</TD>
					</TR>
			</TABLE>
		</CFCASE>
		
<!--- Default Case to allow a user to search --->		
		<CFDEFAULTCASE>
			<FORM action="schedule_time_search.cfm?action=search" METHOD="post" NAME="form">
				<TABLE ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="100%">
					<TR> 
						<TD>	<!--- Table containing input fields --->
							<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="25" WIDTH="99%">
								<TR>
									<TD>&nbsp;</TD>
									<TD><B>First Name:&nbsp;</B> <INPUT TYPE="text" NAME="Firstname" CLASS="text" VALUE=""></TD>
									<TD COLSPAN="3"><B>Last Name:&nbsp;</B> <INPUT TYPE="text" NAME="Lastname" CLASS="text" VALUE=""></TD>
								</TR>
								<!---  										
								<TR>
									<TD>&nbsp;</TD>
									<TD><B>City:</B> &nbsp;<INPUT TYPE="text" NAME="City" CLASS="text" SIZE="27"></TD>
									<TD COLSPAN="2"><B>State:</B> &nbsp;<INPUT TYPE="text" NAME="State" CLASS="text" SIZE="3">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B>Zip:</B> &nbsp;<INPUT TYPE="text" NAME="Zipcode" CLASS="text" SIZE="6"></TD>
								</TR>
								--->	
								<TR>
									<TD COLSPAN="5">&nbsp;</TD>
								</TR>
								
								<TR>
									<TD COLSPAN="5" ALIGN="Center">
										<INPUT TYPE="submit"  VALUE="Search for Speaker/Moderator">
									</TD>
								</TR>
								
								<TR>
									<TD WIDTH="20"></TD>
									<TD WIDTH="200"></TD>
									<TD WIDTH="200"></TD>
									<TD WIDTH="200"></TD>
									<TD WIDTH="100"></TD>
								</TR>
								
							</TABLE>
						</TD>
					</TR>
				</TABLE>
			</FORM>
		</CFDEFAULTCASE>
	</CFSWITCH>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

