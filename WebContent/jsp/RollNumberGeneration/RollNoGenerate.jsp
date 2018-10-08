<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Roll No. Generation | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/jquery-1.9.1.min.js"></script>

<script type="text/javascript">

	function generateRollNofun()
	{
		
		if(check_ForParticularElements(document.approvalForm.chk,"checkbox"))
		{
			
			for(var i=0;i<document.approvalForm.chk.length-1;i++){

				if(document.approvalForm.chk[i].checked){
					
					if(!check_ForParticularElements(document.approvalForm.rollno[i],"text")){
						return false;
					}
				}
			}

			if(confirm("Do you want to generate the Roll no for the Student..?")){
				
				
				for(var i=0;i<document.approvalForm.chk.length-1;i++){

					if(!document.approvalForm.chk[i].checked){
						
						document.approvalForm.rollno[i].disabled	= true;
					}
				}

				document.approvalForm.action	= "./generateRollNoSubmit.jsp";
	    	  	document.approvalForm.submit();
			}
			else
    	  		alert("Roll No. should be generated for all the students.\nFees can be collected and Exam mark can be entered using this Roll No. only.");

		}
	}


	function selectallfun(obj)
	{
		console.log("test");
		if(obj.checked){
			
			if(document.approvalForm.chk.length)
			for(var x=0;x<document.approvalForm.chk.length;x++)
			{
				document.approvalForm.chk[x].checked=true;
			}
		}
		else{

			if(document.approvalForm.chk.length)
			for(var x=0;x<document.approvalForm.chk.length;x++)
			{
				document.approvalForm.chk[x].checked=false;
			}
			
			arrs.pop(rollno);
		}
	}

	function goBack()
	{
		document.approvalForm.action="RollNoGenSelect.jsp";
		document.approvalForm.submit();
	}
	
   
</script>
</head>

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

    <h2>Enrollment / Student Enrollment / Roll No. Generation</h2>


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
 		//out.println("sessionid==>"+sessionid);
 		String stdscheduleid=request.getParameter("standardpublishid");
 		//out.println("stdscheduleid==>"+stdscheduleid);
 		String yearofsession=request.getParameter("req_sessionname");
		String batchName=request.getParameter("req_boardname");
		String courseName=request.getParameter("standardnamegp");
		String secName=request.getParameter("req_sectionname");
		String secSchedId=request.getParameter("req_sectionpubid");
		//out.println("secSchedId-->"+secSchedId+"secName-->"+secName);
		int digits = 3;
		ArrayList registeredList= null;

		//out.println("<script>alert('"+sessionid+"')</script>");
		//	out.println("<script>alert('"+batchid+"')</script>");
		//out.println("<script>alert('"+secSchedId+"')</script>");
		//registeredList	=	(ArrayList)registrationQuery.displayAllocatedDetails(sessionid,stdscheduleid,secSchedId);
		registeredList	=	(ArrayList)registrationQuery.displayAllocatedDetails(secSchedId);
       %>

			<br>

<tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%">Academic Year</td><td class=tablebold width='2%'>:</td><td class=tablelight ><%=yearofsession %></td>
	<td class=tablebold>Board </td><td class=tablebold width='2%'>:</td><td  colspan=2  class=tablelight><%=batchName %></td>
</tr>
<tr><td class=tablebold width="25%">Standard</td><td class=tablebold width='2%'>:</td><td class=tablelight><%=courseName %></td>
<td class=tablebold width="25%">Section</td><td class=tablebold width='2%'>:</td><td class=tablelight><%=secName%></td>
</tr>
<tr><td class=tablebold width="25%">Roll No. Prefix</td><td class=tablebold width='2%'>:</td><td class=tablelight><%=request.getParameter("rollnoprefix") %></td>
</tr>
</table>
</td></tr>
</table>

<table border=0 cellpadding=5 cellspacing=0 align=center width="80%" rules=groups>
<% 
	if(registeredList.size()!=0)
	{
		out.print("<br>");
	}
	else
	{
		out.print("<br>");
	}
%>
<table id="rounded-corner" border=0 width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="7%">Sl.No</th>
            <th scope="col" class="rounded" width="20%">Student Name</th>
            <th scope="col" class="rounded" width="15%">Application No.</th>
            <th scope="col" class="rounded" width="20%">Roll No.</th>
            <th scope="col" class="rounded" width="25%">Date of Allocation</th>
            <th scope="col" class="rounded" width="10%">Roll No. Status</th> 
            <th scope="col" class="rounded-q4" width="5%">Check<input type='checkbox' name='chkAll' onclick='selectallfun(this)'></input></th>            
                      
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
	 int datacount=0;
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

			StringBuffer s = new StringBuffer(digits);
			int zeroes = digits - (int) (Math.log(count) / Math.log(10)) - 1; 
			for (int j = 0; j < zeroes; j++) {
			s.append(0);
			}
			
			if(rollNo==null)
				rollNo = request.getParameter("rollnoprefix")+s.append(count).toString();

			out.print("<tr><td>"+(i+1)+"</td><td>"+applicantName+"</td><td>"+applicationNo+"</td><td><input type='text' name='rollno' id='amount"+i+"' value='"+rollNo+"' validate='Roll Number' size='15' maxlength='15'></td><td>"+dateofallocation+"</td>");
			//out.print("<tr><td>"+(i+1)+"</td><td>"+applicantName+"</td><td>"+applicationNo+"</td><td><input type=text size='10' name='rollno' value='"+rollNo+"' readonly></td><td>"+dateofallocation+"</td>");
			//out.println("<td align='left'><input type='checkbox' name='chk' rollNo="+rollNo+" rowNo="+(count-1)+" value="+studentallocationid+"@"+count+" onclick=chkval(this)></td></tr>");
			if(rollgenerationStatus.equals("NotGenerated")){
				out.println("<td align='left'><font color=red><i>-NYG-</i></font></td>");
				datacount++;
			}
			else{
				out.println("<td align='left'>"+rollgenerationStatus+"</td>");
			}
			
			out.print("<td><input type='checkbox' name='chk' value="+studentallocationid+" rollno="+rollNo+" id='checkbox"+i+"' position="+i+"  validate='Student'></td></tr>");
			
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
<%
//out.print("registeredList.size()-->"+registeredList.size());
 if(registeredList.size()!=0)
      {
		 if(datacount>0){
			 out.print("<tr><td><b>Note: </b></td><td>&nbsp;</td><td>NYG - Not Yet Generated</br></td></tr><br>");
			 out.print("<div class=warning_box>Fees can be collected and Exam mark can be entered using this Roll No. only.</div>");
		 %>
  			    		 
		 <%	
		 }
		 
%>
	
		<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		<%
		//if(datacount>0) 
		//{
			
		%>
		<a href="#" class="bt_green" onclick="generateRollNofun()"><span class="bt_green_lft"></span><strong>Generate / Update Roll No</strong><span class="bt_green_r"></span></a>
		<%
		//}
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
	<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>

	<%
	}
	%>



<input type='hidden' name='chk' 	disabled>
<input type='hidden' name='rollno' 	disabled>

<input type='hidden' name='hiddenrollno' value=''>
<input type='hidden' name='user_mode' value='none'>
<input type='hidden' name='stdscheduleid' value='<%=stdscheduleid%>'>
<input type='hidden' name='sectionSchedId' value='<%=secSchedId%>'>
<input type='hidden' name='studentallocationid' value='<%=studentallocationid%>'>

	<input type=hidden name="req_sessionname" value = "<%=request.getParameter("req_sessionname")%>">
	<input type=hidden name="req_sessionid" value = "<%=request.getParameter("req_sessionid")%>">
	<input type=hidden name="req_boardname" value = "<%=request.getParameter("req_boardname")%>">
	<input type=hidden name="req_boardid" value = "<%=request.getParameter("req_boardid")%>">
	<input type=hidden name="standardnamegp" value = "<%=request.getParameter("standardnamegp")%>">
	<input type=hidden name="standardpublishid" value = "<%=request.getParameter("standardpublishid")%>">
	<input type=hidden name="req_sectionname" value = "<%=request.getParameter("req_sectionname")%>">
	<input type=hidden name="req_sectionpubid" value = "<%=request.getParameter("req_sectionpubid")%>">
	<input type=hidden name="rollnoprefix" value = "<%=request.getParameter("rollnoprefix")%>">
	<input type=hidden name="req_instituteid" value = "<%=session.getValue("instituteid")%>">
	<input type=hidden name="datacount" value = "<%=datacount%>">
	
	
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