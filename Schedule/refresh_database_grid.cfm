	 	 <cfoutput>
 <link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />
  		   	<script type="text/javascript">
function openpopup5(popurl){
var winpops=window.open(popurl,"","top=200,left=300,width=420,height=370,scrollbars=yes,resizable=yes")
}
</script>

 		   <script type="text/javascript">
function openpopupunavail(popurl){
var winpops=window.open(popurl,"","top=200,left=300,width=742,height=610,scrollbars=yes,resizable=yes")
}
</script>
 
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Master Schedule-Data" bodyPassthrough="" doAjax="True">
	
<cfparam name="error" default="">
<cfset today = DateFormat(now(), "m/d/yyyy")>	
 <cfset twomonths = dateAdd('d', -14, today)>   
<cfset time = TimeFormat(now(), "h:mm:ss tt")>
<cfset update_log = '#today# #time#'>

 <cfquery name="delete_old_data" datasource="#application.projdsn#">
			delete
			from schedule
			where Date <= '#DateFormat(twomonths, "m/d/yyyy")#'
		</cfquery> 
	
		<cfquery name="new_data" datasource="#application.projdsn#">
			select *
			from schedule
			
			where 
			Date >= '#DateFormat(url.startdate, "mm/dd/yyyy")#' and
			Date <= '#DateFormat(url.enddate, "mm/dd/yyyy")#' <cfif #url.projectfilter# is not ''>
		    and MeetingCode = '#url.projectfilter#'</cfif>
			Order By MeetingCode	
		</cfquery>
		
<cfset MeetingCode1 = ''>
<cfset Date1 = ''>
<cfset Time1 = ''>
<cfset RowID1 = ''>
<cfset error = ''>	
<cfloop query="new_data">			    
		    <cfset month =#DateFormat(new_data.Date, "mm")#>		    
		    <cfset day =#DateFormat(new_data.Date, "dd")#>	
			<cfset year =#DateFormat(new_data.Date, "yyyy")#>	    
		    <cfset start_hour =#TimeFormat(new_data.Time, "hh")#>		    
		    <cfset start_minute =#TimeFormat(new_data.Time, "mm")#>		    
		    <cfset day_night =#TimeFormat(new_data.Time, "tt")#>		    
		    <cfset MeetingCodeDate = '#Right(year, 2)##month##day#'>		    
		    <cfset MeetingCodeTime = '#start_hour##Left(start_minute, 1)#A'>		    
		    <cfset newMeetingCode = '#Trim(new_data.MeetingCode)##trim(MeetingCodeDate)#-#trim(MeetingCodeTime)#'>		    
		    <cfset EndTimehour = "#TimeFormat(new_data.Time, "h")#">
			
	
			<!--- <cfquery name="check_meeting_code" datasource="#application.projdsn#">
				select MeetingCode
							from ScheduleMaster		
							where MeetingCode = '#newMeetingCode#'
			</cfquery>

    <cfif #check_meeting_code.recordcount# gt 0>
<cfif check_meeting_code.MeetingCode is '#newMeetingCode#'>
<cfset newMeetingCode = '#Left(newMeetingCode, 19)#B'>
    </cfif>
</cfif>

<cfquery name="check_meeting_code" datasource="#application.projdsn#">
				select MeetingCode
							from ScheduleMaster		
							where MeetingCode = '#newMeetingCode#'
			</cfquery>

  <cfif #check_meeting_code.recordcount# gt 0>
<cfif check_meeting_code.MeetingCode is '#newMeetingCode#'>
<cfset newMeetingCode = '#Left(newMeetingCode, 19)#C'>
    </cfif>
</cfif> --->
     
<cfif new_data.Time is not ''>
			
			<cfscript>
StartTime = #TimeFormat(new_data.Time, "h:mm:ss tt")#;    
    new_hour = createTimeSpan(0,1,0,0);    
    EndTime = StartTime + new_hour;</cfscript>	
		    </cfif>
	    
		    <cfset MeetingEndTime = '#TimeFormat(EndTime, "h:mm:ss tt")#'>
			
	
			<cfquery name="check_meeting_code" datasource="#application.projdsn#">
				select MeetingCode
							from ScheduleMaster		
							where MeetingCode = '#newMeetingCode#'
			</cfquery>
						
<cfif #check_meeting_code.recordcount# is 0>				
										
				<cfquery name="get_phone" datasource="#application.projdsn#">
					Select speaker_listenins, helpline
							      From PIW
								  Where project_code = '#new_data.MeetingCode#'
				</cfquery>
				
					<cfset speaker_listenins = '#get_phone.speaker_listenins#'>
					<cfset speaker_helpline = '#get_phone.helpline#'>


<cfif  #MeetingCode# is '#MeetingCode1#' and #Date# is '#Date1#' and #Time# is '#Time1#'>

<cfquery name="delete" datasource="#application.projdsn#">
delete 
from Schedule 
where
RowId = #RowID1# 
</cfquery>
</cfif>
				  <cfquery name="insert_meeting" datasource="#application.projdsn#"> 
					Insert Into ScheduleMaster(   
						projectid,
						MeetingCode,
						Status,
						MeetingDate,
						MtgStartTime,
						MtgEndTime,			
						Remarks,
						LeaderPhone,
						ParticipantPhone,
						DateAdded,
						AddedBy,
						LastUpdated,
						UpdatedBy
						   
					 ) 		
								VALUES(
					    '#new_data.MeetingCode#',
						'#newMeetingCode#',
						'A',
						'#DateFormat(new_data.Date, "m/d/yyyy")#',
						'#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "h:mm:ss tt")#',
						'#DateFormat(new_data.Date, "m/d/yyyy")# #MeetingEndTime#',
					    '#new_data.MeetingNotes#',
						'#speaker_listenins#',
						'#speaker_helpline#',
						'#time#',
						'#session.user#',
						'#update_log#',
						'#session.user#'
								)
				</cfquery> 
								
<cfelse>


<cfif  #new_data.MeetingCode# is '#MeetingCode1#' and #new_data.Date# is '#Date1#' and #new_data.Time# is '#Time1#'>

<cfquery name="delete" datasource="#application.projdsn#">
delete 
from Schedule 
where
RowId = #RowID1# 
</cfquery>
</cfif>
</cfif>
			<cfquery name="new_ScheduleID" datasource="#application.projdsn#"> 
				select scheduleID
							from ScheduleMaster		
							where MeetingCode = '#newMeetingCode#'
			</cfquery>
			
			<!---------------------------------------------MOD 1---------------------------------------->
			
<cfif #check_meeting_code.recordcount# is 0>	
			
				<cfif #new_data.Moderator1LastName# is not ''>					
					<cfquery name="mod1id" datasource="#application.speakerDSN#">
						select speakerid
									from Speaker	
									where 
									lastname = '#Trim(new_data.Moderator1LastName)#' and
									firstname = '#Trim(new_data.Moderator1FirstName)#' and type= 'MOD'
					</cfquery>						
							
			<cfif mod1id.recordcount eq 0>	
			<center>
	The Moderator Name - <strong>#new_data.Moderator1FirstName# #new_data.Moderator1LastName# </strong> for #new_data.MeetingCode# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#  was not found in the database. <br><br>Please ajust your spreadsheet and re-load it.

<cfset error = 'mod1'>
	</center><br><hr size="1"><br>	
</cfif>	
	
	<cfquery name="associated_mods1" datasource="#application.speakerDSN#">
Select 
sp.speakerid, 
sc.ClientId, 
sc.ClientCode 

From Speaker sp, 
SpeakerClients sc 
Where 
sp.speakerid = '#mod1id.speakerid#' and
sp.type = 'MOD' and 
sc.SpeakerId = sp.speakerid and
sc.ClientCode = '#Left(newMeetingCode, 5)#'
Order by lastname
          </cfquery> 
	
	<cfif associated_mods1.recordcount eq 0>	<center>
	The Moderator - <strong>#new_data.Moderator1FirstName# #new_data.Moderator1LastName#</strong> is not associated with  Project <strong>"#new_data.MeetingCode#"</strong>.<br> <a href="javascript:openpopup5('add_mod2.cfm?speakerid=#mod1id.speakerid#&meeting=#Left(newMeetingCode, 9)#')"><u>Click Here</u></a> to add him/her to this project. Then re-load this page. 

<cfset error = 'mod1'>
	</center><br><hr size="1"><br>
</cfif>			

<cfif error is not 'mod1'> 
<!-------------------------------------- Check for Meeting Conflict ----------------------------------------->
<cfquery name="check_avail1" datasource="#application.speakerDSN#">
Select 
SpeakerID,
availfromdate,
availtodate,
availfromtime,
availtotime,
availtype,
allday,
MeetingCode

From SpeakerAvailable 
 
Where 
MeetingCode != '#newmeetingcode#' and
SpeakerID ='#mod1id.speakerid#' and
availfromdate = '#DateFormat(new_data.Date, "m/d/yyyy")#'
</cfquery> 

<cfif check_avail1.recordcount gte 1>

<!--- One Hour After Meeting --->
<cfscript>Conflict1a = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_houra = createTimeSpan(0,1,0,0);    
    end_conflict1a = Conflict1a + new_houra;
</cfscript>
<!--- One Hour Before Meeting --->
<cfscript>
Conflict1b = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourb = createTimeSpan(0,1,0,0);    
    end_conflict1b = Conflict1b - new_hourb;
</cfscript>
<!--- Half Hour After Meeting --->
<cfscript>
Conflict1c = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourc = createTimeSpan(0,0,30,0);    
    end_conflict1c = Conflict1c + new_hourc;
</cfscript>	
<!--- Half Hour Before Meeting --->
<cfscript>
Conflict1d = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourd = createTimeSpan(0,0,30,0);    
    end_conflict1d = Conflict1d - new_hourd;
</cfscript>		

<cfif #check_avail1.allday# is 1>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this day off.<br><br>
Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfset error = 'mod1'>

<cfelse>
         
<cfif #TimeFormat(new_data.Time, "hh:mm tt")# eq '#TimeFormat(check_avail1.availfromtime, "hh:mm tt")#' or #TimeFormat(end_conflict1d, "hh:mm tt")# eq '#TimeFormat(check_avail1.availfromtime, "hh:mm tt")#' or #TimeFormat(end_conflict1c, "hh:mm tt")# eq '#TimeFormat(check_avail1.availtotime, "hh:mm tt")#'> 
<cfset error = 'mod1'>

<cfif #check_avail1.MeetingCode# is ''>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this time off. Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfelse>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# is in meeting #Left(check_avail1.MeetingCode, 9)# from #TimeFormat(check_avail1.availfromtime, "h:mm tt")# to #TimeFormat(check_avail1.availtotime, "h:mm tt")#. Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
</cfif>


<cfelseif 
#TimeFormat(end_conflict1b, "hh:mm tt")# eq '#TimeFormat(check_avail1.availfromtime, "hh:mm tt")#' or #TimeFormat(end_conflict1a, "hh:mm tt")# eq '#TimeFormat(check_avail1.availtotime, "hh:mm tt")#'> 
<cfset error = 'w'>

<font color="FF0000"><strong>Warning!</strong></font> #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# has been added to #Left(newMeetingCode, 9)#, #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")# however, #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# is in meeting #Left(check_avail1.meetingcode, 9)# from #TimeFormat(check_avail1.availfromtime, "h:mm tt")# to #TimeFormat(check_avail1.availtotime, "h:mm tt")#.

<br><hr size="1"><br>
</cfif> 
</cfif>
</cfif>
<!-------------------------------------- Insert Moderator-----------------------------------------> 
<cfif error is not 'mod1'>
					 <cfquery name="insert_mod1" datasource="#application.projdsn#"> 
						Insert Into ScheduleSpeaker(   
							ScheduleID,
							MeetingCode,
							MeetingDate,
							MtgStartTime,
							MtgEndTime,	
							SpeakerID,
							Type,
							activityType,	  
							Confirmed
							   
						 ) 		
									VALUES(
							'#new_ScheduleID.scheduleID#',
							'#newMeetingCode#',
							'#DateFormat(new_data.Date, "m/d/yyyy")#',
							'#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "h:mm:ss tt")#',
							'#DateFormat(new_data.Date, "m/d/yyyy")# #MeetingEndTime#',	
							'#mod1id.speakerid#',
							'MOD',
							'Lead',
							'1'
									)
					</cfquery>  
					<cfquery name="insert_unavailability1" datasource="#application.speakerDSN#">
INSERT into SpeakerAvailable 
       (
		speakerID, 
		availfromdate, 
		availtodate, 
		availfromtime,
		availtotime,
		allday,
		availtype,
		updated,
		updatedby,
		MeetingCode
		)
        VALUES 
        (
		'#mod1id.SpeakerID#',
		'#DateFormat(new_data.Date, "m/d/yyyy")#',
		'#DateFormat(new_data.Date, "m/d/yyyy")# ',	
		'#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "hh:mm:ss tt")#',
		'#DateFormat(new_data.Date, "m/d/yyyy")# #MeetingEndTime#',
		'0',
		'NA',
		'#update_log#',
		'#session.user#',
		'#newMeetingCode#'
				)
</cfquery>
		</cfif>			
					</cfif>
						
				</cfif>
				<!--- Have a meeting Code and mod1 is not blank --->
<cfelse>

	<!--- Mod 1 NULL delete it --->
					
			<cfif #Trim(new_data.Moderator1LastName)# is 'NULL' or #Trim(new_data.Moderator1FirstName)# is 'Null'>
<cfquery name="delete_mod1" datasource="#application.projdsn#">
						delete
						from ScheduleSpeaker
						Where MeetingCode = '#newmeetingcode#' and Type = 'MOD'
						
					</cfquery>
					
		<cfquery name="delete_mod1" datasource="#application.projdsn#">
			 
	     UPDATE Schedule
	     SET  
		 Moderator1FirstName ='', 
		 Moderator1LastName =''
		 WHERE RowID = '#new_data.RowID#'
	  </cfquery> 
	  
<cfquery name="delete_availmod1" datasource="#application.speakerDSN#">			 
	     delete from SpeakerAvailable
	     where	
		 MeetingCode = '#newmeetingcode#' and	 
		 availfromdate =  '#DateFormat(new_data.Date, "m/d/yyyy")#' and
		 availfromtime = '#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "h:mm:ss tt")#'
</cfquery>
	  
								
			<cfelse>
		
<cfif #new_data.Moderator1LastName# is not ''>
<cfquery name="mod1id" datasource="#application.speakerDSN#">
						select speakerid
									from Speaker	
									where 
									lastname = '#Trim(new_data.Moderator1LastName)#' and
									firstname = '#Trim(new_data.Moderator1FirstName)#' and type= 'MOD'
					</cfquery>					
					<cfquery name="mod1id2" datasource="#application.projdsn#">
						select speakerid
						from ScheduleSpeaker
						Where MeetingCode = '#newmeetingcode#' and Type = 'Mod' and speakerid = '#mod1id.speakerid#'									
					</cfquery>
					
	<cfif #mod1id2.recordcount# is 1>	
	
	
	<!---  Mod 1 Exist dont do Anything --->
	
	<!-------------------------------------- Check for Meeting Conflict ----------------------------------------->
<cfquery name="check_avail1" datasource="#application.speakerDSN#">
Select 
SpeakerID,
availfromdate,
availtodate,
availfromtime,
availtotime,
availtype,
allday,
MeetingCode

From SpeakerAvailable 
 
Where 
MeetingCode != '#newmeetingcode#' and
SpeakerID ='#mod1id.speakerid#' and
availfromdate = '#DateFormat(new_data.Date, "m/d/yyyy")#'
</cfquery> 

<cfif check_avail1.recordcount gte 1>

<!--- One Hour After Meeting --->
<cfscript>Conflict1a = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_houra = createTimeSpan(0,1,0,0);    
    end_conflict1a = Conflict1a + new_houra;
</cfscript>
<!--- One Hour Before Meeting --->
<cfscript>
Conflict1b = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourb = createTimeSpan(0,1,0,0);    
    end_conflict1b = Conflict1b - new_hourb;
</cfscript>
<!--- Half Hour After Meeting --->
<cfscript>
Conflict1c = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourc = createTimeSpan(0,0,30,0);    
    end_conflict1c = Conflict1c + new_hourc;
</cfscript>	
<!--- Half Hour Before Meeting --->
<cfscript>
Conflict1d = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourd = createTimeSpan(0,0,30,0);    
    end_conflict1d = Conflict1d - new_hourd;
</cfscript>	

<cfif #check_avail1.allday# is 1>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this day off.<br><br>
Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfset error = 'mod1'>

<cfelse>
	         
<cfif #TimeFormat(new_data.Time, "hh:mm tt")# eq '#TimeFormat(check_avail1.availfromtime, "hh:mm tt")#' or #TimeFormat(end_conflict1d, "hh:mm tt")# eq '#TimeFormat(check_avail1.availfromtime, "hh:mm tt")#' or #TimeFormat(end_conflict1c, "hh:mm tt")# eq '#TimeFormat(check_avail1.availtotime, "hh:mm tt")#'> 
<cfset error = 'mod1'>

<cfif #check_avail1.MeetingCode# is ''>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this time off. Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfelse>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# is in meeting #Left(check_avail1.MeetingCode, 9)# from #TimeFormat(check_avail1.availfromtime, "h:mm tt")# to #TimeFormat(check_avail1.availtotime, "h:mm tt")#. Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
</cfif>

<cfelseif 
#TimeFormat(end_conflict1b, "hh:mm tt")# eq '#TimeFormat(check_avail1.availfromtime, "hh:mm tt")#' or #TimeFormat(end_conflict1a, "hh:mm tt")# eq '#TimeFormat(check_avail1.availtotime, "hh:mm tt")#'> 
<cfset error = 'w'>

<font color="FF0000"><strong>Warning!</strong></font> #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# has been added to #Left(newMeetingCode, 9)#, #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")# however, #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# is in meeting #Left(check_avail1.MeetingCode, 9)# from #TimeFormat(check_avail1.availfromtime, "h:mm tt")# to #TimeFormat(check_avail1.availtotime, "h:mm tt")#.<br><hr size="1"><br>

</cfif> 
</cfif>
</cfif>
			
			<cfelse>					
	
					
					
		<cfif mod1id.recordcount eq 0>	<center>
	The Moderator Name - <strong>#new_data.Moderator1FirstName# #new_data.Moderator1LastName# </strong> for #new_data.MeetingCode# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")# was not found in the database. <br><br>Please ajust your spreadsheet and re-load it. 

<cfset error = 'mod1'>
	</center><br><hr size="1"><br>
</cfif>			

<cfquery name="associated_mods1" datasource="#application.speakerDSN#">
	 Select 
sp.speakerid, 
sc.ClientId, 
sc.ClientCode 

From Speaker sp, 
SpeakerClients sc 
Where 
sp.speakerid = '#mod1id.speakerid#' and
sp.type = 'MOD' and 
sc.SpeakerId = sp.speakerid and
sc.ClientCode = '#Left(newMeetingCode, 5)#'
Order by lastname
          </cfquery> 
	
	<cfif associated_mods1.recordcount eq 0>	<center>
	The Moderator - <strong>#new_data.Moderator1FirstName# #new_data.Moderator1LastName#</strong> is not associated with  Project <strong>"#new_data.MeetingCode#"</strong>.<br> <a href="javascript:openpopup5('add_mod2.cfm?speakerid=#mod1id.speakerid#&meeting=#Left(newMeetingCode, 9)#')"><u>Click Here</u></a> to add him/her to this project. Then re-load this page.

<cfset error = 'mod1'>
	</center><br><hr size="1"><br>
</cfif>	

<cfquery name="check_schedule_mod1" datasource="#application.projdsn#"> 
select speakerid
from ScheduleSpeaker		
where MeetingCode = '#newMeetingCode#' and type ='MOD' and
speakerid != '#mod1id.speakerid#' 
 
 <CFIF IsDefined("mod2id.speakerid")> and speakerid != '#mod2id.speakerid#'</cfif> 
			</cfquery>
			<cfif check_schedule_mod1.recordcount eq 0>
		
		 <cfif error is not 'mod1'> 	
		

<!-------------------------------------- Check for Meeting Conflict ----------------------------------------->
<cfquery name="check_avail1" datasource="#application.speakerDSN#">
Select 
SpeakerID,
availfromdate,
availtodate,
availfromtime,
availtotime,
availtype,
allday,
MeetingCode

From SpeakerAvailable 
 
Where 
MeetingCode != '#newmeetingcode#' and
SpeakerID ='#mod1id.speakerid#' and
availfromdate = '#DateFormat(new_data.Date, "m/d/yyyy")#'
</cfquery> 

<cfif check_avail1.recordcount gte 1>

<!--- One Hour After Meeting --->
<cfscript>Conflict1a = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_houra = createTimeSpan(0,1,0,0);    
    end_conflict1a = Conflict1a + new_houra;
</cfscript>
<!--- One Hour Before Meeting --->
<cfscript>
Conflict1b = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourb = createTimeSpan(0,1,0,0);    
    end_conflict1b = Conflict1b - new_hourb;
</cfscript>
<!--- Half Hour After Meeting --->
<cfscript>
Conflict1c = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourc = createTimeSpan(0,0,30,0);    
    end_conflict1c = Conflict1c + new_hourc;
</cfscript>	
<!--- Half Hour Before Meeting --->
<cfscript>
Conflict1d = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourd = createTimeSpan(0,0,30,0);    
    end_conflict1d = Conflict1d - new_hourd;
</cfscript>		

<cfif #check_avail1.allday# is 1>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this day off.<br><br>
Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfset error = 'mod1'>

<cfelse>

         
<cfif #TimeFormat(new_data.Time, "hh:mm tt")# eq '#TimeFormat(check_avail1.availfromtime, "hh:mm tt")#' or #TimeFormat(end_conflict1d, "hh:mm tt")# eq '#TimeFormat(check_avail1.availfromtime, "hh:mm tt")#' or #TimeFormat(end_conflict1c, "hh:mm tt")# eq '#TimeFormat(check_avail1.availtotime, "hh:mm tt")#'> 
<cfset error = 'mod1'>

<cfif #check_avail1.MeetingCode# is ''>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this time off. Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfelse>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# is in meeting #Left(check_avail1.MeetingCode, 9)# from #TimeFormat(check_avail1.availfromtime, "h:mm tt")# to #TimeFormat(check_avail1.availtotime, "h:mm tt")#. Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
</cfif>

<cfelseif 
#TimeFormat(end_conflict1b, "hh:mm tt")# eq '#TimeFormat(check_avail1.availfromtime, "hh:mm tt")#' or #TimeFormat(end_conflict1a, "hh:mm tt")# eq '#TimeFormat(check_avail1.availtotime, "hh:mm tt")#'>
<cfset error = 'w'> 

<font color="FF0000"><strong>Warning!</strong></font> #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# has been added to #Left(newMeetingCode, 9)#, #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")# however, #Trim(new_data.Moderator1FirstName)# #Trim(new_data.Moderator1LastName)# is in meeting #Left(check_avail1.meetingcode, 9)# from #TimeFormat(check_avail1.availfromtime, "h:mm tt")# to #TimeFormat(check_avail1.availtotime, "h:mm tt")#.<br><hr size="1"><br>
</cfif> 
</cfif> 
</cfif>
<cfif error is not 'mod1'>
  <cfquery name="insert_mod1" datasource="#application.projdsn#"> 
						Insert Into ScheduleSpeaker(   
							ScheduleID,
							MeetingCode,
							MeetingDate,
							MtgStartTime,
							MtgEndTime,	
							SpeakerID,
							Type,
							activityType,	  
							Confirmed
							   
						 ) 		
									VALUES(
							'#new_ScheduleID.scheduleID#',
							'#newMeetingCode#',
							'#DateFormat(new_data.Date, "m/d/yyyy")#',
							'#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "h:mm:ss tt")#',
							'#DateFormat(new_data.Date, "m/d/yyyy")# #MeetingEndTime#',	
							'#mod1id.speakerid#',
							'MOD',
							'Lead',
							'1'
									)
					</cfquery>   
					<cfquery name="insert_unavailability1" datasource="#application.speakerDSN#">
INSERT into SpeakerAvailable 
       (
		speakerID, 
		availfromdate, 
		availtodate, 
		availfromtime,
		availtotime,
		allday,
		availtype,
		updated,
		updatedby,
		MeetingCode
		)
        VALUES 
        (
		'#mod1id.SpeakerID#',
		'#DateFormat(new_data.Date, "m/d/yyyy")#',
		'#DateFormat(new_data.Date, "m/d/yyyy")# ',	
		'#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "hh:mm:ss tt")#',
		'#DateFormat(new_data.Date, "m/d/yyyy")# #MeetingEndTime#',
		'0',
		'NA',
		'#update_log#',
		'#session.user#',
		'#newMeetingCode#'
				)
</cfquery></cfif>
					</cfif>
					
	     <cfelse>	
		 
		<cfif error is not 'mod1'>
		
		<!--- Update Unavailabilty --->
	   <cfquery name="update_unavailability1" datasource="#application.speakerDSN#">
       UPDATE SpeakerAvailable 
       SET
	   speakerID = '#mod1id.speakerid#'
	   Where 
       meetingCode = '#newMeetingCode#' and
       availfromdate = '#DateFormat(new_data.Date, "m/d/yyyy")#' and	
       availfromtime = '#TimeFormat(new_data.Time, "h:mm:ss tt")#'
      </cfquery>
	  
	    <!--- Update Speaker --->
	    <cfquery name="update_spkr1" datasource="#application.projdsn#"> 
	     UPDATE ScheduleSpeaker
	     SET
		 speakerid = '#mod1id.speakerid#' 
		 WHERE meetingCode = '#newMeetingCode#' and type = 'MOD' 
	  </cfquery>  
	   <!--- Update Master --->
	    <cfquery name="update_mod1" datasource="#application.projdsn#"> 
	     UPDATE ScheduleMaster
	     SET
		 LastUpdated = '#update_log#',
		 UpdatedBy = '#session.user#' 
		 WHERE MeetingCode = '#newMeetingCode#' 
	  </cfquery> 
	  
	  </cfif>
	     </cfif>
		 		</cfif>			
<cfelse>
 <!---  Nothing To Insert in Moderator 1 --->
</cfif> 	
</cfif>	
</cfif>

<!---------------------------------------------MOD 2---------------------------------------->
			
<cfif #check_meeting_code.recordcount# is 0>	
			
				<cfif #new_data.Moderator2LastName# is not ''>					
					<cfquery name="mod2id" datasource="#application.speakerDSN#">
						select speakerid
									from Speaker	
									where 
									lastname = '#Trim(new_data.Moderator2LastName)#' and
									firstname = '#Trim(new_data.Moderator2FirstName)#' and type= 'MOD'
					</cfquery>						
							
			<cfif mod2id.recordcount eq 0>	
			<center>
	The Moderator Name - <strong>#new_data.moderator2FirstName# #new_data.moderator2LastName# </strong> for #new_data.MeetingCode# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#  was not found in the database. <br><br>Please ajust your spreadsheet and re-load it.

<cfset error = 'mod2'>
	</center><br><hr size="1"><br>	
</cfif>	
	
	<cfquery name="associated_mods2" datasource="#application.speakerDSN#">
Select 
sp.speakerid, 
sc.ClientId, 
sc.ClientCode 

From Speaker sp, 
SpeakerClients sc 
Where 
sp.speakerid = '#mod2id.speakerid#' and
sp.type = 'MOD' and 
sc.SpeakerId = sp.speakerid and
sc.ClientCode = '#Left(newMeetingCode, 5)#'
Order by lastname
          </cfquery> 
	
	<cfif associated_mods2.recordcount eq 0>	<center>
	The Moderator - <strong>#new_data.Moderator2FirstName# #new_data.Moderator2LastName#</strong> is not associated with  Project <strong>"#new_data.MeetingCode#"</strong>.<br> <a href="javascript:openpopup5('add_mod2.cfm?speakerid=#mod2id.speakerid#&meeting=#Left(newMeetingCode, 9)#')"><u>Click Here</u></a> to add him/her to this project. Then re-load this page. 

<cfset error = 'mod2'>
	</center><br><hr size="1"><br>
</cfif>			
						
<cfif error is not 'mod2'> 
<!-------------------------------------- Check for Meeting Conflict ----------------------------------------->
<cfquery name="check_avail2" datasource="#application.speakerDSN#">
Select 
SpeakerID,
availfromdate,
availtodate,
availfromtime,
availtotime,
availtype,
allday,
MeetingCode

From SpeakerAvailable 
 
Where 
MeetingCode != '#newmeetingcode#' and
SpeakerID ='#mod2id.speakerid#' and
availfromdate = '#DateFormat(new_data.Date, "m/d/yyyy")#'
</cfquery> 

<cfif check_avail2.recordcount gte 1>

<!--- One Hour After Meeting --->
<cfscript>Conflict2a = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_houra = createTimeSpan(0,1,0,0);    
    end_Conflict2a = Conflict2a + new_houra;
</cfscript>
<!--- One Hour Before Meeting --->
<cfscript>
Conflict2b = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourb = createTimeSpan(0,1,0,0);    
    end_Conflict2b = Conflict2b - new_hourb;
</cfscript>
<!--- Half Hour After Meeting --->
<cfscript>
Conflict2c = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourc = createTimeSpan(0,0,30,0);    
    end_Conflict2c = Conflict2c + new_hourc;
</cfscript>	
<!--- Half Hour Before Meeting --->
<cfscript>
Conflict2d = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourd = createTimeSpan(0,0,30,0);    
    end_Conflict2d = Conflict2d - new_hourd;
</cfscript>		

<cfif #check_avail2.allday# is 1>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this day off.<br><br>
Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfset error = 'mod2'>

<cfelse>
         
<cfif #TimeFormat(new_data.Time, "hh:mm tt")# eq '#TimeFormat(check_avail2.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict2d, "hh:mm tt")# eq '#TimeFormat(check_avail2.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict2c, "hh:mm tt")# eq '#TimeFormat(check_avail2.availtotime, "hh:mm tt")#'> 
<cfset error = 'mod2'>

<cfif #check_avail2.MeetingCode# is ''>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this time off. Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfelse>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)# is in meeting #Left(check_avail2.MeetingCode, 9)# from #TimeFormat(check_avail2.availfromtime, "h:mm tt")# to #TimeFormat(check_avail2.availtotime, "h:mm tt")#. Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
</cfif>


<cfelseif 
#TimeFormat(end_Conflict2b, "hh:mm tt")# eq '#TimeFormat(check_avail2.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict2a, "hh:mm tt")# eq '#TimeFormat(check_avail2.availtotime, "hh:mm tt")#'> 
<cfset error = 'w'>

<font color="FF0000"><strong>Warning!</strong></font> #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)# has been added to #Left(newMeetingCode, 9)#, #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")# however, #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)#is in meeting #Left(check_avail2.meetingcode, 9)# from #TimeFormat(check_avail2.availfromtime, "h:mm tt")# to #TimeFormat(check_avail2.availtotime, "h:mm tt")#.

<br><hr size="1"><br>
</cfif> 
</cfif>
</cfif>
<!-------------------------------------- Insert Moderator-----------------------------------------> 
<cfif error is not 'mod2'>
					 <cfquery name="insert_mod2" datasource="#application.projdsn#"> 
						Insert Into ScheduleSpeaker(   
							ScheduleID,
							MeetingCode,
							MeetingDate,
							MtgStartTime,
							MtgEndTime,	
							SpeakerID,
							Type,
							activityType,	  
							Confirmed
							   
						 ) 		
									VALUES(
							'#new_ScheduleID.scheduleID#',
							'#newMeetingCode#',
							'#DateFormat(new_data.Date, "m/d/yyyy")#',
							'#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "h:mm:ss tt")#',
							'#DateFormat(new_data.Date, "m/d/yyyy")# #MeetingEndTime#',	
							'#mod2id.speakerid#',
							'MOD',
							'Lead',
							'1'
									)
					</cfquery>  
					<cfquery name="insert_unavailability1" datasource="#application.speakerDSN#">
INSERT into SpeakerAvailable 
       (
		speakerID, 
		availfromdate, 
		availtodate, 
		availfromtime,
		availtotime,
		allday,
		availtype,
		updated,
		updatedby,
		MeetingCode
		)
        VALUES 
        (
		'#mod2id.SpeakerID#',
		'#DateFormat(new_data.Date, "m/d/yyyy")#',
		'#DateFormat(new_data.Date, "m/d/yyyy")# ',	
		'#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "hh:mm:ss tt")#',
		'#DateFormat(new_data.Date, "m/d/yyyy")# #MeetingEndTime#',
		'0',
		'NA',
		'#update_log#',
		'#session.user#',
		'#newMeetingCode#'
				)
</cfquery>
		</cfif>			
					</cfif>
						
				</cfif>
				<!--- Have a meeting Code and mod2 is not blank --->
<cfelse>

	<!--- Mod 1 NULL delete it --->
					
			<cfif #Trim(new_data.moderator2LastName)# is 'NULL' or #Trim(new_data.moderator2FirstName)# is 'Null'>
<cfquery name="delete_mod2" datasource="#application.projdsn#">
						delete
						from ScheduleSpeaker
						Where MeetingCode = '#newmeetingcode#' and Type = 'MOD'
						
					</cfquery>
					
		<cfquery name="delete_mod2" datasource="#application.projdsn#">
			 
	     UPDATE Schedule
	     SET  
		 moderator2FirstName ='', 
		 moderator2LastName =''
		 WHERE RowID = '#new_data.RowID#'
	  </cfquery> 
	  
<cfquery name="delete_availmod2" datasource="#application.speakerDSN#">			 
	     delete from SpeakerAvailable
	     where	
		 MeetingCode = '#newmeetingcode#' and	 
		 availfromdate =  '#DateFormat(new_data.Date, "m/d/yyyy")#' and
		 availfromtime = '#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "h:mm:ss tt")#'
</cfquery>
	  
								
			<cfelse>
		
<cfif #new_data.moderator2LastName# is not ''>
<cfquery name="mod2id" datasource="#application.speakerDSN#">
						select speakerid
									from Speaker	
									where 
									lastname = '#Trim(new_data.moderator2LastName)#' and
									firstname = '#Trim(new_data.moderator2FirstName)#' and type= 'MOD'
					</cfquery>					
					<cfquery name="mod2id2" datasource="#application.projdsn#">
						select speakerid
						from ScheduleSpeaker
						Where MeetingCode = '#newmeetingcode#' and Type = 'Mod' and speakerid = '#mod2id.speakerid#'									
					</cfquery>
					
	<cfif #mod2id2.recordcount# is 1>	
	
	
	<!---  Mod 2 Exist dont do Anything --->
	
	<!-------------------------------------- Check for Meeting Conflict ----------------------------------------->
<cfquery name="check_avail2" datasource="#application.speakerDSN#">
Select 
SpeakerID,
availfromdate,
availtodate,
availfromtime,
availtotime,
availtype,
allday,
MeetingCode

From SpeakerAvailable 
 
Where 
MeetingCode != '#newmeetingcode#' and
SpeakerID ='#mod2id.speakerid#' and
availfromdate = '#DateFormat(new_data.Date, "m/d/yyyy")#'
</cfquery> 

<cfif check_avail2.recordcount gte 1>

<!--- One Hour After Meeting --->
<cfscript>Conflict2a = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_houra = createTimeSpan(0,1,0,0);    
    end_Conflict2a = Conflict2a + new_houra;
</cfscript>
<!--- One Hour Before Meeting --->
<cfscript>
Conflict2b = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourb = createTimeSpan(0,1,0,0);    
    end_Conflict2b = Conflict2b - new_hourb;
</cfscript>
<!--- Half Hour After Meeting --->
<cfscript>
Conflict2c = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourc = createTimeSpan(0,0,30,0);    
    end_Conflict2c = Conflict2c + new_hourc;
</cfscript>	
<!--- Half Hour Before Meeting --->
<cfscript>
Conflict2d = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourd = createTimeSpan(0,0,30,0);    
    end_Conflict2d = Conflict2d - new_hourd;
</cfscript>	

<cfif #check_avail2.allday# is 1>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this day off.<br><br>
Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfset error = 'mod2'>

<cfelse>
	         
<cfif #TimeFormat(new_data.Time, "hh:mm tt")# eq '#TimeFormat(check_avail2.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict2d, "hh:mm tt")# eq '#TimeFormat(check_avail2.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict2c, "hh:mm tt")# eq '#TimeFormat(check_avail2.availtotime, "hh:mm tt")#'> 
<cfset error = 'mod2'>

<cfif #check_avail2.MeetingCode# is ''>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this time off. Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfelse>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)# is in meeting #Left(check_avail2.MeetingCode, 9)# from #TimeFormat(check_avail2.availfromtime, "h:mm tt")# to #TimeFormat(check_avail2.availtotime, "h:mm tt")#. Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
</cfif>

<cfelseif 
#TimeFormat(end_Conflict2b, "hh:mm tt")# eq '#TimeFormat(check_avail2.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict2a, "hh:mm tt")# eq '#TimeFormat(check_avail2.availtotime, "hh:mm tt")#'> 
<cfset error = 'w'>

<font color="FF0000"><strong>Warning!</strong></font> #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)# has been added to #Left(newMeetingCode, 9)#, #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")# however, #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)# is in meeting #Left(check_avail2.MeetingCode, 9)# from #TimeFormat(check_avail2.availfromtime, "h:mm tt")# to #TimeFormat(check_avail2.availtotime, "h:mm tt")#.<br><hr size="1"><br>

</cfif> 
</cfif>
</cfif>
			
			<cfelse>					
	
					
					
		<cfif mod2id.recordcount eq 0>	<center>
	The Moderator Name - <strong>#new_data.moderator2FirstName# #new_data.moderator2LastName# </strong> for #new_data.MeetingCode# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")# was not found in the database. <br><br>Please ajust your spreadsheet and re-load it. 

<cfset error = 'mod2'>
	</center><br><hr size="1"><br>
</cfif>			

<cfquery name="associated_mods2" datasource="#application.speakerDSN#">
	 Select 
sp.speakerid, 
sc.ClientId, 
sc.ClientCode 

From Speaker sp, 
SpeakerClients sc 
Where 
sp.speakerid = '#mod2id.speakerid#' and
sp.type = 'MOD' and 
sc.SpeakerId = sp.speakerid and
sc.ClientCode = '#Left(newMeetingCode, 5)#'
Order by lastname
          </cfquery> 
	
	<cfif associated_mods2.recordcount eq 0>	<center>
	The Moderator - <strong>#new_data.moderator2FirstName# #new_data.moderator2LastName#</strong> is not associated with  Project <strong>"#new_data.MeetingCode#"</strong>.<br> <a href="javascript:openpopup5('add_mod2.cfm?speakerid=#mod2id.speakerid#&meeting=#Left(newMeetingCode, 9)#')"><u>Click Here</u></a> to add him/her to this project. Then re-load this page.

<cfset error = 'mod2'>
	</center><br><hr size="1"><br>
</cfif>	

<cfquery name="check_schedule_mod2" datasource="#application.projdsn#"> 
select speakerid
from ScheduleSpeaker		
where MeetingCode = '#newMeetingCode#' and type ='MOD' and
speakerid != '#mod2id.speakerid#' 
 
 <CFIF IsDefined("mod2id.speakerid")> and speakerid != '#mod2id.speakerid#'</cfif> 
			</cfquery>
			<cfif check_schedule_mod2.recordcount eq 0>
		
		 <cfif error is not 'mod2'> 	
	

<!-------------------------------------- Check for Meeting Conflict ----------------------------------------->
<cfquery name="check_avail2" datasource="#application.speakerDSN#">
Select 
SpeakerID,
availfromdate,
availtodate,
availfromtime,
availtotime,
availtype,
allday,
MeetingCode

From SpeakerAvailable 
 
Where 
MeetingCode != '#newmeetingcode#' and
SpeakerID ='#mod2id.speakerid#' and
availfromdate = '#DateFormat(new_data.Date, "m/d/yyyy")#'
</cfquery> 

<cfif check_avail2.recordcount gte 1>

<!--- One Hour After Meeting --->
<cfscript>Conflict2a = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_houra = createTimeSpan(0,1,0,0);    
    end_Conflict2a = Conflict2a + new_houra;
</cfscript>
<!--- One Hour Before Meeting --->
<cfscript>
Conflict2b = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourb = createTimeSpan(0,1,0,0);    
    end_Conflict2b = Conflict2b - new_hourb;
</cfscript>
<!--- Half Hour After Meeting --->
<cfscript>
Conflict2c = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourc = createTimeSpan(0,0,30,0);    
    end_Conflict2c = Conflict2c + new_hourc;
</cfscript>	
<!--- Half Hour Before Meeting --->
<cfscript>
Conflict2d = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourd = createTimeSpan(0,0,30,0);    
    end_Conflict2d = Conflict2d - new_hourd;
</cfscript>		

<cfif #check_avail2.allday# is 1>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this day off.<br><br>
Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfset error = 'mod2'>

<cfelse>

         
<cfif #TimeFormat(new_data.Time, "hh:mm tt")# eq '#TimeFormat(check_avail2.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict2d, "hh:mm tt")# eq '#TimeFormat(check_avail2.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict2c, "hh:mm tt")# eq '#TimeFormat(check_avail2.availtotime, "hh:mm tt")#'> 
<cfset error = 'mod2'>

<cfif #check_avail2.MeetingCode# is ''>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this time off. Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfelse>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)# is in meeting #Left(check_avail2.MeetingCode, 9)# from #TimeFormat(check_avail2.availfromtime, "h:mm tt")# to #TimeFormat(check_avail2.availtotime, "h:mm tt")#. Please modify your entry, or check this Moderators availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#mod2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
</cfif>

<cfelseif 
#TimeFormat(end_Conflict2b, "hh:mm tt")# eq '#TimeFormat(check_avail2.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict2a, "hh:mm tt")# eq '#TimeFormat(check_avail2.availtotime, "hh:mm tt")#'>
<cfset error = 'w'> 

<font color="FF0000"><strong>Warning!</strong></font> #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)# has been added to #Left(newMeetingCode, 9)#, #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")# however, #Trim(new_data.moderator2FirstName)# #Trim(new_data.moderator2LastName)# is in meeting #Left(check_avail2.meetingcode, 9)# from  #TimeFormat(check_avail2.availfromtime, "h:mm tt")# to #TimeFormat(check_avail2.availtotime, "h:mm tt")#.<br><hr size="1"><br>
</cfif> 
</cfif> 
</cfif>
<cfif error is not 'mod2'>
  <cfquery name="insert_mod2" datasource="#application.projdsn#"> 
						Insert Into ScheduleSpeaker(   
							ScheduleID,
							MeetingCode,
							MeetingDate,
							MtgStartTime,
							MtgEndTime,	
							SpeakerID,
							Type,
							activityType,	  
							Confirmed
							   
						 ) 		
									VALUES(
							'#new_ScheduleID.scheduleID#',
							'#newMeetingCode#',
							'#DateFormat(new_data.Date, "m/d/yyyy")#',
							'#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "h:mm:ss tt")#',
							'#DateFormat(new_data.Date, "m/d/yyyy")# #MeetingEndTime#',	
							'#mod2id.speakerid#',
							'MOD',
							'Lead',
							'1'
									)
					</cfquery>   
					<cfquery name="insert_unavailability1" datasource="#application.speakerDSN#">
INSERT into SpeakerAvailable 
       (
		speakerID, 
		availfromdate, 
		availtodate, 
		availfromtime,
		availtotime,
		allday,
		availtype,
		updated,
		updatedby,
		MeetingCode
		)
        VALUES 
        (
		'#mod2id.SpeakerID#',
		'#DateFormat(new_data.Date, "m/d/yyyy")#',
		'#DateFormat(new_data.Date, "m/d/yyyy")# ',	
		'#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "hh:mm:ss tt")#',
		'#DateFormat(new_data.Date, "m/d/yyyy")# #MeetingEndTime#',
		'0',
		'NA',
		'#update_log#',
		'#session.user#',
		'#newMeetingCode#'
				)
</cfquery></cfif>
					</cfif>
					
	     <cfelse>	
		 

		<cfif error is not 'mod2'>
		
		<!--- Update Unavailabilty --->
	   <cfquery name="update_unavailability1" datasource="#application.speakerDSN#">
       UPDATE SpeakerAvailable 
       SET
	   speakerID = '#mod2id.speakerid#'
	   Where 
       meetingCode = '#newMeetingCode#' and
       availfromdate = '#DateFormat(new_data.Date, "m/d/yyyy")#' and	
       availfromtime = '#TimeFormat(new_data.Time, "h:mm:ss tt")#'
      </cfquery>
	  
	    <!--- Update Speaker --->
	    <cfquery name="update_spkr1" datasource="#application.projdsn#"> 
	     UPDATE ScheduleSpeaker
	     SET
		 speakerid = '#mod2id.speakerid#' 
		 WHERE meetingCode = '#newMeetingCode#' and type = 'MOD' 
	  </cfquery>  
	   <!--- Update Master --->
	    <cfquery name="update_mod2" datasource="#application.projdsn#"> 
	     UPDATE ScheduleMaster
	     SET
		 LastUpdated = '#update_log#',
		 UpdatedBy = '#session.user#' 
		 WHERE MeetingCode = '#newMeetingCode#' 
	  </cfquery> 
	  
	  </cfif>
	     </cfif>
		 		</cfif>			
<cfelse>
 <!---  Nothing To Insert in Moderator 1 --->
</cfif> 	
</cfif>	
</cfif>
 
 			<!---------------------------------------------SPKR 1---------------------------------------->		
		
<cfif #check_meeting_code.recordcount# is 0>	
			
				<cfif #new_data.Speaker1LastName# is not ''>					
					<cfquery name="spkr1id" datasource="#application.speakerDSN#">
						select speakerid
									from Speaker	
									where 
									lastname = '#Trim(new_data.Speaker1LastName)#' and
									firstname = '#Trim(new_data.Speaker1FirstName)#' and type= 'SPKR'
					</cfquery>						
							
			<cfif spkr1id.recordcount eq 0>	
			<center>
	The Speaker Name - <strong>#new_data.Speaker1FirstName# #new_data.Speaker1LastName# </strong> for #new_data.MeetingCode# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#  was not found in the database. <br><br>Please ajust your spreadsheet and re-load it.

<cfset error = 'spkr1'>
	</center><br><hr size="1"><br>	
</cfif>	
	
	<cfquery name="associated_spkrs1" datasource="#application.speakerDSN#">
Select 
sp.speakerid, 
sc.ClientId, 
sc.ClientCode 

From Speaker sp, 
SpeakerClients sc 
Where 
sp.speakerid = '#spkr1id.speakerid#' and
sp.type = 'SPKR' and 
sc.SpeakerId = sp.speakerid and
sc.ClientCode = '#Left(newMeetingCode, 5)#'
Order by lastname
          </cfquery> 
	
	<cfif associated_spkrs1.recordcount eq 0>	<center>
	The Speaker - <strong>#new_data.Speaker1FirstName# #new_data.Speaker1LastName#</strong> is not associated with  Project <strong>"#new_data.MeetingCode#"</strong>.<br> <a href="javascript:openpopup5('add_spker2.cfm?speakerid=#spkr1id.speakerid#&meeting=#Left(newMeetingCode, 9)#')"><u>Click Here</u></a> to add him/her to this project. Then re-load this page. 

<cfset error = 'spkr1'>
	</center><br><hr size="1"><br>
</cfif>			
						
<cfif error is not 'spkr1'> 
<!-------------------------------------- Check for Meeting Conflict ----------------------------------------->
<cfquery name="check_avail3" datasource="#application.speakerDSN#">
Select 
SpeakerID,
availfromdate,
availtodate,
availfromtime,
availtotime,
availtype,
allday,
MeetingCode

From SpeakerAvailable 
Where 
MeetingCode != '#newmeetingcode#' and
SpeakerID ='#spkr1id.speakerid#' and
availfromdate = '#DateFormat(new_data.Date, "m/d/yyyy")#' 
</cfquery> 

<cfif check_avail3.recordcount gte 1>

<!--- One Hour After Meeting --->
<cfscript>Conflict3A = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_houra = createTimeSpan(0,1,0,0);    
    end_Conflict3A = Conflict3A + new_houra;
</cfscript>
<!--- One Hour Before Meeting --->
<cfscript>
Conflict3B = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourb = createTimeSpan(0,1,0,0);    
    end_Conflict3B = Conflict3B - new_hourb;
</cfscript>
<!--- Half Hour After Meeting --->
<cfscript>
Conflict3C = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourc = createTimeSpan(0,0,30,0);    
    end_Conflict3C = Conflict3C + new_hourc;
</cfscript>	
<!--- Half Hour Before Meeting --->
<cfscript>
Conflict3D = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourd = createTimeSpan(0,0,30,0);    
    end_Conflict3D = Conflict3D - new_hourd;
</cfscript>		

<cfif #check_avail3.allday# is 1>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this day off.<br><br>
Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfset error = 'spkr1'>

<cfelse>
         
<cfif #TimeFormat(new_data.Time, "hh:mm tt")# eq '#TimeFormat(check_avail3.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict3D, "hh:mm tt")# eq '#TimeFormat(check_avail3.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict3C, "hh:mm tt")# eq '#TimeFormat(check_avail3.availtotime, "hh:mm tt")#'> 
<cfset error = 'spkr1'>

<cfif #check_avail3.MeetingCode# is ''>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this time off. Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfelse>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)# is in meeting #Left(check_avail3.MeetingCode, 9)# from #TimeFormat(check_avail3.availfromtime, "h:mm tt")# to #TimeFormat(check_avail3.availtotime, "h:mm tt")#. Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
</cfif>


<cfelseif 
#TimeFormat(end_Conflict3B, "hh:mm tt")# eq '#TimeFormat(check_avail3.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict3A, "hh:mm tt")# eq '#TimeFormat(check_avail3.availtotime, "hh:mm tt")#'> 
<cfset error = 'w'>

<font color="FF0000"><strong>Warning!</strong></font> #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)# has been added to #Left(newMeetingCode, 9)#, #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")# however, #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)#is in meeting #Left(check_avail3.meetingcode, 9)# from #TimeFormat(check_avail3.availfromtime, "h:mm tt")# to #TimeFormat(check_avail3.availtotime, "h:mm tt")#.

<br><hr size="1"><br>
</cfif> 
</cfif>
</cfif>
<!-------------------------------------- Insert Speaker-----------------------------------------> 
<cfif error is not 'spkr1'>
					 <cfquery name="insert_spkr1" datasource="#application.projdsn#"> 
						Insert Into ScheduleSpeaker(   
							ScheduleID,
							MeetingCode,
							MeetingDate,
							MtgStartTime,
							MtgEndTime,	
							SpeakerID,
							Type,
							activityType,	  
							Confirmed
							   
						 ) 		
									VALUES(
							'#new_ScheduleID.scheduleID#',
							'#newMeetingCode#',
							'#DateFormat(new_data.Date, "m/d/yyyy")#',
							'#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "h:mm:ss tt")#',
							'#DateFormat(new_data.Date, "m/d/yyyy")# #MeetingEndTime#',	
							'#spkr1id.speakerid#',
							'SPKR',
							'Lead',
							'1'
									)
					</cfquery>  
					<cfquery name="insert_unavailability1" datasource="#application.speakerDSN#">
INSERT into SpeakerAvailable 
       (
		speakerID, 
		availfromdate, 
		availtodate, 
		availfromtime,
		availtotime,
		allday,
		availtype,
		updated,
		updatedby,
		MeetingCode
		)
        VALUES 
        (
		'#spkr1id.SpeakerID#',
		'#DateFormat(new_data.Date, "m/d/yyyy")#',
		'#DateFormat(new_data.Date, "m/d/yyyy")# ',	
		'#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "hh:mm:ss tt")#',
		'#DateFormat(new_data.Date, "m/d/yyyy")# #MeetingEndTime#',
		'0',
		'NA',
		'#update_log#',
		'#session.user#',
		'#newMeetingCode#'
				)
</cfquery>
		</cfif>			
					</cfif>
						
				</cfif>
				<!--- Have a meeting Code and spkr1 is not blank --->
<cfelse>

	<!--- spkr1 NULL delete it --->
					
			<cfif #Trim(new_data.Speaker1LastName)# is 'NULL' or #Trim(new_data.Speaker1FirstName)# is 'Null'>
<cfquery name="delete_spkr1" datasource="#application.projdsn#">
						delete
						from ScheduleSpeaker
						Where MeetingCode = '#newmeetingcode#' and Type = 'SPKR'
						
					</cfquery>
					
		<cfquery name="delete_spkr1" datasource="#application.projdsn#">
			 
	     UPDATE Schedule
	     SET  
		 Speaker1FirstName ='', 
		 Speaker1LastName =''
		 WHERE RowID = '#new_data.RowID#'
	  </cfquery> 
	  
<cfquery name="delete_availspkr1" datasource="#application.speakerDSN#">			 
	     delete from SpeakerAvailable
	     where	
		 MeetingCode = '#newmeetingcode#' and	 
		 availfromdate =  '#DateFormat(new_data.Date, "m/d/yyyy")#' and
		 availfromtime = '#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "h:mm:ss tt")#'
</cfquery>
	  
								
			<cfelse>
		
<cfif #new_data.Speaker1LastName# is not ''>
<cfquery name="spkr1id" datasource="#application.speakerDSN#">
						select speakerid
									from Speaker	
									where 
									lastname = '#Trim(new_data.Speaker1LastName)#' and
									firstname = '#Trim(new_data.Speaker1FirstName)#' and type= 'SPKR'
					</cfquery>					
					<cfquery name="spkr1id2" datasource="#application.projdsn#">
						select speakerid
						from ScheduleSpeaker
						Where MeetingCode = '#newmeetingcode#' and Type = 'SPKR' and speakerid = '#spkr1id.speakerid#'									
					</cfquery>
					
	<cfif #spkr1id2.recordcount# is 1>	
	
	
	<!---  spkr1 Exist dont do Anything --->
	
	<!-------------------------------------- Check for Meeting Conflict ----------------------------------------->
<cfquery name="check_avail3" datasource="#application.speakerDSN#">
Select 
SpeakerID,
availfromdate,
availtodate,
availfromtime,
availtotime,
availtype,
allday,
MeetingCode

From SpeakerAvailable 
Where 
MeetingCode != '#newmeetingcode#' and
SpeakerID ='#spkr1id.speakerid#' and
availfromdate = '#DateFormat(new_data.Date, "m/d/yyyy")#' 
</cfquery> 

<cfif check_avail3.recordcount gte 1>

<!--- One Hour After Meeting --->
<cfscript>Conflict3A = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_houra = createTimeSpan(0,1,0,0);    
    end_Conflict3A = Conflict3A + new_houra;
</cfscript>
<!--- One Hour Before Meeting --->
<cfscript>
Conflict3B = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourb = createTimeSpan(0,1,0,0);    
    end_Conflict3B = Conflict3B - new_hourb;
</cfscript>
<!--- Half Hour After Meeting --->
<cfscript>
Conflict3C = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourc = createTimeSpan(0,0,30,0);    
    end_Conflict3C = Conflict3C + new_hourc;
</cfscript>	
<!--- Half Hour Before Meeting --->
<cfscript>
Conflict3D = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourd = createTimeSpan(0,0,30,0);    
    end_Conflict3D = Conflict3D - new_hourd;
</cfscript>	

<cfif #check_avail3.allday# is 1>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this day off.<br><br>
Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfset error = 'spkr1'>

<cfelse>
	         
<cfif #TimeFormat(new_data.Time, "hh:mm tt")# eq '#TimeFormat(check_avail3.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict3D, "hh:mm tt")# eq '#TimeFormat(check_avail3.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict3C, "hh:mm tt")# eq '#TimeFormat(check_avail3.availtotime, "hh:mm tt")#'> 
<cfset error = 'spkr1'>

<cfif #check_avail3.MeetingCode# is ''>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this time off. Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfelse>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)# is in meeting #Left(check_avail3.MeetingCode, 9)# from #TimeFormat(check_avail3.availfromtime, "h:mm tt")# to #TimeFormat(check_avail3.availtotime, "h:mm tt")#. Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
</cfif>

<cfelseif 
#TimeFormat(end_Conflict3B, "hh:mm tt")# eq '#TimeFormat(check_avail3.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict3A, "hh:mm tt")# eq '#TimeFormat(check_avail3.availtotime, "hh:mm tt")#'> 
<cfset error = 'w'>

<font color="FF0000"><strong>Warning!</strong></font> #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)# has been added to #Left(newMeetingCode, 9)#, #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")# however, #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)# is in meeting #Left(check_avail3.MeetingCode, 9)# from #TimeFormat(check_avail3.availfromtime, "h:mm tt")# to #TimeFormat(check_avail3.availtotime, "h:mm tt")#.<br><hr size="1"><br>

</cfif> 
</cfif>
</cfif>
			
			<cfelse>					
	
					
					
		<cfif spkr1id.recordcount eq 0>	<center>
	The Speaker Name - <strong>#new_data.Speaker1FirstName# #new_data.Speaker1LastName# </strong> for #new_data.MeetingCode# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")# was not found in the database. <br><br>Please ajust your spreadsheet and re-load it. 

<cfset error = 'spkr1'>
	</center><br><hr size="1"><br>
</cfif>			

<cfquery name="associated_spkrs1" datasource="#application.speakerDSN#">
	 Select 
sp.speakerid, 
sc.ClientId, 
sc.ClientCode 

From Speaker sp, 
SpeakerClients sc 
Where 
sp.speakerid = '#spkr1id.speakerid#' and
sp.type = 'SPKR' and 
sc.SpeakerId = sp.speakerid and
sc.ClientCode = '#Left(newMeetingCode, 5)#'
Order by lastname
          </cfquery> 
	
	<cfif associated_spkrs1.recordcount eq 0>	<center>
	The Speaker - <strong>#new_data.Speaker1FirstName# #new_data.Speaker1LastName#</strong> is not associated with  Project <strong>"#new_data.MeetingCode#"</strong>.<br> <a href="javascript:openpopup5('add_spker2.cfm?speakerid=#spkr1id.speakerid#&meeting=#Left(newMeetingCode, 9)#')"><u>Click Here</u></a> to add him/her to this project. Then re-load this page. 

<cfset error = 'spkr1'>
	</center><br><hr size="1"><br>
</cfif>	

<cfquery name="check_schedule_spkr1" datasource="#application.projdsn#"> 
select speakerid
from ScheduleSpeaker		
where MeetingCode = '#newMeetingCode#' and type ='SPKR' and
speakerid != '#spkr1id.speakerid#' 
 
 <CFIF IsDefined("SPKR2id.speakerid")> and speakerid != '#SPKR2id.speakerid#'</cfif> 
			</cfquery>
			<cfif check_schedule_spkr1.recordcount eq 0>
		
		 <cfif error is not 'spkr1'> 	


<!-------------------------------------- Check for Meeting Conflict ----------------------------------------->
<cfquery name="check_avail3" datasource="#application.speakerDSN#">
Select 
SpeakerID,
availfromdate,
availtodate,
availfromtime,
availtotime,
availtype,
allday,
MeetingCode

From SpeakerAvailable 

Where 
MeetingCode != '#newmeetingcode#' and
SpeakerID ='#spkr1id.speakerid#' and
availfromdate = '#DateFormat(new_data.Date, "m/d/yyyy")#' 
</cfquery> 

<cfif check_avail3.recordcount gte 1>

<!--- One Hour After Meeting --->
<cfscript>Conflict3A = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_houra = createTimeSpan(0,1,0,0);    
    end_Conflict3A = Conflict3A + new_houra;
</cfscript>
<!--- One Hour Before Meeting --->
<cfscript>
Conflict3B = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourb = createTimeSpan(0,1,0,0);    
    end_Conflict3B = Conflict3B - new_hourb;
</cfscript>
<!--- Half Hour After Meeting --->
<cfscript>
Conflict3C = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourc = createTimeSpan(0,0,30,0);    
    end_Conflict3C = Conflict3C + new_hourc;
</cfscript>	
<!--- Half Hour Before Meeting --->
<cfscript>
Conflict3D = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourd = createTimeSpan(0,0,30,0);    
    end_Conflict3D = Conflict3D - new_hourd;
</cfscript>		

<cfif #check_avail3.allday# is 1>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this day off.<br><br>
Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfset error = 'spkr1'>

<cfelse>

         
<cfif #TimeFormat(new_data.Time, "hh:mm tt")# eq '#TimeFormat(check_avail3.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict3D, "hh:mm tt")# eq '#TimeFormat(check_avail3.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict3C, "hh:mm tt")# eq '#TimeFormat(check_avail3.availtotime, "hh:mm tt")#'> 
<cfset error = 'spkr1'>

<cfif #check_avail3.MeetingCode# is ''>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this time off. Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfelse>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)# is in meeting #Left(check_avail3.MeetingCode, 9)# from #TimeFormat(check_avail3.availfromtime, "h:mm tt")# to #TimeFormat(check_avail3.availtotime, "h:mm tt")#. Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr1id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
</cfif>

<cfelseif 
#TimeFormat(end_Conflict3B, "hh:mm tt")# eq '#TimeFormat(check_avail3.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict3A, "hh:mm tt")# eq '#TimeFormat(check_avail3.availtotime, "hh:mm tt")#'>
<cfset error = 'w'> 

<font color="FF0000"><strong>Warning!</strong></font> #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)# has been added to #Left(newMeetingCode, 9)#, #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")# however, #Trim(new_data.Speaker1FirstName)# #Trim(new_data.Speaker1LastName)# is in meeting #Left(check_avail3.meetingcode, 9)# from #TimeFormat(check_avail3.availfromtime, "h:mm tt")# to #TimeFormat(check_avail3.availtotime, "h:mm tt")#.<br><hr size="1"><br>
</cfif> 
</cfif> 
</cfif>
<cfif error is not 'spkr1'>
  <cfquery name="insert_spkr1" datasource="#application.projdsn#"> 
						Insert Into ScheduleSpeaker(   
							ScheduleID,
							MeetingCode,
							MeetingDate,
							MtgStartTime,
							MtgEndTime,	
							SpeakerID,
							Type,
							activityType,	  
							Confirmed
							   
						 ) 		
									VALUES(
							'#new_ScheduleID.scheduleID#',
							'#newMeetingCode#',
							'#DateFormat(new_data.Date, "m/d/yyyy")#',
							'#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "h:mm:ss tt")#',
							'#DateFormat(new_data.Date, "m/d/yyyy")# #MeetingEndTime#',	
							'#spkr1id.speakerid#',
							'SPKR',
							'Lead',
							'1'
									)
					</cfquery>   
					<cfquery name="insert_unavailability1" datasource="#application.speakerDSN#">
INSERT into SpeakerAvailable 
       (
		speakerID, 
		availfromdate, 
		availtodate, 
		availfromtime,
		availtotime,
		allday,
		availtype,
		updated,
		updatedby,
		MeetingCode
		)
        VALUES 
        (
		'#spkr1id.SpeakerID#',
		'#DateFormat(new_data.Date, "m/d/yyyy")#',
		'#DateFormat(new_data.Date, "m/d/yyyy")# ',	
		'#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "hh:mm:ss tt")#',
		'#DateFormat(new_data.Date, "m/d/yyyy")# #MeetingEndTime#',
		'0',
		'NA',
		'#update_log#',
		'#session.user#',
		'#newMeetingCode#'
				)
</cfquery></cfif>
					</cfif>
					
	     <cfelse>	
		 

		<cfif error is not 'spkr1'>
		
		<!--- Update Unavailabilty --->
	   <cfquery name="update_unavailability1" datasource="#application.speakerDSN#">
       UPDATE SpeakerAvailable 
       SET
	   speakerID = '#spkr1id.speakerid#'
	   Where 
       meetingCode = '#newMeetingCode#' and
       availfromdate = '#DateFormat(new_data.Date, "m/d/yyyy")#' and	
       availfromtime = '#TimeFormat(new_data.Time, "h:mm:ss tt")#'
      </cfquery>
	  
	    <!--- Update Speaker --->
	    <cfquery name="update_spkr1" datasource="#application.projdsn#"> 
	     UPDATE ScheduleSpeaker
	     SET
		 speakerid = '#spkr1id.speakerid#' 
		 WHERE meetingCode = '#newMeetingCode#' and type = 'SPKR' 
	  </cfquery>  
	   <!--- Update Master --->
	    <cfquery name="update_spkr1" datasource="#application.projdsn#"> 
	     UPDATE ScheduleMaster
	     SET
		 LastUpdated = '#update_log#',
		 UpdatedBy = '#session.user#' 
		 WHERE MeetingCode = '#newMeetingCode#' 
	  </cfquery> 
	  
	  </cfif>
	     </cfif>
		 		</cfif>			
<cfelse>
 <!---  Nothing To Insert in Speaker 1 --->
</cfif> 	
</cfif>	
</cfif>

<!---------------------------------------------SPKR 2---------------------------------------->		
			
<cfif #check_meeting_code.recordcount# is 0>	
			
				<cfif #new_data.Speaker2LastName# is not ''>					
					<cfquery name="spkr2id" datasource="#application.speakerDSN#">
						select speakerid
									from Speaker	
									where 
									lastname = '#Trim(new_data.Speaker2LastName)#' and
									firstname = '#Trim(new_data.Speaker2FirstName)#' and type= 'SPKR'
					</cfquery>						
							
			<cfif spkr2id.recordcount eq 0>	
			<center>
	The Speaker Name - <strong>#new_data.Speaker2FirstName# #new_data.Speaker2LastName# </strong> for #new_data.MeetingCode# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#  was not found in the database. <br><br>Please ajust your spreadsheet and re-load it.

<cfset error = 'spkr2'>
	</center><br><hr size="1"><br>	
</cfif>	
	
	<cfquery name="associated_spkrs2" datasource="#application.speakerDSN#">
Select 
sp.speakerid, 
sc.ClientId, 
sc.ClientCode 

From Speaker sp, 
SpeakerClients sc 
Where 
sp.speakerid = '#spkr2id.speakerid#' and
sp.type = 'SPKR' and 
sc.SpeakerId = sp.speakerid and
sc.ClientCode = '#Left(newMeetingCode, 5)#'
Order by lastname
          </cfquery> 
	
	<cfif associated_spkrs2.recordcount eq 0>	<center>
	The Speaker - <strong>#new_data.Speaker2FirstName# #new_data.Speaker2LastName#</strong> is not associated with  Project <strong>"#new_data.MeetingCode#"</strong>.<br> <a href="javascript:openpopup5('add_spker2.cfm?speakerid=#spkr2id.speakerid#&meeting=#Left(newMeetingCode, 9)#')"><u>Click Here</u></a> to add him/her to this project. Then re-load this page. 

<cfset error = 'spkr2'>
	</center><br><hr size="1"><br>
</cfif>			
						
<cfif error is not 'spkr2'> 
<!-------------------------------------- Check for Meeting Conflict ----------------------------------------->
<cfquery name="check_avail4" datasource="#application.speakerDSN#">
Select 
SpeakerID,
availfromdate,
availtodate,
availfromtime,
availtotime,
availtype,
allday,
MeetingCode

From SpeakerAvailable 

Where 
MeetingCode != '#newmeetingcode#' and
SpeakerID ='#spkr2id.speakerid#' and
availfromdate = '#DateFormat(new_data.Date, "m/d/yyyy")#' 
</cfquery> 

<cfif check_avail4.recordcount gte 1>

<!--- One Hour After Meeting --->
<cfscript>Conflict4A = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_houra = createTimeSpan(0,1,0,0);    
    end_Conflict4A = Conflict4A + new_houra;
</cfscript>
<!--- One Hour Before Meeting --->
<cfscript>
Conflict4B = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourb = createTimeSpan(0,1,0,0);    
    end_Conflict4B = Conflict4B - new_hourb;
</cfscript>
<!--- Half Hour After Meeting --->
<cfscript>
Conflict4C = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourc = createTimeSpan(0,0,30,0);    
    end_Conflict4C = Conflict4C + new_hourc;
</cfscript>	
<!--- Half Hour Before Meeting --->
<cfscript>
Conflict4D = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourd = createTimeSpan(0,0,30,0);    
    end_Conflict4D = Conflict4D - new_hourd;
</cfscript>		

<cfif #check_avail4.allday# is 1>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this day off.<br><br>
Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfset error = 'spkr2'>

<cfelse>
         
<cfif #TimeFormat(new_data.Time, "hh:mm tt")# eq '#TimeFormat(check_avail4.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict4D, "hh:mm tt")# eq '#TimeFormat(check_avail4.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict4C, "hh:mm tt")# eq '#TimeFormat(check_avail4.availtotime, "hh:mm tt")#'> 
<cfset error = 'spkr2'>

<cfif #check_avail4.MeetingCode# is ''>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this time off. Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfelse>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)# is in meeting #Left(check_avail4.MeetingCode, 9)# from #TimeFormat(check_avail4.availfromtime, "h:mm tt")# to #TimeFormat(check_avail4.availtotime, "h:mm tt")#. Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
</cfif>


<cfelseif 
#TimeFormat(end_Conflict4B, "hh:mm tt")# eq '#TimeFormat(check_avail4.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict4A, "hh:mm tt")# eq '#TimeFormat(check_avail4.availtotime, "hh:mm tt")#'> 
<cfset error = 'w'>

<font color="FF0000"><strong>Warning!</strong></font> #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)# has been added to #Left(newMeetingCode, 9)#, #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")# however, #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)#is in meeting #Left(check_avail4.meetingcode, 9)# from #TimeFormat(check_avail4.availfromtime, "h:mm tt")# to #TimeFormat(check_avail4.availtotime, "h:mm tt")#.

<br><hr size="1"><br>
</cfif> 
</cfif>
</cfif>
<!-------------------------------------- Insert Speaker-----------------------------------------> 
<cfif error is not 'spkr2'>
					 <cfquery name="insert_spkr2" datasource="#application.projdsn#"> 
						Insert Into ScheduleSpeaker(   
							ScheduleID,
							MeetingCode,
							MeetingDate,
							MtgStartTime,
							MtgEndTime,	
							SpeakerID,
							Type,
							activityType,	  
							Confirmed
							   
						 ) 		
									VALUES(
							'#new_ScheduleID.scheduleID#',
							'#newMeetingCode#',
							'#DateFormat(new_data.Date, "m/d/yyyy")#',
							'#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "h:mm:ss tt")#',
							'#DateFormat(new_data.Date, "m/d/yyyy")# #MeetingEndTime#',	
							'#spkr2id.speakerid#',
							'SPKR',
							'Lead',
							'1'
									)
					</cfquery>  
					<cfquery name="insert_unavailability1" datasource="#application.speakerDSN#">
INSERT into SpeakerAvailable 
       (
		speakerID, 
		availfromdate, 
		availtodate, 
		availfromtime,
		availtotime,
		allday,
		availtype,
		updated,
		updatedby,
		MeetingCode
		)
        VALUES 
        (
		'#spkr2id.SpeakerID#',
		'#DateFormat(new_data.Date, "m/d/yyyy")#',
		'#DateFormat(new_data.Date, "m/d/yyyy")# ',	
		'#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "hh:mm:ss tt")#',
		'#DateFormat(new_data.Date, "m/d/yyyy")# #MeetingEndTime#',
		'0',
		'NA',
		'#update_log#',
		'#session.user#',
		'#newMeetingCode#'
				)
</cfquery>
		</cfif>			
					</cfif>
						
				</cfif>
				<!--- Have a meeting Code and spkr2 is not blank --->
<cfelse>

	<!--- spkr2 NULL delete it --->
					
			<cfif #Trim(new_data.Speaker2LastName)# is 'NULL' or #Trim(new_data.Speaker2FirstName)# is 'Null'>
<cfquery name="delete_spkr2" datasource="#application.projdsn#">
						delete
						from ScheduleSpeaker
						Where MeetingCode = '#newmeetingcode#' and Type = 'SPKR'
						
					</cfquery>
					
		<cfquery name="delete_spkr2" datasource="#application.projdsn#">
			 
	     UPDATE Schedule
	     SET  
		 Speaker2FirstName ='', 
		 Speaker2LastName =''
		 WHERE RowID = '#new_data.RowID#'
	  </cfquery> 
	  
<cfquery name="delete_availspkr2" datasource="#application.speakerDSN#">			 
	     delete from SpeakerAvailable
	     where	
		 MeetingCode = '#newmeetingcode#' and	 
		 availfromdate =  '#DateFormat(new_data.Date, "m/d/yyyy")#' and
		 availfromtime = '#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "h:mm:ss tt")#'
</cfquery>
	  
								
			<cfelse>
		
<cfif #new_data.Speaker2LastName# is not ''>
<cfquery name="spkr2id" datasource="#application.speakerDSN#">
						select speakerid
									from Speaker	
									where 
									lastname = '#Trim(new_data.Speaker2LastName)#' and
									firstname = '#Trim(new_data.Speaker2FirstName)#' and type= 'SPKR'
					</cfquery>					
					<cfquery name="spkr2id2" datasource="#application.projdsn#">
						select speakerid
						from ScheduleSpeaker
						Where MeetingCode = '#newmeetingcode#' and Type = 'SPKR' and speakerid = '#spkr2id.speakerid#'									
					</cfquery>
					
	<cfif #spkr2id2.recordcount# is 1>	
	
	
	<!---  spkr2 Exist dont do Anything --->
	
	<!-------------------------------------- Check for Meeting Conflict ----------------------------------------->
<cfquery name="check_avail4" datasource="#application.speakerDSN#">
Select 
SpeakerID,
availfromdate,
availtodate,
availfromtime,
availtotime,
availtype,
allday,
MeetingCode

From SpeakerAvailable 
 
Where 
MeetingCode != '#newmeetingcode#' and
SpeakerID ='#spkr2id.speakerid#' and
availfromdate = '#DateFormat(new_data.Date, "m/d/yyyy")#' 
</cfquery> 

<cfif check_avail4.recordcount gte 1>

<!--- One Hour After Meeting --->
<cfscript>Conflict4A = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_houra = createTimeSpan(0,1,0,0);    
    end_Conflict4A = Conflict4A + new_houra;
</cfscript>
<!--- One Hour Before Meeting --->
<cfscript>
Conflict4B = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourb = createTimeSpan(0,1,0,0);    
    end_Conflict4B = Conflict4B - new_hourb;
</cfscript>
<!--- Half Hour After Meeting --->
<cfscript>
Conflict4C = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourc = createTimeSpan(0,0,30,0);    
    end_Conflict4C = Conflict4C + new_hourc;
</cfscript>	
<!--- Half Hour Before Meeting --->
<cfscript>
Conflict4D = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourd = createTimeSpan(0,0,30,0);    
    end_Conflict4D = Conflict4D - new_hourd;
</cfscript>	

<cfif #check_avail4.allday# is 1>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this day off.<br><br>
Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfset error = 'spkr2'>

<cfelse>
	         
<cfif #TimeFormat(new_data.Time, "hh:mm tt")# eq '#TimeFormat(check_avail4.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict4D, "hh:mm tt")# eq '#TimeFormat(check_avail4.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict4C, "hh:mm tt")# eq '#TimeFormat(check_avail4.availtotime, "hh:mm tt")#'> 
<cfset error = 'spkr2'>

<cfif #check_avail4.MeetingCode# is ''>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this time off. Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfelse>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)# is in meeting #Left(check_avail4.MeetingCode, 9)# from #TimeFormat(check_avail4.availfromtime, "h:mm tt")# to #TimeFormat(check_avail4.availtotime, "h:mm tt")#. Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
</cfif>

<cfelseif 
#TimeFormat(end_Conflict4B, "hh:mm tt")# eq '#TimeFormat(check_avail4.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict4A, "hh:mm tt")# eq '#TimeFormat(check_avail4.availtotime, "hh:mm tt")#'> 
<cfset error = 'w'>

<font color="FF0000"><strong>Warning!</strong></font> #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)# has been added to #Left(newMeetingCode, 9)#, #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")# however, #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)# is in meeting #Left(check_avail4.MeetingCode, 9)# from #TimeFormat(check_avail4.availfromtime, "h:mm tt")# to #TimeFormat(check_avail4.availtotime, "h:mm tt")#.<br><hr size="1"><br>

</cfif> 
</cfif>
</cfif>
			
			<cfelse>					
	
					
					
		<cfif spkr2id.recordcount eq 0>	<center>
	The Speaker Name - <strong>#new_data.Speaker2FirstName# #new_data.Speaker2LastName# </strong> for #new_data.MeetingCode# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")# was not found in the database. <br><br>Please ajust your spreadsheet and re-load it. 

<cfset error = 'spkr2'>
	</center><br><hr size="1"><br>
</cfif>			

<cfquery name="associated_spkrs2" datasource="#application.speakerDSN#">
	 Select 
sp.speakerid, 
sc.ClientId, 
sc.ClientCode 

From Speaker sp, 
SpeakerClients sc 
Where 
sp.speakerid = '#spkr2id.speakerid#' and
sp.type = 'SPKR' and 
sc.SpeakerId = sp.speakerid and
sc.ClientCode = '#Left(newMeetingCode, 5)#'
Order by lastname
          </cfquery> 
	
	<cfif associated_spkrs2.recordcount eq 0>	<center>
	The Speaker - <strong>#new_data.Speaker2FirstName# #new_data.Speaker2LastName#</strong> is not associated with  Project <strong>"#new_data.MeetingCode#"</strong>.<br> <a href="javascript:openpopup5('add_spker2.cfm?speakerid=#spkr2id.speakerid#&meeting=#Left(newMeetingCode, 9)#')"><u>Click Here</u></a> to add him/her to this project. Then re-load this page. 

<cfset error = 'spkr2'>
	</center><br><hr size="1"><br>
</cfif>	

<cfquery name="check_schedule_spkr2" datasource="#application.projdsn#"> 
select speakerid
from ScheduleSpeaker		
where MeetingCode = '#newMeetingCode#' and type ='SPKR' and
speakerid != '#spkr2id.speakerid#' 
 
 <CFIF IsDefined("SPKR2id.speakerid")> and speakerid != '#SPKR2id.speakerid#'</cfif> 
			</cfquery>
			<cfif check_schedule_spkr2.recordcount eq 0>
		
		 <cfif error is not 'spkr2'> 	
			

<!-------------------------------------- Check for Meeting Conflict ----------------------------------------->
<cfquery name="check_avail4" datasource="#application.speakerDSN#">
Select 
SpeakerID,
availfromdate,
availtodate,
availfromtime,
availtotime,
availtype,
allday,
MeetingCode

From SpeakerAvailable 
 
Where 
MeetingCode != '#newmeetingcode#' and
SpeakerID ='#spkr2id.speakerid#' and
availfromdate = '#DateFormat(new_data.Date, "m/d/yyyy")#' 
</cfquery> 

<cfif check_avail4.recordcount gte 1>

<!--- One Hour After Meeting --->
<cfscript>Conflict4A = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_houra = createTimeSpan(0,1,0,0);    
    end_Conflict4A = Conflict4A + new_houra;
</cfscript>
<!--- One Hour Before Meeting --->
<cfscript>
Conflict4B = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourb = createTimeSpan(0,1,0,0);    
    end_Conflict4B = Conflict4B - new_hourb;
</cfscript>
<!--- Half Hour After Meeting --->
<cfscript>
Conflict4C = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourc = createTimeSpan(0,0,30,0);    
    end_Conflict4C = Conflict4C + new_hourc;
</cfscript>	
<!--- Half Hour Before Meeting --->
<cfscript>
Conflict4D = #TimeFormat(new_data.Time, "h:mm tt")#;    
    new_hourd = createTimeSpan(0,0,30,0);    
    end_Conflict4D = Conflict4D - new_hourd;
</cfscript>		

<cfif #check_avail4.allday# is 1>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this day off.<br><br>
Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfset error = 'spkr2'>

<cfelse>

         
<cfif #TimeFormat(new_data.Time, "hh:mm tt")# eq '#TimeFormat(check_avail4.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict4D, "hh:mm tt")# eq '#TimeFormat(check_avail4.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict4C, "hh:mm tt")# eq '#TimeFormat(check_avail4.availtotime, "hh:mm tt")#'> 
<cfset error = 'spkr2'>

<cfif #check_avail4.MeetingCode# is ''>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, he/she has scheduled this time off. Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
<cfelse>
<img src="../images/unconfirmed1.gif" alt="" border="0"> #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)# is <b>not</b> available for #Left(newMeetingCode, 9)# #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")#, #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)# is in meeting #Left(check_avail4.MeetingCode, 9)# from #TimeFormat(check_avail4.availfromtime, "h:mm tt")# to #TimeFormat(check_avail4.availtotime, "h:mm tt")#. Please modify your entry, or check this Speakers availability by <a href="javascript:openpopupunavail('../reports/report_modspkr_calendar2.cfm?no_menu=1.cfm&ID=#spkr2id.speakerid#&year=#DateFormat(new_data.Date, 'yyyy')#&month=#DateFormat(new_data.Date, 'm')#')"><u>clicking here</u></a>.<br><hr size="1"><br>
</cfif>

<cfelseif 
#TimeFormat(end_Conflict4B, "hh:mm tt")# eq '#TimeFormat(check_avail4.availfromtime, "hh:mm tt")#' or #TimeFormat(end_Conflict4A, "hh:mm tt")# eq '#TimeFormat(check_avail4.availtotime, "hh:mm tt")#'>
<cfset error = 'w'> 

<font color="FF0000"><strong>Warning!</strong></font> #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)# has been added to #Left(newMeetingCode, 9)#, #DateFormat(new_data.Date, "m/d/yyyy")# at #TimeFormat(new_data.Time, "h:mm tt")# however, #Trim(new_data.Speaker2FirstName)# #Trim(new_data.Speaker2LastName)# is in meeting #Left(check_avail4.meetingcode, 9)# from #TimeFormat(check_avail4.availfromtime, "h:mm tt")# to #TimeFormat(check_avail4.availtotime, "h:mm tt")#.<br><hr size="1"><br>
</cfif> 
</cfif> 
</cfif>
<cfif error is not 'spkr2'>
  <cfquery name="insert_spkr2" datasource="#application.projdsn#"> 
						Insert Into ScheduleSpeaker(   
							ScheduleID,
							MeetingCode,
							MeetingDate,
							MtgStartTime,
							MtgEndTime,	
							SpeakerID,
							Type,
							activityType,	  
							Confirmed
							   
						 ) 		
									VALUES(
							'#new_ScheduleID.scheduleID#',
							'#newMeetingCode#',
							'#DateFormat(new_data.Date, "m/d/yyyy")#',
							'#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "h:mm:ss tt")#',
							'#DateFormat(new_data.Date, "m/d/yyyy")# #MeetingEndTime#',	
							'#spkr2id.speakerid#',
							'SPKR',
							'Lead',
							'1'
									)
					</cfquery>   
					<cfquery name="insert_unavailability1" datasource="#application.speakerDSN#">
INSERT into SpeakerAvailable 
       (
		speakerID, 
		availfromdate, 
		availtodate, 
		availfromtime,
		availtotime,
		allday,
		availtype,
		updated,
		updatedby,
		MeetingCode
		)
        VALUES 
        (
		'#spkr2id.SpeakerID#',
		'#DateFormat(new_data.Date, "m/d/yyyy")#',
		'#DateFormat(new_data.Date, "m/d/yyyy")# ',	
		'#DateFormat(new_data.Date, "m/d/yyyy")# #TimeFormat(new_data.Time, "hh:mm:ss tt")#',
		'#DateFormat(new_data.Date, "m/d/yyyy")# #MeetingEndTime#',
		'0',
		'NA',
		'#update_log#',
		'#session.user#',
		'#newMeetingCode#'
				)
</cfquery></cfif>
					</cfif>
					
	     <cfelse>	
		 

		<cfif error is not 'spkr2'>
		
		<!--- Update Unavailabilty --->
	   <cfquery name="update_unavailability1" datasource="#application.speakerDSN#">
       UPDATE SpeakerAvailable 
       SET
	   speakerID = '#spkr2id.speakerid#'
	   Where 
       meetingCode = '#newMeetingCode#' and
       availfromdate = '#DateFormat(new_data.Date, "m/d/yyyy")#' and	
       availfromtime = '#TimeFormat(new_data.Time, "h:mm:ss tt")#'
      </cfquery>
	  
	    <!--- Update Speaker --->
	    <cfquery name="update_spkr2" datasource="#application.projdsn#"> 
	     UPDATE ScheduleSpeaker
	     SET
		 speakerid = '#spkr2id.speakerid#' 
		 WHERE meetingCode = '#newMeetingCode#' and type = 'SPKR' 
	  </cfquery>  
	   <!--- Update Master --->
	    <cfquery name="update_spkr2" datasource="#application.projdsn#"> 
	     UPDATE ScheduleMaster
	     SET
		 LastUpdated = '#update_log#',
		 UpdatedBy = '#session.user#' 
		 WHERE MeetingCode = '#newMeetingCode#' 
	  </cfquery> 
	  
	  </cfif>
	     </cfif>
		 		</cfif>			
<cfelse>
 <!---  Nothing To Insert in Speaker 1 --->
</cfif> 	
</cfif>	
</cfif>
<cfset MeetingCode1 = '#Left(newMeetingCode, 9)#'>
<cfset Date1 = '#Date#'>
<cfset Time1 = '#Time#'>
<cfset RowID1 = '#RowID#'>


</cfloop>

		
 <cfif error is ''>
	   <cflocation url="http://ravel/grid/index.cfm?startdate=#url.startdate#&enddate=#url.enddate#&projectfilter=#url.projectfilter#" addtoken="No">

<cfelse>
<center><a href="http://ravel/grid/index.cfm?startdate=#url.startdate#&enddate=#url.enddate#&projectfilter=#url.projectfilter#"><strong><u>Return to Dynamic Grid</u></strong></a> </center><br><br><br>
 </cfif> 
<!--- <a href="http://ravel/grid/index.cfm?startdate=#url.startdate#&enddate=#url.enddate#&projectfilter=#url.projectfilter#"><strong><u>Return to Dynamic Grid</u></strong></a></center><br><br><br>  --->
	</cfoutput>


