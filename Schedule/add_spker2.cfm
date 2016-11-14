<cfoutput>


<cfif IsDefined("FORM.new_spker")>
<cfquery name="proj_info" datasource="#application.projdsn#"> 
Select Distinct
p.client, 
p.client_code 
From
piw p
Where
p.client_code = '#Left(form.projects, 5)#'</cfquery> 

<cfquery name="get_id" datasource="#application.speakerDSN#">
Select Distinct
ProductID, ClientCode
From
SpeakerClients 
Where
ClientCode = '#Left(form.projects, 5)#'</cfquery> 

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
'#Left(form.projects, 5)#',
'#proj_info.client#',	
'#get_id.ProductID#',		
'#form.event_fee#',	
'#form.training_fee#'
			)
	  </cfquery>
</cfif>

<font face="verdana" size="1"><a href="javascript:window.close();"><u>Close Window</u></a></font><br><br>
<cfform method="POST" action="add_spker2.cfm">
<font face="verdana" size="2">
<strong>Add a New Speaker for:</strong> <br><br>
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

<select name="new_spker">
<option value="">- Add -</option>
													     <cfloop query="all_spkers">
														 
													      <option value="#all_spkers.speakerid#"<cfif isDefined("url.speakerid")><cfif trim(url.speakerid) EQ trim(all_spkers.speakerid)>Selected</cfif></cfif>>#UCase(lastname)#, #UCase(firstname)#</option>
													    </cfloop> 
</select><br><br>
<font face="verdana" size="2">
Event Fee:    &nbsp;&nbsp;$<cfinput type="Text" name="event_fee" message="You Must Enter an Event Fee" required="Yes" visible="Yes" enabled="Yes" size="6">
<br><br>
Training Fee: $<cfinput type="Text" name="training_fee" message="You Must Enter a Training Fee" required="Yes" visible="Yes" enabled="Yes" size="6">
<br><br>
<center>
<input type="submit" name="Submit" value="Add"></center>
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
