<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<!----------------------------------------------------------------------------
	venu_Edit.cfm
	Form fields to edit some venue information including: type, name, tax_id
	
	lb060201-  Initial code.
------------------------------------------------------------------------------
--->

<head>
	<title>Edit Venue Details</title>
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
<BODY bgcolor="##FBF9EB" onLoad="MM_preloadImages('images/Backbtn_f2.gif');MM_preloadImages('savebtn_f2.gif');">
</cfoutput>


<!--- Pulls state from codes to populate drop down box --->
<cfquery name="qstate" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'STATE'
	ORDER BY description
	</cfquery>	

	
<!--- Pulls status from codes to populate drop down box --->	
<cfquery name="qactive" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'SSTAT'
	ORDER BY description
	</cfquery>				
	
<!--- Pulls venue types from codes to populate drop down box --->
<cfquery name="qtype" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'VENU'
	ORDER BY description
	</cfquery>


<cfform action="venu_edit_action.cfm?venue_id=#venue_id#&no_menu='1'" method="post" name="venue_edit" id="venue_edit">

<table width="80%" border="0" cellspacing="2" cellpadding="2">
<cfoutput>
<tr BGCOLOR="eeeecc">
	<td><b>Venue ID:</b></td>
	<TD>#venue_id#</td>
</tr>
</cfoutput>
<tr BGCOLOR="eeeecc">
	<td><b>Status</b></td>
	<td><select name="active">
			<CFOUTPUT query="qactive">
			<OPTION value="#code#"<cfif #trim(code)# is #trim(url.active)#> Selected </cfif>>#qactive.description#
			</cfoutput>
			</select></td>
</tr>

<tr BGCOLOR="eeeecc">
	<td><b>Venue Name:</b></td>
	<td><cfinput type="Text" name="venue_name" value="#url.venue_name#" message="Venue name is required" required="Yes" size="50"></td></tr>
<tr BGCOLOR="eeeecc">
	<td><b>Venue Type:</b></td>
	<td><select name="venue_type">
			<CFOUTPUT query="qtype">
			<OPTION value="#code#"<cfif #trim(code)# is #trim(url.venue_type)#> Selected </cfif>>#qtype.description#
			</cfoutput>
			</select></td>
</tr>
<tr BGCOLOR="eeeecc">
	<td><b>Tax ID:</b></td>
		<td><cfinput type="Text" name="tax_id" value="#url.tax_id#" required="no" size="20"></td>
</tr>
</table>

<br> 
<table border="0">
<tr>
<td width="83" align="center" valign="top">
<input type="image" name="Edit" value="Save" src="images/savebtn.gif" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('savebtn','','images/savebtn_f2.gif',1);"><br>
<b><font color="Maroon">save</font></b></td>

<td width="83" align="center" valign="top"><a href="venu_details.cfm?venue_id=#venue_id#" onMouseOut="MM_swapImgRestore();"  onMouseOver="MM_swapImage('Backbtn','','images/Backbtn_f2.gif',1);" onclick="self.close()"><img name="Backbtn" src="images/Backbtn.gif" width="24" height="23" border="0"><br><b>back</b><!-- fwtable fwsrc="bluebtn.png" fwbase="Backbtn.gif" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
</a></td>
<i><b><td width="83" align="center" valign="top">
	<a href="##" onclick="javascript:window.print()" onMouseOut="MM_swapImgRestore();"  onMouseOver="MM_swapImage('printbtn','','images/printbtn_f2.gif',1);" ><img name="printbtn" src="images/printbtn.gif" width="26" height="23" border="0"><br><b><font color="Maroon">print</font></b></a></td>
</tr>
</table>
</cfform>





</body>
</html>
