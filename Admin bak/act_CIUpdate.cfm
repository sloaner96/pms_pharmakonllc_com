<cfflush interval="50">
<cfinclude template="#Application.tagpath#/includes/libraries/CleanString.cfm">
 <!-- Initialize the component -->
  <CFOBJECT COMPONENT="pms.com.webEvents"
	        NAME="webevents">
<cfset WebConfig = 	webEvents.GetConfig(form.ProductCode, form.AppName)>	
<cfset Destination = "#Application.sitepath#\Uploads\">
<cfset conflict = "MAKEUNIQUE">
	
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Rep Update Program" showCalendar="0"><br>          
 <cfoutput>
  <cfif Len(Trim(form.repfile)) GT 0>
    Uploading File......<br>
	<cffile 
	      action="UPLOAD" 
	      filefield="form.repFile" 
		  destination="#destination#"
		  nameconflict="MAKEUNIQUE"> 
		 	 
    <cfset UploadedFile = "#Application.sitepath#\Uploads\#File.ServerFile#">
   	
	<cfif FileExists("#UploadedFile#")> 
		<cfif Right(UploadedFile, 3) EQ "xls"> 
		    Reading File .........<br>
			<!--- <cfset excelQuery = webevents.excel2Query(file=UploadedFile, firstRowIsHeader=true)> --->
			<cfinvoke component="pms.com.webevents" method="excel2Query" returnvariable="ExcelQuery">
			  <cfinvokeargument name="thisfile" value="#UploadedFile#">
			  <cfinvokeargument name="firstRowIsHeader" value="true">
			</cfinvoke>
			
			<cfif ExcelQuery.recordcount GT 0> 
					<strong>#ExcelQuery.recordcount# Records in this file</strong><br>    
					Loading Data...<br> 
					Updating Record.......<br>
                   <cfswitch expression="#form.AppName#">
				      <cfcase value="CI">
					      <cfset LoadTmpTable = webEvents.CILoad(form.productcode, excelQuery)> 
						  
						  <cfdump var="#ExcelQuery#">
						  <cfif NOT LoadTmpTable>
						    <cfdump var="#session#">
							<cfset StructClear(Session.Error)>
						  <cfelse>
						     Committed Successfully	
						  </cfif>
						  <cfabort>
						  <!--- <cfset RunProcedure = webEvents.RunProc(webConfig.StoredProc)>  --->
					  </cfcase>
					  <cfcase value="REG">
					      <cfset LoadTmpTable = webEvents.registerLoad(excelQuery)>
					  </cfcase>
					  <cfcase value="TI">
					      <cfset LoadTmpTable = webEvents.timeLoad(excelQuery)>
					  </cfcase>
					  <cfcase value="PO">
					      <cfset LoadTmpTable = webEvents.pollingLoad(excelQuery)>
					  </cfcase>
					  <cfcase value="QU">
					      <cfset LoadTmpTable = webEvents.questionsLoad(excelQuery)>
					  </cfcase>
					  <cfcase value="SU">
					      <cfset LoadTmpTable = webEvents.surveyLoad(excelQuery)>
					  </cfcase>
				   </cfswitch> 
			       
	        </cfif>
		<cfelseif Right(UploadedFile, 3) EQ "csv">
		   		
		<cfelse>
		    File Type Not Supported!<BR>
		</cfif>   
	<cfset ZipFile = "#Application.sitepath#/Uploads/Processed/ProcessedCI_#DateFormat(now(), 'mmddyyyy')#_#RandRange(1,1000)#.zip">	 
			
	Zipping Up File to "#ReplaceNocase(ZipFile, '#Application.sitepath#/Uploads/Processed/', '', 'ALL')#"<br>
		<cfx_zipman 
		     ACTION="add" 
		     ZIPFILE="#ZipFile#" 
		     INPUT_FILES="#UploadedFile#"> 
	   <cffile action="delete" file="#UploadedFile#">	
	 File Processing Complete...  
   <cfelse>
     The file you attempted to upload could not be found. Please go back and re-attach a file.
   </cfif>	    	
 <cfelse>
   You did not include a file to upload, or the file does not exist, Please go back and re-attach a file.
 </cfif>	
 
 <br><br><strong><a href="dsp_CIUpdate.cfm">Click Here</a> to go back</strong>    
</cfoutput>			 
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">  
