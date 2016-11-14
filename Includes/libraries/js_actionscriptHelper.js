var isInternetExplorer = navigator.appName.indexOf("Microsoft") != -1;
// Handle all the FSCommand messages in a Flash movie.
function dateChooser_DoFSCommand(command, args) {
	var dateChooserObj = isInternetExplorer ? document.all.dateChooser : document.dateChooser;
	//
	// JS CODE HERE

	var2 = args.split("/");

	for (var i=0; i < var2.length; i++) {
		if(var2[i].length == 1)
		var2[i] = "0" + var2[i];

		if(var2[i].length == 4)
		var2[i] = var2[i].substring(2, 4);
	}

	strArgs = var2.join("/");

	document.getElementById('fiStartDate').value = strArgs;
	showhide('lStartDate');

}
function dateChooser2_DoFSCommand(command, args) {
	var dateChooserObj2 = isInternetExplorer ? document.all.dateChooser2 : document.dateChooser2;
	
	//JS CODE HERE
	
	var2 = args.split("/");

	for (var i=0; i < var2.length; i++) {
		if(var2[i].length == 1)
		var2[i] = "0" + var2[i];

		if(var2[i].length == 4)
		var2[i] = var2[i].substring(2, 4);
	}

	strArgs = var2.join("/");
	
	document.getElementById('fiEndDate').value = strArgs;
	showhide('lEndDate');

}
// Hook for Internet Explorer.
if (navigator.appName && navigator.appName.indexOf("Microsoft") != -1 && navigator.userAgent.indexOf("Windows") != -1 && navigator.userAgent.indexOf("Windows 3.1") == -1) {
	document.write('<script language=\"VBScript\"\>\n');
	document.write('On Error Resume Next\n');
	document.write('Sub dateChooser_FSCommand(ByVal command, ByVal args)\n');
	document.write('	Call dateChooser_DoFSCommand(command, args)\n');
	document.write('End Sub\n');
	document.write('</script\>\n');
	document.write('<script language=\"VBScript\"\>\n');
	document.write('On Error Resume Next\n');
	document.write('Sub dateChooser2_FSCommand(ByVal command, ByVal args)\n');
	document.write('	Call dateChooser2_DoFSCommand(command, args)\n');
	document.write('End Sub\n');
	document.write('</script\>\n');
}
