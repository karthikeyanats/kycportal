<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry" />
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.academicsession.deactivepreviewlisttitle") %></title>

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
	document.MainForm.action= "AcademicSessionList.jsp";
document.MainForm.submit();
}
function goToDeactive()
{
if(confirm("Do you want to Deactivate the Academic Session...?"))
{
	document.MainForm.action= "AcademicSessionDeactiveFinal.jsp";
document.MainForm.submit();
}
else
{
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
         <h2><%=bundle.getString("label.academicsession.deactivepreviewlistrootpath") %></h2>

<%@ page language="java" import="java.util.*"%>
<%

String sessionid=request.getParameter("sessionid");

	String newdates = request.getParameter("newdates");
String curstatus="D";
	String description1="";
	String sessionstatus= request.getParameter("sessionstatus");

	String sessionname=""; 
	String description="";
	ArrayList getDetailsForuadate=query_object.getDetailsForuadate(sessionid);     
	HashMap DetailsForuadate=null;
	for(int k=0;k<getDetailsForuadate.size();k++)
	{
		DetailsForuadate=(HashMap)getDetailsForuadate.get(k);
		sessionname=(String)DetailsForuadate.get("sessionname");
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
        	<th scope="col" class="rounded-company" width="10"></th>
        	<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.academicsession.deactivepreviewtableheading") %> </th>
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
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
			<tr bordercolor=white>
				<td align=left class="tablebold" width="20%"><%=bundle.getString("label.academicsession.academicsessionname") %> </td><td class="tablebold" width="1%">:</td><td class="tablelight"><%=sessionname%></td>
			</tr>
			<tr bordercolor=white>
				<td align=left class="tablebold" width="20%"><%=bundle.getString("label.academicsession.description") %> </td><td class="tablebold" width="1%">:</td><td class="tablelight"><%=description%></td>
			</tr>
			
			
			<tr bordercolor=white>
				<td align=left class="tablebold" width="20%"><%=bundle.getString("label.academicsession.dateofcreation") %></td><td class="tablebold" width="1%">:</td><td class="tablelight"><%=newdates%></td>
			</tr>
			</thead>
		</table>
		<a href="#" onclick="goToBack()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.academicsession.back") %></strong><span class="bt_green_r"></strong><span class="bt_blue_r"></span></a>
		<% 
		if(sessionstatus.equals("R"))
		{
			out.println("<div class='warning_box'>");
			out.println(bundle.getString("label.academicsession.trashpreviewerrormessagedetails_5"));
			out.println("</div>");
		}
		else if( sessionstatus.equals("A"))
		{
			out.println("<div class='warning_box'>");
			out.println(bundle.getString("label.academicsession.trashpreviewerrormessagedetails_6"));
			out.println("</div>");
		}
		else
		{
		%>
		<a href="#" onclick="goToDeactive()" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.academicsession.deactive") %></strong><span class="bt_green_r"></span></a>
		<%}%>
		<tr><td>
	<input type="hidden" name="sessionid" value="<%=sessionid %>">
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