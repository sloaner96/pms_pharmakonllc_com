<!---------------------------------
report_modspkr_calendar2.cfm

This report is an Outlook type calendar that will display meetings for a particular 
spkr/mod or times a spkr/mod is unavailable. 

11/14/02 - Matt Eaves - Initial Code
--------------------------------------->
<!--- <cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Moderator/Speaker Calendar" showCalendar="0"> --->
 <link rel="stylesheet" type="text/css" media="all" href="../includes/styles/schedule.css" title="tas" />

<style>
A:link 
{	
	color:navy; 
	
}
A:hover
{

	color:blue; 
	
}
A:visited 
{ 
	color:navy; 

}
A:active 
{
	color:navy; 

}

.daycontent2 {
   width: 99%;
   height:60px;
   border-collapse: collapse;
   overflow:auto;
   font-family:verdana;
   font-size:8px;
   right-margin:0px;
   padding:1px;
   bottom-margin:1px;
   
}

</style>
<script language="JavaScript">
function PerformPrint()
{
	if(document.all.PrintSpaces != null)
	{
		document.all.PrintSpaces.className = "ShowPrintSpaces";
	}
	window.print();
}

function ShowReminder(intaction)
{
	
	if(intaction == 1)
	{
		document.all.PrintReminder.className = "PrintReminderShow";
	}
	else
	{
		document.all.PrintReminder.className = "PrintReminderHide";
	}
}
</script>
</head>

<body>
<cfoutput>
<cfif IsDefined("url.id")>
<cfset ModSpeakerID = #url.id#>
<cfset form.select_month = #url.month#>
<cfset form.select_year = #url.year#>
<cfset Table_Col = '#url.id#'>

<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME="gettype">
select type from
speaker
where speakerid = '#ModSpeakerID#'
</CFQUERY>

<cfset form.sm_type = '#gettype.type#'>
<cfset form.report_type = 'unavailable'>

<cfelse>

<cfif #form.sm_type# EQ "SPKR">
	<cfset ModSpeakerID = #form.speakers#>
	<cfset Table_Col = "speakerid">
<cfelseif #form.sm_type# EQ "MOD">
	<cfset ModSpeakerID = #form.moderators#>
	<cfset Table_Col = "speakerid">
<cfelse>
	<cfinclude template="error_handler.cfm">
	<cfabort>
</cfif>
</cfif>
</cfoutput>

<CFQUERY DATASOURCE="#application.SpeakerDSN#" NAME='getSpeakerModName'>
	SELECT firstname, lastname, speakerid
	FROM Speaker
	WHERE speakerid = #ModSpeakerID#
	ORDER BY lastname
</CFQUERY>

<cfoutput>
	<font face="Verdana" size ="2"><a href="../schedule/schedule_time_list.cfm?id=#ModSpeakerID#&no_menu=1"><u>Back to Month Selection</u></a></font>
	<center>
		<!--- <div style="font-size: 16px; font-family: arial; font-weight: bold; padding-bottom: 7px; color: navy; border-bottom: solid 1px navy;" width="100%"> --->
			<font face="Verdana" size ="2"><strong>#getSpeakerModName.firstname# #getSpeakerModName.lastname#</strong> - <!--- <cfif #form.report_type# EQ "meeting">Meeting Schedule<cfelseif #form.report_type# EQ "unavailable"><strong><font color="800000">Unavailable Calendar</font></strong></font></cfif> ---><br><br>
		<!--- </div> --->
	</center>
</cfoutput>

<cfoutput>
	<font face="Verdana" size ="2"><center><strong>#MonthAsString(form.select_month)# #form.select_year#</strong></center></font><br>
</cfoutput>
	
	<cfset oBeginDate = #CreateDate(form.select_year, form.select_month, 1)#>
	<cfset iDaysInMonth = #DaysInMonth(oBeginDate)#>
	<cfset oEndDate = #CreateDate(form.select_year, form.select_month, iDaysInMonth)#>

	<TABLE ALIGN="Center" WIDTH="100%" BORDER="1px" bordercolor="silver">
		<TR CLASS="Days" ALIGN="Center" HEIGHT="15">
			<TD WIDTH="106" bgcolor="c0c0c0"><font face="Verdana" size ="2">Sun.</font></TD>
			<TD WIDTH="106" bgcolor="c0c0c0"><font face="Verdana" size ="2">Mon.</font></TD>
			<TD WIDTH="106" bgcolor="c0c0c0"><font face="Verdana" size ="2">Tues.</font></TD>
			<TD WIDTH="106" bgcolor="c0c0c0"><font face="Verdana" size ="2">Wed.</font></TD>
			<TD WIDTH="106" bgcolor="c0c0c0"><font face="Verdana" size ="2">Thu.</font></TD>
			<TD WIDTH="106" bgcolor="c0c0c0"><font face="Verdana" size ="2">Fri.</font></TD>
			<TD WIDTH="106" bgcolor="c0c0c0"><font face="Verdana" size ="2">Sat.</font></TD>
		</TR>
	<!--- Starting Day of Month ---->
	<CFSET StartDay = DayOfWeek(CreateDate(form.select_year, form.select_month, 1))>
		
	<!--- Days in Month --->
	<CFSET DaysMonth = DaysInMonth(CreateDate(form.select_year, form.select_month, 1))>
		
	<CFSET DayNumbers = 1>
	<CFSET Counter = 1>
		
	<TR HEIGHT="85">
	<CFLOOP CONDITION = "DayNumbers EQ 1">
	
	<!--- <CFQUERY DATASOURCE="#application.speakerDSN#" NAME="getunavailable">
		SELECT *
		FROM SpeakerAvailable
		WHERE speakerid = #ModSpeakerID# 
			</CFQUERY>  --->
	
		<!--- ****** Set the color and funtionality of the square for the day. If
		square is part of last month, make it uneditable and gray  --->
		<CFIF StartDay EQ Counter>		
			
      <TD WIDTH="106" valign="top" align="left"> 
       <cfelse> 
      <TD WIDTH="106" STYLE="background-color: #EBEBEB; color: 000000; font-size: 10px; position: relative;"> </cfif>	
        <CFIF StartDay EQ Counter>
          <CFOUTPUT> <span style="position: absolute; top: 1; left: 2;"> 
          <cfquery name="indiv_schd" datasource="#application.speakerDSN#">
Select *
From SpeakerAvailable 
Where speakerid = '#ModSpeakerID#'  and
availfromdate = '#form.select_month#/#DayNumbers#/#form.select_year#' and
 availtodate = '#form.select_month#/#DayNumbers#/#form.select_year#'
Order by availfromtime asc
          </cfquery>
		 				<cfif indiv_schd.allday is 1>
<center><strong><font face="Verdana" size="9" color="red">X</font></strong><br><cfif #trim(indiv_schd.availtype)# is 'V'>Vacation <cfelse>NA</cfif></center>
<cfelse>	
	 <div class="daycontent2" id="daycontent_#DayNumbers#"><cfloop query="indiv_schd"><cfif indiv_schd.meetingcode is ''><font color = "red"></cfif>#TimeFormat(indiv_schd.availfromtime, "h:mm tt")# - #TimeFormat(indiv_schd.availtotime, "h:mm tt")#</font><br></cfloop></div> </cfif>		</CFOUTPUT> 
          <CFSET DayNumbers = 2>
          <CFELSE>
          &nbsp; </CFIF> &nbsp; </TD>
		<CFSET Counter = Counter + 1>
	</CFLOOP>
		
	<CFLOOP CONDITION = "DayNumbers EQ 1">

  
  
		<CFIF StartDay EQ Counter>		
			
      <TD WIDTH="106" valign="top" align="left">	  
       <cfelse> 	   
      <TD WIDTH="106" STYLE="background-color: #EBEBEB; color: 000000; font-size: 10px; position: relative;"> </cfif>	
          <CFOUTPUT> 
            <font face="Verdana" size ="2"><a href="">#DayNumbers#</a>.</font><br> 
     
      </CFOUTPUT>
	   <cfquery name="indiv_schd" datasource="#application.speakerDSN#">
Select *
From SpeakerAvailable 
Where speakerid = '#ModSpeakerID#'  and
availfromdate = '#form.select_month#/#DayNumbers#/#form.select_year#' and
 availtodate = '#form.select_month#/#DayNumbers#/#form.select_year#'
Order by availfromtime asc
          </cfquery>
		 
			<cfif indiv_schd.allday is 1>
<center><strong><font face="Verdana" size="9" color="red">X</font></strong><br><cfif #trim(indiv_schd.availtype)# is 'V'>Vacation <cfelse>NA</cfif></center>
<cfelse>	
	 <div class="daycontent2" id="daycontent_#DayNumbers#"><cfloop query="indiv_schd"><cfif indiv_schd.meetingcode is ''><font color = "red"></cfif>#TimeFormat(indiv_schd.availfromtime, "h:mm tt")# - #TimeFormat(indiv_schd.availtotime, "h:mm tt")#</font><br></cfloop></div> </cfif>		</TD>
		<CFSET Counter = Counter + 1>
	</CFLOOP>
		
	<CFLOOP CONDITION = "(DayNumbers LTE DaysMonth) OR  ((DayNumbers GT DaysMonth) AND ((Counter MOD 7) NEQ 1))">
	
	<CFIF DayNumbers LTE DaysMonth>	<!--- Create rows of boxes with the date numbers in them --->
		<CFIF (Counter MOD 7) EQ 1>	<!--- Start a new row --->
			</TR>
			<TR HEIGHT="85">
				
    <TD WIDTH="106" valign="top" align="left"> 
        <CFOUTPUT> 
            <font face="Verdana" size ="2">#DayNumbers#.</font><br> 
     
      </CFOUTPUT>
	   <cfoutput><cfquery name="indiv_schd" datasource="#application.speakerDSN#">
Select *
From SpeakerAvailable 
Where speakerid = '#ModSpeakerID#'  and
availfromdate = '#form.select_month#/#DayNumbers#/#form.select_year#' and
availtodate = '#form.select_month#/#DayNumbers#/#form.select_year#'
Order by availfromtime asc
          </cfquery>
				<cfif indiv_schd.allday is 1>
<center><strong><font face="Verdana" size="9" color="red">X</font></strong><br><cfif #trim(indiv_schd.availtype)# is 'V'><font face="Verdana" size="1">Vacation</font> <cfelse><font face="Verdana" size="1">NA</font></cfif></center>
<cfelse>	
	   <div class="daycontent2" id="daycontent_#DayNumbers#"><cfloop query="indiv_schd"><cfoutput>#TimeFormat(indiv_schd.availfromtime, "h:mm tt")# - #TimeFormat(indiv_schd.availtotime, "h:mm tt")#</font></cfoutput><br></cfloop></div></cfif>
   </cfoutput></TD>
		<CFELSE>	<!--- Finish current row --->
			
    <TD WIDTH="106" valign="top" align="left"> 
	
      <CFOUTPUT> 
            <font face="Verdana" size ="2">#DayNumbers#.</font><br> 
     
      </CFOUTPUT>
	   <cfquery name="indiv_schd" datasource="#application.speakerDSN#">
Select *
From SpeakerAvailable 
Where speakerid = '#ModSpeakerID#'  and
availfromdate = '#form.select_month#/#DayNumbers#/#form.select_year#' and
 availtodate = '#form.select_month#/#DayNumbers#/#form.select_year#'
Order by availfromtime asc
          </cfquery>
					<cfif indiv_schd.allday is 1>
<center><strong><font face="Verdana" size="9" color="red">X</font></strong><br><cfif #trim(indiv_schd.availtype)# is 'V'><font face="Verdana" size="1">Vacation</font> <cfelse><font face="Verdana" size="1">NA</font></cfif></center>
<cfelse>	
	   <div class="daycontent2" id="daycontent_#DayNumbers#"><cfloop query="indiv_schd"><cfoutput>#TimeFormat(indiv_schd.availfromtime, "h:mm tt")# - #TimeFormat(indiv_schd.availtotime, "h:mm tt")#</font></cfoutput><br></cfloop>
	  </div></cfif>
	  </TD>
		</CFIF>
		
	<CFELSEIF (DayNumbers GT DaysMonth) AND ((Counter MOD 7) NEQ 1)>	<!--- Complete current row of boxes before quitting --->
		<TD WIDTH="106" STYLE="background-color: #EBEBEB; color: 000000; font-size: 10px;">&nbsp;</TD>
	</CFIF>	<!--- Quit on a complete row of boxes --->
	
	<!--- Increment the counter and the day numberer variables --->
	<CFSET DayNumbers = DayNumbers + 1>
	<CFSET Counter = Counter + 1>
	
	</CFLOOP>
	
	</TABLE>
	
	<!--- Bottom Detail --->
	
	<!---
	
	<div class="HidePrintSpaces" id="PrintSpaces"><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><br><br></div>
	
	
	<table width="600" border="0" align="center" cellpadding="5" cellspacing="0">
		<TR> 
			<TD colspan="3" CLASS="tdheader"><strong>Unavailability Report Detail - <cfoutput>#getSpeakerModName.firstname# #getSpeakerModName.lastname#</cfoutput></strong></TD>
		</TR>
		<tr>
			<td style="border-left: solid 1px #336699; border-top: solid 1px #336699;" width="50"><strong>Day</strong></td>
			<td style="border-left: solid 1px #336699; border-top: solid 1px #336699;" width="150"><strong>Unavailable Times</strong></td>
			<td style="border-left: solid 1px #336699; border-right: solid 1px #336699; border-top: solid 1px #336699;" width="400"><strong>Comments</strong></td>
		</tr>
		<cfoutput query="getunavailable">
		<cfset udate = CreateDate(#getunavailable.year#, #getunavailable.month#, #getunavailable.day#)>
		<cfif #DayOfWeek(udate)# NEQ 1 AND #DayOfWeek(udate)# NEQ 6 AND #DayOfWeek(udate)# NEQ 7>
		<tr>
			<td style="border-left: solid 1px ##336699; border-top: solid 1px ##336699;">#month#/#day#/#year#</td>
			<td style="border-left: solid 1px ##336699; border-top: solid 1px ##336699;">
				<!---  --->
			</td>
			<td style="border-left: solid 1px ##336699; border-right: solid 1px ##336699; border-top: solid 1px ##336699;">
			<cfif getunavailable.comments EQ "">&nbsp;<cfelse>#comments#</cfif></td>
		</tr>
			</cfif>
		</cfoutput>
		<tr><td colspan="3" style="border-top: solid 1px #6699FF;">&nbsp;</td></tr>	
	</table>

<!--- </cfif> --->
<p><center><input type="button"  value=" Print Calendar " onclick="PerformPrint()" onmouseover="ShowReminder(1)" onmouseout="ShowReminder(2)"> &nbsp; &nbsp; &nbsp; &nbsp; <input type="button"  value=" Go Back " onclick="document.location.href='report_modspkr_calendar.cfm'"></center></p>
<center><span class="PrintReminderHide" id="PrintReminder">Change page layout to landscape before printing</span></center> 
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">--->
