  <cfoutput>
<script type="text/javascript">
function openpopup2(popurl){
var winpops=window.open(popurl,"","top=200,left=300,width=650,height=610,scrollbars=yes,resizable=yes")
}
</script>

<cfset thisdate = DateFormat(Now(), "m/d/yyyy")>

<cfparam name="url.month" default="#month(now())#" type="numeric">
<cfparam name="url.year" default="#year(now())#" type="numeric">
<cfparam name="url.day" default="#day(now())#" type="numeric">

<cfset month = url.month>
<cfset year = url.year>
<cfset day = url.day>

<cfset today = createdate(year, month, day)>
<cfset tomorrow = dateAdd('d', 1, today)>
<cfset yesterday = dateAdd('d', -1, today)>

  
<cfparam name="url.startmonth" default="">
<cfparam name="url.startday" default="">
<cfparam name="url.startyear" default="">
<cfparam name="url.paymonth" default="">
<cfparam name="url.payday" default="">
<cfparam name="url.payear" default="">
<cfparam name="url.endmonth" default="">
<cfparam name="url.endday" default="">
<cfparam name="url.endyear" default="">
<cfparam name="url.startdate" default="">
<cfparam name="url.paydate" default="">
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

<cfif isDefined("Form.paymonth")>  
<cfset paymonth = '#Form.paymonth#'>
<cfelseif url.paydate is not ''>
<cfset paymonth = '#Left(url.paydate, 2)#'>
<cfelse>
<cfset paymonth = '#DateFormat(now(), "mm")#'>
</cfif>

<cfif isDefined("Form.payday")>  
<cfset payday = '#Form.payday#'>
<cfelseif url.paydate is not ''>
<cfset payday = '#Mid(url.paydate, 4,2)#'>
<cfelse>
<cfset payday = '#DateFormat(now(), "dd")#'>
</cfif>

<cfif isDefined("Form.payyear")>  
<cfset payyear = '#Form.payyear#'>
<cfelseif url.startdate is not ''>
<cfset payday = '#Right(url.paydate, 4)#'>
<cfelse>
<cfset payyear = '#DateFormat(now(), "yyyy")#'>
</cfif>


<cfif url.paydate is not ''>
<cfset paydate ='#url.paydate#'>
<cfelse>
<cfset paydate ='#paymonth# #payday# #payyear#'>
<cfset paydate = '#DateFormat(paydate, "mm/dd/yyyy")#'>
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

<cfif isDefined("Form.projectfilter")> 
<cfset projectfilter = '#Form.projectfilter#'>
<cfelseif isDefined("url.projectfilter")>
<cfset projectfilter = '#url.projectfilter#'>
<cfelse>
<cfparam name="form.projectfilter" default="">
</cfif>

<cfparam name="form.speaker1" default="">
  <cfquery name="getactiveProj" datasource="#application.projdsn#">
	     Select project_code, product 
		 From piw
		 Where project_status IN (2, 3)
		 Order By product asc
	  </cfquery>	
	  
	<!---    <cfquery name="getactivespkr" datasource="#application.speakerDSN#">
		SELECT DISTINCT speakerid, 
		                lastname, 
						firstname
						From Speaker
						Where type ='SPKR' 
						and active ='yes'
						order by firstname
						</cfquery> --->
	  
	  
<!--- Include special StyleSheet --->
  <link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Speaker Payments" bodyPassthrough="onLoad='init()'" doAjax="True">
<br><br>
<cfform method="POST" action="payments.cfm">
<table border="0" cellpadding="3" cellspacing="0" align="center" width="100%">
	 			   <tr><td valign="top"><font face="Tahoma" size ="2">
			 
	   
			    
			   <strong>Start Date</strong>: <select name="startmonth">		
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
						
						<strong>End Date</strong>: <select name="endmonth">		
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
						<option value="#next_year#">#next_year#</option></select>  </td><td>
						
				
<a href="javascript:openpopup2('all_invoice.cfm?startdate=#startdate#&enddate=#enddate#&paiddate=#paydate#')"><u>Print All Invoices</u></a>
<!--- <a href="all_invoice.cfm?startdate=#startdate#&enddate=#enddate#&paiddate=#paydate#"><u>Print All Invoices</u></a> --->
					</td></tr>			
	<tr><td><br><br><font face="Tahoma" size ="2"><!--- <strong>Paid Date</strong>: &nbsp;&nbsp;<select name="projectfilter">
		   <option value="">--ALL--</option></select>&nbsp;&nbsp;&nbsp; ---><strong>Filter by Project</strong>: 
		   
	    <select name="projectfilter">
		   <option value="">--ALL--</option>
		    <cfloop query="getactiveProj">
	        <option value="#getactiveProj.Project_Code#" <cfif isDefined("projectfilter")><cfif trim(projectfilter) EQ trim(getactiveProj.Project_Code)>Selected</cfif></cfif>>#getactiveProj.Project_Code#</option>
		   </cfloop> 
	    </select>   
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><font color="4A5F64">Set a Paid Date</font></strong>: <select name="paymonth">		
						<option value="01" <cfif paymonth is '01'>selected </cfif>>Jan</option>
						<option value="02" <cfif paymonth is '02'>selected </cfif>>Feb</option>
						<option value="03" <cfif paymonth is '03'>selected </cfif>>Mar</option>
						<option value="04" <cfif paymonth is '04'>selected </cfif>>Apr</option>	
						<option value="05" <cfif paymonth is '05'>selected </cfif>>May</option>	
						<option value="06" <cfif paymonth is '06'>selected </cfif>>Jun</option>	
						<option value="07" <cfif paymonth is '07'>selected </cfif>>Jul</option>	
						<option value="08" <cfif paymonth is '08'>selected </cfif>>Aug</option>	
						<option value="09" <cfif paymonth is '09'>selected </cfif>>Sep</option>	
						<option value="10" <cfif paymonth is '10'>selected </cfif>>Oct</option>	
						<option value="11" <cfif paymonth is '11'>selected </cfif>>Nov</option>
						<option value="12" <cfif paymonth is '12'>selected </cfif>>Dec</option>							
										</select>/
                        <select name="payday">		
						<option value="01" <cfif payday is 01>selected </cfif>>01</option>
						<option value="02" <cfif payday is 02>selected </cfif>>02</option>
						<option value="03" <cfif payday is 03>selected </cfif>>03</option>
						<option value="04" <cfif payday is 04>selected </cfif>>04</option>	
						<option value="05" <cfif payday is 05>selected </cfif>>05</option>	
						<option value="06" <cfif payday is 06>selected </cfif>>06</option>	
						<option value="07" <cfif payday is 07>selected </cfif>>07</option>	
						<option value="08" <cfif payday is 08>selected </cfif>>08</option>	
						<option value="09" <cfif payday is 09>selected </cfif>>09</option>	
						<option value="10" <cfif payday is 10>selected </cfif>>10</option>	
						<option value="11" <cfif payday is 11>selected </cfif>>11</option>
						<option value="12" <cfif payday is 12>selected </cfif>>12</option>	
						<option value="13" <cfif payday is 13>selected </cfif>>13</option>
						<option value="14" <cfif payday is 14>selected </cfif>>14</option>
						<option value="15" <cfif payday is 15>selected </cfif>>15</option>
						<option value="16" <cfif payday is 16>selected </cfif>>16</option>	
						<option value="17" <cfif payday is 17>selected </cfif>>17</option>	
						<option value="18" <cfif payday is 18>selected </cfif>>18</option>	
						<option value="19" <cfif payday is 19>selected </cfif>>19</option>	
						<option value="20" <cfif payday is 20>selected </cfif>>20</option>	
						<option value="21" <cfif payday is 21>selected </cfif>>21</option>	
						<option value="22" <cfif payday is 22>selected </cfif>>22</option>	
						<option value="23" <cfif payday is 23>selected </cfif>>23</option>
						<option value="24" <cfif payday is 24>selected </cfif>>24</option>	
						<option value="25" <cfif payday is 25>selected </cfif>>25</option>	
						<option value="26" <cfif payday is 26>selected </cfif>>26</option>	
						<option value="27" <cfif payday is 27>selected </cfif>>27</option>	
						<option value="28" <cfif payday is 28>selected </cfif>>28</option>	
						<option value="29" <cfif payday is 29>selected </cfif>>29</option>	
						<option value="30" <cfif payday is 30>selected </cfif>>30</option>	
						<option value="31" <cfif payday is 31>selected </cfif>>31</option>
						<option value="32" <cfif payday is 32>selected </cfif>>32</option>></select>/
								
<select name="payyear">		
						<option value="#this_year#">#this_year#</option>
						<option value="#next_year#">#next_year#</option></select> 
		<br><br>
		
		
		
		&nbsp;&nbsp;* <em>Click name for Invoice</em> <!--- &nbsp;&nbsp;&nbsp;
		<strong>Speaker</strong>: <select name="speaker1">
		<option value="">-ALL-</option>
		    <cfloop query="getactivespkr">
	        <option value="#getactivespkr.speakerid#" <cfif isDefined("form.speaker1")><cfif trim(form.speaker1) EQ trim(getactivespkr.speakerid)>Selected</cfif></cfif>>#getactivespkr.firstname# #getactivespkr.lastname#</option>
		   </cfloop> 
	    </select> ---></td><td><input type="submit" name="Submit" value="Submit Filter"></td></tr></table></cfform>	<br>		
							
		<cfform method="POST" action="payment_process.cfm">	
		<input type="hidden" name ="startdate" value="#startdate#"> 	
		<input type="hidden" name ="enddate" value="#Enddate#"> 
		<input type="hidden" name ="paydate" value="#paydate#"> 
		<input type="hidden" name ="projectfilter" value="#projectfilter#"> 
		<input type="hidden" name ="speaker1" value="#form.speaker1#"> 
		
				<cfquery name="get_meetings" datasource="#application.projdsn#"> 
             Select Distinct
			 ss.MeetingCode,
			 ss.Training,
			 sm.MeetingCode,
			 Left(sm.MeetingCode, 9) as projectid,
			 sm.MeetingDate,
			 sm.MtgStartTime,
			 sm.Confirmed,
			 sm.Type,
			 sm.SpeakerID			
		     From 
			 ScheduleSpeaker sm,
			 ScheduleMaster ss
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
			 sm.MeetingCode NOT LIKE 'GLI%' and
			 sm.MeetingCode = ss.MeetingCode
			  <cfif projectfilter is not ''>
		   AND Left(sm.MeetingCode, 9) = '#projectfilter#'</cfif> 
		    
		   Order By sm.MeetingCode, sm.MeetingDate, sm.MtgStartTime
			 </cfquery>
 <table width="100%" border="0" cellspacing="0" cellpadding="8" align="center" frame="vsides">
 
       <tr> <td valign="top" nowrap ><strong>Meeting Code</strong></td><td valign="top" nowrap ><strong>Date</strong></td><td valign="top" nowrap ><strong>Time</strong></td><td valign="top" nowrap ><strong>Speaker</strong></td><td valign="top" nowrap ><strong>Check Num</strong></td><td align="center" valign="top" nowrap ><strong>Check Amount</strong></td><td valign="top" nowrap ><strong><font color="4A5F64">Paid Date</font></strong></td><td valign="top" nowrap ><strong>Invoiced Date</strong></td></tr>
			 
	        <!--- Loop Query for page --->
		   <cfset i =1>
		   <cfset total =0>
		    <cfset subtotal =0>
		   <cfset project = '#get_meetings.projectid#'>
		   
	   <cfloop query="get_meetings">
	  		  
	    <cfquery name="get_names" datasource="#application.speakerDSN#">
	      Select
		  sp.speakerid, 
		  sp.firstname, 
		  sp.lastname
      	  From 
		  Speaker sp	  
		  
		  Where
		  sp.speakerid = '#get_meetings.SpeakerID#'
			
	  </cfquery> 
	   
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
	  
	  
	   		
	  
	  <cfif #get_meetings.projectid# is not '#project#'>
	  <tr><td colspan="4">&nbsp;</td>
	  <td><strong>SubTotal</strong>: </td>
	  <td><font color="008000">#DollarFormat(subtotal)#</font></td>
	  <td>&nbsp;
	  </td></tr>
	  <tr><td colspan="8">
	  <hr size="1" color="black"><cfset subtotal = 0>
	  </td></tr>
	  <cfelse>
	  	  </cfif> 
	  
	     <tr bgcolor="EEEEEE"><!--- <td>#i#.</td> --->
		<!---  <input type = "hidden" name = "number" value ="#i#"> --->
		 <td valign="middle" nowrap><cfif #get_meetings.projectid# is not '#project#' or #i# is 1>
<cfquery name="get_desc" datasource="#application.projdsn#"> 
Select project_code, product
		     From PIW
			Where project_code = '#get_meetings.projectid#'
			 </cfquery> 
	<strong><font color="800000">#get_desc.product#</font></strong><br>	 
#get_meetings.projectid#<br>
<cfif #Trim(get_meetings.Training)# is 'No'>&nbsp;<cfelse>Training</cfif>
<cfelse>
</cfif>
<input type = "hidden" name = "MeetingCode#i#" value ="#get_meetings.meetingcode#">
<cfif #Trim(get_meetings.Training)# is 'Yes'>Training Session</cfif>
</td>
		 <td valign="middle" nowrap>#DateFormat(get_meetings.MeetingDate, "m/d/yyyy")# <input type = "hidden" name = "Date#i#" value ="#get_pay.Date#"></td>
		 <td valign="middle" nowrap>#TimeFormat(get_meetings.MtgStartTime, "h:mm tt")#<input type = "hidden" name = "Time#i#" value ="#get_pay.Time#"></td>

<td valign="middle" nowrap><cfif #get_names.firstname# is '' or #get_names.lastname# is ''><font color="black">Speaker ID </font><font color="FF0000">#get_meetings.speakerid#</font> <font color="black">Not Found</font><!--- <select name="speaker#i#">
		   <option value="">-SELECT-</option>
		    <cfloop query="getactivespkr">
	        <option value="#getactivespkr.speakerid#">#getactivespkr.firstname# #getactivespkr.lastname#</option>
		   </cfloop> 
	    </select> ---><cfelse><input type = "hidden" name = "speaker#i#" value ="#get_names.speakerid#"><a href="javascript:openpopup2('payment_invoice.cfm?id=#get_names.speakerid#&startdate=#startdate#&enddate=#enddate#&meetingcode=#get_meetings.projectid#&paiddate=#paydate#&PaymentID=#get_pay.PaymentID#&needed_date=#DateFormat(get_pay.paymentdate, "m/d/yyyy")#')"><u>#get_names.firstname# #get_names.lastname#</u></a></cfif> </font></td>

<td valign="middle" nowrap><cfif #get_pay.CheckNumber# is '' or #get_pay.CheckNumber# is 0><input type="text" name="CheckNumber#i#" size="5" maxlength="10"><cfelse><input type = "hidden" name = "CheckNumber#i#" value ="#get_pay.CheckNumber#">#get_pay.CheckNumber#</cfif></td>

<td valign="middle" nowrap>
 <cfquery name="get_salary" datasource="#application.speakerDSN#">
	      Select
		  sc.speakerid,
		  sc.ClientCode,
		  sc.EventFee,
		  sc.TrainingFee
      	  From 
		  SpeakerClients sc 
		  
		  Where
		  sc.speakerid = '#get_meetings.speakerid#' and
		  ClientCode = '#Left(get_meetings.MeetingCode, 5)#'			
	  </cfquery>
	  
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">  
	  <tr>
	  <td width="70%" align="left">
	 <!---  <cfif #get_pay.CheckAmount# is ''> --->
	 

	 <cfif #trim(get_meetings.Training)# is 'yes'>
	 <cfif #get_salary.TrainingFee# is 0>
	 <input type = "hidden" name = "CheckAmount#i#" value ="0">
	 <a href="javascript:openpopup2('../speakers/edit_spkr_clients.cfm?speakerid=#get_meetings.speakerid#')"><u>Enter Fee</u></a>
	 <cfelse>
	 #DollarFormat(get_salary.TrainingFee)#<input type = "hidden" name = "CheckAmount#i#" value ="#get_salary.TrainingFee#">
</cfif>
	 <cfelse>	 
	 	 <cfif #get_salary.EventFee# is 0>
	 <input type = "hidden" name = "CheckAmount#i#" value ="0">
	 <a href="javascript:openpopup2('../speakers/edit_spkr_clients.cfm?speakerid=#get_meetings.speakerid#')"><u>Enter Fee</u></a>
	 <cfelse>
	 #DollarFormat(get_salary.EventFee)#<input type = "hidden" name = "CheckAmount#i#" value ="#get_salary.EventFee#">
	 </cfif>
    </cfif>

<!--- <input type="text" name="CheckAmount#i#" size="5" maxlength="10" value="#get_salary.EventFee#"> ---><!--- <cfelse><input type = "hidden" name = "CheckAmount#i#" value ="#get_pay.CheckAmount#">#DollarFormat(get_pay.CheckAmount)#</cfif> ---> 
	  </td>
	  <!--- <td width="30%" align="left">
	 
	  <input type="Checkbox" name="TrainingFee#i#" visible="Yes" enabled="Yes" value="#get_salary.TrainingFee#" <cfif #get_pay.TrainingFee# gt 0>Checked></cfif>
     <!---  </cfif> --->
	  </td> --->
	  </tr></table>
</td>

<td valign="middle" nowrap>
<cfif get_pay.paymentdate is '' or get_pay.paymentdate is '1/1/1900'>
<input type="text" name="PaymentDate#i#" size="8" maxlength="10" value="#paydate#">
<cfelse>
<input type= "hidden" size="8" name="PaymentDate#i#" value="#DateFormat(get_pay.paymentdate, "m/d/yyyy")#">#DateFormat(get_pay.paymentdate, "m/d/yyyy")#
</cfif></td>
<td valign="middle" nowrap>
<cfif #DateFormat(get_pay.InvoiceDate, "m/d/yyyy")# is '1/1/1900'>
<cfelse>
<em>#DateFormat(get_pay.InvoiceDate, "m/d/yyyy")#</em>
</cfif>
</td>

</tr>

 <cfif #Trim(get_meetings.Training)# is 'No'> 
<cfset total = #total#+#get_salary.EventFee#>
<cfset subtotal = #subtotal#+#get_salary.EventFee#> 
 <cfelse>
<cfset total = #total#+#get_salary.TrainingFee#>
<cfset subtotal = #subtotal#+#get_salary.TrainingFee#>
</cfif>

<cfset counter = #i#>

<input type = "hidden" name = "counter" value ="#counter#">
<cfset i =#i#+1>

<cfset project = '#get_meetings.projectid#'>
</cfloop>

<tr>
<td colspan="4">
&nbsp;
<td align="center"><font face="Verdana" size = "3"><strong>Total</strong>:</font></td>

<td><strong><font face="Verdana" size = "3"><font color="008000">#DollarFormat(total)#</font></font></strong></td>
<td>&nbsp;<td></td>&nbsp;</td>

</td>
</tr>
 <!--- <tr>
 <!--- <td bgcolor="silver">NEW</td> --->
 <td bgcolor="silver" valign="top" nowrap><select name="projectfilter2">
		   <option value="">-SELECT-</option>
		    <cfloop query="getactiveProj">
	        <option value="#getactiveProj.Project_Code#">#getactiveProj.Project_Code#</option>
		   </cfloop> 
	    </select></td> 
 <td bgcolor="silver" valign="top" nowrap><input type="text" name="date2" size="10" maxlength="10" value="#thisdate#"></td>
 <td bgcolor="silver" valign="top" nowrap><input type="text" name="time2" size="8" maxlength="8" value=""></td>
 <td bgcolor="silver" valign="top" nowrap> <select name="speaker2">
		   <option value="">-SELECT-</option>
		    <cfloop query="getactivespkr">
	        <option value="#getactivespkr.speakerid#">#getactivespkr.firstname# #getactivespkr.lastname#</option>
		   </cfloop> 
	    </select></td>
 <td bgcolor="silver" valign="top" nowrap><input type="text" name="checknum2" size="6" maxlength="6" value=""></td>
 <td bgcolor="silver" valign="top" nowrap>$<input type="text" name="amount2" size="10" maxlength="10" value="">&nbsp;<input type="Checkbox" name="training_fee2" visible="Yes" enabled="Yes"></td>
 <td bgcolor="silver" valign="top" nowrap><input type="text" name="paid_date2" size="10" maxlength="10" value="#thisdate#"></td></tr> --->


<tr><td colspan="7">&nbsp;</td>
<td><br><br>
<input type="submit" name="Submit" value="Enter Payments"></td>
</tr>
</table></cfform>


<cfmodule template="#Application.tagpath#/ctags/footer.cfm">  
</cfoutput>