<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.gradesystem.gradeentry")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
function checkNumber(e) {
var code;
if (!e) var e = window.event;
if (e.keyCode) code = e.keyCode;
else if (e.which) code = e.which;
var character = String.fromCharCode(code);
if(code!=9 && code!=46 && code!=8)
{
if (code==47||code<46||code>57)
{
	code=0;
	alert("Enter  Number only")

if(window.event != null)
{
	window.event.keyCode 	= 505;
	event.cancelBubble		= true;
	event.returnValue		= false;
}
else
{
	e.preventDefault();
}
	 return false;
}
}
}
function loadfun()
{
			document.Grade_Form.submit();
} 
	function Gradesubmit()
	{
		 if(check_ForParticularElements(document.Grade_Form.sessionname,"select"))
		 {
		 var count=0;
	 	 var chklength= document.Grade_Form.checkgrade.length;
   		 for(var i=0;i<chklength;i++)
   		 {
   		 	if(document.Grade_Form.checkgrade[i].checked)
			{
				count++;
				document.Grade_Form.GradeName[i].disabled=false;  
   	    		document.Grade_Form.Rangefrom[i].disabled=false;  
   	   	 		document.Grade_Form.Rangeto[i].disabled=false;
			}
			else
			{
			   	document.Grade_Form.GradeName[i].disabled=true;  
   	    		document.Grade_Form.Rangefrom[i].disabled=true;  
   	   	 		document.Grade_Form.Rangeto[i].disabled=true;
			}
   		 }
   		 if(count>0)
   		 {
			document.Grade_Form.action="./GradeSubmit.jsp";
			document.Grade_Form.submit();
		 }
		 else
		 {
			 for(var i=0;i<chklength;i++)
	   		 {	
					document.Grade_Form.GradeName[i].disabled=false;  
	   	    		document.Grade_Form.Rangefrom[i].disabled=false;  
	   	   	 		document.Grade_Form.Rangeto[i].disabled=false;
			}
		 	alert("Check Any Grade");
		 }
	}
	}
	function checkgradefun(obj)
	{
	var no = obj.getAttribute("chkid");
	if(obj.checked)
	{
	if(check_ForParticularElements(document.Grade_Form.GradeName[no],"text",document.Grade_Form.Rangefrom[no],"text",document.Grade_Form.Rangeto[no],"text"))
	{
		
   	    if(parseInt(document.Grade_Form.Rangeto[no].value)<parseInt(document.Grade_Form.Rangefrom[no].value))
   	    {
		var varto=document.Grade_Form.Rangeto[no].value;
		var varfrom=document.Grade_Form.Rangefrom[no].value; 
		document.Grade_Form.Rangeto[no].value=varfrom;
		document.Grade_Form.Rangefrom[no].value=varto; 
		}
   		 var chklength= document.Grade_Form.checkgrade.length;
   		 for(var i=0;i<chklength;i++)
   		 {
	   		 if(i!=no)
	   		 {
	   		 	if(document.Grade_Form.GradeName[no].value==document.Grade_Form.GradeName[i].value)
						{
							alert("Grade Name Already Exists");
							document.Grade_Form.GradeName[no].focus();
							obj.checked=false;
							return false;
						}
	   		 	if(parseInt(document.Grade_Form.Rangeto[no].value)===parseInt(document.Grade_Form.Rangefrom[no].value))
			   		 		{
			   		 		alert("From  Range and To Range Are Same");
			   		 		document.Grade_Form.Rangeto[no].focus();
			   		 		obj.checked=false;
			   		 		return false;
			   		 		}
		   		 if(document.Grade_Form.Rangefrom[i].value!="" && document.Grade_Form.Rangeto[i].value!="")
			   		 {		
			   		 		if(parseInt(document.Grade_Form.Rangefrom[no].value)>=parseInt(document.Grade_Form.Rangefrom[i].value) && parseInt(document.Grade_Form.Rangefrom[no].value)<=parseInt(document.Grade_Form.Rangeto[i].value))
			   		 		{
			   		 		alert("From Range Already Exist");
			   		 		document.Grade_Form.Rangefrom[no].focus();
			   		 		obj.checked=false;
			   		 		return false;
			   		 		}
			   		 		if(parseInt(document.Grade_Form.Rangeto[no].value)>=parseInt(document.Grade_Form.Rangefrom[i].value) && parseInt(document.Grade_Form.Rangeto[no].value)<=parseInt(document.Grade_Form.Rangeto[i].value))
			   		 		{
			   		 		alert("To Range Already Exist");
			   		 		document.Grade_Form.Rangeto[no].focus();
			   		 		obj.checked=false;
			   		 		return false;
			   		 		}
			   		 }
	   		 }
   		 }
   		document.Grade_Form.GradeName[no].disabled=true;  
   	    document.Grade_Form.Rangefrom[no].disabled=true;  
   	    document.Grade_Form.Rangeto[no].disabled=true;
	}
	else
	{
				   		 		obj.checked=false;
	}
	}
	else
	{
		document.Grade_Form.GradeName[no].disabled=false;  
   	    document.Grade_Form.Rangefrom[no].disabled=false;  
   	    document.Grade_Form.Rangeto[no].disabled=false;  
	}
	}
	
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>
    <div class="right_content">

    <h2><%=bundle.getString("label.gradesystem.rootpath")%></h2>
	<form name="Grade_Form" action="" method="post">
    <input type=hidden name=examId />
    <input type=hidden name=examname />
    <input type=hidden name=academicname />
    	<table id="rounded-corner" border=0 width="100%">
    	<thead>
    		<tr>
            	<th scope="col" class="rounded-company" width="90%" colspan=2><%=bundle.getString("label.gradesystem.gradeentry")%></th>
            	<th scope="col" class="rounded-q4" width="10%"></th>        
        	</tr>
    	</thead>
        <tfoot>
    			<tr>
        			<td colspan="2" class="rounded-foot-left"><em></em></td>
        			<td class="rounded-foot-right">&nbsp;</td>
       			</tr>
    	</tfoot>
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime"%>

<%
		com.iGrandee.Exam.ExamnameEntry  examQuery = new com.iGrandee.Exam.ExamnameEntry();
		String instituteid = null;
		ArrayList GradeList=new ArrayList();
		instituteid			= (String)session.getValue("instituteid");
		ArrayList academicList 		= examQuery.loadAcademicYear(instituteid);
		HashMap	hashmap				= null;
		String req_subjectscheduleid="";
		String reg_sessionid 	= null;
		//out.println("==============>>>>>>>>>"+request.getParameter("sessionname"));
	try{
	
		 if(request.getParameter("sessionname") != null )		{
			 reg_sessionid=request.getParameter("sessionname");
			GradeList=examQuery.LoadGradeList(reg_sessionid);

		}
		
		
}catch(Exception e){}
			
%>
			
<tbody>	
<tr height='23'>
		<td class=tablebold width='20%'><%=bundle.getString("label.gradesystem.academic")%></td>
		<td class=tablebold width="2%">:</td>
		<td width='78%'>
					<select name=sessionname Validate='Academic Year' class=tablelight onchange='loadfun()'>
						<option value="00">-Select Academic-</option>
						<%
							for(int s=0;s<academicList.size();s++)
							{
								HashMap map=(HashMap)academicList.get(s);
								String sessionid=(String)map.get("sessionid");
								String yearofsession=(String)map.get("sessionname");
								if(request.getParameter("sessionname") != null)
								{
									if(request.getParameter("sessionname").equals(sessionid))
										out.println("<option selected value='"+sessionid+"'>"+yearofsession+"</option>");
									else
										out.println("<option value='"+sessionid+"'>"+yearofsession+"</option>");
								}
								else
								{
									out.println("<option value='"+sessionid+"'>"+yearofsession+"</option>");
								}
							
							}
						%>
					</select>
				</td>
				
</tr>
	</tbody>
</table>
  <br>
		<table width='100%' align='center' border='0' >
			<tr>
				<td width='100%' class='tablebold' colspan=2>
				
					<table id="rounded-corner1"  border=0 summary="Subject List" width="100%" cellspacing='2' cellpadding='5'>
					    <thead>
					    	<tr class=tableheading>
					        	<th scope="col" class="rounded-company" width="10%" rowspan=2><%=bundle.getString("label.topperweaker.slno")%></th>
					        	<th scope="col" class="rounded" 		width="30%" rowspan=2><%=bundle.getString("label.gradesystem.gradename")%></th>
					        	<th scope="col" class="rounded" 		width="30%" colspan=2 align="center"><%=bundle.getString("label.gradesystem.range")%></th>
					        	<th scope="col" class="rounded-q4"		width="20%" rowspan=2><%=bundle.getString("label.gradesystem.check")%></th>
					        	<tr class=tableheading><th scope="col" class="rounded" width="15%"	><%=bundle.getString("label.gradesystem.from")%></th><th scope="col"  width="15%"	 class="rounded" 	><%=bundle.getString("label.gradesystem.to")%></th>
					        </tr>
					    </thead>
					    <tfoot>
    			<tr>
        			<td colspan="4" class="rounded-foot-left"><em></em></td>
        			<td class="rounded-foot-right">&nbsp;</td>
       			</tr>
    	</tfoot>
    	<tbody>
					   	<%
					   	if(request.getParameter("sessionname") != null && !(request.getParameter("sessionname")+"").equals("00"))
					   	{
					   	int j = 1;
					   	if(GradeList.size()>0 && GradeList!=null)
					   	{
					   		for (int i = 0; i < GradeList.size(); i++,j++) 
		  		 			{	
					   			hashmap=(HashMap)GradeList.get(i);
								out.println("<tr  align='center'>");
								out.println("<td>"+j+"</td><td class=tablelight align='left'>"+hashmap.get("gradename")+"<input type='hidden' name='GradeName' value='"+hashmap.get("gradename")+"' /></td>");
								out.println("<td class=tablelight >"+hashmap.get("rangefrom")+"<input type='hidden' name='Rangefrom' value='"+hashmap.get("rangefrom")+"'/></td>");
								out.println("<td class=tablelight >"+hashmap.get("rangeto")+"<input type='hidden' name='Rangeto' value='"+hashmap.get("rangeto")+"'/></td>");
								out.println("<td class=tablelight >-<input type='hidden'  name='checkgrade'/></td>");
								out.println("</tr>");
							}
					   		for (int i = 0; i < 5; i++,j++) 
		  		 			{
								out.println("<tr align='center'>");
								out.println("<td >"+j+"</td><td class=tablelight align='left'><input type='Text' name='GradeName' value='' validate='Grade Name' size='50' maxlength='50'></td>");
								if(i == 0)
								{
								out.println("<td class=tablelight ><input type='Text' name='Rangefrom' value='0' validate='Range From' size='10' maxlength='5' onkeypress='checkNumber(event)'></td>");
								}
								else
								{
								out.println("<td class=tablelight ><input type='Text' name='Rangefrom' value='' validate='Range From' size='10' maxlength='5' onkeypress='checkNumber(event)'></td>");
								}
								out.println("<td class=tablelight ><input type='Text' name='Rangeto' value='' validate='Range To' size='10' maxlength='5' onkeypress='checkNumber(event)'></td>");
								out.println("<td class=tablelight ><input type='checkbox' chkid='"+(j-1)+"' name='checkgrade' value='' onclick='checkgradefun(this)'></td>");
								out.println("</tr>");
							}
					   	}
					   	else
					   	{
					   		for (int i = 0; i < 5; i++,j++) 
		  		 			{
								out.println("<tr align='center'>");
								out.println("<td >"+j+"</td><td class=tablelight align='left'><input type='Text' name='GradeName' value='' validate='Grade Name' size='50' maxlength='50'></td>");
								if(i == 0)
								{
								out.println("<td class=tablelight ><input type='Text' name='Rangefrom' value='0' validate='Range From' size='10' maxlength='5' onkeypress='checkNumber(event)'></td>");
								}
								else
								{
								out.println("<td class=tablelight ><input type='Text' name='Rangefrom' value='' validate='Range From' size='10' maxlength='5' onkeypress='checkNumber(event)'></td>");
								}
								out.println("<td class=tablelight ><input type='Text' name='Rangeto' value='' validate='Range To' size='10' maxlength='5' onkeypress='checkNumber(event)'></td>");
								out.println("<td class=tablelight ><input type='checkbox' chkid='"+(j-1)+"' name='checkgrade' value='' onclick='checkgradefun(this)'></td>");
								out.println("</tr>");
							}
					   	}
					   	}
					   	else
					   	{
							out.println("<tr align='center' ><td class=tablelight colspan='5'>Select Academic Year</td><tr>");
					   	}
						%>
						</tbody>
		</table>
		</td>
		</tr>
	</table>
		 <a href="#sub" name="sub" class="bt_green" onclick='Gradesubmit()'><span class="bt_green_lft"></span><strong><%=bundle.getString("button.gradesystem.submit")%></strong><span class="bt_green_r"></span></a>
</form>	
    </div><!-- end of right content-->
	</div>   <!--end of center content -->

   <div class="clear"></div>
   </div> <!--end of main content-->
<%@ include file="../../include/footer.jsp" %>
</div>
</body>
</html>