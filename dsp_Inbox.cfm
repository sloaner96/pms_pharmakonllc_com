<cfsilent>
<!---
	*****************************************************************************************
	Name:		Dsp_Inbox.cfm 04/26/2005

	Function:	Displays project codes and related data in a list with links to various functions.

	History:	rws030805-  Changed to use Program Series Code

	*****************************************************************************************
--->
<cfif IsDefined("Session.Project_code") AND Not ISDefined("URL.CompCode")>
  <cfset URL.CompCode = "#Left(Session.Project_Code, 1)#">
  <cfset URL.ClientCode = "#Mid(Session.Project_Code, 2, 2)#">

  <cfinvoke component="pms.com.projects" method="getClientSeries" returnvariable="SetSeries">
	<cfinvokeargument name="SellingCompany" value="#url.CompCode#">
	<cfinvokeargument name="ClientCode" value="#url.ClientCode#">
  </cfinvoke>

  <cfif SetSeries.Recordcount GT 0>
    <cfset URL.Series = SetSeries.SeriesID>
  </cfif>
</cfif>

<cfparam name="url.CompCode" default="" type="string">
<cfparam name="url.ClientCode" default="" type="string">
<cfparam name="url.Series" default="0" type="numeric">
<cfparam name="url.Status" default="2" type="string">

<cfset getCompanies = request.util.getCompany()>
		
</cfsilent>
<div class="inbox" id="inbox">
  <cfoutput query="getCompanies">
   <div class="inboxCompany" id="inboxCompany"><cfif url.CompCode NEQ trim(getCompanies.corp_abbrev)><a href="index.cfm?CompCode=#trim(getCompanies.corp_abbrev)#" style="text-decoration:none;font-weight:bold;">+</a><cfelse><a href="index.cfm" style="text-decoration:none;font-weight:bold;">-</a></cfif> #Trim(getCompanies.corp_value)#
		  <cfif URL.CompCode NEQ "" AND Trim(URL.CompCode) EQ trim(getCompanies.corp_abbrev)>
		     <cfset getClients = request.util.getCompanyClients(url.CompCode)>
			 <cfloop query="getClients">
			     <div class="inboxClient" id="inboxClient"><cfif trim(url.ClientCode) NEQ Trim(getClients.client_abbrev)><a href="index.cfm?CompCode=#trim(url.CompCode)#&ClientCode=#trim(getClients.client_abbrev)#" style="text-decoration:none;font-weight:bold;">+</a><cfelse><a href="index.cfm?CompCode=#trim(url.CompCode)#" style="text-decoration:none;font-weight:bold;">-</a></cfif> #getClients.client_name#
					   <cfif URL.ClientCode NEQ "" AND trim(url.ClientCode) EQ Trim(getClients.client_abbrev)>

						  <cfinvoke component="pms.com.projects" method="getClientSeries" returnvariable="getSeries">
						    <cfinvokeargument name="SellingCompany" value="#url.CompCode#">
							<cfinvokeargument name="ClientCode" value="#url.ClientCode#">
						  </cfinvoke>


						  <cfif getSeries.recordcount GT 0>


							  <cfloop query="getSeries">
								   <div class="inboxSeries" id="inboxSeries"><cfif trim(URL.Series) NEQ getSeries.SeriesID><a href="index.cfm?CompCode=#trim(url.CompCode)#&ClientCode=#trim(url.ClientCode)#&Series=#getSeries.SeriesID#" style="text-decoration:none;font-weight:bold;color:##fff;">+</a><cfelse><a href="index.cfm?CompCode=#trim(url.CompCode)#&ClientCode=#trim(url.ClientCode)#" style="text-decoration:none;font-weight:bold;color:##fff;">-</a></cfif> #getSeries.SeriesLabel# <font size="-2" face="arial">(Start Date:<cfif getSeries.SeriesBegin NEQ "">#DateFormat(getSeries.SeriesBegin, 'MM/DD/YYYY')#<cfelse>N/A</cfif> End Date: <cfif getSeries.SeriesEnd NEQ "">#DateFormat(getSeries.SeriesEnd, 'MM/DD/YYYY')#<cfelse>N/A</cfif>)</font>
									   <cfif URL.Series NEQ "" AND URL.Series EQ getSeries.SeriesID>

									      <cfinvoke component="pms.com.projects" method="getSeriesPrograms" returnvariable="getProjects">
											<cfinvokeargument name="SeriesID" value="#url.Series#">
											<cfinvokeargument name="Status" value="#trim(url.Status)#">
										  </cfinvoke>

										  <div class="inboxPrograms" id="inboxPrograms" align="center">
											    <div class="programActive" id="programActive"><cfif url.Status EQ 2>Active<cfelse><a href="index.cfm?CompCode=#trim(url.CompCode)#&ClientCode=#trim(url.ClientCode)#&Series=#getSeries.SeriesID#&Status=2" style="color:##fff;">Active</a></cfif></div>
											    <div class="programAccept" id="programAccept"><cfif url.Status EQ 1>Accepted<cfelse><a href="index.cfm?CompCode=#trim(url.CompCode)#&ClientCode=#trim(url.ClientCode)#&Series=#getSeries.SeriesID#&Status=1" style="color:##fff;">Accepted</a></cfif></div>
												<div class="programQuoted" id="programQuoted"><cfif url.Status EQ 0>Quoted<cfelse><a href="index.cfm?CompCode=#trim(url.CompCode)#&ClientCode=#trim(url.ClientCode)#&Series=#getSeries.SeriesID#&Status=0" style="color:##fff;">Quoted</a></cfif></div>
												<div class="programComplete" id="programComplete"><cfif url.Status EQ 5>Completed<cfelse><a href="index.cfm?CompCode=#trim(url.CompCode)#&ClientCode=#trim(url.ClientCode)#&Series=#getSeries.SeriesID#&Status=5" style="color:##fff;">Completed</a></cfif></div>
												<div class="programOnHold" id="programOnHold"><cfif url.Status EQ 3>On Hold<cfelse><a href="index.cfm?CompCode=#trim(url.CompCode)#&ClientCode=#trim(url.ClientCode)#&Series=#getSeries.SeriesID#&Status=3" style="color:##fff;">On Hold</a></cfif></div>
												<div class="programCancelled" id="programCancelled"><cfif url.Status EQ 4>Cancelled<cfelse><a href="index.cfm?CompCode=#trim(url.CompCode)#&ClientCode=#trim(url.ClientCode)#&Series=#getSeries.SeriesID#&Status=4" style="color:##fff;">Cancelled</a></cfif></div>
											   <cfif getProjects.recordcount GT 0>
												   <div class="inboxProjects" id="inboxProjects">
												        <cfswitch expression="#url.status#">
														  <cfcase value="0">
														     <cfset thisID = "programQuoted">
														  </cfcase>
														  <cfcase value="1">
														     <cfset thisID = "programAccept">
														  </cfcase>
														  <cfcase value="2">
														     <cfset thisID = "programActive">
														  </cfcase>
														  <cfcase value="3">
														     <cfset thisID = "programOnHold">
														  </cfcase>
														  <cfcase value="4">
														     <cfset thisID = "programCancelled">
														  </cfcase>
														  <cfcase value="5">
														     <cfset thisID = "programComplete">
														  </cfcase>
														</cfswitch>
													    <table border="0" cellpadding="3" cellspacing="1" width="99%" bgcolor="##EFEFEF" align="left">
														   <tr id="#ThisID#" class="color:##fff;" align="left">
														       <td>Program Code</td>
															   <td>Program Start</td>
															   <td>Description</td>
														   </tr>
														   <cfloop query="getProjects">
														     <tr bgcolor="##ffffff">
															   <td align="left" class="footer"><a href="/projects/dsp_reportPIW.cfm?project_code=#getProjects.project_Code#" class="footer">#getProjects.project_Code#</a></td>
															   <td align="left" class="footer">#DateFormat(getProjects.program_start, 'MM/DD/YYYY')#</td>
															   <td align="left" class="footer">#getProjects.description#</td>
															 </tr>
														   </cfloop>
														</table>
												   </div>
											   <cfelse>
											      <div width="90%" class="inboxProjects" id="inboxProjects" style="color:##8b0000;font-size:11px;">There are no programs with this Status</div>
											   </cfif>
										  </div>
									     </cfif>
								  </div>
							  </cfloop>
							 <cfelse>
						       <div class="inboxSeriesBlnk" id="inboxSeriesBlnk">No Program Series</div>
						     </cfif>
					    </cfif>

				 </div>
			 </cfloop>
		   </cfif>
  </div>
 </cfoutput>
</div>
<br><br>

