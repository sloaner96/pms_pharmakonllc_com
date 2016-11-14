<cfsilent>
<!--- Pulls moderator name from spkr_table to populate drop down box --->
<cfquery name="qmoderator_name" datasource="#application.speakerDSN#">
	SELECT DISTINCT lastname
	FROM spkr_table
	WHERE display = '1' and type = 'MOD'
	ORDER BY lastname
	</cfquery>
	
<!--- Pulls specialty from codes to populate drop down box --->
<cfquery name="qspecialty" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'SPEC'
	ORDER BY description
	</cfquery>

<!--- Pulls city from address to populate drop down box --->
<cfquery name="qcity" datasource="#application.speakerDSN#">
	SELECT DISTINCT mailtocity
	FROM address
	WHERE owner_type = 'MOD' AND mailtocity != ''
	ORDER BY mailtocity
	</cfquery>
	 	
<!--- Pulls state from codes to populate drop down box --->
<cfquery name="qstate" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'STATE'
	ORDER BY description
	</cfquery>
	
<!--- pulls status info --->
<cfquery name="qstatus" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'SSTAT'
	ORDER BY description
	</cfquery>	
	
<!--- pulls client info --->
<cfquery name="qclient" datasource="#application.projdsn#">
	SELECT client_code
	FROM client_code
	ORDER BY client_code
</cfquery>		

</cfsilent>

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Search for a Moderator" showCalendar="0">
<script LANGUAGE=JAVASCRIPT>
			<!--
			
			function reset_form(){
			   document.mod_select.status.value = "0"
			   document.mod_select.client.value = "0"
			   document.mod_select.moderator_name.value = "0"
			   document.mod_select.specialty.value = "0"
			   document.mod_select.city.value = "0"
			   document.mod_select.state.value = "0"
			}
			//-->
		 </script>	
<br>

	     
          <p align="center"><font face="verdana" size="-2">You may select any of the following criteria to search by:</font></p>
			<!--- Sends search criteria to mod_summary.cfm --->
			<form action="/moderators/mod_Summary.cfm" method="post" name="mod_select" id="mod_select">
			
			<!--- Table with fields to select search criteria.  --->
			<table width="30%" border="0" cellspacing="0" cellpadding="0" align="center">
			<tr>
					<td>&nbsp;</td>
					<TD><B>Moderator Status</B></TD>
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
				<tr valign=top> 
			    	<td colspan="2"> 
			        	<div align="center"> 
			        	<p>&nbsp;</p>
			        	</div>
			    	</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<TD><B>Client</B></TD>
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
				<tr valign=top> 
			    	<td colspan="2"> 
			        	<div align="center"> 
			        	<p>&nbsp;</p>
			        	</div>
			    	</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<TD><B>Moderator Name</B></TD>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<select name="moderator_name">
						<OPTION value="0">All
						<CFOUTPUT query="qmoderator_name">
						<OPTION 			value="#qmoderator_name.lastname#">#qmoderator_name.lastname#
						</cfoutput>
						</SELECT>
					</td>
				</tr>
				<tr valign=top> 
			    	<td colspan="2"> 
			        	<div align="center"> 
			        	<p>&nbsp;</p>
			        	</div>
			    	</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<TD><B>Specialty</B></TD>
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
				<tr valign=top> 
			    	<td colspan="2"> 
			        	<div align="center"> 
			        	<p>&nbsp;</p>
			        	</div>
			    	</td>
				</tr> 
				<tr>
					<td>&nbsp;</td>
					<td><b>City</b></td>
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
				<tr valign=top> 
			     	<td colspan="2"> 
			         <div align="center"> 
			         <p>&nbsp;</p>
			         </div>
			     	</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><b>State</b></td>
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
			    	<td colspan=""> 
			        <p>&nbsp;</p>
					</td>
				</tr>
				</table>
				<table border="0" align="center">
						<tr>
							<td width="70" align="center" valign="bottom">
							<INPUT TYPE="submit"  NAME="edit" VALUE="Search">
							</td></form>
							<td width="70" align="center" valign="bottom">
								<INPUT TYPE="reset"  NAME="reset" VALUE="Reset" onclick="reset_form()">
				        	</td>
						</tr>
				</table>
			<br><br>
			</form>             
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">