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
<title>Route Report / Session wise Students</title> 

<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>  
<script language="JavaScript">

 
function goback() 
{
document.reportform.action= "ReportRoute.jsp";
document.reportform.submit();
}

function gostudentview(obj)
{
	document.reportform.studentapprovalid.value=obj.getAttribute("studentapprovalid");
	document.reportform.transportstagename.value=obj.getAttribute("transportstagename");
	document.reportform.action= "ReportRouteStudentview.jsp";
	document.reportform.submit();
	
}

function printfun()
{
	//alert("Print Fun");
	//alert(document.reportform.routename.value);
window.open("PrintPreview Reportroutestage.jsp?transportrouteid="+document.reportform.transportrouteid.value+"&routename="+document.reportform.routename.value+"","Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
}

 
</script>
</head>

<body>
<form name="reportform" method="post" action="">

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
                 <h2>Transport Fees / Route Report  / Route wise Students / Stage wise Students</h2>

<%@ page import="java.util.*"%>

<%
ArrayList RouteList=new ArrayList();
HashMap sessionMap=new HashMap();
String roleids="";String routename="";
String instituteid=null;String transportrouteid=null;
if(session.getValue("instituteid")!=null){
	instituteid=(String)session.getValue("instituteid");
} 

if(request.getParameter("transportrouteid")!=null){
	transportrouteid=request.getParameter("transportrouteid");
}

if(request.getParameter("routename")!=null){
	routename=request.getParameter("routename");
}



ArrayList Stagecount=null;
RouteList=query_object.gettransportroutestagecount(transportrouteid); 
%>
<form name="reportform" method="post" action="">

<input type="hidden" name="transportrouteid" value="<%=transportrouteid%>">
<input type="hidden" name="routename" value="<%=routename%>">
<input type="hidden" name="transportstagename" value="">
<input type="hidden" name="studentapprovalid" value="">
 

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="20%">Sl.No</th>
        	<th scope="col" class="rounded" width="50%">Stage Name  </th>
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
				int count=0;int stcount=0;
				if(RouteList!=null && RouteList.size()>0)	
				{	String as=request.getContextPath();						

					for(int i=0;i<RouteList.size();i++)
					{
						count++;
						sessionMap=(HashMap)RouteList.get(i);
						
						out.print("<tr valign='top'>");
						stcount=Integer.parseInt(sessionMap.get("total")+"");
						out.print("<td class='tablelight' valign='top'>"+(count)+"</td>");
						out.print("<td class='tablelight' valign='top'>"+sessionMap.get("transportstagename")+"</td>");
						if(stcount!=0)
							out.print("<td class='tablelight' valign='top'><a href='#' transportstagename='"+sessionMap.get("transportstagename")+"' transportrouteid='"+sessionMap.get("transportrouteid")+"'  studentapprovalid='"+sessionMap.get("studentapprovalid")+"'  onclick='gostudentview(this)'>"+sessionMap.get("total")+"</a></td>");
						else
							out.print("<td class='tablelight' valign='top'>"+sessionMap.get("total")+"</td>");
				} 
				}
				else
				{ 
					out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");


				} 
				

				%>
			
		</table>
				
				<a href="#" class="bt_blue" onclick="goback()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
				
			<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong>Print</strong><span class="bt_green_r"></span></a>
	
	 
		  
		  	
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