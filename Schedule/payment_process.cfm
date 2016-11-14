<cfoutput>

<cfset todaydate = DateFormat(now(), "mm/dd/yyyy")>
<cfset todaytime = timeFormat(now(), "hh:mm:tt")>
<cfset update_log = '#todaydate# #todaytime#'>

<cfset thisdate = DateFormat(Now(), "m/d/yyyy")>
<cfset startdate = '#form.startdate#'>
<cfset enddate = '#form.enddate#'>
<cfset projectfilter = '#form.projectfilter#'>


<cfquery name="get_meetings" datasource="#application.projdsn#"> 
           Select Distinct
			 sm.MeetingCode,
			 Left(sm.MeetingCode, 9) as projectid,
			 sm.MeetingDate,
			 sm.MtgStartTime,
			 sm.Confirmed,
			 sm.Type,
			 sm.SpeakerID			
		     From 
			 ScheduleSpeaker sm
			 Where
			 sm.Type = 'SPKR' and 
			 sm.Type != 'MOD' and 
			 sm.Type != '' and		
			 sm.SpeakerID != '0' and	
			 sm.MeetingDate >= '#startdate#' and
			 sm.MeetingDate <= '#Enddate#' and
			 sm.Confirmed = '1'	and 			  
			 sm.MeetingCode NOT LIKE 'CLI%' and
			 sm.MeetingCode NOT LIKE 'SLI%' and
			 sm.MeetingCode NOT LIKE 'VLI%' and
			 sm.MeetingCode NOT LIKE 'ELI%' and
			 sm.MeetingCode NOT LIKE 'PLI%' and
			 sm.MeetingCode NOT LIKE 'GLI%' 
			  <cfif projectfilter is not ''>
		   AND Left(sm.MeetingCode, 9) = '#projectfilter#'</cfif> 
		    
		   Order By sm.MeetingCode, sm.MeetingDate, sm.MtgStartTime
			 </cfquery>
			 
			 
<cfset i =1>

<cfloop query="get_meetings">


<cfset update_SpeakerID = evaluate("form.speaker#i#")>
<cfset update_CheckNumber = evaluate("form.CheckNumber#i#")>
<cfset update_CheckAmount = evaluate("form.CheckAmount#i#")>
<cfset update_PaymentDate = evaluate("form.PaymentDate#i#")>
<cfset update_MeetingCode = evaluate("form.MeetingCode#i#")>
<cfset update_Date = evaluate("form.Date#i#")>
<cfset update_Time = evaluate("form.Time#i#")>

<cfif isDefined("form.PaymentID#i#")>
<cfset update_PaymentID = evaluate("form.PaymentID#i#")>
</cfif>

<cfif isDefined("form.TrainingFee#i#")> 
<cfset update_TrainingFee = evaluate("form.TrainingFee#i#")>
<cfelse>
<cfset update_TrainingFee = 0>
</cfif>

<cfquery name="get_pay" datasource="#application.projdsn#">
			 Select  
             meetingCode,
			 speakerid,
			 Date,
			 Time,
			 Right(Time, 10) as tt,
			 CheckAmount,
			 CheckNumber,
			 TrainingFee,
			 PaymentDate,
			 InvoiceDate,
			 PaymentID
			 From
			 SpeakerPayments 
			 Where 
			 meetingcode = '#get_meetings.meetingcode#' and
             speakerid = '#get_meetings.SpeakerID#'
		   	        </cfquery> 

<cfif #get_pay.meetingCode# is ''>
<!--- insert meeting into payments database --->
  <cfquery name="insert_meeting" datasource="#application.projdsn#"> 
	      Insert Into SpeakerPayments
		  (
	SpeakerID,
	MeetingCode,
	Date,
	Time,
	CheckAmount,
	TrainingFee,
	CheckNumber,
	PaymentDate,
	InvoiceDate,
	Notes,
	DateAdded,
	LastUpdated,
	UpdatedBy
	   
 ) 		
			VALUES(
    '#update_SpeakerID#',
	'#update_MeetingCode#',
	'#get_meetings.MeetingDate#',
	'#get_meetings.MtgStartTime#',
	'#update_CheckAmount#',	
	'#update_TrainingFee#',
	'#update_CheckNumber#',
	'#update_PaymentDate#',
	'',
	'',
	'#todaydate#',
	'#todaydate# #todaytime#',
	'#session.user#'
			)
	  </cfquery> 
<cfelse>
<!--- update payments database --->

<cfquery name="updatepayment" datasource="#application.projdsn#">
            UPDATE SpeakerPayments
            SET  SpeakerID = '#update_SpeakerID#',
			     CheckNumber = '#update_CheckNumber#',	
				 CheckAmount = '#update_CheckAmount#',	
			     TrainingFee = '#update_TrainingFee#',	
				 PaymentDate = '#update_PaymentDate#',	
			     LastUpdated = '#update_log#',
				 UpdatedBy = '#session.user#'
				
		  WHERE  MeetingCode = '#update_MeetingCode#' and
		         speakerid = '#get_meetings.SpeakerID#'
		        
</cfquery>  

</cfif>
<cfset i =#i#+1>
</cfloop>
         
  <cflocation url="payments.cfm?startdate=#startdate#&enddate=#enddate#&projectfilter=#projectfilter#&paydate=#paydate#" addtoken="No"> 

			 </cfoutput>