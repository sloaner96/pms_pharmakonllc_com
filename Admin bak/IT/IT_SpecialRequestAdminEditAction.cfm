<CFQUERY DATASOURCE="#application.projdsn#" NAME="insert_database_info">
	UPDATE special_request
	SET
	requested_by = '#trim(left(form.requested_by, 30))#',
	request_date = '#form.request_date#',
	request_comp_date = '#form.request_comp_date#', 
	billable = '#form.billable#',
	description ='#trim(left(form.description, 512))#',
	comments ='#trim(left(form.comments, 512))#',
	est_hours ='#trim(left(form.cost_EstHours, 18))#',
	est_dollars ='#trim(left(form.cost_EstDollars, 18))#',
	actual_hours ='#trim(left(form.cost_ActualHours, 18))#',
	actual_dollars ='#trim(left(form.cost_ActualDollars, 18))#',
	received_by ='#form.recieved_by#',
	promised_date = '#form.promised_date#',
	completed_date ='#form.completed_date#',
	received_date ='#form.received_date#'
	Where job_number = '#form.job_number#'
</CFQUERY>
<cfoutput>
<META HTTP-EQUIV="refresh" CONTENT="1; URL=IT_SpecialRequestAdmin.cfm">
</cfoutput>