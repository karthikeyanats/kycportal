<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleBean" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title><%=bundle.getString("label.role.trashpreviewlisttitle") %></title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script language="JavaScript">
function goToBack()
{
	document.MainForm.action= "RoleList.jsp";
document.MainForm.submit();
}
function goToTrash()
{
if(confirm("Do you want to trash the Role...?"))
{
	document.MainForm.action= "RoleTrash.jsp";
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
         <h2><%=bundle.getString("label.role.trashpreviewlistrootpath")%></h2>
<%@ page import="java.io.*,java.util.*"%>

<%
	String curstatus = "T";

	String roleid 		= request.getParameter("roleid");
	String noofdept		= "";
	String rolecount	= "";
	String noofdesp		= "";
	String noofdesp1	= "";
	HashMap as1			= null;
	instituteBean.setRoleid(roleid);
	String instituteid = (String)session.getValue("instituteid");
	String as=query_object.checkTrashRoles(); 

	instituteBean.setinstituteid(instituteid);
	instituteBean.setStatus(curstatus);
	
	ArrayList getDetailsForuadate=query_object.getDetailsForuadate(roleid); 
	HashMap DetailsForuadate=null;
	String rolename=null;
	String description=null;
	for(int k=0;k<getDetailsForuadate.size();k++)
	{
		DetailsForuadate=(HashMap)getDetailsForuadate.get(k);
		 rolename=(String)DetailsForuadate.get("rolename");
		 description=(String)DetailsForuadate.get("description");

	}
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
        	
        	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.role.trashpreviewtableheading")%> </th>
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
				<td  class="tablebold" width="20%"><%=bundle.getString("label.role.rolename")%> </td><td width="1%" class="tablebold">:</td><td class="tablelight" ><%=rolename %></td>
			</tr>
			<tr bordercolor=white>
				<td  class="tablebold" width="20%"><%=bundle.getString("label.role.description")%> </td><td width="1%" class="tablebold">:</td><td class="tablelight"><%=description %></td>
			</tr>

			<tr bordercolor=white>
				<td  class="tablebold" width="20%"><%=bundle.getString("label.role.trashpreviewerrormessage")%> </td><td width="1%" class="tablebold">:</td><td class="tablelight"><%=as%></td>
			</tr>
			</thead>
		</table>
		<br>
			 	 <a href="#" onclick="goToBack()"class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.role.back")%> </strong><span class="bt_blue_r"></span></a>
		
			 <%
			if(as.equals("0") )
			{%>
			     <a href="#" class="bt_green" onclick="goToTrash()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.role.trash")%></strong><span class="bt_green_r"></span></a>
			
	 <%}
	 else
	 {		 out.print("<div class='warning_box'>");

	 	out.print("<a align=center class='tablebold'>"+bundle.getString("label.role.trashpreviewerrormessagedetails")+" </a>");
		 out.print("</div>");

	 }%>
	 
	<input type="hidden" name="roleid" value="<%=roleid %>">
	
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