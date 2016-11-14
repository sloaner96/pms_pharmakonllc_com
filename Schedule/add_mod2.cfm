<cfoutput>


<cfif IsDefined("FORM.new_mod")>
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

<cfquery name="insert_MOD" datasource="#application.speakerDSN#">
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
'#form.new_mod#',
'MOD',
'#Left(form.projects, 5)#',
'#proj_info.client#',	
'#get_id.ProductID#',		
'#form.event_fee#',	
'#form.training_fee#'
			)
	  </cfquery>
</cfif>

<font face="verdana" size="1"><a href="javascript:window.close();"><u>Close Window</u></a></font><br><br>
<cfform method="POST" action="add_mod2.cfm">
<center><font face="verdana" size="2">
<strong>Add a New Moderator for:</strong> <br><br>
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

<cfquery name="all_mods" datasource="#application.speakerDSN#">
Select 
sp.speakerid, 
sp.firstname, 
sp.lastname
From Speaker sp 

Where sp.type = 'MOD' and active = 'yes'
		  		  Order by lastname
          </cfquery>  
		  		
		
		<font face="verdana" size="2" color="maroon">All Moderators</font> 	

<select name="new_mod">
<option value="">- Add -</option>
													     <cfloop query="all_mods">
														 
													      <option value="#all_mods.speakerid#"<cfif isDefined("url.speakerid")><cfif trim(url.speakerid) EQ trim(all_mods.speakerid)>Selected</cfif></cfif>>#UCase(lastname)#, #UCase(firstname)#</option>
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
<cfif IsDefined("FORM.new_mod")>
<cfquery name="new_mod" datasource="#application.speakerDSN#">
Select 
sp.speakerid, 
sp.firstname, 
sp.lastname
From Speaker sp 
Where sp.type = 'MOD' and sp.speakerid = '#FORM.new_mod#'		  		 
          </cfquery>  
#new_mod.firstname# #new_mod.lastname# </font><font face="verdana" size="2" color="maroon"><em><strong>Added</strong></em></font>
</cfif>
</cfoutput>