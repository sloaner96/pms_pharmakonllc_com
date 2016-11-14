

<cfif form.EventKey NEQ "">
  <cfset UpdateStatus = request.admin.UpdateMtgStatus(form.EventKey)>
   
  <cfset MtgParticipants = request.admin.GetMtgParticipants(form.EventKey)>
  <cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Cancel Upcoming Meeting" showCalendar="0">
	<cfoutput>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		   <tr>
		       <td><strong>You Have Successfully Cancelled #form.EventKey#.</strong> <a href="dsp_cancelCI.cfm">Click Here</a> to go back and cancel another meeting</td>
		   </tr>
		</table><br>
		
		<table border="0" cellpadding="4" cellspacing="1" width="100%">
          <tr bgcolor="##444444">
		       <td><strong style="color:##ffffff;">Name</strong></td>
               <td><strong style="color:##ffffff;">Status</strong></td>
		   </tr>
		   <cfloop query="MtgParticipants">
			   <tr <cfif MtgParticipants.currentrow MOD(2) EQ 0>bgcolor="##eeeeee"</cfif>>
			       <td>#MtgParticipants.Firstname# <cfif MtgParticipants.Middlename NEQ "">#MtgParticipants.Middlename#</cfif> #MtgParticipants.Lastname#</td>
				   <td>#MtgParticipants.Status#</td>
				   
				</tr>
		   </cfloop>
        </table>           
	</cfoutput>
  <cfmodule template="#Application.tagpath#/ctags/footer.cfm">	
<cfelse>
   <cflocation url="dsp_CancelCI.cfm?e=1" addtoken="NO">
</cfif>