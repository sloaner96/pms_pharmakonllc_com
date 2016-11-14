<cfcomponent>
  
  
    <!--- Constructor --->
	<cfset init()>
	
	<!--- Initialize datasources --->
	<cfset instance.webEventsDsn = "CBARoster">
    <cfset instance.FilePath = "\\vivaldi\Projects\Other\CIReports">

	<!--- Call the Utilities Component --->
	 <CFOBJECT COMPONENT="PMS.com.Utilities"
	        NAME="Utilities">
			
			
   <!---------------------------- 
      Initialize the component 
     --------------------------->
	
   	
			
   <cffunction name="init" output="true" returnType="boolean" access="public"
				hint="Handles initialization.">
	      <cfset instance.initialized = true>
	      <cfreturn instance.initialized />
   </cffunction>
  
  <cffunction name="getDirListing" returnType="query" access="public">
    <cfdirectory 
	    action="LIST" 
		directory="#Instance.FilePath#" 
		name="GetFilesInDir" 
		filter="*.txt" sort="DATELASTMODIFIED">
    <cfreturn GetFilesInDir />
  </cffunction>
  
  
  <!--- Convert the File Into a Queryset --->
   <cffunction name="csv2Query" returnType="query" access="public">
      <cfargument name="thisFile" required="YES" type="String">
	  <cfargument name="FirstRowISHeader" required="YES" type="String">
	  <cfargument name="Qualifier" required="NO" type="String">
	  <cfargument name="Delimiter" required="NO" type="String">
	  <cfargument name="maxrows" required="NO" type="String" default="">
	  <cfargument name="StartRow" required="NO" type="String">
	 
      <cfx_text2Query
	      file="#Instance.FilePath#\#Arguments.ThisFile#"
	      firstRowIsHeader="#Arguments.FirstRowIsHeader#"
	      qualifier="#Arguments.Qualifier#"
	      delimiter="#Arguments.Delimiter#"
	      startrow="#Arguments.StartRow#"
	      rQuery="thisresults">
	  
      <cfreturn thisresults />
   </cffunction>
   
   
   <!--- Read Header INI File --->
      <!--- Check that the header is properly Formatted --->
   <cffunction name="ReadheaderINI" returnType="any" access="public">
      <cffile action="READ" file="c:\inetpub\wwwroot\pms_pharmakonllc_com\CiHeader.ini" variable="getCIHead">
	  
	  <cfreturn getCIHead/>
   </cffunction>
   
   <!--- Check that the header is properly Formatted --->
   <cffunction name="CheckHeader" returnType="Boolean" access="public">
     
   </cffunction>
   
   <cffunction name="GetDistinctMtgTypes" returnType="query" access="public">
     <cfargument name="ThisQuery" type="query" required="YES">
	 
	 <cfquery name="GetDistMtg" dbtype="query" datasource="Arguments.ThisQuery">
	   Select Distinct MeetingCode
	   From #arguments.ThisQuery#
	   Order By MeetingCode
	 </cfquery>
	 
	 <cfreturn GetDistMtg />
   </cffunction>
   
   <cffunction name="readinFile" access="public" returntype="any">
     <cfargument name="TheFile" type="string" required="YES">
	  
	 <cffile action="READ" file="#Instance.FilePath#/#Arguments.TheFile#" variable="TheReadFile">
     
	 <!--- <cfset TheNewArray = ArrayNew(2)>
	 <cfloop index="i" list="theReadFile" delimiters="#chr(13)##chr(10)#">
	    <cfloop
	 </cfloop> --->
	 
	 <cfreturn TheReadFile />
   </cffunction>
   
   
   <cffunction name="CompareData" returnType="query" access="public">
     
   </cffunction>
   
   
   <cffunction name="DeleteData" returnType="Void" access="public">
     <cfargument name="DateForward" type="date">
	 <cfargument name="MeetingCode" type="date">
	  
	  <cfquery name="DeleteCI" datasource="#Instance.DSN#">
	     Delete From CI_DB
		 Where Left(EventKey, 9) = MeetingCode
		 AND EventDate >= #DateFormat(DateForward, 'MM/DD/YYYY')#
	  </cfquery>
   </cffunction>
   
   
   <cffunction name="InsertCIData" returnType="Void" access="public">
        <cfargument name="PHID" type="numeric" required="NO">
		<cfargument name="MeetingCode" type="string" required="YES">
		<cfargument name="MeetingDate" type="Date" required="YES">
		<cfargument name="MeetingTime" type="string" required="YES">
		<cfargument name="Firstname" type="string" required="YES">
		<cfargument name="Middlename" type="string" required="NO">
		<cfargument name="Lastname" type="string" required="YES">
		<cfargument name="OfficeAddr1" type="string" required="NO">
		<cfargument name="OfficeAddr2" type="string" required="NO">
		<cfargument name="OfficeCity" type="string" required="NO">
		<cfargument name="OfficeState" type="string" required="NO">
		<cfargument name="OfficeZipcode" type="string" required="NO">
		<cfargument name="ShiptoAddr1" type="string" required="NO">
		<cfargument name="ShiptoAddr2" type="string" required="NO">
		<cfargument name="ShiptoCity" type="string" required="NO">
		<cfargument name="ShiptoState" type="string" required="NO">
		<cfargument name="ShiptoZipcode" type="string" required="NO">
		<cfargument name="Specialty" type="string" required="NO">
		<cfargument name="Salutation" type="string" required="NO">
		<cfargument name="Degree" type="string" required="NO">
		<cfargument name="CETPhone" type="string" required="NO">
		<cfargument name="OfficePhone" type="string" required="NO">
		<cfargument name="Fax" type="string" required="NO">
		<cfargument name="FAXAuthorized" type="numeric" required="NO">
		<cfargument name="EmailAddr" type="string" required="NO">
		<cfargument name="eGuideBook" type="numeric" required="NO">
		<cfargument name="eGdbkEmailAddr" type="string" required="NO">
		<cfargument name="CIStatus" type="string" required="NO">
		<cfargument name="ConfirmStatus" type="string" required="NO">
		<cfargument name="Menum" type="string" required="NO">
		<cfargument name="Screener1" type="string" required="NO">
		<cfargument name="Screener2" type="string" required="NO">
		<cfargument name="Screener3" type="string" required="NO">
		<cfargument name="Screener4" type="string" required="NO">
		<cfargument name="Screener5" type="string" required="NO">
		<cfargument name="Screener6" type="string" required="NO">
		<cfargument name="Screener7" type="string" required="NO">
		<cfargument name="Screener8" type="string" required="NO">
		<cfargument name="Screener9" type="string" required="NO">
		<cfargument name="Screener10" type="string" required="NO">
		<cfargument name="Recruit1" type="numeric" required="NO">
		<cfargument name="Recruit2" type="numeric" required="NO">
		<cfargument name="DateSet" type="date" required="NO">
		<cfargument name="Project" type="string" required="NO">
		<cfargument name="ContactID" type="numeric" required="NO">
		<cfargument name="ProspectID" type="numeric" required="NO">
		<cfargument name="EventID" type="numeric" required="NO">
		<cfargument name="User1" type="numeric" required="NO">
		<cfargument name="User2" type="string" required="NO">
		<cfargument name="User3" type="string" required="NO">
		<cfargument name="User4" type="numeric" required="NO">
		<cfargument name="User5" type="String" required="NO">
		<cfargument name="User6" type="string" required="NO">

	 <cfquery name="InsertCI" datasource="#Instance.DSN#">
	    Insert Into CI_DB(
		    phid
			EventKey
			EventDate
			EventTime
			FirstName
			MiddleName
			LastName
			OfficeAdd1
			OfficeAdd2
			OfficeCity
			OfficeState
			OfficeZip
			ShipAdd1
			ShipAdd2
			ShipCity
			ShipState
			ShipZip
			Specialty
			Salutation
			Degree
			CETPHONE
			OfficePhone
			Fax
			FaxAuthorized
			email
			eGuidebook
			eGdbkEmailAddr
			CIStatus
			ConfirmStatus
			menum
			Screener1,
			Screener2,
			Screener3,
			Screener4,
			Screener5,
			Screener6,
			Screener7,
			Screener8,
			Screener9,
			Screener10,
			rep_nom
			other_nom
			DateSet
			Project,
			ContactID,
			ProspectID,
			EventID,
			User1,
			User2,
			User3,
			User4,
			User5,
			User6
		)
		VALUES(
		    #Arguments.PHID#,
			#Arguments.MeetingCode#,
			#Arguments.MeetingDate#,
			#Arguments.MeetingTime#,
			#Arguments.Firstname#,
			#Arguments.Middlename#,
			#Arguments.Lastname#,
			#Arguments.OfficeAddr1#,
			#Arguments.OfficeAddr2#,
			#Arguments.OfficeCity#,
			#Arguments.OfficeState#,
			#Arguments.OfficeZipcode#,
			#Arguments.ShiptoAddr1#,
			#Arguments.ShiptoAddr2#,
			#Arguments.ShiptoCity#,
			#Arguments.ShiptoState#,
			#Arguments.ShiptoZipcode#,
			#Arguments.Specialty#,
			#Arguments.Salutation#,
			#Arguments.Degree#,
			#Arguments.CETPhone#,
			#Arguments.OfficePhone#,
			#Arguments.Fax#,
			#Arguments.FAXAuthorized#,
			#Arguments.EmailAddr#,
			#Arguments.eGuideBook#,
			#Arguments.eGdbkEmailAddr#,
			#Arguments.CIStatus#,
			#Arguments.ConfirmStatus#,
			#Arguments.Menum#,
			#Arguments.Screener1#,
			#Arguments.Screener2#,
			#Arguments.Screener3#,
			#Arguments.Screener4#,
			#Arguments.Screener5#,
			#Arguments.Screener6#,
			#Arguments.Screener7#,
			#Arguments.Screener8#,
			#Arguments.Screener9#,
			#Arguments.Screener10#,
			#Arguments.Recruit1#,
			#Arguments.Recruit2#,
			#Arguments.DateSet#,
			#Arguments.Project#,
			#Arguments.ContactID#,
			#Arguments.ProspectID#,
			#Arguments.EventID#,
			#Arguments.User1#,
			#Arguments.User2#,
			#Arguments.User3#,
			#Arguments.User4#,
			#Arguments.User5#,
			#Arguments.User6#
		)
	 </cfquery>
	 
   </cffunction>
   
</cfcomponent>