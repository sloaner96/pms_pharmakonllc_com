<cfscript>
/**
 * This function will return a string that has been cleaned of all non-alphanumeric characters.
 * 
 * @param Str (Pass it a string that has special characters)  
 * @param allowstr (pass a list of character you want to keep)
 * @return Returns a string. 
 *
 * @author Rich Sloan (rsloan@pharmakonllc.com) 
 * @version 1, March 24, 2005 
 */
function CleanString(str, allowstr){
	var stringToClean = str;
	var allowtmp = allowstr;
	var allowString = ListToArray(allowstr);
	var excludelist = "~,`,!,@,##,$,%,^,&,*,(,),-,_,=,+,{,},[,],\,|,;,:,',?,/,.,>,<,#Chr(32)#,#chr(34)#,#chr(44)#,#chr(145)#,#chr(146)#,#chr(147)#,#chr(148)#";
	var CleanString = "";
	
	if (arrayLen(allowString) GT 1){
		for (x = 1; x lte ArrayLen(allowString); x = x + 1){
				excludelist = ListDeleteAt(excludelist, ListFindnocase(excludelist, allowString[x], ","),",");
	    } 
	 } else {
	    excludelist = ListDeleteAt(excludelist, ListFindnocase(excludelist, allowtmp, ","),",");

	}
	CleanString = REReplace(str, "[^[:print:]]", "", "ALL");
	CleanString = ReplaceList(CleanString, excludelist, "");
	return CleanString;
}

</cfscript>