<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Group.GroupEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Group.GroupBean" />	
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.group.deactivepreviewlisttitle") %></title>

<LINK rel=stylesheet href="../css/kyccss.css">
<link rel="stylesheet" type="text/css" href="../../../jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="../jsp/kycpanel/niceforms-default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language="JavaScript" src="../../../js/Validation.js"></SCRIPT>
<script type="text/javascript" src="../jsp/jconfirmaction.jquery.js"></script>
<script language="javascript" type="text/javascript" src="niceforms.js"></script>

<script language="JavaScript">

function goToBack()
{
	document.MainForm.action= "GroupList.jsp";
document.MainForm.submit();
}
function goToDeactive()
{
if(confirm("Do you want to Deactivate the Group...?"))
{
	document.MainForm.action= "GroupDeactiveFinal.jsp";
document.MainForm.submit();
}

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
         <h2><%=bundle.getString("label.group.deactivepreviewlistrootpath") %></h2>

<%@ page language="java" import="java.util.*"%>
<%

	String groupid = request.getParameter("groupid");
	String newdates = request.getParameter("newdates");
String curstatus="D";

instituteBean.setgroupid(groupid);

String as=query_object.checkTrashgroup((String)session.getValue("instituteid")+"");
ArrayList getDetailsForuadate=query_object.getDetailsForuadate(groupid);    
HashMap DetailsForuadate=null;
String groupname=null;
String description=null;
for(int k=0;k<getDetailsForuadate.size();k++)
{
	DetailsForuadate=(HashMap)getDetailsForuadate.get(k);
	groupname=(String)DetailsForuadate.get("groupname");
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
	
	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
        	<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.group.deactivepreviewtableheading") %></th>
        	<th scope="col" class="rounded-q4" width="10" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>
	<tr>
		<td>
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
			<tr bordercolor=white>
				<td  class="tablebold" width="20%"><%=bundle.getString("label.group.groupname") %></td><td class="tablebold" width="1%">:</td><td class="tablelight"><%=groupname%></td>
			</tr>
			<tr bordercolor=white>
				<td  class="tablebold" width="20%"><%=bundle.getString("label.group.description") %> </td><td class="tablebold" width="1%">:</td><td class="tablelight"><%=description%></td>
			</tr>
			
			
			<!--  <tr bordercolor=white>
				<td  class="tablebold" width="20%"><%=bundle.getString("label.group.dateofcreation") %></td><td class="tablebold" width="1%">:</td><td class="tablelight"><%=newdates%></td>
			</tr>-->
			<tr bordercolor=white>
				<td  class="tablebold" width="30%"><%=bundle.getString("label.group.trashpreviewerrormessage") %></td><td class="tablebold" width="1%">:</td><td class="tablelight"><%=as%></td>
			</tr>			
		</table>
		<br>
		
	
				 <a href="#" onclick="goToBack()"class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.group.back") %> </strong><span class="bt_blue_r"></span></a>
			 <%
			if(as.equals("0") )
			{%>
	     <a href="#" class="bt_green" onclick="goToDeactive()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.group.deactive") %></strong><span class="bt_green_r"></span></a>
	 <%}
	 else
	 {out.println("<div class='warning_box'>");
	 	out.println("<a align=center class='tablebold'>"+bundle.getString("label.group.deactivatepreviewerrormessagedetails")+"</a>");
	 	out.println("</div>");
	 }%>	     

	<tr><td>
	<input type="hidden" name="groupid" value="<%=groupid %>">
	</td></tr>
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