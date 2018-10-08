<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.iGrandee.TransportFees.FeesSettingsAction"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportRouteAction" />
<%
ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.examnamelist.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  


/* function SaveFesstype(obj){	
		
	if(check_ForParticularElements(document.feestypeform.feestypename,"radio"))
	{
	var sessionid = obj.getAttribute("sessionid");	
	var transportfeestypeid = document.feestypeform.transportfeestypeid.value;
	alert("transportfeestypeid===>>>"+transportfeestypeid);
	  if(confirm("Do you want to Select the Fees Type?"))
		{
		document.feestypeform.action = "FeesTypeSubmit.jsp?transportfeestypeid="+transportfeestypeid+"&sessionid="+sessionid;
		document.feestypeform.submit();
		}
	}
}

function clickfun(id)
{
	document.feestypeform.transportfeestypeid.value=id;
}
 */

function addStagetostudent()
{
	
	if(check_ForParticularElements(document.feestypeform.routename,"select",document.feestypeform.stagename,"select"))
	{
		document.feestypeform.action="StudentstageupdateSubmit.jsp";
		document.feestypeform.submit();
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

    <h2>Transport Fees / Route Wise Student Reports</h2>
    
<form name="feestypeform" action="" method="post">
<input type=hidden name=examnameid_hidden>
<input type=hidden name=examname_hidden>
<input type=hidden name=examnameremarks_hidden>
<input type=hidden name=createdby_hidden>
 <%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,java.text.NumberFormat,java.util.Locale"%>
<%
ArrayList Route=new ArrayList();
HashMap newRoute=new HashMap();
String roleids="";

Route=query_object.gettranspotroute();
%>

<%-- <table>
	<tr>
    		<td> 
    			<h4></>Year of Session: <%=sessionname %> </h4>
    		</td>
    	</tr>
</table> --%>





 	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="20%">Sl.No</th>
        	<th scope="col" class="rounded" width="50%">Route Name  </th>
  	        	
  	        	<th scope="col" class="rounded-q4" width="30%">No.of.Students </th>
            
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
						out.print("<td class='tablelight' valign='top'>"+query_object.getstudentcount(newRoute.get("transportrouteid")+"")+"</td>");

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

	

</form>

		
    <%--  <a href="./ExamnameDeactivatedViewList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.examnamelist.deactivatelist")%></strong><span class="bt_blue_r"></span></a>
     <a href="./ExamnameTrashedView.jsp" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.examnamelist.trashitems")%></strong><span class="bt_red_r"></span></a> --%>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>