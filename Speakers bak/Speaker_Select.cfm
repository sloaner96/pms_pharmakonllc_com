<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<!----------------------------------------------------------------------------
	Speaker_Select.cfm
	Initial page of speaker database forms. Search speakers by name, specialty, city, state.
	
	lb060201-  Initial code.
------------------------------------------------------------------------------
--->

<html>
<head>
<LINK REL="stylesheet" HREF="speakerstyle.css" TYPE="text/css">
<script LANGUAGE=JAVASCRIPT>
<!--

function reset_form(){
   document.spkr_select.status.value = "0"
   document.spkr_select.client.value = "0"
   document.spkr_select.speaker_name.value = "0"
   document.spkr_select.specialty.value = "0"
   document.spkr_select.city.value = "0"
   document.spkr_select.state.value = "0"
}
//-->
</script>	


<title>Speaker Selection</title>
</head>
<BODY background="images/blue_stripe.jpg">
<!--- Pulls speaker name from Speaker to populate drop down box --->
<cfquery name="qspeaker_name" DATASOURCE="#application.speakerDSN#">
	SELECT DISTINCT lastname FROM Speaker
	WHERE active = 'yes' and type = 'SPKR'
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
	SELECT DISTINCT city
	FROM SpeakerAddress
	WHERE type = 'SPKR' AND city != ''
	ORDER BY city
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
	
<!--- pulls client info from PROJMAN! --->
<cfquery name="qclient" datasource="#application.projdsn#">
	SELECT client_code
	FROM client_code
	ORDER BY client_code
	</cfquery>		
	
<!--- Sends search criteria to spkr_summary.cfm --->
<form action="spkr_Summary.cfm" method="post" name="spkr_select" id="spkr_select">

<!--- Table with fields to select search criteria.  --->
<table border="0" cellspacing="0" cellpadding="0">
<tr>
	<td width="25">&nbsp;</td>
	<td><b><font size="3"><i><font color="Maroon">You may select any of the following criteria to search by:</font></i></font></b></td>
</tr>
<tr>
<tr>
	<td colspan="2">&nbsp;</td>
</tr>
<tr>
		<td>&nbsp;</td>
		<TD class="searchlabel">Speaker Status</TD>
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
		<TD class="searchlabel">Client</TD>
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
		<TD class="searchlabel">Speaker Name</TD>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>
			<select name="speaker_name">
			<OPTION value="0">All
			<CFOUTPUT query="qspeaker_name">
			<OPTION value="#qspeaker_name.lastname#">#qspeaker_name.lastname#
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
		<TD class="searchlabel">Specialty</TD>
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
		<td class="searchlabel">City</td>
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
	<tr valign=top> 
     	<td colspan="2"> 
         <div align="center"> 
         <p>&nbsp;</p>
         </div>
     	</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td class="searchlabel">State</td>
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
     	<td colspan="2"> 
        <div align="center"> 
        <p>&nbsp;</p>
        </div>
     	</td>
	</tr>
	<tr valign=top>
	<td>&nbsp;</td> 
    	<td colspan=""> 
        <p>&nbsp;</p>
		</td>
	</tr>	   
</table>
<table border="0">
		<tr>
			<td width="70" align="center" valign="bottom">
			<INPUT TYPE="submit"  NAME="edit" VALUE="Search">
			</td></form>
			<td width="70" align="center" valign="bottom">
				<INPUT TYPE="reset"  NAME="reset" VALUE="Reset" onclick="reset_form()">
        	</td>
		</tr>
</table>
    	

</body>
</html>
		
	
	