<link rel="stylesheet" type="text/css" media="all" href="/includes/styles/schedule.css" title="tas" />
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Weekly Breakdown Report" showCalendar="1">

		
<!--- <CFDEFAULTCASE> --->
	<SCRIPT SRC="/includes/libraries/CallCal.js"></SCRIPT>
	<SCRIPT SRC="/includes/libraries/confirm.js"></SCRIPT>
	<SCRIPT>
	function validate(f) 
	{			
		var sbdate = f.begin_date.value;
		var sedate = f.end_date.value;
		
		if (f.begin_date.value == "" || f.begin_date.value == " " || sbdate.length < 6)
		{
			alert("Please select a beginning date!"); 
			return false;
		}

		if (f.end_date.value == "" || f.end_date.value == " " || sedate.length < 6)
		{
			alert("Please select an ending date!"); 
			return false;
		}
		
		sbdate = sbdate.split("/"); //Break starting date into array
		sedate = sedate.split("/");  //Bread ending date inot array
		
		
		for(i=0; i<sbdate.length; i++)
		{
			sbdate[i] = parseInt(sbdate[i]) //turn all string into integers
		}
		
		for(j=0; j<sedate.length; j++)
		{
			sedate[j] = parseInt(sedate[j]) //turn all string into integers
		}
		
		
		if(sbdate[2] < sedate[2]) //begining year is less than ending year
		{
			return true;
		}
		else if(sbdate[2] == sedate[2]) //years are equal
		{
				if(sbdate[0] < sedate[0]) //begining month is less than ending month
				{
					if(sbdate[1] < sedate[1]) //begining day is less than ending day
					{
						return true;
					}
				}
				else if(sbdate[0] == sedate[0]) //begining month is equal to ending month
				{
					if(sbdate[1] <= sedate[1]) //begining day is less than or equal to ending day
					{
						return true;
					}
					else
					{
						alert("The Beginging Date is Later then the Ending Date!")
						return false;
					}
				}
				else //begining month is more than ending month in the same year
				{
					alert("The Beginging Date is Later then the Ending Date!")
					return false;
				}

		}
		else 
		{
			alert("The Beginging Date is Later then the Ending Date!");
			return false;
		}
		
	}
	</SCRIPT>
	</HEAD>
	<BODY>
		
	<FORM NAME="form" action="breakdown_proc.cfm" METHOD="post" onSubmit="return validate(this);">
		<TABLE ALIGN="Center" BORDER="0" CELLPADDING="3" CELLSPACING="1" WIDTH="400">
			<TR> 
				<TD CLASS="tdheader"><CFOUTPUT><font face="Verdana" color="000000">Select Start and End Dates</font></CFOUTPUT></TD>
			</TR>
			<TR> 
				<TD>	<!--- Table containing input fields --->
					<TABLE ALIGN="Center" WIDTH=300 CELLSPACING="0" CELLPADDING="5" BORDER="0">
					  <TR>
						 <TD colspan=2>&nbsp;</TD>
					  </TR>
					  <TR valign="middle">
						 <TD ALIGN=right><b>Beginning Date</b></td>
						 <td align=left><cfmodule template="#Application.TagPath#/ctags/CalInput.cfm" inputname="begin_date" htmlid="begin_date" formvalue="" imgid="begindatebtn"></TD>
					  </TR>
					  <TR>
						 <TD ALIGN=right><b>Ending Date</b></td>
						 <td align=left><cfmodule template="#Application.TagPath#/ctags/CalInput.cfm" inputname="end_date" htmlid="end_date" formvalue="" imgid="enddatebtn"></td>
					  </TR>
					  <TR>
						 <TD colspan=2>&nbsp;</TD>
					  </TR>
					  <TR>
				    	 <TD ALIGN="center"><INPUT TYPE="submit" NAME="submit" VALUE="Submit"></TD>
						 <TD ALIGN="center"><INPUT TYPE="reset" NAME="cancel" VALUE=" Cancel " onclick="javascript:history.back(-1);"></TD>
					  </TR>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
	 </form>
<!--- 	</CFDEFAULTCASE>
</CFSWITCH> --->
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">