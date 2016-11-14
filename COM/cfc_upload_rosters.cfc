<!----------------------------
cfc_upload_rosters.cfc

This component will upload the data from a txt file to the database.  Functions are broken out to 
handle very specific tasks.

11/22/02 - Matt Eaves - Initial Code
12/23/02 - Matt Eaves - Added TrimFields() Function.
1/20/03  - Matt Eaves - Added ability to automatically detect TAB delimited and respond accordingly.
----------------------------->

<cfcomponent hint="Uploads data from a .txt file and inserts it into the database.">
	<!------------------------------------------
	New Error Detection and output 
	IN CFSCRIPT - TS 9-24-03
	------------------------------------------->
	<cfscript>
	
		// 	INITIALIZE ERROR_DEFINITIONS: 
		//	buildErrorDefArray();
		//	ADD a ERROR TO THE ARRAY:  
		//	addToErrorArray(recordNumber,errorNumber);
		// 	DISPLAY ERROR ARRAY :   
		//	viewErrors();	
				
		aError = arrayNew(1);
		aErrorDef = arrayNew(2);
				
		function buildErrorDefArray()
		{
		// [x][1] =  Error Number
		// [x][2] =  Severity ( 0=nonFatal or 1 = fatal )
		// [x][3] =  Error Message
		// [x][4] =  Function Error Occurs in
		// [x][5] =  HINTS On How To FIX  // Maybe empty for a majority of
		
		aErrorDef[1][1] = "1";
		aErrorDef[1][2] = "1";
		aErrorDef[1][3] = "MeetingCode field was never located in header columns.";
		aErrorDef[1][4] = "CheckMeetingCode()";
		aErrorDef[1][5] = ""; // HOW TO FIX 
		aErrorDef[2][1] = "2";
		aErrorDef[2][2] = "1";
		aErrorDef[2][3] = "Decile was never located in header columns.";
		aErrorDef[2][4] = "CheckDecile()";
		aErrorDef[2][5] = ""; // HOW TO FIX 
		aErrorDef[3][1] = "3";
		aErrorDef[3][2] = "1";
		aErrorDef[3][3] = "Columns are misaligned. There is a problem with the way the component parsed the text file. "; //Data in place of date: #DateValue#
		aErrorDef[3][4] = "ConvertDate()";
		aErrorDef[3][5] = ""; // HOW TO FIX 
		aErrorDef[4][1] = "4";
		aErrorDef[4][2] = "1";
		aErrorDef[4][3] = "APPTDATE field was never located in header columns.";
		aErrorDef[4][4] = "ConvertDate()";
		aErrorDef[4][5] = ""; // HOW TO FIX 
		aErrorDef[5][1] = "5";
		aErrorDef[5][2] = "1";
		aErrorDef[5][3] = "APPTTIME field was never located in header columns.";
		aErrorDef[5][4] = "ConvertTime()";
		aErrorDef[5][5] = ""; // HOW TO FIX 
		aErrorDef[6][1] = "6";
		aErrorDef[6][2] = "0";
		aErrorDef[6][3] = "Time field has string GT or LT 7 charaters.";
		aErrorDef[6][4] = "ConvertTime()";
		aErrorDef[6][5] = ""; // HOW TO FIX 
		aErrorDef[7][1] = "7";
		aErrorDef[7][2] = "1";
		aErrorDef[7][3] = "Last Name field was never located in header columns.";
		aErrorDef[7][4] = "CheckName()";
		aErrorDef[7][5] = ""; // HOW TO FIX 
		aErrorDef[8][1] = "8";
		aErrorDef[8][2] = "1";
		aErrorDef[8][3] = "First Name field was never located in header columns.";
		aErrorDef[8][4] = "CheckName()";
		aErrorDef[8][5] = ""; // HOW TO FIX 
		aErrorDef[9][1] = "9";
		aErrorDef[9][2] = "0";
		aErrorDef[9][3] = "Last Name field is null.";
		aErrorDef[9][4] = "CheckName()";
		aErrorDef[9][5] = ""; // HOW TO FIX 
		aErrorDef[10][1] = "10";
		aErrorDef[10][2] = "0";
		aErrorDef[10][3] = "First Name field is null.";
		aErrorDef[10][4] = "CheckName()";
		aErrorDef[10][5] = ""; // HOW TO FIX 
		aErrorDef[11][1] = "11";
		aErrorDef[11][2] = "1";
		aErrorDef[11][3] = "Office_Phone field was never located in header columns.";
		aErrorDef[11][4] = "CheckPhone()";
		aErrorDef[11][5] = ""; // HOW TO FIX 
		aErrorDef[12][1] = "12";
		aErrorDef[12][2] = "1";
		aErrorDef[12][3] = "CET_Phone field was never located in header columns.";
		aErrorDef[12][4] = "CheckPhone()";
		aErrorDef[12][5] = ""; // HOW TO FIX 
		aErrorDef[13][1] = "13";
		aErrorDef[13][2] = "0";
		aErrorDef[13][3] = "Office_Phone field is null.";
		aErrorDef[13][4] = "CheckPhone()";
		aErrorDef[13][5] = ""; // HOW TO FIX 
		aErrorDef[14][1] = "14";
		aErrorDef[14][2] = "0";
		aErrorDef[14][3] = "CET_Phone field is null.";
		aErrorDef[14][4] = "CheckPhone()";
		aErrorDef[14][5] = ""; // HOW TO FIX 
		aErrorDef[15][1] = "15";
		aErrorDef[15][2] = "1";
		aErrorDef[15][3] = "OFFICE_ADDR1 field was never located in header columns.";
		aErrorDef[15][4] = "CheckAddress()";
		aErrorDef[15][5] = ""; // HOW TO FIX 
		aErrorDef[16][1] = "16";
		aErrorDef[16][2] = "1";
		aErrorDef[16][3] = "SHIPTO_ADDR1 field was never located in header columns.";
		aErrorDef[16][4] = "CheckAddress()";
		aErrorDef[16][5] = ""; // HOW TO FIX 
		aErrorDef[17][1] = "17";
		aErrorDef[17][2] = "0";
		aErrorDef[17][3] = "Neither a home or office address is provided.";
		aErrorDef[17][4] = "CheckAddress()";
		aErrorDef[17][5] = ""; // HOW TO FIX 
		aErrorDef[18][1] = "18";
		aErrorDef[18][2] = "1";
		aErrorDef[18][3] = "Office State field was never located in header columns.";
		aErrorDef[18][4] = "CreateKeyField()";
		aErrorDef[18][5] = ""; // HOW TO FIX 
		aErrorDef[19][1] = "19";
		aErrorDef[19][2] = "1";
		aErrorDef[19][3] = "Last Name field was never located in header columns.";
		aErrorDef[19][4] = "CreateKeyField()";
		aErrorDef[19][5] = ""; // HOW TO FIX 
		aErrorDef[20][1] = "20";
		aErrorDef[20][2] = "1";
		aErrorDef[20][3] = "First Name field was never located in header columns.";
		aErrorDef[20][4] = "CreateKeyField()";
		aErrorDef[20][5] = ""; // HOW TO FIX 
		aErrorDef[21][1] = "21";
		aErrorDef[21][2] = "1";
		aErrorDef[21][3] = "No Match on Meeting Code and/or Date. "; //Meeting:  #MeetingCodeValue# ";
		aErrorDef[21][4] = "CheckMeetingCode_AppendPIWInfo()";
		aErrorDef[21][5] = "Check the Meeting Code as well as the date to see if they match. There could be a problem with any of these things"; // HOW TO FIX 
		aErrorDef[22][1] = "22";
		aErrorDef[22][2] = "0";
		aErrorDef[22][3] = "Conference Company could not be located. "; //Meeting: #sMeetingCode# ";
		aErrorDef[22][4] = "CheckMeetingCode_AppendPIWInfo()";
		aErrorDef[22][5] = ""; // HOW TO FIX 
		aErrorDef[23][1] = "23";
		aErrorDef[23][2] = "0";
		aErrorDef[23][3] = "Honoraria Type could not be located. "; //#sMeetingCode# ";
		aErrorDef[23][4] = "CheckMeetingCode_AppendPIWInfo()";
		aErrorDef[23][5] = ""; // HOW TO FIX 
		
		aErrorDef[24][1] = "24";
		aErrorDef[24][2] = "0";
		aErrorDef[24][3] = "Honoraria Type was not put into PIW. "; //#sMeetingCode# ";
		aErrorDef[24][4] = "CheckMeetingCode_AppendPIWInfo()";
		aErrorDef[24][5] = ""; // HOW TO FIX 
		aErrorDef[25][1] = "25";
		aErrorDef[25][2] = "0";
		aErrorDef[25][3] = " Honoraria could not be located. "; //#sMeetingCode# ";
		aErrorDef[25][4] = "CheckMeetingCode_AppendPIWInfo()";
		aErrorDef[25][5] = ""; // HOW TO FIX 
		aErrorDef[26][1] = "26";
		aErrorDef[26][2] = "0";
		aErrorDef[26][3] = "Honoraria was empty string."; //#sMeetingCode# ";
		aErrorDef[26][4] = "CheckMeetingCode_AppendPIWInfo() ";
		aErrorDef[26][5] = ""; // HOW TO FIX 
		aErrorDef[27][1] = "27";
		aErrorDef[27][2] = "0";
		aErrorDef[27][3] = "Value could not be converted to type int.";
		aErrorDef[27][4] = "CheckDecile()";
		aErrorDef[27][5] = ""; // HOW TO FIX 
		aErrorDef[28][1] = "28";
		aErrorDef[28][2] = "1";
		aErrorDef[28][3] = "Roster file has match in database. This roster has been previously uploaded. ";
		aErrorDef[28][4] = "CheckForPreviousUpload()";
		aErrorDef[28][5] = ""; // HOW TO FIX 
		aErrorDef[29][1] = "29";
		aErrorDef[29][2] = "1";
		aErrorDef[29][3] = "MeetingCode field was never located in database.";
		aErrorDef[29][4] = "GetAllMeetings()";
		aErrorDef[29][5] = ""; // HOW TO FIX 
		aErrorDef[30][1] = "30";
		aErrorDef[30][2] = "1";
		aErrorDef[30][3] = "MeetingCode field was never located in database.";
		aErrorDef[30][4] = "RemoveUnwantedMeetings()";
		aErrorDef[30][5] = ""; // HOW TO FIX 
		aErrorDef[31][1] = "31";
		aErrorDef[31][2] = "1";
		aErrorDef[31][3] = "A unique delimeter could not be found.  The file contains too many special charaters.";
		aErrorDef[31][4] = "FindDelimiter()";
		aErrorDef[31][5] = ""; // HOW TO FIX 
		aErrorDef[32][1] = "32";
		aErrorDef[32][2] = "1";
		aErrorDef[32][3] = "Apptime does not match MeetingCode Time";
		aErrorDef[32][4] = "CheckMeetingCode_AppendPIWInfo()";
		aErrorDef[32][5] = ""; // HOW TO FIX
		}
		
		function outputErrorInformation(errNum)
		{
			//errorNumber = errNum * 1;
			//writeOutput(errorNumber);
			//t = 1;
			//errNum = t;
			
			writeOutput(" Error Number: ");
			writeOutput(aErrorDef[errNum][1]);
			writeOutput("<br>");
			
			writeOutput("Severity : ");
			if (aErrorDef[errNum][2] EQ 1)
			{
				writeOutput(" FATAL ");
			}
			else
			{
				writeOutput(" Non - Fatal ");
			}
			writeOutput("<br>");
			
			writeOutput(" Message: ");
			writeOutput(aErrorDef[errNum][3]);
				writeOutput("<br>");
			
			writeOutput(" Function: ");
			writeOutput(aErrorDef[errNum][4]);
			writeOutput(" <br> ");
			
			if(aErrorDef[errNum][5] NEQ "")
			{
				writeOutput(" Remedy: ");
				writeOutput(aErrorDef[errNum][5]);
				writeOutput(" <br> ");
			}
			
		} 
		
		function addToErrorArray(errNum, recNum)
		{
			recNum = toString(recNum); 
			errNum = toString(errNum);
			strForArray = errNum & ',' & recNum;
			arrayAppend(aError, strForArray);
			
		}
		
		function viewErrors()
		{
			writeOutput("<table border=1 width=500 align=center>");
			writeOutput("<tr>");
			writeOutput("<td align=center>");
			writeOutput("<B>");
			writeOutput("Record Number");
			writeOutput("</B>");
			writeOutput("</td>");
			writeOutput("<td align=center>");
			writeOutput("<B>");
			writeOutput("Error Description");
			writeOutput("</B>");
			writeOutput("</td>");	
			writeOutput("</tr>");
			for(i = 1; i LTE arrayLen(aError) ; i=i+1)
			{
				//ArraySort(aError, "numeric");  commented out becuase it was causing it to bomb out
				
				recNum = listGetAt(aError[i],1,",") + 0;
				errNum = listGetAt(aError[i],2,",") + 0;
				writeOutput("<tr>");
				writeOutput("<td align=center valign=center><h2>");
				writeOutput(recNum);
				writeOutput("</h2></td>");
				writeOutput("<td>");
				outputErrorInformation(errNum);
				writeOutput("</td>");	
				writeOutput("</tr>");
			}
			writeOutput("</table>");
			
			
		}
			
		function getErrorArrayLen()
		{
			aErrorLength = arrayLen(aError);
			return (aErrorLength); 
		}
	</cfscript>	
	
	
	
	<!------------------------------------------
	Globals Variables
	------------------------------------------->

	<CFSCRIPT>
		buildErrorDefArray(); // BUILDS ARRAY
	</CFSCRIPT>
	
	<!---File Management Variables----->
	<cfset gsFileData = "">
	<cfset gsLogDirectory = "C:\INETPUB\WWWROOT\pms.pharmakonllc.com\cgi-bin\roster_logs\">
	<cfset gsFullFilePath = "">
	<cfset gsFileName = "">
	
	<!---Data Variables---->
	<cfset aColHeadings = ArrayNew(1)>
	<cfset aDataCells = ArrayNew(1)>
	<cfset iTotalColumns = 0>
	<cfset gaDataCellsByRow = ArrayNew(2)>
	<cfset gsDelimiter = "^">
	<cfset giRowCount = 0>
	<cfset giCount = 0>
	<cfset giRosterMaxRow = 0>
	
	
	<!---Variables hold location of column headings---->
	<cfset giDecileLocation = 0>
	<cfset giDateLocation = 0>
	<cfset giTimeLocation = 0>
	<cfset giMeetingCodeLocation = 0>
	<cfset giFirstNameLocation = 0>
	<cfset giMiddleNameLocation = 0>
	<cfset giLastNameLocation = 0>
	<cfset giOfficePhoneLocation = 0>
	<cfset giCETPhoneLocation = 0>
	<cfset giShiptoAddr1Location = 0>
	<cfset giShiptoAddr2Location = 0>
	<cfset giShiptoAddr3Location = 0>
	<cfset giShiptoCityLocation = 0>
	<cfset giShiptoStateLocation = 0>
	<cfset giShiptoZipCodeLocation = 0>
	<cfset giOfficeAddr1Location = 0>
	<cfset giOfficeAddr2Location = 0>
	<cfset giOfficeAddr3Location = 0>
	<cfset giOfficeCityLocation = 0>
	<cfset giOfficeStateLocation = 0>
	<cfset giOfficeZipCodeLocation = 0>
	<cfset giModeratorLocation = 0>
	<cfset giHonorariaLocation = 0>
	<cfset giConferenceLocation = 0>
	<cfset giHonorariaLocation = 0>
	<cfset giHonorariaTypeLocation = 0>
	<cfset giKeyFldLocation = 0>
	<cfset giUser1Location = 0>
	<cfset giUser2Location = 0>
	<cfset giUser3Location = 0>
	<cfset giUser4Location = 0>
	<cfset giUser5Location = 0>
	<cfset giUser6Location = 0>
	<cfset giPhidLocation = 0>
	<cfset giStatusFieldLocation = 0>
	<cfset giScreener1Location = 0>
	<cfset giScreener2Location = 0>
	<cfset giScreener3Location = 0>
	<cfset giScreener4Location = 0>
	<cfset giScreener5Location = 0>
	<cfset giScreener6Location = 0>
	<cfset giScreener7Location = 0>
	<cfset giScreener8Location = 0>
	<cfset giScreener9Location = 0>
	<cfset giScreener10Location = 0>
	<cfset giDegreeLocation = 0>
	<cfset giSalutationLocation = 0>
	<cfset giFaxLocation = 0>
	<cfset giEmailLocation = 0>
		
	<!----Controls permission for upload----->
	<cfset gbFatalError = false>
	<cfset gbUserAllowingUpload = false>

<!----***************************************************
Function: Main()
Author: Matt Eaves
Description: Drives program and calls all other functions that do not require input from user.
History: 11/26/02 - Created
**********************************************************---->
	<cffunction name="Main" hint="Main()" access="public" output="yes" returntype="any">
		<cfargument name="sFilePath" type="string" required="true"/>
		<cfargument name="sUserDecision" type="string" required="true"/>
		<cfargument name="iStep" type="numeric" required="true"/>
		
		<cfif #arguments.sUserDecision# EQ "0">
			<cfset gbUserAllowingUpload = false>
		<cfelse>
			<cfset gbUserAllowingUpload = true>
		</cfif>

		<cfscript>
			//this.CreateLogFile(sFileNamePath="#arguments.sFilePath#");
			this.ReadFile(sFileNamePath="#arguments.sFilePath#");
			this.FindDelimiter();
			bFileis_Comma = this.FindFileDelimiter();
					
			if(bFileis_Comma) //if true, file is comma delimited.
			{
				this.SetArrays(sTheFile="#gsFileData#");
			}
			else //file is tab delimited
			{
				this.SetArraysFromTAB(sTheFile="#gsFileData#");
			}
			
			this.SetRowCount();
			this.RemoveQuotes();
			this.MatchColumnHeadings();
		
		if(arguments.iStep is 2)
		{
			this.CheckDecile();
			this.ConvertTime();
			this.CheckName();
			this.CheckPhone();
			this.CheckAddress();
			this.CreateKeyField();
			this.RemoveSpecialChars();
			this.ConvertDate();
			this.CheckMeetingCode_AppendPIWInfo();
			this.ConvertTimeBack();
			this.TrimFields();
			this.GetMaxRow();
			
			//if(gbUserAllowingUpload is true) //if user only wants to see data, don't check for previous upload.
			//{
				this.CheckforPreviousUpload();
			//}
			
			//Added by Tom Swift
			//this.WriteErrorFromJSArrayToFile();
		}
		</cfscript>
		<!--- <CFSCRIPT>
			viewErrors(); // views errors
		</CFSCRIPT> --->
	</cffunction>
	

<!----***************************************************
Function: CreateLogFile()
Author: Matt Eaves
Description: Creates Log file to log errors.  For log file name, I use todays date followed by "_for_" and then the last 12 chars of 
			 file being uploaded.  Usually the date of the roster.
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="CreateLogFile" hint="Creates Log File" access="public" output="yes">
		<cfargument name="sFileNamePath" type="string" required="true"/>
		
		<cfset oToday = #DateFormat(Now(), "yyyymmdd")#>
		<cfset sToday = ToString(oToday)>
		<cfset sCurFile = #Right(arguments.sFileNamePath, 12)#>
		<cfset sFileName = #sToday# & "_for_" & #sCurFile#>
		<cfset gsFileName = #sFileName#>
		<cfset gsFullFilePath  = #gsLogDirectory# & #sFileName#>
		
		<cfset oTodayDate = #DateFormat(Now(), "mm/dd/yyyy")#>
		<cfset oTodayTime = #TimeFormat(Now(), "hh:mm:sstt")#>
	
		<cffile action="write" file="#gsFullFilePath#" addNewLine="Yes" output="Date: #oTodayDate# Time: #oTodayTime#">
		<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="************************************">
		<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output=" ">
	</cffunction>
	

<!----***************************************************
Function: ReadFile()
Author: Matt Eaves
Description: Creates Log file to log errors.
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="ReadFile" hint="Reads the file and stores the output in a global variable" access="public" output="no">
		<cfargument name="sFileNamePath" type="string" required="true"/>

		<cffile action="READ" file="#arguments.sFileNamePath#" variable="sFileContents">
		<cfset gsFileData = #sFileContents#>
		
	</cffunction>


<!----***************************************************
Function: FindDelimiter()
Author: Matt Eaves
Description: Because commas appear in some of the data fields, it may be neccessary to change how the data is delimited. To avoid 
			 selecting a delimiter that is already in the file, we scan it, then choose based on what we DONT find.
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="FindDelimiter" hint="Sets a delimiter based on which special character does NOT appear in the file" access="public" output="no">
		
		<cfset DelimiterArray = ArrayNew(1)>
		<cfset DelimiterArray[1] = "*">
		<cfset DelimiterArray[2] = "|">
		<cfset DelimiterArray[3] = "^">
		<cfset DelimiterArray[4] = "!">
		<cfset DelimiterArray[5] = "{">
		<cfset DelimiterArray[6] = "~">
		
		<cfset bDelimiterFound = false>
		<cfloop index="i" from="1" to="#ArrayLen(DelimiterArray)#" step="1">
			<cfif bDelimiterFound EQ false> 
				<cfset chrTemp = #Find(DelimiterArray[i],gsFileData)#>
				<cfif chrTemp EQ 0><!---Character was not found set it as delimeter--->
					<cfset gsDelimiter = #DelimiterArray[i]#>
					<cfset bDelimiterFound = true>
				</cfif>
			</cfif>
		</cfloop>
		
		<cfif bDelimiterFound EQ false>
			<cfoutput>
				<cfscript>addToErrorArray(0,31);</cfscript>
				<h2>An Error has occured!</h2>
				A unique delimeter could not be found.  The file contains too many special charaters. Contact the I.T. department.
			</cfoutput>
			<cfabort>
		</cfif>
			
	</cffunction>
	
	
<!----***************************************************
Function: FindFileDelimiter()
Author: Matt Eaves
Description: Finds if file is TAB or COMMA delimited.
History: 01/21/02 - Created
**********************************************************---->	
	<cffunction name="FindFileDelimiter" hint="Finds if file is TAB or COMMA delimited." access="public" returntype="boolean">
		<cfset iDelimLoc = Find("#Chr(9)#",#gsFileData#)><!----Look for a TAB---->
		
		<!---Return Var is set to TAB by default. This may seem backwards because comma is the default, but 
		we have to check for TAB because even TAB Delimited files contain commas, but not vice versa.---->
		<cfset bFileIsComma = false>
		<cfif iDelimLoc EQ 0>
			<cfset bFileIsComma = true>
		</cfif>
		<cfreturn bFileIsComma>
		
	</cffunction>



<!----***************************************************
Function: SetArrays()
Author: Matt Eaves
Description: Sets the 2d array that holds all of the data.  Several checks and function calls are made within this function.
			 This function is really the bread and butter of the code. Almost all functions depend on this function.
History: 11/26/02 - Created
**********************************************************---->
	<cffunction name="SetArrays" hint="Sets all data to a two demensional array" access="public" output="yes">
		<cfargument name="sTheFile" type="string" required="true"/>
		
		<cfloop index="row" list="#sTheFile#" delimiters="#Chr(13)#">
	
			<cfset giCount = #giCount# + 1>
			
			<cfif #giCount# EQ 1><!---First row are heading names--->
				<!---Set the headers--->
				<cfset aColHeadings = ListToArray(row,",")>
				<cfloop index="t" from="1" to="#ArrayLen(aColHeadings)#" step="1">
					<cfset gaDataCellsByRow[1][t] = aColHeadings[t]>
				</cfloop>
				<!---Add Headings that will be appended later in the file---->
				<cfset gaDataCellsByRow[1][#ArrayLen(aColHeadings)# + 1] = "moderator">
				<cfset gaDataCellsByRow[1][#ArrayLen(aColHeadings)# + 2] = "honoraria">
				<cfset gaDataCellsByRow[1][#ArrayLen(aColHeadings)# + 3] = "conference">
				<cfset gaDataCellsByRow[1][#ArrayLen(aColHeadings)# + 4] = "honoraria_type">
				<cfset gaDataCellsByRow[1][#ArrayLen(aColHeadings)# + 5] = "keyfld">
				
				<!---Set the lenght of the new array----->
				<cfset iTotalColumns = #ArrayLen(aColHeadings)# + 5>
							
			<cfelse>
				<!---Keeep in mind that in this function we never talk to iTotalColumns because we are always dealing with the 
				list that is pulled from the roster, and not the length of the array we are setting dynamically.  In every other function 
				we talk to iTotalColumns because we deal with the 2d array and not the list. aColHeadings will always accurately reflect 
				the number of data columns in the roster .txt file.----->
				<cfset aTemp = ListToArray(row,",")>	
				
				<cfif #ArrayLen(aTemp)# LT #ArrayLen(aColHeadings)#>
					<cfscript>
						sCorrectedComma = this.UpdateNumericFields(sLine="#row#");
					</cfscript>
					<cfset the_temp = ListToArray(sCorrectedComma,",")>
									
				<cfelseif #ArrayLen(aTemp)# GT #ArrayLen(aColHeadings)#>
					
					<cfscript>
						sCorrectedComma = this.UpdateNumericFields(sLine="#row#");
						sNewDelimiter = this.InsertNewDelimiter(sLine2="#sCorrectedComma#");
					</cfscript>
					<cfset the_temp = ListToArray(sNewDelimiter,"#gsDelimiter#")><!----Set the string back to an array--->
										
					<cfif #ArrayLen(the_temp)# LT #ArrayLen(aColHeadings)#><!---We have a numeric field that needs to be placed into quotes--->
						<cfscript>
							sDataFix = this.PlaceQuotesAroundNumericField(sNewList="#sNewDelimiter#");
						</cfscript>
						<cfset the_temp = ListToArray(sDataFix,"#gsDelimiter#")>
					</cfif>
			
				<cfelse>
					<!---We are here because the array length is equal to that of the column headings array length.  To be sure 
					this ins't due to a comma appearing in one of the data fields we change the dilimeter and recalculate 
					the length of the array.---->
					<cfscript>
						sCorrectedComma = this.UpdateNumericFields(sLine="#row#");
						sNewDelimiter = this.InsertNewDelimiter(sLine2="#sCorrectedComma#");
					</cfscript>
					<cfset the_temp = ListToArray(sNewDelimiter,"#gsDelimiter#")><!----Set the string back to an array--->
										
					<cfif #ArrayLen(the_temp)# LT #ArrayLen(aColHeadings)#><!---We have a numeric field that needs to be placed into quotes--->
						<cfscript>
							sDataFix = this.PlaceQuotesAroundNumericField(sNewList="#sNewDelimiter#");
						</cfscript>
						<cfset the_temp = ListToArray(sDataFix,"#gsDelimiter#")>
					</cfif>
				</cfif>
				
				<!---Set the row of data to the master array. We add five places in the array below to compensate for the 
				appended data that we want to add but is not in the roster----->
				<cfloop index="z" from="1" to="#ArrayLen(the_temp)#" step="1">
					<cfset gaDataCellsByRow[giCount][z] = the_temp[z]>
				</cfloop>
				<cfset gaDataCellsByRow[giCount][#ArrayLen(the_temp)# + 1] = "">
				<cfset gaDataCellsByRow[giCount][#ArrayLen(the_temp)# + 2] = "">
				<cfset gaDataCellsByRow[giCount][#ArrayLen(the_temp)# + 3] = "">
				<cfset gaDataCellsByRow[giCount][#ArrayLen(the_temp)# + 4] = "">
				<cfset gaDataCellsByRow[giCount][#ArrayLen(the_temp)# + 5] = "">
				
			</cfif>
		</cfloop>
			
	</cffunction>
	

<!----***************************************************
Function: SetArraysFromTAB()
Author: Matt Eaves
Description: Sets the 2d array that holds all of the data. 
History: 01/21/02 - Created
**********************************************************---->
	<cffunction name="SetArraysFromTAB" hint="Sets all data to a two demensional array" access="public" output="yes">
		<cfargument name="sTheFile" type="string" required="true"/>
		
		<cfloop index="row" list="#sFileContents#" delimiters="#Chr(13)#">
	
			<cfset giCount = #giCount# + 1>
			
			<cfif #giCount# EQ 1><!---First row are heading names--->
				<!---Set the headers--->
				<cfset aColHeadings = ListToArray(row,"#Chr(9)#")>
				<cfloop index="t" from="1" to="#ArrayLen(aColHeadings)#" step="1">
					<cfset gaDataCellsByRow[1][t] = aColHeadings[t]>
				</cfloop>
				<!---Add Headings that will be appended later in the file---->
				<cfset gaDataCellsByRow[1][#ArrayLen(aColHeadings)# + 1] = "moderator">
				<cfset gaDataCellsByRow[1][#ArrayLen(aColHeadings)# + 2] = "honoraria">
				<cfset gaDataCellsByRow[1][#ArrayLen(aColHeadings)# + 3] = "conference">
				<cfset gaDataCellsByRow[1][#ArrayLen(aColHeadings)# + 4] = "honoraria_type">
				<cfset gaDataCellsByRow[1][#ArrayLen(aColHeadings)# + 5] = "keyfld">
				
				<!---Set the lenght of the new array----->
				<cfset iTotalColumns = #ArrayLen(aColHeadings)# + 5>
										
			<cfelse>
				
				<cfset lNewList = Replace("#row#", "#Chr(9)##Chr(9)#", "*NULL*", "all")>
				<cfset lNewList = Replace("#lNewList#", "**", "*NULL*", "all")>
				<!--- <cfoutput>#NewList#</cfoutput><br> --->
				<cfset lNewList = Replace("#lNewList#", "#Chr(9)#", "*", "all")>
				<!--- <cfoutput>#NewList#</cfoutput><br> --->
				<cfset lNewList = Replace("#lNewList#", "**", "*NULL*", "all")>
				<!--- <cfoutput>#NewList#</cfoutput><br><br> --->
				<cfset aTemp = ListToArray(lNewList,"*")>
							
				<!---Set the row of data to the master array. We add five places in the array below to compensate for the 
				appended data that we want to add but is not in the roster----->
				<cfloop index="z" from="1" to="#ArrayLen(aTemp)#" step="1">
					<cfif aTemp[z] EQ 'NULL'>
						<cfset aTemp[z] = ''>
					</cfif>
					<cfset gaDataCellsByRow[giCount][z] = aTemp[z]>
				</cfloop>
				<cfset gaDataCellsByRow[giCount][#ArrayLen(aTemp)# + 1] = "">
				<cfset gaDataCellsByRow[giCount][#ArrayLen(aTemp)# + 2] = "">
				<cfset gaDataCellsByRow[giCount][#ArrayLen(aTemp)# + 3] = "">
				<cfset gaDataCellsByRow[giCount][#ArrayLen(aTemp)# + 4] = "">
				<cfset gaDataCellsByRow[giCount][#ArrayLen(aTemp)# + 5] = "">
				
			</cfif>
		</cfloop>
			
	</cffunction>


<!----***************************************************
Function: UpdateNumericFields()
Author: Matt Eaves
Description: Although ,, represents a numeric field CFM does not allow empty sets in lists.  Need 
			 to set ,, to ,"",.  Data type will be int when we perform SQL insert
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="UpdateNumericFields" hint="Replaces instances of ,, with ,""," access="public" output="yes" returntype="string">
		<cfargument name="sLine" type="string" required="true"/>
	
		<cfset sCorrectedRowofData = #Replace(arguments.sLine,',,',',"",',"all")#>
		<cfreturn sCorrectedRowofData>
		
	</cffunction>

	
<!----***************************************************
Function: InsertNewDelimiter()
Author: Matt Eaves
Description: Were here becasue there is a data field that contains commas.  
			For example Augmentin,Biaxin,Levaquin is a single data field.
			To correct this we switch the delimiter and then we can leave the comma in the data
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="InsertNewDelimiter" hint="Replaces , delimiter with new delimiter" access="public" output="yes" returntype="string">
		<cfargument name="sLine2" type="string" required="true"/>
			
		<cfset sNewDelimitedData = Replace(arguments.sLine2,'","','"#gsDelimiter#"',"all")>
		<cfreturn sNewDelimitedData>
		
	</cffunction>

	
<!----***************************************************
Function: PlaceQuotesAroundNumericField()
Author: Matt Eaves
Description: Numieric Fields do not contain quotes.  This function will place quotes around numeric 
			 data fields with an actual value in it. The UpdateNumericFields() function handles null fields
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="PlaceQuotesAroundNumericField" hint="Puts quotes around numeric fields" access="public" output="yes" returntype="string">
		<cfargument name="sNewList" type="string" required="true"/>
		<!---Programmer Note: This function contains a bug.  In some situtations we may have a data field that looks like 
		this: "drug_a,", in that situation that field would be converted to two fields. drug_a and a numeric field.  Need 
		a way to recognize when blitz just put a comma to follow a string.---->
		
		<cfset sFixQuoteComma = Replace(arguments.sNewList,'",','"#gsDelimiter#"',"all")><!---Replace ", with "*"--->
		<cfset sFixCommaQuote = Replace(sFixQuoteComma,',"','"#gsDelimiter#"',"all")><!---Replace ," with "*"--->
		<cfreturn sFixCommaQuote>
		
	</cffunction>

	
<!----***************************************************
Function: RemoveQuotes()
Author: Matt Eaves
Description: Removes all quotes that encloses data.  Also converts fields/data to uppercase.
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="RemoveQuotes" hint="Removes the Quotes from the data fields" access="public" output="yes">
		<!---<cfoutput>#giRowCount#:#iTotalcolumns#</cfoutput>--->
		<cfloop index="r" from="1" to="#giRowCount#" step="1">
			<cfloop index="f" from="1" to="#iTotalColumns#" step="1">
				<cfset sTemp = Replace(gaDataCellsByRow[r][f],'"','',"all")>
				<cfset sTemp = #trim(sTemp)#>
								
				<cfif #r# EQ 1>
				<!---Set the column headings to lower case to match the database---->
					<cfset sTemp = #Lcase(sTemp)#>
				<cfelse>
					<cfset sTemp = #Ucase(sTemp)#>
				</cfif>
				
				<cfset gaDataCellsByRow[r][f] = #sTemp#>
				
			</cfloop>
		</cfloop>
	</cffunction>
	
<!----***************************************************
Function: RemoveSpecialChars()
Author: Matt Eaves
Description: Removes ' from data.
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="RemoveSpecialChars" hint="Removes Special charaters" access="public" output="no">
		
		<cfloop index="c" from="1" to="#giRowCount#" step="1">
			<cfloop index="b" from="1" to="#iTotalColumns#" step="1">
				<cfset sTemp = Replace(gaDataCellsByRow[c][b],"'"," ","all")>
				<cfset gaDataCellsByRow[c][b] = #sTemp#>
			</cfloop>
		</cfloop>

	</cffunction>

	
<!----***************************************************
Function: MatchColumnHeadings()
Author: Matt Eaves
Description: Macthes database column headings to current column headings in array. This ensures correct data is getting dumped into db.
			 Later in the file, certain functions ensure that these fields are found, if they arn't fatal error.
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="MatchColumnHeadings" hint="Matches Array to Column Headings" access="public" output="yes">
				
		<cfloop index="t" from="1" to="#iTotalColumns#" step="1">
			<cfswitch expression="#trim(gaDataCellsByRow[1][t])#">
				<cfcase value="DECILE">
					<cfset giDecileLocation = #t#>
				</cfcase>
				<cfcase value="MEETINGCODE">
					<cfset giMeetingCodeLocation = #t#>
				</cfcase>
				<cfcase value="APPTDATE">
					<cfset giDateLocation = #t#>
				</cfcase>
				<cfcase value="APPTTIME">
					<cfset giTimeLocation = #t#>
				</cfcase>
				<cfcase value="FIRSTNAME">
					<cfset giFirstNameLocation = #t#>
				</cfcase>
				<cfcase value="MIDDLENAME">
					<cfset giMiddleNameLocation = #t#>
				</cfcase>
				<cfcase value="LASTNAME">
					<cfset giLastNameLocation = #t#>
				</cfcase>
				<cfcase value="CET_PHONE">
					<cfset giCETPhoneLocation = #t#>
				</cfcase>
				<cfcase value="OFFICE_PHONE">
					<cfset giOfficePhoneLocation = #t#>
				</cfcase>
				<cfcase value="SHIPTO_ADDR1">
					<cfset giShiptoAddr1Location = #t#>
				</cfcase>
				<cfcase value="SHIPTO_ADDR2">
					<cfset giShiptoAddr2Location = #t#>
				</cfcase>
				<cfcase value="SHIPTO_ADDR3">
					<cfset giShiptoAddr3Location = #t#>
				</cfcase>
				<cfcase value="SHIPTO_CITY">
					<cfset giShiptoCityLocation = #t#>
				</cfcase>
				<cfcase value="SHIPTO_STATE">
					<cfset giShiptoStateLocation = #t#>
				</cfcase>
				<cfcase value="SHIPTO_ZIPCODE">
					<cfset giShiptoZipCodeLocation = #t#>
				</cfcase>
				<cfcase value="OFFICE_ADDR1">
					<cfset giOfficeAddr1Location = #t#>
				</cfcase>
				<cfcase value="OFFICE_ADDR2">
					<cfset giOfficeAddr2Location = #t#>
				</cfcase>
				<cfcase value="OFFICE_ADDR3">
					<cfset giOfficeAddr3Location = #t#>
				</cfcase>
				<cfcase value="OFFICE_CITY">
					<cfset giOfficeCityLocation = #t#>
				</cfcase>
				<cfcase value="OFFICE_STATE">
					<cfset giOfficeStateLocation = #t#>
				</cfcase>
				<cfcase value="OFFICE_ZIPCODE">
					<cfset giOfficeZipCodeLocation = #t#>
				</cfcase>
				<cfcase value="MODERATOR">
					<cfset giModeratorLocation = #t#>
				</cfcase>
				<cfcase value="CONFERENCE">
					<cfset giConferenceLocation = #t#>
				</cfcase>
				<cfcase value="HONORARIA">
					<cfset giHonorariaLocation = #t#>
				</cfcase>
				<cfcase value="HONORARIA_TYPE">
					<cfset giHonorariaTypeLocation = #t#>
				</cfcase>
				<cfcase value="KEYFLD">
					<cfset giKeyFldLocation = #t#>
				</cfcase>
				<cfcase value="USER1">
					<cfset giUser1Location = #t#>
				</cfcase>
				<cfcase value="USER2">
					<cfset giUser2Location = #t#>
				</cfcase>
				<cfcase value="USER3">
					<cfset giUser3Location = #t#>
				</cfcase>
				<cfcase value="USER4">
					<cfset giUser4Location = #t#>
				</cfcase>
				<cfcase value="USER5">
					<cfset giUser5Location = #t#>
				</cfcase>
				<cfcase value="USER6">
					<cfset giUser6Location = #t#>
				</cfcase>
				<cfcase value="PHID">
					<cfset giPhidLocation = #t#>
				</cfcase>
				<cfcase value="STATUS">
					<cfset giStatusFieldLocation = #t#>
				</cfcase>
				<cfcase value="SCREENER1">
					<cfset giScreener1Location = #t#>
				</cfcase>
				<cfcase value="SCREENER2">
					<cfset giScreener2Location = #t#>
				</cfcase>
				<cfcase value="SCREENER3">
					<cfset giScreener3Location = #t#>
				</cfcase>
				<cfcase value="SCREENER4">
					<cfset giScreener4Location = #t#>
				</cfcase>
				<cfcase value="SCREENER5">
					<cfset giScreener5Location = #t#>
				</cfcase>
				<cfcase value="SCREENER6">
					<cfset giScreener6Location = #t#>
				</cfcase>
				<cfcase value="SCREENER7">
					<cfset giScreener7Location = #t#>
				</cfcase>
				<cfcase value="SCREENER8">
					<cfset giScreener8Location = #t#>
				</cfcase>
				<cfcase value="SCREENER9">
					<cfset giScreener9Location = #t#>
				</cfcase>
				<cfcase value="SCREENER10">
					<cfset giScreener10Location = #t#>
				</cfcase>
				
				<cfcase value="SALUTATION">
					<cfset giSalutationLocation = #t#>
				</cfcase>
				<cfcase value="DEGREE">
					<cfset giDegreeLocation = #t#>
				</cfcase>
				<cfcase value="FAX">
					<cfset giFaxLocation = #t#>
				</cfcase>
				<cfcase value="EMAIL">
					<cfset giEmailLocation = #t#>
				</cfcase>		
			</cfswitch>		
		</cfloop>
		
	</cffunction>


<!----***************************************************
Function: SetRowCount()
Author: Matt Eaves
Description: Last line of data will contain a carriage return.  To avoid array elements not found error, we need to set the 
			 length of the array to one less than it actually is.
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="SetRowCount" hint="Last line will contain carriage return. Need to remove from Array Length" access="public" output="no">
		
		<cfset giRowCount = #giCount# - 1>

	</cffunction>


<!----***************************************************
Function: CheckDecile()
Author: Matt Eaves
Description: Ensures decile exists, converts non-numeric values to integers if possible, and inputs erros into log file.
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="CheckDecile" hint="Ensures each record has a decile and makes sure it is numeric" access="public" output="no">

		<cfif #giDecileLocation# NEQ 0>
			<cfloop index="h" from="2" to="#giRowCount#" step="1">
				<cfset DecileValue = #trim(gaDataCellsByRow[h][giDecileLocation])#>
				<cfset ValisNum = #IsNumeric(DecileValue)#>
				
				<cfset NewDecileValue = ''>
				<cfif #ValisNum#>
					<cfset NewDecileValue = #DecileValue#>
				<cfelse>
					<cfif Len(DecileValue) EQ 2>
						<cfset NewDecileValue = RemoveChars(DecileValue, 1, 1)>
						<cfset ValNum = #IsNumeric(NewDecileValue)#>
						<cfif NOT #ValNum#>
							<cfscript>addToErrorArray(h,27);</cfscript>
							<cfset NewDecileValue = ''>
						</cfif>					
					</cfif>
				</cfif>
				<cfset gaDataCellsByRow[h][giDecileLocation] = #NewDecileValue#>
			</cfloop>
		<cfelse>
				<cfscript>addToErrorArray(h,2);</cfscript>
			<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckDecile() || Error: Decile was never located in header columns. || ERROR IS FATAL">
			<cfset gbFatalError = true>
		</cfif>
		
	</cffunction>
	
<!----***************************************************
Function: ConvertDate()
Author: Matt Eaves
Description: Ensures date exsits and then converts it to object.  This function also insures that the columns are aligned correctly. 
			 If a string resembling a date is not in the current array element, then we know that our SetArrays() function had an error 
			 and needs to be corrected.  			 
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="ConvertDate" hint="Converts Date to Date Object" access="public" output="yes">

		<cfif #giDateLocation# NEQ 0>
			<cfloop index="h" from="2" to="#giRowCount#" step="1">
			
				<cfset DateValue = #trim(gaDataCellsByRow[h][giDateLocation])#>
				<cfset iDateDivider = #Find("/",DateValue)#>
				
				<cfif iDateDivider EQ 0>
					<cfscript>addToErrorArray(h,3);</cfscript>
					<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: ConvertDate() || Error: Columns are misaligned. There is a problem with the way the component parsed the text file. Contact I.T. Department to fix the problem. || Record: #h# Data in place of date: #DateValue#  || ERROR IS FATAL">
					<cfset gbFatalError = true>
				<cfelse>
					<cfset aNewDate = ListToArray(DateValue,"/")>
					<cfset sMonth = #aNewDate[1]#>
					<cfset sDay = #aNewDate[2]#>
					<cfset sYear = #aNewDate[3]#>
					
					<cfset oDateofMeeting = #CreateDate(sYear, sMonth, sDay)#>
					<cfset gaDataCellsByRow[h][giDateLocation] = #oDateofMeeting#>
				</cfif>
				
				
			</cfloop>
		<cfelse>
				<cfscript>addToErrorArray(h,4);</cfscript>
			<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: ConvertDate() || Error: APPTDATE field was never located in header columns. || ERROR IS FATAL">
			<cfset gbFatalError = true>
		</cfif> 
		
	</cffunction>	


<!----***************************************************
Function: ConvertTime()
Author: Matt Eaves
Description: Converts civilian time string to military string.  We need this funtion in order to compare meeting times in the scheduling 
			 system.
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="ConvertTime" hint="Converts civilian time to military" access="public" output="yes">
				
		<cfif #giTimeLocation# NEQ 0>
			<cfloop index="h" from="2" to="#giRowCount#" step="1">
				<cfset sCivTime = #trim(gaDataCellsByRow[h][giTimeLocation])#>
				<cfset sTimeLength = #Len(sCivTime)#>
				
				<cfif #sTimeLength# EQ 7>		
			
					<cfset BMeridiem = #Mid(sCivTime, 6, 2)#>
					<cfset BHour = #Mid(sCivTime, 1, 2)#>
					<cfset BMinute = #Mid(sCivTime, 4, 2)#>
					
					<cfif #BMeridiem# EQ 'AM'>
						<cfswitch expression="#BHour#">
							<cfcase value="01"><cfset MilitaryHour = "0100"></cfcase>
							<cfcase value="02"><cfset MilitaryHour = "0200"></cfcase>
							<cfcase value="03"><cfset MilitaryHour = "0300"></cfcase>
							<cfcase value="04"><cfset MilitaryHour = "0400"></cfcase>
							<cfcase value="05"><cfset MilitaryHour = "0500"></cfcase>
							<cfcase value="06"><cfset MilitaryHour = "0600"></cfcase>
							<cfcase value="07"><cfset MilitaryHour = "0700"></cfcase>
							<cfcase value="08"><cfset MilitaryHour = "0800"></cfcase>
							<cfcase value="09"><cfset MilitaryHour = "0900"></cfcase>
							<cfcase value="10"><cfset MilitaryHour = "1000"></cfcase>
							<cfcase value="11"><cfset MilitaryHour = "1100"></cfcase>
							<cfcase value="12"><cfset MilitaryHour = "2400"></cfcase>
						</cfswitch>
					<cfelse>
						<cfswitch expression="#BHour#">
							<cfcase value="12"><cfset MilitaryHour = "1200"></cfcase>
							<cfcase value="01"><cfset MilitaryHour = "1300"></cfcase>
							<cfcase value="02"><cfset MilitaryHour = "1400"></cfcase>
							<cfcase value="03"><cfset MilitaryHour = "1500"></cfcase>
							<cfcase value="04"><cfset MilitaryHour = "1600"></cfcase>
							<cfcase value="05"><cfset MilitaryHour = "1700"></cfcase>
							<cfcase value="06"><cfset MilitaryHour = "1800"></cfcase>
							<cfcase value="07"><cfset MilitaryHour = "1900"></cfcase>
							<cfcase value="08"><cfset MilitaryHour = "2000"></cfcase>
							<cfcase value="09"><cfset MilitaryHour = "2100"></cfcase>
							<cfcase value="10"><cfset MilitaryHour = "2200"></cfcase>
							<cfcase value="11"><cfset MilitaryHour = "2300"></cfcase>
						</cfswitch>
					</cfif>
					
					<cfif #BMinute# EQ "30">
						<cfset MilitaryMinute = "50">
					<cfelse>
						<cfset MilitaryMinute = "00">
					</cfif>
			
					<cfset sTheTime = #MilitaryHour# + #MilitaryMinute#>
					<cfset gaDataCellsByRow[h][giTimeLocation] = #sTheTime#>
				
				<cfelse><!---Length of string is not something we can work with------>
					<cfscript>addToErrorArray(h,6);</cfscript>
					<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: ConvertTime() || Error: Time field has string GT or LT 7 charaters. || Record: #h#">
					<cfset gaDataCellsByRow[h][giTimeLocation] = "Error">	
				</cfif>
			</cfloop>
		<cfelse>
			<cfscript>addToErrorArray(h,5);</cfscript>
			<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: ConvertTime() || Error: APPTTIME field was never located in header columns. || ERROR IS FATAL">
			<cfset gbFatalError = true>
		</cfif>
	</cffunction>


<!----***************************************************
Function: CheckName()
Author: Matt Eaves
Description: Ensures first and last name fields are not null.  If they are we just log an error.  NULL fields are not fatal.
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="CheckName" hint="Ensures first and last name fields are not null" access="public" output="no">

		<cfif #giFirstNameLocation# NEQ 0> 
			<cfif #giLastNameLocation# NEQ 0>
				<cfloop index="h" from="2" to="#giRowCount#" step="1">
					<cfset sFirstName = #trim(gaDataCellsByRow[h][giFirstNameLocation])#>
					<cfset sLastName = #trim(gaDataCellsByRow[h][giLastNameLocation])#>
						
					<cfif sFirstName EQ ''>
						<cfscript>addToErrorArray(h,10);</cfscript>
						<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckName() || Error: First Name field is null. || Record: #h#">	
					<cfelseif Len(sFirstName) GT 34>
						<cfset gaDataCellsByRow[h][giFirstNameLocation] = #Left(sFirstName, 35)#>
					</cfif>
					
					<cfif sLastName EQ ''>
						<cfscript>addToErrorArray(h,9);</cfscript>
						<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckName() || Error: Last Name field is null. || Record: #h#">
					<cfelseif Len(sLastName) GT 34>
						<cfset gaDataCellsByRow[h][giLastNameLocation] = #Left(sLastName, 35)#>
					</cfif>				
					
				</cfloop>
			<cfelse>
				<cfscript>addToErrorArray(h,7);</cfscript>
				<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckName() || Last Name field was never located in header columns. || ERROR IS FATAL">
				<cfset gbFatalError = true>
			</cfif>
		<cfelse>
			<cfscript>addToErrorArray(h,8);</cfscript>
			<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckName() || First Name field was never located in header columns. || ERROR IS FATAL">
			<cfset gbFatalError = true>
		</cfif> 
		
	</cffunction>	


<!----***************************************************
Function: CheckPhone()
Author: Matt Eaves
Description: Ensures phone1 and phone2 is not null or empty string
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="CheckPhone" hint="Ensures CET_phone and Office_phone are not null or empty string" access="public" output="no">

		<cfif #giCETPhoneLocation# NEQ 0>
			<cfif #giOfficePhoneLocation# NEQ 0>
				<cfloop index="h" from="2" to="#giRowCount#" step="1">
					<cfset sCETPhone = #trim(gaDataCellsByRow[h][giCETPhoneLocation])#>
					<cfset sOfficePhone = #trim(gaDataCellsByRow[h][giOfficePhoneLocation])#>
										
					<cfif sCETPhone EQ ''>
						<cfscript>addToErrorArray(h,13);</cfscript>
						<cffile action="APPEND" file="#gsFullFilePath#" addnewline="yes" output=" ">
						<cffile action="APPEND" file="#gsFullFilePath#" addnewline="yes" output="*************************">
						<cffile action="APPEND" file="#gsFullFilePath#" addnewline="yes" output="ERROR in Record: #h#!!!">
						<cffile action="APPEND" file="#gsFullFilePath#" addnewline="yes" output="CET_Phone field is null.">
						<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Error occured in function: CheckPhone()">
						<cffile action="APPEND" file="#gsFullFilePath#" addnewline="yes" output=" ">
					<cfelse>
						<cfscript>
							strFormatedPhoneNum = this.FormatPhone(sPhoneNumber="#sCETPhone#");
						</cfscript>
						<cfset gaDataCellsByRow[h][giCETPhoneLocation] = #strFormatedPhoneNum#>
					</cfif>
					
					<cfif sOfficePhone EQ ''>
							<cfscript>addToErrorArray(h,14);</cfscript>
						<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckPhone() || Error: Office_Phone field is null. || Record: #h#">					
					<cfelse>
						<cfscript>
							strFormatedPhoneNum2 = this.FormatPhone(sPhoneNumber="#sOfficePhone#");
						</cfscript>
						<cfset gaDataCellsByRow[h][giOfficePhoneLocation] = #strFormatedPhoneNum2#>
					</cfif>
					
				</cfloop>
			<cfelse>
					<cfscript>addToErrorArray(h,12);</cfscript>
				<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckPhone() || Office_Phone field was never located in header columns. || ERROR IS FATAL">
				<cfset gbFatalError = true>
			</cfif>	
		<cfelse>
				<cfscript>addToErrorArray(h,11);</cfscript>
			<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckPhone() || CET_Phone field was never located in header columns. || ERROR IS FATAL">
			<cfset gbFatalError = true>
		</cfif> 
		
	</cffunction>


<!----***************************************************
Function: FormatPhone()
Author: Matt Eaves
Description: Puts phone numbers into 773-555-5555 format if possible.
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="FormatPhone" hint="Puts phone number into correct format" access="public" output="yes" returntype="string">
		<cfargument name="sPhoneNumber" type="string" required="true"/>
			
		<cfset strFld = #trim(arguments.sPhoneNumber)#>
		<cfset strChar = "">
		<cfset strPhoneNumber = "">
		<cfset strAreaCode = "">
		<cfset strExchange = "">
		<cfset strNumber = "">
		
		<cfset strChar = #Mid(strFld, 1, 1)#>
		<cfif strChar EQ "(">	
			<cfset strAreaCode = #Mid(strFld, 2, 3)#>
			<cfset strExchange = #Mid(strFld, 6, 3)#>
			<cfset strNumber = #Right(strFld, 4)#>
			<cfset strFld = #strAreaCode# & "-" & #strExchange# & "-" & #strNumber#>
		<cfelse>
			<cfset strChar = #Mid(strFld, 4, 1)#>
			<cfif strChar EQ "-">
				<!---Leave phone number as is---->
			<cfelse>
				<cfset strAreaCode = #Mid(strFld, 1, 3)#>
				<cfset strExchange = #Mid(strFld, 4, 3)#>
				<cfset strNumber = #Right(strFld, 4)#>
				<cfset strFld = #strAreaCode# & "-" & #strExchange# & "-" & #strNumber#>
			  </cfif>
		</cfif>	
		
		<cfreturn #strFld#>	
				
	</cffunction>
						

<!----***************************************************
Function: CheckAddress()
Author: Matt Eaves
Description: Ensures there is either a Home Address of an Office Address
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="CheckAddress" hint="Ensures there is either a Home Address of an Office Address" access="public" output="no">
		
		<cfif #giShiptoAddr1Location# NEQ 0>
			<cfif #giOfficeAddr1Location# NEQ 0>
				<cfloop index="h" from="2" to="#giRowCount#" step="1">
					<cfset sHomeAddress = #trim(gaDataCellsByRow[h][giShiptoAddr1Location])#>
					<cfset sOfficeAddress = #trim(gaDataCellsByRow[h][giOfficeAddr1Location])#>
										
					<cfif sHomeAddress EQ ''>
						<cfif sOfficeAddress EQ ''>
								<cfscript>addToErrorArray(h,17);</cfscript>
							<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckAddress() || Error: Neither a home or office address is provided. || Record: #h#">
						<cfelseif  Len(sOfficeAddress) GT 34>
							<cfset gaDataCellsByRow[h][giOfficeAddr1Location] = #Left(sOfficeAddress, 35)#>
						</cfif>
					<cfelseif Len(sHomeAddress) GT 34>
						<cfset gaDataCellsByRow[h][giShiptoAddr1Location] = #Left(sHomeAddress, 35)#>				
					</cfif>
	
				</cfloop> 
			<cfelse>
				<cfscript>addToErrorArray(h,15);</cfscript>
				<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckAddress() || Error: OFFICE_ADDR1 field was never located in header columns. || ERROR IS FATAL">
				<cfset gbFatalError = true>
			</cfif>
		<cfelse>
			<cfscript>addToErrorArray(h,16);</cfscript>
			<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckAddress() || Error: SHIPTO_ADDR1 field was never located in header columns. || ERROR IS FATAL">
			<cfset gbFatalError = true>
		</cfif> 
		
	</cffunction>	


<!----***************************************************
Function: CreateKeyField()
Author: Matt Eaves
Description: Creates key field by using 5 bytes of last name, 5 bytes of first name, and 5 bytes of office state.  CFM will NOT recognize more 
			 than one space or  " ".  Need to use _ (underscore) to symbolize empty spaces.  So if someones name is Bill, the fuction will convert 
			 Bill to Bill_
History: 12/4/02 - Created
		 1/20/03 - Matt Eaves changed zip code to State
**********************************************************---->	
	<cffunction name="CreateKeyField" hint="Uploads data to the server" access="public" output="no">
						
		<cfif #giFirstNameLocation# NEQ 0> 
			<cfif #giLastNameLocation# NEQ 0>
				<cfif #giOfficeStateLocation# NEQ 0>
					<cfloop index="h" from="2" to="#giRowCount#" step="1">
					
						<cfset sFirstName = #trim(gaDataCellsByRow[h][giFirstNameLocation])#>
						<cfset sLastName = #trim(gaDataCellsByRow[h][giLastNameLocation])#>
						<cfset sOfficeZipCode = #trim(gaDataCellsByRow[h][giOfficeZipCodeLocation])#>
						<cfset sZipCode = #trim(gaDataCellsByRow[h][giShiptoZipCodeLocation])#>
						
						<!---Replace ' with underscore--->
						<cfset sTemp = Replace(sFirstName,"'","_","all")>
						<cfset sFirstName = #sTemp#>
						
						<!---Replace ' with underscore--->
						<cfset sTemp2 = Replace(sLastName,"'","_","all")>
						<cfset sLastName = #sTemp2#>
						
						<cfset sTempZip = "">
						<cfset sTempLast = "">
						<cfset sTempFirst = "">
						<cfset sKeyField = "">
							
						<cfif #sFirstName# EQ "">
							<cfset sTempFirst = "_____">
						<cfelseif #Len(sFirstName)# EQ 5>
							<cfset sTempFirst = #sFirstName#>
						<cfelseif #Len(sFirstName)# EQ 4>
							<cfset sTempFirst = #sFirstName# & "_">
						<cfelseif #Len(sFirstName)# EQ 3>
							<cfset sTempFirst = #sFirstName# & "__">
						<cfelseif #Len(sFirstName)# EQ 2>
							<cfset sTempFirst = #sFirstName# & "___">
						<cfelseif #Len(sFirstName)# EQ 1>
							<cfset sTempFirst = #sFirstName# & "____">
						<cfelseif #Len(sFirstName)# EQ 0>
							<cfset sTempFirst = "_____">
						<cfelseif #Len(sFirstName)# GT 5>
							<cfset sTempFirst = #Mid(sFirstName, 1, 5)#>
						</cfif>								
						
						<cfif #sLastName# EQ "">
							<cfset sTempLast = "_____">
						<cfelseif #Len(sLastName)# EQ 5>
							<cfset sTempLast = #sLastName#>
						<cfelseif #Len(sLastName)# EQ 4>
							<cfset sTempLast = #sLastName# & "_">
						<cfelseif #Len(sLastName)# EQ 3>
							<cfset sTempLast = #sLastName# & "__">
						<cfelseif #Len(sLastName)# EQ 2>
							<cfset sTempLast = #sLastName# & "___">
						<cfelseif #Len(sLastName)# EQ 1>
							<cfset sTempLast = #sLastName# & "____">
						<cfelseif #Len(sLastName)# EQ 0>
							<cfset sTempLast = "_____">
						<cfelseif #Len(sLastName)# GT 5>
							<cfset sTempLast = #Mid(sLastName, 1, 5)#>
						</cfif>			
						
						<cfif #sOfficeZipCode# NEQ "" AND #Len(sOfficeZipCode)# GT 4>
								<cfset sTempZipCode = #left(sOfficeZipCode, 5)#>
						<cfelse>
							<cfif #sZipCode# NEQ "" AND #Len(sZipCode)# GT 4>
								<cfset sTempZipCode = #left(sZipCode, 5)#>
							<cfelse>
								<cfset sTempZipCode = "_____">
							</cfif>
						</cfif>
						
						<cfset sKeyField = #Insert(sTempFirst, sTempZipCode, 0)#>
						<cfset sKeyField = #Insert(sTempLast, sKeyField, 0)#>
						
						<cfset gaDataCellsByRow[h][giKeyFldLocation] = #sKeyField#>
																													
					</cfloop>
				<cfelse>
						<cfscript>addToErrorArray(h,18);</cfscript>
					<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CreateKeyField() || Office State field was never located in header columns. || ERROR IS FATAL">
					<cfset gbFatalError = true>
				</cfif>
			<cfelse>
				<cfscript>addToErrorArray(h,19);</cfscript>
				<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CreateKeyField() || Last Name field was never located in header columns. || ERROR IS FATAL">
				<cfset gbFatalError = true>
			</cfif>
		<cfelse>
			<cfscript>addToErrorArray(h,20);</cfscript>
			<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CreateKeyField() || First Name field was never located in header columns. || ERROR IS FATAL">
			<cfset gbFatalError = true>
		</cfif> 
				
	</cffunction>


	
<!----***************************************************
Function: CheckMeetingCode_AppendPIWInfo()
Author: Matt Eaves
Description: Checks to see if meeting code is valid, Adds Confernece Company, Honoraria, Moderator to array.
History: 12/6/02 - Created
**********************************************************---->	
	<cffunction name="CheckMeetingCode_AppendPIWInfo" hint="Checks to see if meeting code is valid Adds Confernece Company, Honoraria, Moderator to array." access="public" output="yes">
						
		<cfif #giMeetingCodeLocation# NEQ 0>
			<cfset sCurrentMeetingCode = "">
			
			<!----Set some globals here to hold all query information.  When the full meeting code is the same we don't 
				want to query all the tables again so we just set the array to the last query results.---->
				<cfset sPreviousMeetingCode = "">
				<cfset sModeratorName = "">
				<cfset iHonoraria = "">
				<cfset sConferenceCompany = "">
				<cfset sHonorariaType = "">

			<cfloop index="h" from="2" to="#giRowCount#" step="1">
								
				<cfset MeetingCodeValue = #trim(gaDataCellsByRow[h][giMeetingCodeLocation])#>
				<cfset sMeetingCode = #Mid(MeetingCodeValue, 1, 9)#>
				<cfset sClientCode = #Mid(MeetingCodeValue, 1, 5)#>
				
				<cfif #MeetingCodeValue# EQ #sPreviousMeetingCode#><!---Meeting is the same as last one, no need to query again--->
					<!--- display meetng code for debug 
						<cfoutput>#MeetingCodeValue#</cfoutput>
					--->
					
				<cfset strMilitaryTime = #trim(gaDataCellsByRow[h][giTimeLocation])#>
				
				<!--- <cfoutput><hr>
				sPreviousMeetingCode = #sPreviousMeetingCode# <br>
				sModeratorName = #sModeratorName# <br>
				iHonoraria = #iHonoraria# <br>
				sConferenceCompany = #sConferenceCompany# <br>
				sHonorariaType = #sHonorariaType# <br>
				<hr></cfoutput> --->
					
				
				<cfif strMilitaryTime GTE 1000>
				<cfset strCivilianHour = #Left(strMilitaryTime, 2)#>
				<cfelse>
				<cfset strCivilianHour = #Left(strMilitaryTime, 1)#>
				</cfif>
				

				<cfset strCivilianMinute = #Mid(strMilitaryTime, 3, 2)#>

				<!-----Set the Minutes---->
				<cfset strMinute = "00">
				<cfif strCivilianMinute EQ "50">
					<cfset strMinute = "30">
				</cfif>
				
				<cfset strMinute = "00">
				<cfif strCivilianMinute EQ "50">
					<cfset strMinute = "30">
				</cfif>
			
				<cfset strHour = #strCivilianHour#>
							
				<!----If hour is < 12, the hour is the same. ex. 0100 == 1:00AM---->
				
				<cfset strMeridiem = "PM">
				<cfif #strHour# GT 12 AND #strHour# NEQ 24>
					<cfset strHour = #strHour# - 12>
				<cfelseif #strHour# GT 12 AND #strHour# EQ 24>
					<cfset strHour = #strHour# - 12>
					<cfset strMeridiem = "AM">
				<cfelseif #strHour# EQ 12>
					<cfset strMeridiem = "PM">
				<cfelse>
					<cfset strMeridiem = "AM">
					
				</cfif>
				
				<cfset CivTime = #strHour# & ":" & #strMinute# & #strMeridiem#>
			
					 <CFSET CheckTimes = Right(MeetingCodeValue, 4)>
					 <CFSET CheckTimes = left(CheckTimes, 3)>
					 <CFSET CheckTimes = CheckTimes * 10>
					
					 
					 <cfif CheckTimes GTE 1000>
					 <CFSET CivTime = replace(trim(CivTime),":","","ALL")>
					 <CFSET CivTime = mid(CivTime,1,4)>
					 <cfelse>
					 <CFSET CivTime = replace(trim(CivTime),":","","ALL")>
					 <CFSET CivTime = mid(CivTime,1,3)>
					 </cfif>
					 
					
					 <cfif CheckTimes NEQ CivTime>
					 
					 	<cfscript>addToErrorArray(h,32);</cfscript>
					 <cfset gbFatalError = true>
					 </cfif>
				
					
					<cfset gaDataCellsByRow[h][giModeratorLocation] = #sModeratorName#>
					<cfset gaDataCellsByRow[h][giConferenceLocation] = #sConferenceCompany#>
					<cfset gaDataCellsByRow[h][giHonorariaTypeLocation] = #sHonorariaType#>
					<cfset gaDataCellsByRow[h][giHonorariaLocation] = #iHonoraria#>
					
				
				<cfelse><!---Last Meeting Code is not the same as current, need to query--->
				
				<!--- <cfoutput>#gaDataCellsByRow[h][giTimeLocation]#</cfoutput> --->
				<cfif gaDataCellsByRow[h][giTimeLocation] LT 1000>
				
				<cfset strNewTimeLoc = "">
				<cfset strNewTimeLoc = rjustify(gaDataCellsByRow[h][giTimeLocation], 4)>
				
				<cfset strNewTimeLoc = Replace(strNewTimeLoc, " ", "0")>
								
				</cfif>
				
				
				
					<CFQUERY DATASOURCE="#session.dbs#" NAME="getMeeting" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
						SELECT rowid, staff_id FROM schedule_meeting_time 
						WHERE project_code = '#sMeetingCode#' 
						AND year = year(#gaDataCellsByRow[h][giDateLocation]#) 
						AND month = month(#gaDataCellsByRow[h][giDateLocation]#)
						AND day = day(#gaDataCellsByRow[h][giDateLocation]#) 
						AND start_time = <cfif gaDataCellsByRow[h][giTimeLocation] LT 1000>'#strNewTimeLoc#'<cfelse>'#gaDataCellsByRow[h][giTimeLocation]#'</cfif> 
						AND status = 0 AND staff_type = 1
					</cfquery> 
					
					<cfset sPreviousMeetingCode = #MeetingCodeValue#>
							
					<cfif getMeeting.recordcount LT 1>
						<cfscript>addToErrorArray(h,21);</cfscript>
						<cfset gbFatalError = true>
						
					<cfelse>
						
						<!----Pull the Moderator Name---->
						<CFQUERY DATASOURCE="#session.spkrdbs#" NAME="GetModerator" USERNAME="#session.spkrdbu#" PASSWORD="#session.spkrdbp#">
							SELECT firstname, lastname
							FROM spkr_table 
							WHERE speaker_id = #getMeeting.staff_id#
						</CFQUERY>
						<!----Set the Moderator Name to the Array--->
						<cfset sModName = "">
						<cfif GetModerator.recordcount LT 1>
							<cfscript>addToErrorArray(h,22);</cfscript>
							<!--- bj20050307 - removed error logging, program was abending on this statement.
							<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckMeetingCode_AppendPIWInfo() || Error: Moderator assignment could not be located. || Meeting: #sMeetingCode# || Record: #h#">
							--->
							<cfset sModNam = "N/A">
						<cfelse>
							<cfset sModName = #trim(GetModerator.firstname)# & " " & #trim(GetModerator.lastname)#>
						</cfif>
						<cfset gaDataCellsByRow[h][giModeratorLocation] = #sModName#>
						<cfset sModeratorName = #sModName#>					
						
										
						<!----Pull the Conference Company---->
						<CFQUERY DATASOURCE="#session.dbs#" NAME="getConferenceCompany" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
							SELECT p.conference_company, c.conf_company_name 
							FROM piw p, conference_company c
							WHERE project_code = '#sMeetingCode#' 
							AND p.conference_company = c.id  
						</cfquery>
						<!----Set the Conference Company Name to the Array--->
						<cfset sConferenceCom = "">
						<cfif getConferenceCompany.recordcount LT 1>
								<cfscript>addToErrorArray(h,22);</cfscript>
							<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckMeetingCode_AppendPIWInfo() || Error: Conference Company could not be located. || Meeting: #sMeetingCode# || Record: #h#">
							<cfset sConferenceCom = "N/A">
						<cfelse>
							<cfset sConferenceCom = #getConferenceCompany.conf_company_name#>
						</cfif>
						<cfset gaDataCellsByRow[h][giConferenceLocation] = #sConferenceCom#> 
						<cfset sConferenceCompany = #sConferenceCom#>
						
						
						<!----Pull the Honoraria Type---->
						<CFQUERY DATASOURCE="#session.dbs#" NAME="getHonType" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
							SELECT attendee_comp_type 
							FROM piw 
							WHERE project_code = '#sMeetingCode#'  
						</cfquery>
						
						<!----Set the Honoraria Type to the Array--->
						<cfset sHonoType = "">
						<cfif getHonType.recordcount LT 1>
							<cfscript>addToErrorArray(h,23);</cfscript>
							<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckMeetingCode_AppendPIWInfo() || Error: Honoraria Type could not be located. || Meeting: #sMeetingCode# || Record: #h#">
							<cfset sHonoType = "N/A">
						<cfelseif getHonType.attendee_comp_type EQ "">
							<cfscript>addToErrorArray(h,24);</cfscript>
							<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckMeetingCode_AppendPIWInfo() || Error: Honoraria Type was not put into PIW. || Meeting: #sMeetingCode# || Record: #h#">
							<cfset sHonoType = "N/A">
						<cfelse>
							<cfset sHonoType = #getHonType.attendee_comp_type#>
						</cfif>
						<cfset gaDataCellsByRow[h][giHonorariaTypeLocation] = #sHonoType#> 
						<cfset sHonorariaType = #sHonoType#>
										
						
						<!----Pull the Honoraria---->
						<CFQUERY DATASOURCE="#session.dbs#" NAME="GetHonoraria" USERNAME="#session.dbu#" PASSWORD="#session.dbp#">
							SELECT attendee_comp
							FROM piw 
							WHERE project_code = '#sMeetingCode#' 
						</CFQUERY>
						
						<!---Ensure that we can find the honoraria fee.  If not put a error in the log file, and just make it empty string.--->
						<cfset iHonoFee = "">
						<cfif GetHonoraria.recordcount LT 1>
							<cfscript>addToErrorArray(h,25);</cfscript>
							<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckMeetingCode_AppendPIWInfo() || Error: Honoraria could not be located. || Meeting: #MeetingCodeValue# || Record: #h#">
						<cfelseif #GetHonoraria.attendee_comp# EQ "">
							<cfscript>addToErrorArray(h,26);</cfscript>
							<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckMeetingCode_AppendPIWInfo() || Error: Honoraria was empty string. || Meeting: #MeetingCodeValue# || Record: #h#">
						<cfelse>
							<cfset iHonoFee = #GetHonoraria.attendee_comp#>
						</cfif>
						<!----Set the Moderator Name to the Array--->
						<cfset gaDataCellsByRow[h][giHonorariaLocation] = #iHonoFee#>
						<cfset iHonoraria = #iHonoFee#>
						
					</cfif><!----End Meeting Count if------>
				</cfif><!----End MeetingCode match if----->
							
			</cfloop>
		<cfelse>
			<cfscript>addToErrorArray(h,1);</cfscript>
			<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: CheckMeetingCode() || Error: MeetingCode field was never located in header columns. || ERROR IS FATAL">
			<cfset gbFatalError = true>
		</cfif>
		
	</cffunction>

<!----***************************************************
Function: CheckForPreviousUpload()
Author: Matt Eaves
Description: Checks to ensure that this roster was not uploaded previously.  Do this at teh end because the data has to be formated and 
			 in the array to make a comparison to the database.
History: 12/09/02 - Created
**********************************************************---->	
	<cffunction name="CheckForPreviousUpload" hint="Ensures that this roster was not uploaded previously" access="public" output="no">
						
		<cfloop index="h" from="2" to="4" step="1"><!---- changed from 6 to 4 so i could let arthrotec rosters in ---Check the first 5 records to see if there are matches--->
		
			<cfset sMeetingCode = #trim(gaDataCellsByRow[h][giMeetingCodeLocation])#>
			<cfset sKey = #trim(gaDataCellsByRow[h][giKeyFldLocation])#>
								
			<CFQUERY DATASOURCE="#session.rosterdbs#" NAME="getDuplicates" USERNAME="#session.rosterdbu#" PASSWORD="#session.rosterdbp#">
				SELECT rowid 
				FROM roster 
				WHERE meetingcode = '#sMeetingCode#' AND keyfld = '#sKey#'	
			</cfquery>
					
		<cfif getDuplicates.recordcount>
			<cfscript>addToErrorArray(h,28);</cfscript>		
			<cfset gbFatalError = true>
		</cfif>
		
		</cfloop> 
				
	</cffunction>

<!----***************************************************
Function: getErrorArrayLength()
Author: Tom Swift
Description: Gets Error Array Length
History: 09/23/03 - Created
**********************************************************---->	
	<cffunction name="getErrorArrayLength" hint="" access="public" output="yes" returntype="boolean">
		
		<cfscript>aLength = getErrorArrayLen();</cfscript>	
		<cfreturn aLength>
				
	</cffunction>
	
<!----***************************************************
Function: DisplayMessage()
Author: Tom Swift
Description: Diplays Error Array
History: 09/23/03 - Created
**********************************************************---->	
	<cffunction name="DisplayErrors" hint="" access="public" output="yes" returntype="boolean">
		
		<!---  --->
		<cfscript>viewErrors();</cfscript>
		<!---  --->
		
						
		<cfreturn gbFatalError>
				
	</cffunction>


<!----***************************************************
Function: DisplayMessage()
Author: Matt Eaves
Description: Returns value of gbFatalError to GUI/Form Page.  Based on value, message is displayed.
History: 12/20/02 - Created
**********************************************************---->	
	<cffunction name="DisplayMessage" hint="Returns value of gbFatalError to GUI" access="public" output="yes" returntype="boolean">
		<cfreturn gbFatalError>		
	</cffunction>
	

<!----***************************************************
Function: GetFileName()
Author: Matt Eaves
Description: Returns the Log File Name to the form page so the user can link to it via an href.
History: 12/20/02 - Created
**********************************************************---->	
	<cffunction name="GetFileName" hint="Returns value of gbFatalError to GUI" access="public" output="yes" returntype="string">
						
		<cfreturn gsFileName>
				
	</cffunction>



<!----***************************************************
Function: GetMaxRow()
Author: Matt Eaves
Description: Grabs the Max(row_id) from roster table. Eventually will be printed to log file. Should data 
need to be backed out, use this number to do delete.
History: 12/20/02 - Created
**********************************************************---->	
	<cffunction name="GetMaxRow" hint="Set the max row id of the roster table to a global variable" access="public" output="no">
		<cftransaction>				
		<CFQUERY DATASOURCE="#session.rosterdbs#" NAME="getMaxRecord" USERNAME="#session.rosterdbu#" PASSWORD="#session.rosterdbp#">
			SELECT MAX(rowid) as LastRec FROM roster
		</cfquery>
		</cftransaction>
		<cfset giRosterMaxRow = #getMaxRecord.LastRec#>		
	</cffunction>



<!----***************************************************
Function: GetAllMeetings()
Author: Matt Eaves
Description: Because some meetings a recruiting company will handle may not appear in our PMS system,
			 we need to allow the user to remove those meeting from the array, so the 
			 CheckMeetingCode_AppendPIWInfo() does not throw an error and will allow upload.
History: 12/20/02 - Created
**********************************************************---->	
	<cffunction name="GetAllMeetings" hint="Returns value of gbFatalError to GUI" access="public" output="yes">
						
		<cfif #giMeetingCodeLocation# NEQ 0>
			
			<cfset aMeetingCodeArray = ArrayNew(1)>
			<cfloop index="h" from="2" to="#giRowCount#" step="1">
				<cfset MeetingCodeValue = #trim(gaDataCellsByRow[h][giMeetingCodeLocation])#>
				<cfset sMeetingCode = #Mid(MeetingCodeValue, 1, 9)#>
				<cfset aMeetingCodeArray[h-1] = #sMeetingCode#>
			</cfloop>
			<cfset temp = ArraySort(aMeetingCodeArray, "textnocase", "desc")>
			
			<cfreturn aMeetingCodeArray>
			
		<cfelse>
			<cfscript>addToErrorArray(h,29);</cfscript>
			<cfset gbFatalError = true>
		</cfif>
				
	</cffunction>



<!----***************************************************
Function: RemoveUnwantedMeetings()
Author: Matt Eaves
Description: User can selet certain meetings that they don't want to include in the upload.  This function removes meetings that
			 are not wanted by deleting entire row of the 2d global array that hold all of the data.
History: 12/20/02 - Created
**********************************************************---->	
	<cffunction name="RemoveUnwantedMeetings" hint="Deletes unwanted meetings" access="public" output="yes">
		<cfargument name="aCheckedMeetings" type="string" required="true"/>			
		
		<cfif #giMeetingCodeLocation# NEQ 0>
			<!---Set a temp var here because you can not manipulte the value of an array index. 
			We will be subtracting one from the total row count each time we delete a row---->
			<cfset iMaxRow = #giRowCount#>
			
			<!----Loop backwards to avoid trying to reference a deleted row.---->
			<cfloop index="h" from="#iMaxRow#" to="2" step="-1">
				<cfset MeetingCodeValue = #trim(gaDataCellsByRow[h][giMeetingCodeLocation])#>
				<cfset sMeetingCode = #Mid(MeetingCodeValue, 1, 9)#>
				<cfset iIsMatch = #ListFind(arguments.aCheckedMeetings, sMeetingCode, ",")#>
				<cfif iIsMatch NEQ 0>
					<cfset temp = #ArrayDeleteAt(gaDataCellsByRow, h)#>
					<!---Set the global varible of the row count to one less--->
					<cfset giRowCount = #giRowCount# - 1>
				</cfif>
			</cfloop>
			
		<cfelse>
			<cfscript>addToErrorArray(h,29);</cfscript>
			<cfset gbFatalError = true>
		</cfif>
				
	</cffunction>
	
<!----***************************************************
Function: TrimFields()
Author: Matt Eaves
Description: Trims fields before inserting into database
History: 12/20/02 - Created
**********************************************************---->	
	<cffunction name="TrimFields" hint="Trims fields before inserting into database" access="public" output="yes">
			
		<cfloop index="w" from="2" to="#giRowCount#" step="1">
			<cfloop index="e" from="1" to="#iTotalColumns#" step="1">
			
				<cfif #e# EQ #giStatusFieldLocation#>
					<cfif #Len(gaDataCellsByRow[w][giStatusFieldLocation])# GT 19>
						<cfset gaDataCellsByRow[w][giStatusFieldLocation] = #Left(gaDataCellsByRow[w][giStatusFieldLocation], 20)#>
					</cfif>
				</cfif>
				
				<!----Trim the Screener Fields----->
				<cfif #e# EQ #giScreener1Location#>
					<cfif #Len(gaDataCellsByRow[w][giScreener1Location])# GT 50>
						<cfset gaDataCellsByRow[w][giScreener1Location] = #Left(gaDataCellsByRow[w][giScreener1Location], 50)#>
					</cfif>
				</cfif>
				<cfif #e# EQ #giScreener2Location#>
					<cfif #Len(gaDataCellsByRow[w][giScreener2Location])# GT 50>
						<cfset gaDataCellsByRow[w][giScreener2Location] = #Left(gaDataCellsByRow[w][giScreener2Location], 50)#>
					</cfif>
				</cfif>
				<cfif #e# EQ #giScreener3Location#>
					<cfif #Len(gaDataCellsByRow[w][giScreener3Location])# GT 50>
						<cfset gaDataCellsByRow[w][giScreener3Location] = #Left(gaDataCellsByRow[w][giScreener3Location], 50)#>
					</cfif>
				</cfif>
				<cfif #e# EQ #giScreener4Location#>
					<cfif #Len(gaDataCellsByRow[w][giScreener4Location])# GT 50>
						<cfset gaDataCellsByRow[w][giScreener4Location] = #Left(gaDataCellsByRow[w][giScreener4Location], 50)#>
					</cfif>
				</cfif>
				<cfif #e# EQ #giScreener5Location#>
					<cfif #Len(gaDataCellsByRow[w][giScreener5Location])# GT 50>
						<cfset gaDataCellsByRow[w][giScreener5Location] = #Left(gaDataCellsByRow[w][giScreener5Location], 50)#>
					</cfif>
				</cfif>
				<cfif #e# EQ #giScreener6Location#>
					<cfif #Len(gaDataCellsByRow[w][giScreener6Location])# GT 50>
						<cfset gaDataCellsByRow[w][giScreener6Location] = #Left(gaDataCellsByRow[w][giScreener6Location], 50)#>
					</cfif>
				</cfif>
				<cfif #e# EQ #giScreener7Location#>
					<cfif #Len(gaDataCellsByRow[w][giScreener7Location])# GT 50>
						<cfset gaDataCellsByRow[w][giScreener7Location] = #Left(gaDataCellsByRow[w][giScreener7Location], 50)#>
					</cfif>
				</cfif>
				<cfif #e# EQ #giScreener8Location#>
					<cfif #Len(gaDataCellsByRow[w][giScreener8Location])# GT 50>
						<cfset gaDataCellsByRow[w][giScreener8Location] = #Left(gaDataCellsByRow[w][giScreener8Location], 50)#>
					</cfif>
				</cfif>
				<cfif #e# EQ #giScreener9Location#>
					<cfif #Len(gaDataCellsByRow[w][giScreener9Location])# GT 100>
						<cfset gaDataCellsByRow[w][giScreener9Location] = #Left(gaDataCellsByRow[w][giScreener9Location], 100)#>
					</cfif>
				</cfif>
				<cfif #e# EQ #giScreener10Location#>
					<cfif #Len(gaDataCellsByRow[w][giScreener10Location])# GT 50>
						<cfset gaDataCellsByRow[w][giScreener10Location] = #Left(gaDataCellsByRow[w][giScreener10Location], 50)#>
					</cfif>
				</cfif>
				<!----End trim of Screener Fields--->
				
				<!----Trim Email Address---->
				<cfif #e# EQ #giEmailLocation#>
					<cfif #Len(gaDataCellsByRow[w][giEmailLocation])# GT 80>
						<cfset gaDataCellsByRow[w][giEmailLocation] = #Left(gaDataCellsByRow[w][giEmailLocation], 80)#>
					</cfif>
				</cfif>
				
				<!----Trim City and Secondary Addresses.  Primary address fields are trimed in CheckAdress()----->
				<cfif #e# EQ #giShiptoAddr1Location#>
					<cfif #Len(gaDataCellsByRow[w][giShiptoAddr1Location])# GT 35>
						<cfset gaDataCellsByRow[w][giShiptoAddr1Location] = #Left(gaDataCellsByRow[w][giShiptoAddr1Location], 35)#>
					</cfif>
				</cfif>
				<cfif #e# EQ #giShiptoAddr2Location#>
					<cfif #Len(gaDataCellsByRow[w][giShiptoAddr2Location])# GT 35>
						<cfset gaDataCellsByRow[w][giShiptoAddr2Location] = #Left(gaDataCellsByRow[w][giShiptoAddr2Location], 35)#>
					</cfif>
				</cfif>
				<cfif #e# EQ #giShiptoaddr3Location#>
					<cfif #Len(gaDataCellsByRow[w][giShiptoaddr3Location])# GT 35>
						<cfset gaDataCellsByRow[w][giShiptoaddr3Location] = #Left(gaDataCellsByRow[w][giShipto_addr3Location], 35)#>
					</cfif>
				</cfif>
				<cfif #e# EQ #giShiptoCityLocation#>
					<cfif #Len(gaDataCellsByRow[w][giShiptoCityLocation])# GT 35>
						<cfset gaDataCellsByRow[w][giShiptoCityLocation] = #Left(gaDataCellsByRow[w][giShiptoCityLocation], 35)#>
					</cfif>
				</cfif>
				<cfif #e# EQ #giOfficeAddr1Location#>
					<cfif #Len(gaDataCellsByRow[w][giOfficeAddr1Location])# GT 35>
						<cfset gaDataCellsByRow[w][giOfficeAddr1Location] = #Left(gaDataCellsByRow[w][giOfficeAddr1Location], 35)#>
					</cfif>
				</cfif>
				<cfif #e# EQ #giOfficeAddr2Location#>
					<cfif #Len(gaDataCellsByRow[w][giOfficeAddr2Location])# GT 35>
						<cfset gaDataCellsByRow[w][giOfficeAddr2Location] = #Left(gaDataCellsByRow[w][giOfficeAddr2Location], 35)#>
					</cfif>
				</cfif>
				<cfif #e# EQ #giOfficeaddr3Location#>
					<cfif #Len(gaDataCellsByRow[w][giOfficeaddr3Location])# GT 35>
						<cfset gaDataCellsByRow[w][giOfficeaddr3Location] = #Left(gaDataCellsByRow[w][giOffice_addr3Location], 35)#>
					</cfif>
				</cfif>
				<cfif #e# EQ #giOfficeCityLocation#>
					<cfif #Len(gaDataCellsByRow[w][giOfficeCityLocation])# GT 35>
						<cfset gaDataCellsByRow[w][giOfficeCityLocation] = #Left(gaDataCellsByRow[w][giOfficeCityLocation], 35)#>
					</cfif>
				</cfif>
				
				
			</cfloop>
		</cfloop>
							
	</cffunction>


<!----***************************************************
Function: ConvertTimeBack()
Author: Matt Eaves
Description: Converts Time for Military format to sting format.  Ex. 10:30PM.
History: 12/09/02 - Created
**********************************************************---->	
	<cffunction name="ConvertTimeBack" hint="Converts Time from Military to String Format" access="public" output="yes">
						
		<cfif gbFatalError>
			<!---File has fatal errors, don't run any further code in this function.----->			
		<cfelse>
		
			<cfloop index="h" from="2" to="#giRowCount#" step="1">
				<cfset strMilitaryTime = #trim(gaDataCellsByRow[h][giTimeLocation])#>
								
				<!--- <cfset strCivilianHour = #Left(strMilitaryTime, 2)#> --->
				
				<cfif strMilitaryTime GTE 1000>
				<cfset strCivilianHour = #Left(strMilitaryTime, 2)#>
				<cfelse>
				<cfset strCivilianHour = #Left(strMilitaryTime, 1)#>
				</cfif>
				
				<cfset strCivilianMinute = #Mid(strMilitaryTime, 3, 2)#>
				<!--- <cfoutput>#strMilitaryTime# #strCivilianHour#  #strCivilianMinute#</cfoutput> --->
				<!-----Set the Minutes---->
				<cfset strMinute = "00">
				<cfif strCivilianMinute EQ "50">
					<cfset strMinute = "30">
				</cfif>
				
				<cfset strMinute = "00">
				<cfif strCivilianMinute EQ "50">
					<cfset strMinute = "30">
				</cfif>
			
				<cfset strHour = #strCivilianHour#>
								
				<!----If hour is < 12, the hour is the same. ex. 0100 == 1:00AM---->
				
			
				<cfset strMeridiem = "PM">
				
				<cfif #strHour# GT 12 AND #strHour# NEQ 24>
					<cfset strHour = #strHour# - 12>
				<cfelseif #strHour# GT 12 AND #strHour# EQ 24>
					<cfset strHour = #strHour# - 12>
					<cfset strMeridiem = "AM">
				<cfelseif #strHour# EQ 12>
					<cfset strMeridiem = "PM">
				<cfelse>
					<cfset strMeridiem = "AM">
				</cfif>
				
				
				<cfset CivTime = #strHour# & ":" & #strMinute# & #strMeridiem#>
				<cfset gaDataCellsByRow[h][giTimeLocation] = #CivTime#>		
			</cfloop>
		</cfif>
				
	</cffunction>


<!----***************************************************
Function: UploadData()
Author: Matt Eaves
Description: Uploads data to the server.
History: 11/26/02 - Created
**********************************************************---->	
	<cffunction name="UploadData" hint="Uploads data to the server" access="public" output="yes">
						
		<cfif gbFatalError>
			<!---File has fatal errors, don't run any further code in this function.----->
		<cfelse>
			<cfif gbUserAllowingUpload>
			<!-- <cftransaction> -->
				<cfloop index="w" from="2" to="#giRowCount#" step="1">
					<CFQUERY DATASOURCE="#session.rosterdbs#" NAME="getDuplicates" USERNAME="#session.rosterdbu#" PASSWORD="#session.rosterdbp#">
						INSERT INTO roster(
						<cfloop index="e" from="1" to="#iTotalColumns#" step="1">
							<cfoutput>
							<cfif #gaDataCellsByRow[1][e]# eq "SHIPTO_ADDR1">Shipto_Addr1
							<cfelseif #gaDataCellsByRow[1][e]# eq "SHIPTO_ADDR2">Shipto_Addr2
							<!--- <cfelseif #gaDataCellsByRow[1][e]# eq "SHIPTO_ADDR3">SHIPTO_ADDR3 --->
							<cfelseif #gaDataCellsByRow[1][e]# eq "SHIPTO_CITY">Shipto_City
							<cfelseif #gaDataCellsByRow[1][e]# eq "SHIPTO_STATE">Shipto_State
							<cfelseif #gaDataCellsByRow[1][e]# eq "SHIPTO_ZIPCODE">Shipto_Zipcode
							<cfelseif #gaDataCellsByRow[1][e]# eq "CET_PHONE">CET_Phone
							<cfelseif #gaDataCellsByRow[1][e]# eq "OFFICE_PHONE">Office_Phone
							<cfelseif #gaDataCellsByRow[1][e]# eq "OFFICE_ADDR1">Office_Addr1
							<cfelseif #gaDataCellsByRow[1][e]# eq "OFFICE_ADDR2">Office_Addr2
							<!--- <cfelseif #gaDataCellsByRow[1][e]# eq "OFFICE_ADDR3">OFFICE_ADDR3 --->
							<cfelseif #gaDataCellsByRow[1][e]# eq "SPECIALTY">Prime_Specialty  
							<cfelseif #gaDataCellsByRow[1][e]# eq "SALUTATION">Salutation
							<cfelseif #gaDataCellsByRow[1][e]# eq "DEGREE">Degree
							<cfelseif #gaDataCellsByRow[1][e]# eq "fax">Fax
							<cfelseif #gaDataCellsByRow[1][e]# eq "email">Email
							<cfelse>#gaDataCellsByRow[1][e]#
							</cfif>
							<cfif #e# NEQ #iTotalColumns#>,</cfif>
							</cfoutput>
						</cfloop>) 
						VALUES(
						<cfloop index="x" from="1" to="#iTotalColumns#" step="1">
							<cfif #x# NEQ #giDateLocation#>
								<cfif #x# NEQ #giHonorariaTypeLocation#>
									<cfif #x# NEQ #giUser1Location#>
										<cfif #x# NEQ #giUser3Location#>
											<cfif #x# NEQ #giUser6Location#>
												<cfif #x# NEQ #giPhidLocation#>
													<cfoutput>'#gaDataCellsByRow[w][x]#'<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
												<cfelse>
													<cfif #gaDataCellsByRow[w][x]# EQ "">
														<cfoutput>0<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
													<cfelse>
														<cfoutput>#gaDataCellsByRow[w][x]#<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
													</cfif>
												</cfif>
											<cfelse>
												<cfif #gaDataCellsByRow[w][x]# EQ "">
													<cfoutput>NULL<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
												<cfelse>
													<cfoutput>#gaDataCellsByRow[w][x]#<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
												</cfif>
											</cfif>
										<cfelse>
											<cfif #gaDataCellsByRow[w][x]# EQ "">
												<cfoutput>NULL<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
											<cfelse>
												<cfoutput>#gaDataCellsByRow[w][x]#<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
											</cfif>
										</cfif>
									<cfelse>
										<cfif #gaDataCellsByRow[w][x]# EQ "">
											<cfoutput>NULL<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
										<cfelse>
											<cfoutput>#gaDataCellsByRow[w][x]#<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
										</cfif>
									</cfif>
								<cfelse>
									<cfif #gaDataCellsByRow[w][x]# EQ "">
										<cfoutput>NULL<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
									<cfelse>
										<cfoutput>#gaDataCellsByRow[w][x]#<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
									</cfif>
								</cfif>
							<cfelse>
								<cfif #gaDataCellsByRow[w][x]# EQ "">
									<cfoutput>NULL<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
								<cfelse>
									<cfoutput>#gaDataCellsByRow[w][x]#<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
								</cfif>				
							</cfif>
						</cfloop>)	
					</cfquery>
				</cfloop>
				<!-- </cftransaction> -->
				<cfset TotalRecordsAdded = #giRowCount# - 1>
				<cfoutput><br><br></cfoutput>
				<!--- <cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: UploadData() || File upload was successful.">
				<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="#TotalRecordsAdded# records added to roster table in CBARoster.">
				<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="#giRosterMaxRow# was the Max(rowid) before new data was uploaded.">
			 --->
			<cfelse><!---User is not allowing upload and only wants to see data in table format or psuedo SQL statments.---->
				
				<table border="1" cellpadding="3px" cellspacing="0">
					<cfloop index="w" from="1" to="#giRowCount#" step="1">
						<tr>
							<cfloop index="e" from="1" to="#iTotalColumns#" step="1">
									<td>#gaDataCellsByRow[w][e]#
									<cfif #gaDataCellsByRow[w][e]# eq "">&nbsp;</cfif>
									</td>
							</cfloop>
						</tr>
					</cfloop>
				</table>
				<!--- <cfloop index="w" from="2" to="#giRowCount#" step="1">
					INSERT INTO roster(
					<cfloop index="e" from="1" to="#iTotalColumns#" step="1">
						<cfoutput>#gaDataCellsByRow[1][e]#<cfif #e# NEQ #iTotalColumns#>,</cfif></cfoutput>
					</cfloop>) 
					VALUES(
					<cfloop index="x" from="1" to="#iTotalColumns#" step="1">
						<cfif #x# NEQ #giDateLocation#>
							<cfif #x# NEQ #giHonorariaTypeLocation#>
								<cfif #x# NEQ #giUser1Location#>
									<cfif #x# NEQ #giUser3Location#>
										<cfif #x# NEQ #giUser6Location#>
											<cfif #x# NEQ #giPhidLocation#>
												<cfoutput>'#gaDataCellsByRow[w][x]#'<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
											<cfelse>
												<cfif #gaDataCellsByRow[w][x]# EQ "">
													<cfoutput>NULL<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
												<cfelse>
													<cfoutput>#gaDataCellsByRow[w][x]#<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
												</cfif>
											</cfif>
										<cfelse>
											<cfif #gaDataCellsByRow[w][x]# EQ "">
												<cfoutput>NULL<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
											<cfelse>
												<cfoutput>#gaDataCellsByRow[w][x]#<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
											</cfif>
										</cfif>
									<cfelse>
										<cfif #gaDataCellsByRow[w][x]# EQ "">
											<cfoutput>NULL<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
										<cfelse>
											<cfoutput>#gaDataCellsByRow[w][x]#<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
										</cfif>
									</cfif>
								<cfelse>
									<cfif #gaDataCellsByRow[w][x]# EQ "">
										<cfoutput>NULL<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
									<cfelse>
										<cfoutput>#gaDataCellsByRow[w][x]#<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
									</cfif>
								</cfif>
							<cfelse>
								<cfif #gaDataCellsByRow[w][x]# EQ "">
									<cfoutput>NULL<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
								<cfelse>
									<cfoutput>#gaDataCellsByRow[w][x]#<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
								</cfif>
							</cfif>
						<cfelse>
							<cfif #gaDataCellsByRow[w][x]# EQ "">
								<cfoutput>NULL<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
							<cfelse>
								<cfoutput>#gaDataCellsByRow[w][x]#<cfif #x# NEQ #iTotalColumns#>,</cfif></cfoutput>
							</cfif>				
						</cfif>
					</cfloop>)
				<p>&nbsp;</p>
				</cfloop> 
				<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="Function: UploadData() || User choose to view data only.  No upload was performed.">
				<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="#TotalRecordsAdded# records are contained in the file.">
				<cffile action="append" file="#gsFullFilePath#" addNewLine="Yes" output="#giRosterMaxRow# is the Max(rowid).">
				
				--->
				<cfset TotalRecordsAdded = #giRowCount# - 1>
				
			</cfif>
		</cfif>
				
	</cffunction>
	
	<!----***************************************************
Function: getMaxId / getTotalRows
Author: Tom Swift
Description: Returns MAX rowid and # of rows added
History: 09/23/03 - Created
**********************************************************---->	
	<cffunction name="getMaxId" hint="" access="public" output="yes">
		<cftransaction>				
		<CFQUERY DATASOURCE="#session.rosterdbs#" NAME="getMaxRecord" USERNAME="#session.rosterdbu#" PASSWORD="#session.rosterdbp#">
			SELECT MAX(rowid) as FinalRec FROM roster
		</cfquery>
		</cftransaction>
			
		<cfreturn #getMaxRecord.FinalRec# >
				
	</cffunction>
	
	<cffunction name="getTotalRows" hint="" access="public" output="yes">	
		<cfset maxRowCount = #giRowCount# - 1>
		<cfreturn maxRowCount>
				
	</cffunction>

	
</cfcomponent>