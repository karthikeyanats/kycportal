function clearObjects()
{
	var no_of_arguments = arguments.length;
	for(var i=0;i<no_of_arguments;i++)
	{
		var clearobj = document.getElementById(arguments[i]);
		if(clearobj != null)
		for(var i1=clearobj.options.length;i1>1;i1--)
		{
			clearobj[i1-1] = null;
		}
	}
}