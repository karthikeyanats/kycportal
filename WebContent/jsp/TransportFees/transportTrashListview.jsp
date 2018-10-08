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
document.routeform.action= "transportroutelist.jsp";
document.routeform.submit();
}


function DeleteFun(obj)
{
if(confirm("Do you want to Delete the TransportRoute...?"))
{
	
document.routeform.transportrouteid.value=obj.getAttribute("transportrouteid");
document.routeform.action= "RouteDelete.jsp";
document.routeform.submit();

}

}
function RestoreFun(obj)
{
if(confirm("Do you want to Restore the TransportRoute...?"))
{
document.routeform.transportrouteid.value=obj.getAttribute("transportrouteid");

document.routeform.action= "RouteRestore.jsp";
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
         <h2>Transport / TransportRoute / TransportRoute List / TransportRoute TrashList</h2>
<%@ page import="java.util.*"%>

<%
ArrayList TransportRoute=null;
HashMap newRole=null;


TransportRoute=query_object.gettrashtranspotroute();

%>
<form name="routeform" method="post" action="">
<input type="hidden" name="transportrouteid" value="">
<input type="hidden" name="routename" value="">
<input type="hidden" name="routedescription" value="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>

	
		<tr><td valign="top">

		
		<table id="rounded-corner" border=0 summary="TransportRoute List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%" align="right">Sl.No</th>
        	<th scope="col" class="rounded" width="35%" align="right">Route Name </th>
  	        	<th scope="col" class="rounded" width="35%" align="right">Description </th>
  	        	 <th scope="col" class="rounded" width="10%" align="right" >Delete	 </th>
  	        	<th scope="col" class="rounded-q4" width="10%" align="right" >Restore</th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=4  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
				<% String []count=null;
				if(TransportRoute!=null && TransportRoute.size()>0)
				{ 
				for(int i=0,j=1;i<TransportRoute.size();i++,j++)
				{					newRole=(HashMap)TransportRoute.get(i);
					String newdescription=(String)newRole.get("routedescription");
					out.print("<tr valign='top'>");
					out.print("<td class='tablelight' >"+j+"</td>");
					out.print("<td class='tablelight' >"+newRole.get("routename")+"</td>");
					if(newdescription == null || newdescription.equals("") || newdescription.equals("-") || newdescription.equalsIgnoreCase("null"))
					{
						out.print("<td class='tablelight' width='30%'>-</td>");

					}
					else
					{

						   String des_temp=newRole.get("routedescription")+"";
						   count=des_temp.split(" ");
							if((count.length-1)>15)
							{
								out.print("<td class='tablelight' ");
								String des_tempnew="";
								for(int s=0;s<15;s++)
								{
									des_tempnew+=count[s]+" ";
								}%>
								<div>
								<%=des_tempnew%><a href="index.htm" onclick="return hs.htmlExpand(this)">
							[<font color="red">More..</font>]
						</a>  
						<div class="highslide-maincontent">
							<h3></h3>
							<%=(newRole.get("routedescription")+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
						</div>
							</div>
							<% }
							else
							{
								out.print("<td class='tablelight'>"+newRole.get("routedescription")+"</td>");

							}			
					}
					out.print("<td class='tablelight'  ><a href='#' onclick='DeleteFun(this)'  transportrouteid='"+newRole.get("transportrouteid")+"' routename='"+newRole.get("routename")+"' routedescription='"+newRole.get("routedescription")+"'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_logout.png' alt='delete' title='"+bundle.getString("label.role.delete")+"' border='0' /></td>");
					out.print("<td class='tablelight' ><a href='#' onclick='RestoreFun(this)' transportrouteid='"+newRole.get("transportrouteid")+"' routename='"+newRole.get("routename")+"' routedescription='"+newRole.get("routedescription")+"'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/16-undo1.png' alt='restore' title='"+bundle.getString("label.role.restore")+"' border='0' /></td>");

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