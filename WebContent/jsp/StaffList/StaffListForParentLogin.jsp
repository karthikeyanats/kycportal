<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.stafflistparent.entrytitle") %>| Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script language='javascript'>

function backfun()
{

document.f1.action= "StudentDiary.jsp";
			document.f1.submit();

}

</script>
</head>
<body>
<div id="main_container">

<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">
<h2><%=bundle.getString("label.stafflistparent.entryheading") %> </h2>

<form name="f1" method="post" action=""><%@ page
	import="java.util.*"%> <%
 
 %> 
  <%@ page import="com.iGrandee.StaffList.StaffEntry"%>

<%
StaffEntry studentquery = new StaffEntry(); 
ArrayList classTeacherList=new ArrayList();
ArrayList staffDetails=new ArrayList();
HashMap staffDetailsmap=null;
HashMap classTeacherListmap = null;
	String sectionscheduleid	= (String)session.getValue("sectionscheduleid");
	staffDetails=studentquery.ListstaffDetailsForStudent(sectionscheduleid);
	classTeacherList=studentquery.showClassTeacher(sectionscheduleid);
%>
<form name="f1" method="post" action="">



						<table id="rounded-corner" border=0 summary="Department List" width="100%">
					    <thead>
					    	<tr>
					        	
					            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.stafflistparent.StudentDetails") %></th>
					            <th scope="col" class="rounded-q4" width="2%"></th>
					        </tr>
					    </thead>
					    <tr>		
					    	<td colspan='2'>					
				
								<%
									out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
									out.print("<tr><td width='17%' class='tablebold'>"+bundle.getString("label.stafflistparent.StudentName")+"</td><td width='1%' class='tablebold'>:</td><td>"+session.getValue("studentname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.stafflistparent.AcademicYear")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
									if(session.getValue("groupname") == null)
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.stafflistparent.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"</td></tr>");
									else
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.stafflistparent.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.stafflistparent.SectionName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sectionname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.stafflistparent.BoardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("boardname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.stafflistparent.MediumName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("mediumname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.stafflistparent.RollNo.")+"</td><td class='tablebold'>:</td><td>"+session.getValue("rollno") + "</td></tr>");

									out.print("</table>");
								%>	
							</td>
						</tr>
					</table>
					<br>
					
<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	height="100%" cellpadding=0>
	<tr>
	
	<table  id="rounded-corner" border=0 cellspacing=0 cellpadding=0 width="100%">
<thead>
			<tr>
							<th scope="col" class="rounded-company" width="90%">
							<%=bundle.getString("label.stafflist.classteacher")%>
							</th>
							<th scope="col" class="rounded-q4" width="10%" ></th>
				</tr>
				</thead>
				
	 <%
					    
					    if(classTeacherList!=null && classTeacherList.size()>0)
						{//uname, mobilenumber, emailid, imagepath, qualification, subjectname, staffid, staffcategoryid, subjectscheduleid, standardscheduleid, personid, subjectypename
							for(int i=0,j=1;i<classTeacherList.size();i++,j++)
							{
								out.print("<tr valign='top'>");
								classTeacherListmap=(HashMap)classTeacherList.get(i);
								prefix = (String) classTeacherListmap.get("prefix");
								String qualification = (String) classTeacherListmap.get("qualification");
								String firstname = (String) classTeacherListmap.get("firstname");
								String middlename = (String) classTeacherListmap.get("middlename");
								if(middlename.equals("") || middlename.equals("-"))
									middlename = "";
								String lastname = (String) classTeacherListmap.get("lastname");
								String landlinenumber = (String) classTeacherListmap.get("landlinenumber");
								String mobilenumber = (String) classTeacherListmap.get("mobilenumber");
								String emailid = (String) classTeacherListmap.get("emailid");
								String imagepath = (String) classTeacherListmap.get("imagepath");
								String departmentname = (String) classTeacherListmap.get("departmentname");
								String rolename = (String) classTeacherListmap.get("rolename");
								String sex = (String) classTeacherListmap.get("sex");
								
								String fullname = firstname+" "+middlename+" "+lastname;
					    %>			

		<tr>
		<td colspan=2>
			<table border=0 cellspacing=0 cellpadding=0 width="100%">
			<tr>
				<td class=tablebold  width='17%'><%=bundle.getString("label.studentprofile.Name")%></td><td width='1%' class='tablebold'>:</td><td><%=prefix%> <%=fullname%>, <%=qualification%></td><td rowspan=5 align=center><img
						src="<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=imagepath%>"
						name='stphoto_img1' id=stphoto_img width=120 height=130></td>
			</tr>
			<tr>
							<td class=tablebold><%=bundle.getString("label.stafflist.department")%></td><td width='1%' class='tablebold'>:</td><td><%=departmentname%></td>
			</tr>
			<tr>
							<td class=tablebold><%=bundle.getString("label.stafflist.role")%></td><td width='1%' class='tablebold'>:</td><td><%=rolename%></td>
			</tr>
			<tr>
										<td class=tablebold><%=bundle.getString("label.stafflist.landlinenumber")%></td><td width='1%' class='tablebold'>:</td><td><%=landlinenumber%></td>
			</tr>
			<tr>
										<td class=tablebold><%=bundle.getString("label.stafflist.mobilenumber")%></td><td width='1%' class='tablebold'>:</td><td><%=mobilenumber%></td>
			</tr>


		<tr>
			<td class=tablebold>
				<%=bundle.getString("label.stafflist.emailid")%>
			</td>
			<td width='1%' class='tablebold'>:</td><td><a href="mailto:<%=emailid %>"><%=emailid %></a></td>
			
		</tr>
	</table>
	</tr>
	<%}}
	else
	{
		out.println("<tr><td colspan=2>Class teacher not yet assigned</td>");
	}%>
	
	</tr>
	
	</TABLE>					
					
<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	height="100%" cellpadding=0>
	

	
<br>
	
		<tr>
		<td valign='top'>
				<table border=0 id="rounded-corner" width="80%">

			<thead>
				<tr>
        	<th scope="col" class="rounded-company" width="10"><%=bundle.getString("label.stafflistparent.SL.No") %></th>
        	<th scope="col" class="rounded" width="15%"><%=bundle.getString("label.stafflistparent.SubjectName") %>  </th>
  	        	<th scope="col" class="rounded" width="15%"><%=bundle.getString("label.stafflistparent.SubjectType") %> </th>
  	        	<th scope="col" class="rounded-q4" width="60%"><%=bundle.getString("label.stafflistparent.StaffDetails") %>  </th>
  	        	
  	        	
        	
            
        </tr>
    </thead>
    <%
   
    %>
    <tfoot>
    	<tr>
        	<td colspan=3  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
        </tr>
    </tfoot>
   <tbody>
   
		
				<%
				String photo="";
				//out.println(staffDetails);
				if(staffDetails!=null && staffDetails.size()>0)
				{//uname, mobilenumber, emailid, imagepath, qualification, subjectname, staffid, staffcategoryid, subjectscheduleid, standardscheduleid, personid, subjectypename
					for(int i=0,j=1;i<staffDetails.size();i++,j++)
					{
						out.print("<tr valign='top'>");
						staffDetailsmap=(HashMap)staffDetails.get(i);
						photo = (String) staffDetailsmap.get("imagepath");
						
						out.print("<td valign='top'>"+j+"</td>");
						out.print("<td valign='top'>"+staffDetailsmap.get("subjectname")+"</td>");
						String subjectypename=(String)staffDetailsmap.get("subjectypename");
						if(subjectypename == null || subjectypename.equals("") || subjectypename.equals("-") || subjectypename.equalsIgnoreCase("null"))
							subjectypename="-";
						else
							subjectypename=(String)staffDetailsmap.get("subjectypename");
						String qualification=(String)staffDetailsmap.get("qualification");
						if(qualification == null || qualification.equals("") || qualification.equals("-") || qualification.equalsIgnoreCase("null"))
							qualification="";
						else
							qualification=(String)staffDetailsmap.get("qualification");
						out.print("<td>"+subjectypename+"</td>");
						out.print("<td ><table border=0 ><tr valign='top'><td rowspan=4 ><img src='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+staffDetailsmap.get("imagepath")+"' name='stphoto_img1' id=stphoto_img  title='' border='0'  width='120' height='120'/></td><tr><td>Name:"+staffDetailsmap.get("uname")+"&nbsp;"+qualification+"</td></tr><tr><td>Mobile:"+staffDetailsmap.get("mobilenumber")+"</td></tr><tr><td>Email ID:<a href=mailto:"+staffDetailsmap.get("emailid")+">"+staffDetailsmap.get("emailid")+"</a></td></tr></table></td>");

						out.print("</tr>");
					}
				}
				else
				{
					out.println("<td colspan='4' align=center><font color='red'><b>Data Not Found</b></font></td>");
					//out.print("<td colspan=4>Data Not Found</td>");
	
				}
				%>
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