<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.assignmentcreation.AssignmentAllocation") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/xmlhttpobject.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/clearselects.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script language='javascript'>

function makeEmpty()
{
	document.workallotment.task.value				= "";
	document.workallotment.startdate.value			= "";
	document.workallotment.startsbut.disabled		= false;
	document.workallotment.enddate.value			= "";
	document.getElementById("astudename").innerHTML	= "";
	document.getElementById("remaining").innerHTML = "<font color=red>2000 characters remaining";
	
}

function lessonChanging(){
	
	document.workallotment.section.selectedIndex	= 0;
	clearObjects("assignment","student");
	makeEmpty();
}

function doCompletion(flag)
{
	var url 	= "";
	
	if(flag=="standard")
	{
		clearObjects("subject","lesson","section","assignment","student");
		makeEmpty();
		url = "getAgentCourseInfo.jsp?action=standard&yearid="+document.getElementById("session").value;
	}
	else if(flag=="subject")
	{
		clearObjects("subject","lesson","section","assignment","student");	
		makeEmpty();
		if(check_ForParticularElements(document.workallotment.standard,"select")){
			url = "getAgentCourseInfo.jsp?action=subject&standard="+document.getElementById("standard").value;
		}
	}
	else if(flag=="lesson")
	{
		clearObjects("lesson","section","assignment","student");
		makeEmpty();
		if(check_ForParticularElements(document.workallotment.standard,"select",document.workallotment.subject,"select")){
			url = "getAgentCourseInfo.jsp?action=lesson&subject="+document.getElementById("subject").value;
		}
	}
	else if(flag=="section")
	{
		clearObjects("section","assignment","student");
		makeEmpty();		
		if(check_ForParticularElements(document.workallotment.standard,"select",document.workallotment.subject,"select")){
			url = "getAgentCourseInfo.jsp?action=section&subject="+document.getElementById("subject").value;
		}
	}
	else if(flag=="assignment")
	{
		clearObjects("assignment","student");
		makeEmpty();		
		if(check_ForParticularElements(document.workallotment.standard,"select",document.workallotment.subject,"select",document.workallotment.lesson,"select",document.workallotment.section,"select")){
			url = "getAgentCourseInfo.jsp?action=topic&lesson="+document.getElementById("lesson").value+"&section="+document.getElementById("section").value;
		}
	}
	else if(flag=="student")
	{
		clearObjects("student");
		if(check_ForParticularElements(document.workallotment.standard,"select",document.workallotment.subject,"select",document.workallotment.lesson,"select",document.workallotment.section,"select",document.workallotment.assignment,"select")){
			url = "getAgentCourseInfo.jsp?action=student&section="+document.getElementById("section").value+"&assignment="+document.getElementById("assignment").value;
		}
	}

	var req =initRequest();
	req.onreadystatechange = function()
	{
		if (req.readyState == 4)
		{
			if (req.status == 200)
			{
				if(flag=="student")
				{
					loadStudents(req.responseXML);
				}
				else
				{
					if(flag == "lesson")
					doCompletion("section")
					parseMessages(req.responseXML,flag);
				}

			}
		}
	};
	req.open("GET", url, true);
	req.send(null);
}

function studentName(studenames)
{
	if(check_ForParticularElements(document.workallotment.student,"select")){
		  stud_names=document.workallotment.student.options[document.workallotment.student.options.selectedIndex].text; 
		  studentFun();
	}
}


function loadStudents(parseXML)	{

	var rootObj			= parseXML.getElementsByTagName("MainEntity");
	var result_object	= document.getElementById("student");
	var cNode_1			= rootObj[0].childNodes.length;
	var teststatus 		= false;

	for(var i=0;i<parseInt(cNode_1);i++)
	{

		result_object.options[result_object.options.length] = new Option(rootObj[0].childNodes[i].childNodes[1].childNodes[0].nodeValue,rootObj[0].childNodes[i].childNodes[0].childNodes[0].nodeValue);

		if(rootObj[0].childNodes[i].childNodes[5].childNodes[0].nodeValue == "Yes")
		{
			result_object.options[result_object.options.length-1].disabled = true;
			result_object.options[result_object.options.length-1].selected=true;
			result_object.options[result_object.options.length-1].className = 'tablebold';
			
			if(!teststatus)
			{

				var adate	= rootObj[0].childNodes[i].childNodes[0].childNodes[0].nodeValue;
				var sdate	= rootObj[0].childNodes.item(i).childNodes.item(4).firstChild.nodeValue;
       	        var qid		= rootObj[0].childNodes.item(i).childNodes.item(5).firstChild.nodeValue;
       	        var remarks	= rootObj[0].childNodes.item(i).childNodes.item(6).firstChild.nodeValue;


				document.workallotment.task.value				= rootObj[0].childNodes[i].childNodes[6].childNodes[0].nodeValue;
				document.workallotment.startdate.value			= rootObj[0].childNodes[i].childNodes[2].childNodes[0].nodeValue;
				document.workallotment.enddate.value			= rootObj[0].childNodes[i].childNodes[3].childNodes[0].nodeValue;
				document.workallotment.assignment_hide.value	= rootObj[0].childNodes[i].childNodes[4].childNodes[0].nodeValue;
				document.workallotment.startsbut.disabled		= true;
				document.getElementById("remaining").innerHTML = "<font color=red>"+(2000-document.workallotment.task.value.length)+" characters remaining";
				
			}
			teststatus = true;
		}
	}
	
}

	
function studentFun()
{
	var str="<table border=0 cellspacing=0>";
	var j=1;
	for(var i=0;i<document.workallotment.student.options.length;i++)
	{
		if(document.workallotment.student.options[i].selected && !document.workallotment.student.options[i].disabled)
		{
			str+="<tr><td valign=top class=tablelight>"+j+".</td><td valign=top class=tablelight>"+document.workallotment.student.options[i].text+"</td></tr>";
			j++;
		}
	}
	str+="</table>";
	document.getElementById("astudename").innerHTML=str;
}


function selectAllStudent()
{
	opt_len = document.workallotment.student.options.length;

	if(document.workallotment.selectall.checked)
	{
		if(opt_len >= 1)
		{
			for(i=1;i<opt_len;i++)
			{
				document.workallotment.student.options[i].selected = true;
			}
		}
		document.workallotment.student.options[0].selected = false;
	}
	else
	{
		for(i=0;i<opt_len;i++)
		{
			document.workallotment.student.options[i].selected = false;
		}
	}
	studentFun();
}


function submitFun()
{
	document.getElementById("savebut").disabled = true;
	var stud_name							= new Array();

	for(var i=1;i<document.workallotment.student.options.length;i++)
	{
		if(document.workallotment.student.options[i].selected && !document.workallotment.student.options[i].disabled)
		{
			stud_name[stud_name.length] = document.workallotment.student.options[i].value;
		}
	}

	if(check_ForParticularElements(document.workallotment.standard,"select",document.workallotment.subject,"select",document.workallotment.lesson,"select",document.workallotment.section,"select",document.workallotment.assignment,"select",document.workallotment.task,"textarea",document.workallotment.startdate,"text",document.workallotment.enddate,"text"))
	{
		if(stud_name.length==0)
		{
			alert("Please select Student Name(s)!");
			document.getElementById("savebut").disabled = false;
			return false;
		}
		if(confirm("Do you wish to continue?"))
		{
			document.workallotment.student_hide.value	= stud_name;
			document.workallotment.action = "AllocationSubmit.jsp";
			document.workallotment.submit();
		}
		else
			document.getElementById("savebut").disabled = false;
	}
	else
		document.getElementById("savebut").disabled = false;
}


function removeFun(){

	if(check_ForParticularElements(document.workallotment.standard,"select",document.workallotment.subject,"select",document.workallotment.lesson,"select",document.workallotment.section,"select",document.workallotment.assignment,"select",document.workallotment.task,"textarea",document.workallotment.startdate,"text",document.workallotment.enddate,"text"))

		if(document.workallotment.assignment_hide.value != ""){

			document.workallotment.standardname.value 		= document.workallotment.standard.options[document.workallotment.standard.options.selectedIndex].text;
			document.workallotment.lessonname.value 		= document.workallotment.lesson.options[document.workallotment.lesson.options.selectedIndex].text;
			document.workallotment.subjectname.value 		= document.workallotment.subject.options[document.workallotment.subject.options.selectedIndex].text;
			document.workallotment.assignmentname.value 	= document.workallotment.assignment.options[document.workallotment.assignment.options.selectedIndex].text;
			document.workallotment.sectionname.value 		= document.workallotment.section.options[document.workallotment.section.options.selectedIndex].text;

			document.workallotment.action = "Remove_Assignment.jsp";
			document.workallotment.submit();
		}
		else{

			alert("Please select an assignment,that is already allotted to the students.");
			return false;
		}
	}
	
	function calculateRemaining(obj,val) {

		var txtlemgth	= obj.value;
		var remobj		= document.getElementById("remaining");

		if(txtlemgth.length>=val) {
			alert("Only 5000 characters allowed.");
			obj.setAttribute("value",txtlemgth.substring(0,val))
			remobj.innerHTML = "<font color=red>0 characters remaining";
			return false;
		}
		else
			remobj.innerHTML = "<font color=red>"+(val-txtlemgth.length)+" characters remaining";
	}
	

	
</script>
</head>
<body>
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

    <h2><%=bundle.getString("label.assignmentcreation.allocationrootpath") %></h2>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Assignment.Assignment,com.iGrandee.Common.DateTime"%>
	
<%
	String sessionid		= (String)session.getValue("sessionid");
	String sessionname		= (String)session.getValue("sessionname");
	Assignment wallot 		= new Assignment();
	DateTime	datetime	= new DateTime();
	String instituteid 		= (String)session.getValue("instituteid");
	String userid 			= (String)session.getValue("userid");
	String today			= datetime.showTime("calendar");
	HashMap	hashmap			= null;
	ArrayList standardList	= null;
	standardList			= wallot.loadStandardForStaff(userid,sessionid); 

%>
	<form name='workallotment' method='post'>
		<table class="bodyinnercolor" border=0 bordercolor='red' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
						<table id="rounded-corner" border=0  width="90%">
						    <thead>
						    	<tr>
						        	
						            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.assignmentcreation.AssignmentAllocation") %></th>
						            <th scope="col" class="rounded-q4" width="2%"></th>
						        </tr>
						    </thead>				  		
						    <tr>
				  			<td colspan='2'>
					  			<table border=0 width="80%" align=center cellspacing=0 cellpadding=5>
					  				<tr height=20>
										<td class='tablebold'><%=bundle.getString("label.assignmentcreation.AcademicYear") %></td>
										<td class='tablebold'>:</td><td class='tablelight'>
										<%=sessionname %>
										</td>
									</tr>
					  				<tr bgcolor=f4f4f4 height=20>
					  					<td class=tablebold><%=bundle.getString("label.assignmentcreation.Standard") %></td>
					  					<td class='tablebold'>:</td><td><select name='standard' id='standard' validate="Standard Name" class=tablelight style="width:200" onchange="doCompletion('subject')">
											<option value=0>- Select Standard Name -</option>
											<%
											if(standardList != null && standardList.size()>0){
												for(int y=0;y<standardList.size();y++){
													hashmap		= (HashMap)standardList.get(y);
													String groupname = (String) hashmap.get("groupname");
									 				if(groupname==null)
									 					groupname = "";
									 				else
									 					groupname = " - "+groupname;
													out.print("<option value='"+hashmap.get("standardscheduleid")+"'>"+hashmap.get("standardname")+""+groupname+"</option>");
												}
											}
											%>												
					  					</select></td>
					  				</tr>
					  				<tr height=20>
					  					<td class=tablebold><%=bundle.getString("label.assignmentcreation.Subject") %></td>
					  					<td class='tablebold'>:</td><td><select name='subject' id='subject' validate="Subject Name" class=tablelight style="width:200" onchange="doCompletion('lesson')">
					  						<option value=0>- Select Subject -</option>
					  					</select></td>
					  				</tr>
					  				<tr bgcolor=f4f4f4 height=20>
					  					<td class=tablebold><%=bundle.getString("label.assignmentcreation.Lesson") %></td>
					  					<td class='tablebold'>:</td><td><select name='lesson' id='lesson' validate="Lesson Name" class=tablelight  style="width:200" onchange='lessonChanging()' >
											<option value=0>- Select Lesson Name-</option>
										</select></td>
			
									<tr  height=20 valign=top>
					  					<td class=tablebold><%=bundle.getString("label.assignmentcreation.Section") %></td>
					  					<td class='tablebold'>:</td><td><select name='section' id='section' validate="Section" class=tablelight style="width:200" onchange="doCompletion('assignment')">
											<option value=0>- Select Section -</option>
					  					</select></td>
					  				</tr>
									<tr  height=20 valign=top>
					  					<td class=tablebold><%=bundle.getString("label.assignmentcreation.Assignment") %></td>
					  					<td class='tablebold'>:</td><td><select name='assignment' id='assignment' validate="Assignment" class=tablelight style="width:200" onchange="doCompletion('student')">
											<option value=0>- Select Assignment -</option>
					  					</select></td>
					  				</tr>
					  				
					  				<tr height=20 bgcolor=f4f4f4 valign=top>
					  					<td class=tablebold valign=top><%=bundle.getString("label.assignmentcreation.Description") %></td>
					  					<td class='tablebold'>:</td><td valign=top><textarea name=task class=tablelight rows=3 cols=50 validate="Description" onKeyPress='calculateRemaining(this,2000)' onKeyUp='calculateRemaining(this,2000)'></textarea><br><span id='remaining'><font color="red"><%=bundle.getString("label.assignmentcreation.2000charactersremaining") %></font></span></td>
				  					</tr>
					  				<tr  height=20>
					  					<td class=tablebold><%=bundle.getString("label.assignmentcreation.StartDate") %></td>
					  					<td class='tablebold'>:</td><td><input type=text name=startdate size=10 validate="StartDate" class=tablelight onkeypress='this.blur();' ><input type="button" name='startsbut' value="^" class="tablehead" onclick="document.workallotment.enddate.value='';this.blur();Calendar_Fun('../../js/Calendar/CalendarWindow.html','workallotment.startdate','0',event,'Not_Less_Than_CurrentDate',document.workallotment.currentdate);"></td>
					  				</tr>
					  				<tr height=20 bgcolor=f4f4f4>
					  					<td class=tablebold><%=bundle.getString("label.assignmentcreation.EndDate") %></td>
					  					<td class='tablebold'>:</td><td><input type=text name=enddate size=10 validate="EndDate" class=tablelight onkeypress='this.blur();' ><input type="button" value="^" class="tablehead" onclick="document.workallotment.student.focus();Calendar_Fun('../../js/Calendar/CalendarWindow.html','workallotment.enddate','0',event,'Not_Less_Than_StartDate',document.workallotment.startdate);"></td>
					  				</tr>
					  				<tr  height=20 valign=top>
					  					<td class=tablebold><%=bundle.getString("label.assignmentcreation.StudentNames") %></td>
					  					<td class='tablebold'>:</td><td valign=top><select name='student' id='student' validate='Student Name' multiple class=tablelight size=5 onchange="studentName(this)" style=width:250;>
					  					<%
											out.println("<option value=0>- Select Students from List -</option>");
										%>
										</select></td>
									</tr>
									<tr height=20 bgcolor=f4f4f4>
					  					<td colspan='4'>
					  						<a class='tablelight'><font color='red'><i><%=bundle.getString("label.assignmentcreation.message") %></font></a>
					  						<br>
					  						<input type=checkbox name="selectall" onclick='selectAllStudent()'><a class=tablebold><%=bundle.getString("label.assignmentcreation.SelectAll") %></a>
					  					</td>
					  				</tr>
					  				<tr  height=20 valign=top>
					  					<td class=tablebold><%=bundle.getString("label.assignmentcreation.AssignedStudents") %></td>
					  					<td class='tablebold'>:</td><td valign=top><span id=astudename class=tablelight></span></td>
					  				</tr>
					  				<tr height=20 bgcolor=f4f4f4>
					  					<td class=tabledata colspan=4><font color=red>* <%=bundle.getString("label.assignmentcreation.Use") %> <font color=black><%=bundle.getString("label.assignmentcreation.[Ctrl]") %></font> <%=bundle.getString("label.assignmentcreation.message_1") %></font></td>
					  				</tr>
					  			</table>
		  					</td>
		  				</tr>
		  			</table>
		  			
		  			<a href="#" id="savebut"  class="bt_green" onclick='submitFun()'><span class="bt_green_lft"></span><strong><%=bundle.getString("button.assignmentcreation.Assign") %></strong><span class="bt_green_r"></span></a>
		  			<a href="#" id="rembut"   class="bt_red" onclick='removeFun()'><span class="bt_red_lft"></span><strong><%=bundle.getString("button.assignmentcreation.Remove") %></strong><span class="bt_red_r"></span></a>
		  			
		  			
				</td>
			</tr>
		</table>
		
		<input type='hidden' name='standardname' 	value=''>
		<input type='hidden' name='sectionname'		value=''>
		<input type='hidden' name='sessionname' 	value=''>
		<input type='hidden' name='assignmentname' 	value=''>
		<input type='hidden' name='lessonname' 		value=''>
		<input type='hidden' name='subjectname' 	value=''>
		<input type='hidden' name='assignment_hide' value=''>
		<input type='hidden' name='student_hide' 	value=''>
		<input type='hidden' name='currentdate' 	value='<%=today%>'>
		
		
	</form>


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>