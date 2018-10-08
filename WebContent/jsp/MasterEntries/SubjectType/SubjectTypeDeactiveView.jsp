<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.subjecttype.deactivepreviewlisttitle") %></title>

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
	document.MainForm.action= "SubjectTypeList.jsp";
	document.MainForm.submit();
}

function goToDeactive()
{
if(confirm("Do you want to Deactivate the Subject Type...?"))
{
	document.MainForm.action= "SubjectTypeDeactiveFinal.jsp";
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
         <h2><%=bundle.getString("label.subjecttype.deactivepreviewlistrootpath") %></h2>

<%@ page language="java" import="java.util.*"%>
<%

String subjecttypeid=request.getParameter("subjecttypeid");

	String newdates = request.getParameter("newdates");
String curstatus="D";
ArrayList getDetailsForuadate=query_object.getDetailsForuadate(subjecttypeid);     
HashMap DetailsForuadate=null;
String subjectypename=null; 
String description=null;
for(int k=0;k<getDetailsForuadate.size();k++)
{
	DetailsForuadate=(HashMap)getDetailsForuadate.get(k);
	subjectypename=(String)DetailsForuadate.get("subjectypename");
	description=(String)DetailsForuadate.get("description");

}

String as=query_object.checkTrashSubject(subjecttypeid,(String)session.getValue("instituteid"));	

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
        	<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.subjecttype.deactivepreviewtableheading") %> </th>
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
				<td  class="tablebold" width="20%"><%=bundle.getString("label.subjecttype.subjecttypename") %> </td><td width="1%" class="tablebold">:</td><td class="tablelight"><%=subjectypename%></td>
			</tr>
			<tr bordercolor=white>
				<td  class="tablebold" width="20%"><%=bundle.getString("label.subjecttype.description") %> </td><td width="1%" class="tablebold">:</td><td class="tablelight"><%=description%></td>
			</tr>
			
			
			<tr bordercolor=white>
				<td  class="tablebold" width="30%"><%=bundle.getString("label.subjecttype.trashpreviewerrormessage") %></td><td width="1%" class="tablebold">:</td><td class="tablelight"><%=as%></td>
			</tr>
		</table>
	
	 <a href="#" onclick="goToBack()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.subjecttype.back") %> </strong><span class="bt_blue_r"></span></a>
	
				 <%
			if(as.equals("0") )
			{%>
	 <a href="#" class="bt_green" onclick="goToDeactive()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.subjecttype.deactive") %></strong><span class="bt_green_r"></span></a>
	 <%}
	 else
	 {  out.print("<div class='warning_box'>");
	 	out.print("<a align=center class='tablebold'>"+bundle.getString("label.subjecttype.trashpreviewerrormessagedetails")+" </a>");
	 	out.print("</div >");
	 }%>
	 
	<tr><td>
	<input type="hidden" name="subjecttypeid" value="<%=subjecttypeid %>">
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