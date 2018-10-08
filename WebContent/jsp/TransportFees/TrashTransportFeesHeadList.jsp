<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportRouteAction" />
<jsp:useBean id="transportBean" scope="page"
	class="com.iGrandee.TransportFees.TransportRoute" />
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>TransportRoute TrashList</title>

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
document.routeform.action= "transportFeeslist.jsp";
document.routeform.submit();
}


function DeleteFun(obj)
{
if(confirm("Do you want to Delete the Transport Fees Head Name...?"))
{
document.routeform.transportfeesheadid.value=obj.getAttribute("transportfeesheadid");

document.routeform.action= "FeesHeadDelete.jsp";
document.routeform.submit();

}

}

function RestoreFun(obj)
{
if(confirm("Do you want to Restore the Transport Fees Head Name...?"))
{
document.routeform.transportfeesheadid.value=obj.getAttribute("transportfeesheadid");

document.routeform.action= "FeesHeadRestore.jsp";
document.routeform.submit();

}

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
         <h2>Transport / Transport Fees Head / Transport Fees Head List / Transport Fees Head TrashList</h2>
<%@ page import="java.io.*,java.util.*"%>

<%
ArrayList TransportFeesHead=null;
HashMap newRole=null;
String instituteid = (String)session.getValue("instituteid");


TransportFeesHead=query_object.gettrashtranspotFeesHead(instituteid);


%>
<form name="routeform" method="post" action="">
<input type="hidden" name="transportfeesheadid" value="">
<input type="hidden" name="routename" value="">
<input type="hidden" name="routedescription" value="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>

	
		<tr><td valign="top">

		
		<table id="rounded-corner" border=0 summary="TransportRoute List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="15%" align="right">Sl.No</th>
        	<th scope="col" class="rounded" width="45%" align="right">Fees Head Name </th>
  	        	 <th scope="col" class="rounded" width="20%" align="right" >Delete	 </th>
  	        	<th scope="col" class="rounded-q4" width="20%" align="right" >Restore</th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=3  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
				<% String []count=null;
				if(TransportFeesHead!=null && TransportFeesHead.size()>0)
				{ 
				for(int i=0,j=1;i<TransportFeesHead.size();i++,j++)
				{	
					newRole=(HashMap)TransportFeesHead.get(i);
					out.print("<td class='tablelight' valign='top'>"+(i+1)+".</td>");
					out.print("<td class='tablelight' valign='top'>"+newRole.get("transportfeesheadname")+"</td>");
					//out.print("<td class='tablelight' valign='top'>"+newRole.get("transportfeesheadid")+"</td>");
					
					out.print("<td class='tablelight'  ><a href='#' onclick='DeleteFun(this)'  transportfeesheadid='"+newRole.get("transportfeesheadid")+"' transportfeesheadname='"+newRole.get("transportfeesheadname")+"'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_logout.png' alt='delete' title='"+bundle.getString("label.role.delete")+"' border='0' /></td>");
					out.print("<td class='tablelight' ><a href='#' onclick='RestoreFun(this)' transportfeesheadid='"+newRole.get("transportfeesheadid")+"' transportfeesheadname='"+newRole.get("transportfeesheadname")+"'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/16-undo1.png' alt='restore' title='"+bundle.getString("label.role.restore")+"' border='0' /></td>");

					out.print("</tr>");

				}
				}
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
					//out.print("<tr >");
					//out.print("<td colspan='5' align='center'class='tablelight'>Data Not Found</td>");
					//out.print("</tr>");
	
				}
				%>
			
			
		</table>
		  <a href="#" onclick="goback()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.role.back") %> </strong><span class="bt_blue_r"></span></a>

		</td>
	</tr>

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