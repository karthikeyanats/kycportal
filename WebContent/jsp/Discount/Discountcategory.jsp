<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Discount.DiscountAction" />

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>List ListYearsession</title>

<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script language="JavaScript">

function godiscountinsert(obj)
{
	document.discountform.sessionid.value=obj.getAttribute("sessionid");
	document.discountform.sessionname.value=obj.getAttribute("sessionname");
	document.discountform.action= "Discountcreation.jsp";
	document.discountform.submit();
}

 
function goback()
{
document.discountform.action= "transportroute.jsp";
document.discountform.submit();
}



</script>
</head>

<body>
<form name="discountform" method="post" action="">

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
         <h2>Discount / Discount Category Session Wise</h2>
<%@ page import="java.util.*"%>

<%
ArrayList ListYearsession=new ArrayList();
HashMap sessionMap=new HashMap();
String roleids="";
String instituteid=null;
if(session.getValue("instituteid")!=null){
	instituteid=(String)session.getValue("instituteid");
} 
ListYearsession=query_object.listYearofSession(instituteid);
%>
<form name="discountform" method="post" action="">
<input type="hidden" name="sessionid" value="">
<input type="hidden" name="sessionname" value="">


<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	
		<table id="rounded-corner" border=0 summary="Department List" width="100%"> 
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="20%">Sl.No</th>
        	<th scope="col" class="rounded" width="50%">Academic Year  </th>
  	        	
  	        	<th scope="col" class="rounded-q4" width="30%">No.of Allocated Category </th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
				<% 
				int count=0;
				if(ListYearsession!=null && ListYearsession.size()>0)
				{	String as=request.getContextPath();						

					for(int i=0;i<ListYearsession.size();i++)
					{
						count++;
						out.print("<tr valign='top'>");
						sessionMap=(HashMap)ListYearsession.get(i);
						out.print("<td class='tablelight' valign='top'>"+(count)+"</td>");
						out.print("<td class='tablelight' valign='top'>"+sessionMap.get("sessionname")+"</td>");
						out.print("<td class='tablelight' valign='top'><a href='#'   sessionid="+sessionMap.get("sessionid")+" sessionname="+sessionMap.get("sessionname")+" onclick='godiscountinsert(this)'>"+query_object.countcategory(sessionMap.get("sessionid")+"")+"</a></td>");

				} 
				}
				else
				{ 
					out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");


				} 
				
 
				%>
			
			
		</table>
				
	
	
	 
		  
		  	
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