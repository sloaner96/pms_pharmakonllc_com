<cfparam name="url.print" default="0">
<cfparam name="attributes.bodypassthrough" default="">
<cfparam name="attributes.showCalendar" default="">
<cfparam name="attributes.showPrinter" default="1">
<cfparam name="attributes.title" default="">
<cfparam name="attributes.doAjax" default="false">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<cfoutput>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <title>Pharmakon Project Management System<cfif attributes.title NEQ "">: #attributes.title#</cfif></title>
  <link rel="stylesheet" href="#Application.baseurl#/includes/styles/main.css" type="text/css" media="screen"/>
  <link rel="stylesheet" href="#Application.baseurl#/includes/styles/printfriendly.css" type="text/css" media="print"/>
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

<!--- These are the libraries needed to do ajax --->
<cfif attributes.DoAjax>
        <script type='text/javascript' src='/ajax/core/engine.js'></script>
		<script type='text/javascript' src='/ajax/core/util.js'></script>
		<script type='text/javascript' src='/ajax/core/settings.js'></script>
</cfif>
<cfif url.print EQ 0>
  <cfmodule template="#Application.TagPath#/ctags/menus.cfm">
</cfif>

</head>

<cfoutput><body leftmargin="0" topmargin="0" #attributes.bodypassthrough#></cfoutput>
<script language="JavaScript1.2">mmLoadMenus();</script>
<table border="0" cellpadding="0" cellspacing="0" class="MainTable" id="Maintable" align="center">
   <tr>
       <td>
	     <table border="0" cellpaddding="0" cellspacing="0" width="100%" class="PrintHeader" id="PrintHeader">
		   <tr>
		       <td><img src="/Images/Main_Header_small.gif" alt="" border="0"></td>
		      </tr>
		 </table>
	      <table border="0" cellpadding="0" cellspacing="0" width="100%" background="/images/header_bg.jpg" class="MainHeader" id="MainHeader">
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
	     <table border="0" cellpaddding="0" cellspacing="0" background="/images/nav_bg.gif" width="100%" class="MainHeader" id="MainHeader">
           <tr bgcolor="#4a5f64">

			   <td width="20%" align="center">

<a name="projects" onmouseover="MM_showMenu(window.mm_menu_0309135207_0,0,20,null,'projects');" onmouseout="MM_startTimeout();"><img src="/Images/nav_projects_off.gif" width="85" height="20" alt="" border="0" onmouseover="this.src='/images/nav_projects_on.gif';" onmouseout="this.src='/images/nav_projects_off.gif';"></a></td>


<td width="3"><img src="/Images/navSpacer.gif" width="3" height="20" alt="" border="0" hspace=0 vspace=0></td>


			   <td width="20%" align="center"><a name="Search" onMouseOut="MM_startTimeout();"  onMouseOver="MM_showMenu(window.mm_menu_0309140501_1,0,20,null,'Search');">
			          <img src="/Images/nav_search_off.gif" width="83" height="20" alt="" border="0" onmouseover="this.src='/images/nav_search_on.gif'" onmouseout="this.src='/images/nav_search_off.gif'"></a></td>


<td width="3"><img src="/Images/navSpacer.gif" width="3" height="20" alt="" border="0" hspace=0 vspace=0></td>


			   <td width="20%" align="center"><a name="Scheduling" href="/schedule/main.cfm" onMouseOut="MM_startTimeout();">
			          <img src="/Images/nav_schedules_off.gif" width="108" height="20" alt="" border="0" onmouseover="this.src='/images/nav_schedules_on.gif'" onmouseout="this.src='/images/nav_schedules_off.gif'"></a></td>


<td width="3"><img src="/Images/navSpacer.gif" width="3" height="20" alt="" border="0" hspace=0 vspace=0></td>


			   <td width="20%" align="center"><a name="Reports" href="/reports/index.cfm" onMouseOut="MM_startTimeout();">
			         <img src="/Images/nav_reports_off.gif" width="86" height="20" alt="" border="0" hspace=0 vspace=0  onmouseover="this.src='/images/nav_reports_on.gif'" onmouseout="this.src='/images/nav_reports_off.gif'"></a></td>






			 <cfif Trim(Session.UserInfo.USER_DEPT) EQ "IT" OR Trim(Session.UserInfo.USER_DEPT) EQ "OPS">
			   <td width="3"><img src="/Images/navSpacer.gif" width="3" height="20" alt="" border="0" ></td>
			   <td width="20%" align="center"><a name="admin" href="/admin/index.cfm" onMouseOut="MM_startTimeout();">
			         <img src="/Images/nav_admin_off.gif" width="84" height="20" alt="" border="0" hspace=0 vspace=0  onmouseover="this.src='/images/nav_admin_on.gif'" onmouseout="this.src='/images/nav_admin_off.gif'"></a></td>

			 <cfelse>

			   <td width="3"><img src="/Images/navSpacer.gif" width="3" height="20" alt="" border="0" ></td>
			   <td width="20%" align="center">
			         <img src="/Images/nav_admin_off.gif" width="84" height="20" alt="" border="0" hspace=0 vspace=0></td>
			 </cfif>
		   </tr>
		 </table>



		 <cfif IsDefined("attributes.title")>
		    <cfoutput><br>
			 <table border="0" cellpadding="4" cellspacing="1" width="100%" bgcolor="##000000" class="mainwindow" id="mainwindow">
			   <tr bgcolor="##666666">
			      <td align="center"><strong style="color:##ffffff;">#attributes.title#</strong></td>
			   </tr>
			   <tr>
			    <td bgcolor="##ffffff">
			 <!--- <table border="0" cellpadding="3" cellspacing="0" width="100%">
	           <tr>
	               <td class="tdheader">#attributes.title#</td>
	           </tr>
	         </table> --->
		    </cfoutput>
		 </cfif>
