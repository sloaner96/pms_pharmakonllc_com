<!---
	*****************************************************************************************
	Name:		PIWedit.cfm

	Function:	Is a frontpage for all EDITING procedures, depending on what they select via
				the radio button determines what they want to edit.
	History:	7/18/01, finalized code	TJS
				8/01/01, changed form handling, layout, and cancel method
				bj010402, changed selction from project code to client code
				ts011002, added black border around table - (old code saved as piwedit.old -
						  if changes are not wanted)
				lb012302, changed datasource to pull client_proj table from hourday
				bj040402 - 	removed project notes option form this page.
							This is now a separate option under 'projects' menu item.
				ts072803  - removed 'edit database info' moved to admin function page

	*****************************************************************************************
--->
<CFSET session.project_admin=0>
<CFPARAM NAME="URL.client" DEFAULT="">
<CFPARAM NAME="URL.action" DEFAULT="">

<link href="simple.css" rel="stylesheet" type="text/css">
<LINK REL="stylesheet" HREF="newStyle.css" TYPE="text/css">
<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Weekly Report Setup" showCalendar="0">

<CFSWITCH EXPRESSION="#URL.action#">
<!--- Default case to present edit selection form to user --->
	<CFCASE VALUE="go_edit">
		<CFSET session.client_code = form.client_code>
		<CFSET session.project_code = form.project_code>
		<CFOUTPUT><META HTTP-EQUIV="REFRESH" CONTENT="0; URL=#form.edit_action#"></CFOUTPUT>
	</CFCASE>
	<CFDEFAULTCASE>
		<CFSET session.project_status="">
		<cfset session.project_code="">
		<CFQUERY DATASOURCE="#application.projdsn#" NAME="qmt">
		select meeting_type_description, rtrim(meeting_type_value)  from meeting_type
		</CFQUERY>

		<CFQUERY DATASOURCE="#application.projdsn#" NAME="qstatus">
			SELECT DISTINCT (ps.codedesc) AS status_description,
			count(p.project_status) as counts, ps.codevalue as status_code
			FROM lookup ps, client_proj cp, piw p
			where ps. codegroup = 'PROJECTSTATUS' 
			AND ps.codevalue = cp.status
			and p.project_status = ps.codevalue
			and cp.client_code != 'czzzz'
			GROUP BY CodeDesc, CodeValue
			Order BY CodeDesc
		</CFQUERY>

<script language="JavaScript" type="text/javascript">
    <!--
      function ListFindNoCase(list, value)
      {
        var returnValue = -1;
        var i = 0;
        var delimiter = ',';
        var _tempArray = new Array();
        if(ListFindNoCase.arguments.length == 3) delimiter = ListFindNoCase.arguments[2];
        list = list.toLowerCase();
        value = value.toLowerCase();
        _tempArray = list.split(delimiter);
        for(i = 0; i < _tempArray.length; i++)
        {
          if(_tempArray[i] == value)
          {
            returnValue = i;
            break;
          }
        }
        return returnValue;
      };

      function toggleDisabled(form, bDisabled)
      {
        if(toggleDisabled.arguments.length < 3) return;
        for(var i = 2; i < toggleDisabled.arguments.length; i++)
        {
          element = form.elements[toggleDisabled.arguments[i]];
          if(element)
          {
            element.disabled = bDisabled;
            if(ListFindNoCase('input,textarea,select', element.tagName) != -1)
            {
              if(ListFindNoCase('checkbox,radio,button,submit,reset', element.type) == -1)
              {
                if(!element.enabledClass && !element.disabled) element.enabledClass = element.className;
                if(!element.disabledClass && element.disabled) element.disabledClass = element.className;
                element.className = (bDisabled) ? element.disabledClass : element.enabledClass;
                if(element.type.toLowerCase() == 'file' && element.reset)
                  element.reset();
              }
              if(element.type.toLowerCase() == 'select-one')
              {
                if(bDisabled)
                {
                  if(element.selectedIndex != -1)
                    element.defaultSelected = element.selectedIndex;
                  element.selectedIndex = -1;
                }
                else
                {
                  element.selectedIndex = element.defaultSelected;
                  element.defaultSelected = element.selectedIndex;
                }
              }
            }
          }
        }
        if(!bDisabled && ListFindNoCase('text,password,textarea,checkbox,radio,select-one,select-multiple,submit,reset,button', form.elements[toggleDisabled.arguments[2]].type) != -1) form.elements[toggleDisabled.arguments[2]].focus();
      }

      var getOptions = new Object();
	<cfloop query="qstatus">
	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qcc2">
		SELECT Distinct(cc.client_code), cc.client_code_description
		FROM client_code cc, client_proj cp
		WHERE cc.client_code = cp.client_code and cp.status = <cfoutput>#qstatus.status_code#</cfoutput> and cc.client_code != 'czzzz'
		order by cc.client_code_description
	</CFQUERY>
	getOptions['<cfoutput>#qstatus.status_code#</cfoutput>'] = 	[[['value', 0], ['text', 'Select a Product']], <cfloop query="qcc2">
	[['value', '<cfoutput>#trim(qcc2.client_code)#</cfoutput>'], ['text','<cfoutput>#trim(qcc2.client_code_description)#</cfoutput> - (<cfoutput>#trim(qcc2.client_code)#</cfoutput>)']]<cfif #qcc2.currentRow# NEQ #qcc2.RecordCount#>,</cfif></cfloop>];
	</cfloop>


	<CFQUERY DATASOURCE="#application.projdsn#" NAME="qclient_proj">
	  SELECT cp.status,rtrim(ltrim(cp.client_code)) as client_code,
	  rtrim(ltrim(cp.client_proj)) as client_proj, SUBSTRING(cp.client_proj, 8, 10) as description
	  FROM client_proj cp
	  where cp.status IN (SELECT DISTINCT(cp.status)
                           FROM lookup ps, client_proj cp, piw p
                           WHERE ps.codegroup = 'PROJECTSTATUS' 
                           AND ps.codevalue = cp.status
                           AND p.project_status = ps.codevalue
                           AND cp.client_code != 'czzzz')
      order by status, client_proj
	</CFQUERY>


	<cfscript>
	   // get the attributenames
   	attributes = ArrayNew(1);
   	attributes = ListToArray(qmt.ColumnList);

	   // make an array out of each column
	   columns = ArrayNew(1);
	   alen = ArrayLen(attributes);
	   for (i = 1; i lte alen; i = i + 1)
	      columns[i] = ListToArray(evaluate("ValueList(qmt.#attributes[i]#)"));

	   GoodArray = ArrayNew(2);
	   qcount = qmt.RecordCount;
	   ccount = ListLen(qmt.ColumnList);

	   // loop over the arrays and copy the row/column to column/row
	   for (i = 1; i lte qcount; i = i + 1) {
      		for (c = 1; c lte ccount; c = c + 1) {
        		GoodArray[i][c] = REReplace(columns[c][i],"'","","ALL");

	      }
	   }


	temp = "a";
	temp2 = "b";

	for(myCounter=1; myCounter LTE qclient_proj.RecordCount; myCounter = myCounter + 1)
	{
   		temp = #trim(qclient_proj.client_code[myCounter])#;
		if (temp NEQ temp2)
		{
			if (myCounter NEQ 1)
			{
				WriteOutput("];");
			}
			WriteOutput("getOptions['#trim(qclient_proj.status[myCounter])#']");
			WriteOutput("['#trim(qclient_proj.client_code[myCounter])#'] ");
			WriteOutput("= ");
			WriteOutput("[");
			WriteOutput("[");
			WriteOutput("['value', '#trim(qclient_proj.client_proj[myCounter])#']");
			WriteOutput(", ");
			WriteOutput("['text','");
			for (i = 1; i lte #ArrayLen(GoodArray)#; i = i + 1)
			{
			if (GoodArray[i][1]  EQ '#trim(qclient_proj.description[myCounter])#')

			writeoutput("#GoodArray[i][2]#");
			}
			WriteOutput(" - #trim(qclient_proj.client_proj[myCounter])#'");
			WriteOutput("]");
			WriteOutput("]");

		}
		else
		{
			WriteOutput(", ");

			WriteOutput("[");
			WriteOutput("['value', '#trim(qclient_proj.client_proj[myCounter])#']");
			WriteOutput(", ");
			WriteOutput("['text','");
			for (i = 1; i lte #ArrayLen(GoodArray)#; i = i + 1)
			{
			if (GoodArray[i][1]  EQ '#trim(qclient_proj.description[myCounter])#')

			writeoutput("#GoodArray[i][2]#");
			}
			WriteOutput(" - #trim(qclient_proj.client_proj[myCounter])#'");
			WriteOutput("]");
			WriteOutput("]");

		}
		if (myCounter EQ qclient_proj.RecordCount)
		{	WriteOutput("];");}
		temp2 = #trim(qclient_proj.client_code[myCounter])#;
	};

	</cfscript>

      function setOptions(oForm, oElement, oOptions)
      {
        if(!oOptions) oOptions = '';
        oElement.options.selectedIndex = -1;
        oElement.options.length = 0;
        toggleDisabled(oForm, (oOptions.length <= 1), oElement.id);
        for(var i = 0; i < oOptions.length; i++)
        {
          oElement.options.length = oElement.options.length + 1;
          for(var j = 0; j < oOptions[i].length; j++)
            oElement.options[i][oOptions[i][j][0]] = oOptions[i][j][1];
        }
      }

	function Verify ( form )
	{
	  // ** START **
	 if (form.project_status.value == "") {
		alert( "Please select a PROJECT STATUS." );
		return false ;
	  }
	 if (form.product.value == "") {
		alert( "Please select a PRODUCT CODE." );
		return false ;
	  }
	  if (form.project_code.value == "") {
	    alert( "Please select a PROJECT CODE." );
	    return false ;
	  }
	  // ** END **
	  return true ;
	}


	function showhide(id){
		if (document.getElementById){
			obj = document.getElementById(id);
			if (obj.style.display == "none")
			{
				obj.style.display = "";
			}
			else
			{
				obj.style.display = "none";
			}
		}
	}

//-->
</script>


<div class="main">
<FORM ACTION="rpt_weeklyReportsSetup.cfm?action=go_edit" METHOD="post" name="get_client" onsubmit="return Verify(this);">
<div class="wrap1">
	<div class="wrap2">
		<div class="wrap3">
			<div class="box">
				<strong>Project Code Select</strong>
				<div>
					<!--- create dynamically populated select boxes with this custom tag --->
					<select class="center" name="project_status" onChange="setOptions(this.form, this.form.product, getOptions[this[this.selectedIndex].value]); setOptions(this.form, this.form.project_code, null)" tabindex="1" accesskey=""><option value="">Select Project Status</option>
					<option value="">---------------</option>
					<cfoutput query="qstatus">
						<option value="#status_code#">#status_description#</option>
					</cfoutput>
					</select>
					<br /><br />
					<select class="center" name="client_code" id="product" tabindex="2" disabled="disabled" onChange="setOptions(this.form, this.form.project_code, getOptions[this.form.project_status.value][this[this.selectedIndex].value]); form.project_code.disabled=false;">
					</select>
					<br /><br />
					<select class="center" name="project_code" id="project_code" tabindex="3" disabled="disabled">
					</select>

				</div>
				<div>
					<INPUT TYPE="radio" NAME="edit_action" CHECKED VALUE="dsp_weeklyReportsSetup_view.cfm">
					View Weekly Reports Setup Information

				</div>
				<div>
					<INPUT TYPE="radio" NAME="edit_action" VALUE="dsp_weeklyReportsSetup_edit.cfm">
					Edit Setup Information for this project code
				</div>
				<div>
					<INPUT TYPE="radio" NAME="edit_action" VALUE="dsp_weeklyReportsSetup_add.cfm">
					Add Setup Information for this project code
				</div>
				<div>
					<INPUT TYPE="radio" NAME="edit_action" VALUE="dsp_weeklyReportsSetup_clone.cfm">
					Clone Selected Project Code's Setup Information to another Project Code (This code will be the 'source' for the next selected code)
				</div>
				<div>
					<INPUT TYPE="radio" NAME="edit_action" VALUE="act_weeklyReportsSetup_delete.cfm">
					Delete Setup Information for this project code
				</div>
			</div>
		</div>
	</div>
</div>
<br/>
<div class="wrap1">
	<div class="wrap2">
		<div class="wrap3">
			<div class="box">
					<p>
						<INPUT TYPE="submit" NAME="submit" VALUE="  Next ->  "  style="float:left;">
					</P>
					<p/>
			</div>
		</div>
	</div>
</div>
</form>

</div>
</CFDEFAULTCASE>
</CFSWITCH>
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">
