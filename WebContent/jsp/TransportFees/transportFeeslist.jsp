<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportRouteAction" />
<jsp:useBean id="transportRouteBean" scope="page"
	class="com.iGrandee.TransportFees.TransportRoute" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>TransportRoute List</title>

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

function DeactiveView()
{
document.routeform.action= "transportroutedeactiveview.jsp";
document.routeform.submit();

}


function goback()
{
document.routeform.action= "TransportFeesHead.jsp";
document.routeform.submit();
}

function trashFun(obj)
{
	
					//alert("FeesHeadid===>>"+obj.getAttribute("transportfeesheadid"));
					url = "../StudentPromotion/getAction.jsp?Action=checkfeeshead&transportfeesheadid="+obj.getAttribute("transportfeesheadid");
		
					var req=null;
				
					try
					  {
					  // Firefox, Opera 8.0+, Safari
					  req=new XMLHttpRequest();
					  }
					catch (e)
					  {
					  // Internet Explorer
					  try
					    {
					    req=new ActiveXObject("Msxml2.XMLHTTP");
					    }
					  catch (e)
					    {
					    req=new ActiveXObject("Microsoft.XMLHTTP");
					    }
					  }
					  //alert(req)
					
							req.onreadystatechange = function()
							{
							//	alert(req.readyState)
								if (req.readyState == 4)
								   {
									//   alert(req.status)
								  		 if(req.status == 200)
										 {
						              			var parseXML=req.responseXML;
					
												var rootObj=parseXML.getElementsByTagName("checkNumber");
												var cNode_1=rootObj[0].childNodes.length;
												var username=null;
												var finalValue=rootObj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
												//var finalValue=rootObj[0].childNodes[0].selectSingleNode("finalValue").text;

												if(finalValue=="1")
												{
													alert("This Transport Fees Head Name had been allocated. You cant Trash")
												}
												else
												{
													if(confirm("Do you want To Trash the Transport Fees Head Name...?"))
													{
													
													document.routeform.transportfeesheadid.value=obj.getAttribute("transportfeesheadid");
													document.routeform.action= "TransportFeesHeadTrash.jsp";
													document.routeform.submit(); 
													}
												}
				
										  }
									   	 else if (req.status == 204)
									     {
										 }
								   	}
						   };
						req.open("GET",url,true);
						req.send(null);
	
}


function editByClickFun(obj) 
{      
if(confirm("Do you want to Update the Fees Head Name...?"))
{ 
	document.routeform.transportfeesheadid.value=obj.getAttribute("transportfeesheadid");
	//alert("document.routeform.transportfeesheadid.value===>>>"+document.routeform.transportfeesheadid.value);
	document.routeform.transportfeesheadname.value=obj.getAttribute("transportfeesheadname");
	document.routeform.action= "transportfeesheadedit.jsp";
	document.routeform.submit();
}

}
function DeactiveFun(obj)
{
if(confirm("Do you want to Deactivate the Route...?"))
{
document.routeform.transportrouteid.value=obj.getAttribute("transportrouteid");
document.routeform.routename.value=obj.getAttribute("routename");
document.routeform.routedescription.value=obj.getAttribute("routedescription");
document.routeform.action= "RoleDeactivatePreview.jsp";
document.routeform.submit();
}
else
{}
}
function TrashListview()
{

document.routeform.action= "TrashTransportFeesHeadList.jsp";
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
         <h2>Transport / Transport Fees Head / Transport Fees Head List</h2>
<%@ page import="java.util.*"%>

<%
ArrayList Route=new ArrayList();
HashMap newRoute=new HashMap();
String roleids="";
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
transportRouteBean.setInstituteid(instituteid);
Route=query_object.getFeesHeadName(instituteid);
%>
<form name="routeform" method="post" action="">
<input type="hidden" name="transportfeesheadid" value="">
<input type="hidden" name="transportfeesheadname" value="">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="15%">Sl.No</th>
        	<th scope="col" class="rounded" width="35%">Fees Head Name  </th>
				<th scope="col" class="rounded" width="35%">Edit </th>
  	        	<th scope="col" class="rounded-q4" width="30%">Trash </th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=3  class="rounded-foot-left"><em></em></td>
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
						out.print("<td class='tablelight' valign='top'>"+(i+1)+".</td>");
						out.print("<td class='tablelight' valign='top'>"+newRoute.get("transportfeesheadname")+"</td>");

						out.print("<td class='tablelight' valign='top'><a href='#'  id='check' rowpos='"+i+"' transportfeesheadid='"+newRoute.get("transportfeesheadid")+"' transportfeesheadname='"+newRoute.get("transportfeesheadname")+"' incvalue='"+i+"' tablename='maintab' class='tablelight' onclick='editByClickFun(this)'><img src='"+as+"/jsp/kycpanel/images/user_edit.png' alt='' title='"+bundle.getString("hlink.role.edit")+"' border=0 /></a></td>");
						out.print("<td class='tablelight' valign='top'><a href='#' class='tablelight' onclick='trashFun(this)' transportfeesheadid='"+newRoute.get("transportfeesheadid")+"' transportfeesheadname='"+newRoute.get("transportfeesheadname")+"' ><img src='"+as+"/jsp/kycpanel/images/trash.png' alt='' title='"+bundle.getString("label.role.trash")+"' border=0 /></a></td>");
						out.print("</tr>");
						
			
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
		
			<a href="./TransportFeesHead.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
	
		  <a href="#" onclick="TrashListview()" class="bt_red"><span class="bt_red_lft"></span><strong>Trash List </strong><span class="bt_red_r"></span></a>
		  
		  
		  
		  	
	<tr><td>
			<input type='hidden' name='sessiontype' value="ExistSession">
			
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