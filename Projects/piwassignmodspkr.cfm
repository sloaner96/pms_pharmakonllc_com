<!---
**************************************************************************
	piwassignmodspkr.cfm
	
	assigns speakers or moderators to projects.
	
	bj010102 - Initial code.
	
**************************************************************************
--->
<HTML>
<HEAD>
<TITLE>Project Initiation Worksheet - Assign Moderators/Speakers</TITLE>
<LINK REL=stylesheet HREF="piw1style.css" TYPE="text/css">
</HEAD>
<BODY>
<CFSWITCH EXPRESSION="#URL.action#">
	<!--- action = INSERT --->
	<CFCASE VALUE="insert">
		<CFIF #form.assign_choice# EQ "MOD">
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
				DELETE FROM piw_moderators	WHERE project_code = '#session.project_code#';
			</CFQUERY>
		<CFELSE>
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="UPDATERECORD">
				DELETE FROM piw_speakers WHERE project_code = '#session.project_code#';
			</CFQUERY>
		</CFIF>

		<cfif IsDefined("form.assign_name")>
			<cfloop index="modspkr_id" list="#form.assign_name#">
			<CFOUTPUT>
			<CFIF #form.assign_choice# EQ "MOD">
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="updaterecord">
					insert INTO piw_moderators(project_code, moderator_id, updated, userid) 
							Values('#session.project_code#','#modspkr_id#', #createodbcdatetime(Now())#, '#session.userinfo.rowid#')
				</cfquery>
			<CFELSE>
				<CFQUERY DATASOURCE="#application.projdsn#" NAME="updaterecord">
					insert INTO piw_speakers(project_code, speaker_id, updated, userid) 
						Values('#session.project_code#','#modspkr_id#', #createodbcdatetime(Now())#, '#session.userinfo.rowid#')
				</cfquery>
			</CFIF>	
			</CFOUTPUT>
			</cfloop>
		</cfif>
		<CFOUTPUT><META HTTP-EQUIV="refresh" CONTENT="0; Url=piwassignmodspkr.cfm?action=endreport&assign_choice=#form.assign_choice#"></CFOUTPUT>
	</CFCASE>
	<!--- end of action = INSERT --->			

			

	<!--- action = ENDREPORT --->		
	<CFCASE VALUE="endreport">
		<CFIF #url.assign_choice# EQ "MOD">
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="get_id">
				SELECT moderator_id	FROM piw_moderators	WHERE project_code = '#session.project_code#';
			</CFQUERY>
		<CFELSE>
			<CFQUERY DATASOURCE="#application.projdsn#" NAME="get_id">
				SELECT speaker_id FROM piw_speakers WHERE project_code = '#session.project_code#';
			</CFQUERY>
		</CFIF>
		<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="400">
		<TR>
			<TD CLASS="tdheader">Assigned <CFIF #url.assign_choice# EQ "MOD">Moderators<CFELSE>Speakers</CFIF></TD>
		</TR>
		<TR>
			<TD>
			<!--- Table containing input fields --->
			<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="15" WIDTH="85%">
			<TR>
		   		<TD ALIGN="center" COLSPAN="2">
					Your <CFIF #url.assign_choice# EQ "MOD">Moderator<CFELSE>Speaker</CFIF> assignment was succesful.
					<BR>You have assigned these <CFIF #url.assign_choice# EQ "MOD">Moderators<CFELSE>Speakers</CFIF> to the <BR>Project Code: <CFOUTPUT><B>#session.project_code#</B></CFOUTPUT>
				</TD>
			</TR>
			<TR>
				<TD ALIGN="center" COLSPAN="2"><CFIF #url.assign_choice# EQ "MOD"><U>Moderator</U><CFELSE><U>Speaker</U></CFIF><U> NAME</U></TD>
			</TR>
			<CFOUTPUT>
			<CFLOOP QUERY="get_id">
			<TR>
				<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="get_name">
					SELECT firstname, lastname
					FROM spkr_table
					WHERE speaker_id = <CFIF #url.assign_choice# EQ "MOD">#get_id.moderator_id#<CFELSE>#get_id.speaker_id#</CFIF>
				</CFQUERY>
				<CFLOOP QUERY="get_name">
					<TD ALIGN="center" COLSPAN="2">#get_name.firstname# #get_name.lastname#</TD></TR>
				</CFLOOP>
				</CFLOOP>	
				</CFOUTPUT>
			<TR>
			<td><b><SCRIPT LANGUAGE="JavaScript">
					  <!-- Begin print button
					  if (window.print) {document.write('<BR>' + '<form>'
					  + '<input type=button  name=print value="  Print  " '
					  + 'onClick="javascript:window.print()"></form>');
					  }
					  // End print button-->
				  </script></b>
			</td>
			<TD><BR><FORM ACTION="index.cfm" METHOD="post"><INPUT TYPE="submit" NAME="FINISH" VALUE="    FINISH    "></FORM></TD>
			</TR>
			</TABLE>
		</TD>
		</TR>
		</TABLE>	
	</CFCASE>
	<!--- end of action = ENDREPORT --->

	<!--- action = SELECT --->
	<CFCASE VALUE="select">
		<FORM ACTION="piwassignmodspkr.cfm?action=insert" METHOD="post">
		<!--- <CFSET session.project_code = form.project_code> --->
		<CFOUTPUT><input TYPE="Hidden" Name="assign_choice" VALUE="#form.assign_choice#"></CFOUTPUT>
		<CFQUERY DATASOURCE="#application.speakerDSN#" NAME="name">
			SELECT * FROM spkr_table WHERE type='#form.assign_choice#';
		</CFQUERY>
		<CFSET i=0>
		<CFOUTPUT><CFSET type=#name.type#></CFOUTPUT>
		<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="600">
		<TR>
			<TD CLASS="tdheader">Assign <CFIF #type# EQ "MOD">Moderators<CFELSE>Speakers</CFIF></TD>
		</TR>
		<TR>
			<TD>
			<!--- Table containing input fields --->
			<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="5">
			<TR>
			<CFOUTPUT>
			<CFLOOP QUERY="name">
				<CFIF I MOD 4 EQ 0>
					</TR><TR>
				</CFIF>
				<TD><INPUT TYPE="checkbox" NAME="assign_name" VALUE=#name.speaker_id#>
				<!--- #name.speaker_id#  --->#name.firstname# #name.lastname#</TD>
				<CFSET i=i+1>
			</CFLOOP>
			</CFOUTPUT>
			</TR>
			<TR><TD COLSPAN=4 ALIGN="center"><BR><INPUT TYPE="submit" VALUE="    NEXT    "></TD></TR>
			</TABLE>
		</TD>
	</TR>
	</TABLE>
	</FORM>
	</CFCASE>
	<!--- END OF ACTION = select --->		
	
	<!--- DEFAULT ACTION --->		
	<CFDEFAULTCASE>
		<!--- Query to grab all Pending Project Codes and Populate a dropdown for the User --->
		<!--- <CFQUERY DATASOURCE="#application.projdsn#" NAME="get_projectcode">
			SELECT project_code
			FROM piw
			WHERE project_status = 0	
			ORDER BY project_code
		</CFQUERY> --->
		<FORM ACTION="piwassignmodspkr.cfm?action=select" METHOD="post">
		<TABLE BGCOLOR="##000080" ALIGN="center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="400">
		<TR>
			<TD CLASS="tdheader">Project Initiation Form - PIW Assign Moderators or Speakers</TD>
		</TR>
		<TR>
			<TD>
				<!--- Table containing input fields --->
				<TABLE ALIGN="center" BORDER="0" CELLPADDING="0" CELLSPACING="15" WIDTH="85%">
				<!--- <TR>
			   		<TD ALIGN="center">Select a project code to manipulate:&nbsp;&nbsp;&nbsp;
						<SELECT NAME="project_code" SIZE="1">
							<CFOUTPUT QUERY="get_projectcode">
								<OPTION <CFIF (isDefined("session.project_code")) AND (session.project_code EQ trim(Project_code))>SELECTED</CFIF>>#trim(Project_code)#</OPTION>
							</CFOUTPUT>
						</SELECT>
						<CFOUTPUT>#session.project_code#</CFOUTPUT>
					</TD>
					
				</TR> --->
				<TR ALIGN="center"> 
					<TD ALIGN="center">Assign Mod/Spkr For Project Code : <B><CFOUTPUT>#session.project_code#</CFOUTPUT></B></td>
				</TR>
				<TR><TD><INPUT NAME="assign_choice" TYPE="radio" VALUE="mod">Assign/Edit Moderators
						<BR>
						<INPUT NAME="assign_choice" TYPE="radio" VALUE="spkr">Assign/Edit Speakers 		
				</TD></TR>
				<TR>
			   		<TD COLSPAN="2" ALIGN="center"><BR><INPUT TYPE="hidden" NAME="clear" VALUE=1><INPUT TYPE="submit" NAME="START"  VALUE="    Start    "></TD>
				</TR>
				</TABLE>
			</TD>
		</TR>
		</TABLE>	
		</FORM>
		</CFDEFAULTCASE>
	</CFSWITCH>
	</BODY>
</HTML>