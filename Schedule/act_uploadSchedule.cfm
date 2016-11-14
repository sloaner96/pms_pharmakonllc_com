<!--- Set Global Variables --->
 <cfset FilePath= application.SitePath & "\uploads\Schedule">
 <!--- Validate that a file was uploaded --->
  <cfif Len(Trim(form.excelupload)) EQ 0>
    <cflocation url="dsp_globalSchedule.cfm?e=1" addtoken="NO">
  </cfif>

<!--- Upload the File --->
  <cffile action="UPLOAD" 
     filefield="form.excelupload" 
	 destination="#FilePath#" 
	 nameconflict="MAKEUNIQUE"> 
	 
<!--- Set the File name into a variable --->	 
  <!--- <cfset ScheduleFile =  FilePath & "\Schedule Week April 03_20069.xls"> --->
    <cfset ScheduleFile =  FilePath & "\" & file.serverfile>
<!--- Read the file into a query String --->
  <cfinvoke component="PMS.com.utilities" method="excel2Query" returnVariable="XLSSet">
    <cfinvokeargument name="thisFile" value="#ScheduleFile#">
	<cfinvokeargument name="StartRow" value="1">
	 <cfinvokeargument name="FirstRowISHeader" value="True">
  </cfinvoke>

<!--- Validate the File Format --->
<cfdump var="#XLSSet#">
<!--- Load the File into the database --->
<cfloop query="XLSSet">
    <cfif Len(Trim(XLSSet.Date)) GT 0>
		<cfquery name="InsertTemp" datasource="#application.projdsn#"> 
		  Insert Into ScheduleTemp(meetingCode, MeetingDate, MtgStartTime, Remarks)
		  Values('#Trim(XLSSet.MeetingCode)#', #CreateODBCDate(Trim(XLSSet.Date))#, ##)
		</cfquery>
	</cfif>
</cfloop> 
<!--- Run validations on the data --->

<!--- Throw user to a summary screen --->

