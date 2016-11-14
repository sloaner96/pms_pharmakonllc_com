<cfscript>
  /**
 * This function will return a phone string that has been formatted (aaa) bbb-cccc.
 * 
 * @param PhoneStr (Pass it a phone string)  
 * @return Returns a string. 
 *
 * @author Rich Sloan (rsloan@pharmakonllc.com) 
 * @version 1, April 11, 2005 
 */
 function FormatPhone(PhoneStr){
 	var phoneString = phoneStr;
	var FormattedPhoneString = "";
	var countrycode = "";
	var areacode = "";
	var prefix = "";
	var suffix = "";
	if (isNumeric(PhoneString)){
		if (Len(phoneString) LT 9){
		  return PhoneString;
		} else {
			  if (LEFT(PhoneString, 1) NEQ 1){
			     areacode = left(PhoneString, 3);
				 prefix = mid(PhoneString, 4, 3);
				 suffix = right(PhoneString, 4);
				 FormattedPhoneString = "("&AreaCode&")"&Chr(32)&Prefix&"-"&suffix;
				 return FormattedPhoneString;
			  } else {
		         countrycode = left(PhoneString,1);
				 areacode = mid(PhoneString, 2, 3);
				 prefix = mid(PhoneString, 5, 3);
				 suffix = right(PhoneString, 4);
				 FormattedPhoneString = countrycode&"-"&"("&AreaCode&")"&Chr(32)&Prefix&"-"&suffix;
				 return FormattedPhoneString;
		      }
		} 
	} else {
	  msg = "Error! The String is not numeric!!"; 
	  return msg;
	}
 }
</cfscript>