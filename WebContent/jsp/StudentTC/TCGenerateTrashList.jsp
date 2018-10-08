<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - TC Issued Trash View | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>

<script type="text/javascript">

function goBack()
{
	document.tcgenerationForm.action="TCGenSelect.jsp";
	document.tcgenerationForm.submit();
}

function statusChangeFun(obj)
{
		if(confirm("Do you want to "+obj.getAttribute("statusval")+" the TC Issued Details..?"))
		{
			document.tcgenerationForm.tcissueid_hidden.value = obj.getAttribute("tcissueid");
			document.tcgenerationForm.statuschange.value = obj.getAttribute("status");
			//alert(document.tcgenerationForm.statuschange.value)
			document.tcgenerationForm.action= "tcGenerateStatusSubmit.jsp";
			document.tcgenerationForm.submit();
		}
}

function viewDeactive()
{
	document.tcgenerationForm.action= "TCGenerateDeactivatedList.jsp";
	document.tcgenerationForm.submit();
}

function viewActive()
{
	document.tcgenerationForm.action= "TCGenerateList.jsp";
	document.tcgenerationForm.submit();
}

</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>
<body bgcolor="#2B303E" topmargin="0" bottommargin="0">
<form name="tcgenerationForm" action="" method="post">
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

    <h2>Certificate / Transfer Certificate Trashed View</h2>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
            <th scope="col" class="rounded" width="100%">Selected Information </th>
            <th scope="col" class="rounded-q4" width="10"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>


	 <%
	 	com.iGrandee.TCGeneration.TCGenerationQuery  tcgenerationQuery = new com.iGrandee.TCGeneration.TCGenerationQuery();	
	 
		String Regno=null;
		String applicantName=null;
		String applicationNo=null;
		String studentallocationId="";
		String dateofallocation=null;
		String tcgenerationDate=null;
		String tcissueDate=null;
		String reason=null;
		String tcissueId=null;
		String rollNo="";
		String sessionid=request.getParameter("reg_sessionid");
 		String boardid=request.getParameter("reg_boardid");
 		String stdscheduleid=request.getParameter("course");
 		ArrayList registeredList= null;
		registeredList	=	(ArrayList)tcgenerationQuery.listTCIssuedDetails(request.getParameter("req_sectionpubid"),"T");
       %>

			<br>

		<tr><td><td><table border=0 align=center id="rounded-corner1" width="100%">
		<tr>
			<td class=tablebold width="25%">Academic Year</td><td class=tablelight ><%=request.getParameter("req_sessionname") %></td>
			<td class=tablebold>Board </td><td  colspan=2  class=tablelight><%=request.getParameter("req_boardname") %></td>
		</tr>
		<tr><td class=tablebold width="25%">Standard</td><td class=tablelight><%=request.getParameter("standardnamegp") %></td>
		<td class=tablebold width="25%">Section</td><td class=tablelight><%=request.getParameter("req_sectionname")%></td>
		</tr>
		</table>
		</td><td></td></tr>
		</table>

		<table border=0 cellpadding=5 cellspacing=0 align=center width="80%" rules=groups>
		<% 
				out.print("<br>");
		%>
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		    	    <th scope="col" class="rounded-company" width="5%">Sl.No</th>
		            <th scope="col" class="rounded" width="35%">Student Name</th>
		            <th scope="col" class="rounded" width="15%">Application No</th>
		            <th scope="col" class="rounded" width="15%">Roll No</th>		            
		            <th scope="col" class="rounded" width="15%">Date of Issue</th>
                    <th scope="col" class="rounded" width="10%">Delete</th>
            		<th scope="col" class="rounded-q4" width="10%">Restore</th>
		        </tr>
		    </thead>
		    <tfoot>
		    	<tr>
		        	<td colspan="6" class="rounded-foot-left"><em></em></td>
		        	<td class="rounded-foot-right">&nbsp;</td>
		       </tr>
		    </tfoot>
  


			<%
			 	int count=0;
				boolean flag = false;
				//out.print("registeredList-->"+registeredList.size());
				if(registeredList.size()!=0)
				{
					for(int i=0;i<registeredList.size();i++)
					{
						count=count+1;
						HashMap map				=	(HashMap)registeredList.get(i);
						applicantName			=	(String) map.get("applicantname");
						applicationNo			=	(String) map.get("applicationno");
						studentallocationId		=	(String) map.get("studentallocationid");
						rollNo					=	(String) map.get("rollno");
						dateofallocation 		=	(String) map.get("dateofallocation");
						tcgenerationDate		=	(String) map.get("tcgenerationdate");
						tcissueId				=	(String) map.get("tcissueid");
						reason					=	(String) map.get("reason");
						tcissueDate				=	(String) map.get("tcissuedate");
						
						
						if(rollNo==null)
							rollNo = "-";
			
						out.print("<tr><td>"+(i+1)+"</td><td>"+applicantName+"</td><td>"+applicationNo+"</td><td>"+rollNo+"</td><td>"+tcgenerationDate+"</td>");
						%>
			            
			            <td><a href="#"   applicantname="<%=applicantName %>" applicationno="<%=applicationNo %>" tcissueid="<%=tcissueId%>" statusval="Delete" status="X" onclick="statusChangeFun(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_logout.png" alt="" title="" border="0" /></a></td>
			            <td><a href="#"   applicantname="<%=applicantName %>" applicationno="<%=applicationNo %>" tcissueid="<%=tcissueId%>" statusval="Restore" status="A" onclick="statusChangeFun(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/16-undo1.png" alt="" title="" border="0" /></a></td>
					<% 
					}
				}
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
				}		
			%>
		</table>
		</table>
		<br>

		<a href="#" class="bt_green" onclick="goBack()"><span class="bt_green_lft"></span><strong>Add new item</strong><span class="bt_green_r"></span></a>
	    <a href="#" class="bt_red" onclick="viewDeactive()"><span class="bt_red_lft"></span><strong>View Deactive Applicants </strong><span class="bt_red_r"></span></a>
	    <a href="#" class="bt_blue" onclick="viewActive()"><span class="bt_blue_lft"></span><strong>View Active Applicants</strong><span class="bt_blue_r"></span></a>

		<!--  <a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>-->			


<input type='hidden' name='stdscheduleid' value='<%=stdscheduleid%>'>
<input type='hidden' name='req_sectionpubid' value='<%=request.getParameter("req_sectionpubid")%>'>

<input type='hidden' name='studentallocationid' value='<%=studentallocationId%>'>

<input type='hidden' name='req_sessionname' value='<%=request.getParameter("req_sessionname")%>'>
<input type='hidden' name='req_boardname' value='<%=request.getParameter("req_boardname")%>'>
<input type='hidden' name='standardnamegp' value='<%=request.getParameter("standardnamegp")%>'>
<input type='hidden' name='req_sectionname' value='<%=request.getParameter("req_sectionname")%>'>

<input type=hidden name=applicantname_hidden>
<input type=hidden name=applicationno_hidden>
<input type=hidden name=tcissueid_hidden>
<input type=hidden name=tcissuedate_hidden>
<input type=hidden name=reason_hidden>
<input type=hidden name=rollno_hidden>
<input type=hidden name=studentallocationid_hidden>
<input type=hidden name=statuschange>



    

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</form>
</body>

</html>