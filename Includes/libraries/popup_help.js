// Used to Popup Help Files.  Function takes the page as a parameter.


function OpenWindow(sPage)
{
	var pageParameters = 'height=300,width=400,toolbar=0,status=no,resizable=no,scrollbars=yes'
	var winName = ''
	window.open(sPage, winName, pageParameters);
}