<!---
    $Id: ,v 1.0 2000/00/00 rsloan Exp $
    Copyright (c) 2005 Pharmakon, LLC.

    Description:
        
    Parameters:
        
    Usage:
        
    Documentation:
        
    Based on:
        
--->
<cfparam name="URL.E" default="">
<!--- Select Distinct Meeting Codes --->
<cfset GetMtg = request.admin.GetDistinctMtg(Now())>


<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Cancel Upcoming Meeting" showCalendar="0">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
   <tr>
       <td>Use the form below to cancel a meeting. First select the meeting code</td>
   </tr>
</table><br>
<cfif url.e EQ 1>
 <strong style="color:#CC0000">Error! You Must Select a Meeting to Cancel</strong>
</cfif>
<form name="cancelmeeting" method="POST" action="dsp_CancelCI.cfm"> 
	<table border="0" cellpadding="0" cellspacing="4">
	   <tr>
	       <td><strong>Select a Meeting Code:</strong></td>
		   <td><select name="MtgKey">
		            <option value="">-- Choose One --</option>
		         <cfoutput query="GetMtg">
		            <option value="#GetMtg.EventKey#" <cfif IsDefined("form.MtgKey")><cfif form.MtgKey EQ getMtg.EventKey>Selected</cfif></cfif>>#GetMtg.EventKey#</option>
				 </cfoutput> 
			   </select>
		   </td>
		   <td><input type="submit" name="submit" value="Select"></td>
	   </tr>
	</table>
</form>           
<br>
<cfif IsDefined("form.MtgKey")>
   <!--- Get the participants for the meeting --->
   <cfset MtgParticipants = request.admin.GetMtgParticipants(form.mtgKey)>
	
	<hr noshade size="1">
	<cfif MtgParticipants.recordcount GT 0>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
      <tr>
         <td><strong style="color:#cc0000;"> WARNING! By clicking the "cancel meeting" button, the people below will have the status set to Mtg Cancel.</strong></td>
      </tr>
    </table>  
	<br>
	
	<form name="cancelCi" action="act_CancelCI.cfm" Method="POST">   
	  <cfoutput><input type="hidden" name="EventKey" value="#form.MtgKey#"></cfoutput>     
		<table border="0" cellpadding="4" cellspacing="1" width="100%">
		  <tr>
		    <td colspan="4"><strong><cfoutput>#MtgParticipants.recordcount#</cfoutput> participants will be effected by the cancellation of <cfoutput>#form.mtgKey#</cfoutput>.</strong> </td>
		  </tr>
		  
		  
		   <tr bgcolor="#444444">
		       <td><strong style="color:#ffffff;">Name</strong></td>
			   <td><strong style="color:#ffffff;">Event Date</strong></td>
			   <td><strong style="color:#ffffff;">Event Time</strong></td>
			   <td><strong style="color:#ffffff;">Date CI Loaded</strong></td>
		   </tr>
		   <cfoutput query="MtgParticipants">
			   <tr <cfif MtgParticipants.currentrow MOD(2) EQ 0>bgcolor="##eeeeee"</cfif>>
			       <td>#MtgParticipants.Firstname# <cfif MtgParticipants.Middlename NEQ "">#MtgParticipants.Middlename#</cfif> #MtgParticipants.Lastname#</td>
				   <td>#DateFormat(MtgParticipants.EventDate, 'MM/DD/YYYY')#</td>
				   <td>#MtgParticipants.EventTime#</td>
				   <td>#DateFormat(MtgParticipants.ci_load_date, 'MM/DD/YYYY')# at #TimeFormat(MtgParticipants.ci_load_date, 'hh:mm tt')#</td>
			   </tr>
		   </cfoutput>
		   <tr>
		     <td colspan="4" align="center"><input type="submit" name="submit" value="Cancel Meeting"></td>
		   </tr>
		</table> 
	</form>  
	<cfelse>
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
      <tr>
         <td><strong>There are no participants for this meeting. Please select another meeting above.</strong></td>
      </tr>
   </table>            
	</cfif>
</cfif>        
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
