<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Circular Entry | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<SCRIPT language="JavaScript" src='<%=request.getContextPath()%>/js/Calendar/Calendar.js'></SCRIPT>
<script language="javascript">
upflag = false;
function resetfun()
{
	document.main_Form.reset();
}

function changefun(obj,obj1,obj2,obj3)
{
	obj1.options[0].selected = true;
	clearcombo(obj);
	clearcombo(obj2);
	clearcombo(obj3);
}
function changefun2(obj,obj1)
{
	obj.options[0].selected = true;
	clearcombo(obj1);
}
function clearcombo(object)
{
	for(var x=-1;x<object.options.length;x++)
	{
		object.options[1]=null;
	}
}
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
	td.colSpan=3;
	td.align="left";
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
				code="<select name='slt_year' id='slt_year'  style='width:200px' onchange='changefun(document.getElementById(\"slt_standard\"),document.getElementById(\"slt_board\"),document.getElementById(\"slt_section\"),document.getElementById(\"slt_1\"))'>";
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
	code="<select name='slt_year' id='slt_year'  style='width:200px' onchange='changefun2(document.getElementById(\"slt_board\"),document.getElementById(\"slt_1\"))'>";
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
function calcalender(event)
{
	if(check_ForParticularElements(document.main_Form.start_date,"text"))
	{
		Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','main_Form.end_date','0',event,'Not_Less_Than_StartDate',document.main_Form.start_date);
	}
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
function flagSlt_Action()
{
	flag_slt=true;
}

function callToNotice()
{
	alert(encodeURIComponent("&"));
}

function callToAnnounce()
{
	document.main_Form.action="Announce.jsp";
	document.main_Form.submit();
}

function goToSchedule()
{
	document.main_Form.action = "./Schedule.jsp";
	document.main_Form.submit();
}

function goToTimeTable()
{
	document.main_Form.action = "./TimeTable.jsp";
	document.main_Form.submit();
}

function goToProject()
{
	document.main_Form.action = "./ProjectCreation.jsp";
	document.main_Form.submit();
}

function goToLab()
{
	document.main_Form.action = "./CircularEntry.jsp";
	document.main_Form.submit();
}

function call_view()
{
	document.main_Form.action = "./CircularView.jsp";
	document.main_Form.submit();
}

function validation_all()
{
	if(check_ForParticularElements(document.main_Form.subject,"text",document.main_Form.content,"textarea",document.main_Form.start_date,"text",document.main_Form.end_date,"text"))
	{
	document.main_Form.smsstatus.value="";
	if(document.main_Form.smsgatewayenable.value=="yes")
	{
		if(document.main_Form.smsbox.checked==true)
		{
		document.main_Form.smsstatus.value="YES";
		}
	}

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


function Updatevalidation_all()
{
	var submition = false;

	if(check_ForParticularElements(document.main_Form.up_subject,"text",document.main_Form.up_content,"textarea",document.main_Form.up_ndate,"text",document.main_Form.up_enddate,"text"))
	{
		submition = true;
	}
	if(submition)
	{
		UpdatesubmitAction();
	}
}

function Delete_view()
{
	setflag = false;

	for(k=0;k<document.main_Form.rad.length;k++)
	{
		if(document.main_Form.rad[k].checked)
		{
   			setflag = true;
    	}
	}

	if(setflag)
	{
		if(confirm("Do you want to Delete the Selected Circular?"))
		{
		 	document.main_Form.action='Delete_circular.jsp';
		   	document.main_Form.submit();
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

				result_object.options[result_object.options.length] = new Option(decodeURIComponent(temp_name),temp_id);
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

function callUn()
{
	document.main_Form.action="../UniversityRegistration.jsp";
	document.main_Form.submit();
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

    <h2>General / Circular / Circular Entry</h2>


<%@ page import="java.util.*"%>


<%
	ResourceBundle bundle = null;
	ResourceBundle serverbundle=  null;
%>

<%
	try
	{
			String resources_ln=   "";
			///bundle = ResourceBundle.getBundle("ResourceBundle.English_eng");
			bundle = ResourceBundle.getBundle("resources.ApplicationResources");
			serverbundle=ResourceBundle.getBundle("resources.serversetup");
			//session.putValue("resources_ln","English");
	}
	catch(NullPointerException e)
	{
		//System.out.println("Message ==\t\t"+e.getMessage());
	}
%>

<jsp:useBean id='com_qu' scope='page' class='com.iGrandee.Common.DateTime'/>
<jsp:useBean id='gen_query' scope='page' class='com.iGrandee.Circular.CircularEntryQuery'/>
<%
		String date_str = com_qu.showTime("calendar");

%>

<!--  BODY CONTENT TABLE  START  -->


<TABLE class=tableBody_border align=center width=100% cellspacing=0 cellpadding=8>
	<TR><TD colspan=2 valign=top>
<BR>
<form name="main_Form" method="post" enctype="multipart/form-data">
<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center height=100% cellpadding=0  >
	<TR valign="top"><TD>
					<table border=0 width="100%" align=center cellpadding=0 cellspacing=0  id="rounded-corner">
						<thead>
						<tr>
	            			<th scope="col" class="rounded-company" width="85%" ><%=bundle.getString("label.tablehead.circularentry")%></th>
    	        			<th scope="col" class="rounded-q4" width="15%" align=right > <font color=red>*</font><%=bundle.getString("label.common.mandatory") %></th>
						</tr>
						</thead>
						<tbody>
						<tr height=30 ><td colspan=2>
						
						<table border=0 width="100%">
						
								<tr>
									<td class=tablebold  align>&nbsp;<%=bundle.getString("label.circular.subjectname")%><font color=red>*</font></td>
									<td width='1%' class='tablebold'>:</td>
									<td ><input type="text" size=49 name=subject id='subject' validate="Subject" class=tablelight maxlength=200 /></td>
								</tr>
								<tr height=30>
									<td class=tablebold  valign=top>&nbsp;<%=bundle.getString("label.circular.crsdescription")%> <font color=red>*</font></td>
									<td width='1%' class='tablebold' valign=top>:</td>
									<td ><textarea name=content validate="Description" class=tablelight rows=10 cols=80 maxlength=2000  onkeydown="textCounter_label(document.main_Form.content,document.getElementById('remLen2'),2000)"
													onkeypress="textCounter_label(document.main_Form.content,document.getElementById('remLen2'),2000)"></textarea>
												<br>
												
												<i><font color="red"><label name="remLen2" id="remLen2">2000</label>
												characters Remaining</font></i></td>
								</tr>
								<tr height=30>
									<td class=tablebold >&nbsp;<%=bundle.getString("label.circular.attach")%></td>
									<td width='1%' class='tablebold'>:</td>
									<td   align='left' width="500"><input type = file validate="Photo" name="user_photo" onkeypress="this.blur()" maxlength=300 class=tablelight size="60" /></td>
								</tr>
								<tr height=60 >
									<td class=tablebold width="40%"><%=bundle.getString("label.circular.ValidPeriod")%><font color=red>*</font></td>
									<td width='1%' class='tablebold'>:</td>
									<td  class=tablelight align='left'><%=bundle.getString("label.circular.From")%>&nbsp;&nbsp;<input class='tablelight' type=text name=start_date validate="Start Date" style="width:110px" value='' onkeypress='this.blur();' /><input type="button" value="^" class="tablehead" onclick="document.main_Form.start_date.value='';document.main_Form.end_date.value='';Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','main_Form.start_date','0',event,'Not_Less_Than_CurrentDate',document.main_Form.currentdate);" />&nbsp;&nbsp;&nbsp;&nbsp;<%=bundle.getString("label.circular.To")%>&nbsp;&nbsp;
									<input class='tablelight' type=text name=end_date validate="End Date" style="width:110px" value='' onkeypress='this.blur();' /><input type="button" value="^" class="tablehead" onclick="document.main_Form.end_date.value='';calcalender(event);" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="btn_submit" value='<%=bundle.getString("button.circular.Send")%>' class=buttonTab onclick="addFeatures()" /></td>
								</tr>
						</table></td></tr></tbody>
					</table>
					<br>
						<table border=0 width="100%" align=center cellpadding=0 cellspacing=0 rules=groups id="rounded-corner">
						<thead>
						<tr height=20 >
						<th scope="col" class="rounded-company" width="10"></th>
            			<th scope="col" class="rounded" width="100%">Send Option</th>
            			<th scope="col" class="rounded-q4" width="10"></th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td></td>
							<td >
							<table id="circular_zone" border=0 width="100%" ><tr>
							<td align=center>Select Send Button for more option</td></tr></table>
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
						<table>
						</div>
						<br>
						<% 
						if(serverbundle.getString("smsgatewayenable").equals("yes"))
						{		
								%>
						<table border=0 width="100%" align=center cellpadding=0 cellspacing=0 rules=groups id="rounded-corner">
						<thead>
						<tr height=20 >
						<th scope="col" class="rounded-company" width="30%"></th>
            			<th scope="col" class="rounded" width="30%" ></th>
            			<th scope="col" class="rounded-q4" width="40%"></th>
						</tr>
						</thead>
						<tbody>
						<tr>
						<td width="10%" class="tablelight">Send SMS</td>
						<td>
						<input type="checkbox" name="smsbox" onClock="smsfunction()">
						</td>
						<td></td>
						</tr>
						</tbody>
						</table>
						<% }%>

				</td>
			</tr>
		</table>
<TD></TR></TABLE>
<br>
<input type="hidden" name="Status" value="Insert" /> 
<input type="hidden" name="recievers_id" />
<input type="hidden" name="currentdate" value="<%=date_str%>" />
<input type="hidden" name="smsstatus" value="" />
<input type="hidden" name="smsgatewayenable" value="<%=serverbundle.getString("smsgatewayenable") %>" />
 
 
</form>
</TD></TR></TABLE>

<a href="#na1" name="na1" class="bt_red" onclick="resetfun()"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.circular.reset")%></strong><span class="bt_red_r"></span></a>
<a href="#na2" name="na2" class="bt_blue" onclick="call_view()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("buttons.circular.ViewContentss")%></strong><span class="bt_blue_r"></span></a>

<a href="#na3" name="na3" class="bt_green" onclick="validation_all()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.circular.submit")%></strong><span class="bt_green_r"></span></a>

	</div><!-- end of right content-->
	</div>   <!--end of center content -->
 
    <div class="clear"></div>
    </div> <!--end of main content-->

	<%@ include file="../include/footer.jsp" %>

	</div></BODY>
</HTML>
