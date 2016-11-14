<cfparam name="url.print" default="0">
<cfparam name="attributes.bodypassthrough" default="">
<cfparam name="attributes.showCalendar" default="">
<cfparam name="attributes.showPrinter" default="1">
<cfparam name="attributes.title" default="">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<cfoutput>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Pharmakon, LLC. Project Management System<cfif attributes.title NEQ "">: #attributes.title#</cfif></title>
  <link rel="stylesheet" href="#Application.baseurl#/includes/styles/main.css" type="text/css" media="screen"/>
  <link rel="stylesheet" href="#Application.baseurl#/includes/styles/printerfriendly.css" type="text/css" media="print"/>
</cfoutput>
<cfif attributes.showCalendar EQ 1>
  <!-- calendar stylesheet -->
  <link rel="stylesheet" type="text/css" media="all" href="/jscalendar1_0/calendar-blue.css" title="tas" />

  <!-- main calendar program -->
  <script type="text/javascript" src="/jscalendar1_0/calendar.js"></script>

  <!-- language for the calendar -->
  <script type="text/javascript" src="/jscalendar1_0/lang/calendar-en.js"></script>

  <!-- the following script defines the Calendar.setup helper function, which makes
       adding a calendar a matter of 1 or 2 lines of code. -->
  <script type="text/javascript" src="/jscalendar1_0/calendar-setup.js"></script>
</cfif>
<cfif url.print EQ 0>
  <cfmodule template="#Application.TagPath#/ctags/menus.cfm">
</cfif>


</head>

<cfoutput><body leftmargin="0" topmargin="0" #attributes.bodypassthrough#></cfoutput>
<cfif url.print EQ 0>
<script language="JavaScript1.2">mmLoadMenus();</script>
<table border="0" cellpadding="0" cellspacing="0" width="760" align="center">
   <tr>
       <td>
	     <table border="0" cellpaddding="0" cellspacing="0" width="100%" class="PrintHeader">
		   <tr>
		       <td><img src="/Images/Main_Header_small.gif" alt="" border="0"></td>
			   <td align="right"><a href="##" onclick="self.close();">X Close</a></td>
		      </tr>
		 </table>  
	      <table border="0" cellpadding="0" cellspacing="0" width="100%" background="/images/header_bg.jpg" class="MainHeader">
			<tr>
			   <td background="/images/header_bg.jpg"><a href="/index.cfm"><img src="/Images/Main_Header.jpg" width="284" height="76" alt="Pharmakon, LLC. Project Management System" border="0"></a></td>
			   <td valign="top" align="right">
			      <table border="0" cellpaddding="3" cellspacing="0">
                     <tr>
                        <td><a href="/index.cfm" class="topnav">HOME</a></td>
						<td>|</td>
						<td><a href="/help/index.cfm" class="topnav" target="_blank">HELP</a></td>
						<td>|</td>
						<td><a href="/logout.cfm" class="topnav" style="color:#990000;">LOGOUT</a></td>
                     </tr>
					 <tr>
					   <td colspan=5>&nbsp;</td>
					 </tr>
					 <cfoutput>
						 <cfif Attributes.ShowPrinter>
							  <tr>
							     <td align="center" valign="bottom" colspan="5"><a href="javascript:void(0);" onclick="window.print();" class="topnav"><img src="/Images/btn_printer_friendly.gif" width="18" height="15" alt="Click Here for a printer friendly version" border="0"> Printer Friendly</a></td>
							  </tr>
						 </cfif>
					 </cfoutput>
                  </table>           
			   </td>
			</tr>
		  </table>
	     <table border="0" cellpaddding="0" cellspacing="0" background="/images/nav_bg.gif" class="MainHeader">
           <tr>
               <td><a name="projects" onmouseover="MM_showMenu(window.mm_menu_0309135207_0,0,20,null,'projects');" onmouseout="MM_startTimeout();">
			          <img src="/Images/nav_projects_off.gif" width="85" height="20" alt="" border="0" onmouseover="this.src='/images/nav_projects_on.gif';" onmouseout="this.src='/images/nav_projects_off.gif';"></a></td>
			   <td><img src="/Images/navSpacer.gif" width="3" height="20" alt="" border="0" hspace=0 vspace=0></td>
			   <td><a name="Search" onMouseOut="MM_startTimeout();"  onMouseOver="MM_showMenu(window.mm_menu_0309140501_1,0,20,null,'Search');">
			          <img src="/Images/nav_search_off.gif" width="83" height="20" alt="" border="0" onmouseover="this.src='/images/nav_search_on.gif'" onmouseout="this.src='/images/nav_search_off.gif'"></a></td>
			   <td><img src="/Images/navSpacer.gif" width="3" height="20" alt="" border="0" hspace=0 vspace=0></td>
			   <td><a name="Scheduling" onMouseOut="MM_startTimeout();"  onMouseOver="MM_showMenu(window.mm_menu_0309140733_2,0,20,null,'Scheduling');">
			          <img src="/Images/nav_schedules_off.gif" width="108" height="20" alt="" border="0" onmouseover="this.src='/images/nav_schedules_on.gif'" onmouseout="this.src='/images/nav_schedules_off.gif'"></a></td>
			   <td><img src="/Images/navSpacer.gif" width="3" height="20" alt="" border="0" hspace=0 vspace=0></td>
			   <td><a name="Speakers" onMouseOut="MM_startTimeout();"  onMouseOver="MM_showMenu(window.mm_menu_0309141142_3,0,20,null,'Speakers');">
			          <img src="/Images/nav_speakers_off.gif" width="90" height="20" alt="" border="0" onmouseover="this.src='/images/nav_speakers_on.gif'" onmouseout="this.src='/images/nav_speakers_off.gif'"></a></td>
			   <td><img src="/Images/navSpacer.gif" width="3" height="20" alt="" border="0" hspace=0 vspace=0></td>
			   <td><a name="moderators" onMouseOut="MM_startTimeout();"  onMouseOver="MM_showMenu(window.mm_menu_0309141305_4,0,20,null,'moderators');">
			          <img src="/Images/nav_moderators_off.gif" width="118" height="20" alt="" border="0" onmouseover="this.src='/images/nav_moderators_on.gif'" onmouseout="this.src='/images/nav_moderators_off.gif'"></a></td>
			   <td><img src="/Images/navSpacer.gif" width="3" height="20" alt="" border="0" hspace=0 vspace=0></td>
			   <td><a name="venues" onMouseOut="MM_startTimeout();"  onMouseOver="MM_showMenu(window.mm_menu_0309141953_5,0,20,null,'venues');">
			         <img src="/Images/nav_venues_off.gif" width="80" height="20" alt="" border="0" onmouseover="this.src='/images/nav_venues_on.gif'" onmouseout="this.src='/images/nav_venues_off.gif'"></a></td>
			   <td><img src="/Images/navSpacer.gif" width="3" height="20" alt="" border="0" hspace=0 vspace=0></td>
			   <td><a name="Reports" onMouseOut="MM_startTimeout();"  onMouseOver="MM_showMenu(window.mm_menu_0309142106_6,0,20,null,'Reports');">
			         <img src="/Images/nav_reports_off.gif" width="86" height="20" alt="" border="0" hspace=0 vspace=0  onmouseover="this.src='/images/nav_reports_on.gif'" onmouseout="this.src='/images/nav_reports_off.gif'"></a></td>
			 <cfif Trim(Session.UserInfo.USER_DEPT) EQ "IT">  
			   <td><img src="/Images/navSpacer.gif" width="3" height="20" alt="" border="0" ></td>
			   <td><a name="admin" href="/admin/index.cfm" onMouseOut="MM_startTimeout();"  onMouseOver="MM_showMenu(window.mm_menu_0309143331_7,-49,20,null,'admin');">
			         <img src="/Images/nav_admin_off.gif" width="84" height="20" alt="" border="0" hspace=0 vspace=0  onmouseover="this.src='/images/nav_admin_on.gif'" onmouseout="this.src='/images/nav_admin_off.gif'"></a></td>
			 <cfelse>
			   <td><img src="/images/blank.gif" width="87" height="20"></td>
			 </cfif>		 
		   </tr>
		 </table>     
		 <cfif IsDefined("attributes.title")>
		    <cfoutput><br>
			 <table border="0" cellpadding="3" cellspacing="0" width="100%">
	           <tr>
	               <td class="tdheader">#attributes.title#</td>
	           </tr>
	         </table>
		    </cfoutput>
		 </cfif>
	                
         
