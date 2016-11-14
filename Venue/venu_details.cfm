<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<!----------------------------------------------------------------------------
	venu_details.cfm
	Displays details of venue. Venue_id was passed from venu_summary. Queries are run to pull details.
	
	lb060201-  Initial code.
------------------------------------------------------------------------------
--->

<html>
<head>
<script LANGUAGE=JAVASCRIPT>
<!--
//use if Delete Venue is added
//function checkOut() 
//shows a confirm dialog box when the "venue delete" button is hit
//{
	//	a = (confirm("Are you sure you want to delete this venue and all related information including:\n\n          phone numbers\n          contacts\n          addresses?"))
   	//if (a == true)
	//return true 
	
	//else
	//return false
	
	//}

//opens popup window	
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

//pop up for Comments. Opens fullscreen then resizes it, so close button is not shown. User must use back button I provide. This forces a refresh of venu_details when pop up is closed.
function fullScreen(theURL) {
NFW = window.open(theURL, '', 'fullscreen=yes, scrollbars=auto')
NFW.resizeTo(650,400)
NFW.moveTo(50,100);
}


//-->

</script>	

<!--- sets sortby/order variables to be passed to venu_Add_Comment.cfm  --->
<cfset sortby = "date_created">
<cfset order = "DESC">

	<title>Venue Details</title>
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


</head>

<!--- pulls venue info --->
<cfquery name="qdetails" datasource="#application.speakerDSN#">
	SELECT  venues.venue_id, venues.venue_name, 
			venues.date_created, venues.date_updated,  venues.active, venues.date_inactive, venues.tax_id, venues.venue_type, venues.created_by, venues.updated_by
	FROM   	venues  
	WHERE  	venues.venue_id =  #venue_id# AND venues.display = '1' 
	</cfquery>
	
<!--- pulls userid info --->
<cfquery name="quserid" datasource="#session.login_dbs#" dbtype="ODBC" username="#session.login_dbu#" password="#session.login_dbp#">
	SELECT  user_id.last_name
	FROM   	user_id  
	WHERE  	user_id.rowid =  #qdetails.created_by#
	</cfquery>	
	
<!--- pulls userid info --->
<cfquery name="quserid2" datasource="#session.login_dbs#" dbtype="ODBC" username="#session.login_dbu#" password="#session.login_dbp#">
	SELECT  user_id.last_name
	FROM   	user_id  
	WHERE  	user_id.rowid =  #qdetails.updated_by#
	</cfquery>		
	
<!--- pulls venue's address --->
<cfquery name="qaddress" datasource="#application.speakerDSN#">
	SELECT  address.add_id, address.mailtoadd_1, address.mailtoadd_2, address.mailtoadd_3, 
			address.mailtocity, address.mailtostate, address.mailtozip, address.mailtocountry, address.busadd_1, address.busadd_2, address.busadd_3, 
			address.buscity, address.busstate, address.buszip, address.buscountry 
	FROM    address
	WHERE   address.owner_id =  #venue_id# and address.owner_type = 'VENU'
	ORDER BY address.add_id
	</cfquery>

 <!--- pulls venue's comments --->	
<cfquery name="qcomments" datasource="#application.speakerDSN#">
	SELECT  comment_id
	FROM    comments
	WHERE   comments.owner_id =  #venue_id# AND comments.owner_type = 'VENU'
	</cfquery> 
	
<!--- pulls contacts for the venue --->	
<cfquery name="qcontacts" datasource="#application.speakerDSN#">
	SELECT  contact_info.contact_id, contact_info.contact_info
	FROM   	contact_info  
	WHERE  	contact_info.owner_id =  #venue_id# AND contact_info.owner_type = 'VENU'
	</cfquery>
	
	<!--- pulls the phone, fax, email, etc --->
<cfquery name="qphone" datasource="#application.speakerDSN#">
	SELECT  phone_details.phone1, phone_details.phone2, phone_details.fax1, phone_details.fax2, phone_details.cell1, phone_details.cell2, phone_details.pager1, phone_details.pager2, phone_details.service1, phone_details.service2, phone_details.email1, phone_details.email2, phone_details.phone_id
	FROM    phone_details
	WHERE   phone_details.owner_id = #venue_id# AND phone_details.owner_type = 'VENU'
	</cfquery>
	
	

<cfoutput>
<BODY bgcolor="##FBF9EB" onLoad="MM_preloadImages('images/printbtn_f2.gif');MM_preloadImages('images/Backbtn_f2.gif');">
</cfoutput>



<cfoutput>
<table width="80%" border="0" cellspacing="2" cellpadding="0">
	<tr>
		<td colspan="5">
			<b><font size="4"><font color="Navy">Venue Details</font></font></b>
		</td>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td></td>
<!--- print button --->
		<td width="83" align="center" valign="top">
			<a href="##" onclick="javascript:window.print()" onMouseOut="MM_swapImgRestore();"  onMouseOver="MM_swapImage('printbtn','','images/printbtn_f2.gif',1);" ><img name="printbtn" src="images/printbtn.gif" width="26" height="23" border="0"><br><b><font color="Maroon">print</font></b></a>
		</td>
<!--- back to search button --->
		<td width="83" align="center" valign="top">
			<a href="venue_Select.cfm?venue_id=#venue_id#" onMouseOut="MM_swapImgRestore();"  onMouseOver="MM_swapImage('Backbtn','','images/Backbtn_f2.gif',1);"><img name="Backbtn" src="images/Backbtn.gif" width="24" height="23" border="0"><br><b>search again</b><!-- fwtable fwsrc="bluebtn.png" fwbase="Backbtn.gif" fwstyle="Dreamweaver" fwdocid = "742308039" fwnested="0" -->
</a></b></i>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td width="92" align="left"><font color="Navy"><b>Date Created:</b></font>
		</td>
		<td width="70" align="left">#dateFormat(qdetails.date_created,"m/dd/yyyy")#
		</td>
		<td width="80" align="left"><font color="Navy"><b>Created By:</b></font>
		</td>
		<td>#quserid.last_name#</td>	
	</tr>
	<tr>
		<td width="92" align="left"><font color="Navy"><b>Date Updated:</b></font></td>
		<td width="70" align="left">#dateFormat(qdetails.date_updated,"m/dd/yyyy")#</b></font></td>
		<td width="80" align="left"><font color="Navy"><b>Updated By:</b></font></td>
		<td width="70" align="left">#quserid2.last_name#</b></font></td>
	</tr>
	<br>
</table>
</cfoutput>

<table width="80%" border="0" cellspacing="0" cellpadding="3">
<cfoutput query="qdetails">
	<tr BGCOLOR="eeeecc">
		<th width="200" align="right">Venue ID:</th>
		<td></td>
		<td colspan="3">#qdetails.venue_id#</td>
	</tr>
	<tr>
		<td colspan="4">
	</tr>
<!--- pulls description for inactive code --->
<cfquery name="qactive" datasource="#application.speakerDSN#">
	SELECT description
	FROM codes
	WHERE code_type = 'SSTAT' AND code = '#qdetails.active#'
	</cfquery>
	<tr>
		<th><b>Status:</b></th><td></td>
		<td colspan="3">#qactive.description#&nbsp;&nbsp;<cfif qdetails.active EQ 'INACT'><b>Inactive Date:</b>&nbsp;#dateFormat(qdetails.date_inactive,"m/dd/yyyy")#</cfif></td>
	</tr>
	<tr>
		<td colspan="4">
	</tr>
	<tr BGCOLOR="eeeecc">
		<th><b>Venue Name:</b></th>
		<td></td>
		<td colspan="3"><A HREF="venu_edit.cfm?venue_id=#qdetails.venue_id#&venue_name=#URLEncodedFormat(qdetails.venue_name)#&active=#qdetails.active#&venue_type=#venue_type#&tax_id=#URLEncodedFormat(qdetails.tax_id)#&no_menu='1'" onclick="NewWindow(this.href,'name','500','300','yes');return false;"><b><font size="2">#qdetails.venue_name#</font></b></a></td>
	</tr>
	<tr>
		<td colspan="4">
	</tr>
<cfquery name="qtype" datasource="#application.speakerDSN#">
	SELECT code, description
	FROM codes
	WHERE code_type = 'VENU' AND code = '#qdetails.venue_type#'
</cfquery>	
	<tr>
		<th><b>Venue Type:</b></th>
		<td></td>
		<td colspan="3">#qtype.description#</td>
	</tr>
	<tr>
		<td colspan="4">
	</tr>
	<tr BGCOLOR="eeeecc">
		<Th><b>SS/Tax ID:</b></th>
		<td></td>
		<td colspan="3">#qdetails.tax_id#</td>
	</tr>
	<tr>
		<td colspan="4">
	</tr>
</cfoutput>

	<tr>
<cfoutput query="qaddress">
		<th valign="top"><A HREF="venu_edit_address.cfm?venue_id=#URLEncodedFormat(qdetails.venue_id)#&mailtoadd_1=#URLEncodedFormat(qaddress.mailtoadd_1)#&mailtoadd_2=#URLEncodedFormat(qaddress.mailtoadd_2)#&mailtoadd_3=#URLEncodedFormat(qaddress.mailtoadd_3)#&mailtocity=#URLEncodedFormat(qaddress.mailtocity)#&mailtostate=#URLEncodedFormat(qaddress.mailtostate)#&mailtozip=#qaddress.mailtozip#&mailtocountry=#URLEncodedFormat(qaddress.mailtocountry)#&add_id=#qaddress.add_id#&busadd_1=#URLEncodedFormat(qaddress.busadd_1)#&busadd_2=#URLEncodedFormat(qaddress.busadd_2)#&busadd_3=#URLEncodedFormat(qaddress.busadd_3)#&buscity=#URLEncodedFormat(qaddress.buscity)#&busstate=#URLEncodedFormat(qaddress.busstate)#&buszip=#qaddress.buszip#&buscountry=#URLEncodedFormat(qaddress.buscountry)#&no_menu='1'" onclick="NewWindow(this.href,'name','500','540','yes');return false;"><b> Addresses:</b></a>
	</th><td></td>
	<td colspan="3" align="left"><b><font color="Navy">Mail To:</font><br></b>#qaddress.mailtoadd_1#
	<cfif qaddress.mailtoadd_2 NEQ ""><br>#qaddress.mailtoadd_2#</cfif><cfif qaddress.mailtoadd_3 NEQ ""><br>#qaddress.mailtoadd_3#</cfif><cfif qaddress.mailtocity NEQ ""><br>#qaddress.mailtocity#</cfif><cfif qaddress.mailtostate NEQ "">&nbsp;&nbsp;#qaddress.mailtostate#</cfif><cfif qaddress.mailtozip NEQ "">&nbsp;&nbsp;#qaddress.mailtozip#</cfif><cfif qaddress.mailtocountry NEQ ""><br>#qaddress.mailtocountry#</cfif></td>
</tr>
<tr>
	<td></td><td></td>
	<td colspan="3" align="left"><b><font color="Navy">Business Address:</font><br></b>#qaddress.busadd_1#
	<cfif qaddress.busadd_2 NEQ ""><br>#qaddress.busadd_2#</cfif><cfif qaddress.busadd_3 NEQ ""><br>#qaddress.busadd_3#</cfif><cfif qaddress.buscity NEQ ""><br>#qaddress.buscity#</cfif><cfif qaddress.busstate NEQ "">&nbsp;&nbsp;#qaddress.busstate#</cfif><cfif qaddress.buszip NEQ "">&nbsp;&nbsp;#qaddress.buszip#</cfif><cfif qaddress.buscountry NEQ ""><br>#qaddress.buscountry#</cfif></td>
</tr>
</cfoutput>
<tr>
	<td colspan="4"></td>
</tr>
<tr BGCOLOR="eeeecc">
<cfoutput query="qphone">
	<th valign="top">
	<A HREF="venu_edit_phone.cfm?venue_id=#qdetails.venue_id#&phone_id=#qphone.phone_id#&phone1=#URLEncodedFormat(qphone.phone1)#&phone2=#URLEncodedFormat(qphone.phone2)#&fax1=#URLEncodedFormat(qphone.fax1)#&fax2=#URLEncodedFormat(qphone.fax2)#&cell1=#URLEncodedFormat(qphone.cell1)#&cell2=#URLEncodedFormat(qphone.cell2)#&pager1=#URLEncodedFormat(qphone.pager1)#&pager2=#URLEncodedFormat(qphone.pager2)#&service1=#URLEncodedFormat(qphone.service1)#&service2=#URLEncodedFormat(qphone.service2)#&email1=#URLEncodedFormat(qphone.email1)#&email2=#URLEncodedFormat(qphone.email2)#&no_menu='1'" onclick="NewWindow(this.href,'name','500','500','yes');return false;"><b>Phone Numbers:</b></a></th><td></td>
<td colspan="3"><cfif qphone.phone1 NEQ "">#qphone.phone1#&nbsp;<font color="Navy"><b>-Primary Phone</b></font></cfif>
<cfif qphone.fax1 NEQ ""><br>#qphone.fax1#&nbsp;<b><font color="Navy">-Primary Fax</font></b></cfif>
<cfif qphone.cell1 NEQ ""><br>#qphone.cell1#&nbsp;<b><font color="Navy">-Primary Cell</font></b></cfif>
<cfif qphone.pager1 NEQ ""><br>#qphone.pager1#&nbsp;<b><font color="Navy">-Primary Pager</font></b></cfif>
<cfif qphone.service1 NEQ ""><br>#qphone.service1#&nbsp;<b><font color="Navy">-Primary Service</font></b></cfif>
<cfif qphone.email1 NEQ ""><br>#qphone.email1#&nbsp;<b><font color="Navy">-Primary E-mail</font></b></cfif>
<cfif qphone.phone2 NEQ ""><br>#qphone.phone2#&nbsp;<b><font color="Navy">-Secondary Phone</font></b></cfif>
<cfif qphone.fax2 NEQ ""><br>#qphone.fax2#&nbsp;<b><font color="Navy">-Secondary Fax</font></b></cfif>
<cfif qphone.cell2 NEQ ""><br>#qphone.cell2#&nbsp;<b><font color="Navy">-Secondary Cell</font></b></cfif>
<cfif qphone.pager2 NEQ ""><br>#qphone.pager2#&nbsp;<b><font color="Navy">-Secondary Pager</font></b></cfif>
<cfif qphone.service2 NEQ ""><br>#qphone.service2#&nbsp;<b><font color="Navy">-Secondary Service</font></b></cfif>
<cfif qphone.email2 NEQ ""><br>#qphone.email2#&nbsp;<b><font color="Navy">-Secondary E-mail</font></b></cfif></td>
</tr>	
</cfoutput>
<tr>
	<td colspan="4"></td>
</tr>

<tr>
<cfoutput query="qcontacts">
	<th><A HREF="venu_edit_contacts.cfm?contact_id=#qcontacts.contact_id#&venue_id=#qdetails.venue_id#&contact_info=#URLEncodedFormat(qcontacts.contact_info)#&no_menu='1'" onclick="NewWindow(this.href,'name','520','400','yes');return false;"><b>Contact Info:</b></a></th><td></td>
	<td colspan="3">
	#qcontacts.contact_info#
	</td>
</tr>
<tr>
	<td colspan="4">
</tr></cfoutput>

<cfoutput query="qdetails">
<cfif qcomments.recordcount GT 0> 
<tr BGCOLOR="eeeecc"><th><img name="commentgif" src="images/page.gif">&nbsp;<A HREF="venu_comments_details.cfm?venue_id=#qdetails.venue_id#&no_menu='1'" onclick="fullScreen(this.href);return false;"><b>View Comments:</b></a></th>
	<td colspan="4">
</tr>
<cfelse>
<tr BGCOLOR="eeeecc"><th><A HREF="venu_Add_Comment.cfm?venue_id=#qdetails.venue_id#&sortby=#sortby#&order=#order#&no_menu='1'" onclick="fullScreen(this.href);return false;"><b>Add Comments:</b></a></th>
	<td colspan="4">
</tr>
</cfif>
</cfoutput>

</table>


</body>
</html>
