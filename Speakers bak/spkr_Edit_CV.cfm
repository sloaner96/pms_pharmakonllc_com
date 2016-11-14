<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	spkr_Edit_CV.cfm
	Form fields to edit cv, w9, and contryes received dates.
	
	lb060201-  Initial code.
------------------------------------------------------------------------------
--->
<head>
	<title>Edit Speaker CV/W9 Date</title>
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


<!--- pops up calendar --->
<script language="JavaScript" src="date-picker.js"></script>
<script>

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
</script>
</HEAD>


<cfoutput>
<BODY bgcolor="##FBF9EB" onLoad="MM_preloadImages('images/Backbtn_f2.gif');MM_preloadImages('savebtn_f2.gif');">
</cfoutput>


<b><i><font size="3">Edit CV/W9 Date</font></i></b><br>
<cfform action="spkr_Edit_cv_action.cfm?speakerid=#URLEncodedFormat(speakerid)#&no_menu='1'" method="post" name="calform" enablecab="Yes">
<cfoutput>

<input type="hidden" name="speakerid" value="#speakerid#">
</cfoutput>
<table width="80%" border="0" cellspacing="2" cellpadding="2">
<tr BGCOLOR="eeeecc">
	<td><b>Speaker ID:</b></td>
	<TD><cfoutput>#speakerid#</cfoutput></td>

<tr BGCOLOR="eeeecc">
	<td><b>CV Received Date:</b></td>
	<TD BGCOLOR="eeeecc">
	<cfinput type="Text" name="CVdatebox" value="#DateFormat(cv, "m/d/yyyy")#" required="No" size="15"><a href="javascript:show_calendar('calform.CVdatebox');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"><img src="../images/show-calendar.gif" width=24 height=22 border=0></a>
</tr>
<tr BGCOLOR="eeeecc">
	<td><b>W9 Received Date:</b></td>
	<TD BGCOLOR="eeeecc">
	<cfinput type="Text" name="W9datebox" value="#DateFormat(w9, "m/d/yyyy")#" required="No" size="15"><a href="javascript:show_calendar('calform.W9datebox');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"><img src="../images/show-calendar.gif" width=24 height=22 border=0></a>
</tr>
<tr BGCOLOR="eeeecc">
	<td><b>Contryes Received Date:</b></td>
	<TD BGCOLOR="eeeecc">
	<cfinput type="Text" name="consult_agreedatebox" value="#DateFormat(consult_agree, "m/d/yyyy")#" required="No" size="15"><a href="javascript:show_calendar('calform.consult_agreedatebox');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;"><img src="../images/show-calendar.gif" width=24 height=22 border=0></a>
</tr>
  <tr valign=top> 
            <td colspan="2"> 
              <div align="center"> 
                <p>&nbsp;</p>
              </div>
            </td>
          </tr>
</table>


<table width="100%" border="0">
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
