<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	spkr_Edit_Address.cfm
	Form fields to edit address information including: mailto address, city, state, zip AND Business address, city, state, zip
	
	lb060201-  Initial code.
------------------------------------------------------------------------------
--->
<head>
	<title>Edit Speaker Address</title>

	
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
	
	<style>
	BODY, TD {font-family : Verdana, Arial, sans-serif ;font-size : 8pt;}
	TH {
		font-family : Verdana, Arial, sans-serif ;
		font-size : 9pt;
		color: navy;
		text-align : right;
		font-weight : bold;
	}
	A {	text-decoration: none; color: blue;}
	A:Hover {text-decoration: underline;color: red;}
</style>
</head>


<cfoutput>
<BODY bgcolor="##FBF9EB" onLoad="MM_preloadImages('images/Deletebtn_f2.gif');MM_preloadImages('images/Backbtn_f2.gif');MM_preloadImages('savebtn_f2.gif');">
</cfoutput>


	

<!--- Pulls state from codes to populate drop down box --->
<cfquery name="qstate" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'STATE'
	ORDER BY description
	</cfquery>	
	

<cfform action="spkr_Edit_Address_action.cfm?speakerid=#speakerid#&add_id=#add_id#&no_menu='1'" method="POST" enablecab="No">
<table width="100%" border="0" cellspacing="2" cellpadding="2">
<tr BGCOLOR="eeeecc">
	<td><b>Speaker ID:</b></td>
	<TD><cfoutput>#speakerid#</cfoutput></td>
</tr>
<tr BGCOLOR="eeeecc">
	<td><b><font color="Navy">Mail To Address:</font></b></td>
	<TD>
	<cfinput type="Text" name="add1" value="#url.add1#" message="Address is Required" required="No" size="50"></td>
</tr>
<tr BGCOLOR="eeeecc">
	<td></td>
	<TD>
	<cfinput type="Text" name="add2" value="#url.add2#"size="50"></td>
</tr>
<tr BGCOLOR="eeeecc">
	<td></td>
	<TD>
	<cfinput type="Text" name="add3" value="#url.add3#"size="50"></td>
</tr>
<tr BGCOLOR="eeeecc">
	<td align="right"><b>City:&nbsp;</b></td>
	<TD>
	<cfinput type="Text" name="city" value="#url.city#" message="City is Required" required="No" size="40"></td>
</tr>
<tr>
	<td align="right" bgcolor="#EEEECC"><b>State:&nbsp;</b></td>	
	<TD BGCOLOR="eeeecc">
	<cfselect name="state" message="State is Required" required="No">
			<OPTION value="">(Select)
			<CFOUTPUT query="qstate">
			<OPTION value="#qstate.code#"<cfif #trim(qstate.code)# is #trim(url.state)#> Selected </cfif>>#qstate.description#
			</cfoutput>
			</cfselect></td>
</tr>	
<tr><td align="right" bgcolor="#EEEECC"><b>Zip:&nbsp;</b></td>
	<TD BGCOLOR="eeeecc"><cfinput type="Text" name="zipcode" value="#url.zipcode#" required="No" size="10"></td>
</tr>
<tr BGCOLOR="eeeecc">
		<td align="right" bgcolor="#EEEECC"><b>Country:</b>&nbsp;</td>
		<td colspan="3">
			<cfinput type="Text" name="mailtocountry" value="#url.mailtocountry#" size="35">
		</td>
	</tr>
<tr>
	<td colspan="2">&nbsp;</td>
</tr>
<tr>
	<td colspan="2"><!--- <input type="Checkbox" name="same" value="1"  <cfif qsame.same EQ 1>checked="Yes"</cfif>>Check if Business Address is Same as Mail To ---></td>
</tr>
<tr BGCOLOR="eeeecc">
	<td><b><font color="Navy">Business Address:</font></b></td>
	<TD>
	<cfinput type="Text" name="busadd_1" value="#url.busadd_1#" message="Address is Required" required="No" size="50"></td>
</tr>
<tr BGCOLOR="eeeecc">
	<td></td>
	<TD>
	<cfinput type="Text" name="busadd_2" value="#url.busadd_2#"size="50"></td>
</tr>
<tr BGCOLOR="eeeecc">
	<td></td>
	<TD>
	<cfinput type="Text" name="busadd_3" value="#url.busadd_3#"size="50"></td>
</tr>
<tr BGCOLOR="eeeecc">
	<td align="right"><b>City:</b>&nbsp;</td>
	<TD>
	<cfinput type="Text" name="buscity" value="#url.buscity#" message="City is Required" required="No" size="40"></td>
</tr>
<tr>
	<td align="right" bgcolor="#EEEECC"><b>State:</b>&nbsp;</td>	
	<TD BGCOLOR="eeeecc">
	<cfselect name="busstate" message="State is Required" required="No">
			<OPTION value="">(Select)
			<CFOUTPUT query="qstate">
			<OPTION value="#qstate.code#"<cfif #trim(qstate.code)# is #trim(url.busstate)#> Selected </cfif>>#qstate.description#
			</cfoutput>
			</cfselect></td>
</tr>	
<tr><td align="right" bgcolor="#EEEECC"><b>Zip:</b>&nbsp;</td>
	<TD BGCOLOR="eeeecc"><cfinput type="Text" name="buszip" value="#url.buszip#" required="No" size="10"></td>
</tr>
<tr BGCOLOR="eeeecc">
		<td align="right" bgcolor="#EEEECC"><b>Country:</b>&nbsp;</td>
		<td colspan="3">
			<cfinput type="Text" name="buscountry" value="#url.buscountry#" size="35">
		</td>
	</tr>
	<tr BGCOLOR="eeeecc">
		<td align="right" bgcolor="#EEEECC"><b>Hours from Eastern Time:</b>&nbsp;</td>
		<td colspan="3">
			<cfinput type="Text" name="timezone" value="#url.timezone#" size="5">&nbsp;
			Use a negative number if timezone is behind Eastern Time. Example: Chicago is -1 hours from Eastern Time.
		</td>
	</tr>
</table>

<br> 
<table border="0">
<tr>
<td width="83" align="center" valign="top">
<input type="image" name="Edit" value="Save" src="images/savebtn.gif" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('savebtn','','images/savebtn_f2.gif',1);"><br>
<b><font color="Maroon">save</font></b></td>

<td width="83" align="center" valign="top"><a href="spkr_details.cfm?speakerid=#speakerid#" onMouseOut="MM_swapImgRestore();"  onMouseOver="MM_swapImage('Backbtn','','images/Backbtn_f2.gif',1);" onclick="self.close()"><img name="Backbtn" src="images/Backbtn.gif" width="24" height="23" border="0"><br><b>back</b><!-- fwtable fwsrc="bluebtn.png" fwbase="Backbtn.gif" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
</a></td>
<i><b><td width="83" align="center" valign="top">
	<a href="##" onclick="javascript:window.print()" onMouseOut="MM_swapImgRestore();"  onMouseOver="MM_swapImage('printbtn','','images/printbtn_f2.gif',1);" ><img name="printbtn" src="images/printbtn.gif" width="26" height="23" border="0"><br><b><font color="Maroon">print</font></b></a></td>
</tr>
</table>
</cfform>

</body>
</html>
