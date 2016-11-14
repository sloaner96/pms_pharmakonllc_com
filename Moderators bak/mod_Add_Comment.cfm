<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!----------------------------------------------------------------------------
	mod_Add_Comment.cfm
	Add a new comment for a moderator. Comments include a date, type and memo area
	
	lb070101-  Initial code.
------------------------------------------------------------------------------
--->

<html>
<head>
	<title>Add Moderator Comment</title>
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
//limit comment to only 245 chars
	function  _checkLimitContent(_CF_this)
	{
		if (_CF_this.value.length > 245)
		{
			alert("Please limit your notes to 250 charyesers");
    		return false;
  		}
    	return true;
	}
	
//Fireworks butttons	
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
<BODY bgcolor="##FFFFCC" onLoad="MM_preloadImages('/images/Deletebtn_f2.gif');MM_preloadImages('/images/Backbtn_f2.gif');MM_preloadImages('savebtn_f2.gif');">
</cfoutput>

<!--- pull comment types from codes table --->
<cfquery name="qcomment_type" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'CTYPE'
	ORDER BY description
	</cfquery>

<b><i><font size="3">Add Comment</font></i></b><br>

<cfform action="mod_add_comment_action.cfm?speakerid=#URLEncodedFormat(speakerid)#&sortby=#sortby#&order=#order#&no_menu='1'" method="POST" enablecab="Yes">

<table width="80%" border="0" cellspacing="2" cellpadding="2">
	<tr BGCOLOR="eeeecc">
		<th><b>Moderator ID:</b></th>
		<TD><cfoutput>#speakerid#</cfoutput></td>
	</tr>
	<tr>
	</tr>
	<tr>
		<th>Type:</th>
		<td><select name="comment_type">
			<CFOUTPUT query="qcomment_type">
			<OPTION value="#qcomment_type.code#">#qcomment_type.description#
			</cfoutput>
			</select></td>
	</tr>
	<tr BGCOLOR="eeeecc">
		<th valign="top"><b>Comments:</b></th>
		<td colspan="1" valign="top"><textarea cols="60" rows="5" name="comment"onkeyup="return _checkLimitContent(this)"></textarea> 
		</td>
	</tr>
	<tr>
		<td></td>
	</tr><cfoutput>
	<tr>
		<td width="83" align="center" valign="top">
			<input type="image" name="Edit" value="Save" src="/images/savebtn.gif" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('savebtn','','/images/savebtn_f2.gif',1);"><br>
<b><font color="Maroon">save</font></b></td>

		<td width="83" align="center" valign="top"><a href="mod_comments_details.cfm?speakerid=#speakerid#&no_menu='1'" onMouseOut="MM_swapImgRestore();"  onMouseOver="MM_swapImage('Backbtn','','/images/Backbtn_f2.gif',1);"><img name="Backbtn" src="/images/Backbtn.gif" width="24" height="23" border="0"><br><b>back</b><!-- fwtable fwsrc="bluebtn.png" fwbase="/images/Backbtn.gif" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
</a></td>
	</tr></cfoutput>
	
</table>
 


</cfform>

</body>
</html>
