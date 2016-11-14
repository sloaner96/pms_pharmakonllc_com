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
	var isFull = checkforblanks(
					document.form.product.value, "the project's product",
					document.form.guide_topic.value, "the project's guide topic / headline",
					document.form.recruiting_company_phone.value, "the recruiting company's 800 number",
					document.form.helpline.value, "the conference company's helpline number");
					)				
					
	if (!isFull)
		{return false;}
	}


