<!--- Include needed libraries --->
  <cfinclude template="/testPMS/includes/libraries/listcompare.cfm">
<!--- Initialize the Component and set into a variable--->
<cfobject name="DailyCI" component="pms.com.DailyCI">

Getting Files from Directory...<br>
<!--- Get the files is the directory and set them in a queryset to be looped over --->
<cfset getFiles = DailyCI.getDirListing()>

<cfdump var="#getFiles#">
<cfoutput>
Got #getFiles.RecordCount# Files in Directory 
<!--- Loop over the files --->
Looping over #getFiles.NAME#
		<cfloop query="getFiles">
		
		  <!--- Read the File into a queryset --->
		     
			 <cfset thisFile = DailyCI.readinFile(getFiles.NAME)> 
			
			
		   <cfset FileHeader = listGetAt(ThisFile, 1, "#chr(13)##chr(10)#")>

		  <!--- Validate the header and that this is a correctly formatted File --->
			<cfset Fileheader = replaceNoCase(FileHeader, '"', '', 'ALL')>
			
			<cfset CIHeader = DailyCI.ReadheaderINI()>
			
			<cfif ListLen(Fileheader) EQ ListLen(CIHeader)></cfif>
			  
			  <strong>#ListCompare(CIHeader, FileHeader)#</strong>
			
			
			<cfabort>

		  <!--- Get the Distinct Meeting Codes our of the file --->
		  
		  
		  <!--- Delete Everything going forward --->
		  
		  
		  <!--- Repopulate with the new data --->
			<!--- <cfinvoke component="pms.com.DailyCI" method="InsertCIData">
					<cfargument name="PHID" value="">
					<cfargument name="MeetingCode" value="">
					<cfargument name="MeetingDate" value="">
					<cfargument name="MeetingTime" value="">
					<cfargument name="Firstname" value="">
					<cfargument name="Middlename" value="">
					<cfargument name="Lastname"  value="">
					<cfargument name="OfficeAddr1" value="">
					<cfargument name="OfficeAddr2" value="">
					<cfargument name="OfficeCity" value="">
					<cfargument name="OfficeState" value="">
					<cfargument name="OfficeZipcode" value="">
					<cfargument name="ShiptoAddr1" value="">
					<cfargument name="ShiptoAddr2" value="">
					<cfargument name="ShiptoCity" value="">
					<cfargument name="ShiptoState" value="">
					<cfargument name="ShiptoZipcode" value="">
					<cfargument name="Specialty" value="">
					<cfargument name="Salutation" value="">
					<cfargument name="Degree" value="">
					<cfargument name="CETPhone" value="">
					<cfargument name="OfficePhone" value="">
					<cfargument name="Fax" value="">
					<cfargument name="FAXAuthorized" value="">
					<cfargument name="EmailAddr" value="">
					<cfargument name="eGuideBook" value="">
					<cfargument name="eGdbkEmailAddr" value="">
					<cfargument name="CIStatus" value="">
					<cfargument name="ConfirmStatus" value="">
					<cfargument name="Menum" value="">
					<cfargument name="Screener1"  value="">
					<cfargument name="Screener2" value="">
					<cfargument name="Screener3" value="">
					<cfargument name="Screener4" value="">
					<cfargument name="Screener5" value="">
					<cfargument name="Screener6" value="">
					<cfargument name="Screener7" value="">
					<cfargument name="Screener8" value="">
					<cfargument name="Screener9" value="">
					<cfargument name="Screener10" value="">
					<cfargument name="Recruit1" value="">
					<cfargument name="Recruit2" value="">
					<cfargument name="DateSet" value="">
					<cfargument name="Project" value="">
					<cfargument name="ContactID" value="">
					<cfargument name="ProspectID" value="">
					<cfargument name="EventID" value="">
					<cfargument name="User1" value="">
					<cfargument name="User2" value="">
					<cfargument name="User3" value="">
					<cfargument name="User4" value="">
					<cfargument name="User5" value="">
					<cfargument name="User6" value="">
			</cfinvoke> --->
		
		</cfloop>
</cfoutput>