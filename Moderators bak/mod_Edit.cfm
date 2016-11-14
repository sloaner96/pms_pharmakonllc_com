<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<!----------------------------------------------------------------------------
	mod_Edit.cfm
	Form fields to edit some moderator information including: status, region, specialty, first name, middle initial, last name, degree, affiliations/credentials, sex, ss
	
	lb060201-  Initial code.
------------------------------------------------------------------------------
--->

<head>
	<title>Edit Moderator Details</title>
	<style>
	BODY, TD {font-family : Verdana, Arial, sans-serif ;font-size : 8pt;}
	TH {
		font-family : Verdana, Arial, sans-serif ;
		font-size : 8pt;
		color: navy;
		text-align : right;
		font-weight : bold;
	}
	A {	text-decoration: none; color: blue;}
	A:Hover {text-decoration: underline;color: red;}
</style>
<cfset comment_id="">

<script LANGUAGE=JAVASCRIPT>
<!--
//Fireworks buttons
function MM_findObj(n, d) { //v3.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); return x;
}
function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
 var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
   var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
   if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

//-->

</script>	

</head>


<cfoutput>
<BODY onLoad="MM_preloadImages('/images/Backbtn_f2.gif');MM_preloadImages('/images/savebtn_f2.gif');">
</cfoutput>
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Speaker Details" showCalendar="0">

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
<cfquery name="qactive" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'SSTAT'
	ORDER BY description
</cfquery>				
	
<cfquery name="speaker" datasource="#application.speakerDSN#">
	SELECT *
	FROM Speaker
	WHERE speakerid = '#url.speakerid#'
	</cfquery>	


<cfform action="mod_edit_action.cfm?speakerid=#speakerid#&no_menu='1'" method="post" name="moderator_edit" id="moderator_edit">

<table width="80%" border="0" cellspacing="2" cellpadding="2">
<cfoutput>
<tr BGCOLOR="##eeeeee">
	<td><b>Moderator ID:</b></td>
	<TD>#speakerid#</td>
</tr>
</cfoutput>
<tr BGCOLOR="#eeeeee">
	<td><b>Status</b></td>
	<td>
	<select name="active">
		<!--- <CFOUTPUT query="qactive"> --->
			<OPTION value="yes" Selected >Active</option>
			<OPTION value="no">Inactive</option>
		<!--- </cfoutput> --->
	</select>
	</td>
</tr>
<tr BGCOLOR="#eeeeee">
	<td><b>Region</b></td>
	<td><select name="travel">
	<OPTION value="">(Select)
			<CFOUTPUT query="qtravel">
			<OPTION value="#qtravel.code#"<!--- <cfif #trim(qtravel.code)# is #trim(url.travel)#> Selected </cfif> --->>#qtravel.description#
			</cfoutput>
			</select></td>
</tr>
<tr BGCOLOR="#eeeeee">
	<td><b>Specialty</b></td>
		<td><select name="specialty">
		<OPTION value="">(Select)
			<CFOUTPUT query="qspecialty">
			<OPTION value="#qspecialty.code#"<!--- <cfif #trim(qspecialty.code)# is #trim(url.specialty)#> Selected </cfif> --->>#qspecialty.description#
			</cfoutput>
			</select></td>
</tr>
<cfoutput>
<tr BGCOLOR="##eeeeee">
	<td><b>Moderator First Name:</b></td>
	<td><cfinput type="Text" name="firstname" value="#speaker.firstname#" message="First name is required" required="Yes" size="30"></td></tr>
<tr BGCOLOR="##eeeeee">
	<td><b>Middle Initial:</b></td>		
		<td><input type="Text" name="middlename" value="#speaker.middlename#" required="No" size="5"></td></tr>
<tr BGCOLOR="##eeeeee">
	<td><b>Last Name:</b></td>
	<td><cfinput type="Text" name="lastname" value="#speaker.lastname#" message="Last name is required" required="Yes" size="30"></td>
</tr>
<tr BGCOLOR="##eeeeee">
	<td><b>Degree</b></td>
	<TD>
	<input type="Text" name="degree" value="#speaker.degree#"size="15"></td>
</tr>
</cfoutput>
<tr BGCOLOR="#eeeeee">
	<td><b>Sex:</b></td>
		<td><select name="sex">
			<OPTION value="">(Select)		
			<CFOUTPUT query="qsex">
			<OPTION value="#qsex.code#"<cfif trim(qsex.code) EQ trim(speaker.sex)> Selected </cfif>>#qsex.code#
			</cfoutput>
			</select></td>
</tr>
<tr BGCOLOR="#eeeeee">
	<td><b>SS/Tax ID:</b></td>
		<td><cfinput type="Text" name="ss" value="#speaker.taxid#" required="no" size="20"></td>
</tr>
<tr BGCOLOR="#eeeeee">
	<td><b>Affiliations:</b></td>
	<td><textarea cols="25" rows="2" name="affil"><cfoutput>#speaker.affil#</cfoutput></textarea></td>
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

