<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<!----------------------------------------------------------------------------
	mod_Edit_Comment.cfm
	Form fields to edit comments including: date, type message
	
	lb060201-  Initial code.
------------------------------------------------------------------------------
--->
<head>
	<title>Edit Moderator Comments</title>
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

<script LANGUAGE=JAVASCRIPT>
<!--

//limit length of comment to 245 chars
	function  _checkLimitContent(_CF_this)
	{
		if (_CF_this.value.length > 245)
		{
			alert("Please limit your notes to 250 charyesers");
    		return false;
  		}

    	return true;
	}
	
	function checkOut() 
//shows a confirm dialog box when the "delete comment" button is hit
{
	a = (confirm("Are you sure you want to delete this information?"));
   	if (a == true)
		return true;
	else
		return false;
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

</head>
<!--- pulls comment types from codes table --->
<cfquery name="qcomment_type" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'CTYPE'
	ORDER BY description
	</cfquery>


<cfoutput>
<BODY bgcolor="##FFFFCC" onLoad="MM_preloadImages('/images/Deletebtn_f2.gif');MM_preloadImages('/images/Backbtn_f2.gif');MM_preloadImages('savebtn_f2.gif');">
</cfoutput>


<cfform action="mod_edit_comment_action.cfm?speakerid=#URLEncodedFormat(speakerid)#&comment_id=#URLEncodedFormat(comment_id)#&sortby=#URLEncodedFormat(sortby)#&order=#URLEncodedFormat(order)#&no_menu='1'" method="POST" enablecab="Yes">
<table width="80%" border="0" cellspacing="2" cellpadding="2">
<cfoutput><tr>
	<th><b>Comment ID:</b></th>
	<TD>#comment_id#</td>
</tr>
<tr>
</tr>
<tr BGCOLOR="eeeecc">
<th>Date Created:</th>
<td>#dateformat(date_created, "mm/dd/yyyy")#</td>
</tr></cfoutput>
<tr>
<th>Type:</th>
<td><select name="comment_type">
			<CFOUTPUT query="qcomment_type">
			<OPTION value="#qcomment_type.code#"<cfif #trim(qcomment_type.code)# is #trim(url.comment_type)#> Selected </cfif>>#qcomment_type.description#
			</cfoutput>
			</select></td>
</tr>
<cfoutput>
	<tr BGCOLOR="eeeecc"><th><b>Comments:</b></th>


<input type="hidden" name="comment_id" value="#comment_id#">

<td colspan="1" valign="top"><textarea cols="60" rows="5" name="comment"onkeyup="return _checkLimitContent(this)">#comment#</textarea> 
		</td>

</tr>
</table>
<table border="0">
<tr><td></td></tr>
<tr>
<td width="83" align="center" valign="top">
<input type="image" name="Edit" value="Save" src="/images/savebtn.gif" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('savebtn','','/images/savebtn_f2.gif',1);"><br>
<b><font color="Maroon">save</font></b></td>
<td width="83" align="center" valign="top"><a href="mod_comments_details.cfm?speakerid=#speakerid#&no_menu='1'" onMouseOut="MM_swapImgRestore();"  onMouseOver="MM_swapImage('Backbtn','','/images/Backbtn_f2.gif',1);"><img name="Backbtn" src="/images/Backbtn.gif" width="24" height="23" border="0"><br><b>back</b><!-- fwtable fwsrc="bluebtn.png" fwbase="/images/Backbtn.gif" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
</a></td>
<i><b><td width="83" align="center" valign="top">
<a href="mod_Delete_Comment.cfm?comment_id=#comment_id#&speakerid=#speakerid#&sortby=#sortby#&order=#order#" onClick="return checkOut();" onMouseOut="MM_swapImgRestore();"  onMouseOver="MM_swapImage('Deletebtn','','/images/Deletebtn_f2.gif',1);"><img name="Deletebtn" src="/images/Deletebtn.gif" width="26" height="23" border="0"><br><b> delete comment</b><!-- fwtable fwsrc="redbtn.png" fwbase="Deletebtn.gif" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
</a></td>
</tr>
</cfoutput>
</table>
<br> 

 
</cfform> 

</body>
</html>
