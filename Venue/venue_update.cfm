<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Venue Update Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<cfquery name="getVenues" datasource="#session.solvaydbs#" username="#session.solvaydbu#" password="#session.solvaydbp#">
	SELECT loc_type, loc_name, loc_address1, loc_address2, loc_city, loc_state, loc_zipcode, 
	loc_phone, loc_contact, rowid
	FROM meeting 
	WHERE status IN (8,9,10) AND
	loc_name != '' AND
	year(eventdate1) IN (2001,2002)
	AND loc_venue_id = ''
</cfquery>

<cfoutput>#getVenues.recordcount#</cfoutput>
<!------
<cfoutput query="getVenues">

	<cfquery name="insertVenues" DATASOURCE="#application.speakerDSN#">
		INSERT INTO venues(venue_name, venue_type, venue_address1, venue_address2, venue_city, venue_state, venue_zip, venue_phone, venue_contact) 
		VALUES('#getVenues.loc_name#', '#getVenues.loc_type#', '#getVenues.loc_address1#', '#getVenues.loc_address2#', '#getVenues.loc_city#', '#getVenues.loc_state#', '#getVenues.loc_zipcode#', '#getVenues.loc_phone#', '#getVenues.loc_contact#')
	</cfquery>
	
	<cfquery name="GetMaxID" DATASOURCE="#application.speakerDSN#">
		SELECT MAX(venue_id) as InsertedLast FROM venues
	</cfquery>
	
	<cfquery name="UpdateMeetingLoc" datasource="#session.solvaydbs#" username="#session.solvaydbu#" password="#session.solvaydbp#">
		UPDATE meeting SET loc_venue_id = #GetMaxID.InsertedLast# WHERE rowid = #getVenues.rowid#
	</cfquery>
	
</cfoutput>
------>
Good Job!
</body>
</html>
