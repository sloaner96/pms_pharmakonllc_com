// Copywright 2000, Ben Packer
function checkforblanks()
	{
	for (var i = 0; i < arguments.length; i += 2)
		{
		if (!arguments[i])
			{alert("Please enter " + arguments[i+1] + ".");return false;}
		}
	return true;
	}

function validate()
	{
	// Make sure none of the required fields are empty
	var isFull = checkforblanks(document.form.target_audience.value, "the project's target audience",
					document.form.total_cert_honoraria.value, "the total certificate honoraria for this project",
					document.form.total_cash_honoraria.value, "the total cash honoraria for this project");
	if (!isFull)
		{return false;}
	}


