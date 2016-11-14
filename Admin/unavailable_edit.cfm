
<cfsilent>
<cfparam name="url.month" default="#month(now())#" type="numeric">
<cfparam name="url.year" default="#year(now())#" type="numeric">


<cfif isDefined("url.id")>
<cfset client.avail_speakerid = '#url.id#'>
<cfelse>
<cfset client.avail_speakerid = '#form.speakerid#'>
</cfif>

<cfquery name="current_spkr" datasource="#application.speakerDSN#">
	       Select
		  sp.speakerid, 
		  sp.firstname, 
		  sp.lastname
		   From 
		  Speaker sp		  
		  Where 		 	
		  sp.speakerid = '#client.avail_speakerid#' 
</cfquery>

<cfset month = url.month>
<cfset year = url.year>

<cfset firstDay = createDate(year,month,1)>
<cfset firstDOW = dayOfWeek(firstDay)>
<cfset dim = daysInMonth(firstDay)>

<cfset lastMonth = dateAdd("m",-1,firstDay)>
<cfset nextMonth = dateAdd("m",1,firstDay)>

<cfif month(now()) EQ month>
  <cfset IsCurrentMonth = true>
<cfelse>
  <cfset IsCurrentMonth = false>  
</cfif> 
</cfsilent>

<cfset startmonth = '#DateFormat(now(), "m")#'>
<cfset startday = '#DateFormat(now(), "d")#'>
<cfset startyear = '#DateFormat(now(), "yyyy")#'>
<cfset endmonth = '#DateFormat(now(), "m")#'>
<cfset endday = '#DateFormat(now(), "d")#'>
<cfset endyear = '#DateFormat(now(), "yyyy")#'>
<cfset this_year = #DateFormat(now(), "yyyy")#>
<cfset next_year = #this_year# + 1> 


	 <link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Unavailable Admin Edit for #current_spkr.firstname# #current_spkr.lastname#" bodyPassthrough="" doAjax="True">
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
<br>
<cfoutput><table border="0" cellpadding="0" cellspacing="0" width="100%">
		        <tr>
		           <td align="left" valign="top"><cfform action="unavailable_edit_process.cfm" method="POST">
<font face="Verdana" size ="1"><strong>Block Out Full Days</strong>
<br><br>

      
        

From: <select name="startmonth">		
						<option value="1" <cfif startmonth is '1'>selected </cfif>>Jan</option>
						<option value="2" <cfif startmonth is '2'>selected </cfif>>Feb</option>
						<option value="3" <cfif startmonth is '3'>selected </cfif>>Mar</option>
						<option value="4" <cfif startmonth is '4'>selected </cfif>>Apr</option>	
						<option value="5" <cfif startmonth is '5'>selected </cfif>>May</option>	
						<option value="6" <cfif startmonth is '6'>selected </cfif>>Jun</option>	
						<option value="7" <cfif startmonth is '7'>selected </cfif>>Jul</option>	
						<option value="8" <cfif startmonth is '8'>selected </cfif>>Aug</option>	
						<option value="9" <cfif startmonth is '9'>selected </cfif>>Sep</option>	
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
						
						<br><br>
						
						To: &nbsp;&nbsp;&nbsp;&nbsp;<select name="endmonth">		
							<option value="1" <cfif startmonth is '1'>selected </cfif>>Jan</option>
						<option value="2" <cfif startmonth is '2'>selected </cfif>>Feb</option>
						<option value="3" <cfif startmonth is '3'>selected </cfif>>Mar</option>
						<option value="4" <cfif startmonth is '4'>selected </cfif>>Apr</option>	
						<option value="5" <cfif startmonth is '5'>selected </cfif>>May</option>	
						<option value="6" <cfif startmonth is '6'>selected </cfif>>Jun</option>	
						<option value="7" <cfif startmonth is '7'>selected </cfif>>Jul</option>	
						<option value="8" <cfif startmonth is '8'>selected </cfif>>Aug</option>	
						<option value="9" <cfif startmonth is '9'>selected </cfif>>Sep</option>	
						<option value="10" <cfif startmonth is '10'>selected </cfif>>Oct</option>	
						<option value="11" <cfif startmonth is '11'>selected </cfif>>Nov</option>
						<option value="12" <cfif startmonth is '12'>selected </cfif>>Dec</option>									
										</select>/
                        <select name="endday">		
					    <option value="01" <cfif endday is 1>selected </cfif>>01</option>
						<option value="02" <cfif endday is 2>selected </cfif>>02</option>
						<option value="03" <cfif endday is 3>selected </cfif>>03</option>
						<option value="04" <cfif endday is 4>selected </cfif>>04</option>	
						<option value="05" <cfif endday is 5>selected </cfif>>05</option>	
						<option value="06" <cfif endday is 6>selected </cfif>>06</option>	
						<option value="07" <cfif endday is 7>selected </cfif>>07</option>	
						<option value="08" <cfif endday is 8>selected </cfif>>08</option>	
						<option value="09" <cfif endday is 9>selected </cfif>>09</option>	
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
						<input type = "hidden" name = "days" value="days">
						<input type = "hidden" name = "speakerid" value="#client.avail_speakerid#">		
						<br>
						
						Unavailibility Type: &nbsp;&nbsp;&nbsp;<select name="type">		
						<option value="NA">NA</option>
						<option value="V">Vacation</option></select>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="Submit" value="Submit"></cfform><br>
						
						<b>To Free blocked time, <a href="available.cfm?id=#client.avail_speakerid#"><u>click here</u></b></a>.</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="black.gif" alt="" width="10" height="10" border="0">= Meeting&nbsp;&nbsp;&nbsp;&nbsp;<img src="red.gif" alt="" width="10" height="10" border="0">= Other  
</td>
<td valign="top" align="left"><cfform action="unavailable_edit_process.cfm" method="POST">
<font face="Verdana" size ="1"><strong>Block Out Time for a Day</strong>.</font><br><br>

<input type = "hidden" name = "speakerid" value="#client.avail_speakerid#">
<input type = "hidden" name = "time" value="time">		
On: &nbsp;&nbsp;&nbsp;<select name="startmonth2">		
							<option value="1" <cfif startmonth is '1'>selected </cfif>>Jan</option>
						<option value="2" <cfif startmonth is '2'>selected </cfif>>Feb</option>
						<option value="3" <cfif startmonth is '3'>selected </cfif>>Mar</option>
						<option value="4" <cfif startmonth is '4'>selected </cfif>>Apr</option>	
						<option value="5" <cfif startmonth is '5'>selected </cfif>>May</option>	
						<option value="6" <cfif startmonth is '6'>selected </cfif>>Jun</option>	
						<option value="7" <cfif startmonth is '7'>selected </cfif>>Jul</option>	
						<option value="8" <cfif startmonth is '8'>selected </cfif>>Aug</option>	
						<option value="9" <cfif startmonth is '9'>selected </cfif>>Sep</option>	
						<option value="10" <cfif startmonth is '10'>selected </cfif>>Oct</option>	
						<option value="11" <cfif startmonth is '11'>selected </cfif>>Nov</option>
						<option value="12" <cfif startmonth is '12'>selected </cfif>>Dec</option>									
										</select>/
<select name="startday2">		
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
<select name="startyear2">		
						<option value="#this_year#">#this_year#</option>
						<option value="#next_year#">#next_year#</option></select> 
						<br><br>

From: <select name="starthour">		
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>	
						<option value="4">4</option>	
						<option value="5">5</option>	
						<option value="6">6</option>	
						<option value="7">7</option>	
						<option value="8" selected>8</option>	
						<option value="9">9</option>	
						<option value="10">10</option>
						<option value="11">11</option>	
						<option value="12">12</option>							
										</select>:
                        <select name="startminute">		
						<option value="00">00</option>
						<option value="15">15</option>
						<option value="30">30</option>	
						<option value="45">45</option>	
										</select>
						<select name="startam">		
						<option value="AM">AM</option>
						<option value="PM" selected>PM</option>
											
										</select>
										<br><br>
To: &nbsp;&nbsp;&nbsp;&nbsp;<select name="tohour">		
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>	
						<option value="4">4</option>	
						<option value="5">5</option>	
						<option value="6">6</option>	
						<option value="7">7</option>	
						<option value="8" selected>8</option>	
						<option value="9">9</option>	
						<option value="10">10</option>
						<option value="11">11</option>	
						<option value="12">12</option>							
										</select>:
                        <select name="tominute">		
						<option value="00">00</option>
						<option value="15">15</option>
						<option value="30">30</option>	
						<option value="45">45</option>	
										</select>
						<select name="toam">		
						<option value="AM">AM</option>
						<option value="PM" selected>PM</option>
											
										</select>										
										<br><br>
						
						Unavailibility Type: &nbsp;&nbsp;&nbsp;<select name="type">		
						<option value="NA">NA</option>
						<option value="V">Vacation</option></select>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="Submit" value="Submit"></cfform>

</td>
</tr></table></cfoutput>


<br><br><cfoutput>
<cfif isDefined("url.conflict") and url.message is 'day'><center>
* <font face="Verdana" size="2" color="red">
You can not Block out #url.meetingdate#, for #current_spkr.firstname# #current_spkr.lastname#. #current_spkr.firstname# currently has a meeting scheduled on #url.meetingdate#. Please remove the meeting before blocking out the day.

<br><br></center>

<cfelseif isDefined("url.conflict") and url.message is 'time'>
* <font face="Verdana" size="2" color="red">
You can not Block out #url.starttime# to #url.endtime# on #url.meetingdate#, for #current_spkr.firstname# #current_spkr.lastname#. #current_spkr.firstname# currently has a meeting scheduled on #url.meetingdate# at that time. Please remove the meeting before blocking out the day.

<br><br></center></cfif></cfoutput>



	    <cfoutput> <center><table border="0" cellpadding="0" cellspacing="0">
		        <tr>
		           <td align="center" class="calmonth"><a href="unavailable_edit.cfm?month=#month(lastmonth)#&year=#year(lastmonth)#&id=#client.avail_speakerid#"><img src="/Images/arrow_L.gif" width="10" height="10" alt="" border="0"></a>&nbsp;&nbsp;#monthAsString(month)# #year#&nbsp;&nbsp;<a href="unavailable_edit.cfm?month=#month(nextmonth)#&year=#year(nextmonth)#&id=#client.avail_speakerid#"><img src="/Images/arrow_r.gif" width="10" height="10" alt="" border="0"></a></td>
		       </tr>
		   </table> </center></cfoutput>  
		   <br>
		   
		   

	<div id="maincalendar" class="maincalendar">
	   <cfset dayCounter = 1>
		<cfoutput>
		
		<center>
		<table border=0 class="calendar_table" align="center">
		<tr>
		  <td class="caldayofweek">Sun</td>
		  <td class="caldayofweek">Mon</td>
		  <td class="caldayofweek">Tue</td>
		  <td class="caldayofweek">Wed</td>
		  <td class="caldayofweek">Thu</td>
		  <td class="caldayofweek">Fri</td>
		  <td class="caldayofweek">Sat</td>
		</tr>
		</cfoutput>
		<!--- loop until 1st --->
		<cfoutput><tr></cfoutput>
		
		
		<cfloop index="x" from=1 to="#firstDOW-1#">
			<cfoutput>			
			<td class="blankcell">&nbsp;</td></cfoutput>
		</cfloop>				
		
		 <cfloop index="x" from="#firstDOW#" to="7">
	 <cfoutput>	 	 
		<td <cfif month(now()) EQ month>
			                    <cfif daycounter EQ day(now())>
								   class="caltoday"
								<cfelse>
								   class="calday"
								</cfif>
						  <cfelse>
						     class="calday"
						  </cfif> 
						  id="calcell_#dayCounter#" 
						  valign="top" align="left">
						   <table border="0" cellpadding="0" cellspacing="0">
		        <tr>
				
		           <td align="left" valign ="top">
						#dayCounter#.&nbsp;</td></tr></table><br>
						<!--- Unavailable Info --->
				
<cfquery name="unavail_time1" datasource="#application.speakerDSN#">
Select *
From SpeakerAvailable 
Where speakerid = '#client.avail_speakerid#'  and
availfromdate = '#month#/#dayCounter#/#year#' and 
 availtodate = '#month#/#dayCounter#/#year#'
Order by availfromtime asc
</cfquery>
	<cfif unavail_time1.allday is 1>
<center><strong><font face="Verdana" size="9" color="red">X</font></strong><br><cfif #trim(unavail_time1.availtype)# is 'V'>Vacation <cfelse>NA</cfif></center>
<cfelse>
	 <div class="daycontent2" id="daycontent_#dayCounter#"><cfloop query="unavail_time1"><cfif unavail_time1.meetingcode is ''><font color = "red"></cfif>#TimeFormat(unavail_time1.availfromtime, "h:mm tt")# - #TimeFormat(unavail_time1.availtotime, "h:mm tt")#</font><br></cfloop></div> </cfif>					
					   </td>
					   </cfoutput>
			<cfset dayCounter = dayCounter + 1>
		</cfloop>	
		</tr>
		<!--- now loop until month days --->
		<cfset rowCounter = 1>
		
		<cfloop index="x" from="#dayCounter#" to="#dim#">
			<cfif rowCounter is 1>
				<cfoutput><tr></cfoutput>
			</cfif> 
			<cfoutput>
				<td 
<cfif month(now()) EQ month>
<cfif x EQ day(now())>class="caltoday"

<cfelse>class="calday"</cfif>

<cfelse>class="calday"</cfif> id="calcell_#x#" valign="top" align="left">

<table border="0" cellpadding="0" cellspacing="0">
		        <tr>
						           <td align="left" valign ="top">
				   

<cfif Len(#x#) LT 2>#x#.&nbsp;<cfelse>#x#.</cfif></td>
<td align="left" valign ="top"></tr></table>

<cfquery name="unavail_time2" datasource="#application.speakerDSN#">
Select *
From SpeakerAvailable 
Where speakerid = '#client.avail_speakerid#' and
availfromdate = '#month#/#x#/#year#'  and
 availtodate = '#month#/#x#/#year#'
Order by availfromtime asc
</cfquery>
<cfif unavail_time2.allday is 1>
<center><strong><font face="Verdana" size="9" color="red">X</font></strong><br><cfif #trim(unavail_time2.availtype)# is 'V'>Vacation <cfelse>NA</cfif></center>
<cfelse>	
	 <div class="daycontent2" id="daycontent_#dayCounter#"><cfloop query="unavail_time2"><cfif unavail_time2.meetingcode is ''><font color = "red"></cfif>#TimeFormat(unavail_time2.availfromtime, "h:mm tt")# - #TimeFormat(unavail_time2.availtotime, "h:mm tt")#</font><br></cfloop></div> </cfif>		

</td> 
		  </cfoutput>
			<cfset rowCounter = rowCounter + 1>
			<cfif rowCounter is 8>
				<cfoutput></tr></cfoutput>
				<cfset rowCounter = 1>
			</cfif>
		</cfloop>
		<!--- now finish up last row --->
		<cfloop index="x" from="#rowCounter#" to=7>
			<cfoutput><td class="blankcell">&nbsp;</td></cfoutput>
		</cfloop>
		<cfoutput></tr></table></center></cfoutput>
		
	
	

	
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">  







