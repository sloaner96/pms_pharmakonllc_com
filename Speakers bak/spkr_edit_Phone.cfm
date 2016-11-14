<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	spkr_Edit_Phone.cfm
	Form fields to edit phone info including: primary phone, fax, cell, email, service, pager AND secondary phone, fax, cell, email, service, pager
	
	lb060201-  Initial code.
------------------------------------------------------------------------------
--->
<head>
	<title>Edit Speaker Phone</title>
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

<script LANGUAGE=JAVASCRIPT>

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
<BODY bgcolor="##FBF9EB" onLoad="MM_preloadImages('images/Deletebtn_f2.gif');MM_preloadImages('images/Backbtn_f2.gif');MM_preloadImages('savebtn_f2.gif');">
</cfoutput>

	


<cfform action="spkr_edit_phone_action.cfm?speakerid=#URLEncodedFormat(speakerid)#&phone_id=#URLEncodedFormat(phone_id)#&no_menu='1'" method="POST" enablecab="Yes">
<table width="80%" border="0" cellspacing="2" cellpadding="2">
<tr>
	<td><b>Speaker ID:&nbsp;&nbsp;</b><cfoutput>#speakerid#</cfoutput></td>

</tr>

<tr BGCOLOR="eeeecc">
	<td width="200"><b><font color="Navy">Primary Phone:</font></b></td>
	<TD>
	<cfinput type="Text" name="phone1" value="#url.phone1#" message="Phone is required " required="No" size="25"></td>
</tr>
<tr>
	<td><b><font color="Navy">Primary Fax:</font></b></td>
	<TD>
	<cfinput type="Text" name="fax1" value="#url.fax1#" message="Phone is required " required="No" size="25"></td>
</tr>
<tr BGCOLOR="eeeecc">
	<td><b><font color="Navy">Primary Cell Phone:</font></b></td>
	<TD>
	<cfinput type="Text" name="cell1" value="#url.cell1#" message="Phone is required " required="No" size="25"></td>
</tr>
<tr>
	<td><b><font color="Navy">Primary Pager:</font></b></td>
	<TD>
	<cfinput type="Text" name="pager1" value="#url.pager1#" message="Phone is required " required="No" size="25"></td>
</tr>
<tr BGCOLOR="eeeecc">
	<td><b><font color="Navy">Primary Service:</font></b></td>
	<TD>
	<cfinput type="Text" name="service1" value="#url.service1#" message="Phone is required " required="No" size="25"></td>
</tr>
<tr>
	<td><b><font color="Navy">Primary E-Mail:</font></b></td>
	<TD>
	<cfinput type="Text" name="email1" value="#url.email1#" message="Phone is required " required="No" size="25"></td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr BGCOLOR="eeeecc">
	<td><b><font color="Green">Secondary Phone:</font></b></td>
	<TD>
	<cfinput type="Text" name="phone2" value="#url.phone2#" message="Phone is required " required="No" size="25"></td>
</tr>
<tr>
	<td><b><font color="Green">Secondary Fax:</font></b></td>
	<TD>
	<cfinput type="Text" name="fax2" value="#url.fax2#" message="Phone is required " required="No" size="25"></td>
</tr>
<tr BGCOLOR="eeeecc">
	<td><b><font color="Green">Secondary Cell Phone:</font></b></td>
	<TD>
	<cfinput type="Text" name="cell2" value="#url.cell2#" message="Phone is required " required="No" size="25"></td>
</tr>
<tr>
	<td><b><font color="Green">Secondary Pager:</font></b></td>
	<TD>
	<cfinput type="Text" name="pager2" value="#url.pager2#" message="Phone is required " required="No" size="25"></td>
</tr>
<tr BGCOLOR="eeeecc">
	<td><b><font color="Green">Secondary Service:</font></b></td>
	<TD>
	<cfinput type="Text" name="service2" value="#url.service2#" message="Phone is required " required="No" size="25"></td>
</tr>
<tr>
	<td><b><font color="Green">Secondary E-Mail:</font></b></td>
	<TD>
	<cfinput type="Text" name="email2" value="#url.email2#" message="Phone is required " required="No" size="25"></td>
</tr>
</table>
<br> 
<table width="80%" border="0">
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
