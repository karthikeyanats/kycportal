<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Alumni Student List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />


<script type="text/javascript">

function goBack()
{
	document.tcgenerationForm.action="aluminiSelect.jsp";
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

    <h2>Certificate / Alumni Students / Alumni Students View</h2>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	
            <th scope="col" class="rounded-company" width="90%">Selected Information </th>
            <th scope="col" class="rounded-q4" width="10%"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>


	 <%
	 	com.iGrandee.TCGeneration.TCGenerationQuery  tcgenerationQuery = new com.iGrandee.TCGeneration.TCGenerationQuery();	
	 
		String profileName=null;
		String mobileNumber=null;
		String emailId=null;
		String applicantName=null;
		String applicationNo=null;
		String studentallocationId="";
		String rollNo="";
		String sessionid=request.getParameter("reg_sessionid");
 		String boardid=request.getParameter("reg_boardid");
 		String stdscheduleid=request.getParameter("course");
 		ArrayList registeredList= null;
		registeredList	=	(ArrayList)tcgenerationQuery.listAluminiStudents(request.getParameter("req_sectionpubid"),"A");
       %>

			<br>

		<tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">
		<tr>
			<td class=tablebold width="25%">Academic Year</td><td class=tablebold>:</td><td class=tablelight ><%=request.getParameter("req_sessionname") %></td>
			<td class=tablebold>Board </td><td class=tablebold>:</td><td    class=tablelight><%=request.getParameter("req_boardname") %></td>
		</tr>
		<tr><td class=tablebold width="25%">Standard</td><td class=tablebold>:</td><td class=tablelight><%=request.getParameter("standardnamegp") %></td>
		<td class=tablebold width="25%">Section</td><td class=tablebold>:</td><td class=tablelight><%=request.getParameter("req_sectionname")%></td>
		</tr>
		</table>
		</td></tr>
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
		            <th scope="col" class="rounded" width="10%">Roll No</th>		            
		            <th scope="col" class="rounded" width="20%">Contact No</th>
		            <th scope="col" class="rounded-q4" width="20%">E-Mail</th>
		        </tr>
		    </thead>
		    <tfoot>
		    	<tr>
		        	<td colspan="5" class="rounded-foot-left"><em></em></td>
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
						profileName				=	(String) map.get("profilename");
						mobileNumber			=	(String) map.get("mobilenumber");
						emailId					=	(String) map.get("emailid");
						//applicantName			=	(String) map.get("applicantname");
						applicationNo			=	(String) map.get("applicationno");
						studentallocationId		=	(String) map.get("studentallocationid");
						rollNo					=	(String) map.get("rollno");
				
						if(mobileNumber==null)
							mobileNumber = "-";
						
						if(emailId==null)
							emailId = "-";
						
						if(rollNo==null)
							rollNo = "-";
			
						out.print("<tr><td>"+(i+1)+"</td><td>"+profileName+"</td><td>"+applicationNo+"</td><td>"+rollNo+"</td><td>"+mobileNumber+"</td><td><a href=mailto:"+emailId+">"+emailId+"</a></td>");
					}
				}
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
				}		
			%>
		</table>
		</table>
		<br>

		 <a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>			


<input type='hidden' name='stdscheduleid' value='<%=stdscheduleid%>'>
<input type='hidden' name='req_sectionpubid' value='<%=request.getParameter("req_sectionpubid")%>'>

<input type='hidden' name='studentallocationid' value='<%=studentallocationId%>'>

<input type='hidden' name='req_sessionname' value='<%=request.getParameter("req_sessionname")%>'>
<input type='hidden' name='req_boardname' value='<%=request.getParameter("req_boardname")%>'>
<input type='hidden' name='standardnamegp' value='<%=request.getParameter("standardnamegp")%>'>
<input type='hidden' name='req_sectionname' value='<%=request.getParameter("req_sectionname")%>'>


    

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</form>
</body>

</html>