function confirmSubmit()
{
var msg=confirm(
"\nIf you proceed to exit entering PIW information please\n" +
"Click on edit form to finish the form you are exiting.\n\n" +
"When editing a form please enter the Project Code to \n" +
"further edit or finish a PIW form!!!\n\n"+
"Do you wish to exit?");
if (msg)
	return true ;
else
	return false ;
}
