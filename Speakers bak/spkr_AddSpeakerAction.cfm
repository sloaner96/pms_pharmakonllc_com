<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<cfdump var="#Session#">
<!----------------------------------------------------------------------------
	spkr_AddSpeakeraction.cfm
	queries to add new speaker to database
	
	lb070201-  Initial code.
------------------------------------------------------------------------------
--->

<!--- check for null dates --->
<CFIF parameterexists(form.consult_agreedatebox)>
    <CFSET consult_agreedate = form.consult_agreedatebox>
<CFELSE>
    <CFSET consult_agreedate = "">
</CFIF>

<CFIF parameterexists(form.w9datebox)>
   <CFSET w9date = form.w9datebox>
<CFELSE>
   <CFSET w9date = "">
</CFIF>

<CFIF parameterexists(form.cvdatebox)>
	<CFSET cvdate = form.cvdatebox>
<CFELSE>
	<CFSET cvdate = "">
</CFIF>

<!--- create a new speaker id from nextnumber table --->
<cfquery name="qCreateSpeakerID" datasource="#application.speakerDSN#">
	SELECT  seqnum as new_speaker 
	FROM   	nextnumber  
	</cfquery>
	
<cfoutput query="qCreateSpeakerID">

	<!--- set next number --->
	<cfset next_number = new_speaker + 1>
</cfoutput>
	
	<cfset commitIt = "yes">

	<CFTRANSaction action="Begin">
	   <CFTRY>  
	
	 <!--- update nextnumber table with next_number created above --->	
	 <cfquery name="qCreateNewSeqnum" datasource="#application.speakerDSN#">
	   Update nextnumber 
	   Set seqnum='#next_number#'
	 </cfquery>

 	  <cfcatch type="Database">
	    <Cftransaction action="Rollback"/>
		<CFSET CommitIt = "no">
	  </Cfcatch>
	</cftry>
	<cfif CommitIt EQ "yes">
		<cftry>  

		<!--- insert info into Speaker --->		
		<cfquery name="qInsertNewSpeaker" datasource="#application.speakerDSN#">
		 Insert into Speaker (
			   speakerid, 
			   type, 
			   lastname, 
			   firstname, 
			   middlename, 
			   ss, 
			   display, 
			   date_created, 
			   created_by, 
			   degree, 
			   sex, 
			   travel, 
			   specialty, 
			   affil, 
			   active 
			   <cfif form.active EQ 'INyes'>,date_inactive</cfif>
			   <cfif cvdate NEQ "">,cv</cfif>
			   <cfif w9date NEQ "">,w9</cfif>
			   <cfif consult_agreedate NEQ "">,consult_agree</cfif>
			   )  
		 Values(
			   <cfoutput query="qCreateSpeakerID">#new_speaker#</cfoutput>, 
			   'SPKR',
			    '#Left(form.lastname, 50)#',
				'#Left(form.firstname, 30)#',
				'#Left(Form.middlename, 3)#',
				'#Left(Form.ss, 11)#',
				'1', 
				<cfoutput>#Now()#</cfoutput>, 
				#session.UserInfo.rowid#, 
				'#Left(Form.degree, 30)#', 
				'#Left(Form.sex, 1)#', 
				'#Form.travel#', 
				'#Form.specialty#', 
				'#Left(Form.affil, 500)#', 
				'#Form.active#'
				<cfif form.active EQ 'INyes'>,#Now()#</cfif>
				<cfif cvdate NEQ "">,#CreateODBCDate(cvdate)#</cfif>
				<cfif w9date NEQ "">,#CreateODBCDate(w9date)#</cfif>
				<cfif consult_agreedate NEQ "">,#CreateODBCDate(consult_agreedate)#</cfif>
				)
		</cfquery>

 		<cfcatch Type="Database">
		   <cftransaction action="rollback"/>
		    <cfset commitIt="No">
		</cfcatch>
		
		</cftry>	
  </cfif> 
	

	 	<cfif CommitIt EQ "yes">
		<cftry>  

		<!--- insert new speakers addressess into address table --->		
		<cfquery name="qInsertNewAddress" datasource="#application.speakerDSN#">
			Insert into address (
			    speakerid, 
				add1, 
				add2,
				add3, 
				city, 
				state,
				zipcode, 
				mailtocountry, 
				type, 
				busadd_1, 
				busadd_2,
				busadd_3, 
				buscity, 
				busstate, 
				buszip, 
				buscountry 
				)  
			Values(
			    <cfoutput query="qCreateSpeakerID">#new_speaker#</cfoutput>,
				'#Left(Form.add1, 75)#',
				'#Left(Form.add2, 75)#',
				'#Left(Form.add3, 75)#',
				'#Left(Form.city, 35)#',
				'#Left(Form.state, 2)#',
				'#Left(Form.zipcode, 10)#', 
				'#Left(form.mailtocountry, 35)#',
				'SPKR',
				'#Left(Form.busadd_1, 75)#',
				'#Left(Form.busadd_2, 75)#',
				'#Left(Form.busadd_3, 75)#',
				'#Left(Form.buscity, 35)#',
				'#Left(Form.busstate, 2)#',
				'#Left(Form.buszip, 10)#', 
				'#Left(form.buscountry, 35)#'
				)
		</cfquery>
		 <cfcatch Type="Database">
		<cftransaction action="rollback"/>
		<cfset commitIt="No">
		</cfcatch>
		</cftry>	
		</cfif>

 		<cfif CommitIt EQ "yes">
		<cftry> 

<!--- if a product has been selected on the previous form, run this insert query to --->		
<cfif #parameterexists(form.client_code)#>
<!--- update new client info based on the client id from previous page. If a client was not chosen, a record will not be added --->	
<!---  <cfloop index="all_index" list="#form.client#"> 
	<cfquery name="qAddClients" datasource="#application.speakerDSN#">
	Insert into speaker_clients (speakerid, client_id, fee, type, comments)  
	Values(<cfoutput query="qCreateSpeakerID">#new_speaker#</cfoutput>,'#all_index#', '#LSParseNumber(evaluate('form.fee'& all_index))#',  'SPKR', '#evaluate('form.comments'& all_index)#')
</cfquery>
</cfloop>  --->
<cfquery name="qAddClients" datasource="#application.speakerDSN#">
	Insert into speaker_clients (speakerid, client_code, fee, type, comments)  
	Values(<cfoutput query="qCreateSpeakerID">#new_speaker#</cfoutput>, '#form.client_code#', #LSParseNumber(form.client_fee)#, 'SPKR', '#form.clientcomments#')
</cfquery>

</cfif>

 		 <cfcatch Type="Database">
		<cftransaction action="rollback"/>
		<cfset commitIt="No">
		</cfcatch>
		</cftry>
		</cfif>
 		
	
	 	<cfif CommitIt EQ "yes">
		<cftry> 
		
<!--- insert Contact information for the new speaker into Contact_info table --->		
<cfquery name="qInsertNewContact" datasource="#application.speakerDSN#">
	Insert into Contact_info (speakerid, Contact_info, type)  
	Values(<cfoutput query="qCreateSpeakerID">#new_speaker#</cfoutput>,'#Left(form.Contact_info, 500)#',
		'SPKR')
</cfquery>		
 		 <cfcatch Type="Database">
		<cftransaction action="rollback"/>
		<cfset commitIt="No">
		</cfcatch>
		</cftry>
		</cfif>

	 	<cfif CommitIt EQ "yes">
		
		<cftry> 
		<cfif #form.comment# is not "">
<!--- Insert new speaker comment into comments --->		
<cfquery name="InsertNewComment" datasource="#application.speakerDSN#">
	Insert into comments (speakerid, type, comment)  
	Values(<cfoutput query="qCreateSpeakerID">#new_speaker#</cfoutput>,'SPKR',
		'#Left(Form.comment, 250)#')
</cfquery>
		</cfif>
		 <cfcatch Type="Database">
		<cftransaction action="rollback"/>
		<cfset commitIt="No">
		</cfcatch>
		</cftry>
		</cfif>
		


	 	<cfif CommitIt EQ "yes">
		<cftry> 
		
		<!--- insert new speaker phone numbers --->
		<cfquery name="qInsertNewPhone" datasource="#application.speakerDSN#">
			Insert into phone_details (
			    speakerid, 
				type, 
				phone1, 
				phone2, 
				fax1, 
				fax2, 
				cell1, 
				cell2, 
				pager1, 
				pager2, 
				service1, 
				service2, 
				email1, 
				email2)  
			Values(
			   #qCreateSpeakerID.new_speaker#,
			   'SPKR',
			   '#Left(Form.phone1, 30)#',
			   '#Left(Form.phone2, 30)#',
			   '#Left(Form.fax1, 30)#',
			   '#Left(Form.fax2, 30)#',
			   '#Left(Form.cell1, 30)#',
			   '#Left(Form.cell2, 30)#',
			   '#Left(Form.pager1, 30)#',
			   '#Left(Form.pager2, 30)#',
			   '#Left(Form.service1, 30)#',
			   '#Left(Form.service2, 30)#', 
			   '#Left(Form.email1, 30)#', 
			   '#Left(Form.email2, 30)#' 
			   )
		</cfquery>
	
 		 <cfcatch Type="Database">
		    <cftransaction action="rollback"/>
		    <cfset commitIt="No">
		 </cfcatch>
		</cftry>
		</cfif>	


	</cftransaction> 

<!--- if all queries ran ok, go to speaker details if not, show warning --->
 <cfif commitIt EQ "yes">
		    <cflocation url="spkr_details.cfm?speakerid=#qCreateSpeakerID.new_speaker#">
		
 <cfelse>
This Speaker has not been inserted. Please Contact IT for assistance.
</cfif>  
</body>
</html>	 
	
