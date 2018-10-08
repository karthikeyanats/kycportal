<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.classmates.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>

<script language='javascript'>


	
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

    <h2><%=bundle.getString("label.classmates.rootpath")%></h2>
    
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>
<%
	try{
	String sectionid				= (String)session.getValue("sectionscheduleid");
	String studentid				= (String)session.getValue("studentid");
	RegistrationProcess	classmate	= new RegistrationProcess();
	HashMap	hashmap					= null;
	ArrayList studentList			= classmate.displayclassmateDetails(sectionid,studentid);
%>    
    
    
	<form name='workallotment' method='post'>
		<table class="bodyinnercolor" border=0 bordercolor='red' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
				 <%
	if(session.getValue("usercategory").equals("P")){%> 
				<table id="rounded-corner" border=0 summary="Department List" width="100%">
					    <thead>
					    	<tr>
					        	
					            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.classmates.StudentDetails") %></th>
					            <th scope="col" class="rounded-q4" width="2%"></th>
					        </tr>
					    </thead>
					    <tr>		
					    	<td colspan='2'>					
				
								<%
									out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
									out.print("<tr><td width='17%' class='tablebold'>"+bundle.getString("label.classmates.StudentName")+"</td><td width='1%' class='tablebold'>:</td><td>"+session.getValue("studentname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.classmates.AcademicYear")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
									if(session.getValue("groupname") == null)
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.classmates.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"</td></tr>");
									else
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.classmates.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.classmates.SectionName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sectionname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.classmates.BoardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("boardname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.classmates.MediumName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("mediumname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.classmates.RollNo.")+"</td><td class='tablebold'>:</td><td>"+session.getValue("rollno") + "</td></tr>");

									out.print("</table>");
								%>	
							</td>
						</tr>
					</table><%} %>
					<br>
										
					<table  border=0 bordercolor='blue' align="center" width="90%" cellspacing=0 cellpadding=0>
						<tr>
							<td width='100%' align='left'>
							
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								        	<th scope="col" class="rounded-company" width="1%"></th>
								            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.classmates.SL.No")%></th>
								            <th scope="col" class="rounded" width="45%"><%=bundle.getString("label.classmates.ClassMateName")%></th>
								            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.classmates.RollNo")%></th>
								            <th scope="col" class="rounded-q4" width="25%"><%=bundle.getString("label.classmates.EMail")%></th>
								            
								        </tr>
								    </thead>
								    						
													<%

													 int count=0;
													boolean flag = false;
													//out.print("registeredList-->"+registeredList.size());
													if(studentList.size()!=0)
													{
														for(int i=0;i<studentList.size();i++)
														{
															count=count+1;
															HashMap map				=	(HashMap)studentList.get(i);
															String applicantName			=	(String) map.get("applicantname");
															String rollNo					=	(String) map.get("rollno");
															String mailid 		=	(String) map.get("emailid");
															
															
															if(rollNo==null)
																rollNo = "-";

															out.print("<tr><td></td><td width='15%'>"+(i+1)+"</td><td width='45%'>"+applicantName+"</td><td>"+rollNo+"</td><td><a href=mailto:"+mailid+">"+mailid+"</a></td></tr>");
															
														}
													}
													else
													  {
														  out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
													  }
													
													
													%>
																										
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<%
		}
		catch(Exception e){}
		%>		
	</form>    
    

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>