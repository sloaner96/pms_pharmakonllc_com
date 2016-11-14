	<!---
	----------------------------------------------------------------------------------------
	Filename: error_db_abort.cfm
	This include file is used within a cfcatch statement to alert the user about an error
	that occurred during a cfquery operation.  Processing will stop once this statement
	is envoked.
	
	04092004 - Ben - initial code.
	----------------------------------------------------------------------------------------
	--->
<p>
<font  face="Verdana, Arial, Helvetica, sans-serif" color="##990000">
<h4>An error was encountered while performing the previous function!</h4>	
</font>
<font face="Verdana, Arial, Helvetica, sans-serif"> 
Please click the Refresh button on your browser to retry this function<br>
or click the Back button to re-submit your request.</font>
<font face="Verdana, Arial, Helvetica, sans-serif" size="-1">
<br>If the problem persists, please inform the System Administrator</font> 
</p>
<cfabort>
