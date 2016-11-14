
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Search for Speaker" showCalendar="0">
<!--- Pulls speaker name from Speaker to populate drop down box --->
<cfquery name="qspeaker_name" DATASOURCE="#application.speakerDSN#">
	SELECT DISTINCT lastname, firstname FROM Speaker
	WHERE active = 'yes' and type = 'MOD'
	ORDER BY lastname
	</cfquery>
	
<!--- Pulls specialty from codes to populate drop down box --->
<cfquery name="qspecialty" DATASOURCE="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'SPEC'
	ORDER BY description
	</cfquery>

<!--- Pulls city FROM SpeakerAddress to populate drop down box --->
<cfquery name="qcity" DATASOURCE="#application.speakerDSN#">
	SELECT DISTINCT sa.city, s.type
	FROM SpeakerAddress sa,
	Speaker s
	WHERE s.speakerid = sa.speakerid and
	s.type = 'MOD' AND sa.city != ''
	ORDER BY sa.city
	</cfquery>
	 	
<!--- Pulls state from codes to populate drop down box --->
<cfquery name="qstate" DATASOURCE="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'STATE'
	ORDER BY description
	</cfquery>
	
<!--- pulls status info --->
<!--- <cfquery name="qstatus" DATASOURCE="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'SSTAT'
	ORDER BY description
	</cfquery> --->	
	
<!--- pulls client info from PROJMAN! --->
<cfquery name="qclient" DATASOURCE="#application.projdsn#">
	SELECT Distinct 
	project_code 
	FROM piw
	ORDER BY project_code
	</cfquery>		
	
	<br>
<form action="../Moderators/mod_Summary.cfm" method="post" name="MOD_select" id="MOD_select">
		<!--- Sends search criteria to MOD_summary.cfm --->
			
			<!--- Table with fields to select search criteria.  --->
				<table border="0" cellspacing="4" cellpadding="0" width="100%" align="center">
					<tr>
						<td width="25">&nbsp;</td>
						<td>You may select any of the following criteria to search by:</td>
					</tr>
					<tr>
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
					
					<tr>
							<td>&nbsp;</td>
							<TD><strong>Moderator Name</strong></TD>
						</tr>
						<!--- <tr>
							<td>&nbsp;</td>
							<td>
								Last Name:<input type="text" name="lastname" size="25" maxlength="50">&nbsp;&nbsp;First Name:<input type="text" name="firstname" size="25" maxlength="50">
							</td>
						</tr> --->
						<tr>
							<td>&nbsp;</td>
							<td>
								<select name="speaker_name">
								<OPTION value="0">All
								<CFOUTPUT query="qspeaker_name">
								<OPTION value="#qspeaker_name.lastname#">#qspeaker_name.firstname# #qspeaker_name.lastname#
								</cfoutput>
								</SELECT>
							</td>
						</tr>
					<tr>
							<td>&nbsp;</td>
							<TD><strong>Moderator Status</strong></TD>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>
								<select name="status">
								<OPTION value="yes">Active</option>
								<OPTION value="no">Inactive</option>								
								</SELECT>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<TD><strong>Client</strong></TD>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>
								<select name="client">
								<OPTION value="0">All
								<CFOUTPUT query="qclient">
								<OPTION value="#qclient.project_code#">#qclient.project_code#
								</cfoutput>
								</SELECT>
							</td>
						</tr>
											
						<tr>
							<td>&nbsp;</td>
							<TD><strong>Specialty</strong></TD>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>
								<select name="specialty">
								<OPTION value="0">All
								<CFOUTPUT query="qspecialty">
								<OPTION value="#qspecialty.code#">#qspecialty.description#
								</cfoutput>
								</SELECT>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><strong>City</strong></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>
								<select name="city">
								<OPTION value="0">All
								<CFOUTPUT query="qcity">
								<OPTION value="#qcity.city#">#qcity.city#
								</cfoutput>
								</SELECT>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><strong>State</strong></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>
								<select name="state">
								<OPTION value="0">All
								<CFOUTPUT query="qstate">
								<OPTION value="#code#">#description#
								</cfoutput>
								</SELECT>
							</td>
						</tr>
						<tr valign=top>
						<td>&nbsp;</td> 
						</tr>	
						<tr>
								<td colspan=2 align="center">
								<INPUT TYPE="submit"  NAME="edit" VALUE="Search">
								</td>
					   </tr>   
					</table>
			
		</td>
      </tr>
   </table> 
  </form>
 <cfmodule template="#Application.tagpath#/ctags/footer.cfm">
