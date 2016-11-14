<!-- Dynamic Version by: Nannette Thacker -->
<!-- http://www.shiningstar.net -->
function textCounter(field, cntfield, maxlimit) 
{
	if (field.value.length > maxlimit) // if too long...trim it!
	{
		alert('Sorry, you are over the allotted characters for this field!');
		field.value = field.value.substring(0, maxlimit);
	}// otherwise, update 'characters left' counter
	else
	{
		cntfield.value = maxlimit - field.value.length;
	}
}