
<!----------------------------------------------------------------------------
	spkr_Edit.cfm
	Form fields to edit some speaker information including: status, region, specialty, first name, middle initial, last name, degree, affiliations/credentials, sex, ss
	
	lb060201-  Initial code.
	rws100305- Revamped for new look
------------------------------------------------------------------------------
--->
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Speaker Details" showCalendar="0">
<cfset comment_id="">
<script language="JavaScript">

function CheckFields(oForm)
{
	if(oForm.firstname != '')
	{
		if(oForm.lastname != '')
		{
			return true;
		}
		else
		{
			alert("Last Name is Required.")
			return false;
		}
	}
	else
	{
		alert("First Name is Required.")
		return false;
	}
}

</script>

<cfquery name="qdetails" DATASOURCE="#application.speakerDSN#" >
	SELECT  
	s.speakerid, 
	s.lastname, 
	s.firstname, 
	s.middlename, 	 
	s.updatedby, 
	s.updated, 
	s.degree, 
	s.sex, 
	s.cv, 
	s.w9, 
	s.travel, 
	s.specialty, 
	s.active, 	 
	s.consultagree, 
	s.affil,
	s.type,
	s.taxid,
	s.active
	FROM   	Speaker s 
	WHERE  	
	s.speakerid =  #speakerid# AND 
	s.active = 'yes' AND type = 'SPKR' 
</cfquery>	
<!--- Pulls state from codes to populate drop down box --->
<cfquery name="qstate" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'STATE'
	ORDER BY description
	</cfquery>	
	
<!--- Pulls sex from codes to populate drop down box --->	
<cfquery name="qsex" datasource="#application.speakerDSN#">
	SELECT code
	FROM codes
	WHERE code_type = 'SEX'
	ORDER BY code
	</cfquery>	
	
<!--- Pulls travel from codes to populate drop down box --->	
<cfquery name="qtravel" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'TRAVL'
	ORDER BY description
	</cfquery>	
	
<!--- Pulls specialty from codes to populate drop down box --->	
<cfquery name="qspecialty" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'SPEC'
	ORDER BY description
	</cfquery>		
	
<!--- Pulls status from codes to populate drop down box --->	
<!--- <cfquery name="qactive" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'SSTAT'
	ORDER BY description
</cfquery>	 --->			



<cfoutput>
<form action="spkr_edit_action.cfm?speakerid=#speakerid#&no_menu='1'" method="post" onsubmit="return CheckFields(this)">

<table width="80%" border="0" cellspacing="2" cellpadding="2">

<tr BGCOLOR="##eeeeee">
	<td><b>Speaker ID:</b></td>
	<TD>#speakerid#</td>
</tr>
</cfoutput>
<tr BGCOLOR="#eeeeee">
	<td><b>Status</b></td>
	<td>
	<select name="active">
		<!--- <CFOUTPUT query="qdetails"> --->
			<OPTION value="yes" Selected >Active</option>
			<OPTION value="no">Inactive</option>
		<!--- </cfoutput> --->
	</select>
	</td>
</tr>
<tr BGCOLOR="#eeeeee">
	<td><b>Region</b></td>
	<td>
	<select name="travel">
	<OPTION value="">(Select)
		<CFOUTPUT query="qtravel">
			<OPTION value="#qtravel.code#"<cfif #trim(qtravel.code)# is #trim(qdetails.travel)#> Selected </cfif>>#qtravel.description#
		</cfoutput>
	</select>
	</td>
</tr>
<tr BGCOLOR="#eeeeee">
	<td><b>Specialty</b></td>
	<td>
	<select name="specialty">
	<OPTION value="">(Select)
		<CFOUTPUT query="qspecialty">
			<OPTION value="#qspecialty.code#"<cfif #trim(qspecialty.code)# is #trim(qdetails.specialty)#> Selected </cfif>>#qspecialty.description#
		</cfoutput>
	</select>
	</td>
</tr>
<cfoutput>
<tr BGCOLOR="##eeeeee">
	<td><b>Speaker First Name:</b></td>
	<td><input type="Text" name="firstname" value="#qdetails.firstname#" size="30"></td>
</tr>
<tr BGCOLOR="##eeeeee">
	<td><b>Middle Initial:</b></td>		
	<td><input type="Text" name="middlename" value="#qdetails.middlename#" required="No" size="5"></td>
</tr>
<tr BGCOLOR="##eeeeee">
	<td><b>Last Name:</b></td>
	<td><input type="Text" name="lastname" value="#qdetails.lastname#" size="30"></td>
</tr>
<tr BGCOLOR="##eeeeee">
	<td><b>Degree</b></td>
	<TD><input type="Text" name="degree" value="#qdetails.degree#"size="15"></td>
</tr>
</cfoutput>
<tr BGCOLOR="#eeeeee">
	<td><b>Sex:</b></td>
	<td>
	<select name="sex">
		<OPTION value="">(Select)		
		<CFOUTPUT query="qsex">
			<OPTION value="#qsex.code#"<cfif #trim(qsex.code)# is #trim(qdetails.sex)#> Selected </cfif>>#qsex.code#
		</cfoutput>
	</select>
	</td>
</tr>
<tr BGCOLOR="#eeeeee">
	<td><b>SS/Tax ID:</b></td>
		<td><input type="Text" name="ss" value="<cfoutput>#qdetails.taxid#</cfoutput>" size="20"></td>
</tr>
<tr BGCOLOR="#eeeeee">
	<td><b>Affiliations:</b></td>
	<td><textarea cols="25" rows="2" name="affil"><cfoutput>#qdetails.affil#</cfoutput></textarea></td>
</tr>
<tr>
  <td>&nbsp;</td>
</tr>
<tr>
  <td align="center"><table border="0" width="100%">
<tr>
<td align="center" valign="top">		
<INPUT TYPE="submit"  NAME="save" VALUE="Save">
</form>
		</td>
<!--- back to search button --->
		<td width="83" align="center" valign="top">
			<form action="">
<INPUT TYPE="submit"  NAME="close" VALUE="Close" onclick="self.close()">
</form>
		</td>
<td width="83" align="center" valign="top">
		<SCRIPT LANGUAGE="JavaScript">
		  <!-- Begin print button
		  if (window.print) {
		  document.write('<form>'
		  + '<input type=button  name=print value="  Print  " '
		  + 'onClick="javascript:window.print()"></form>');
		  }
		  // End print button-->
		  </script>	
		</td>
</tr>
</table></td>
</tr>
</table>

<br> 
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">

