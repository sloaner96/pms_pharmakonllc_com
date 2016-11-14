<cfoutput>
<cfset date = DateFormat(now(), "mm/dd/yyyy")>
<cfset time = timeFormat(now(), "hh:mm:tt")>
<cfset update_log = '#date# #time#'>

 <cfquery name="get_id" datasource="#application.speakerDSN#"> 
SELECT MAX(speakerid) as "speakerid"
FROM Speaker
</cfquery>   

<cfset new_speakerid = #get_id.speakerid#+1> 

<cfquery name="insert_spker" datasource="#application.speakerDSN#">
	      Insert Into Speaker(  
		        speakerid, 
				type,
                active,
				degree,
				specialty,
			    firstname,
			    lastname, 
				middlename,				
				travel,
				sex, 				 
				affil,
				taxid, 
				taxidtype,
				cv,
				w9,
				updated, 
				updatedby,
				consultagree
	    ) 		
			VALUES
			(
'#new_speakerid#',
'MOD',
'#form.active#',
'#trim(form.degree)#',
'#trim(form.specialty)#',
'#trim(form.firstname)#',
'#trim(form.lastname)#', 
'#trim(form.middlename)#',
'#trim(form.travel)#',
'#trim(form.sex)#', 		
'#trim(form.affil)#',
<cfif #form.tin# is not ''>
'#trim(form.tin)#', 
'TIN',
<cfelse>
'#trim(form.ss)#',
'ss',
</cfif>
'#trim(form.cv)#',
'#trim(form.w9)#',
'#update_log#', 
'#session.user#',
'#trim(form.consult_agree)#'
			)
	  </cfquery> 

	  
	 <cfquery name="insert_spker" datasource="#application.speakerDSN#">
	      Insert Into SpeakerAddress
		        ( 
		        speakerid,  
                address1,
				address2,
				address3, 
				city, 
				state,
				zipcode, 
				country,
				same, 
				shipaddress1, 
				shipaddress2,
				shipaddress3, 
				shipcity, 
				shipstate, 
				shipzipcode, 
				shipcountry, 
				phone1,
				phone2,
				fax1,
				fax2,
				pager,
				cell,
				email1,
				email2
				) 		
			VALUES
		  (
'#new_speakerid#',
'#trim(form.address1)#',
'#trim(form.address2)#',
'#trim(form.address3)#', 
'#trim(form.city)#', 
'#trim(form.state)#',
'#trim(form.zipcode)#', 
'#trim(form.mailtocountry)#', 
<cfif IsDefined("FORM.shipsameaddress")>
'1',
'#trim(form.address1)#',
'#trim(form.address2)#',
'#trim(form.address3)#', 
'#trim(form.city)#', 
'#trim(form.state)#',
'#trim(form.zipcode)#', 
'#trim(form.mailtocountry)#',
<cfelse>
'0',
'#trim(form.shipaddress1)#', 
'#trim(form.shipaddress2)#',
'#trim(form.shipaddress3)#', 
'#trim(form.shipcity)#', 
'#trim(form.shipstate)#', 
'#trim(form.shipzipcode)#', 
'#trim(form.shiptocountry)#',
</cfif> 
'#trim(form.phone1)#',
'#trim(form.phone2)#',
'#trim(form.fax1)#',
'#trim(form.fax2)#',
'#trim(form.pager)#',
'#trim(form.cell)#',
'#trim(form.email1)#',
'#trim(form.email2)#'    
		  )
	  </cfquery> 
	

<cflocation url="mod_edit.cfm?speakerid=#new_speakerid#" addtoken="No">
</cfoutput> 

