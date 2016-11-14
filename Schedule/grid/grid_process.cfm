  <cfoutput>
  <cfif isdefined("Form.Schedule.rowstatus.action")>

  <cfloop index = "Counter" from = "1" to =
    #arraylen(Form.Schedule.rowstatus.action)#>
		

      The row action for #Counter# is:
      #Form.Schedule.rowstatus.action[Counter]#
      <br>
    

    <cfif Form.Schedule.rowstatus.action[counter] is "D">
	
		<!--- split speaker first and last name --->
	<cfif #Form.Schedule.Speaker1[Counter]# is not '' and #Form.Schedule.Speaker1[Counter]# is not 'NULL'>
	<cfset pos1 = '#find(" ",Form.Schedule.Speaker1[Counter])#'>		
	<cfset first_name1 = '#Left(Form.Schedule.Speaker1[Counter], pos1)#'>
	<cfset last_name1 = '#Mid(Form.Schedule.Speaker1[Counter], pos1, 50)#'>
	<cfelse>
	<cfset first_name1 = ''>
	<cfset last_name1 = ''>
	</cfif>
	
	<cfif #Form.Schedule.Speaker2[Counter]# is not '' and #Form.Schedule.Speaker2[Counter]# is not 'NULL'>
	<cfset pos2 = '#find(" ",Form.Schedule.Speaker2[Counter])#'>	
	<cfset first_name2 = '#Left(Form.Schedule.Speaker2[Counter], pos2)#'>	
	<cfset last_name2 = '#Mid(Form.Schedule.Speaker2[Counter], pos2, 50)#'>
	<cfelse>
	<cfset first_name2 = ''>
	<cfset last_name2 = ''>
	</cfif>
   	   
	   <!--- split mod first and last name --->	   
	<cfif #Form.Schedule.Moderator1[Counter]# is not '' and #Form.Schedule.Moderator1[Counter]# is not 'NULL'>   
	<cfset pos3 = '#find(" ",Form.Schedule.Moderator1[Counter])#'>		
	<cfset first_name3 = '#Left(Form.Schedule.Moderator1[Counter], pos3)#'>
	<cfset last_name3 = '#Mid(Form.Schedule.Moderator1[Counter], pos3, 50)#'>
	<cfelse>
	<cfset first_name3 = ''>
	<cfset last_name3 = ''>
	</cfif>
	
	<cfif #Form.Schedule.Moderator2[Counter]# is not '' and #Form.Schedule.Moderator2[Counter]# is not 'NULL'>
	<cfset pos4 = '#find(" ",Form.Schedule.Moderator2[Counter])#'>	
	<cfset first_name4 = '#Left(Form.Schedule.Moderator2[Counter], pos4)#'>
	<cfset last_name4 = '#Mid(Form.Schedule.Moderator2[Counter], pos4, 50)#'>
    <cfelse>
	<cfset first_name4 = ''>
	<cfset last_name4 = ''>
	</cfif>
	
	
	<cfif #Form.Schedule.Moderator1[Counter]# is not ''>
	
	<cfquery name="get_mod1id" datasource="#application.speakerDSN#">
	select speakerid
	from Speaker	
	where 
	lastname = '#last_name3#' and
	firstname = '#first_name3#'
	</cfquery>		
	
		
	<cfquery name="delete_availmod1" datasource="#application.speakerDSN#">			 
	     delete from SpeakerAvailable
	     where
		 speakerID =  '#get_mod1id.SpeakerID#' and
		 availtodate =  '#DateFormat(Form.Schedule.Date[Counter], "m/d/yyyy")#' and
		 availfromtime = '#DateFormat(Form.Schedule.Date[Counter], "m/d/yyyy")# #TimeFormat(Form.Schedule.tt[Counter], "h:mm tt")#'
	  </cfquery>
	  
	<cfelseif #Form.Schedule.Moderator2[Counter]# is not ''>
	  
	  	<cfquery name="get_mod2id" datasource="#application.speakerDSN#">
	select speakerid
	from Speaker	
	where 
	lastname = '#last_name4#' and
	firstname = '#first_name4#'
	</cfquery>		
	
	<cfquery name="delete_availmod2" datasource="#application.speakerDSN#">			 
	     delete from SpeakerAvailable
	     where
		 speakerID =  '#get_mod1id.SpeakerID#' and
		  availtodate =  '#DateFormat(Form.Schedule.Date[Counter], "m/d/yyyy")#' and
		 availfromtime = '#DateFormat(Form.Schedule.Date[Counter], "m/d/yyyy")# #TimeFormat(Form.Schedule.tt[Counter], "h:mm tt")#'
	  </cfquery>
	  
	<cfelseif #Form.Schedule.Speaker1[Counter]# is not ''>
	  
	  <cfquery name="get_spkr1id" datasource="#application.speakerDSN#">
	select speakerid
	from Speaker	
	where 
	lastname = '#last_name1#' and
	firstname = '#first_name1#'
	</cfquery>		
	
	<cfquery name="delete_availmod2" datasource="#application.speakerDSN#">			 
	     delete from SpeakerAvailable
	     where
		 speakerID =  '#get_spkr1id.SpeakerID#' and
		  availtodate =  '#DateFormat(Form.Schedule.Date[Counter], "m/d/yyyy")#' and
		  availfromtime = '#DateFormat(Form.Schedule.Date[Counter], "m/d/yyyy")# #TimeFormat(Form.Schedule.tt[Counter], "h:mm tt")#'
	  </cfquery>
	  
	  <cfelseif #Form.Schedule.Speaker2[Counter]# is not ''>
	  
	  <cfquery name="get_spkr2id" datasource="#application.speakerDSN#">
	select speakerid
	from Speaker	
	where 
	lastname = '#last_name2#' and
	firstname = '#first_name2#'
	</cfquery>		
	
	<cfquery name="delete_availmod2" datasource="#application.speakerDSN#">			 
	     delete from SpeakerAvailable
	     where
		 speakerID =  '#get_spkr2id.SpeakerID#' and
		 availtodate =  '#DateFormat(Form.Schedule.Date[Counter], "m/d/yyyy")#' and
		 availfromtime = '#DateFormat(Form.Schedule.Date[Counter], "m/d/yyyy")# #TimeFormat(Form.Schedule.tt[Counter], "h:mm tt")#'
	  </cfquery>
	</cfif>
  
      <cfquery name="DeleteExisting" 
        datasource="#application.speakerDSN#">
        DELETE FROM Schedule
        WHERE RowID= <cfqueryparam value="#Form.Schedule.original.RowID[Counter]#">
      </cfquery>	  
	  
	  
    <cfelseif Form.Schedule.rowstatus.action[counter] is "U">
	
	<!--- split speaker first and last name --->
	<cfif #Form.Schedule.Speaker1[Counter]# is not '' and #Form.Schedule.Speaker1[Counter]# is not 'NULL'>
	<cfset pos1 = '#find(" ",Form.Schedule.Speaker1[Counter])#'>		
	<cfset first_name1 = '#Left(Form.Schedule.Speaker1[Counter], pos1)#'>
	<cfset last_name1 = '#Mid(Form.Schedule.Speaker1[Counter], pos1, 50)#'>
	<cfelse>
	<cfset first_name1 = ''>
	<cfset last_name1 = ''>
	</cfif>
	
	<cfif #Form.Schedule.Speaker2[Counter]# is not '' and #Form.Schedule.Speaker2[Counter]# is not 'NULL'>
	<cfset pos2 = '#find(" ",Form.Schedule.Speaker2[Counter])#'>	
	<cfset first_name2 = '#Left(Form.Schedule.Speaker2[Counter], pos2)#'>	
	<cfset last_name2 = '#Mid(Form.Schedule.Speaker2[Counter], pos2, 50)#'>
	<cfelse>
	<cfset first_name2 = ''>
	<cfset last_name2 = ''>
	</cfif>
   	   
	   <!--- split mod first and last name --->	   
	<cfif #Form.Schedule.Moderator1[Counter]# is not '' and #Form.Schedule.Moderator1[Counter]# is not 'NULL'>   
	<cfset pos3 = '#find(" ",Form.Schedule.Moderator1[Counter])#'>		
	<cfset first_name3 = '#Left(Form.Schedule.Moderator1[Counter], pos3)#'>
	<cfset last_name3 = '#Mid(Form.Schedule.Moderator1[Counter], pos3, 50)#'>
	<cfelse>
	<cfset first_name3 = ''>
	<cfset last_name3 = ''>
	</cfif>
	
	<cfif #Form.Schedule.Moderator2[Counter]# is not '' and #Form.Schedule.Moderator2[Counter]# is not 'NULL'>
	<cfset pos4 = '#find(" ",Form.Schedule.Moderator2[Counter])#'>	
	<cfset first_name4 = '#Left(Form.Schedule.Moderator2[Counter], pos4)#'>
	<cfset last_name4 = '#Mid(Form.Schedule.Moderator2[Counter], pos4, 50)#'>
    <cfelse>
	<cfset first_name4 = ''>
	<cfset last_name4 = ''>
	</cfif>
	
      <cfquery name="UpdateExisting"
        datasource="#application.speakerDSN#">
        UPDATE Schedule
        SET 
		Project= <cfqueryparam value="#Form.Schedule.Project[Counter]#">,
		MeetingCode= <cfqueryparam value="#Form.Schedule.MeetingCode[Counter]#">,
		Date= <cfqueryparam value="#Form.Schedule.Date[Counter]#">,
		Time= <cfqueryparam value="#Form.Schedule.tt[Counter]#">,
		<cfif #Form.Schedule.Speaker1[Counter]# is 'NULL'>
		Speaker1FirstName= <cfqueryparam value="NULL">,
		<cfelse>
		Speaker1FirstName= '#Trim(first_name1)#',
		</cfif>
		<cfif #Form.Schedule.Speaker1[Counter]# is 'NULL'>
		Speaker1LastName= <cfqueryparam value="NULL">,
		<cfelse>
		Speaker1LastName= '#Trim(last_name1)#',
		</cfif>
		<cfif #Form.Schedule.Speaker2[Counter]# is 'NULL'>
		Speaker2FirstName= <cfqueryparam value="NULL">,
		<cfelse>
		Speaker2FirstName= '#Trim(first_name2)#',
		</cfif>
		<cfif #Form.Schedule.Speaker2[Counter]# is 'NULL'>
		Speaker2LastName= <cfqueryparam value="NULL">,
		<cfelse>
		Speaker2LastName= '#Trim(last_name2)#',
		</cfif>
		<cfif #Form.Schedule.Moderator1[Counter]# is 'NULL'>
		Moderator1FirstName= <cfqueryparam value="NULL">,
		<cfelse>
		Moderator1FirstName= '#Trim(first_name3)#',
		</cfif>
		<cfif #Form.Schedule.Moderator1[Counter]# is 'NULL'>
		Moderator1LastName= <cfqueryparam value="NULL">,
		<cfelse>
		Moderator1LastName= '#Trim(last_name3)#',
		</cfif>
		<cfif #Form.Schedule.Moderator2[Counter]# is 'NULL'>
		Moderator2LastName= <cfqueryparam value="NULL">,
		<cfelse>
		Moderator2LastName= '#Trim(last_name4)#',
		</cfif>
		<cfif #Form.Schedule.Moderator2[Counter]# is 'NULL'>
		Moderator2FirstName= <cfqueryparam value="NULL">
		<cfelse>
		Moderator2FirstName= '#Trim(first_name4)#'	
		</cfif>			
          
        WHERE RowID= <cfqueryparam value="#Form.Schedule.original.RowID[Counter]#">
        </cfquery>
					

    <cfelseif Form.Schedule.rowstatus.action[counter] is "I">
	
	<cfquery name="find_existing_meeting" datasource="#application.speakerDSN#">
	  select MeetingCode, Date, Time, RowID 
	  from Schedule
	  Where 
	  MeetingCode = <cfqueryparam value="#Form.Schedule.MeetingCode[Counter]#"> and 
	  Date = <cfqueryparam value="#Form.Schedule.Date[Counter]#"> and
	  Time = <cfqueryparam value="#Form.Schedule.tt[Counter]#">
	  </cfquery>
   
		<cfif #find_existing_meeting.recordcount# gt 0>
		
		  
	<cfquery name="DeleteExisting_Mods_Spkrs" datasource="#application.speakerDSN#">
	  delete
	  from Schedule
	  Where RowID = '#find_existing_meeting.RowID#'
	  </cfquery> 	
	  
	  </cfif>    
	  
          <!--- split speaker first and last name --->
	<cfif #Form.Schedule.Speaker1[Counter]# is not '' and #Form.Schedule.Speaker1[Counter]# is not 'NULL'>
	<cfset pos1 = '#find(" ",Form.Schedule.Speaker1[Counter])#'>		
	<cfset first_name1 = '#Left(Form.Schedule.Speaker1[Counter], pos1)#'>
	<cfset last_name1 = '#Mid(Form.Schedule.Speaker1[Counter], pos1, 50)#'>
	<cfelse>
	<cfset first_name1 = ''>
	<cfset last_name1 = ''>
	</cfif>
	
	<cfif #Form.Schedule.Speaker2[Counter]# is not '' and #Form.Schedule.Speaker2[Counter]# is not 'NULL'>
	<cfset pos2 = '#find(" ",Form.Schedule.Speaker2[Counter])#'>	
	<cfset first_name2 = '#Left(Form.Schedule.Speaker2[Counter], pos2)#'>	
	<cfset last_name2 = '#Mid(Form.Schedule.Speaker2[Counter], pos2, 50)#'>
	<cfelse>
	<cfset first_name2 = ''>
	<cfset last_name2 = ''>
	</cfif>
   	   
	   <!--- split mod first and last name --->	   
	<cfif #Form.Schedule.Moderator1[Counter]# is not '' and #Form.Schedule.Moderator1[Counter]# is not 'NULL'>   
	<cfset pos3 = '#find(" ",Form.Schedule.Moderator1[Counter])#'>		
	<cfset first_name3 = '#Left(Form.Schedule.Moderator1[Counter], pos3)#'>
	<cfset last_name3 = '#Mid(Form.Schedule.Moderator1[Counter], pos3, 50)#'>
	<cfelse>
	<cfset first_name3 = ''>
	<cfset last_name3 = ''>
	</cfif>
	
	<cfif #Form.Schedule.Moderator2[Counter]# is not '' and #Form.Schedule.Moderator2[Counter]# is not 'NULL'>
	<cfset pos4 = '#find(" ",Form.Schedule.Moderator2[Counter])#'>	
	<cfset first_name4 = '#Left(Form.Schedule.Moderator2[Counter], pos4)#'>
	<cfset last_name4 = '#Mid(Form.Schedule.Moderator2[Counter], pos4, 50)#'>
    <cfelse>
	<cfset first_name4 = ''>
	<cfset last_name4 = ''>
	</cfif>
	

        <cfquery name="InsertNew"
        datasource="#application.speakerDSN#">
        INSERT into Schedule (
		Project, 
		MeetingCode, 
		Date, 
		Time, 
		Speaker1FirstName, 
		Speaker1LastName, 
		Speaker2FirstName, 
		Speaker2LastName, 
		Moderator1FirstName, 
		Moderator1LastName, 
		Moderator2LastName, 
		Moderator2FirstName 
		)
        VALUES 
          (
		<cfqueryparam value="#Form.Schedule.Project[Counter]#">,
		<cfqueryparam value="#Form.Schedule.MeetingCode[Counter]#">,
		'#DateFormat(Form.Schedule.Date[Counter], "m/d/yyyy")#',
		'#DateFormat(Form.Schedule.Date[Counter], "m/d/yyyy")# #TimeFormat(Form.Schedule.tt[Counter], "h:mm tt")#',
		'#Trim(first_name1)#',
		'#Trim(last_name1)#',
	    '#Trim(first_name2)#',
		'#Trim(last_name2)#',
	    '#Trim(first_name3)#',
		'#Trim(last_name3)#',
		'#Trim(last_name4)#',
		'#Trim(first_name4)#'	              
			)
      </cfquery> 

    </cfif>
  </cfloop>
</cfif>

 <cflocation url="../refresh_database_grid.cfm?excel=no&grid=yes&startdate=#form.startdate#&enddate=#form.enddate#&projectfilter=#form.projectfilter#" addtoken="No"> 
 </cfoutput>