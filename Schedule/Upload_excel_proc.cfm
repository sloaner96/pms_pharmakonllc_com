<html>
<head> <title>Upload File</title> </head>
<body>
<h2>Upload File</h2>
<cfoutput>
<cfif isdefined("Form.Submit") 
    and trim(form.FileName) neq "">
    <cftry>
        <!---  
          Upload the file to a folder on the webserver and 
          outside the web root.
        --->
<cffile action="upload"
		destination="c:\inetpub\wwwroot\pms_PharmakonLLC_Com\Uploads\Schedule"
		nameConflict="overwrite"
		fileField="Form.FileName"
		accept="application/octet-stream, application/vnd.ms-excel">

uploaded #cffile.ClientFileName#.#cffile.ClientFileExt#
			successfully to #cffile.ServerDirectory#.


            <!---  
              The file is on the web server now. Read it as a binary
              and put the result in the ColdFusion variable file_blob
            --->
           <!---  <cffile 
                action = "readbinary" 
                file = "c:\inetpub\wwwroot\pms_PharmakonLLC_Com\Uploads\Schedule\#cffile.serverFile#" 
                variable="file_blob"> --->


            <!---  
              Insert the ColdFusion variable file_blob
              into the table, making sure to select
              cf_sql_blob as the sql type.
            --->
	
	
<!--- 	<cfquery name="test" datasource="dynamicMDB">
   SELECT *
   FROM [Schedule_Blank$]

   IN 'c:\inetpub\wwwroot\pms_PharmakonLLC_Com\Uploads\Schedule\Schedule.xls'
</cfquery> --->

	
	<cfquery name="test" datasource="dynamicXLS2">
   SELECT *
   FROM [Schedule_Blank.xls$]
   
</cfquery> 
	
	
	
	
	
	
	
	<!--- 		<cfquery name="test" datasource="dynamicXLS">
   SELECT project
   FROM [Schedule_Blank.xls$]
   IN 'c:\inetpub\wwwroot\pms_PharmakonLLC_Com\Uploads\Schedule\#cffile.serverFile#' 'EXCEL 5.0;'
</cfquery> --->


<!--- <cfoutput query="test">
   #test.Name#
</cfoutput> --->















			
					
           <!---  <cfquery name="q" datasource="#application.projdsn#"> 
			   insert into ScheduleMaster (
	  Project,
	  Meeting Code,
	  Meeting Status,
	  Date,
	  Time,
	  Speakers,
	  Moderators,
	  Speaker/Listen In Number,
	  Participant Dial In Number,
	  Meeting Notes
				)
                values (
				
                    <cfqueryparam 
                        value="#file_blob#" 
                        cfsqltype="cf_sql_blob">
                )
            </cfquery>  --->

			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
           		   
		   
		    <!---  
              No  need to keep the file on the webserver
              because it was just stored in the database. So,
              delete it from the folder.
            --->
            <!--- <cffile 
                action="delete" 
                file="c:\inetpub\wwwroot\pms_PharmakonLLC_Com\Uploads\Schedule\#cffile.serverFile#">  --->                

            File successfully saved.

    <cfcatch type="application">
        You've got an error!        
    </cfcatch>
    </cftry>
</cfif>


</cfoutput>

</body>
</html>
