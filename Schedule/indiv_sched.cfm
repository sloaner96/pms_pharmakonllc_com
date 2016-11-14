        
<!--- <cfoutput>		  <cfquery name="getmeetings" datasource="#application.projdsn#"> 
Select *
From ScheduleMaster 
          </cfquery>
		  
	<cfloop query="getmeetings">
	<cfquery name="update" datasource="#application.projdsn#"> 
	 UPDATE ScheduleSpeaker

	        SET 
			MtgStartTime = '#getmeetings.MtgStartTime#',
			MtgEndTime = '#getmeetings.MtgEndTime#'
WHERE Scheduleid = '#getmeetings.Scheduleid#'
	  </cfquery>
	</cfloop>	
	
	  #update.recordcount#
		  </cfoutput>
		  
		  <cfabort>  --->
		  <cfoutput> 
		  
		  <link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />
		   <cfset today = DateFormat(now(), "mm-dd-yyyy")>	
		   <cfset this_month = '#DateFormat(today, "m")#'>
		   <cfset this_year = '#DateFormat(today, "yyyy")#'>
		   
		   <script type="text/javascript">
function openpopupunavail(popurl){
var winpops=window.open(popurl,"","top=200,left=300,width=742,height=610,scrollbars=yes,resizable=yes")
}
</script>

		  <cfquery name="indiv_schd" datasource="#application.projdsn#"  maxrows="10">
	 Select *
From ScheduleSpeaker 
Where speakerid = '#url.speakerid#'
and MeetingDate >= '#today#'
Order by MeetingDate desc
          </cfquery>  
		  
		  
	 <cfquery name="current_indiv" datasource="#application.speakerDSN#">
	     Select 
		 *	  
		 From
		 Speaker
		  Where 		 	
		  speakerid = '#url.speakerid#' 
	          </cfquery> 
		  	  <font face="verdana" size="1">	  		
<a href="javascript:window.close();"><u>Close Window</u></a></font><br>
		
		<center><font face="verdana" size="3"> <strong>#current_indiv.firstname# #current_indiv.lastname#</strong>
<br></font><font face="verdana" size="2">
<!--- <a href="javascript:openpopup2('zoom_Schedule.cfm?day=#dayCounter#&month=#url.month#&year=#url.year#')">
 --->
<a href="../admin/unavailable_edit.cfm?no_menu=1.cfm&ID=#url.speakerid#&year=#this_year#&month=#this_month#" target="_blank"><u>Availability</u></a></center>
  <font face="verdana" size="2" color="c0c0c0"><strong>Schedule</strong></font>
 
<br>
		  
		   <table border="1" cellpadding="2" cellspacing="0" width="100%">
		        <tr bgcolor="d3d3d3">
						   <td>&nbsp;</td><td><font face="verdana" size="1"><strong>Project</strong></font></td><td><font face="verdana" size="1"><strong>Date</strong></font></td><td><font face="verdana" size="1"><strong>Time</strong></font></td><td><font face="verdana" size="1"><strong>Role</strong></font></td><td><font face="verdana" size="1"><strong>Confirmed</strong></font></td></tr>
<cfset index = 0>
						 <cfloop query="indiv_schd">	                    
						   <cfset index = #index# +1>
						   <tr>
						   <td><font face="verdana" size="1"><strong>#index#.</strong></font></td>
						   <td><font face="verdana" size="1" color="maroon">
						   <cfquery name="get_desc" datasource="#application.projdsn#"> 
Select project_code, product
		     From PIW
			Where project_code = '#Left(indiv_schd.MeetingCode,9)#'
			 </cfquery> 				   
						   #get_desc.product#	</font></td>
						   <td> <font face="verdana" size="1">#DateFormat(indiv_schd.meetingdate, "mm/dd/yyyy")#	</td>
						   
						      <td>
							  <table border="0" cellpadding="2" cellspacing="0">
                                            <tr>  <td>
<font face="verdana" size="1">

Start Time:	</font></td><td><font face="verdana" size="1">#TimeFormat(indiv_schd.MtgStartTime, 'h')#: #TimeFormat(indiv_schd.MtgStartTime, 'mm')# #TimeFormat(indiv_schd.MtgStartTime, 'tt')#</font></td></tr>

											 <tr>
											   
											   <td>  <font face="verdana" size="1">       
End Time: </font></td><td><font face="verdana" size="1">#TimeFormat(indiv_schd.MtgEndTime, 'h')#: #TimeFormat(indiv_schd.MtgEndTime, 'mm')# #TimeFormat(indiv_schd.MtgEndTime, 'tt')#</font></font></td></tr></table>			  
							  	</td>
								
								
						      
							     <td><font face="verdana" size="1">#indiv_schd.ActivityType#</font></td>
								 <td><font face="verdana" size="1">	<cfif #indiv_schd.Confirmed# is 1>Yes<cfelse>No</cfif></font></td>
						   </tr> </cfloop>
						   </table>
		  <br>
		 <font face="verdana" size="2" color="c0c0c0"><strong>Profile</strong></font>&nbsp;&nbsp;<cfif #Trim(current_indiv.type)# is 'MOD'><a href="../moderators/edit_mod_clients.cfm?speakerid=#current_indiv.speakerid#"><font face="verdana" size="1">[EDIT]</font></a><cfelse><a href="../speakers/edit_spkr_clients.cfm?speakerid=#current_indiv.speakerid#"><font face="verdana" size="1">[EDIT]</font></a></cfif><br>
		  
		     <table border="1" cellpadding="2" cellspacing="0" width="100%">
		        <tr><td><font face="verdana" size="2"><strong>ID</strong></font></td><td><font face="verdana" size="2"><strong>Name</strong></font></td><td align="center"><font face="verdana" size="2"><strong>Type</strong></font></td><!--- td><font face="verdana" size="2"><strong>Specialty</strong></font></td> ---><td colspan="2"><font face="verdana" size="2"><strong>Products</strong></font></td></tr>
		
				<tr><td valign="top"><font face="verdana" size="2">#current_indiv.speakerid#</font></td><td nowrap valign="top"><font face="verdana" size="2">#current_indiv.salutation# #current_indiv.firstname# #current_indiv.middlename# #current_indiv.lastname#</font></td><td align="center" valign="top"><font face="verdana" size="2">#current_indiv.type#</font></td><!--- <td><font face="verdana" size="2">#current_indiv.specialty#</font></td> --->

<td colspan="2"><!--- <font face="verdana" size="1"> --->
	<cfquery name="all_prods" datasource="#application.speakerDSN#">
	 Select 
sc.ClientCode
From Speaker sp, 
SpeakerClients sc 
Where 
sp.speakerid = '#current_indiv.speakerid#' and
sc.SpeakerId = sp.speakerid		
order by ClientCode asc
           </cfquery> 
<cfset list =0> 
<table border="0" cellpadding="2" cellspacing="0" width="100%">
<tr><td align="left" valign="top"><font face="verdana" size="1">
<cfloop query="all_prods">
<cfset list = #list# +1>
<cfquery name="get_desc_all" datasource="#application.projdsn#"> 
Select project_code, product
From PIW
Where project_code like '#Left(all_prods.ClientCode,5)#%'
			 </cfquery> 
</font><font face="verdana" size="1" color="maroon"><!--- #Left(all_prods.ClientCode,5)# -  --->#get_desc_all.product#<br>
<cfif #list# eq 6>
</font></td>
<td align="left" valign="top"><font face="verdana" size="1">
</cfif> 
</cfloop>
</font></td></tr></font>
</table>

</td></tr>
							
				
				<tr><td colspan="3"><font face="verdana" size="2"><strong>Address</strong></font></td><td><font face="verdana" size="2"><strong>Phone</strong></font></td><td><font face="verdana" size="2"><strong>Email</strong></font></td></tr>

				<cfquery name="details" datasource="#application.speakerDSN#">
					 Select * From SpeakerAddress Where speakerid = '#current_indiv.speakerid#'</cfquery> 
			
		  
		  <tr><td colspan="3"><font face="verdana" size="1">#details.address1# #details.address2#<br>
#details.city# #details.state# #details.zipcode#
</font></td><td><font face="verdana" size="1">Ph. #details.phone1#<br>Of. #details.phone2#<br>Fax. #details.fax1#<br>Cell. #details.cell#<br>Pgr.#details.pager#</font></td><td><font face="verdana" size="1"><a href="mailto:#details.email1#"><u>#details.email1#</u></a><br><a href="mailto:#details.email2#"><u>#details.email2#</u></a>

</font></td></tr>
		  
	
						   </table>
		  
		  </cfoutput>