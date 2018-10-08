<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Student Mark Entry | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<SCRIPT language="JavaScript" src='<%=request.getContextPath()%>/js/Calendar/Calendar.js'></SCRIPT>
<script language="javascript">
function backfun()
{
	document.main_Form.action="./CircularView.jsp";
	document.main_Form.submit();
}
function calcalender(event)
{
	if(check_ForParticularElements(document.main_Form.start_date,"text"))
	{
		Calendar_Fun('/kycportal/js/Calendar/CalendarWindow.html','main_Form.end_date','0',event,'Not_Less_Than_StartDate',document.main_Form.start_date);
	}
}
function resetfun()
{
	document.resetform.submit();
}
upflag = false;
function addFeatures()
{
 	document.main_Form.btn_submit.disabled=true;
 	document.getElementById("circular_zone").deleteRow(0);
	tBody = document.createElement("tbody");
	tr = document.createElement("tr");
	tBody.appendChild(tr);
	td = document.createElement("td");
	td.colspan=4;
  	td.innerHTML ="<hr color='#EFEFE7'>";
	tr.appendChild(td);

	tr = document.createElement("tr");
	tBody.appendChild(tr);

	td = document.createElement("td");
	td.innerHTML ="<input type='radio' class='tabledivision' name='rad_course' value='Standard' onclick='call_byCourse()'><font class='tablelight'>Standard";
	tr.appendChild(td);

	td = document.createElement("td");
	td.innerHTML ="<input type='radio' class='tabledivision' name='rad_course' value='Role' onclick='call_byRole()'><font class='tablelight'>Role";
	tr.appendChild(td);

	td = document.createElement("td");
	td.innerHTML ="<input type='radio' class='tabledivision' name='rad_course' value='Individual' onclick='call_byIndividual()'><font class='tablelight'>Indivdual";
	tr.appendChild(td);

	document.getElementById("circular_zone").appendChild(tBody);
	//document.getElementById("divid").style.visibility="visible";
	document.getElementById("divid").style.display="block";
}
function call_byCourse()
{

	find_Year_Of_Session();
	submissionPart();
	doCompletion("year","year",document.getElementById("slt_year"));
	document.getElementById("slt_1").options[0] = new Option("------------Select Standard------------","00");
	document.getElementById("slt_2").options[0] = new Option("------------Selected Standard------------","00");
}

function call_byRole()
{
	if(document.getElementById("discussion_zone")!=null)
	{
		call_Delete_tables(document.getElementById("discussion_zone"));
	}
	tBody = document.createElement("tbody");

	tr = document.createElement("tr");
	tBody.appendChild(tr);

	td = document.createElement("td");
	td.innerHTML ="<hr color='#EFEFE7'>";
	td.colSpan=3;
	tr.appendChild(td);

	tr = document.createElement("tr");
	tBody.appendChild(tr);
	/*td = document.createElement("td");
	td.align="left";
	code="<select name='slt_institute' id='slt_institute'  style='width:200px' onchange='concatArg(\"department&instituteid=\",this.value,\"department\",document.getElementById(\"slt_department\"))'>";
	code=code+"<option>--Select--</option>";
	code=code+"</select>";

	td.innerHTML="<font class='tablebold'>&nbsp;Institution &nbsp;"+code;
	tr.appendChild(td);*/

	td = document.createElement("td");
	td.colSpan=2;
	td.align="center";
	code="<select name='slt_department' id='slt_department' style='width:200px' onchange='concatArg(\"role&departmentid=\",this.value,\"roles\",document.getElementById(\"slt_1\"))'>";
	code=code+"<option>--Select--</option>";
	code=code+"</select>";
	td.innerHTML="<font class='tablebold'>Department &nbsp;"+code;
	tr.appendChild(td);

    document.getElementById("discussion_zone").appendChild(tBody);
    submissionPart();
    doCompletion('department','department',document.getElementById("slt_department"));
    document.getElementById("slt_1").options[0] = new Option("-------------Select Role------------","00");
	document.getElementById("slt_2").options[0] = new Option("------------Selected Role------------","00");
}

function call_byIndividual()
{
	if(document.getElementById("discussion_zone")!=null)
	{
		call_Delete_tables(document.getElementById("discussion_zone"));
	}
	tBody = document.createElement("tbody");

	tr = document.createElement("tr");
	tBody.appendChild(tr);

	td = document.createElement("td");
	td.innerHTML ="<hr color='#EFEFE7'>";
	td.colSpan=3;
	tr.appendChild(td);

	tr = document.createElement("tr");
	tBody.appendChild(tr);

	td = document.createElement("td");
	td.align="center";
	td.innerHTML ="<input type='radio' name='rad_staff' value='staff' onclick='call_Individual_staff()'>&nbsp;<font class='tablelight'>Staff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='radio' name='rad_staff' value='student' onclick='call_Individual_student()'>&nbsp;<font class='tablelight'>Student";
	td.colSpan=3;
	tr.appendChild(td);
	document.getElementById("discussion_zone").appendChild(tBody);
}

function call_Individual_student()
{
	if(document.getElementById("discussion_zone")!=null)
	{
		 len=document.getElementById("discussion_zone").rows.length;
		 for(var i=len;i>2;i--)
		 {
			document.getElementById("discussion_zone").deleteRow(i-1);
		 }
	}
		tBody1 = document.createElement("tbody");
		tr = document.createElement("tr");
		tBody1.appendChild(tr);
		
		td = document.createElement("td");
		td.align="center";
		td.colSpan=3;
		table1 = document.createElement("table");
		td.appendChild(table1);
		tr.appendChild(td);
		
		tBody = document.createElement("tbody");
		tr = document.createElement("tr");
		tBody.appendChild(tr);
		
		td = document.createElement("td");
		td.align="center";
		td.innerHTML="<font class='tablebold'>&nbsp;&nbsp;&nbsp;Year of Session &nbsp;";
		tr.appendChild(td);
		
		td = document.createElement("td");
				code="<select name='slt_year' id='slt_year'  style='width:200px' onchange='concatArg(\"course1&yearid=\",this.value,\"course\",document.getElementById(\"slt_course\"))'>";
				code=code+"<option>--Select--</option>";
				code=code+"</select>";
		td.innerHTML=code;
		tr.appendChild(td);
		td = document.createElement("td");
		td.innerHTML="<font class='tablebold'>&nbsp;&nbsp;&nbsp;&nbsp;";
		td.align="center";
		tr.appendChild(td);
		td = document.createElement("td");
		td.align="center";
		
		td.innerHTML="<font class='tablebold'>Board &nbsp;";
		tr.appendChild(td);
		
		td = document.createElement("td");
			code="<select name='slt_board' id='slt_board'  style='width:200px' onchange=concatArg('standard&boardid=',this.value,'standard1',document.getElementById('slt_standard'))>";
			code=code+"<option>--Select--</option>";
			code=code+"</select>";
		td.align="center";
		td.innerHTML=code;
		tr.appendChild(td);
		
		tr = document.createElement("tr");
		tBody.appendChild(tr);
		td = document.createElement("td");
		td.align="center";
		td.innerHTML="<font class='tablebold'>Standard &nbsp;";
		tr.appendChild(td);
		
		td = document.createElement("td");
		code="<select name='slt_standard' id='slt_standard'  style='width:200px' onchange='concatArg(\"section&standardscheduleid=\",this.value,\"section\",document.getElementById(\"slt_section\"))'>";
		code=code+"<option>--Select--</option>";
		code=code+"</select>";
		td.innerHTML=code;
		tr.appendChild(td);
		td = document.createElement("td");
		td.innerHTML="<font class='tablebold'>&nbsp;&nbsp;&nbsp;&nbsp;";
		td.align="center";
		tr.appendChild(td);
		td = document.createElement("td");
		td.innerHTML="<font class='tablebold'>&nbsp;&nbsp;&nbsp;Section &nbsp;";
		td.align="center";
		tr.appendChild(td);
		td = document.createElement("td");
			code="<select name='slt_section' id='slt_section'  style='width:200px' onchange='concatArg(\"student&sectionscheduleid=\",this.value,\"student\",document.getElementById(\"slt_1\"))'>";
			code=code+"<option>--Select--</option>";
			code=code+"</select>";
		td.innerHTML=code;
		td.align="center";
		tr.appendChild(td);
		table1.appendChild(tBody);
		
	    document.getElementById("discussion_zone").appendChild(tBody1);
	    submissionPart();
	    doCompletion("year","year",document.getElementById("slt_year"));
	    document.getElementById("slt_1").options[0] = new Option("------------Select Student------------","00");
		document.getElementById("slt_2").options[0] = new Option("------------Selected Student------------","00");
}
function call_Individual_staff()
{
	if(document.getElementById("discussion_zone")!=null)
	{
		 len=document.getElementById("discussion_zone").rows.length;
		 for(var i=len;i>2;i--)
		 {
			document.getElementById("discussion_zone").deleteRow(i-1);
	 	 }
	}

	tBody = document.createElement("tbody");

	tr = document.createElement("tr");
	tBody.appendChild(tr);

	td = document.createElement("td");
	td.innerHTML ="<hr color='#EFEFE7'>";
	td.colSpan=3;
	tr.appendChild(td);

	tr = document.createElement("tr");
	tBody.appendChild(tr);
	/*td = document.createElement("td");
	td.align="left";

	code="<select name='slt_institute' id='slt_institute'    style='width:200px' onchange='concatArg(\"department&instituteid=\",this.value,\"department\",document.getElementById(\"slt_department\"))'>";
	code=code+"<option>--Select--</option>";
	code=code+"</select>";

	td.innerHTML="<font class='tablebold'>&nbsp;Institution &nbsp;"+code;
	tr.appendChild(td);*/

	td = document.createElement("td");
	td.colSpan=2;
	td.align="center";

	code="<select name='slt_department' id='slt_department'  style='width:200px' onchange='concatArg(\"staff&departmentid=\",this.value,\"staff\",document.getElementById(\"slt_1\"))'>";
	code=code+"<option>--Select--</option>";
	code=code+"</select>";
	td.innerHTML="<font class='tablebold'>Department &nbsp;"+code;
	tr.appendChild(td);
	document.getElementById("discussion_zone").appendChild(tBody);
	submissionPart();
    doCompletion('department','department',document.getElementById("slt_department"));
	document.getElementById("slt_1").options[0] = new Option("------------Select Staff------------","00");
	document.getElementById("slt_2").options[0] = new Option("------------Selected Staff------------","00");
	
}
function find_Year_Of_Session()
{
	if(document.getElementById("discussion_zone")!=null)
	{
		call_Delete_tables(document.getElementById("discussion_zone"));
	}

	tBody = document.createElement("tbody");

	tr = document.createElement("tr");
	tBody.appendChild(tr);

	td = document.createElement("td");
	td.innerHTML ="<hr color='#EFEFE7'>";
	td.colSpan=3;
	tr.appendChild(td);

	tr = document.createElement("tr");
	tBody.appendChild(tr);
	td = document.createElement("td");
	td.align="center";
	code="<select name='slt_year' id='slt_year'  style='width:200px' >";
	//onchange='concatArg(\"course1&yearid=\",this.value,\"course\",document.getElementById(\"slt_1\"))';
	code=code+"<option>--Select--</option>";
	code=code+"</select>";

	td.innerHTML="<font class='tablebold'>Year of Session &nbsp;"+code;
	tr.appendChild(td);
	
	td = document.createElement("td");
	td.align="center";
	td.colSpan=2;
	code="<select name='slt_board' id='slt_board'  style='width:200px' onchange=concatArg('standard&boardid=',this.value,'standard',document.getElementById('slt_1'))>";
	code=code+"<option>--Select--</option>";
	code=code+"</select>";

	td.innerHTML="<font class='tablebold'>Board &nbsp;"+code;
	tr.appendChild(td);

    document.getElementById("discussion_zone").appendChild(tBody);
}

function concatArg(val_1,val_2,check_var,result_object)
{
	len=result_object.length;
	
	for(var i=0;i<len;i++)
	{
 		result_object.options[1]=null;
	}
	/*if(result_object.name!="slt_1" && result_object.name!="slt_department")
	{
		result_object.options[result_object.options.length] = new Option("--Select--","");
	}*/
	if(val_2!="")
	{
		doCompletion(val_1+val_2,check_var,result_object);
	}
	/*if(document.getElementById("slt_1")!=null)
	{
		len=document.getElementById("slt_1").length;
		for(var i=0;i<len;i++)
		{
			document.getElementById("slt_1").options[0]=null;
		}
	}*/
}

function create_SelectBox(val,wid)
{
	code="<select name='"+val+"' id='"+val+"'  style='width:"+wid+"'>";
	code=code+"<option>--Select--</option>";
	code=code+"</select>";
	return code;
}

function call_Delete_tables(obj)
{
	 len=obj.rows.length;
	 for(i=0;i<len;i++)
	 {
		obj.deleteRow(obj.rows.length-1);
	 }
}

function submissionPart()
{
	tBody = document.createElement("tbody");

	tr = document.createElement("tr");
	tBody.appendChild(tr);

	td = document.createElement("td");
	td.colSpan=3;
   	td.innerHTML ="<hr color='#EFEFE7'>";
	tr.appendChild(td);

	tr = document.createElement("tr");
	tBody.appendChild(tr);

	td = document.createElement("td");
	td.align="center";
	td.rowSpan=4;
	var code="<select name='slt_1' id='slt_1' size=7 style='width:250px' onchange='flagSlt_Action()'>";
	
	code=code+"</select>";

	td.innerHTML =code;
	tr.appendChild(td);

	td = document.createElement("td");
	td.align="center";
	td.innerHTML ="<input type=button value='>' style='width:30' onclick='add_First()'>";
	tr.appendChild(td);

	td = document.createElement("td");
	td.align="center";
	td.rowSpan=4;
	code="<select name='slt_2' id='slt_2' size=7 style='width:250px' onchange='flagSlt_Action()'>";
	
	code=code+"</select>";

 	td.innerHTML =code;
	tr.appendChild(td);

	tr = document.createElement("tr");
	tBody.appendChild(tr);
	td = document.createElement("td");
	td.align="center";
	td.innerHTML ="<input type=button value='>>' style='width:30' onclick='add_All_First()'>";
	tr.appendChild(td);

	tr = document.createElement("tr");
	tBody.appendChild(tr);
	td = document.createElement("td");
	td.align="center";
	td.innerHTML ="<input type=button value='<' style='width:30' onclick='add_Second()'>";
	tr.appendChild(td);

	tr = document.createElement("tr");
	tBody.appendChild(tr);
	td = document.createElement("td");
	td.align="center";
	td.innerHTML ="<input type=button value='<<' style='width:30' onclick='add_All_Second()'>";
	tr.appendChild(td);

	document.getElementById("discussion_zone").appendChild(tBody);
}

function add_First()
{
	flag=false;
	if(document.main_Form.slt_1.selectedIndex!=0)
	{
		if(document.main_Form.slt_1.selectedIndex>-1)
		{
			for(var x=0;x<document.main_Form.slt_2.options.length;x++)
			{
				if(document.main_Form.slt_2.options[x].value==document.main_Form.slt_1[document.main_Form.slt_1.selectedIndex].value)
				{
					flag=true;
					document.main_Form.slt_1.options[document.main_Form.slt_1.selectedIndex]=null;	
				}
			}
			if(flag==false)
			{
					document.main_Form.slt_2.options[document.main_Form.slt_2.options.length] = new Option(document.main_Form.slt_1[document.main_Form.slt_1.selectedIndex].text,document.main_Form.slt_1[document.main_Form.slt_1.selectedIndex].value);
					document.main_Form.slt_1.options[document.main_Form.slt_1.selectedIndex]=null;
			}
		}	
	}
}
function add_All_First()
{
	len=document.main_Form.slt_1.options.length;
	for(var i=0;i<len;i++)
	{
			flag=false;
			if(document.main_Form.slt_1.options[1]!=null)
				{
						for(var x=0;x<document.main_Form.slt_2.options.length;x++)
						{
							if(document.main_Form.slt_1.options[1]!=null)
								{
									if(document.main_Form.slt_2.options[x].value==document.main_Form.slt_1.options[1].value)
									{
										flag=true;
										document.main_Form.slt_1.options[1]=null;
									}
								}
						}
						if(document.main_Form.slt_1.options[1]!=null)
						{
							if(!flag)
							{
								document.main_Form.slt_2.options[document.main_Form.slt_2.options.length] = new Option(document.main_Form.slt_1.options[1].text,document.main_Form.slt_1.options[1].value);
								document.main_Form.slt_1.options[1]=null;
							}
						}
				}
	}
}

function add_Second()
{
	flag=false
	if(document.main_Form.slt_2.selectedIndex!=0)
	{
	if(document.main_Form.slt_2.selectedIndex>-1)
	{
		for(var x=0;x<document.main_Form.slt_1.options.length;x++)
			{
			if(document.main_Form.slt_1.options[x].value==document.main_Form.slt_2[document.main_Form.slt_2.selectedIndex].value)
				{
					flag=true;
					document.main_Form.slt_2.options[document.main_Form.slt_2.selectedIndex]=null;	
				}
			}
			if(flag==false)
			{
				document.main_Form.slt_1.options[document.main_Form.slt_1.options.length] = new Option(document.main_Form.slt_2[document.main_Form.slt_2.selectedIndex].text,document.main_Form.slt_2[document.main_Form.slt_2.selectedIndex].value);
				document.main_Form.slt_2.options[document.main_Form.slt_2.selectedIndex]=null;
			}
	}
	}
}

function add_All_Second()
{
	len=document.main_Form.slt_2.options.length;
	for(var i=0;i<len;i++)
	{
		if(document.main_Form.slt_2.options[1]!=null)
			{
				flag=false;
				for(var x=0;x<document.main_Form.slt_1.options.length;x++)
				{
				if(document.main_Form.slt_2.options[1]!=null)
					{
						if(document.main_Form.slt_1.options[x].value==document.main_Form.slt_2.options[1].value)
							{
								flag=true;
								document.main_Form.slt_2.options[1]=null;
							}
					}
				}
				if(document.main_Form.slt_2.options[1]!=null)
				{
					if(flag==false)
					{
						document.main_Form.slt_1.options[document.main_Form.slt_1.options.length] = new Option(document.main_Form.slt_2.options[1].text,document.main_Form.slt_2.options[1].value);
						document.main_Form.slt_2.options[1]=null;
					}
				}
			}
	}
}

function validation_all()
{
	if(check_ForParticularElements(document.main_Form.subject,"text",document.main_Form.content,"textarea",document.main_Form.start_date,"text",document.main_Form.end_date,"text"))
	{

		var len=0;
		var value="";
		if(document.getElementById("slt_2")!=null && (len=document.getElementById("slt_2").options.length)>1 )
		{
			for(var i=0;i<len;i++)
			{
			if(document.getElementById("slt_2").options[i].value!="00")
			{
				value=value+document.getElementById("slt_2").options[i].value+",";
			}
			}
			if(len==2)
			{
			value=document.getElementById("slt_2").options[1].value;
			}
 			document.main_Form.recievers_id.value=value;
 			document.main_Form.start_date.value=splitDate(document.main_Form.start_date.value);
			document.main_Form.end_date.value=splitDate(document.main_Form.end_date.value);
 			document.main_Form.action="./CircularEntrySubmit.jsp";
			document.main_Form.submit();
		}
		else
		{
			alert("Please Specify to Whom this Circular is Send?");
		}
	}
}
function initRequest()
{
   if(window.XMLHttpRequest)
   {
	   return new XMLHttpRequest();
   }
   else if (window.ActiveXObject)
   {
 	   isIE = true;
	   return new ActiveXObject("Microsoft.XMLHTTP");
   }
}

function doCompletion(result_var,check_var,result_object)
{
if(check_var=="standard" || check_var=="standard1")
{
	result_var=result_var+"&yearid="+document.getElementById("slt_year").value;
}
//
	   var url = "getCircularInfo.jsp?action="+result_var;
//alert("========>>>>>>"+url);
  	   var req =initRequest();
 	   req.onreadystatechange = function()
	   {
		   if (req.readyState == 4)
		   {
//alert("========>>>>>>"+req.status);

 			   if (req.status == 200)
			   {
				  parseMessages(req.responseXML,check_var,result_object);
			   }
			   else if (req.status == 204)
			   {
			   }
		   }
	   };
	   req.open("GET", url, true);
	   req.send(null);
}

function parseMessages(parseXML,check_var,result_object)
{
//alert("check_var========>>>>>>"+check_var);
      if(check_var=="year")
      {
			var rootObj	= parseXML.getElementsByTagName("year");
 			var cNode_1	= rootObj[0].childNodes.length;

			for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp_id=rootObj[0].childNodes[i].childNodes[0].childNodes[0].nodeValue;
				var temp_name=rootObj[0].childNodes[i].childNodes[1].childNodes[0].nodeValue;
				result_object.options[result_object.options.length] = new Option(temp_name,temp_id);
				if(document.main_Form.hiddensession.value==temp_id)
					result_object.options[result_object.options.length-1].selected=true;
			}
		doCompletion("board","board",document.getElementById("slt_board"));
   	   }
   	  else if(check_var=="board")
      {
      
			var rootObj	= parseXML.getElementsByTagName("board");
 			var cNode_1	= rootObj[0].childNodes.length;
 			
			for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp_id=rootObj[0].childNodes[i].childNodes[0].childNodes[0].nodeValue;
				var temp_name=rootObj[0].childNodes[i].childNodes[1].childNodes[0].nodeValue;
				result_object.options[result_object.options.length] = new Option(temp_name,temp_id);
				if(document.main_Form.hiddenboard.value==temp_id && document.main_Form.rad_course[0].checked==true)
				{
					result_object.options[result_object.options.length-1].selected=true;
					concatArg('standard&boardid=',result_object.options[result_object.options.length-1].value,'standard',document.getElementById('slt_1'));
					eval(document.main_Form.hiddencode.value);
				}
				else if(document.main_Form.hiddenboard.value==temp_id && document.main_Form.rad_course[2].checked==true)
				{
					result_object.options[result_object.options.length-1].selected=true;
					concatArg('standard&boardid=',result_object.options[result_object.options.length-1].value,'standard1',document.getElementById('slt_standard'));
				}
				}
   	   }
   	   else if(check_var=="standard")
	   {
	   		result_object.options[0] = new Option("------------Select Standard------------","00");
	   		document.getElementById("slt_2").options[0] = new Option("------------Selected Standard------------","00");
	   		var rootObj	= parseXML.getElementsByTagName("standard");
 			var cNode_1	= rootObj[0].childNodes.length;
 			for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp_id=rootObj[0].childNodes[i].childNodes[0].childNodes[0].nodeValue;
				var temp_name=rootObj[0].childNodes[i].childNodes[1].childNodes[0].nodeValue;
				result_object.options[result_object.options.length] = new Option(temp_name,temp_id);
			}
   	   }
   	   else if(check_var=="standard1")
	   {
			var rootObj=parseXML.getElementsByTagName("standard");
 			var cNode_1=rootObj[0].childNodes.length;
			for(var i=0;i<parseInt(cNode_1);i++)
			{
				//var temp_id=rootObj[0].childNodes[i].selectSingleNode("semesterscheduleid").text;
				//var temp_name=rootObj[0].childNodes[i].selectSingleNode("semestername").text;
				var temp_id=rootObj[0].childNodes[i].childNodes[0].childNodes[0].nodeValue;
				var temp_name=rootObj[0].childNodes[i].childNodes[1].childNodes[0].nodeValue;
				result_object.options[result_object.options.length] = new Option(temp_name,temp_id);
				if(document.main_Form.hiddenstandard.value==temp_id && document.main_Form.rad_course[2].checked==true)
				{
					result_object.options[result_object.options.length-1].selected=true;
					concatArg('section&standardscheduleid=',result_object.options[result_object.options.length-1].value,'section',document.getElementById('slt_section'));
					//eval(document.main_Form.hiddencode.value);
				}
			}
   	   }
   	  /* else if(check_var=="role")
	   {
 			var rootObj=parseXML.getElementsByTagName("institute");
 			var cNode_1=rootObj[0].childNodes.length;
			
			for(var i=0;i<parseInt(cNode_1);i++)
			{
				//var temp_id=rootObj[0].childNodes[i].selectSingleNode("instituteid").text;
				//var temp_name=rootObj[0].childNodes[i].selectSingleNode("institutename").text;
				var temp_id=rootObj[0].childNodes[i].childNodes[0].childNodes[0].nodeValue;
				var temp_name=rootObj[0].childNodes[i].childNodes[1].childNodes[0].nodeValue;
				result_object.options[result_object.options.length] = new Option(temp_name,temp_id);
			}
   	   }*/
   	   else if(check_var=="department")
	   {
			var rootObj=parseXML.getElementsByTagName("department");
 			var cNode_1=rootObj[0].childNodes.length;
			for(var i=0;i<parseInt(cNode_1);i++)
			{
				//var temp_id=rootObj[0].childNodes[i].selectSingleNode("departmentid").text;
				//var temp_name=rootObj[0].childNodes[i].selectSingleNode("departmentname").text;
				var temp_id=rootObj[0].childNodes[i].childNodes[0].childNodes[0].nodeValue;
				var temp_name=rootObj[0].childNodes[i].childNodes[1].childNodes[0].nodeValue;
				
				result_object.options[result_object.options.length] = new Option(temp_name,temp_id);
				if(document.main_Form.hiddendepartment.value==temp_id && document.main_Form.rad_course[1].checked==true)
				{
					result_object.options[result_object.options.length-1].selected=true;
					concatArg('role&departmentid=',result_object.options[result_object.options.length-1].value,'roles',document.getElementById('slt_1'));
					eval(document.main_Form.hiddencode.value);
				}
				else if(document.main_Form.hiddendepartment.value==temp_id && document.main_Form.rad_course[2].checked==true)
				{
					result_object.options[result_object.options.length-1].selected=true;
					concatArg('staff&departmentid=',result_object.options[result_object.options.length-1].value,'staff',document.getElementById('slt_1'));
					eval(document.main_Form.hiddencode.value);
				}
			}
   	   }
   	   else if(check_var=="roles")
	   {
	  		result_object.options[0] = new Option("------------Select Role------------","00");
	   		document.getElementById("slt_2").options[0] = new Option("------------Selected Role------------","00");
	   		
			var rootObj=parseXML.getElementsByTagName("role");
 			var cNode_1=rootObj[0].childNodes.length;
			for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp_id=rootObj[0].childNodes[i].childNodes[0].childNodes[0].nodeValue;
				var temp_name=rootObj[0].childNodes[i].childNodes[1].childNodes[0].nodeValue;
				result_object.options[result_object.options.length] = new Option(temp_name,temp_id+"&"+document.main_Form.slt_department[document.main_Form.slt_department.selectedIndex].value);
			}
   	   }
   	   else if(check_var=="staff")
	   {
	   		result_object.options[0] = new Option("------------Select Staff------------","00");
	   		document.getElementById("slt_2").options[0] = new Option("------------Selected Staff------------","00");
			var rootObj=parseXML.getElementsByTagName("staff");
 			var cNode_1=rootObj[0].childNodes.length;
			for(var i=0;i<parseInt(cNode_1);i++)
			{
				//var temp_id=rootObj[0].childNodes[i].selectSingleNode("agentid").text;
				//var temp_name=rootObj[0].childNodes[i].selectSingleNode("personname").text;
 				var temp_id=rootObj[0].childNodes[i].childNodes[0].childNodes[0].nodeValue;
				var temp_name=rootObj[0].childNodes[i].childNodes[1].childNodes[0].nodeValue;
 				result_object.options[result_object.options.length] = new Option(temp_name,temp_id);
			}
   	   }
   	   else if(check_var=="student")
	   {
	   		result_object.options[0] = new Option("------------Select Student------------","00");
	   		document.getElementById("slt_2").options[0] = new Option("------------Selected Student------------","00");
			var rootObj=parseXML.getElementsByTagName("student");
 			var cNode_1=rootObj[0].childNodes.length;

			for(var i=0;i<parseInt(cNode_1);i++)
			{
				//var temp_id=rootObj[0].childNodes[i].selectSingleNode("studentid").text;
				//var temp_name=rootObj[0].childNodes[i].selectSingleNode("personname").text;
				var temp_id=rootObj[0].childNodes[i].childNodes[2].childNodes[0].nodeValue;
				var temp_name=rootObj[0].childNodes[i].childNodes[1].childNodes[0].nodeValue;
				result_object.options[result_object.options.length] = new Option(temp_name,temp_id);
			}
   	   }
   	    else if(check_var=="section")
	  	 {
			var rootObj=parseXML.getElementsByTagName("section");
 			var cNode_1=rootObj[0].childNodes.length;

			for(var i=0;i<parseInt(cNode_1);i++)
			{
				//var temp_id=rootObj[0].childNodes[i].selectSingleNode("studentid").text;
				//var temp_name=rootObj[0].childNodes[i].selectSingleNode("personname").text;
				var temp_id=rootObj[0].childNodes[i].childNodes[0].childNodes[0].nodeValue;
				var temp_name=rootObj[0].childNodes[i].childNodes[1].childNodes[0].nodeValue;
				result_object.options[result_object.options.length] = new Option(temp_name,temp_id);
				if(document.main_Form.hiddensection.value==temp_id && document.main_Form.rad_course[2].checked==true)
				{
					result_object.options[result_object.options.length-1].selected=true;
					concatArg('student&sectionscheduleid=',result_object.options[result_object.options.length-1].value,'student',document.getElementById('slt_1'));
					eval(document.main_Form.hiddencode.value);
				}
			}
   	   }
   	    else
   	   {
			alert("Key text doesn't match please contact Administrator");
	   }
}

function splitDate(date)
{
	var result_date="";
	var split_array = date.split("-");

	if(split_array.length==3)
	{
		result_date=result_date+split_array[2]+"-";
		result_date=result_date+getMonthValue(split_array[1])+"-";
		result_date=result_date+split_array[0];
		return result_date;
	}
	else
	{
		return date;
	}
}

function getMonthValue(val)
{
  switch(val)
  {
	 case "Jan":
	   val = "01";
	   break;
	 case "Feb":
	   val = "02";
	   break;
	 case "Mar":
	   val = "03";
	   break;
	 case "Apr":
	   val = "04";
	   break;
	 case "May":
	   val = "05";
	   break;
	 case "Jun":
	   val = "06";
	   break;
	 case "Jul":
	   val = "07";
	   break;
	 case "Aug":
	   val = "08";
	   break;
	 case "Sep":
	   val = "09";
	   break;
	 case "Oct":
	   val = "10";
	   break;
	 case "Nov":
	   val = "11";
	   break;
	 case "Dec":
	   val = "12";
	   break;
  }
	  return val;
}
</script>
</HEAD>

<body bgcolor="#2B303E" topmargin="0" bottommargin="0">
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2>General / Circular / Circular View / Circular Edit</h2>

<jsp:useBean id='com_qu' scope='page' class='com.iGrandee.Common.DateTime'/>

<%@ page import="java.io.*,java.util.*,java.net.*"%>
<%@ page import="java.sql.*"%>
<%
   String date_str = com_qu.showTime("calendar");

	ResourceBundle bundles=ResourceBundle.getBundle("resources.application");
%>
<%
	ResourceBundle bundle = null;
%>
<%
	try
	{
			String resources_ln=   "";
			bundle = ResourceBundle.getBundle("resources.ApplicationResources");
			session.putValue("resources_ln","English");
	}
	catch(NullPointerException e)
	{
		//System.out.println("Message ==\t\t"+e.getMessage());
	}
%>
<%@ page 	import="java.io.*,java.util.*,com.iGrandee.Circular.CircularEntryQuery"%>
<%
    	String circularId = null;
    	String subject = null;
    	String details = null;
    	String dateOfCreation = null;
    	String validityFrom = null;
    	String validiTo = null;
    	String sendTo = null;
    	String mode = null;
    	String Attachment = null;
    	String sessionid=null;
    	String boardid=null;
    	String standardid=null;
    	String sectionid=null;
    	String departid=null;
    	String strArr[] = null;

    	String temp = "";
    	String code = "";
    	String circularid = request.getParameter("circularid");
    	ArrayList list = new ArrayList();
    	CircularEntryQuery circularQuery = new CircularEntryQuery();
    	list = circularQuery.loadCircularForCircularid(circularid);

    	if (list.size() > 0) {
    		HashMap map = (HashMap) list.get(0);
    		circularId = (String) map.get("circularid");
    		subject = (String) map.get("subject");
    		details = (String) map.get("details");
    		dateOfCreation = (String) map.get("dateofcreation");
    		validityFrom = (String) map.get("validityfrom");
    		validiTo = (String) map.get("validityto");
    		sendTo = (String) map.get("sendto");
    		mode = (String) map.get("mode");
    		Attachment = (String) map.get("attachments");

    		if (mode.equals("Standard")) {
    			code="";
    			ArrayList list_1 = new ArrayList();
    			ArrayList r_list = circularQuery.getReceiverInfo(mode,sendTo);
    			for (int i = 0; i < r_list.size(); i++) {
    				map = (HashMap) r_list.get(i);
    				String year = (String) map.get("sessionname");
    				String course = (String) map.get("standardname");
    				sessionid = (String) map.get("sessionid");
    				boardid = (String) map.get("boardid");
    				String coursePublishId = (String) map .get("standardscheduleid");
    				code +="document.getElementById('slt_2').options[document.getElementById('slt_2').length]=new Option('"+course+"','"+coursePublishId+"');";
    				}
    			}
    			else if(mode.equals("student"))
    			{
    				String tttt="";
    				ArrayList r_list=circularQuery.getReceiverInfo(mode,sendTo);
    				strArr= new String[r_list.size()];
    				ArrayList list_4=new ArrayList();
    				//System.out.println("=======>>>>>>>>>"+r_list.size());
    				for(int i=0;i<r_list.size();i++)
    				{
    					//c.,ys.sessionid,secs.
    					map=(HashMap)r_list.get(i);
    					sessionid = (String) map.get("sessionid");
        				boardid = (String) map.get("boardid");
        				standardid= (String) map.get("standardscheduleid");
        		    	sectionid= (String) map.get("sectionscheduleid");
    					String year=(String)map.get("sessionname");
    					String standardname=(String)map.get("standardname");
    					String sectionname=(String)map.get("sectionname");
    					String student=(String)map.get("uname");
    					String studentallocationid=(String)map.get("studentallocationid")+"";
    					temp=studentallocationid;
    					if(!tttt.equals(temp))
    					{
    	    				code +="document.getElementById('slt_2').options[document.getElementById('slt_2').length]=new Option('"+student+"','"+studentallocationid+"');";
    						tttt=temp;
    					}
    				}
    			}
    			else if(mode.equals("Role"))
    			{
    				code="";
    				ArrayList departList =new ArrayList();
    				String sendto2="";
    				String temparray []=sendTo.replace(",","&").split("&");
    				for(int x=0;x<temparray.length;x++)
    				{
    					if(x%2==0)
    					{
    						sendto2 +=temparray [x]+",";
	    					//System.out.println("==========>>>>>"+temparray[x]);
    					}
    					else
    					{
    						departList.add(temparray [x]);
	    					//System.out.println("==========>>>>>"+temparray[x]);

    					}
    				}
    				ArrayList r_list=circularQuery.getReceiverInfo(mode,sendto2);
    				strArr= new String[r_list.size()];
    				ArrayList list_4=new ArrayList();
    				for(int i=0;i<r_list.size();i++)
    				{
    					map=(HashMap)r_list.get(i);
    					String name=(String)map.get("institutename");
    					String d_name=(String)map.get("departmentname");
    					String d_id=(String)map.get("departmentid");
    					String r_name=(String)map.get("rolename");
    					String r_id=(String)map.get("roleid");
    					//System.out.println("r_id==========>>>>>"+r_id);
    					for(int z=0;z<departList.size();z++)
    					{
	    					String depid=departList.get(z)+"";
	    					departid=depid;
	    					//System.out.println(depid+"==========>>>>>"+d_id);
	    					if(depid.equals(d_id))
	    					{
		    					if(!list_4.contains(r_id+"/"+depid))
		    					{	
		    						code +="document.getElementById('slt_2').options[document.getElementById('slt_2').length]=new Option('"+r_name+"','"+r_id+"&"+depid+"');";
		    						list_4.add(r_id+"/"+depid);
		     					}
	    					}
    					}
    			}
    			}
    		else if(mode.equals("staff"))
    			{
					code="";
					temp="";
    				ArrayList r_list=circularQuery.getReceiverInfo(mode,sendTo); 
    				strArr= new String[r_list.size()];
    				ArrayList list_4=new ArrayList();
    				for(int i=0;i<r_list.size();i++)
    				{
    					map=(HashMap)r_list.get(i);
    					String staff=(String)map.get("uname");
    					String staffid=(String)map.get("staffid");
    					departid=(String)map.get("departmentid");
    					if(!temp.equals(staffid))
    					{
						code +="document.getElementById('slt_2').options[document.getElementById('slt_2').length]=new Option('"+staff+"','"+staffid+"');";
    					temp=staffid;
    					}
    				}
    			}
    	}
																		    %>
<!--  BODY CONTENT TABLE  START  -->


<TABLE class=tableBody_border align=center width=100% cellspacing=0 cellpadding=8>
	<TR><TD colspan=2 valign=top>
<BR>
<form name="main_Form" method="post" enctype="multipart/form-data">

<TABLE border=0 class="tablecolor" cellspacing=0 width=97% align=center height=100% cellpadding=0  >
	<TR valign="top"><TD>
		<table border=0 width="80%" align=center  bordercolor="#EFEFE7"  cellpadding=3 cellspacing=0 rules=groups>
			<tr>
				<td>
					<table border=0 width="100%" align=center cellpadding=0 cellspacing=0  id="rounded-corner">
						<thead>
						<tr height=20 >
            			<th scope="col" class="rounded-company" width="80%" colspan=3><%=bundle.getString("label.tracks.Circularss")%></th>
            			<th scope="col" class="rounded-q4" width="10"></th>        
						</tr>
						</thead>
						<tbody>
						<tr height=30 >
						<td></td>
							<td class=tablebold width="30%" align>&nbsp;<%=bundle.getString("label.examschedule.subjectname")%>&nbsp;<font color=red>*</font></td>
							<td><input type="text" size=49 name=subject id='subject' class=tablelight maxlength=500 value="<%=subject %>"></td>
							<td></td>
						</tr>
						<tr height=30>
						<td></td>
							<td class=tablebold valign=top>&nbsp;<%=bundle.getString("label.courseentry.crsdescription")%>&nbsp;<font color=red>*</font></td>
							<td><textarea name=content class=tablelight rows=10 cols=80 maxlength=2000 onkeydown="textCounter_label(document.main_Form.content,document.getElementById('remLen2'),2000)"
							onkeypress="textCounter_label(document.main_Form.content,document.getElementById('remLen2'),2000)"><%=details %></textarea>
						<br>
						<i><font color="red"><label name="remLen2" id="remLen2">2000</label>
						characters Remaining</font></i></td>
							<td></td>
						</tr>

						<tr height=30>
						<td></td>
							<td class=tablebold>&nbsp;<%=bundle.getString("label.myfeed.attach")%></td>
							<td align='left' width="500"><input type = file name="user_photo" onkeypress="this.blur()" maxlength=300 class=tablelight size="60"><input type='hidden' name='attach' value='<%=Attachment%>'> &nbsp;<a href="#remove" title='Remove Attachment' onclick="document.main_Form.attach.value='null'">Remove</a></td>
							<td></td>
						</tr>

						<tr height=60>
						<td></td>
							<td class=tablebold><%=bundle.getString("label.tracks.ValidPeriod")%>&nbsp;<font color=red>*</font></td> 						
							<td class=tablelight align='left'><%=bundle.getString("label.Tracks.From")%>&nbsp;&nbsp;<input class='tablelight' type=text name=start_date style="width:110px" value="<%=validityFrom %>" onkeypress='this.blur();'><input type="button" value="^" class="tablehead" onclick="document.main_Form.start_date.value='';Calendar_Fun('/kycportal/js/Calendar/CalendarWindow.html','main_Form.start_date','0',event,'Not_Less_Than_CurrentDate',document.main_Form.currentdate);">&nbsp;&nbsp;&nbsp;&nbsp;<%=bundle.getString("label.mycors.To")%>&nbsp;&nbsp;<input class='tablelight' type=text name=end_date style="width:110px" value="<%=validiTo %>" onkeypress='this.blur();'><input type="button" value="^" class="tablehead" onclick="document.main_Form.end_date.value='';calcalender(event);">&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="btn_submit" value='<%=bundle.getString("button.eaxms.Send")%>' class=buttonTab onclick="addFeatures()"></td>
							<td></td>
						</tr>
						</tbody>
					</table>
					<br>
						<table border=0 width="100%" align=center cellpadding=0 cellspacing=0 rules=groups id="rounded-corner">
						<thead>
						<tr height=20 >
						<th scope="col" class="rounded-company" width="10"></th>
            			<th scope="col" class="rounded" width="100%">Select Option For More Function</th>
            			<th scope="col" class="rounded-q4" width="10"></th>        
						</tr>
						</thead>
						<tbody>
						<tr>
							<td></td>
							<td >
							<table id="circular_zone" border=0 width="100%" ><tr>
							<td align=center>Select Send Button </td></tr></table>
							</td>
							<td></td>
							</tr>
						</tbody>
					</table>
					<br>
					<div id="divid" style="display:none">
					<table border=0 width="100%" align=center cellpadding=0 cellspacing=0 rules=groups id="rounded-corner"> 
						<thead>
						<tr height=20 >
						<th scope="col" class="rounded-company" width="10"></th>
            			<th scope="col" class="rounded" width="100%" ></th>
            			<th scope="col" class="rounded-q4" width="10"></th>        
						</tr>
						</thead>
						<tbody>
						<tr>
							<td></td>
							<td>
							<table id="discussion_zone" border=0 width="100%" ><tr>
							<td align=center>Select Option  </td></tr></table>
							</td>
							<td></td>
						</tr>
						</tbody>
						</table>
						</div>
						
				</td>
			</tr>
		</table>
		<%
	out.println("<script>addFeatures();</script>");
	if(mode.equals("Standard"))
	{
		out.println("<script>document.main_Form.rad_course[0].checked=true;</script>");
		out.println("<script>call_byCourse();</script>");
	}
	else if(mode.equals("Role"))
	{
		out.println("<script>document.main_Form.rad_course[1].checked=true;</script>");
		out.println("<script>call_byRole();</script>");
	}
	else if(mode.equals("staff") || mode.equals("student"))
	{
		out.println("<script>document.main_Form.rad_course[2].checked=true;</script>");
		out.println("<script>call_byIndividual();</script>");
		if(mode.equals("staff"))
		{
			out.println("<script>document.main_Form.rad_staff[0].checked=true;</script>");
			out.println("<script>call_Individual_staff();</script>");
		}
		else if(mode.equals("student"))
		{
			out.println("<script>document.main_Form.rad_staff[1].checked=true;</script>");
			out.println("<script>call_Individual_student();</script>");
		}
	}
	%>
	
	<input type=hidden  name="hiddensession"		value="<%=sessionid%>">
	<input type=hidden  name="hiddenboard"		value="<%=boardid%>">
	<input type=hidden  name="hiddenstandard"		value="<%=standardid%>">
	<input type=hidden  name="hiddensection"		value="<%=sectionid%>">
	<input type=hidden  name="hiddencode"		value="<%=code%>">
	<input type=hidden  name="hiddendepartment"		value="<%=departid%>">
	<TD></TR></TABLE>
<br>
<input type="hidden" name="Status" value="Edit">
<input type="hidden" name="recievers_id">

<input type="hidden" name="circularid" value="<%=circularid%>">
<input type="hidden" name="currentdate" value="<%=date_str%>">
</form>
<form name='resetform' method='post' action=''>
<input type="hidden" name="circularid" value="<%=circularid%>">

</form>
</TD></TR></TABLE>
<a href="#na2" name="na2" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>

<a href="#na1" name="na1" class="bt_red" onclick="resetfun()"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.staffentrollement.reset")%></strong><span class="bt_red_r"></span></a>
<a href="#na3" name="na3" class="bt_green" onclick="validation_all()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.appointnment.submit")%></strong><span class="bt_green_r"></span></a>

	</div><!-- end of right content-->


	</div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->

	<%@ include file="../include/footer.jsp" %>

	</div></BODY>
	
</HTML>
