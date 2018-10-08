<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/csspopup.js"></script>

<script language='javascript'>


	
	
	function backfun(){
	
		document.wprkallotment.action = "TimeTable.jsp";
		document.wprkallotment.submit();
	}
	

	function windopen(obj)
	{
   var attachments=obj.getAttribute("attachments");
	window.open("<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2="+attachments);
	}

</script>
<style type="text/css">
</style>
</head>
<body>
<div id="main_container">
<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">
<body >
<h2>  <%=bundle.getString("label.adminportal.circularviewrootpath") %>
</h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%> <%@ page
	language="java"
	import="java.util.ArrayList,java.util.HashMap"%>

	
	<%@ page
					import="com.iGrandee.Parent.ParentHome"%>
<%
ParentHome parentquery = new ParentHome();
	HashMap hashmap = null;
	String standardscheduleid = (String) session
			.getValue("standardscheduleid");
	String studentid = (String) session.getValue("studentid");

	String sectionid = request.getParameter("section");
	String instituteid = (String) session.getValue("instituteid");
	String sectionscheduleid = (String) session
			.getValue("sectionscheduleid");
	String userid = (String) session.getValue("userid");
	
	String circularid=request.getParameter("circularid");

	ArrayList circulararray=null;
	ArrayList institutearray=null;
	HashMap circularmap=null;
	HashMap institutemap=null;
	circulararray=parentquery.CircularViewListForStudentPage(circularid);
	
	 institutearray=parentquery.InstituteDetailForCircularStudentPage(instituteid);
	 
	
%> 

<form name='wprkallotment' method='post'><input type="hidden"
	name="circularid" value="">
<table class="bodyinnercolor" border='0' align="center" width="100%"
	height='100%' cellspacing=0 cellpadding=0>
	<tr>
		<td width='100%' align='center'>
		
						<table border='0' align="center" width="100%" 
							cellspacing=5 cellpadding=0>
							<tr>
								<td>
								<table id="rounded-corner" border=0 
									width="50%" height="50%">
									<thead>
										<tr>
											
											<th scope="col" class="rounded-company" width="48%"> <%=bundle.getString("label.adminportal.CircularDetails") %>
 											</th>
											<th scope="col" class="rounded" width="1%"></th>
											<th scope="col" class="rounded-q4" width="1%"></th>
										</tr>
									</thead>
									<tr>  
										<td colspan='3'>

										<table border='0' align="center" width="90%" cellspacing=0
											cellpadding=5>
											
											<% 
											String createdby="";
											String photo="";
											String attachments="";
											String dept="";
											String getrole="";
											String departmentname="";
											HashMap getDepartmentmap =null;
											String uname = "";
											if(institutearray != null ||institutearray.size()>0 )
											{
												for(int i=0;i<institutearray.size();i++)
												{
													institutemap=(HashMap)institutearray.get(i);

													 photo=(String)institutemap.get("institutelogo");
													     
													out.print("<tr><td align='center' colspan='5' class='tablebold'>"+(String)institutemap.get("institutename")+"</td></tr>");

												}
												
											}
											
											if(circulararray!=null || circulararray.size()>0)
											{
												for(int j=0;j<circulararray.size();j++)   
												{
													
													circularmap=(HashMap)circulararray.get(j);
													attachments=(String)circularmap.get("attachments"); 
													createdby=(String)circularmap.get("createdby");
													uname=(String)circularmap.get("uname");
													String circularcreatedby=(String)parentquery.getCreatename(createdby);
													ArrayList getDepartment=parentquery.getDepartment(createdby);
													for(int k=0;k<getDepartment.size();k++)
													{  
														getDepartmentmap=(HashMap)getDepartment.get(k);
													usercategory=(String)getDepartmentmap.get("usercategory");
													departmentname=(String)getDepartmentmap.get("departmentname");

													}
													if(usercategory.equals("SA"))
													{
													 dept="Administrator";
													}
													else if(usercategory.equals("HM"))
													{
														 dept="Head Master";	
													}                 
													out.print("<tr align='right'><td colspan=5 ><a class='tablebold'>"+bundle.getString("label.adminportal.Date")+":</a>&nbsp;&nbsp;<a class=tablelight>"+(String)circularmap.get("dateofcreation")+"</a></td></tr>");
													out.print("<tr><td  colspan=5><a class='tablebold'>"+bundle.getString("label.adminportal.Subject")+":</a>&nbsp;&nbsp;  <a class='tablelight'>"+(String)circularmap.get("subject")+"</a></td></tr>");
													out.print("<tr><td class='tablelight' colspan='5' align='justify'>"+(String)circularmap.get("details")+"</td></tr>");
													if(attachments==null || attachments.equals("") || attachments.equalsIgnoreCase("null"))
													{ 
														out.print("<tr><td class='tablebold' colspan='5'>"+bundle.getString("label.adminportal.Attachments")+"</td></tr>");
														out.print("<tr><td class='tablelight' colspan='5'>There is no Attachments </td></tr>");

												   	} 
													else
													{   
														out.print("<tr><td colspan='5'><a  class='tablebold'>"+bundle.getString("label.adminportal.Attachments")+" :</a>&nbsp;&nbsp;<a href='#' attachments='"+attachments+"' onclick=windopen(this)>"+bundle.getString("label.adminportal.View")+"</a></td></tr>");

													} 
													//out.print("<tr><td class='tablebold'  align='right' colspan='5'>"+bundle.getString("label.adminportal.CreatedBy")+"</td></tr><tr><td align='right'  class='tablelight' colspan='5'>"+circularcreatedby+"</td></tr>");
													out.print("<tr><td class='tablebold'  align='right' colspan='5'>"+bundle.getString("label.adminportal.CreatedBy")+"</td></tr><tr><td align='right'  class='tablelight' colspan='5'>"+uname+"</td></tr>");
													
													out.print("<tr><td class='tablelight'' colspan='5' align='right'>["+dept+"]</td></tr>");
													out.print("<tr><td class='tablelight'' colspan='5' align='right'>["+departmentname+"]</td></tr>");
													
												}   
											}
											%>
											
										</table>                       
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>

				</table>
	


</form>
</div>
<!-- end of right content--></div>
<!--end of center content -->




<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>


</div>
</body>
</html>