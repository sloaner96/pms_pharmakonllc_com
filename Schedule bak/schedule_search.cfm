<!--- 	This is The main search interface for searching rosters TABLE 
		Created by Michael Dragilev on 06/04/2001
		Edited : 7/19/01 TJS
		Edited : 7/24/01 CJL
--->    
<cfparam name="URL.Action" default="">                 
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Search for Schedule" showCalendar="0">

			
	<CFSWITCH EXPRESSION="#URL.action#">
	<!--- Case for submitting a new project code to be added --->
		<CFCASE VALUE="search">
			
			<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="find_speakers">
				SELECT *
				FROM spkr_table
				WHERE active = 'ACT' 
				<CFIF Len("form.lastname") GT 0>AND lastname LIKE '#trim(form.lastname)#%'</CFIF>
				<CFIF Len("form.firstname") GT 0>
					AND firstname LIKE '#trim(form.firstname)#%'</CFIF>
				ORDER BY type, lastname, firstname;
			</CFQUERY>
			<CFSET bg_color = "EEEEEE">
			
<!--- Table containing input fields --->
							<TABLE WIDTH="99%" BORDER="0" CELLSPACING="2" CELLPADDING="3">
								<TR>
									<TD>&nbsp;</TD>
								</TR>
								
								<TR><CFOUTPUT>
									<TD STYLE="background-color:#bg_color#;" WIDTH="20%"><B>Name</B></TD>
								</CFOUTPUT></TR>

								<CFOUTPUT QUERY="Find_Speakers">
									<TR>
										<TD STYLE="background-color:#bg_color#;"><A HREF="schedule_insert.cfm?&id=#trim(speaker_id)#">#lastname#, #firstname#</A> - #type#</TD>	
									</TR>
								</CFOUTPUT>
								<TR>
									<TD>&nbsp;</TD>
								</TR>
								<form action="schedule_search.cfm?action=0" method="post">
									<TR>
										<TD><INPUT TYPE="submit"  VALUE="Search Again"></TD>
									</TR>
								</form>
							</TABLE>
		</CFCASE>
		
<!--- Default Case to allow a user to search --->		
		<CFDEFAULTCASE>
			<FORM ACTION="schedule_search.cfm?action=search" METHOD="post" NAME="form">
<!--- Table containing input fields --->
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
			</FORM>
		</CFDEFAULTCASE>
	</CFSWITCH>

<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
