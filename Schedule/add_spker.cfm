<cfoutput>


<cfif IsDefined("FORM.new_spker")>
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
ClientCode = '#Left(session.projectCode, 5)#'</cfquery> 

<cfquery name="insert_spker" datasource="#application.speakerDSN#">
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
'#form.new_spker#',
'SPKR',
'#proj_info.client_code#',
'#proj_info.client#',	
'#get_id.ProductID#',		
'#form.event_fee#',	
'#form.training_fee#'
			)
	  </cfquery>
</cfif>

<font face="verdana" size="1"><a href="javascript:window.close();"><u>Close Window</u></a></font><br><br>

<center><font face="verdana" size="2">
Add a New Speaker for <br>
<cfquery name="get_desc" datasource="#application.projdsn#"> 
Select project_code, product
		     From PIW
			Where project_code = '#session.projectCode#'
			 </cfquery> 
<strong>#get_desc.product#</strong></font><br><br></center>

<cfquery name="all_spkers" datasource="#application.speakerDSN#">
Select 
sp.speakerid, 
sp.firstname, 
sp.lastname
From Speaker sp 

Where sp.type = 'SPKR' and active = 'yes'
		  		  Order by lastname
          </cfquery>  
		  		
		
		<font face="verdana" size="2" color="maroon">All Speakers</font> 	
<cfform method="POST" action="add_spker.cfm">
<select name="new_spker">
<option value="">- Add -</option>
													     <cfloop query="all_spkers">
														 
													      <option value="#all_spkers.speakerid#">#UCase(lastname)#, #UCase(firstname)#</option>
													    </cfloop> 
</select><br><br>
<font face="verdana" size="2">
Event Fee:    &nbsp;&nbsp;$<cfinput type="Text" name="event_fee" message="You Must Enter an Event Fee" required="Yes" visible="Yes" enabled="Yes" size="6">
<br><br>
Training Fee: $<cfinput type="Text" name="training_fee" message="You Must Enter a Training Fee" required="Yes" visible="Yes" enabled="Yes" size="6">
<br><br>
<input type="submit" name="Submit" value="Add">
</cfform>
</font>
<font face="verdana" size="2">
<cfif IsDefined("FORM.new_spker")>
<cfquery name="new_spker" datasource="#application.speakerDSN#">
Select 
sp.speakerid, 
sp.firstname, 
sp.lastname
From Speaker sp 
Where sp.type = 'SPKR' and sp.speakerid = '#FORM.new_spker#'		  		 
          </cfquery>  
#new_spker.firstname# #new_spker.lastname# </font><font face="verdana" size="2" color="maroon"><em><strong>Added</strong></em></font>
</cfif>
</cfoutput>
