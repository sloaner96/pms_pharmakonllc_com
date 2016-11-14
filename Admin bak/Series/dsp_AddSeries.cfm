


<cfset qcorp = Request.Util.getCompany()>
<cfparam name="URL.E" default="0">
<cfparam name="URL.Corp" default="">
<cfparam name="URL.client" DEFAULT="">
<cfparam name="URL.product" DEFAULT="">

<cfmodule template="#Application.tagpath#/ctags/header.cfm" title="Add New Program Series" showCalendar="1" bodyPassthrough="onLoad='init()'" doAjax="True">
<br>
<script language="javascript">
	function getClient()
	{
		var Company = DWRUtil.getValue("company");
		DWREngine._execute(_cfscriptPMSLocation, null, 'getclient', Company, ClientResult);
	}
	
	function ClientResult(clientArray)
	{
		DWRUtil.removeAllOptions("client");
		DWRUtil.addOptions("client", clientArray, "KEY", "VALUE");
		getProduct(); 
	}
    
	function getProduct()
	{
		 
		var Client = DWRUtil.getValue("client");
		DWREngine._execute(_cfscriptPMSLocation, null, 'Productlookup', Client, ProductResults);
	}
	
	function ProductResults(productArray)
	{
		DWRUtil.removeAllOptions("products");
		DWRUtil.addOptions("products", productArray, "KEY", "VALUE");
	}
	
	function init()
	{
		DWRUtil.useLoadingMessage();
		DWREngine._errorHandler =  errorHandler;
		getClient();
		getProduct();

	}
				
  </script>
<cfoutput>
    <cfform name="projseries" action="act_maintainSeries.cfm?action=ADD" method="POST">
        
		    <div style="color:##CC0000;">* All Fields Required</div><br>
			<cfif url.E EQ 1>
			    <div style="color:##CC2200; font-weight:bold;" align="center">Error! You Must Select a Selling Company.</div><br>
			<cfelseif url.E EQ 2>
			    <div style="color:##CC2200; font-weight:bold;" align="center">Error! You Must Select a Client Company.</div><br>
			<cfelseif url.E EQ 3>
			    <div style="color:##CC2200; font-weight:bold;" align="center">Error! You Must Select a Client Product.</div><br>
			<cfelseif url.E EQ 4>
			   <div style="color:##CC2200; font-weight:bold;" align="center">Error! You Must Enter a Series Name.</div><br>
			<cfelseif url.E EQ 4>
			   <div style="color:##CC2200; font-weight:bold;" align="center">Error! You Must Enter a Starting Date for this Series.</div><br>
			</cfif>
		    <table border="0" cellpadding="4" cellspacing="0">
               <tr>
			     <td><strong <cfif URL.E EQ 1>style="color:##CC2200;"</cfif>>Select a Selling Company:</strong></td>
				 <td><select name="company" onchange="getClient()">
						<cfloop query="qcorp">
						<option value="#trim(qcorp.corp_abbrev)#" <cfif trim(qcorp.corp_abbrev) is trim(url.corp)>Selected</cfif>>#trim(qcorp.corp_value)#
						</cfloop>
				     </select>
				 </td>
			  </tr>
			  <tr>
			     <td><strong>Select a Client:</strong></td>
				 <td>
				   <select name="client" id="client" style="vertical-align:top;"  onchange="getProduct();"></select>
				 </td>
			  </tr>
			  <tr>
			     <td><strong>Select a Product:</strong></td>
				 <td>
				   <select name="products" id="products" style="vertical-align:top;"></select>
				 </td>
			  </tr>
			  <tr>
			     <td><strong <cfif URL.E EQ 4>style="color:##CC2200;"</cfif>>Series Name:</strong></td>
				 <td><cfinput type="text" name="serieslabel" passthrough='id="serieslabel"' size="30" maxlength="90" required="YES" message="You must enter a Series Name"></td>
			  </tr>
			  <tr>
			     <td><strong <cfif URL.E EQ 5>style="color:##CC2200;"</cfif>>Series Starting Date:</strong></td>
				 <td><cfinput type="text" 
						    name="seriesStartdate" 
							passthrough='id="seriesStartdate" 
							style="font-size:11px;"' 
							value="" 
							size="10" maxlength="10" 
							required="YES"
							Message="You must include a start date for this Series"
							>&nbsp;
							<img src="/images/btn_formcalendar.gif" 
							    id="seriesStartbtn" 
								border="0" 
								alt="Click to view calendar" 
								onclick="Calendar.setup({inputField:'seriesStartdate' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'seriesStartbtn',singleClick:true,step:1})"></td>
			  </tr>
			  <tr>
			     <td><strong>Series End Date:</strong></td>
				 <td><cfinput type="text" 
						    name="seriesEnddate" 
							passthrough='id="seriesEnddate" 
							style="font-size:11px;"' 
							value="" 
							size="10" maxlength="10">&nbsp;
							<img src="/images/btn_formcalendar.gif" 
							    id="seriesEndbtn" 
								border="0" 
								alt="Click to view calendar" 
								onclick="Calendar.setup({inputField:'seriesEnddate' ,ifFormat:'%m/%d/%Y',showsTime:false,button:'seriesEndbtn',singleClick:true,step:1})"></td>
			  </tr>
			  <tr>
			    <td>&nbsp;</td>
			  </tr>
			  <tr>
			    <td colspan="2" align="center"><input type="submit" name="submit" value="Create Series and Add Programs >>"></td>
			  </tr>
			</table>           
  </cfform>	   
</cfoutput>     
<cfmodule template="#Application.tagpath#/ctags/footer.cfm">	
