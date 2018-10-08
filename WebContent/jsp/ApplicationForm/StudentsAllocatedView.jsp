<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Students Allocated View | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">

function goBack()
{
	document.approvalForm.req_sessionstatus.value = null;
	document.approvalForm.action="StudentsAllocated.jsp";
	document.approvalForm.submit();
}

function viewTrash()
{
	document.approvalForm.action="StudentsAllocatedTrashView.jsp";
	document.approvalForm.submit();
}

function editApplicant(obj)
{
if(confirm("Do you want to Update the Allocation Details ...?"))
	{
	document.approvalForm.studentallocationid_hidden.value=obj.getAttribute("studentallocationid");
	document.approvalForm.applicantname_hidden.value=obj.getAttribute("applicantname");
	document.approvalForm.applicationno_hidden.value=obj.getAttribute("applicationno");
	document.approvalForm.rollno_hidden.value=obj.getAttribute("rollno");
	//document.approvalForm.standardpubid_hidden.value=obj.getAttribute("standardpubid");
	//document.approvalForm.sectionschedid_hidden.value=obj.getAttribute("secschedid");
	document.approvalForm.action="StudentsAllocatedUpdate.jsp";
	document.approvalForm.submit();
	}
}

function statusChangeFun(obj)
{
		if(confirm("Do you want to "+obj.getAttribute("statusval")+" the Allocation Details..?"))
		{

			document.approvalForm.applicantname_hidden.value=obj.getAttribute("applicantname");
			document.approvalForm.applicationno_hidden.value=obj.getAttribute("applicationno");
			document.approvalForm.rollno_hidden.value=obj.getAttribute("rollno");
		
			document.approvalForm.studentallocationid_hidden.value = obj.getAttribute("studentallocationid");
			document.approvalForm.statuschange.value = obj.getAttribute("status");
			document.approvalForm.dateofallocation_hidden.value=obj.getAttribute("allocationdate");
			
			//alert(document.approvalForm.statuschange.value)
			document.approvalForm.action= "StudentsAllocatedTrashPreview.jsp";
			document.approvalForm.submit();
		}
}


function statusChangeFun1(obj)
{
		if(confirm("Do you want to "+obj.getAttribute("statusval")+" the Allocation Details..?"))
		{
			document.approvalForm.studentallocationid_hidden.value = obj.getAttribute("studentallocationid");
			document.approvalForm.statuschange.value = obj.getAttribute("status");
			//alert(document.approvalForm.statuschange.value)
			document.approvalForm.action= "allocationStatusSubmit.jsp";
			document.approvalForm.submit();
		}
}


</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>
<body bgcolor="#2B303E" topmargin="0" bottommargin="0">
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

    <h2>Enrollment / Student Enrollment / Allocation / Students Allocated View</h2>


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
		String studentallocationId="";
		String dateofallocation=null;
		String rollgenerationStatus=null;
		
		String rollNo="";
		int rollNoNote = 0;
		String sessionid=request.getParameter("reg_sessionid");
 		String boardid=request.getParameter("reg_boardid");
 		//out.println("boardid==>"+boardid);
 		String stdscheduleid=request.getParameter("course");
 		//out.println("stdscheduleid==>"+stdscheduleid);
 		String yearofsession=request.getParameter("req_sessionname");
		String boardName=request.getParameter("req_boardname");
		String standardName=request.getParameter("standardnamegp");
		String secName=request.getParameter("req_sectionname");
		String secSchedId=request.getParameter("req_sectionpubid");
		//out.println("secSchedId-->"+secSchedId+"secName-->"+secName);
		ArrayList registeredList= null;

		//out.println("<script>alert('"+sessionid+"')</script>");
		//	out.println("<script>alert('"+batchid+"')</script>");
		//out.println("<script>alert('"+stdscheduleid+"')</script>");
		//registeredList	=	(ArrayList)registrationQuery.displayAllocatedDetails(sessionid,stdscheduleid,secSchedId);
		registeredList	=	(ArrayList)registrationQuery.listAllocatedDetails(secSchedId,"A");
       %>

			<br>

<tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%">Academic Year</td><td class=tablebold width='2%'>:</td><td class=tablelight ><%=yearofsession %></td>
	
	<td class=tablebold>Board </td><td class=tablebold width='2%'>:</td><td  colspan=2  class=tablelight><%=boardName %></td>
</tr>
<tr><td class=tablebold width="25%">Standard</td><td class=tablebold width='2%'>:</td><td class=tablelight><%=standardName %></td>
<td class=tablebold width="25%">Section</td><td class=tablebold width='2%'>:</td><td class=tablelight><%=secName%></td>
</tr>
</table>
</td></tr>
</table>

<table border=0 cellpadding=5 cellspacing=0 align=center width="80%" rules=groups>
<% 
		out.print("<br>");
%>
<table id="rounded-corner" border=0 width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="7%">Sl.No</th>
            <th scope="col" class="rounded" width="25%">Student Name</th>
            <th scope="col" class="rounded" width="15%">Application No.</th>
            <th scope="col" class="rounded" width="15%">Roll No.</th>
            <th scope="col" class="rounded" width="20%">Date of Allocation</th>              
            <th scope="col" class="rounded" width="10%">Edit</th>
            <th scope="col" class="rounded-q4" width="10%">Trash</th>                       
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
			rollgenerationStatus	=	(String) map.get("rollgenerationstatus");
			
			if(rollNo==null){
				rollNo = "<font color=red><i>-NYG-</i></font>";
				rollNoNote = rollNoNote+1;
			}

			out.print("<tr><td>"+(i+1)+"</td><td>"+applicantName+"</td><td>"+applicationNo+"</td><td>"+rollNo+"</td><td>"+dateofallocation+"</td>");
			%>
            <% 
            if(request.getParameter("req_sessionstatus")=="A" || request.getParameter("req_sessionstatus").equals("A"))
            {
            %>				
			<td><a href="#"  rollno="<%=rollNo%>" studentallocationid="<%=studentallocationId%>" applicantname="<%=applicantName %>" applicationno="<%=applicationNo %>" standardpubid="<%=request.getParameter("standardpublishid")%>" onclick="editApplicant(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="Edit" border="0" /></a></td>
			<td><a href="#"  rollno="<%=rollNo%>" studentallocationid="<%=studentallocationId%>" applicantname="<%=applicantName %>" applicationno="<%=applicationNo %>" allocationdate="<%=dateofallocation %>" studentallocationid="<%=studentallocationId%>"  statusval="Trash" status="T" onclick="statusChangeFun(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="Trash" border="0" /></a></td>
            <%
            } 
            else
            {
            %>
            <td>-</td>
            <td>-</td>
			<% 
            }
			%>        			
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
					<% 
					if(rollNoNote>0)
					{
					%>
					<br>
					<tr>
					<td valign=top colspan=2>
						<b>Note: </b></td><td>&nbsp;</td><td>NYG - Not Yet Generated</td>
					</tr>  
					<br>
					<%}%>
					


		<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_red" onclick="viewTrash()"><span class="bt_red_lft"></span><strong>Trashed Applicants</strong><span class="bt_red_r"></span></a>


<input type='hidden' name='stdscheduleid' value='<%=stdscheduleid%>'>

	
	<input type=hidden name="req_sectionname" value = "<%=secName%>">
	<input type='hidden' name='sectionSchedId' value='<%=secSchedId%>'>
	<input type='hidden' name='req_sectionpubid' value='<%=secSchedId%>'>	
	<input type=hidden name="req_sessionname" value = "<%=yearofsession%>">
	<input type=hidden name="req_sessionid" value = "<%=sessionid%>">
	<input type=hidden name="req_boardname" value = "<%=boardName%>">
	<input type=hidden name="req_boardid" value = "<%=boardid%>">
	<input type=hidden name="standardnamegp" value = "<%=standardName%>">
	<input type=hidden name="standardpublishid" value = "<%=request.getParameter("standardpublishid")%>">
	<input type=hidden name="req_sessionstatus" value = "<%=request.getParameter("req_sessionstatus")%>">


	<input type=hidden name=studentallocationid_hidden>
	<input type=hidden name=applicantname_hidden>
	<input type=hidden name=applicationno_hidden>
	<input type=hidden name=rollno_hidden>
	<input type=hidden name=statuschange>
	<input type=hidden name=dateofallocation_hidden>
	
	

	<!-- <a href="#" class="bt_green" onclick="navAction()"><span class="bt_green_lft"></span><strong>Admit</strong><span class="bt_green_r"></span></a> 
	<a href="#" class="bt_red" onclick="goBack()"><span class="bt_red_lft"></span><strong>Back</strong><span class="bt_red_r"></span></a>
    <a href="#" class="bt_blue" onclick="viewStudent()"><span class="bt_blue_lft"></span><strong>View Students</strong><span class="bt_blue_r"></span></a>-->
     

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</form>
</body>

</html>