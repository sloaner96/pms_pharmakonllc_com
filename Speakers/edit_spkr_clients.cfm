		  <cfoutput>
		 <cfquery name="indiv_schd" datasource="#application.projdsn#"  maxrows="10">
	 Select *
From ScheduleSpeaker 
Where speakerid = '#url.speakerid#'
          </cfquery>  		  
		  
	 <cfquery name="current_indiv" datasource="#application.speakerDSN#">
	     Select 
		 *	  
		 From
		 Speaker
		  Where 		 	
		  speakerid = '#url.speakerid#' 
	          </cfquery>   
		  
		 <cfif IsDefined("FORM.new_spkr")>
<cfquery name="proj_info" datasource="#application.projdsn#"> 
Select Distinct
p.client, 
p.client_code 
From
piw p
Where
p.client_code = '#Left(session.projectCode, 5)#'</cfquery> 

<cfquery name="get_id" datasource="#application.speakerDSN#">
Select Distinct
ProductID, ClientCode
From
SpeakerClients 
Where
ClientCode = '#Left(form.projects, 5)#'</cfquery> 

<cfquery name="insert_SPKR" datasource="#application.speakerDSN#">
	      Insert Into SpeakerClients(   
	SpeakerID,
	Type,
	ClientCode,
	ClientID,
	ProductID,	
	EventFee,
	TrainingFee
	   
 ) 		
			VALUES(
'#form.new_spkr#',
'SPKR',
'#Left(form.projects, 5)#',
'#proj_info.client#',	
'#get_id.ProductID#',		
'#form.eventfee#',	
'#form.trainingfee#'
			)
	  </cfquery>
</cfif> 
		<cfif IsDefined("FORM.update_clients")>	

	<cfquery name="all_prods1" datasource="#application.speakerDSN#">
	 Select 
sc.ClientCode, sc.EventFee, sc.TrainingFee
From Speaker sp, 
SpeakerClients sc 
Where 
sp.speakerid = '#current_indiv.speakerid#' and
sc.SpeakerId = sp.speakerid		
order by ClientCode asc
           </cfquery> 
		   
<cfset i = 1>

<cfloop query="all_prods1">  
<cfset new_eventfee = evaluate("form.eventfee#i#")>
<cfset new_trainingfee = evaluate("form.trainingfee#i#")>
<cfquery name="update_client#i#" datasource="#application.speakerDSN#"> 
	      UPDATE 
		  SpeakerClients
	        SET  
			EventFee = '#new_eventfee#', 
			TrainingFee = '#new_trainingfee#'
		  WHERE 
		  ClientCode = '#Left(all_prods1.ClientCode, 5)#' and
          speakerid = '#url.speakerid#'
	  </cfquery>  
	  
         <cfif IsDefined("form.delete#i#")>
<cfset delete = evaluate("form.delete#i#")> 

<cfquery name="delete#i#" datasource="#application.speakerDSN#"> 
Delete from SpeakerClients
Where 
ClientCode = '#Left(all_prods1.ClientCode, 5)#' and
speakerid = '#url.speakerid#'
</cfquery> 
          </cfif> 
  	
  <cfset i = i+1>
  </cfloop>
</cfif>  
	  
		 
  <table border="0" cellpadding="2" cellspacing="0" width="100%">
		        <tr><td align="left"><font face="verdana" size="2"><strong>ID</strong></font></td><td align="left"><font face="verdana" size="2"><strong>Name</strong></font></td><td align="left"><font face="verdana" size="2"><strong>Type</strong></font></td><td align="left"><font face="verdana" size="2"><strong>Specialty</strong></font></td> </tr>
		
				<tr><td valign="top" align="left"><font face="verdana" size="2">#current_indiv.speakerid#</font></td><td nowrap valign="top" align="left"><font face="verdana" size="2">#current_indiv.salutation# #current_indiv.firstname# #current_indiv.middlename# #current_indiv.lastname#</font></td><td align="left" valign="top"><font face="verdana" size="2">#current_indiv.type#</font></td><td align="left"><font face="verdana" size="2"><cfif #current_indiv.specialty# is ''>&nbsp;<cfelse>#current_indiv.specialty#</cfif></font></td></tr>
<tr><td colspan ="4">&nbsp;<br><br></td></tr>
<tr>

<td colspan="4">
<table border="1" cellpadding="2" cellspacing="0" width="100%">
<tr>
<td align="left" valign="top"><font face="verdana" size="1">
<strong>Product</strong></font>
</td>
<td align="left" valign="top"><font face="verdana" size="1">
<strong>Event Fee</strong></font>
</td>
<td align="left" valign="top"><font face="verdana" size="1">
<strong>Training Fee</strong></font>
</td>
<td align="left" valign="top"><font face="verdana" size="1" color="red">
Delete</font>
</td>
</tr>

  	<cfquery name="all_prods" datasource="#application.speakerDSN#">
	 Select 
sc.ClientCode, sc.EventFee, sc.TrainingFee
From Speaker sp, 
SpeakerClients sc 
Where 
sp.speakerid = '#current_indiv.speakerid#' and
sc.SpeakerId = sp.speakerid		
order by ClientCode asc
           </cfquery> 
  <cfset i = 1>
<cfloop query="all_prods">  	
<form method="POST" action="edit_spkr_clients.cfm?speakerid=#url.speakerid#">
<input type="hidden" name="update_clients" value="yes">
<tr>
<td align="left" valign="top" nowrap>
<cfquery name="get_desc_all" datasource="#application.projdsn#"> 
Select project_code, product
From PIW
Where project_code like '#Left(all_prods.ClientCode,9)#%'
</cfquery> 
<font face="verdana" size="1" color="maroon">#Left(all_prods.ClientCode,9)#</font> - <font face="verdana" size="1">#get_desc_all.product#</font>
</td>
<td><font face="verdana" size="2" color="green">
$<input type ="text" name ="eventfee#i#" value = "#all_prods.eventFee#" size="10">
</font>
</td>
<td><font face="verdana" size="2" color="green">
$<input type ="text" name ="trainingfee#i#" value = "#all_prods.trainingFee#" size="10"></font>
</td>
<td><font face="verdana" size="1">
<input type="checkbox" name="delete#i#" value="delete" visible="Yes" enabled="Yes"></font>
</td>
</tr>
<cfset i = i+1>
</cfloop>
<tr><td colspan ="4" align="right">
<input type="submit" name="Submit" value="Update Clients">
</td></tr>
</table>
</form>
</td></tr>
<td colspan ="4">
<hr size="1" color="black">
</td>

</td></tr>
</table>

<cfform method="POST" action="edit_spkr_clients.cfm?speakerid=#url.speakerid#">
<font face="verdana" size="2">
<strong>Associate a New Product</strong> <br><br>
<cfquery name="get_proj" datasource="#application.projdsn#"> 
 Select Distinct project_code, product 
		 From piw
		 Where project_status IN (2, 3)
		 Order By product asc
			 </cfquery> 
			 
 <select name="projects">
		   <option value="">--Select--</option>
		    <cfloop query="get_proj">
	        <option value="#get_proj.Project_Code#"<cfif isDefined("url.meeting")><cfif trim(url.meeting) EQ trim(get_proj.Project_Code)>Selected</cfif></cfif>>#get_proj.Project_Code# - #product#</option>
		   </cfloop> 
	    </select>
<br><br>
<input type="hidden" name="new_spkr" value="#url.speakerid#">

<font face="verdana" size="2">
Event Fee:    &nbsp;&nbsp;$<cfinput type="Text" name="eventfee" message="You Must Enter an Event Fee" required="Yes" visible="Yes" enabled="Yes" size="6">
<br><br>
Training Fee: $<cfinput type="Text" name="trainingfee" message="You Must Enter a Training Fee" required="Yes" visible="Yes" enabled="Yes" size="6">
<br><br>

<input type="submit" name="Submit" value="Add">
</cfform>
</font>
<font face="verdana" size="2">
<cfif IsDefined("FORM.new_spkr")>
<cfquery name="new_spkr" datasource="#application.speakerDSN#">
Select 
sp.speakerid, 
sp.firstname, 
sp.lastname
From Speaker sp 
Where sp.type = 'SPKR' and sp.speakerid = '#FORM.new_spkr#'		  		 
          </cfquery>  
#new_spkr.firstname# #new_spkr.lastname# </font><font face="verdana" size="2" color="maroon"><em><strong>Added</strong></em></font>
</cfif>
</cfoutput>