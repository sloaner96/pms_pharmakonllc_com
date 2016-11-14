<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<!----------------------------------------------------------------------------
	venu_AddVenue.cfm
	Form fields to add a new venue
	
	lb070201-  Initial code.
------------------------------------------------------------------------------
--->

<html>
<head>
	<title>Add New Venue</title>
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
<script language="JavaScript" src="date-picker.js"></script>
<script LANGUAGE=JAVASCRIPT>

<!--
	//limit comments to 245
	function  _checkLimitContent(_CF_this)
	{
		if (_CF_this.value.length > 245)
		{
			alert("Please limit your comments to 250 characters");
    		return false;
  		}
    	return true;
	}
	
	//fireworks buttons
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
<BODY bgcolor="##FBF9EB" onLoad="MM_preloadImages('images/Deletebtn_f2.gif');MM_preloadImages('images/Backbtn_f2.gif');MM_preloadImages('savebtn_f2.gif');">
</cfoutput>

<!--- pulls state descriptions for codes --->
<cfquery name="qstate" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'STATE'
	ORDER BY description
	</cfquery>
	
	
<!--- Pulls status codes --->	
<cfquery name="qactive" datasource="#application.speakerDSN#">
	SELECT DISTINCT description, code
	FROM  codes
	WHERE code_type = 'SSTAT'
	ORDER BY codes.description
	</cfquery>	
	
<!--- Pulls venue types from codes to populate drop down box --->
<cfquery name="qtype" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'VENU'
	ORDER BY description
	</cfquery>	

<cfform name="AddVenue" action="venu_AddvenueAction.cfm?no_menu='1'" method="POST">
<b><font size="4"><font color="Navy">Add New Venue</font></font></b><br><br>
<table width="80%" border="0" cellspacing="0" cellpadding="2">
	<tr>
		<th><b>Venue ID:</b></th>
		<td colspan="4"></td>
	</tr>
	<tr BGCOLOR="eeeecc">
		<th><b>Status:</b></th>
		<td colspan="4">
			<select name="active">
			<cfoutput query="qactive">
			<option value="#qactive.code#">#qactive.description#
			</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<th><b>Venue Name:</b></th>
		<td colspan="4">
			<cfinput type="Text" name="venue_name" message="Venue name is required" required="Yes" size="50">
		</td>
	</tr>
	<tr BGCOLOR="eeeecc">
		<th><b>Venue Type:</b></th>
		<td colspan="4">
			<select name="venue_type">
			<OPTION value="">(Select)
			<cfoutput query="qtype">
			<option value="#qtype.code#">#qtype.description#
			</cfoutput>
			</select>
		</td>
	</tr>
	<tr>
		<th><b>Tax Id:</b></th>
		<td colspan="4">
			<cfinput type="Text" name="tax_id" size="25">
		</td>
	</tr>
	<tr BGCOLOR="eeeecc">
		<th><b>Mail To Address:</b></th>
		<td colspan="3">
			<cfinput type="Text" name="mailtoadd_1" message="Address is required" required="No" size="35">
		</td>
	</tr>
	<tr BGCOLOR="eeeecc">
		<td></td>
		<td colspan="3">
			<cfinput type="Text" name="mailtoadd_2" size="35">
		</td>
	</tr>
	<tr BGCOLOR="eeeecc">
		<td></td>
		<td colspan="3">
			<cfinput type="Text" name="mailtoadd_3" size="35">
		</td>
	</tr>
	<tr BGCOLOR="eeeecc">
		<th><b>City/State/Zip:</b></th>
		<td colspan="3">
		<cfinput type="Text" name="mailtocity" message="City is required" required="No" size="35">&nbsp;&nbsp;
			<select name="mailtostate">
			<OPTION value="">(Select)
			<cfoutput query="qstate">
			<option value="#qstate.code#">#qstate.description#
			</cfoutput>
			</select>&nbsp;&nbsp;<cfinput type="Text" name="mailtozip" message="Zip is required" required="No" size="10">
		</td>
	</tr>
	<tr BGCOLOR="eeeecc">
		<th><b>Country:</b></th>
		<td colspan="3">
			<cfinput type="Text" name="mailtocountry" value="USA" required="No" size="35">
		</td>
	</tr>
	<tr BGCOLOR="eeeecc">
		<td colspan="4">&nbsp;</td>
	</tr>
	<tr BGCOLOR="eeeecc">
		<th><b>Business Address:</b></th>
		<td colspan="4"><cfinput type="Text" name="busadd_1" message="Address is required" required="No" size="35">
		</td>
	</tr>
	<tr BGCOLOR="eeeecc">
		<td></td>
		<td colspan="3">
			<cfinput type="Text" name="busadd_2" size="35">
		</td>
	</tr>
	<tr BGCOLOR="eeeecc">
		<td></td>
		<td colspan="3">
			<cfinput type="Text" name="busadd_3" size="35">
		</td>
	</tr>
	<tr BGCOLOR="eeeecc">
		<th><b>City/State/Zip:</b></th>
		<td colspan="4">
			<cfinput type="Text" name="buscity" message="City is required" required="No" size="35">&nbsp;&nbsp;<select name="busstate">
			<OPTION value="">(Select)
			<cfoutput query="qstate">
			<option value="#qstate.code#">#qstate.description#
			</cfoutput>
		</select>&nbsp;&nbsp;<cfinput type="Text" name="buszip" message="Zip is required" required="No" size="10">
		</td>
	</tr>
	<tr BGCOLOR="eeeecc">
		<th><b>Country:</b></th>
		<td colspan="3">
			<cfinput type="Text" name="buscountry" value="USA" required="No" size="35">
		</td>
	</tr>
	<tr>
		<th><b>Phone Numbers:</b></th>
		<td colspan="3"></td>
	</tr>
	<tr>
		<td></td>
		<td align="right"><b>Primary Phone: </b><cfinput type="Text" name="phone1" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td></td>
		<td align="right"><b>Primary Fax:</b> <input type="Text" name="fax1" size="25">
		</td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td></td>
		<td align="right"><b>Primary Cell:</b> <input type="Text" name="cell1" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td></td>
		<td align="right"><b>Primary Pager:</b> <input type="Text" name="pager1" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td></td>
		<td align="right"><b>Primary Service:</b> <input type="Text" name="service1" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td></td>
		<td align="right"><b>Primary E-Mail:</b> <input type="Text" name="email1" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td></td>
		<td align="right"><b>Secondary Phone:</b> <cfinput type="Text" name="phone2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td></td>
		<td align="right"><b>Secondary Fax:</b> <input type="Text" name="fax2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td></td>
		<td align="right"><b>Secondary Cell:</b> <input type="Text" name="cell2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td></td>
		<td align="right"><b>Secondary Pager:</b> <input type="Text" name="pager2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td></td>
		<td align="right"><b>Secondary Service:</b> <input type="Text" name="service2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr>
		<td></td>
		<td align="right"><b>Secondary E-Mail:</b> <input type="Text" name="email2" size="25"></td>
		<td colspan="2"></td>
	</tr>
	<tr BGCOLOR="eeeecc">
		<th><b>Contact Info:</b></th>
		<td colspan="4" valign="top"><textarea cols="60" rows="2" name="contact_info" onkeyup="return _checkLimitContent(this)"></textarea> 
		</td>
	</tr>
	<tr>
		<th><b>Comments:</b></th>
		<td colspan="4" valign="top"><textarea cols="60" rows="2" name="comment"onkeyup="return _checkLimitContent(this)"></textarea> 
		</td>
	</tr>

</table>
<br> 

<table border="0">
	<cfoutput>
	<tr>
		<td width="83" align="center" valign="top">
			<a href="##" onclick="javascript:window.print()" onMouseOut="MM_swapImgRestore();"  onMouseOver="MM_swapImage('printbtn','','images/printbtn_f2.gif',1);" ><img name="printbtn" src="images/printbtn.gif" width="26" height="23" border="0"><br><b><font color="Maroon">print</font></b></a>
		</td>
		<td width="83" align="center" valign="top">
			<input type="image" name="Edit" value="Save" src="images/savebtn.gif" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('savebtn','','images/savebtn_f2.gif',1);"><br>
<b><font color="Maroon">save</font></b>
		</td>
		<td width="83" align="center" valign="top">
			<a href="venue_Select.cfm" onMouseOut="MM_swapImgRestore();"  onMouseOver="MM_swapImage('Backbtn','','images/Backbtn_f2.gif',1);"><img name="Backbtn" src="images/Backbtn.gif" width="24" height="23" border="0"><br><b>back</b><!-- fwtable fwsrc="bluebtn.png" fwbase="Backbtn.gif" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
</a>
		</td>
	</tr>
	</cfoutput>

</table></cfform>
 
</body>
</html>
