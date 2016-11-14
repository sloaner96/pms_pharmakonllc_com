  <!-------------------------- Import Payments from Access ------------------------------> 
 <cfset date = DateFormat(now(), "mm/dd/yyyy")>
<cfset time = timeFormat(now(), "hh:mm:tt")>
<cfset update_log = '#date# #time#'>

<cfoutput>	
<!--- Get Event Fee from Access --->

<!---  <cfquery name="paymentsfee" datasource="Payments">
SELECT SpeakerID, MeetingCode, Salary, DrugName
From 
SpeakerInfo

 WHERE 		
 Salary > 0 and  
 DrugName Like '%Training'
		</cfquery>
		
<cfloop query="paymentsfee">

  <cfquery name="update_fees" datasource="#application.speakerDSN#"> 
	      UPDATE SpeakerClients
	        SET  TrainingFee = '#paymentsfee.Salary#' 
				 
		  WHERE 
		  speakerid = '#paymentsfee.SpeakerID#' and 
		  TrainingFee = '0' and
		  ClientCode = '#Left(paymentsfee.MeetingCode, 5)#' 
	  </cfquery>   

	
	  
</cfloop> --->

<!--- get address's from access --->

<!--- <cfquery name="paymentsfee" datasource="Payments">
SELECT SpeakerID, Address1, Address2, Address3, City, StateProvince, PostalCode
From 
SpeakerInfo

	</cfquery>
		
<cfloop query="paymentsfee">

  <cfquery name="update_fees" datasource="#application.speakerDSN#"> 
	      UPDATE SpeakerAddress
	        SET  
			address1 = '#paymentsfee.Address1#',
			address2 = '#paymentsfee.Address2#',
			address3 = '#paymentsfee.Address3#',
			City = '#paymentsfee.City#',
			State = '#paymentsfee.StateProvince#',
			zipcode = '#paymentsfee.PostalCode#',
			country = 'USA'	 
		  WHERE 
		  speakerid = '#paymentsfee.SpeakerID#' 
		  	  </cfquery>   
    
</cfloop>  --->

<!--- update social from access --->

<!--- <cfquery name="paymentsfee" datasource="Payments">
SELECT SpeakerID, SocialSecurityNumber, TaxIDNumber
From 
SpeakerInfo

	</cfquery>
		
<cfloop query="paymentsfee">

  <cfquery name="update_fees" datasource="#application.speakerDSN#"> 
	      UPDATE Speaker
	        SET  			
			<!--- taxid = '#paymentsfee.SocialSecurityNumber#',
			taxidtype = 'SSN' --->
						
			taxid = '#paymentsfee.TaxIDNumber#',
			taxidtype = 'TIN'
									
		  WHERE 
		  speakerid = '#paymentsfee.SpeakerID#' 
		  	  </cfquery>   
    
</cfloop> ---> 


<!--- get speaker id's put to access --->
 <!--- <cfquery name="paymentsnames" datasource="Payments">
SELECT firstname, lastname 
From 
SpeakerInfo

		</cfquery>


 <cfloop query="paymentsnames"> 

 <cfquery name="getid" datasource="#application.speakerDSN#">
select speakerid, firstname, lastname
from Speaker	
where 
firstname = '#paymentsnames.firstname#' and
lastname = '#paymentsnames.lastname#'
</cfquery> 

   <cfquery name="update_access" datasource="Payments"> 
	      UPDATE SpeakerInfo
	        SET  speakerid = '#getid.speakerid#' 
				 
		  WHERE 
		  firstname = '#getid.firstname#' and
		  lastname = '#getid.lastname#' 
	  </cfquery> 


</cfloop>
 --->




<!--- part 1 get meetings --->
   <!--- <cfquery name="payments" datasource="Payments">
SELECT *
From 
MeetingDates

Where  
SpeakerInfoID > 0  and
(Date >= #createodbcdatetime('01/01/2005')#)

			</cfquery>
						
 					
		 <cfloop query="payments"> 
	<cfquery name="insert_meetings" datasource="#application.projdsn#">
INSERT into SpeakerPayments 
       (		 
		PaymentID, 
		MeetingCode,
		Date, 
		Time,
		LastUpdated,
		UpdatedBy
		)
        VALUES 
        (
		'#payments.SpeakerInfoID#',
		'#payments.MeetingCode#',
		'#DateFormat(payments.Date, "m/d/yyyy")#',	
		'#DateFormat(payments.Date, "m/d/yyyy")# #TimeFormat(payments.Time, "HH:mm:ss")#',
		'#update_log#',
		'#session.user#'	
				)
</cfquery>  

<cfquery name="updatepayments" datasource="#application.projdsn#">
        UPDATE SpeakerPayments 
		SET				
		PaymentDate = '#payments.PaidDate#',
		CheckNumber = '#payments.CheckNumber#',		
		Notes = '#payments.Notes#',
		InvoiceDate = '#payments.InvoicedDate#',
		LastUpdated = '#update_log#',
		UpdatedBy = '#session.user#'		
				
		Where 
        PaymentID = '#payments.SpeakerInfoID#' and 
		MeetingCode = '#payments.MeetingCode#'
      </cfquery>

		</cfloop>   --->
		
		<!--- part 2 get id's --->
<!--- 		  <cfquery name="payments2" datasource="Payments">
SELECT *
From 
SpeakerInfo
			</cfquery>			
	

 <cfloop query="payments2"> 
 
 <cfquery name="id" datasource="#application.speakerDSN#">
						select speakerid
									from Speaker	
									where 
									lastname = '#Trim(payments2.lastName)#' and
									firstname = '#Trim(payments2.firstName)#' 
					</cfquery>		
							
	  
	    
 	   <cfquery name="updatepayments" datasource="#application.projdsn#">
        UPDATE SpeakerPayments 
		SET				
		SpeakerID = '#id.SpeakerID#'		
		<!--- CheckAmount = '#payments2.Salary#' ---> 
				
		Where 
        PaymentID = '#payments2.SpeakerInfoID#' 
      </cfquery>  
	  
	    </cfloop>  ---> 
		
		
		
<!--- part 3 get check amount --->


<!--- <cfquery name="payments3" datasource="Payments">
SELECT Salary, SpeakerInfoID
From 
SpeakerInfo
where 
Salary > 0
			</cfquery>	
			
	<cfloop query="payments3"> 		
			
			 <cfquery name="updatepayments" datasource="#application.projdsn#">
        UPDATE SpeakerPayments 
		SET				
		CheckAmount = '#payments3.Salary#' 
				
		Where 
		PaymentID = '#payments3.SpeakerInfoID#' 
      </cfquery>  
						
			</cfloop>   --->
			
				
  </cfoutput> 
 

<!---  
 <!-------------------------- Update Spkrs Mods Available Time ------------------------------>  
 
 <cfset today = DateFormat(Now(), "m/d/yyyy")> 
  
 <cfoutput>  
 
 <cfquery name="new_data" datasource="#application.projdsn#">
	select *	
	from ScheduleSpeaker
	where speakerID != 0 and
	MeetingDate >= '1/1/2006'	
	</cfquery>
   
<cfloop query="new_data">

 <cfset month =#DateFormat(new_data.MeetingDate, "mm")#>		    
		    <cfset day =#DateFormat(new_data.MeetingDate, "dd")#>		    
		    <cfset start_hour =#TimeFormat(new_data.MtgStartTime, "hh")#>		    
		    <cfset start_minute =#TimeFormat(new_data.MtgStartTime, "mm")#>		    
		    <cfset day_night =#TimeFormat(new_data.MtgStartTime, "tt")#>		    
		    <cfset MeetingCodeDate = '#Right(new_data.MeetingDate, 2)##month##day#'>		    
		    <cfset MeetingCodeTime = '#start_hour##Left(start_minute, 1)#A'>		    
		    <cfset newMeetingCode = '#Trim(new_data.MeetingCode)##trim(MeetingCodeDate)#-#trim(MeetingCodeTime)#'>		    
		    <cfset EndTimehour = "#TimeFormat(new_data.MtgStartTime, "h")#">
			<cfset newMeetingCode = '#Left(newMeetingCode, 20)#'>	
	
			
						
			<cfscript>
StartTime = #TimeFormat(new_data.MtgStartTime, "h:mm:ss tt")#;
    
    new_hour = createTimeSpan(0,1,0,0);
    
    EndTime = StartTime + new_hour;</cfscript>	
		  
	    
		    <cfset MeetingEndTime = '#TimeFormat(EndTime, "h:mm:ss tt")#'>

 <cfquery name="insert_time" datasource="#application.speakerDSN#">
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
		meetingcode
		)
        VALUES 
        (
		'#new_data.SpeakerID#',
		'#DateFormat(new_data.MeetingDate, "m/d/yyyy")#',
		'#DateFormat(new_data.MeetingDate, "m/d/yyyy")#',	
		'#DateFormat(new_data.MeetingDate, "m/d/yyyy")# #TimeFormat(new_data.MtgStartTime, "h:mm tt")#',
		'#DateFormat(new_data.MeetingDate, "m/d/yyyy")# #MeetingEndTime#',
		'0',
		'NA',
		#today#,
		'#session.user#',
		'#newMeetingCode#'
				)
</cfquery>  


 id - '#new_data.SpeakerID#' - '#newMeetingCode#'
<hr> 

</cfloop>   </cfoutput>   --->
   
   
    <!-------------------------- Scrub Live Mods and Spkrs ------------------------------>
  
<!--- <cfoutput><cfquery name="data" datasource="#application.projdsn#">
select * 
from ScheduleSpeaker 
</cfquery>
  
  <cfloop query="data">
  
  <cfquery name="getid" datasource="#application.speakerDSN#">
	select speakerid, type
	from Speaker	
	where 
	speakerid = '#data.speakerid#'
					</cfquery>
  
  <cfif #data.type# is not '#getid.type#'>
  <cfquery name="deletedata" datasource="#application.projdsn#">
  Delete 
  from ScheduleSpeaker
  where SchedSpeakerID = '#data.SchedSpeakerID#'
  </cfquery>
  </cfif>  
  </cfloop> </cfoutput> --->
  
  
  
  <!-------------------------- update meetings and speakers from live ------------------------------>

<!--- <cfquery name="deletedata" datasource="#application.projdsn#">
  Delete from Schedule
  </cfquery>
  
<cfoutput>
  
<cfquery name="data" datasource="#application.projdsn#">
select * 
from ScheduleMaster
order by projectid
</cfquery>

<cfloop query="data">

<cfquery name="get_desc" datasource="#application.projdsn#"> 
Select project_code, product
		     From PIW
			Where project_code = '#data.projectid#'
			 </cfquery> 

<cfquery name="insert" datasource="#application.projdsn#">
INSERT into Schedule 
       (
		Project, 
		MeetingCode, 
		Date, 
		Time 
		
		)
        VALUES 
        (
		'#get_desc.product#', 
		'#data.projectid#',
		'#DateFormat(data.MeetingDate, "mm/dd/yyyy")#',		
		'#DateFormat(data.MeetingDate, "mm/dd/yyyy")# #TimeFormat(data.MtgStartTime, "hh:mm tt")#'
		)
</cfquery>


#get_desc.product#<br>
#data.projectid#<br>
#DateFormat(data.MeetingDate, "mm/dd/yyyy")#<br>
#DateFormat(data.MeetingDate, "mm/dd/yyyy")# #TimeFormat(data.MtgStartTime, "hh:mm tt")#<br>
<br><hr><br>
</cfloop>



</cfoutput>  --->

<!--- <cfoutput>
<cfquery name="data2" datasource="#application.projdsn#">
select * 
from ScheduleSpeaker 
where 
type ='MOD' 
</cfquery>

<cfloop query="data2">
 
 <cfquery name="getid2" datasource="#application.speakerDSN#">
						select speakerid, firstname, lastname
									from Speaker	
									where 
									speakerid = '#data2.speakerid#'
					</cfquery>
 
 
<cfquery name="update2" datasource="#application.projdsn#">
        UPDATE Schedule 
		SET		
		<cfif #data2.ActivityType# is 'Lead'>
		Moderator1FirstName = '#getid2.firstname#', 
		Moderator1LastName = '#getid2.lastname#' 
		<cfelse>
		Moderator2FirstName = '#getid2.firstname#', 
		Moderator2LastName = '#getid2.lastname#' 
		</cfif>		
		
		Where 
        MeetingCode = '#Left(data2.MeetingCode, 9)#' and
		Date = '#DateFormat(data2.Meetingdate, "mm/dd/yyyy")#'and
		Time = '#DateFormat(data2.Meetingdate, "mm/dd/yyyy")# #TimeFormat(data2.MtgStartTime, "h:mm tt")#'
      </cfquery>
	  </cfloop>
	  
	  
	  <cfquery name="data3" datasource="#application.projdsn#">
select * 
from ScheduleSpeaker 
where 
type ='SPKR' 
</cfquery>

<cfloop query="data3">
 
 <cfquery name="getid3" datasource="#application.speakerDSN#">
						select speakerid, firstname, lastname
									from Speaker	
									where 
									speakerid = '#data3.speakerid#'
					</cfquery>
 
 
<cfquery name="update3" datasource="#application.projdsn#">
        UPDATE Schedule 
		SET		
		<cfif #data3.ActivityType# is 'Lead'>
		Speaker1FirstName = '#getid3.firstname#', 
		Speaker1LastName = '#getid3.lastname#' 
		<cfelse>
		Speaker2FirstName = '#getid3.firstname#', 
		Speaker2LastName = '#getid3.lastname#' 
		</cfif>		
		
		Where 
        MeetingCode = '#Left(data3.MeetingCode, 9)#' and
		Date = '#DateFormat(data3.Meetingdate, "mm/dd/yyyy")#'and
		Time = '#DateFormat(data3.Meetingdate, "mm/dd/yyyy")# #TimeFormat(data3.MtgStartTime, "h:mm tt")#'
      </cfquery>
	  </cfloop>
</cfoutput>    --->




<!------------------------ Just update mods and speakers from live------------->



<!---  <cfoutput>

<cfquery name="data" datasource="#application.projdsn#">
select * 
from ScheduleSpeaker 
where 
MeetingDate < '08/01/2006' and type ='MOD' and Activitytype= 'Lead'
</cfquery>
<cfloop query="data">
 
 <cfquery name="getmodid" datasource="#application.speakerDSN#">
select speakerid, firstname, lastname
from Speaker	
where 
speakerid = '#data.speakerid#' and type ='MOD'
</cfquery>

<cfquery name="update" datasource="#application.projdsn#">
        UPDATE Schedule 
		SET
		Moderator1FirstName = '#getmodid.firstname#', 
		Moderator1LastName = '#getmodid.lastname#' 
		
		
		Where 
        MeetingCode = '#Left(data.MeetingCode, 9)#' and
		Date = '#DateFormat(data.Meetingdate, "mmm, dd yyyy")#' and
		Time = '#DateFormat(data.Meetingdate, "m/dd/yyyy")# #TimeFormat(data.MtgStartTime, "hh:mm")#'
      </cfquery>
</cfloop> 

<cfquery name="data2" datasource="#application.projdsn#">
select * 
from ScheduleSpeaker 
where 
MeetingDate < '08/01/2006' and type ='SPKR' and Activitytype= 'Lead'
</cfquery>
<cfloop query="data2">
 
	  
<cfquery name="getspkrid" datasource="#application.speakerDSN#">
select speakerid, firstname, lastname
from Speaker	
where 
speakerid = '#data2.speakerid#' and type ='SPKR'
					</cfquery>
 
 
<cfquery name="update2" datasource="#application.projdsn#">
        UPDATE Schedule 
		SET
		Speaker1FirstName = '#getspkrid.firstname#', 
		Speaker1LastName = '#getspkrid.lastname#' 
		
		Where 
        MeetingCode = '#Left(data2.MeetingCode, 9)#' and
		Date = '#DateFormat(data2.Meetingdate, "mmm, dd yyyy")#'and
		Time = '#DateFormat(data.Meetingdate, "m/dd/yyyy")# #TimeFormat(data2.MtgStartTime, "hh:mm")#'
      </cfquery>

</cfloop>
</cfoutput>  --->

<!---------------------------------------- Kill Duplicates ------------------------------------------>

<!--- <cfoutput>
<cfparam name="Time1" default="">
<cfparam name="Date1" default="">
<cfparam name="MeetingCode1" default="">
<cfparam name="RowID1" default="">


<cfquery name="update" datasource="#application.projdsn#">
Select *
		   		  From Schedule
ORDER BY MeetingCode, Date, Time
		  </cfquery>
		  
		  <cfloop query="update">		  
		  
		   <cfif  #MeetingCode# is '#MeetingCode1#' and #Date# is '#Date1#' and #Time# is '#Time1#'>
		  <cfquery name="delete" datasource="#application.projdsn#">
		  delete 
from Schedule 
where
RowId = #RowID# 
		    </cfquery>
		  </cfif>
<cfset MeetingCode1 = '#MeetingCode#'>
<cfset Date1 = '#Date#'>
<cfset Time1 = '#Time#'>
<cfset RowID1 = '#RowID#'>
#MeetingCode#, #Date#, #Time# #RowID#<br><br>
		  </cfloop>
		 
		  </cfoutput> --->
		  
		  
		