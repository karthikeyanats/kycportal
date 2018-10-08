<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.PeriodName.PeriodNameEntry" />
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.periodnames.trashlisttitle") %> </title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>

<script language="JavaScript">
function trashFun()
{
	if(confirm("Do you want to trash the Period Name...?"))
	{
		document.MainForm.flage.value="Trash";
		document.MainForm.action						= "./PeriodNameStatusUpdate.jsp";
		document.MainForm.submit();
	}
} 
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
         <h2><%=bundle.getString("label.periodnames.trashlistrootpath_view") %></h2>
     
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
	String roleids			= "";
	String createdby 		= session.getValue("userid")+"";
	String instituteid 		= session.getValue("instituteid")+"";
	String periodname   	=request.getParameter("periodname");
	String periodnameid   	=request.getParameter("periodnameid");
	int count=0;
	String  output		= query_object.LoadPeriodNameAllocatedCount(periodnameid,instituteid); 
	if(output!=null && !output.equalsIgnoreCase("null"))
		count=Integer.parseInt(output);
%>
<form name="MainForm" method="post">
<input type="hidden" name="periodnameid" value="<%=periodnameid%>">
<input type="hidden" name="flage">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=5
	cellpadding=5>  
	
	
		<tr><td valign="top">

		<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="95%" colspan=2><%=bundle.getString("label.common.selectedinfo") %></th>
        	<th scope="col" class="rounded-q4" width="5%"> </th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
   
		<tbody>
		<tr>
		<td width=20%>
		<%=bundle.getString("label.periodnames.periodname") %>
		</td>
		<td  width=1%>
		:
		</td>
		<td  width=80%>
				<%=periodname%>
		
		</td>
		</tr>
		</tbody>
		</table>
		<br>
				<%if(count>0){ %>
				<div class=warning_box><%=bundle.getString("label.periodnames.message") %></div>
		<%} %>
		<a href="PeriodNameList.jsp" class="bt_blue" onclick="goback()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.periodnames.back") %> </strong><span class="bt_blue_r"></span></a>
		<%if(count==0){ %>
		<a href="#" class="bt_green" onclick="trashFun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.periodnames.Trash") %> </strong><span class="bt_green_r"></span></a>
		<%} %>
		</td>
	</tr>
	<tr><td>
			
			
</td></tr>	

</TABLE>   
</form> 
 </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../include/footer.jsp" %>

</div>

</body>
</html>