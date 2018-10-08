function initRequest()
{
	if(window.XMLHttpRequest)
	{
		return new XMLHttpRequest();
	}
	else if(window.ActiveXObject)
	{
		return new ActiveXObject("Microsoft.XMLHTTP");
	}
}

function parseMessages(parseXML,flag)
{
	var resultObj	= document.getElementById(flag);
	var rootObj		= parseXML.getElementsByTagName("MainEntity");
	var cNode_1		= rootObj[0].childNodes.length;
	
	for(var i=0;i<parseInt(cNode_1);i++){
		resultObj.options[resultObj.options.length] = new Option(rootObj[0].childNodes[i].childNodes[1].childNodes[0].nodeValue,rootObj[0].childNodes[i].childNodes[0].childNodes[0].nodeValue);
	}
}