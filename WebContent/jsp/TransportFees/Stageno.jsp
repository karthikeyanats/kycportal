<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportRouteAction" />

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>List Route</title>

<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />

<script language="JavaScript">

function gostageinsert(obj)
{
	document.routeform.transportrouteid.value=obj.getAttribute("transportrouteid");
	document.routeform.action= "Stage.jsp";
	document.routeform.submit();

}


function goback()
{
document.routeform.action= "transportroute.jsp";
document.routeform.submit();
}



</script>
</head>

<body>
<form name="routeform" method="post" action="">

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
         <h2>Transport / List Route</h2>
<%@ page import="java.util.*"%>

<%
ArrayList Route=new ArrayList();
HashMap newRoute=new HashMap();
String roleids="";
String instituteid = (String)session.getValue("instituteid");

Route=query_object.gettranspotroute(instituteid);
%>
<form name="routeform" method="post" action="">
<input type="hidden" name="transportrouteid" value="">
<input type="hidden" name="routename" value=""> 


<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="20%">Sl.No</th>
        	<th scope="col" class="rounded" width="50%">Route Name  </th>
  	        	
  	        	<th scope="col" class="rounded-q4" width="30%">No.of.Stages </th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td> 
       </tr>
    </tfoot>
				<% 
				String []count=null;
				if(Route!=null && Route.size()>0)
				{	String as=request.getContextPath();						

					for(int i=0;i<Route.size();i++)
					{
						out.print("<tr valign='top'>");
						newRoute=(HashMap)Route.get(i);
						out.print("<td class='tablelight' valign='top'>"+(i+1)+"</td>");
						out.print("<td class='tablelight' valign='top'>"+newRoute.get("routename")+"</td>");
						out.print("<td class='tablelight' valign='top'><a href='#'   transportrouteid="+newRoute.get("transportrouteid")+" onclick='gostageinsert(this)'>"+query_object.getcount(newRoute.get("transportrouteid")+"")+"</a></td>");

				}
				}
				else
				{ 
					out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
					//out.print("<tr>");
					//out.print("<td colspan='7' align='center'class='tablelight'>Data Not Found</td>");
					//out.print("</tr>");

				} 
						%>
		
		</table>
		<a href="./StageList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>View All Stage</strong><span class="bt_blue_r"></span></a>	  	
	<tr><td>
			
</td></tr>	

</TABLE>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->
     
<%@ include file="../include/footer.jsp" %>

</div>
 
    </form>
	
</body>
</html>