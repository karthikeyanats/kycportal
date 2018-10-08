<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Roll No. Generation | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript">


var a=0;
function chkval(obj)
{
	if(obj.checked)
		a++;
	else
		a--;


}

function goBack()
{
	document.approvalForm.action="RollNoGenSelect.jsp";
	document.approvalForm.submit();
}

function checkStudentsAvailable(obj)
{

	var sectionSchedId = document.approvalForm.sectionSchedId.value;
	url = "../StudentPromotion/getAction.jsp?Action=getRollNoGenStudents&sectionSchedId="+sectionSchedId;
	
	var req=null;

	try
	  {
	  // Firefox, Opera 8.0+, Safari
	  req=new XMLHttpRequest();
	  }
	catch (e)
	  {
	  // Internet Explorer
	  try
	    {
	    req=new ActiveXObject("Msxml2.XMLHTTP");
	    }
	  catch (e)
	    {
	    req=new ActiveXObject("Microsoft.XMLHTTP");
	    }
	  }
	  //alert(req)
	
			req.onreadystatechange = function()
			{
			//	alert(req.readyState)
				if (req.readyState == 4)
				   {
					//   alert(req.status)
				  		 if(req.status == 200)
						 {
		              			var parseXML=req.responseXML;
	
								var rootObj=parseXML.getElementsByTagName("checkNumber");
								var cNode_1=rootObj[0].childNodes.length;
								var username=null;
								var finalValue=rootObj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
								//var finalValue=rootObj[0].childNodes[0].selectSingleNode("finalValue").text;
	
								if(finalValue=="1")
								{
									alert("Roll No generated for this Section.So you cant Update")
									//document.approvalForm.rollnoprefix.value="";
									document.approvalForm.rollnoprefix.focus();
									return;	
								}
								else
								{
									checkRollNoPre(obj);
								}
						  }
					   	 else if (req.status == 204)
					     {
						 }
				   	}
		   };
		req.open("GET",url,true);
		req.send(null);
}

function checkRollNoPre(obj)
{
	var rollNoPre=document.approvalForm.rollnoprefix.value;
	var yearofsessionid=document.approvalForm.req_sessionid.value;
	
	url = "../StudentPromotion/getAction.jsp?Action=getRollNoPrefix&rollNoPre="+rollNoPre+"&yearofsessionid="+yearofsessionid;
	
	var req=null;

	try
	  {
	  // Firefox, Opera 8.0+, Safari
	  req=new XMLHttpRequest();
	  }
	catch (e)
	  {
	  // Internet Explorer
	  try
	    {
	    req=new ActiveXObject("Msxml2.XMLHTTP");
	    }
	  catch (e)
	    {
	    req=new ActiveXObject("Microsoft.XMLHTTP");
	    }
	  }
	  //alert(req)
	
			req.onreadystatechange = function()
			{
			//	alert(req.readyState)
				if (req.readyState == 4)
				   {
					//   alert(req.status)
				  		 if(req.status == 200)
						 {
		              			var parseXML=req.responseXML;
	
								var rootObj=parseXML.getElementsByTagName("checkNumber");
								var cNode_1=rootObj[0].childNodes.length;
								var username=null;
								var finalValue=rootObj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
								//var finalValue=rootObj[0].childNodes[0].selectSingleNode("finalValue").text;
	
								if(finalValue=="1")
								{
									alert("This Roll No. Prefix Already Exist")
									//document.approvalForm.rollnoprefix.value="";
									document.approvalForm.rollnoprefix.focus();
									return;	
								}
								else
								{
									setRollNoPrefix(obj);
								}
						  }
					   	 else if (req.status == 204)
					     {
						 }
				   	}
		   };
		req.open("GET",url,true);
		req.send(null);
}

function setRollNoPrefix(obj)
{
	var confirmresult = "Set";
	if(document.approvalForm.rollnoprefix.value=="")
	{
		alert("Enter Roll No Prefix to "+obj.getAttribute("confirm"));
		document.approvalForm.rollnoprefix.focus();
		return
	}
	else
	{
		if(confirm("Do you want to "+obj.getAttribute("confirm")+" Roll No Prefix..?"))
		{
			if(obj.getAttribute("confirm") == "Update")
				confirmresult = "Updated";
				
			document.approvalForm.action="rollnoprefixSubmit.jsp?confirmresult="+confirmresult;
			document.approvalForm.submit();
		}
	}

}
</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>
<body bgcolor="#2B303E" topmargin="0" bottommargin="0" onload="document.approvalForm.rollnoprefix.focus()">
<form name="approvalForm" action="" method="post">
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

		<%
		String prefixHead = ""; 
		if(request.getParameter("rollnoprefix")!="")
			prefixHead = " / Edit Roll No. Prefix";
		else
			prefixHead = " / Set Roll No. Prefix";
		%>						
    <h2>Enrollment / Student Enrollment / Roll No. Generation<%=prefixHead%></h2>


<table id="rounded-corner" border=0 width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="100%">Selected Information </th>
            <th scope="col" class="rounded-q4" width="10"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>


	 <%
		com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();

		String Regno=null;
		String applicantName=null;
		String applicationNo=null;
		String studentallocationid="";
		String dateofallocation=null;
		String rollgenerationStatus=null;
		
		String rollNo="";
		String sessionid=request.getParameter("req_sessionid");
 		String boardid=request.getParameter("req_boardid");
 		//out.println("boardid==>"+boardid);
 		String stdscheduleid=request.getParameter("standardpublishid");
 		//out.println("stdscheduleid==>"+stdscheduleid);
 		String yearofsession=request.getParameter("req_sessionname");
		String batchName=request.getParameter("req_boardname");
		String courseName=request.getParameter("standardnamegp");
		String secName=request.getParameter("req_sectionname");
		String secSchedId=request.getParameter("req_sectionpubid");
		%>

			<br>

<tr><td colspan="2"><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%">Academic Year</td><td class=tablebold width='2%'>:</td><td class=tablelight ><%=yearofsession %></td>
	<td class=tablebold>Board </td><td class=tablebold width='2%'>:</td><td  colspan=2  class=tablelight><%=batchName %></td>
</tr>
<tr><td class=tablebold width="25%">Standard</td><td class=tablebold width='2%'>:</td><td class=tablelight><%=courseName %></td>
<td class=tablebold width="25%">Section</td><td class=tablebold width='2%'>:</td><td class=tablelight><%=secName%></td>
</tr>
</table>
</td></tr>
</table>

<table id="rounded-corner" border=0 width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="100%">Set Roll No Prefix </th>
            <th scope="col" class="rounded-q4" width="10"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    <br>
	<tr><td colspan="2"><table border=0 align=center id="rounded-corner1" width="50%">
	<tr>
	
		<%
		out.print("<td align='left' class='tablebold'>Roll No Prefix</td><td class=tablebold width='2%'>:</td><td class='styleClass'><input type='text' name='rollnoprefix' class=tablelight maxlength='30' value="+request.getParameter("rollnoprefix")+"></td>");
		//if(request.getParameter("rollnoprefix")!="")
			//out.print("<td align='left' class='tablebold'>Roll No Prefix</td><td class='styleClass'>"+request.getParameter("rollnoprefix")+"</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>");
		//else
			//out.print("<td align='left' class='tablebold'>Roll No Prefix</td><td class='styleClass'><input type='text' name='rollnoprefix' class=tablelight maxlength='30' onblur='checkRollNoPre()' value="+request.getParameter("rollnoprefix")+"></td>");
		%>
		
</tr>
</table>
</td></tr>
</table>

<br>

<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>						
		<% 
		if(request.getParameter("rollnoprefix")!="")
			out.print("<a href='#' class='bt_green' confirm='Update' onclick='checkStudentsAvailable(this)'><span class='bt_green_lft'></span><strong>Update</strong><span class='bt_green_r'></span></a>");
		else
			out.print("<a href='#' class='bt_green' confirm='Set' onclick='checkRollNoPre(this)'><span class='bt_green_lft'></span><strong>Set</strong><span class='bt_green_r'></span></a>");
		%>						




<input type='hidden' name='user_mode' value='none'>
<input type='hidden' name='stdscheduleid' value='<%=stdscheduleid%>'>
<input type='hidden' name='sectionSchedId' value='<%=secSchedId%>'>

<input type='hidden' name='studentallocationid' value='<%=studentallocationid%>'>
<input type='hidden' name='req_sessionid' value='<%=request.getParameter("req_sessionid")%>'>
<input type='hidden' name='req_boardid' value='<%=request.getParameter("req_boardid")%>'>
<input type='hidden' name='reg_coursepubid_hidden' value='<%=request.getParameter("standardpublishid")%>'>



     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</form>
</body>

</html>