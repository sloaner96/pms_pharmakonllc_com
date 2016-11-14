<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	spkr_Edit_Contacts.cfm
	Memo field to edit Contact information.
	
	lb060201-  Initial code.
------------------------------------------------------------------------------
--->
<head>
<script LANGUAGE=JAVASCRIPT>

<!--
	//limit text to 495 chars
	function  _checkLimitContent(_CF_this)
	{
		if (_CF_this.value.length > 495)
		{
			alert("Please limit your notes to 500 charyesers");
    		return false;
  		}

    	return true;
	}
	
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


	<title>Edit Contact Details</title>
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
<cfset speakerid="#speakerid#">
</head>



<cfoutput>
<BODY bgcolor="##FBF9EB" onLoad="MM_preloadImages('images/Backbtn_f2.gif');MM_preloadImages('savebtn_f2.gif');">
</cfoutput>



<cfquery name="qContact_details" datasource="#application.speakerDSN#">
	SELECT  Contact_info.Contact_id, Contact_info.Contact_info, Contact_info.date_created, Contact_info.date_updated
	FROM   Contact_info  
	WHERE  Contact_info.Contact_id =  #Contact_id# AND Contact_info.type = 'SPKR'
	</cfquery>
	

	<b><font size="4"><font color="Navy">Contact Details</font></font></b><br>
	<br>
	
<cfform action="spkr_edit_Contacts_action.cfm?Contact_id=#URLEncodedFormat(Contact_id)#&speakerid=#speakerid#&no_menu='1'" method="POST" enablecab="Yes">	
<cfoutput query="qContact_details">
<font color="Navy"><b><font size="1">Date Created:</font></b></font>
	#dateFormat(qContact_details.date_created,"m/dd/yyyy")#<br>
<font color="Navy"><b><font size="1">Date Updated:</font></b></font>
#dateFormat(qContact_details.date_updated,"m/dd/yyyy")#</b></font><br>
<table width="80%" border="0" cellspacing="2" cellpadding="2">
<tr  BGCOLOR="eeeecc">
	<td><b>Contact ID:</b></td>
	<TD>#Contact_id#</td> 
</tr>
<tr  BGCOLOR="eeeecc">
	<td><b>Contact Info:</b></td>
		<TD><textarea cols="50" rows="9" name="Contact_info"onkeyup="return _checkLimitContent(this)">#qContact_details.Contact_info#</textarea></td> 
</tr>
<tr  BGCOLOR="eeeecc">
	<td colspan="2"></td>
</tr>

</cfoutput>


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
</cfform>
  </table>