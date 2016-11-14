<cfoutput>
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
</style>
<cfset thisdate = DateFormat(Now(), "m/d/yyyy")>

 <cfset todaydate = DateFormat(now(), "mm/dd/yyyy")>
<cfset todaytime = timeFormat(now(), "hh:mm:tt")>
<cfset update_log = '#todaydate# #todaytime#'>

<!--- get meeting --->

           <cfquery name="get_meetings" datasource="#application.projdsn#"> 
                 Select 
			 sm.MeetingCode,
			 ss.Training,
			 ss.MeetingCode,
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
			 sm.MeetingDate >= '#startdate#' and
			 sm.MeetingDate <= '#Enddate#' and
			 sm.Confirmed = '1'	and
			 sm.type= 'SPKR' and
			 sm.SpeakerID = '#url.id#' and
			 Left(sm.MeetingCode, 9) = '#Left(url.meetingcode, 9)#'	and
			 sm.MeetingCode = ss.MeetingCode
			 
		    
		   Order By sm.MeetingCode, sm.MeetingDate, sm.MtgStartTime 
			 </cfquery>
<!--- get speaker --->			 
<cfquery name="get_spkr" datasource="#application.speakerDSN#">
select *
from Speaker	
where speakerid = '#url.id#'
</cfquery>		

<cfquery name="get_spkr_add" datasource="#application.speakerDSN#">
select *
from SpeakerAddress	
where speakerid = '#url.id#'
</cfquery>					 
 			
			 <cfquery name="get_prod" datasource="#application.projdsn#"> 
Select project_code, product
		     From PIW
			Where project_code = '#url.meetingcode#'
			 </cfquery> 
			 
			 <cfquery name="get_corp" datasource="#application.projdsn#"> 
            SELECT * 
			FROM corp	
			Where corp_abbrev = '#Left(url.meetingcode, 1)#'		
						</cfquery> 
			 
 <table width="650" border="0" cellspacing="0" cellpadding="0" align="center">
 <tr>
 <td> 
  <table border="0" cellspacing="0" cellpadding="3" align="left" width="100%">
  <tr>
 <td width="25%">
  <table border="1" cellspacing="0" cellpadding="3" align="left" width="100%" bordercolor="000000">
  <tr><td>
 <font face="Verdana" size = "2"><em>Date Needed</em></font><br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<!---  <cfif #url.needed_date# is ''> --->
  <input type = "text" size="10" value="#url.paiddate#">
  <!--- <cfelse>
   <input type = "text" size="10" value="#url.needed_date#">
 </cfif> --->
  </td></tr></table> 
 </td> 
 <td align="right" valign="top"><font face="Verdana" size = "1"><A HREF="javascript:window.print()"><u>Print Invoice</u></font> <img src="../images/btn_printer_friendly.gif" alt="Print Invoice" width="18" height="15" border="0"></a></td></tr></table>
 
 <br><br><br><br>

   <table border="1" cellspacing="0" cellpadding="3" align="center" width="80%">
  <tr>
 <td align="center"><font face="Verdana" size = "3"><strong><em>#get_prod.product# Invoice</em></strong></font>
 </td></tr>
  </table>
  <br><center>
<font face="Verdana" size = "3"><strong>#get_corp.corp_value#</strong></font>
</center>
<br>
  <table border="0" cellspacing="0" cellpadding="3" align="center" width="100%">
  <tr>
 <td align="center">
<font face="Verdana" size = "2">
<em><strong>Fax Number: <u>888-397-0761</u></strong></em></font>
</td>
<td align="center">
<font face="Verdana" size = "2">
<em><strong>Phone Number: <u>800-617-8252</u></strong></em></font>
</td>
 </tr>
 <tr><td colspan="2">
 <hr width="100%" size="1" color="000000">
 </td></tr>
 </table>
 
<table border="0" cellspacing="0" cellpadding="3" align="center" width="100%">
<tr>
<td width="50%"><font face="Verdana" size = "2"><em>Speaker Information</em></font></td>
<td><font face="Verdana" size = "2"><em>MeetingCode</em></font></td>
</tr>
<tr>
<td><font face="Verdana" size = "2"><strong>#get_spkr.firstname# #get_spkr.lastname#</strong></font></td>
<td><font face="Verdana" size = "2"><strong>#Left(get_meetings.MeetingCode, 9)#</strong></font></td>
</tr>
<tr>
<td><font face="Verdana" size = "2">Business Name: </font></td>
<td><font face="Verdana" size = "2">Speaker S.S.N (TaxID##)</font></td>
</tr>
<tr>
<td><font face="Verdana" size = "2">Address: <strong>#get_spkr_add.address1# #get_spkr_add.address2#</strong>
<br>Address: <strong>#get_spkr_add.address3#</strong>
</font></td>
<td><font face="Verdana" size = "2"><cfif #get_spkr.taxidtype# is 'SSN'>SSN - <strong>#get_spkr.TaxID#</strong><br>
<cfelse>
<br>
<font face="Verdana" size = "2">Tax ID - <strong>#get_spkr.TaxID#</strong>
</cfif></font></td>
</tr>
<tr>
<td><font face="Verdana" size = "2">City: <strong>#get_spkr_add.city#</strong></font></td>
<td><font face="Verdana" size = "1">(if Business Name is used, Tax ID ## is needed)</font></td>
</tr>
<tr>
<td><font face="Verdana" size = "2">State: <strong>#get_spkr_add.state#</strong> &nbsp;&nbsp;Zip: <strong>#get_spkr_add.zipcode#</strong></font></td>
<td><font face="Verdana" size = "1">&nbsp;</font></td>
</tr>
<tr>
<td colspan="2"><br></td>
</tr>
</table>

   <hr width="100%" size="1" color="000000">
<br>
  <table border="1" cellspacing="0" cellpadding="3" align="center" width="400">
    <tr>
 <td align="center"><font face="Verdana" size = "2">
<strong>Date</strong></font></td>
 <td align="center"><font face="Verdana" size = "2">
<strong>Time</strong></font> </td> 
 <td align="center"><font face="Verdana" size = "2">
<strong>Fee per Meeting</strong></font></td>
 </tr>
 <cfset total =0>
		   
  <cfloop query="get_meetings">
  <!--- get fees --->
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
  <!--- get payment info --->	
 <cfquery name="get_payment" datasource="#application.projdsn#">
			 Select  
             sp.meetingCode,
			 sp.speakerid,
			 sp.Date,
			 sp.Time,
			 sp.CheckAmount,
			 sp.CheckNumber,
			 sp.TrainingFee,
			 sp.PaymentDate,
			 sp.InvoiceDate,
			 sp.PaymentID
			 From
			 SpeakerPayments sp
			 Where 
			 sp.meetingcode = '#get_meetings.meetingcode#'  and 			
             speakerid = '#get_meetings.SpeakerID#'
	        </cfquery>
		
			<!--- update invoice --->
			
<cfif #get_payment.meetingCode# is ''>		
			
			   <cfquery name="insert_pay" datasource="#application.projdsn#"> 
	      Insert Into SpeakerPayments
		  (
	SpeakerID,
	MeetingCode,
	Date,
	Time,
	CheckAmount,
	TrainingFee,	
	PaymentDate,
	InvoiceDate,
	Notes,
	DateAdded,
	LastUpdated,
	UpdatedBy
	   
 ) 		
			VALUES(
    '#get_meetings.SpeakerID#',
	'#get_meetings.meetingcode#',
	'#get_meetings.MeetingDate#',
	'#get_meetings.MtgStartTime#',
	<cfif #trim(get_meetings.Training)# is 'yes'>
	'#get_salary.TrainingFee#',
	 <cfelse>
	 '#get_salary.EventFee#',
    </cfif>	
	<cfif #trim(get_meetings.Training)# is 'yes'>
	'#get_salary.TrainingFee#',
	 <cfelse>
	 '0',
    </cfif>	
	'#url.paiddate#',
	'',
	'',
	'#todaydate#',
	'#todaydate# #todaytime#',
	'#session.user#'
			)
	  </cfquery>  
			
	</cfif>					
						
			<cfif get_payment.InvoiceDate is '' or get_payment.InvoiceDate is '1/1/1900'>
   <cfquery name="update_invoice" datasource="#application.projdsn#"> 
	      UPDATE SpeakerPayments	  
	        SET  
			 InvoiceDate = '#thisdate#',
			 LastUpdated = '#update_log#', 
			 UpdatedBy = '#session.user#'
			 Where
		     meetingcode = '#get_meetings.meetingcode#'  and 			
             speakerid = '#get_meetings.SpeakerID#'
	  </cfquery>  
	 	       </cfif>
  <tr>
 <td align="center"><font face="Verdana" size = "2">
#DateFormat(get_meetings.MeetingDate, "m/d/yyyy")#</font></td>
 <td align="center"><font face="Verdana" size = "2">
#TimeFormat(get_meetings.MtgStartTime, "h:mm tt")# ET
  </font></td> 
 <td align="center"><font face="Verdana" size = "2">
 	 <cfif #trim(get_meetings.Training)# is 'yes'>
	 #DollarFormat(get_salary.TrainingFee)#
	 <cfelse>
	 #DollarFormat(get_salary.EventFee)#
    </cfif>

  </font></td>
  
 </tr>
 <cfif #Trim(get_meetings.Training)# is 'No'> 
<cfset total = #total#+#get_salary.EventFee#>

 <cfelse>
<cfset total = #total#+#get_salary.TrainingFee#>

</cfif>
</cfloop>
  <tr>
 </table>
 <br>
  <table border="0" cellspacing="0" cellpadding="3" align="center" width="400">
    <tr> 
 <td align="right" colspan="3"><font face="Verdana" size = "2">
<strong>Total Amount Due:&nbsp;&nbsp;<font color="008000">#DollarFormat(total)#</font></strong>
  </font></td> 
  </tr>
   </td> 
 </tr>
 </table>
<br><br><br><br><br><br>
   <table border="1" cellspacing="0" cellpadding="3" align="center" bordercolor="000000" width="100%">
    <tr>
 <td align="left">
 
  <table border="0" cellspacing="0" cellpadding="3" align="center"width="100%">
    <tr>
 <td align="left" colspan = "2">
 <font face="Verdana" size = "1"><strong>(Office Use Only)</strong></font><br>&nbsp;</td></tr>
 <tr> 
 <td width="60%" nowrap><font face="Verdana" size = "2"><em>Approved By:</em><strong>__________________________</strong></font></td>  <td width="40%"><font face="Verdana" size = "2"><em>Date:</em>&nbsp;&nbsp;<input type = "text" size="10" value="#thisdate#"></font></td>
 </tr>
  <tr> 
 <td width="60%"><font face="Verdana" size = "2"><br><br></td>  <td width="50%"><br></td>
 </tr>
  <tr> 
 <td width="40%" nowrap><font face="Verdana" size = "2"><em>Check Number:</em>&nbsp;&nbsp;<strong><input type = "text" size="10" value="#get_payment.CheckNumber#"></strong></font></td>  <td width="50%"><font face="Verdana" size = "2"><em>Paid Date:</em>&nbsp;&nbsp;<input type = "text" size="10" value="#url.paiddate#"></font></td>
 </tr>  
 </table>
 <br>
 </td>    
 </tr>
 </table>
 <br>
 
   <table border="0" cellspacing="0" cellpadding="3" align="center" bordercolor="000000" width="100%">
    <tr>
 <td align="left">
<font face="Verdana" size = "1">#DateFormat(thisdate, "dddd, mmmm d, yyyy")#</font>
    </td> 
	
	 <td align="right">
<font face="Verdana" size = "1">GL5999</font>

    </td>
 </tr>
 </table> 
 
<br><br>
<hr width="100%" size="1" color="silver">
<br><br>

   </td> 
 </tr>
 </table> 
 </cfoutput>