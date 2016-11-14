<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<!----------------------------------------------------------------------------
	venu_comments_details.cfm
	Shows comment details. User can sort form.
	
	lb070201-  Initial code.
------------------------------------------------------------------------------
--->

<html>
<head>
<script LANGUAGE=JAVASCRIPT>

<!--
//create popup window
function NewWindow(mypage, myname, w, h, scroll) {
var winl = (screen.width - w) / 2;
var wint = (screen.height - h) / 2;
winprops = 'height='+h+',width='+w+',top='+wint+',left='+winl+',scrollbars='+scroll+',resizable'
win = window.open(mypage, myname, winprops)
if (parseInt(navigator.appVersion) >= 4) { win.window.focus(); }
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

	<title>Venue Comments Details</title>
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

<!--- check if new sort order has been selected --->
<cfif #parameterexists(sortby)#>
	<cfset sortby = #sortby#>
<cfelse>
	<cfset sortby = 'DATE_CREATED'>
</cfif>
<cfif #parameterexists(order)#>
	<cfset order = #order#>
<cfelse>
	<cfset order = 'DESC'>
</cfif>
		

</head>



<!--- pulls venue's comments --->	
<cfquery name="qcomments" datasource="#application.speakerDSN#">
	SELECT  comment, comment_id, comment_type, date_created, updated_by
	FROM    comments
	WHERE   comments.owner_id = #venue_id# AND comments.owner_type = 'VENU'
	ORDER BY #sortby# #order#
	</cfquery>


	
<cfoutput>
<BODY bgcolor="##FFFFCC" onLoad="MM_preloadImages('images/Addbtn_f2.gif'); MM_preloadImages('images/Backbtn_f2.gif');">
</cfoutput>



<cfoutput>
<table border="0" cellspacing="2" cellpadding="0">
	<tr BGCOLOR="eeeecc">
		<td colspan="4" valign="top"><font color="Navy"><b><font size="3">Comments</font></b></font>
		</td>
		<td></td>
	<tr BGCOLOR="eeeecc">
		<td width="350" valign="top"></td>
		<td width="83" align="center" valign="top">
      		<a href="venu_Add_Comment.cfm?venue_id=#venue_id#&sortby=#sortby#&order=#order#&no_menu='1'" onMouseOut="MM_swapImgRestore();"  onMouseOver="MM_swapImage('Addbtn','','images/Addbtn_f2.gif',1);"><img name="Addbtn" src="images/Addbtn.gif" width="24" height="23" border="0"><br><b>add comment</b><!-- fwtable fwsrc="Addbtn.png" fwbase="images/Addbtn.gif" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
</a>	</td>
		<td width="83" align="center" valign="top">
			<a href="venu_edit_bridge.cfm?venue_id=#venue_id#&no_menu='1'" onMouseOut="MM_swapImgRestore();"  onMouseOver="MM_swapImage('Backbtn','','images/Backbtn_f2.gif',1);" ><img name="Backbtn" src="images/Backbtn.gif" width="24" height="23" border="0"><br><b>back</b><!-- fwtable fwsrc="bluebtn.png" fwbase="Backbtn.gif" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
</a>	</td>
		<td width="83" align="center" valign="top">
			<a href="##" onclick="javascript:window.print()" onMouseOut="MM_swapImgRestore();"  onMouseOver="MM_swapImage('printbtn','','images/printbtn_f2.gif',1);" ><img name="printbtn" src="images/printbtn.gif" width="26" height="23" border="0"><br><b><font color="Maroon">print</font></b></a>
		</td>
		</td>
	</tr>
	<tr BGCOLOR="eeeecc">
		<td height="30" colspan="4" align="center">
			<b><font color="Navy">To change the sort order. Select the appropriate fields and hit 'Go'</font></b>
		</td>
	</tr>
	</cfoutput>
	<tr BGCOLOR="eeeecc"><td colspan="4" align="left">
	
	<!--- form for sort order changes --->
	<cfform name="Sort" action="venu_comments_details.cfm?venue_id=#venue_id#&no_menu='1'" method="POST">

	<b><font color="Maroon">Sort By:</font></b>&nbsp;
			<select name="sortby">
			<OPTION value="date_created"<cfif sortby is "date_created"> Selected </cfif>>Date
			<OPTION value="comment_type"<cfif sortby is "comment_type"> Selected </cfif>>Type
			<OPTION value="updated_by"<cfif sortby is "updated_by"> Selected </cfif>>User
			</select>
			&nbsp;
	<b><font color="Maroon">Order By:</font></b>&nbsp;
			<select name="order">
			<OPTION value="DESC"<cfif order is "DESC"> Selected </cfif>>DESC
			<OPTION value="ASC"<cfif order is "ASC"> Selected </cfif>>ASC
			</select>
			&nbsp;
			<input type="Image" src="images/go_button.gif" value="" name="go">		
		</td>
	</tr>
</table><br><br>

<table>
	<tr>
		<td width="50"><font color="Navy"><b>Date</b></font></td>
		<td width="50"><font color="Navy"><b>Type</b></font></td>
		<td width="50"><font color="Navy"><b>User</b></font></td>
		<td width="400" colspan="2"><font color="Navy"><b>Message</b></font></td>
	</tr>
	<cfoutput query="qcomments">
	<!--- pulls userid info --->
<cfquery name="quserid2" datasource="#session.login_dbs#" dbtype="ODBC" username="#session.login_dbu#" password="#session.login_dbp#">
	SELECT  user_id.last_name
	FROM   	user_id  
	WHERE  	user_id.rowid =  #qcomments.updated_by#
	</cfquery>
	<tr bgcolor="#IIf(Currentrow Mod 2, DE('eeeecc'), DE('FBF9EB'))#">
		<td>#dateformat(date_created, "mm/dd/yyyy")#</td>
		<td>#comment_type#</td>
		<td>#quserid2.last_name#</td>
		<td colspan="2">
			<A HREF="venu_Edit_Comment.cfm?comment_id=#qcomments.comment_id#&venue_id=#venue_id#&comment=#URLEncodedFormat(qcomments.comment)#&date_created=#URLEncodedFormat(qcomments.date_created)#&comment_type=#URLEncodedFormat(qcomments.comment_type)#&sortby=#URLEncodedFormat(sortby)#&order=#URLEncodedFormat(order)#&no_menu='1'"><b>#qcomments.comment#</b></a></td>
	</tr>
	</cfoutput>
</table>
</cfform>



	



</body>
</html>
