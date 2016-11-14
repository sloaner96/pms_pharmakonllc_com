
 <cfoutput>
 <link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />
 
 		   	<script type="text/javascript">
function openpopup4(popurl){
var winpops=window.open(popurl,"","top=200,left=300,width=540,height=610,scrollbars=yes,resizable=yes")
}
</script> 

 		   	<script type="text/javascript">
function openpopup5(popurl){
var winpops=window.open(popurl,"","top=200,left=300,width=300,height=350,scrollbars=yes,resizable=yes")
}
</script> 


 <cfset today = DateFormat(now(), "mm-dd-yyyy")>	
	<cfset time_now= 'TimeFormat(now(),hh:mm:tt'>	
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

<!--- <cfobject component="testpms.com.Scheduling" name="Schedule"> 
<cfset getactiveProj = Schedule.getactiveProjects()> --->

 <!--------------------------- 
     get Projects for this Day 
	 --------------------------->
	  
	 <cfset thisMonth = "#url.month#">
	  <cfset thisday = "#url.day#">
	  <cfset thisMonth = "#url.year#"> 
	  
	  <cfset getdate = '#url.month#-#url.day#-#url.year#'> 
	  <cfset thisdate = '#DateFormat(getdate, "mm-dd-yyyy")#'> 	 
	  
	  
			  <cfquery name="getDayList2" datasource="#application.projdsn#"> 
	    Select left(meetingCode, 9) as projectCode, MtgStartTime, MtgEndTime, ScheduleID, Status, meetingcode, remarks, Training, password, updatedby, Lastupdated, DateAdded,
		  (Select speaker_listenins
		      From PIW
			  Where project_code = left(M.meetingCode, 9)) as ListenIN,
		   (Select helpline
		     From PIW
			  Where project_code = left(M.meetingCode, 9)) as DialIN,	     	
		   (Select Top 1 SpeakerID
		      From ScheduleSpeaker
			  Where ScheduleID = M.ScheduleID
			  AND Type = 'MOD') as ModeratorExists,
		   (Select Top 1 SpeakerID
		      From ScheduleSpeaker
			  Where ScheduleID = M.ScheduleID
			  AND Type = 'SPKR') as SpeakerExists		
		  From 
		  ScheduleMaster M		   		  
		  Where meetingdate = '#thisdate#' and 
		  meetingCode = '#url.meetingCode#' 
		
	  </cfquery>	  
	  
	  <cfset session.day= '#url.day#'>
	  <cfset session.month= '#url.month#'>
	  <cfset session.year= '#url.year#'>
	  <cfset session.status= '#getDayList2.status#'>
	  <cfset session.remarks= '#getDayList2.remarks#'>
	  <cfset session.meetingCode= '#getDayList2.meetingCode#'>
	  <cfset session.projectCode= '#getDayList2.projectCode#'>
	  <cfset session.ScheduleID= '#getDayList2.ScheduleID#'>
	  <cfset session.MeetingDate= '#session.month#/#session.day#/#session.year#'>
	  <cfif #getDayList2.ModeratorExists# is not ''><cfset session.mod = '#getDayList2.ModeratorExists#'>
	  <cfelse><cfset session.mod = ''>	  
	  </cfif>
	  
	  
	  <cfset session.start_time= '#TimeFormat(getDayList2.MtgStartTime, 'h')#: #TimeFormat(getDayList2.MtgStartTime, 'mm')# #TimeFormat(getDayList2.MtgStartTime, 'tt')#'>
	  <cfset session.end_time= '#TimeFormat(getDayList2.MtgEndTime, 'h')#: #TimeFormat(getDayList2.MtgEndTime, 'mm')# #TimeFormat(getDayList2.MtgEndTime, 'tt')#'>

<font face="verdana" size="1">	  		
<a href="zoom_Schedule.cfm?day=#url.day#&month=#url.month#&year=#url.year#"><u>Back to Day View</u></a>&nbsp;|&nbsp;<a href="javascript:window.close();"><u>Close Window</u></a></font><br>
	  	<center><font face="verdana" size="2"> Schedule for  <strong>#thisdate#</strong></font><br>
<font face="verdana" size="1"><em>Edit Meeting #getDayList2.meetingCode#</em></font>
</center> 
	     <table border="1" cellpadding="2" cellspacing="0" width="100%">
		        <tr bgcolor="d3d3d3">
						   <td align="left"><font face="verdana" size="2"><strong>Project</strong></font></td>							 
				    <td align="left"><font face="verdana" size="2"><strong>Date</strong></font></td>
					 <td align="left"><font face="verdana" size="2"><strong>Time</strong></font></td>					  			   
				   </tr>  
				
<cfquery name="get_desc" datasource="#application.projdsn#"> 
Select project_code, product
		     From PIW
			Where project_code = '#session.projectCode#'
			 </cfquery> 
			 
<cfloop query="getDayList2">
<cfform action="update_Schedule_meeting.cfm" method="POST">
<tr>
<td><!--- #getDayList2.scheduleid# ---><font face="verdana" size="2" color="maroon">
<strong>#get_desc.product#</strong></font><br>
<font face="verdana" size="1">
<em>#getDayList2.projectCode#</em>
</font>

<form method="POST" action="update_Schedule_meeting.cfm">
<input type="hidden" name="update_master" value="yes">

									 </font> </td>

 <td>
									 
									    <table border="0" cellpadding="2" cellspacing="0">
                                            <tr>
											   
											   <td>
											   
										<font face="verdana" size="2">	#thisdate#</font>
		   </td>
											</tr>
                                        </table>           
									  </td>


<td>

 <table border="0" cellpadding="2" cellspacing="0">
                                            <tr>
											   
											   <td>

<font face="verdana" size="1">

Start Time:	</font></td><td><font face="verdana" size="1">#TimeFormat(getDayList2.MtgStartTime, 'h')#: #TimeFormat(getDayList2.MtgStartTime, 'mm')# #TimeFormat(getDayList2.MtgStartTime, 'tt')#</font></td></tr>

											 <tr>
											   
											   <td>  <font face="verdana" size="1">       
End Time: </font></td><td><font face="verdana" size="1">#TimeFormat(getDayList2.MtgEndTime, 'h')#: #TimeFormat(getDayList2.MtgEndTime, 'mm')# #TimeFormat(getDayList2.MtgEndTime, 'tt')#</font></font></td></tr></table>
											       
									  </td> </tr>
									 <tr bgcolor="d3d3d3">
						   <td align="left"><font face="verdana" size="2"><strong>Password</strong></font></td>        
								   <td align="left" nowrap><font face="verdana" size="2"><strong>Status</strong></font></td>
				    <td align="left"><font face="verdana" size="2"><strong>Last Updated</strong></font></td>
								  			   
				   </tr>    
						<tr><td>
									
									<input type="text" name="password" value="#getDayList2.password#" size="15" maxlength="100"></td>
									
								
								<td>	<select name="Status">
		   <option value="A" <cfif #getDayList2.Status# is 'A'>Selected</cfif>>Active</option>
		   <option value="C" <cfif #getDayList2.Status# is 'C'>Selected</cfif>>Canceled</option>
		   <option value="CPS" <cfif #getDayList2.Status# is 'CPS'>Selected</cfif>>Canceled Pay Speaker</option>
		   <option value="CPA" <cfif #getDayList2.Status# is 'CPA'>Selected</cfif>>Canceled Pay All</option>
		   <option value="CPI" <cfif #getDayList2.Status# is 'CPI'>Selected</cfif>>Canceled Pay Invitees</option>
		   <option value="P" <cfif #getDayList2.Status# is 'P'>Selected</cfif>>Pending</option>
		  
		  
			    </select>
							<br><a href="update_Schedule_meeting.cfm?delete=yes&meetingcode=#getDayList2.meetingCode#&day=#url.day#&month=#url.month#&year=#url.year#"><font face="verdana" size="1" color="red"><u>Delete Meeting</u></a></font><br><font face="verdana" size="1"><em>(Be sure to delete all Speakers and Moderators first)</em></font></td>
									
									
								<td><font face="verdana" size="2" color="gray">
							<cfif #getDayList2.UpdatedBy# is ''>
							<cfset update_log1_show = ''>
							<cfset update_log1 = '#session.user#'>
							<cfelse>
							<cfset update_log1 = 'By: #getDayList2.UpdatedBy#<br>'>
							By: #getDayList2.UpdatedBy#<br>
							</cfif>
							
							
							<cfif #getDayList2.LastUpdated# is ''> 
							<cfset update_log2= '#getDayList2.DateAdded#'>
                           <cfelse>
						  <cfset update_log2= '#getDayList2.LastUpdated#'></cfif> 
						  
			

<!--- #DateFormat(Left(update_log2, 9), "mm/dd/yyyy")# ---> <cfif #getDayList2.LastUpdated# is ''><cfelse> #update_log2#  </cfif> </font>

								</td>
									</tr>		
									
								 <tr bgcolor="d3d3d3">
									<td align="left"><font face="verdana" size="2"><strong>Notes</strong></font></td><td align="left"><font face="verdana" size="2"><strong>Meeting / Training</strong></font></td>

<td align="left"><font face="verdana" size="2"><strong>Dial In Numbers</strong></font></td>
									</tr>
									<tr>
									
			


<td> <textarea name="remarks" rows="3" cols="20">#Trim(Remarks)#</textarea></td>
<td align="center"><font face="verdana" size="2"> <cfif #Trim(Training)# is 'yes'>Training Session<cfelse>Meeting</cfif></font></td> 				
									
								<td>	
					<font face="verdana" size="1">	
					Dial In Number: #getDayList2.DialIN#                     <br>
					Listen In Number: #getDayList2.ListenIN#	
								
							<td>
																</tr> 
									
									
		<tr><td colspan="2">&nbsp;</td>
	<td><br>

	<input type="submit" value="Update">&nbsp;&nbsp;<input type="reset" name="Reset"></form></td>

									 </tr> 							
																		
									  
									  <tr bgcolor="d3d3d3">
									  <td colspan ="2"><font face="verdana" size="2"><strong>Moderators</strong></font></td><td><font face="verdana" size="2"><strong>Speakers</strong></font></td>
									  
									 <tr>
									 <td colspan="2" valign="top" nowrap width="50%">
									 
									 
			<!--- Insert Delete Moderators --->						 
									 
		<cfquery name="get_selected_mods" datasource="#application.projdsn#"> 
Select
speakerid,
activityType,
Confirmed 
From ScheduleSpeaker
Where 
ScheduleID = '#getDayList2.ScheduleID#' and 
Type = 'MOD'

 </cfquery> 							 
									 
									 
	<cfquery name="all_mods" datasource="#application.speakerDSN#">
	 Select 
sp.speakerid, 
sp.firstname, 
sp.lastname, 
sc.ClientId, 
sc.ClientCode

From Speaker sp, 
SpeakerClients sc
 
Where sp.type = 'MOD' and 
sc.SpeakerId = sp.speakerid and
sc.ClientCode = '#Left(session.projectCode, 5)#' and
sp.active= 'yes'

		  Order by lastname
          </cfquery>
		
		<font face="verdana" size="2" color="maroon">Lead Moderators</font>&nbsp;&nbsp;<a href=""><font face="verdana" size="1"><a href="javascript:openpopup5('add_mod.cfm')">Associate New Mod</font></a><br> 
	
<form method="POST" action="update_Schedule_meeting.cfm">
<select name="MOD" onchange="this.form.submit();">
<option value="">- Add -</option>
<cfloop query="all_mods">
 <cfquery name="check_avail1" datasource="#application.speakerDSN#">
Select SpeakerID, availfromdate, availtodate, availfromtime, availtotime, availtype, allday, MeetingCode
From SpeakerAvailable  
Where SpeakerID ='#all_mods.speakerid#' and 
availfromdate = '#DateFormat(thisdate, "m/d/yyyy")#' 
</cfquery> 

<!--- Half Hour into Meeting --->
<cfscript>
Conflict1c = #TimeFormat(getDayList2.MtgStartTime, "h:mm tt")#;    
    new_hourc = createTimeSpan(0,0,30,0);    
    end_conflict1c = Conflict1c + new_hourc;
</cfscript>	
<cfset dont_show = ''>
 <cfloop query="check_avail1">

 <cfif #TimeFormat(check_avail1.availfromtime, "hh:mm tt")# is '#TimeFormat(getDayList2.MtgStartTime, "hh:mm tt")#' or #TimeFormat(check_avail1.availfromtime, "hh:mm tt")# is '#TimeFormat(end_conflict1c, "hh:mm tt")#'> 
<cfset dont_show = '#all_mods.speakerid#'><cfbreak>
</cfif>
</cfloop> 

<cfif #dont_show# is ''>		 
<option value="#all_mods.speakerid#">#UCase(all_mods.lastname)#, #UCase(all_mods.firstname)#</option>
<cfelse>
<option value="0#all_mods.speakerid#">* #UCase(all_mods.lastname)#, #UCase(all_mods.firstname)# -UNAVAILABLE-</option>
 </cfif>
 
</cfloop> 
</select>
					<cfset index=0>		
						<table border="0" cellpadding="2" cellspacing="0">
	<tr>
<td><font face="verdana" size="1">Delete</font></td><td align="center"><font face="verdana" size="1">Confirm</font></td><td nowrap><font face="verdana" size="1">&nbsp;&nbsp;&nbsp;&nbsp;Moderator</font></td>
		</tr>								
	<cfloop query="get_selected_mods">
<cfquery name="current_mod" datasource="#application.speakerDSN#">
	     Select 
		  sp.speakerid, 
		  sp.firstname, 
		  sp.lastname,
		  sp.type      	  
		  From 
		  Speaker sp		  
		  Where 		 	
		  sp.speakerid = '#get_selected_mods.speakerid#' 
		
		  order by sp.firstname
</cfquery> 

<cfif get_selected_mods.activityType is 'Lead'> 
<tr>													  
<cfif current_mod.speakerid is not ''>	<cfset index = index + 1>												  
<td width ="1" align="center">

<cfif #Left(get_selected_mods.speakerid, 1)# is not '0'><a href="update_Schedule_meeting.cfm?delete_speaker=#current_mod.speakerid#&activityType=#get_selected_mods.activityType#"><img src="../images/delete1.gif" alt="Delete Moderator" border="0"></a>
<cfelse>
<a href="update_Schedule_meeting.cfm?delete_speaker=0#current_mod.speakerid#&activityType=#get_selected_mods.activityType#"><img src="../images/delete1.gif" alt="Delete Moderator" border="0"></a>
</cfif>


</td><td width ="1">

<cfif #Left(get_selected_mods.speakerid, 1)# is not '0'>
<a href="update_Schedule_meeting.cfm?confirm_speaker=#current_mod.speakerid#&activityType=#get_selected_mods.activityType#&Confirmed=#get_selected_mods.Confirmed#"><cfif get_selected_mods.Confirmed is 0><img src="../images/unconfirmed1.gif" alt="Unconfirmed Moderator" border="0"><cfelse><img src="../images/confirmed1.gif" alt="Confirmed Moderator" border="0"></cfif></a></cfif>
</td>
<td nowrap><font face="verdana" size="1">#index#. 

<cfif #Left(get_selected_mods.speakerid, 1)# is '0'>
<a href="javascript:openpopup4('indiv_sched.cfm?speakerid=#current_mod.speakerid#')"><font color="gray"><u>#current_mod.firstname# #current_mod.lastname#</u></a></font><font color="black"> - UNAVAILABLE</font>
<cfelse>
<a href="javascript:openpopup4('indiv_sched.cfm?speakerid=#current_mod.speakerid#')">
<u>#current_mod.firstname# #current_mod.lastname#</u></a></font>
</cfif>
</cfif></td>
</tr>
</cfif>

</cfloop></table></font>							  
													  
													  </form>
													  
<form method="POST" action="update_Schedule_meeting.cfm">
<select name="MOD_list" onchange="this.form.submit();">
<option value="">- Add -</option>
<cfloop query="all_mods">
 <cfquery name="check_avail1" datasource="#application.speakerDSN#">
Select SpeakerID, availfromdate, availtodate, availfromtime, availtotime, availtype, allday, MeetingCode
From SpeakerAvailable  
Where SpeakerID ='#all_mods.speakerid#' and 
availfromdate = '#DateFormat(thisdate, "m/d/yyyy")#' 
</cfquery> 

<!--- Half Hour into Meeting --->
<cfscript>
Conflict1c = #TimeFormat(getDayList2.MtgStartTime, "h:mm tt")#;    
    new_hourc = createTimeSpan(0,0,30,0);    
    end_conflict1c = Conflict1c + new_hourc;
</cfscript>	
<cfset dont_show = ''>
 <cfloop query="check_avail1">

 <cfif #TimeFormat(check_avail1.availfromtime, "hh:mm tt")# is '#TimeFormat(getDayList2.MtgStartTime, "hh:mm tt")#' or #TimeFormat(check_avail1.availfromtime, "hh:mm tt")# is '#TimeFormat(end_conflict1c, "hh:mm tt")#'> 
<cfset dont_show = '#all_mods.speakerid#'><cfbreak>
</cfif>
</cfloop>  

<cfif #dont_show# is ''>		 
<option value="#all_mods.speakerid#">#UCase(all_mods.lastname)#, #UCase(all_mods.firstname)#</option>
<cfelse>
<option value="0#all_mods.speakerid#">* #UCase(all_mods.lastname)#, #UCase(all_mods.firstname)# -UNAVAILABLE-</option>
 </cfif>
 
</cfloop> 
</select>										
														<cfset index=0>		
						<table border="0" cellpadding="2" cellspacing="0">
	<tr>
<td><font face="verdana" size="1">Delete</font></td><td align="center"><font face="verdana" size="1">Confirm</font></td><td nowrap><font face="verdana" size="1">&nbsp;&nbsp;&nbsp;&nbsp;Moderator</font></td>
		</tr>								
	<cfloop query="get_selected_mods">
<cfquery name="current_lis_mod" datasource="#application.speakerDSN#">
	     Select 
		  sp.speakerid, 
		  sp.firstname, 
		  sp.lastname,
		  sp.type      	  
		  From 
		  Speaker sp		  
		  Where 		 	
		  sp.speakerid = '#get_selected_mods.speakerid#' 
		  order by sp.firstname
</cfquery> 

<cfif get_selected_mods.activityType is 'Listen'>	
<tr>											  
<cfif current_lis_mod.speakerid is not ''>	<cfset index = index + 1>												  
<td width ="1" align="center">


<cfif #Left(get_selected_mods.speakerid, 1)# is not '0'><a href="update_Schedule_meeting.cfm?delete_speaker=#current_lis_mod.speakerid#&activityType=#get_selected_mods.activityType#"><img src="../images/delete1.gif" alt="Delete Moderator" border="0"></a>
<cfelse>
<a href="update_Schedule_meeting.cfm?delete_speaker=0#current_lis_mod.speakerid#&activityType=#get_selected_mods.activityType#"><img src="../images/delete1.gif" alt="Delete Moderator" border="0"></a>

</cfif>
</td><td width ="1">

<cfif #Left(get_selected_mods.speakerid, 1)# is not '0'>
<a href="update_Schedule_meeting.cfm?confirm_speaker=#current_lis_mod.speakerid#&activityType=#get_selected_mods.activityType#&Confirmed=#get_selected_mods.Confirmed#"><cfif get_selected_mods.Confirmed is 0><img src="../images/unconfirmed1.gif" alt="Unconfirmed Moderator" border="0"><cfelse><img src="../images/confirmed1.gif" alt="Confirmed Moderator" border="0"></cfif>
</a></cfif></td>
<td nowrap><font face="verdana" size="1">#index#.


<cfif #Left(get_selected_mods.speakerid, 1)# is '0'>
 <a href="javascript:openpopup4('indiv_sched.cfm?speakerid=#current_mod.speakerid#')"><font color="gray"><u>#current_lis_mod.firstname# #current_lis_mod.lastname#</u></a></font><font color="black"> - UNAVAILABLE</font>
<cfelse>
 <a href="javascript:openpopup4('indiv_sched.cfm?speakerid=#current_mod.speakerid#')"><u>#current_lis_mod.firstname# #current_lis_mod.lastname#</u></a></font>
</cfif>
</cfif>
</td>
</tr>
</cfif>

</cfloop></table></font>		
</form>							  
</td> 
										
					<!--- End Insert Delete Moderators --->	
									
					<!--- End Insert Delete Speakers --->		
									
															
		<td colspan="2" valign="top">
		
		<cfquery name="get_selected_speakers" datasource="#application.projdsn#"> 
Select
speakerid,
activityType,
Confirmed   
From ScheduleSpeaker
Where 
ScheduleID = '#getDayList2.ScheduleID#' and 
Type = 'SPKR'
 </cfquery> 	  	
		
		
				<cfquery name="all_speakers" datasource="#application.speakerDSN#">
	 	 Select 
sp.speakerid, 
sp.firstname, 
sp.lastname, 
sc.ClientId, 
sc.ClientCode 

From Speaker sp, 
SpeakerClients sc 
Where sp.type = 'SPKR' and 
sc.SpeakerId = sp.speakerid and
		  sc.ClientCode = '#Left(session.projectCode, 5)#' and
sp.active= 'yes'
		  Order by lastname
          </cfquery> 
		  		
		
		<font face="verdana" size="2" color="maroon">Lead Speakers</font>&nbsp;&nbsp;<a href=""><font face="verdana" size="1"><a href="javascript:openpopup5('add_spker.cfm')">Associate New Speaker</a></font></a><br> 
	
		<form method="POST" action="update_Schedule_meeting.cfm">
		
		<select name="SPKR" onchange="this.form.submit();">
		<option value="">- Add -</option>
<cfloop query="all_speakers">
<cfquery name="check_avail1" datasource="#application.speakerDSN#">
Select SpeakerID, availfromdate, availtodate, availfromtime, availtotime, availtype, allday, MeetingCode
From SpeakerAvailable  
Where SpeakerID ='#all_speakers.speakerid#' and availfromdate = '#DateFormat(thisdate, "m/d/yyyy")#' 
</cfquery> 

<!--- Half Hour into Meeting --->
<cfscript>
Conflict1c = #TimeFormat(getDayList2.MtgStartTime, "h:mm tt")#;    
    new_hourc = createTimeSpan(0,0,30,0);    
    end_conflict1c = Conflict1c + new_hourc;
</cfscript>	
<cfset dont_show = ''>
<cfloop query="check_avail1">

<cfif #TimeFormat(check_avail1.availfromtime, "hh:mm tt")# is '#TimeFormat(getDayList2.MtgStartTime, "hh:mm tt")#' or #TimeFormat(check_avail1.availfromtime, "hh:mm tt")# is '#TimeFormat(end_conflict1c, "hh:mm tt")#'> 
<cfset dont_show = '#all_speakers.speakerid#'><cfbreak>
</cfif>
</cfloop>

<cfif #dont_show# is ''>		 
<option value="#all_speakers.speakerid#">#UCase(all_speakers.lastname)#, #UCase(all_speakers.firstname)#</option>
<cfelse>
<option value="0#all_speakers.speakerid#">* #UCase(all_speakers.lastname)#, #UCase(all_speakers.firstname)# -UNAVAILABLE-</option>
 </cfif>
 
</cfloop> 
</select>
					<cfset index=0>		
						<table border="0" cellpadding="2" cellspacing="0">
	<tr>
<td><font face="verdana" size="1">Delete</font></td><td align="center"><font face="verdana" size="1">Status</font></td><td nowrap><font face="verdana" size="1">&nbsp;&nbsp;&nbsp;&nbsp;Speaker</font></td>
		</tr>								
<cfloop query="get_selected_speakers">
<cfquery name="current_spkr" datasource="#application.speakerDSN#">
	       Select
		  sp.speakerid, 
		  sp.firstname, 
		  sp.lastname,
		  sp.type      	  
		  From 
		  Speaker sp		  
		  Where 		 	
		  sp.speakerid = '#get_selected_speakers.speakerid#' 
		
		  order by sp.firstname
</cfquery> 


<cfif get_selected_speakers.activityType is 'Lead'>
<tr>							  
												  
<cfif current_spkr.speakerid is not ''>	<cfset index = index + 1>												  
<td width ="1" align="center">

<cfif #Left(get_selected_speakers.speakerid, 1)# is not '0'><a href="update_Schedule_meeting.cfm?delete_speaker=#current_spkr.speakerid#&activityType=#get_selected_speakers.activityType#"><img src="../images/delete1.gif" alt="Delete Speaker" border="0"></a>
<cfelse>
<a href="update_Schedule_meeting.cfm?delete_speaker=0#current_spkr.speakerid#&activityType=#get_selected_speakers.activityType#"><img src="../images/delete1.gif" alt="Delete Speaker" border="0"></a>
</cfif>

</td><td width ="1">

<cfif #Left(get_selected_speakers.speakerid, 1)# is not '0'><a href="update_Schedule_meeting.cfm?confirm_speaker=#current_spkr.speakerid#&activityType=#get_selected_speakers.activityType#&Confirmed=#get_selected_speakers.Confirmed#"><cfif get_selected_speakers.Confirmed is 0><img src="../images/unconfirmed1.gif" alt="Unconfirmed Speaker" border="0"><cfelse><img src="../images/confirmed1.gif" alt="Confirmed Speaker" border="0"></cfif></a></cfif>
</td>
<td nowrap><font face="verdana" size="1">#index#. 

<cfif #Left(get_selected_speakers.speakerid, 1)# is '0'>
<a href="javascript:openpopup4('indiv_sched.cfm?speakerid=#current_spkr.speakerid#')"><font color="gray"><u>#current_spkr.firstname# #current_spkr.lastname#</u></a></font><font color="black"> - UNAVAILABLE</font>
<cfelse>
<a href="javascript:openpopup4('indiv_sched.cfm?speakerid=#current_spkr.speakerid#')">
<u>#current_spkr.firstname# #current_spkr.lastname#</u></a></font>
</cfif>
</cfif></td>
</tr>
</cfif>

</cfloop></table></font>							  
													  
													  </form>
													  
													 
													    <form method="POST" action="update_Schedule_meeting.cfm">
														<input type="hidden" name="meetingCode" value="#getDayList2.meetingCode#">

													  <font face="verdana" size="2" color="maroon">Listening Speakers</font><br>
	   <select name="SPKR_lis" onchange="this.form.submit();">
	   <option value="">- Add -</option>
<cfloop query="all_speakers">
<cfquery name="check_avail1" datasource="#application.speakerDSN#">
Select SpeakerID, availfromdate, availtodate, availfromtime, availtotime, availtype, allday, MeetingCode
From SpeakerAvailable  
Where SpeakerID ='#all_speakers.speakerid#' and availfromdate = '#DateFormat(thisdate, "m/d/yyyy")#' 
</cfquery> 

<!--- Half Hour into Meeting --->
<cfscript>
Conflict1c = #TimeFormat(getDayList2.MtgStartTime, "h:mm tt")#;    
    new_hourc = createTimeSpan(0,0,30,0);    
    end_conflict1c = Conflict1c + new_hourc;
</cfscript>	
<cfset dont_show = ''>
<cfloop query="check_avail1">

<cfif #TimeFormat(check_avail1.availfromtime, "hh:mm tt")# is '#TimeFormat(getDayList2.MtgStartTime, "hh:mm tt")#' or #TimeFormat(check_avail1.availfromtime, "hh:mm tt")# is '#TimeFormat(end_conflict1c, "hh:mm tt")#'> 
<cfset dont_show = '#all_speakers.speakerid#'><cfbreak>
</cfif>
</cfloop>

<cfif #dont_show# is ''>		 
<option value="#all_speakers.speakerid#">#UCase(all_speakers.lastname)#, #UCase(all_speakers.firstname)#</option>
<cfelse>
<option value="0#all_speakers.speakerid#">* #UCase(all_speakers.lastname)#, #UCase(all_speakers.firstname)# -UNAVAILABLE-</option>
 </cfif>
 
</cfloop> 
</select>	
													  
						<cfset index=0>		
						<table border="0" cellpadding="2" cellspacing="0">
	<tr>
<td><font face="verdana" size="1">Delete</font></td><td align="center"><font face="verdana" size="1">Status</font></td><td nowrap><font face="verdana" size="1">&nbsp;&nbsp;&nbsp;&nbsp;Speaker</font></td>
		</tr>								
<cfloop query="get_selected_speakers">
<cfquery name="current_spkr" datasource="#application.speakerDSN#">
	       Select
		  sp.speakerid, 
		  sp.firstname, 
		  sp.lastname,
		  sp.type      	  
		  From 
		  Speaker sp		  
		  Where 		 	
		  sp.speakerid = '#get_selected_speakers.speakerid#' 
		
		  order by sp.firstname
</cfquery> 


<cfif get_selected_speakers.activityType is 'Listen'>
<tr>		
											  
<cfif current_spkr.speakerid is not ''>	<cfset index = index + 1>												  
<td width ="1" align="center">

<cfif #Left(get_selected_speakers.speakerid, 1)# is not '0'><a href="update_Schedule_meeting.cfm?delete_speaker=#current_spkr.speakerid#&activityType=#get_selected_speakers.activityType#"><img src="../images/delete1.gif" alt="Delete Speaker" border="0"></a>
<cfelse>
<a href="update_Schedule_meeting.cfm?delete_speaker=0#current_spkr.speakerid#&activityType=#get_selected_speakers.activityType#"><img src="../images/delete1.gif" alt="Delete Speaker" border="0"></a>
</cfif>

</td><td width ="1">

<cfif #Left(get_selected_speakers.speakerid, 1)# is not '0'><a href="update_Schedule_meeting.cfm?confirm_speaker=#current_spkr.speakerid#&activityType=#get_selected_speakers.activityType#&Confirmed=#get_selected_speakers.Confirmed#"><cfif get_selected_speakers.Confirmed is 0><img src="../images/unconfirmed1.gif" alt="Unconfirmed Speaker" border="0"><cfelse><img src="../images/confirmed1.gif" alt="Confirmed Speaker" border="0"></cfif></a></cfif>
</td>
<td nowrap><font face="verdana" size="1">#index#. 

<cfif #Left(get_selected_speakers.speakerid, 1)# is '0'>
<a href="javascript:openpopup4('indiv_sched.cfm?speakerid=#current_spkr.speakerid#')"><font color="gray"><u>#current_spkr.firstname# #current_spkr.lastname#</u></a></font><font color="black"> - UNAVAILABLE</font>
<cfelse>
<a href="javascript:openpopup4('indiv_sched.cfm?speakerid=#current_spkr.speakerid#')">
<u>#current_spkr.firstname# #current_spkr.lastname#</u></a></font>
</cfif>
</cfif></td>
</tr>
</cfif>

</cfloop></table></font>  </form>
			
		</td>							 
	</tr>
	

</cfform></cfloop></table>
</cfoutput>