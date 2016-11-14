
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Search for Speaker" showCalendar="0">
<!--- Pulls speaker name from spkr_table to populate drop down box --->
<cfquery name="qspeaker_name" DATASOURCE="#application.speakerDSN#">
	SELECT DISTINCT lastname FROM spkr_table
	WHERE display = '1' and type = 'SPKR'
	ORDER BY lastname
	</cfquery>
	
<!--- Pulls specialty from codes to populate drop down box --->
<cfquery name="qspecialty" DATASOURCE="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'SPEC'
	ORDER BY description
	</cfquery>

<!--- Pulls city from address to populate drop down box --->
<cfquery name="qcity" DATASOURCE="#application.speakerDSN#">
	SELECT DISTINCT mailtocity
	FROM address
	WHERE owner_type = 'SPKR' AND mailtocity != ''
	ORDER BY mailtocity
	</cfquery>
	 	
<!--- Pulls state from codes to populate drop down box --->
<cfquery name="qstate" DATASOURCE="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'STATE'
	ORDER BY description
	</cfquery>
	
<!--- pulls status info --->
<cfquery name="qstatus" DATASOURCE="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'SSTAT'
	ORDER BY description
	</cfquery>	
	
<!--- pulls client info from PMSProd! --->
<cfquery name="qclient" DATASOURCE="#application.projdsn#">
	SELECT client_code
	FROM client_code
	ORDER BY client_code
	</cfquery>		
	
	<br>
<form action="act_spkrSummary.cfm" method="post" name="spkr_select" id="spkr_select">
		<!--- Sends search criteria to spkr_summary.cfm --->
			
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
							<TD><strong>Speaker Status</strong></TD>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>
								<select name="status">
								<OPTION value="0">All
								<CFOUTPUT query="qstatus">
								<OPTION value="#qstatus.code#">#qstatus.description#
								</cfoutput>
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
								<OPTION value="#qclient.client_code#">#qclient.client_code#
								</cfoutput>
								</SELECT>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<TD><strong>Speaker Name</strong></TD>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>
								<select name="speaker_name">
								<OPTION value="0">All
								<CFOUTPUT query="qspeaker_name">
								<OPTION value="#qspeaker_name.lastname#">#lcase(Trim(qspeaker_name.lastname))#
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
								<OPTION value="#qcity.mailtocity#">#qcity.mailtocity#
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
