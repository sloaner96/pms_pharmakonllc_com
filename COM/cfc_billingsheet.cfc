<cfcomponent>
	<!--- <cffunction hint="pulls billing program info for a client" name="getProgram" access="public" returntype="query">
		<cfargument hint="stores 5 digit client code" name="client_code" type="string" required="true"/>
		<cfquery name="qbilling_select" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			SELECT p.project_code, p.honoraria_amt, p.honoraria_type, p.rate_amt, p.note, p.updated, p.updated_userid, p.rate_type, p.rowid, h.honoraria_name, r.rate_name
			FROM program_info p, honoraria_type h, rate_type r
			WHERE LEFT(p.project_code,5) = '#arguments.client_code#' AND p.honoraria_type *= h.honoraria_id AND p.rate_type *= r.rate_id  
			ORDER BY updated DESC
		</cfquery>	
		<cfreturn qbilling_select>		
	</cffunction> --->
	
	
		<cffunction hint="pulls other billing info for a client" name="getProgram" access="public" returntype="query">
		<cfargument hint="stores 5 digit client code" name="client_code" type="string" required="true"/>
		<cfquery name="qbilling_select" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			SELECT o.project_code, o.charge_type, o.cost_amt, o.sell_amt, o.note, o.updated, o.updated_userid, o.rowid, t.type_name1, o.cost_rate, o.sell_rate, o.vendor, o.quantity, o.updated_userid
			FROM other_charges o, other_charges_type t
			WHERE LEFT(o.project_code,5) = '#arguments.client_code#' AND o.charge_type *= t.type_id1
			ORDER BY updated DESC
		</cfquery>	
		<cfreturn qbilling_select>		
	</cffunction>
	
	<cffunction hint="pulls standard charges" name="getCosts" access="public" returntype="query">
		<cfquery name="qcosts" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			SELECT t.type_name1, t.charge, t.type_id1
			FROM other_charges_type t
			ORDER BY type_name1
		</cfquery>	
		<cfreturn qcosts>		
	</cffunction>
	
	
	<cffunction hint="Totals the program honoraria amount" name="totalHono" access="public" returntype="query">
		<cfargument hint="stores 5 digit client code" name="client_code" type="string" required="true"/>
		<cfquery name="qhonototal" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			SELECT Sum(p.honoraria_amt) AS honototal
			FROM program_info p
			WHERE LEFT(p.project_code,5) = '#arguments.client_code#'
		</cfquery>	
		<cfreturn qhonototal>		
	</cffunction>
	
	<cffunction hint="Totals the program meeting rate amount" name="totalRate" access="public" returntype="query">
		<cfargument hint="stores 5 digit client code" name="client_code" type="string" required="true"/>
		<cfquery name="qratetotal" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			SELECT Sum(p.rate_amt) AS ratetotal
			FROM program_info p
			WHERE LEFT(p.project_code,5) = '#arguments.client_code#'
		</cfquery>	
		<cfreturn qratetotal>		
	</cffunction>
	
	<cffunction hint="pulls billing honoraria info for a client" name="getHonoraria" access="public" returntype="query">
		<cfargument hint="stores 5 digit client code" name="client_code" type="string" required="true"/>
		<cfquery name="qhonoraria_select" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			SELECT s.project_code, s.rate_amt, s.note, s.updated, s.updated_userid, s.rowid
			FROM speaker_honoraria s
			WHERE LEFT(s.project_code,5) = '#arguments.client_code#'
			ORDER BY updated DESC
		</cfquery>	
		<cfreturn qhonoraria_select>		
	</cffunction>
	
	<cffunction hint="Totals the honoraria speaker rate amount" name="totalSpkr" access="public" returntype="query">
		<cfargument hint="stores 5 digit client code" name="client_code" type="string" required="true"/>
		<cfquery name="qspkrtotal" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			SELECT Sum(s.rate_amt) AS spkrtotal
			FROM speaker_honoraria s
			WHERE LEFT(s.project_code,5) = '#arguments.client_code#'
		</cfquery>	
		<cfreturn qspkrtotal>		
	</cffunction>
	
	<cffunction hint="pulls other billing info for a client" name="getOther" access="public" returntype="query">
		<cfargument hint="stores 5 digit client code" name="client_code" type="string" required="true"/>
		<cfquery name="qother_select" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			SELECT o.project_code, o.charge_type, o.cost_amt, o.sell_amt, o.note, o.updated, o.updated_userid, o.rowid, t.type_name1, o.cost_rate, o.sell_rate, o.vendor
			FROM other_charges o, other_charges_type t
			WHERE LEFT(o.project_code,5) = '#arguments.client_code#' AND o.charge_type *= t.type_id1
			ORDER BY updated DESC
		</cfquery>	
		<cfreturn qother_select>		
	</cffunction>
	
	<cffunction hint="Totals the other cost amount" name="totalCost" access="public" returntype="query">
		<cfargument hint="stores 5 digit client code" name="client_code" type="string" required="true"/>
		<cfquery name="qcostOther" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			SELECT Sum(o.cost_amt) AS costtotal
			FROM other_charges o
			WHERE LEFT(o.project_code,5) = '#arguments.client_code#'
		</cfquery>	
		<cfreturn qcostOther>		
	</cffunction>
	
	<cffunction hint="Totals the other sell amount" name="totalSell" access="public" returntype="query">
		<cfargument hint="stores 5 digit client code" name="client_code" type="string" required="true"/>
		<cfquery name="qsellOther" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			SELECT Sum(o.sell_amt) AS selltotal
			FROM other_charges o
			WHERE LEFT(o.project_code,5) = '#arguments.client_code#'
		</cfquery>	
		<cfreturn qsellOther>		
	</cffunction>
	
	<cffunction hint="Inserts new program totals" name="InsertProgram" access="public" output="false">
		<cfargument hint="stores project code" name="project_code" type="string" required="true"/>
		<cfargument hint="stores honoraria type" name="honoraria_type" type="numeric" required="true"/>
		<cfargument hint="stores honoraria amount" name="honoraria_amt" type="numeric" required="true"/>
		<cfargument hint="stores rate type of meeting cost " name="rate_type" type="numeric" required="true"/>
		<cfargument hint="stores meeting rate " name="rate_amt" type="numeric" required="true"/>
		<cfargument hint="stores program comments " name="note" type="string" required="false"/>
		<cfargument hint="stores todays date " name="today" type="date" required="true"/>
		<cfargument hint="stores userid " name="userid" type="numeric" required="true"/>
		<cfquery name="qInsertProgram" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			Insert into program_info (project_code, honoraria_type, honoraria_amt, rate_type, rate_amt, note, updated, updated_userid)  
			Values('#arguments.project_code#', #arguments.honoraria_type#, #arguments.honoraria_amt#, #arguments.rate_type#, 
		#arguments.rate_amt#, '#arguments.note#', #arguments.today#, #arguments.userid#)
		</cfquery>			
	</cffunction>
	
	<cffunction hint="Deletes program totals" name="DeleteProgram" access="public" output="false">
		<cfargument hint="stores rowid to be deleted" name="rowid" type="numeric" required="true"/>
		<cfquery name="qDeleteProgram" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			Delete other_charges where rowid=#arguments.rowid#
		</cfquery>			
	</cffunction>
	
	<cffunction hint="Inserts new Honoraria totals" name="InsertHonoraria" access="public" output="false">
		<cfargument hint="stores project code" name="project_code" type="string" required="true"/>
		<cfargument hint="stores speaker rate amount" name="rate_amt" type="numeric" required="true"/>
		<cfargument hint="stores honoraria comments " name="note" type="string" required="false"/>
		<cfargument hint="stores todays date " name="today" type="date" required="true"/>
		<cfargument hint="stores userid " name="userid" type="numeric" required="true"/>
		<cfquery name="qInsertHonoraria" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			Insert into speaker_honoraria (project_code, rate_amt, note, updated, updated_userid)  
	Values('#arguments.project_code#',  
		#arguments.rate_amt#, '#arguments.note#', #arguments.today#, #arguments.userid#)
		</cfquery>			
	</cffunction>
	
	<cffunction hint="Deletes honoraria totals" name="DeleteHonoraria" access="public" output="false">
		<cfargument hint="stores rowid to be deleted" name="rowid" type="numeric" required="true"/>
		<cfquery name="qDeleteHonoraria" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			Delete speaker_honoraria where rowid=#arguments.rowid#
		</cfquery>			
	</cffunction>
	
	<cffunction hint="Inserts new Other Costs totals" name="InsertOther" access="public" output="false">
		<cfargument hint="stores project code" name="project_code" type="string" required="true"/>
		<cfargument hint="stores other charge type" name="other_type" type="numeric" required="true"/>
		<cfargument hint="stores cost amount" name="cost_amt" type="numeric" required="true"/>
		<cfargument hint="stores sell amount" name="sell_amt" type="numeric" required="true"/>
		<cfargument hint="stores cost units " name="cost_units" type="numeric" required="true"/>
		<cfargument hint="stores sell units " name="sell_units" type="numeric" required="true"/>
		<cfargument hint="stores other costs comments " name="note" type="string" required="false"/>
		<cfargument hint="stores todays date " name="today" type="date" required="true"/>
		<cfargument hint="stores userid " name="userid" type="numeric" required="true"/>
		<cfquery name="qInsertOther" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			Insert into other_charges (project_code, charge_type, cost_amt, sell_amt, note, updated, updated_userid, cost_rate, sell_rate)  
	Values('#arguments.project_code#', #arguments.other_type#, 
		#arguments.cost_amt#, #arguments.sell_amt#, '#arguments.note#', #arguments.today#, #arguments.userid#, #arguments.cost_units#, #arguments.sell_units#)
		</cfquery>			
	</cffunction>
	
	<cffunction hint="Deletes Other Costs totals" name="DeleteOther" access="public" output="false">
		<cfargument hint="stores rowid to be deleted" name="rowid" type="numeric" required="true"/>
		<cfquery name="qDeleteOther" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			Delete other_charges where rowid=#url.rowid#
		</cfquery>			
	</cffunction>
	
	<cffunction hint="pulls client information" name="getClient" access="public" returntype="query">
		<cfargument hint="stores 5 digit client code" name="client_code" type="string" required="true"/>
		<cfquery name="qclient" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			SELECT cc.client_code_description, c.corp_value, cc.createdby, cc.createddate
			FROM client_code cc, corp c 
			WHERE cc.client_code = '#arguments.client_code#' AND c.corp_abbrev = '#LEFT(arguments.client_code,1)#'
		</cfquery>	
		<cfreturn qclient>		
	</cffunction>
	
	<cffunction hint="pulls account executive information" name="getAE" access="public" returntype="query">
		<cfargument hint="stores 5 digit client code" name="client_code" type="string" required="true"/>
		<cfquery name="qae" datasource="#session.dbs#" username="#session.dbu#" password="#session.dbp#">
			SELECT p.account_exec, p.account_supr, p.project_code
			FROM piw p
			WHERE LEFT(p.project_code,5) = '#arguments.client_code#'
		</cfquery>	
		<cfreturn qae>		
	</cffunction>
	
	<cffunction hint="Updates Program billing sheet row" name="UpdateProgram" access="public" output="false">
		<cfargument hint="stores project code" name="project_code" type="string" required="true"/>
		<cfargument hint="stores honoraria amount" name="honoraria_amt" type="numeric" required="true"/>
		<cfargument hint="stores honoraria type" name="honoraria_type" type="numeric" required="true"/>
		<cfargument hint="stores todays date" name="today" type="date" required="true"/>
		<cfargument hint="stores meeting rate amount " name="rate_amt" type="numeric" required="true"/>
		<cfargument hint="stores meeting rate type " name="rate_type" type="string" required="true"/>
		<cfargument hint="stores program billing comments " name="note" type="string" required="false"/>
		<cfargument hint="stores userid " name="userid" type="numeric" required="true"/>
		<cfargument hint="stores id of row to be updated " name="rowid" type="numeric" required="true"/>
		<cfquery name="qprogram_edit" datasource="#session.dbs#" dbtype="ODBC" username="#session.dbu#" password="#session.dbp#">
			Update program_info 
			Set project_code='#arguments.project_code#', honoraria_amt=#arguments.honoraria_amt#,
			honoraria_type=#arguments.honoraria_type#, updated=#arguments.today#, 
			rate_amt=#arguments.rate_amt#, rate_type='#arguments.rate_type#', note='#arguments.note#',
			updated_userid = #arguments.userid#
			Where program_info.rowid = #arguments.rowid#
		</cfquery>
			
	</cffunction>	
	
						
	
</cfcomponent>
