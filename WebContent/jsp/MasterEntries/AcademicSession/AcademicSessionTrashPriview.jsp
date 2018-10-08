<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionBean" />
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.academicsession.trashpreviewlisttitle") %></title>

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
function goToTrash()
{
if(confirm("Do you want to trash the Academic Session ...?"))
{
	document.MainForm.action= "AcademicSessionTrash.jsp";
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
         <h2><%=bundle.getString("label.academicsession.trashpreviewlistrootpath") %></h2>

<%@ page language="java" import="java.util.*"%>
<%

ArrayList courseList = new ArrayList();

	String curstatus = "T";
	int arraySize=0;
String sessionid=request.getParameter("sessionid");
instituteBean.setsessionid(sessionid);
String sessionstatus= request.getParameter("sessionstatus");

	
	String noofdept="";

	String noofdesp="";


	if(noofdept.equals(""))
	{
		noofdept="-";
	}
	
	if(noofdesp.equals(""))
	{
		noofdesp="-";
	}
	
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
String instituteid=(String)session.getValue("instituteid"); 
                  
courseList=query_object.checkforTrashAcademicSession(sessionid,instituteid);

arraySize=courseList.size();     

	
%>
<form name="MainForm" method="post" action="">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>   
	
	<tr>   
		<td>   
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>  
    	<tr>  
        	  	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.academicsession.trashpreviewtableheading") %></th>
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
				<td align=left class="tablebold" width="40%"><%=bundle.getString("label.academicsession.academicsessionname") %> </td><td class="tablebold" width="1%">:</td><td class="tablelight"><%=sessionname %></td>
			</tr>
			<tr bordercolor=white>
				<td align=left class="tablebold" width="20%"><%=bundle.getString("label.academicsession.description") %> </td><td class="tablebold" width="1%">:</td><td class="tablelight"><%=description %></td>
			</tr>
			
			
			
			</thead>
		</table>
		<br>		
			<a href="#" onclick="goToBack()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.academicsession.back") %> </strong><span class="bt_blue_r"></span></a>
		
			<%if(arraySize!=0 )
			{
				out.println("<div class='warning_box'>");
				out.println(bundle.getString("label.academicsession.trashpreviewerrormessagedetails_2"));
				out.println("</div>");
			}
			else
			{
						if(sessionstatus.equals("A"))
						{
							out.println("<div class='warning_box'>");
							out.println(bundle.getString("label.academicsession.trashpreviewerrormessagedetails_3"));
							out.println("</div>");

						}
						else if(sessionstatus.equals("R"))
						{
							out.println("<div class='warning_box'>");
							out.println(bundle.getString("label.academicsession.trashpreviewerrormessagedetails_4"));
							out.println("</div>");

						}
						else
						{
						%>
							<a href="#" onclick="goToTrash()" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.academicsession.trash") %> </strong><span class="bt_green_r"></span></a>
		
					  <%}
		
			}%>
		
	<input type="hidden" name="sessionid" value="<%=sessionid %>">
	
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