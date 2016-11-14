 <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Dynamic Schedule</title>
	   		   	<script type="text/javascript">
function openpopup4(popurl){
var winpops=window.open(popurl,"","top=200,left=300,width=540,height=610,scrollbars=yes,resizable=yes")
}
</script> 
</head>

<body alink="#0000ff" link="#0000ff" vlink="#0000ff">
 
  <cfoutput>  
<cfparam name="url.startmonth" default="">
<cfparam name="url.startday" default="">
<cfparam name="url.startyear" default="">
<cfparam name="url.endmonth" default="">
<cfparam name="url.endday" default="">
<cfparam name="url.endyear" default="">
<cfparam name="url.startdate" default="">
<cfparam name="url.enddate" default="">
   
<cfif isDefined("Form.startmonth")>  
<cfset startmonth = '#Form.startmonth#'>
<cfelseif url.startdate is not ''>
<cfset startmonth = '#Left(url.startdate, 2)#'>
<cfelse>
<cfset startmonth = '#DateFormat(now(), "mm")#'>
</cfif>

<cfif isDefined("Form.startday")>  
<cfset startday = '#Form.startday#'>
<cfelseif url.startdate is not ''>
<cfset startday = '#Mid(url.startdate, 4,2)#'>
<cfelse>
<cfset startday = '#DateFormat(now(), "dd")#'>
</cfif>

<cfif isDefined("Form.startyear")>  
<cfset startyear = '#Form.startyear#'>
<cfelseif url.startdate is not ''>
<cfset startday = '#Right(url.startdate, 4)#'>
<cfelse>
<cfset startyear = '#DateFormat(now(), "yyyy")#'>
</cfif>


<cfif url.startdate is not ''>
<cfset startdate ='#url.startdate#'>
<cfelse>
<cfset startdate ='#startmonth# #startday# #startyear#'>
<cfset startdate = '#DateFormat(startdate, "mm/dd/yyyy")#'>
</cfif>


<cfif isDefined("Form.endmonth")>  
<cfset endmonth = '#Form.endmonth#'>
<cfelseif url.enddate is not ''>
<cfset endmonth = '#Left(url.enddate, 2)#'>
<cfelse>
<cfset endmonth = '#DateFormat(now(), "mm")#'>
</cfif>

<cfif isDefined("Form.endday")>  
<cfset endday = '#Form.endday#'>
<cfelseif url.enddate is not ''>
<cfset endday = '#Mid(url.enddate, 4,2)#'>
<cfelse>
<cfset endday = '#DateFormat(now(), "dd")#'>
<cfset nextweek = dateAdd('d', 7, endday)>
<cfset endday = '#DateFormat(nextweek, "dd")#'>
</cfif>

<cfif isDefined("Form.endyear")>  
<cfset endyear = '#Form.endyear#'>
<cfelseif url.enddate is not ''>
<cfset endyear = '#Right(url.enddate, 4)#'>
<cfelse>
<cfset endyear = '#DateFormat(now(), "yyyy")#'>
</cfif>

<cfif url.enddate is not ''>
<cfset enddate ='#url.enddate#'>
<cfelse>
<cfset enddate ='#endmonth# #endday# #endyear#'>
<cfset enddate = '#DateFormat(enddate, "mm/dd/yyyy")#'>
</cfif>

<cfset this_year = #DateFormat(now(), "yyyy")#>
<cfset next_year = #this_year# + 1> 

<cfif isDefined("url.projectfilter")>
<cfset form.projectfilter ='#url.projectfilter#'>
<cfelse>
<cfparam name="form.projectfilter" default="">
</cfif>

  <cfquery name="getblitz" datasource="CBARoster">
	     Select EventKey, EventDateTime, event_count, Event_max
		 From Meeting_counts_Blitz
		 Where EventKey != '' and
		 EventDateTime != 'EventDateTime' and
		 EventDateTime >= '#DateFormat(startdate, "mm/dd/yyyy")#' <!--- and
		 EventDateTime <= '#DateFormat(Enddate, "mm/dd/yyyy")#'		 ---> 
		 <cfif form.projectfilter is not ''>
		   AND Left(EventKey, 9) = '#Trim(form.projectfilter)#'</cfif>
		 Order By EventKey, EventDateTime
	  </cfquery>


  <cfquery name="getactiveProj" datasource="#application.projdsn#">
	     Select project_code, product 
		 From piw
		 Where project_status IN (2, 3)
		 Order By product asc
	  </cfquery>	

<CFSET projectlist = ValueList(getactiveProj.project_code)>
<CFSET productlist = ValueList(getactiveProj.product)>  
<a href="../live_to_grid.cfm?startdate=#startdate#&enddate=#enddate#&projectfilter=#form.projectfilter#"><u><i>Import Live Data into Pending Grid</i></u></a><br><br>
		
<!---<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Master Schedule-Day View" bodyPassthrough="onLoad='init()'" doAjax="True"> --->
	     
	  <table border="0" cellpadding="3" cellspacing="0" align="center" width="100%">
	 			   <tr><td valign="top"><font face="Tahoma" size ="2">
			 <cfform method="POST" action="index.cfm">
	    <strong>Filter by Project:</strong>
	    <select name="projectfilter">
		   <option value="">--ALL--</option>
		    <cfloop query="getactiveProj">
	        <option value="#getactiveProj.Project_Code#" <cfif isDefined("form.projectfilter")><cfif trim(form.projectfilter) EQ trim(getactiveProj.Project_Code)>Selected</cfif></cfif>>#product# #getactiveProj.Project_Code#</option>
		   </cfloop> 
	    </select>
			  
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			    
			   Start Date: <select name="startmonth">		
						<option value="01" <cfif startmonth is '01'>selected </cfif>>Jan</option>
						<option value="02" <cfif startmonth is '02'>selected </cfif>>Feb</option>
						<option value="03" <cfif startmonth is '03'>selected </cfif>>Mar</option>
						<option value="04" <cfif startmonth is '04'>selected </cfif>>Apr</option>	
						<option value="05" <cfif startmonth is '05'>selected </cfif>>May</option>	
						<option value="06" <cfif startmonth is '06'>selected </cfif>>Jun</option>	
						<option value="07" <cfif startmonth is '07'>selected </cfif>>Jul</option>	
						<option value="08" <cfif startmonth is '08'>selected </cfif>>Aug</option>	
						<option value="09" <cfif startmonth is '09'>selected </cfif>>Sep</option>	
						<option value="10" <cfif startmonth is '10'>selected </cfif>>Oct</option>	
						<option value="11" <cfif startmonth is '11'>selected </cfif>>Nov</option>
						<option value="12" <cfif startmonth is '12'>selected </cfif>>Dec</option>								
										</select>/
<select name="startday">		
						<option value="01" <cfif startday is 01>selected </cfif>>01</option>
						<option value="02" <cfif startday is 02>selected </cfif>>02</option>
						<option value="03" <cfif startday is 03>selected </cfif>>03</option>
						<option value="04" <cfif startday is 04>selected </cfif>>04</option>	
						<option value="05" <cfif startday is 05>selected </cfif>>05</option>	
						<option value="06" <cfif startday is 06>selected </cfif>>06</option>	
						<option value="07" <cfif startday is 07>selected </cfif>>07</option>	
						<option value="08" <cfif startday is 08>selected </cfif>>08</option>	
						<option value="09" <cfif startday is 09>selected </cfif>>09</option>	
						<option value="10" <cfif startday is 10>selected </cfif>>10</option>	
						<option value="11" <cfif startday is 11>selected </cfif>>11</option>
						<option value="12" <cfif startday is 12>selected </cfif>>12</option>	
						<option value="13" <cfif startday is 13>selected </cfif>>13</option>
						<option value="14" <cfif startday is 14>selected </cfif>>14</option>
						<option value="15" <cfif startday is 15>selected </cfif>>15</option>
						<option value="16" <cfif startday is 16>selected </cfif>>16</option>	
						<option value="17" <cfif startday is 17>selected </cfif>>17</option>	
						<option value="18" <cfif startday is 18>selected </cfif>>18</option>	
						<option value="19" <cfif startday is 19>selected </cfif>>19</option>	
						<option value="20" <cfif startday is 20>selected </cfif>>20</option>	
						<option value="21" <cfif startday is 21>selected </cfif>>21</option>	
						<option value="22" <cfif startday is 22>selected </cfif>>22</option>	
						<option value="23" <cfif startday is 23>selected </cfif>>23</option>
						<option value="24" <cfif startday is 24>selected </cfif>>24</option>	
						<option value="25" <cfif startday is 25>selected </cfif>>25</option>	
						<option value="26" <cfif startday is 26>selected </cfif>>26</option>	
						<option value="27" <cfif startday is 27>selected </cfif>>27</option>	
						<option value="28" <cfif startday is 28>selected </cfif>>28</option>	
						<option value="29" <cfif startday is 29>selected </cfif>>29</option>	
						<option value="30" <cfif startday is 30>selected </cfif>>30</option>	
						<option value="31" <cfif startday is 31>selected </cfif>>31</option>
						<option value="32" <cfif startday is 32>selected </cfif>>32</option></select>/
								
<select name="startyear">		
						<option value="#this_year#">#this_year#</option>
						<option value="#next_year#">#next_year#</option></select> 
						
						&nbsp;&nbsp;&nbsp;&nbsp;
						
						End Date: <select name="endmonth">		
						<option value="01" <cfif endmonth is '01'>selected </cfif>>Jan</option>
						<option value="02" <cfif endmonth is '02'>selected </cfif>>Feb</option>
						<option value="03" <cfif endmonth is '03'>selected </cfif>>Mar</option>
						<option value="04" <cfif endmonth is '04'>selected </cfif>>Apr</option>	
						<option value="05" <cfif endmonth is '05'>selected </cfif>>May</option>	
						<option value="06" <cfif endmonth is '06'>selected </cfif>>Jun</option>	
						<option value="07" <cfif endmonth is '07'>selected </cfif>>Jul</option>	
						<option value="08" <cfif endmonth is '08'>selected </cfif>>Aug</option>	
						<option value="09" <cfif endmonth is '09'>selected </cfif>>Sep</option>	
						<option value="10" <cfif endmonth is '10'>selected </cfif>>Oct</option>	
						<option value="11" <cfif endmonth is '11'>selected </cfif>>Nov</option>
						<option value="12" <cfif endmonth is '12'>selected </cfif>>Dec</option>							
										</select>/
                        <select name="endday">		
						<option value="01" <cfif endday is 01>selected </cfif>>01</option>
						<option value="02" <cfif endday is 02>selected </cfif>>02</option>
						<option value="03" <cfif endday is 03>selected </cfif>>03</option>
						<option value="04" <cfif endday is 04>selected </cfif>>04</option>	
						<option value="05" <cfif endday is 05>selected </cfif>>05</option>	
						<option value="06" <cfif endday is 06>selected </cfif>>06</option>	
						<option value="07" <cfif endday is 07>selected </cfif>>07</option>	
						<option value="08" <cfif endday is 08>selected </cfif>>08</option>	
						<option value="09" <cfif endday is 09>selected </cfif>>09</option>	
						<option value="10" <cfif endday is 10>selected </cfif>>10</option>	
						<option value="11" <cfif endday is 11>selected </cfif>>11</option>
						<option value="12" <cfif endday is 12>selected </cfif>>12</option>	
						<option value="13" <cfif endday is 13>selected </cfif>>13</option>
						<option value="14" <cfif endday is 14>selected </cfif>>14</option>
						<option value="15" <cfif endday is 15>selected </cfif>>15</option>
						<option value="16" <cfif endday is 16>selected </cfif>>16</option>	
						<option value="17" <cfif endday is 17>selected </cfif>>17</option>	
						<option value="18" <cfif endday is 18>selected </cfif>>18</option>	
						<option value="19" <cfif endday is 19>selected </cfif>>19</option>	
						<option value="20" <cfif endday is 20>selected </cfif>>20</option>	
						<option value="21" <cfif endday is 21>selected </cfif>>21</option>	
						<option value="22" <cfif endday is 22>selected </cfif>>22</option>	
						<option value="23" <cfif endday is 23>selected </cfif>>23</option>
						<option value="24" <cfif endday is 24>selected </cfif>>24</option>	
						<option value="25" <cfif endday is 25>selected </cfif>>25</option>	
						<option value="26" <cfif endday is 26>selected </cfif>>26</option>	
						<option value="27" <cfif endday is 27>selected </cfif>>27</option>	
						<option value="28" <cfif endday is 28>selected </cfif>>28</option>	
						<option value="29" <cfif endday is 29>selected </cfif>>29</option>	
						<option value="30" <cfif endday is 30>selected </cfif>>30</option>	
						<option value="31" <cfif endday is 31>selected </cfif>>31</option>
						<option value="32" <cfif endday is 32>selected </cfif>>32</option>></select>/
								
<select name="endyear">		
						<option value="#this_year#">#this_year#</option>
						<option value="#next_year#">#next_year#</option></select>  
						 </td><td valign="top" align="left" nowrap><font face="Tahoma" size ="2">
						
						
						<input type="submit" name="Submit" value="Submit Filter"></cfform>
			    </font></td></tr>
			   <tr><td>
					   <tr>
		       <td valign="top" colspan="2">					      
	 <cfquery name="project" datasource="#application.projdsn#">
	   Select Distinct 
	   Project, 
	   MeetingCode, 
	   Time, 
	   Left(Date, 11) as Date, 
	   Right(Time, 8) as tt, 
	   Speaker1FirstName + ' ' + Speaker1LastName as Speaker1,
	   Speaker2FirstName + ' ' + Speaker2LastName as Speaker2,
	   Moderator1FirstName + ' ' + Moderator1LastName as Moderator1,
	   Moderator2FirstName + ' ' + Moderator2LastName as Moderator2,	 
	   RowID 
	   From Schedule
		   Where 
		   Date >= '#DateFormat(startdate, "mm/dd/yyyy")#'   and 
		   Date <= '#DateFormat(Enddate, "mm/dd/yyyy")#' <cfif form.projectfilter is not ''>
		   AND MeetingCode = '#form.projectfilter#'</cfif> 
		  Order By Date, Time
	  </cfquery>
	  
	  
<cfquery name="spkrs1" datasource="#application.speakerDSN#">
Select Distinct
sp.firstname + ' ' + sp.lastname as name, firstname

From Speaker sp<cfif form.projectfilter is not ''>, 
SpeakerClients sc</cfif> 
Where 
<cfif form.projectfilter is not ''>sc.ClientCode = '#Left(form.projectfilter, 5)#' and
sc.SpeakerId = sp.speakerid and</cfif>
sp.type = 'SPKR' and 
sp.active = 'yes' 		  
Order by firstname
          </cfquery> 
<cfset speakername = ValueList(spkrs1.name)>

<cfquery name="mods1" datasource="#application.speakerDSN#">
Select Distinct 
sp.firstname + ' ' + sp.lastname as modname, firstname

From Speaker sp<cfif form.projectfilter is not ''>, 
SpeakerClients sc</cfif> 
Where 
<cfif form.projectfilter is not ''>sc.ClientCode = '#Left(form.projectfilter, 5)#' and
sc.SpeakerId = sp.speakerid and</cfif>
sp.type = 'MOD' and 
sp.active = 'yes' 		  
Order by firstname
          </cfquery> 
<CFSET modname = ValueList(mods1.modname)>	

 
<cfform action="grid_process.cfm" method="POST"> 

<cfgrid name="Schedule"
        height="400"
        width="100%"
        query="project"
        insert="Yes"
        delete="Yes"
        sort="Yes"
        font="Tahoma"
        fontsize="10"
        bold="No"
        italic="No"
        autowidth="true"
        appendkey="No"
        highlighthref="No"
        griddataalign="CENTER"
        gridlines="Yes"
        rowheaders="Yes"
        rowheaderalign="LEFT"
        rowheaderitalic="No"
        rowheaderbold="No"
        colheaders="Yes"
        colheaderalign="LEFT"
        colheaderitalic="No"
        colheaderbold="No"
        selectcolor="FFFF00"
        selectmode="EDIT"
        picturebar="No"
        insertbutton="Insert Row"
        deletebutton="Delete Row"
        sortascendingbutton="Sort ASC"
        sortdescendingbutton="Sort DESC">
    <cfgridcolumn name="Project"
        header="Project"
        headeralign="LEFT"
        dataalign="LEFT"
        font="Tahoma"
        fontsize="10"
        bold="No"
        italic="No"
        select="Yes"
        display="Yes"
        headerbold="Yes"
        headeritalic="No"
		values="NULL, #productlist#"
        valuesdelimiter=",">
    <cfgridcolumn name="MeetingCode"
        header="MeetingCode"
        headeralign="LEFT"
        dataalign="LEFT"
        font="Tahoma"
        fontsize="10"
        bold="No"
        italic="No"
        select="Yes"
        display="Yes"
        headerbold="Yes"
        headeritalic="No"
        values="NULL, #projectlist#"
        valuesdelimiter=",">
    <CFGRIDCOLUMN NAME="Date" HEADER="Date"
       headeralign="LEFT"
        dataalign="LEFT"
        font="Tahoma"
        fontsize="10"
        bold="No"
        italic="No"
        select="Yes"
        display="Yes"
        headerbold="Yes"
        headeritalic="No">
    <cfgridcolumn name="tt" header="Time"
        headeralign="LEFT"
        dataalign="LEFT"
        font="Tahoma"
        fontsize="10"
        bold="No"
        italic="No"
        select="Yes"
        display="Yes"
        headerbold="Yes"
        headeritalic="No">			  
    <CFGRIDCOLUMN NAME="Speaker1" HEADER="Speaker 1" 
        headeralign="LEFT"
        dataalign="LEFT"
        font="Tahoma"
        fontsize="10"
        bold="No"
        italic="No"
        select="Yes"
        display="Yes"
        headerbold="Yes"		
        headeritalic="No"
		values="NULL, #speakername#"
        valuesdelimiter=",">	
	<!--- <CFGRIDCOLUMN NAME="Speaker1LastName" HEADER="Sp1LastName"
      headeralign="LEFT"
        dataalign="LEFT"
        font="Tahoma"
        fontsize="10"
        bold="No"
        italic="No"
        select="Yes"
        display="Yes"
        headerbold="Yes"
        headeritalic="No"
		values="NULL, #spkrlistlastname#"
        valuesdelimiter=",">	 --->
	<CFGRIDCOLUMN NAME="Speaker2" HEADER="Speaker 2"
        headeralign="LEFT"
        dataalign="LEFT"
        font="Tahoma"
        fontsize="10"
        bold="No"
        italic="No"
        select="Yes"
        display="Yes"
        headerbold="Yes"
        headeritalic="No"
		values="NULL, #speakername#"
        valuesdelimiter=",">	
	<!--- <CFGRIDCOLUMN NAME="Speaker2LastName" HEADER="Sp2LastName"
       headeralign="LEFT"
        dataalign="LEFT"
        font="Tahoma"
        fontsize="10"
        bold="No"
        italic="No"
        select="Yes"
        display="Yes"
        headerbold="Yes"
        headeritalic="No"
		values="NULL, #spkrlistlastname#"
        valuesdelimiter=",">	 --->
	<cfgridcolumn name="Moderator1"
        header="Moderator 1"
        headeralign="LEFT"
        dataalign="LEFT"
        font="Tahoma"
        fontsize="10"
        bold="No"
        italic="No"
        select="Yes"
        display="Yes"
        headerbold="Yes"
        headeritalic="No"
        values="NULL, #modname#"
        valuesdelimiter=",">
	<!--- <CFGRIDCOLUMN NAME="Moderator1LastName" HEADER="Mod1LastName"
       headeralign="LEFT"
        dataalign="LEFT"
        font="Tahoma"
        fontsize="10"
        bold="No"
        italic="No"
        select="Yes"
        display="Yes"
        headerbold="Yes"
        headeritalic="No"
		values="NULL, #modlistlastname#"
        valuesdelimiter=","> --->
	<CFGRIDCOLUMN NAME="Moderator2" HEADER="Moderator 2"
        headeralign="LEFT"
        dataalign="LEFT"
        font="Tahoma"
        fontsize="10"
        bold="No"
        italic="No"
        select="Yes"
        display="Yes"
        headerbold="Yes"
        headeritalic="No"
		values="NULL, #modname#"
        valuesdelimiter=",">
	<!--- <CFGRIDCOLUMN NAME="Moderator2LastName" HEADER="Mod2LastName"
      headeralign="LEFT"
        dataalign="LEFT"
        font="Tahoma"
        fontsize="10"
        bold="No"
        italic="No"
        select="Yes"
        display="Yes"
        headerbold="Yes"
        headeritalic="No"
		values="NULL, #modlistlastname#"
        valuesdelimiter=","> --->
	<CFGRIDCOLUMN NAME="RowID" HEADER="RowID"
      		DISPLAY="No">

</CFGRID>  
</td>
</tr>

<tr><td align="right" colspan="2">
<input type ="hidden" name = "startdate" value="#startdate#">
<input type ="hidden" name = "enddate" value="#Enddate#">
<!--- <input type ="hidden" name = "Time" value="#project.Time#"> --->
<input type ="hidden" name = "projectfilter" value="#form.projectfilter#">
		 
<input type="submit" name="Submit" value="Submit Data">&nbsp;&nbsp;<input type="reset" name="Reset" value="Reset">
 </cfform> 
</td></tr>
<tr>
<td align="center">

  <table border="1" cellpadding="3" cellspacing="0" align="left" width ="50%">
	 			   <tr><td valign="top" bgcolor="silver"><font face="Tahoma" size ="1">
<strong>Guide Writers</strong></font></td><td valign="top" bgcolor="silver"><font face="Tahoma" size ="1"><strong>Fee For Service</strong></font></td><td valign="top" bgcolor="silver"><font face="Tahoma" size ="1"><strong>Independent</strong></font></td></tr>
<tr>
<td valign="top" align="left">
<cfquery name="getmodsgw" datasource="#application.speakerDSN#">
	     Select firstname, lastname, speakerid 
		 From Speaker
		 Where Salery = 'GW'
		 Order By firstname
	  </cfquery>
	  
  <table border="0" cellpadding="3" cellspacing="0" align="left">
  <cfloop query="getmodsgw">
  <tr><td valign="top"><font face="Tahoma" size ="1"> 
  <a href="javascript:openpopup4('http://pms.pharmakonllc.com/schedule/indiv_sched.cfm?speakerid=#speakerid#')"><u>
#getmodsgw.firstname# #getmodsgw.lastname#</u></a><br></font></td>
<td valign="top">
 <cfquery name="numbers1" datasource="#application.projdsn#">
	     Select RowID
		 From Schedule		 
	     Where 
		 Date between '#startdate#' and '#Enddate#' and
		 (Moderator1LastName = '#getmodsgw.lastname#' or Moderator2LastName = '#getmodsgw.lastname#') 
		  <cfif form.projectfilter is not ''>and MeetingCode = '#form.projectfilter#'</cfif>
		   		 	  </cfquery>
<font face="Tahoma" size ="1" color="maroon"><strong>#numbers1.recordcount#</strong></td></tr>
</cfloop></table>

</td>
<td valign="top" align="left">  
  <cfquery name="getmodsffs" datasource="#application.speakerDSN#">
	     Select firstname, lastname, speakerid  
		 From Speaker
		 Where Salery = 'FFS'
		 Order By firstname
	  </cfquery>

 <table border="0" cellpadding="3" cellspacing="0">
  <cfloop query="getmodsffs">
  <tr><td valign="top"><font face="Tahoma" size ="1">  
 <a href="javascript:openpopup4('http://pms.pharmakonllc.com/schedule/indiv_sched.cfm?speakerid=#speakerid#')"><u>#getmodsffs.firstname# #getmodsffs.lastname#</u></a><br></font></td>
<td valign="top" nowrap>
 <cfquery name="numbers2" datasource="#application.projdsn#">
	    Select RowID
		 From Schedule
		Where 
		Date between '#startdate#' and '#Enddate#' and
		 (Moderator1LastName = '#getmodsffs.lastname#' or Moderator2LastName = '#getmodsffs.lastname#') 	 	
		 <cfif form.projectfilter is not ''>and MeetingCode = '#form.projectfilter#'</cfif>    
		     	  </cfquery>
<font face="Tahoma" size ="1" color="navy"><strong>#numbers2.recordcount#</strong></td></tr>
</cfloop></table>

</td>
<td valign="top" align="left">
  <cfquery name="getmodsinde" datasource="#application.speakerDSN#">
	     Select firstname, lastname, speakerid  
		 From Speaker
		 Where Salery = 'Inde'
		 Order By firstname
	  </cfquery>
<table border="0" cellpadding="3" cellspacing="0" align="left">
  <cfloop query="getmodsinde">
  <tr><td valign="top"><font face="Tahoma" size ="1">  
 <a href="javascript:openpopup4('http://pms.pharmakonllc.com/schedule/indiv_sched.cfm?speakerid=#speakerid#')"><u>#getmodsinde.firstname# #getmodsinde.lastname#</u></a><br></font></td>
<td valign="top">
 <cfquery name="numbers3" datasource="#application.projdsn#">
	   	     Select RowID
		 From Schedule
		 Where 
		 Date between '#startdate#' and '#Enddate#' and
		 (Moderator1LastName = '#getmodsinde.lastname#' or Moderator2LastName = '#getmodsinde.lastname#')
		 <cfif form.projectfilter is not ''>and MeetingCode = '#form.projectfilter#'</cfif>    
		 	  </cfquery>
<font face="Tahoma" size ="1"><strong>#numbers3.recordcount#</strong></td></tr>
</cfloop></table>
</td>
</tr>
</table>


 <table border="0" cellpadding="0" cellspacing="0" width="500">
    <tr>
  <td valign="middle" bgcolor="silver" width="125" height="20"><font face="Tahoma" size ="1">&nbsp;<strong>MeetingCode</strong></font></td>
    <td valign="middle" bgcolor="silver" width="125"><font face="Tahoma" size ="1"><strong>Date / Time</strong></font></td>
	  <td valign="middle" bgcolor="silver" width="125"><font face="Tahoma" size ="1"><strong>Event Count</strong></font></td>
	    <td valign="middle" bgcolor="silver" width="125"><font face="Tahoma" size ="1"><strong>Event Max</strong></font></td>
 </tr>
  <tr>
  <td valign="top" colspan="4">
<div id=scrollanle style="overflow: auto; height: 152;">

 <table border="1" cellpadding="3" cellspacing="0" width="500">
  <cfloop query="getblitz">
  <!--- <cfif getblitz.col012 is not 'EventDateTime'>
 <cfif #DateFormat(Left(getblitz.col012, 9), "m/d/yyyy")# gte #DateFormat(startdate, "m/d/yyyy")#> --->
    <tr>  
  <td valign="top" width="125"><font face="Tahoma" size ="1">#Left(getblitz.EventKey, 9)#</font></td>
  <td valign="top" width="125"><font face="Tahoma" size ="1">#getblitz.EventDateTime#</font></td>
  <td valign="top" width="125"><font face="Tahoma" size ="1">#getblitz.event_count#</font></td>
  <td valign="top" width="125"><font face="Tahoma" size ="1">#getblitz.Event_max#</font></td>      
  </tr><!--- </cfif></cfif> --->
  </cfloop>
      </table>
	 </div> 
 </td>
        </tr>
      </table>

	     </td>
        </tr>
      </table>
	    </cfoutput>     
		</body>
</html>