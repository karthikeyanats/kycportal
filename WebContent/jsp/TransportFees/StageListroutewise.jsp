<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportStageAction" />
<jsp:useBean id="transportRouteBean" scope="page"
	class="com.iGrandee.TransportFees.TransportStage" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>Stage List</title>

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
document.routeform.action= "Stageno.jsp";
document.routeform.submit();
}
function trashFun(obj)
{
	
	//alert(obj.getAttribute("transportstageid"))
					url = "../StudentPromotion/getAction.jsp?Action=checkstage&transportstageid="+obj.getAttribute("transportstageid");
		
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
													alert("This Stage had been allocated. You cant Trash")
												}
												else
												{
													if(confirm("Do you want To Trash the Stage...?"))
													{
												
													
													document.routeform.transportstageid.value=obj.getAttribute("transportstageid");
													
													document.routeform.action= "Stagetrashpreview.jsp";
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
if(confirm("Do you want to Update the Stage...?"))
{
	document.routeform.transportstageid.value=obj.getAttribute("transportstageid");
	document.routeform.transportstagename.value=obj.getAttribute("transportstagename");
	document.routeform.transportstagedescription.value=obj.getAttribute("transportstagedescription");
	document.routeform.transportrouteid.value=obj.getAttribute("transportrouteid");
	
	document.routeform.action= "stagerouteedit.jsp";
	document.routeform.submit();
}

}
function DeactiveFun(obj)
{
if(confirm("Do you want to Deactivate the Route...?"))
{
document.routeform.transportrouteid.value=obj.getAttribute("transportrouteid");
document.routeform.transportstagename.value=obj.getAttribute("transportstagename");
document.routeform.transportstagedescription.value=obj.getAttribute("transportstagedescription");
document.routeform.action= "RoleDeactivatePreview.jsp";
document.routeform.submit();
}
else
{}
}
function TrashListview()
{

document.routeform.action= "Stagetrashview.jsp";
document.routeform.submit();

}

function goback(){
	document.routeform.action= "Stage.jsp";
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
         <h2>Transport / List Route / Stage Creation / Stage List</h2>
     <%
     String routename=null;
       if(request.getParameter("routename")!=null)
       {
    	   routename=(String)request.getParameter("routename");
    	 out.println("<h2>Route Name: &nbsp;&nbsp;"+routename+"</h2>");  
       }
       %>  
<%@ page import="java.util.*"%>

<%
ArrayList Route=new ArrayList();
HashMap newRoute=new HashMap();
String roleids="";
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String transportrouteid=null;
if(request.getParameter("transportrouteid")!=null){
	transportrouteid=(String)request.getParameter("transportrouteid");
	out.println("<input type='hidden' name='transportrouteid' value='"+transportrouteid+"'>");
} 

if(request.getParameter("routename")!=null){

	out.println("<input type='hidden' name='routename' value='"+routename+"'>");
} 
Route=query_object.gettransportstageroutewise(instituteid,transportrouteid);
%>
<form name="routeform" method="post" action="">
<input type="hidden" name="transportrouteid" value="">
<input type="hidden" name="transportstagename" value="">
<input type="hidden" name="transportstagedescription" value="">
<input type="hidden" name="transportstageid" value="">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10">Sl.No</th>
        	<th scope="col" class="rounded" width="25%">Stage Name  </th>
  	        	<th scope="col" class="rounded" width="30%">Description</th>
  	        	<th scope="col" class="rounded" width="20%">Date of creation</th>
				<th scope="col" class="rounded" width="5%">Edit </th>
  	        	<th scope="col" class="rounded-q4" width="10%">Trash </th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=5  class="rounded-foot-left"><em></em></td>
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
						out.print("<td class='tablelight' valign='top'>"+newRoute.get("transportstagename")+"</td>");
						
						String a1=newRoute.get("transportstagedescription")+"";
						if(a1 == null || a1.equals("") || a1.equals("null"))	
						{
						out.print("<td class='tablelight' valign='top'>-</td>");
						}
						else
						{
							String des_temp=newRoute.get("transportstagedescription")+"";
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
								<%=(newRoute.get("transportstagedescription")+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
							</div>
								</div>
								<% }
								else
								{
									out.print("<td class='tablelight'>"+newRoute.get("transportstagedescription")+"</td>");

								}
						}
						
						out.print("<td class='tablelight' valign='top'>"+newRoute.get("newdates")+"</td>");


						out.print("<td class='tablelight' valign='top'><a href='#'  id='check' rowpos='"+i+"' transportrouteid='"+newRoute.get("transportrouteid")+"'  transportstageid='"+newRoute.get("transportstageid")+"' transportrouteid='"+newRoute.get("transportrouteid")+"'  incvalue='"+i+"' tablename='maintab' class='tablelight' onclick='editByClickFun(this)'><img src='"+as+"/jsp/kycpanel/images/user_edit.png' alt='' title='"+bundle.getString("hlink.role.edit")+"' border=0 /></a></td>");
						out.print("<td class='tablelight' valign='top'><a href='#' class='tablelight' onclick='trashFun(this)' transportstageid='"+newRoute.get("transportstageid")+"'><img src='"+as+"/jsp/kycpanel/images/trash.png' alt='' title='"+bundle.getString("label.role.trash")+"' border=0 /></a></td>");
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
				
	
	
	
	
		<a href="#" onclick="goback()" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		  
		  
		  
		  	
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