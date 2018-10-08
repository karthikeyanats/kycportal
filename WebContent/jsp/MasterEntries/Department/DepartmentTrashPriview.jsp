<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Department.DepartMentEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Department.DepartmentBean" />
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.department.trashpreviewlisttitle") %> </title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script language="JavaScript">

function goToBack()
{
	document.MainForm.action= "DepartmentList.jsp";
document.MainForm.submit(); 
}
function goToTrash()
{
if(confirm("Do you want to trash the Department...?"))
{
	document.MainForm.action= "DepartmentTrash.jsp";
document.MainForm.submit();
}
else{}
}
</script>
</head>

<body>
<form name="MainForm" method="post" action="">

<div id="main_container">

	<div class="header">
	
<%@ include file="../../include/userheader.jsp" %>
   
	   </div>

    <div class="main_content">
    
<%@ include file="../../include/header.jsp" %>
    <div class="center_content">

     <div class="left_content">

    </div>

    <div class="right_content">
         <h2><%=bundle.getString("label.department.trashpreviewlistrootpath") %> </h2>
     
<%@ page language="java" import="java.util.*"%>
<%

	String Deptid 			= request.getParameter("Deptid");
	instituteBean.setDepartmentid(Deptid);
	String deptcount		= query_object.checkTrashDepts();

	
	

	ArrayList getDetailsForuadate=query_object.getDetailsForuadate(Deptid);
	HashMap DetailsForuadate=null;
	String departmentname=null;
	String description=null;
	for(int k=0;k<getDetailsForuadate.size();k++)
	{
		DetailsForuadate=(HashMap)getDetailsForuadate.get(k);
		 departmentname=(String)DetailsForuadate.get("departmentname");
		 description=(String)DetailsForuadate.get("description");

	}
	if(departmentname!= null)
	if(description.equals(""))
	{
	description="-";
	}
	
	
%>
<form name="MainForm" method="post" action="">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	

	<tr>
		<td>
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.department.trashpreviewtableheading") %></th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
			<tr bordercolor=white>
				<td  class="tablebold" width='25%' ><%=bundle.getString("label.department.departmentname") %> </td><td width='1%' class='tablebold'>:</td><td class="tablelight"><%=departmentname %></td>
			</tr>
			<tr bordercolor=white>
				<td  class="tablebold" width='25%'><%=bundle.getString("label.department.description") %> </td><td width='1%' class='tablebold'>:</td><td class="tablelight"><%=description %></td>
			</tr>
			<tr bordercolor=white>
				<td  class="tablebold" width='25%'><%=bundle.getString("label.department.trashpreviewerrormessage") %></td><td width='1%' class='tablebold'>:</td><td class="tablelight"><%=deptcount%></td>
			</tr>
			
			</thead>
									</table>
			
		<br>
		<a href="#" onclick="goToBack()"class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.department.back") %> </strong><span class="bt_blue_r"></span></a>	
			 <%
			if(deptcount.equals("0") )
			{%>
     <a href="#" class="bt_green" onclick="goToTrash()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.department.trash") %> </strong><span class="bt_blue_r"></strong><span class="bt_green_r"></span></a>
	 <%}
	 else
	 {
		 out.println("<div class='warning_box'>");
	 	out.println("<a align=left class='tablebold'>"+bundle.getString("label.department.trashpreviewerrormessagedetails") +"</a>");
		 out.println(" </div>");

	 }%>
	 
	 
	 
	<input type="hidden" name="Deptid" value="<%=Deptid %>">
	
</TABLE>
</div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>