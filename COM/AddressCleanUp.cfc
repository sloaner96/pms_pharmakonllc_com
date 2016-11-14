<cfcomponent>
  <cfset instance = StructNew()>
  <cfset instance.DSN = "DBMaster">
  <cfset instance.projDSN = "PMS">
  
  <cfset Init()>
  
  <!--- Initialize the Component --->
  <cffunction name="init" returntype="void" access="Private">
     <cfreturn />
  </cffunction>
  
  <!--- /////////////////////////////
     These are the Lookup Functions
  ////////////////////////////////// --->
  
  <!--- Lookup the Physician info by Phid --->
  <cffunction name="getPhysicianInfo" returntype="Query" access="Public">
      <cfargument name="Phid" required="Yes" Type="Numeric">
	  
	  <cfquery name="GetPhidInfo" datasource="#instance.DSN#">
	    Select P.Phid, P.firstname, P.middlename, P.lastname, P.zip
		From physician P
		Where P.Phid = #Arguments.Phid#
		Order By P.Phid, P.Firstname, P.Lastname
	  </cfquery>
	  
	  <cfreturn GetPhidInfo /> 
  </cffunction>
  
   <!--- Lookup the Physician info by Phid --->
  <cffunction name="getPhysicianInfoByName" returntype="Query" access="Public">
      <cfargument name="firstname" required="Yes" Type="string">
	  <cfargument name="lastname" required="Yes" Type="string">
	  <cfargument name="zipcode" required="Yes" Type="string">
	  <cfargument name="Fax" required="NO" Type="string">
	  
	  <cfquery name="GetPhidInfobyname" datasource="#instance.DSN#">
	    Select P.Phid, P.firstname, P.middlename, P.lastname, P.zip
		From physician P
		Where firstname Like '#arguments.Firstname#%'
		AND Lastname like  '#arguments.Lastname#%'
		AND Left(Zip, 5) = '#Left(arguments.ZipCode, 5)#'
		Order By P.Phid, P.Firstname, P.Lastname
	  </cfquery>
	  
	  <cfreturn GetPhidInfobyname /> 
  </cffunction>
  <!--- Lookup the Physician Address by Phid --->
  <cffunction name="getPhysicianAddr" returntype="Query" access="Public">
      <cfargument name="Phid" required="Yes" Type="Numeric">
	  
	  <cfquery name="GetPhidAddr" datasource="#instance.DSN#">
	    Select A.address1, A.address2, A.city, A.state, A.zip, A.addressstatus
		From physicianaddress A
		Where A.Phid = #Arguments.Phid#
		Order By A.Phid, A.State, A.City
	  </cfquery>
	  
	  <cfreturn GetPhidAddr /> 
  </cffunction>
  
    <!--- Lookup the Physician ShipTo Info By Phid --->
  <cffunction name="getPhysicianShipTo" returntype="Query" access="Public">
      <cfargument name="Phid" required="Yes" Type="Numeric">
	  
	  <cfquery name="GetPhidShipto" datasource="#instance.DSN#">
	    Select S.address1 as Shipaddr1, S.address2 as ShipAddr2, S.city as ShipCity, S.state as ShipState, S.zip as shipZip, S.addressstatus as ShipaddrStatus
		From physicianshipto S
		Where S.Phid = #Arguments.Phid#
		Order By S.Phid, S.State, S.City
	  </cfquery>
	  
	  <cfreturn GetPhidShipto /> 
  </cffunction>
  
    <!--- Lookup the Physician Phone Numbers --->
  <cffunction name="getPhysicianPhone" returntype="Query" access="Public">
      <cfargument name="Phid" required="Yes" Type="Numeric">
	  
	  <cfquery name="GetPhidPhone" datasource="#instance.DSN#">
	    Select C.cetphone, C.phone1, C.phone2, C.faxno, C.emailid, C.faxauthorized, C.authorizeddate
		From physiciancontact C
		Where C.Phid = #Arguments.Phid#
		Order By C.Phid, C.Phone1, C.EmailID
	  </cfquery>
	  
	  <cfreturn GetPhidPhone /> 
  </cffunction>
  
 <!--- Lookup the States for the dropdown --->
  <cffunction name="getStates" returntype="Query" access="Public">
	  
	  <cfquery name="GetStates" datasource="#instance.ProjDSN#" cachedwithin="#CreateTimeSpan(1, 0, 0,0)#">
	    Select codevalue as state, codeDesc as state_description
		From lookup
		Where CodeGroup = 'STATES'
		Order By State
	  </cfquery>
	  
	  <cfreturn GetStates /> 
  </cffunction>
  <!--- /////////////////////////////
     These are the Update Functions
  ////////////////////////////////// --->
  
  <!--- Update Physician Addr --->
  <cffunction name="updatePhysicianInfo" returntype="string" access="Public">
      <cfargument name="Phid" required="Yes" Type="Numeric">
	  <cfargument name="Firstname" required="Yes" Type="Numeric">
	  <cfargument name="middlename" required="Yes" Type="Numeric">
	  <cfargument name="lastname" required="Yes" Type="Numeric">
	  <cfargument name="zipcode" required="Yes" Type="Numeric">
	  
	  <cfset Status = true>
	  
	  <cfquery name="UpdateInfo" datasource="#instance.DSN#">
	    Update physician
		  Set firstname = '#arguments.Firstname#',
		      middlename = '#arguments.middlename#',
			  lastname = '#arguments.lastname#', 
			  zip = '#arguments.zipcode#',
			  date_modified = #CreateODBCDateTime(now())#
		Where Phid = #Arguments.Phid# 	  
	  </cfquery>
	  
	  <cfreturn Status /> 
  </cffunction>
  
    <!--- Update Physician Shipto --->
  <cffunction name="updatePhysicianAddr" returntype="string" access="Public">
      <cfargument name="Phid" required="Yes" Type="Numeric">
	  <cfargument name="Addr1" required="Yes" Type="String">
	  <cfargument name="Addr2" required="No" Type="String">
	  <cfargument name="City" required="Yes" Type="String">
	  <cfargument name="State" required="Yes" Type="String">
	  <cfargument name="ZipCode" required="Yes" Type="String">
	  <cfargument name="Status" required="Yes" Type="Numeric">
	  
	  <cfset Status = true>
	  
	  <cfquery name="UpdateAddr" datasource="#instance.DSN#">
	   Update physicianaddress
	     Set Address1 = '#Arguments.Addr1#', 
		     Address2 = '#Arguments.Addr2#',
			 City = '#Arguments.City#', 
			 State = '#Arguments.State#', 
			 Zip = '#Arguments.ZipCode#',
			 Addressstatus = #Arguments.Status#,
		     date_modified = #CreateODBCDateTime(now())#
	   Where Phid = #Arguments.Phid# 		 
	  </cfquery>
	  
	  <cfreturn Status /> 
  </cffunction>
  
  <!--- Update Physician Shipto --->
  <cffunction name="updatePhysicianShipTo" returntype="string" access="Public">
      <cfargument name="Phid" required="Yes" Type="Numeric">
	  <cfargument name="Addr1" required="Yes" Type="String">
	  <cfargument name="Addr2" required="No" Type="String">
	  <cfargument name="City" required="Yes" Type="String">
	  <cfargument name="State" required="Yes" Type="String">
	  <cfargument name="ZipCode" required="Yes" Type="String">
	  <cfargument name="Status" required="Yes" Type="Numeric">
	  
	  <cfset Status = true>
	  
	  <cfquery name="UpdateShipto" datasource="#instance.DSN#">
	   Update physicianshipto
	     Set Address1 = '#Arguments.Addr1#', 
		     Address2 = '#Arguments.Addr2#',
			 City = '#Arguments.City#', 
			 State = '#Arguments.State#', 
			 Zip = '#Arguments.ZipCode#',
			 Addressstatus = #Arguments.Status#,
		     date_modified = #CreateODBCDateTime(now())#
	   Where Phid = #Arguments.Phid# 		 
	  </cfquery>
	  
	  <cfreturn Status /> 
  </cffunction>
  
    <!--- Update Physician Addr --->
  <cffunction name="updatePhysicianPhone" returntype="Query" access="Public">
      <cfargument name="Phid" required="Yes" Type="Numeric">
	  <cfargument name="CETPhone" required="Yes" Type="string">
	  <cfargument name="Phone1" required="No" Type="string">
	  <cfargument name="Phone2" required="No" Type="string">
	  <cfargument name="faxNo" required="No" Type="string">
	  <cfargument name="Email" required="No" Type="string">
	  
	  <cfquery name="GetPhidAddr" datasource="#instance.DSN#">
	    Update physiciancontact
		  Set cetphone = '#Arguments.CETPhone#',
		      phone1 = '#Arguments.Phone1#',
			  phone2 = '#Arguments.Phone2#',
			  faxno = '#Arguments.faxno#',
			  emailid = '#Arguments.email#',
			  date_modified = #CreateODBCDateTime(now())#
		Where Phid = #Arguments.Phid# 
	  </cfquery>
	  
	  <cfreturn GetPhidAddr /> 
  </cffunction>
  
      <!--- Update Physician Fax --->
  <cffunction name="updatePhysicianFaxEmail" returntype="Void" access="Public">
      <cfargument name="Phid" required="Yes" Type="Numeric">
	  <cfargument name="faxNo" required="No" Type="string">
	  <cfargument name="Email" required="No" Type="string">
	  <cfargument name="FaxStatus" required="No" Type="string">
	  
	  <cfquery name="GetPhidAddr" datasource="#instance.DSN#">
	    Update physiciancontact
		  Set date_modified = #CreateODBCDateTime(now())#,
		      <cfif IsDefined("arguments.FaxNo")>
			  faxno = '#Arguments.faxNo#',
		      faxauthorized = #Arguments.FaxStatus#,
			  authorizeddate = #CreateODBCDateTime(now())#
			  </cfif>
		
		Where Phid = #Arguments.Phid# 
	  </cfquery>

  </cffunction>
</cfcomponent>