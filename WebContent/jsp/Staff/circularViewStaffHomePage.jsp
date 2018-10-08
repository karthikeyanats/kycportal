<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
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
	src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/csspopup.js"></script>

<script language='javascript'>


	
	
	function backfun(){
	
		document.wprkallotment.action = "StaffHomepage.jsp";
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

<h2> Dashboard / Circular Details</h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%> <%@ page
	language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>

	
	<%@ page
					import="com.iGrandee.Parent.ParentHome"%>
<%
	//ResourceBundle bundle = ResourceBundle.getBundle("ResourceBundle.English_en");
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

	ArrayList circulararray=new ArrayList();
	ArrayList institutearray=new ArrayList();
	HashMap circularmap=null;
	HashMap institutemap=null;
	circulararray=parentquery.CircularViewListForStudentPage(circularid);
	
	 institutearray=parentquery.InstituteDetailForCircularStudentPage(instituteid);

	
	//out.println(circulararray);
	
	//out.println(institutearray);

	
	
	  
	
	
	
	
	
	
%> <jsp:useBean id="common_data_object" scope="page"
	class="com.iGrandee.Common.CommonDataAccess" />
<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
<div id="blanket" style="display: none;"></div>
<div id="popUpDiv" style="display: none;"><a href="#"
	onclick="popup('popUpDiv')">Click Me To Close</a>
<table id="newTable" width='100%' height="100%" align="center">
</table>
</div>
<form name='wprkallotment' method='post'><input type="hidden"
	name="circularid" value="">
<table class="bodyinnercolor" border='0' align="center" width="100%"
	height='100%' cellspacing=0 cellpadding=0>
	<tr>
		<td width='100%' align='center'>
		<table border=0 bordercolor='blue' align="center" width="80%"
			cellspacing=0 cellpadding=0>
			<tr>
				<td align='left' width='100%' height='100%'>
				<table border='0' align="center" width="100%" cellspacing=5
					cellpadding=0>

					<tr height='25'>
						<td valign='top'>
						<table border='0' align="center" width="100%" height="100%"
							cellspacing=5 cellpadding=0>
							<tr>
								<td>
								<table id="rounded-corner" border=0 summary="Department List"
									width="50%" height="50%">
									<thead>
										<tr>
											<th scope="col" class="rounded-company" width="1%"></th>
											<th scope="col" class="rounded" width="48%">Circular Details 
											</th>
											<th scope="col" class="rounded" width="1%"></th>
											<th scope="col" class="rounded-q4" width="1%"></th>
										</tr>
									</thead>
									<tr>  
										<td colspan='4'>

										<table border='0' align="center" width="80%" cellspacing=0
											cellpadding=5>
											
											<%
											String createdby="";
											String photo="";
											String attachments="";
											String dept="";
											String getrole="";
											String departmentname="";
											HashMap getDepartmentmap =null;
											if(institutearray != null ||institutearray.size()>0 )
											{
												for(int i=0;i<institutearray.size();i++)
												{
													institutemap=(HashMap)institutearray.get(i);

													 photo=(String)institutemap.get("institutelogo");
													 
												//out.print("<tr><td align='left'  class='tablebold'><img src='/kycportal/OpenDocument?r1=storagepath&r2="+photo+"' name='stphoto_img1' id=stphoto_img width=120 height=130></td>");
													out.print("<tr><td align='center' colspan='8' class='tablebold'>"+(String)institutemap.get("institutename")+"</td></tr>");

												}
												
											}
											else
											{
											}
											if(circulararray!=null || circulararray.size()>0)
											{
												for(int j=0;j<circulararray.size();j++)   
												{
													
													circularmap=(HashMap)circulararray.get(j);
													attachments=(String)circularmap.get("attachments"); 
													createdby=(String)circularmap.get("createdby");//
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
													 dept="Administrator"	;
													}
													else if(usercategory.equals("HM"))
													{
														 dept="Head Master";	
													}
													out.print("<tr><td align='right' class='tablebold'>Date :</td><td class='tablelight'>"+(String)circularmap.get("dateofcreation")+"</td></tr>");
													out.print("<tr><td class='tablebold'>&nbsp;&nbsp;&nbsp;&nbsp;Subject :&nbsp;&nbsp;<a class='tablelight'>"+(String)circularmap.get("subject")+"</a></td></tr>");
													out.print("<tr><td class='tablelight'  >"+(String)circularmap.get("details")+"</td></tr>");
													
													out.print("<tr><td class='tablebold'  align='right' colspan='2'>Created By</td></tr><tr><td align='right'  class='tablelight' colspan='2'>"+circularcreatedby+"</td></tr>");
													out.print("<tr><td class='tablelight'' colspan='4' align='right'>["+dept+"]</td></tr>");
													out.print("<tr><td class='tablelight'' colspan='4' align='right'>["+departmentname+"]</td></tr>");
													
													if(attachments==null || attachments.equals("") || attachments.equalsIgnoreCase("null"))
													{
														out.print("<tr><td class='tablebold'>Attachments :</td><td class='tablelight'></td></tr>");
														
														out.print("<tr><td class='tablelight'>There is no Attachments </td><td class='tablelight'></td></tr>");

												   	}
													else
													{   
														out.print("<tr><td colspan='4' class='tablebold'>Attachments :&nbsp;&nbsp;<a href='#' attachments='"+attachments+"' onclick=windopen(this)>View</a></td></tr>");

													}
														

	
													
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
				</td>

			</tr>


		</table>
		</td>
	</tr>
</table>


		  <a href="#" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong>BACK</strong><span class="bt_blue_r"></span></a>

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