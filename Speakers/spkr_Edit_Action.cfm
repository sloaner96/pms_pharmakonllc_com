<cfset date = DateFormat(now(), "mm/dd/yyyy")>
<cfset time = timeFormat(now(), "hh:mm:tt")>
<cfset update_log = '#date# #time#'>
		
		
		<cfquery name="updatespeaker" datasource="#application.speakerDSN#">
			Update Speaker 
			Set 
			    active = '#form.active#',
				degree = '#trim(form.degree)#',
				specialty = '#trim(form.specialty)#',
			    firstname = '#trim(form.firstname)#',
			    lastname = '#trim(form.lastname)#', 
				middlename	= '#trim(form.middlename)#',				
				travel	= '#trim(form.travel)#',
				sex	= '#trim(form.sex)#', 				 
				affil = '#trim(form.affil)#',
				<cfif form.taxidtype is 'TIN'> 
				taxid = '#trim(form.tin)#', 
				<cfelseif form.taxidtype is 'SS'>
				taxid = '#trim(form.ss)#',
				</cfif>
				cv = '#trim(form.cv)#',
				w9 = '#trim(form.w9)#',
				updated	= 'update_log', 
				updatedby = '#session.user#',
				consultagree = '#trim(form.consult_agree)#'
				
			    Where speakerid = '#form.speakerid#' 
		</cfquery>

				<cfquery name="updatespeakeradd" datasource="#application.speakerDSN#">
			  Update SpeakerAddress 
			  Set 
	            address1 = '#trim(form.address1)#',
				address2 = '#trim(form.address2)#',
				address3 = '#trim(form.address3)#', 
				city = '#trim(form.city)#', 
				state = '#trim(form.state)#',
				zipcode = '#trim(form.zipcode)#', 
				country = '#trim(form.mailtocountry)#', 
				shipaddress1 = '#trim(form.shipaddress1)#', 
				shipaddress2 = '#trim(form.shipaddress2)#',
				shipaddress3 = '#trim(form.shipaddress3)#', 
				shipcity = '#trim(form.shipcity)#', 
				shipstate = '#trim(form.shipstate)#', 
				shipzipcode = '#trim(form.shipzipcode)#', 
				shipcountry = '#trim(form.shiptocountry)#', 
				phone1 = '#trim(form.phone1)#',
				phone2 = '#trim(form.phone2)#',
				fax1 = '#trim(form.fax1)#',
				fax2 = '#trim(form.fax2)#',
				pager = '#trim(form.pager)#',
				cell = '#trim(form.cell)#',
				email1 = '#trim(form.email1)#',
				email2 = '#trim(form.email2)#'
				
				Where speakerid = '#form.speakerid#'
		</cfquery>

<cfoutput> 
<cflocation url="spkr_edit.cfm?speakerid=#form.speakerid#" addtoken="No">
</cfoutput> 

