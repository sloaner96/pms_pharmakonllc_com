<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<!----------------------------------------------------------------------------
	venu_AddVenueAction.cfm
	queries to add new venue to database
	
	lb070201-  Initial code.
------------------------------------------------------------------------------
--->

<html>
<head>
	<title>Add Venue Action</title>
	
</head>


<body>

<!--- create a new venue id from nextnumber table --->
<cfquery name="qCreatevenueID" datasource="#application.speakerDSN#">
	SELECT  seqnum as new_venue 
	FROM   	nextnumber  
	</cfquery>
	
<cfoutput query="qCreatevenueID">

<!--- set next number --->
<cfset next_number = #new_venue# + 1></cfoutput>
	
	 <cfset commitIt = "yes">

	<CFTRANSACTION Action="Begin">
	<CFTRY> 
	
<!--- update nextnumber table with next_number created above --->	
<cfquery name="qCreateNewSeqnum" datasource="#application.speakerDSN#">
	Update nextnumber 
	Set seqnum='#next_number#'
</cfquery>

 		<cfcatch type="Database">
		<Cftransaction Action="Rollback"/>
		<CFSET CommitIt = "no">
		</Cfcatch>
		</cftry>
		<cfif CommitIt EQ "yes">
		<cftry> 

<!--- insert info into venues --->		
<cfquery name="qInsertNewvenue" datasource="#application.speakerDSN#">
	Insert into venues (venue_id, venue_type, venue_name, tax_id, display, date_created, created_by, active <cfif form.active EQ 'INACT'>,date_inactive</cfif>)  
	Values(<cfoutput query="qCreatevenueID">#new_venue#</cfoutput>, '#Left(form.venue_type, 5)#', '#Left(form.venue_name, 50)#', '#Left(Form.tax_id, 11)#',
		'1', <cfoutput>#Now()#</cfoutput>, #session.userinfo.rowid#, '#Form.active#'<cfif form.active EQ 'INACT'>,#Now()#</cfif>)
</cfquery>

 		<cfcatch Type="Database">
		<cftransaction action="rollback"/>
		<cfset commitIt="No">
		</cfcatch>
		</cftry>	
		</cfif> 
	

	 	<cfif CommitIt EQ "yes">
		<cftry> 

<!--- insert new venues addressess into address table --->		
<cfquery name="qInsertNewAddress" datasource="#application.speakerDSN#">
	Insert into address (owner_id, mailtoadd_1, mailtoadd_2,
		mailtoadd_3, mailtocity, mailtostate, mailtozip, mailtocountry, owner_type, busadd_1, busadd_2,
		busadd_3, buscity, busstate, buszip, buscountry )  
	Values(<cfoutput query="qCreatevenueID">#new_venue#</cfoutput>,
		'#Left(Form.mailtoadd_1, 75)#','#Left(Form.mailtoadd_2, 75)#','#Left(Form.mailtoadd_3, 75)#','#Left(Form.mailtocity, 35)#',
		'#Left(Form.mailtostate, 2)#','#Left(Form.mailtozip, 10)#', '#Left(Form.mailtocountry, 35)#', 'VENU', '#Left(Form.busadd_1, 75)#','#Left(Form.busadd_2, 75)#','#Left(Form.busadd_3, 75)#','#Left(Form.buscity, 35)#',
		'#Left(Form.busstate, 2)#','#Left(Form.buszip, 10)#', '#Left(Form.buscountry, 35)#')
</cfquery>
		<cfcatch Type="Database">
		<cftransaction action="rollback"/>
		<cfset commitIt="No">
		</cfcatch>
		</cftry>	
		</cfif>
 		
	
	 	<cfif CommitIt EQ "yes">
		<cftry>
		
<!--- insert contact information for the new venue into contact_info table --->		
<cfquery name="qInsertNewContact" datasource="#application.speakerDSN#">
	Insert into contact_info (owner_id, contact_info, owner_type)  
	Values(<cfoutput query="qCreatevenueID">#new_venue#</cfoutput>,'#Left(form.contact_info, 500)#',
		'VENU')
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
<!--- Insert new venue comment into comments --->		
<cfquery name="InsertNewComment" datasource="#application.speakerDSN#">
	Insert into comments (owner_id, owner_type, comment)  
	Values(<cfoutput query="qCreatevenueID">#new_venue#</cfoutput>,'VENU',
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
		
<!--- insert new venue phone numbers --->
<cfquery name="qInsertNewPhone" datasource="#application.speakerDSN#">
	Insert into phone_details (owner_id, owner_type, 
		phone1, phone2, fax1, fax2, cell1, cell2, pager1, pager2, service1, service2, email1, email2)  
	Values(<cfoutput query="qCreatevenueID">#new_venue#</cfoutput>,'VENU',
		 '#Left(Form.phone1, 30)#', '#Left(Form.phone2, 30)#', '#Left(Form.fax1, 30)#', '#Left(Form.fax2, 30)#', '#Left(Form.cell1, 30)#', '#Left(Form.cell2, 30)#', '#Left(Form.pager1, 30)#', '#Left(Form.pager2, 30)#', '#Left(Form.service1, 30)#', '#Left(Form.service2, 30)#', '#Left(Form.email1, 30)#', '#Left(Form.email2, 30)#' )
</cfquery>
	
 		<cfcatch Type="Database">
		<cftransaction action="rollback"/>
		<cfset commitIt="No">
		</cfcatch>
		</cftry>
		</cfif>	


		</cftransaction>

<!--- if all queries ran ok, go to venue details if not, show warning --->
<cfif commitIt EQ "yes">
<cfoutput query="qCreatevenueID">
<cflocation url="venu_details.cfm?venue_id=#new_venue#">
</cfoutput>
 <cfelse>
This Venue has not been inserted. Please contact IT for assistance.
</cfif> 
</body>
</html>	 
	
