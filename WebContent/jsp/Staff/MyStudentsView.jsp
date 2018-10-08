<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.tracking.studentlisttitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">

function goBack()
{
	document.approvalForm.action="MyStudentSelect.jsp";
	document.approvalForm.submit();
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

    <h2><%=bundle.getString("label.tracking.studentviewrootpath") %></h2>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.tracking.SelectedInformation") %> </th>
            <th scope="col" class="rounded-q4" width="10%"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
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
		//out.println("secSchedId-->"+secSchedId+"secName-->"+secName);
		ArrayList registeredList= null;
		String studentemail	=	null;
		String mobilenumber	=	null;
		String landlinenumber	= null;
		String contactnos = null;
		//out.println("<script>alert('"+session.getValue("userid")+"')</script>");
		//	out.println("<script>alert('"+batchid+"')</script>");
		//out.println("<script>alert('"+stdscheduleid+"')</script>");
		//registeredList	=	(ArrayList)registrationQuery.displayAllocatedDetails(sessionid,stdscheduleid,secSchedId);
		registeredList	=	(ArrayList)registrationQuery.displayAllocatedDetails(secSchedId);
       %>

			<br>

<tr>
<td colspan=2>
	<table border=0 align=center id="rounded-corner1" width="100%">
	<tr>
		<td class=tablebold width="25%"><%=bundle.getString("label.tracking.AcademicYear") %></td><td class=tablebold>:</td><td class=tablelight ><%=yearofsession %></td>
		<td class=tablebold><%=bundle.getString("label.schedule.board") %> </td><td class=tablebold>:</td><td  colspan=2  class=tablelight><%=batchName %></td>
	</tr>
	<tr><td class=tablebold width="25%"><%=bundle.getString("label.tracking.Standard") %></td><td class=tablebold>:</td><td class=tablelight><%=courseName %></td>
	<td class=tablebold width="25%"><%=bundle.getString("label.tracking.Section") %></td><td class=tablebold>:</td><td class=tablelight><%=secName%></td>
	</tr>
	</table>
</td>
</tr>
</table>
<br/>

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="7%"><%=bundle.getString("label.tracking.SL.No") %></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.tracking.StudentName") %></th>
               <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.tracking.RollNo") %>.</th>
            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.tracking.studentemail") %>.</th>
         <th scope="col" class="rounded-q4" width="30%"><%=bundle.getString("label.tracking.contactnos") %></th>                       
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
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
			studentallocationid		=	(String) map.get("studentallocationid");
			rollNo					=	(String) map.get("rollno");
			dateofallocation 		=	(String) map.get("dateofallocation");
			rollgenerationStatus	=	(String) map.get("rollgenerationstatus");
		
			
			studentemail	=	(String) map.get("emailid");
			mobilenumber	=	(String) map.get("mobilenumber");
			landlinenumber	=	(String) map.get("landlinenumber");
			if(landlinenumber.equals(""))
				landlinenumber= "<i>-Not Given-<i>";
			contactnos = "<a class=tablebold>Mobile No.</a>"+mobilenumber+"<br><a class=tablebold>Landline :</a>"+landlinenumber;
			
			if(rollNo==null)
				rollNo = "-";

			out.print("<tr><td>"+(i+1)+"</td><td>"+applicantName+"</td><td>"+rollNo+"</td><td><a href=mailto:"+studentemail+">"+studentemail+"</a></td><td>"+contactnos+"</td></tr>");
			//out.println("<td align='left'><input type='checkbox' name='chk' value="+studentallocationid+"@"+count+" onclick=chkval(this)></td></tr>");
		}
	}
	else
	  {
		  out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
	  }


	%>
</table>

<br/>

<%
//out.print("registeredList.size()-->"+registeredList.size());
 if(registeredList.size()!=0)
      {
%>
	
		<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.tracking.Back") %></strong><span class="bt_blue_r"></span></a>
		<%
		
			//if(flag == true){
		%>
		    <!--  <input type="button" name=aapp value="Approve" class="buttons" onclick="approvefun()">	    
		    <a href="#" class="bt_green" onclick="allocatefun()"><span class="bt_green_lft"></span><strong>Allocate</strong><span class="bt_green_r"></span></a>-->	
		   <%
			//}
		   %>
			


<%
}
 else
	{
	%>
	<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.tracking.Back") %></strong><span class="bt_blue_r"></span></a>

	<%
	}
	%>


<input type='hidden' name='user_mode' value='none'>
<input type='hidden' name='stdscheduleid' value='<%=stdscheduleid%>'>
<input type='hidden' name='sectionSchedId' value='<%=secSchedId%>'>

<input type='hidden' name='studentallocationid' value='<%=studentallocationid%>'>







  	</td>
 						</table></td><td></td></tr>

						</table>

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