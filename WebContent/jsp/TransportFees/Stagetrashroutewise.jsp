<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportStageAction" />
<jsp:useBean id="transportBean" scope="page"
	class="com.iGrandee.TransportFees.TransportStage" />
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>TransportStage TrashList</title>

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
document.stageform.action= "Stage.jsp";
document.stageform.submit();
}


function DeleteFun(obj)
{
if(confirm("Do you want to Delete the Stage...?"))
{
document.stageform.transportstageid.value=obj.getAttribute("transportstageid");
document.stageform.action= "Stagedelete.jsp";
document.stageform.submit();

}

}
function RestoreFun(obj)
{
if(confirm("Do you want to Restore the Stage...?")) 
{
document.stageform.transportstageid.value=obj.getAttribute("transportstageid");
document.stageform.action= "Stagerestore.jsp";
document.stageform.submit();

}

}
</script>
</head>

<body>
<form name="stageform" method="post" action="">

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
         <h2>Transport / List Route / Stage Creation / Stage List / TrashList</h2>
         <%
String routename=null;
if(request.getParameter("routename")!=null){
	routename=request.getParameter("routename");
	out.println("<input type='hidden' name='routename' value='"+routename+"'>");
	out.println("<h2>Route Name: &nbsp;&nbsp;"+routename+"</h2>");  
	
} 
         
         %>
<%@ page import="java.io.*,java.util.*"%>

<%
ArrayList TransportStage=null;
HashMap newRole=null;String transportrouteid=null;
String instituteid=null;
 instituteid = (String)session.getValue("instituteid");
 out.println("<input type='hidden' name='transportrouteid' value='"+request.getParameter("transportrouteid")+"'>");
if(request.getParameter("transportrouteid")!=null){
	transportrouteid=(String)request.getParameter("transportrouteid");
	out.println("<input type='hidden' name='transportrouteid' value='"+transportrouteid+"'>");
} 
TransportStage=query_object.gettrashtransportstageroutewise(instituteid,transportrouteid);

%>
<form name="stageform" method="post" action="">
<input type="hidden" name="transportstageid" value="">
<input type="hidden" name="transportstagename" value="">
<input type="hidden" name="transportstagedescription" value="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>

	
		<tr><td valign="top">

		
		<table id="rounded-corner" border=0 summary="TransportStage List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%" align="right">Sl.No</th>
        	
        	<th scope="col" class="rounded" width="30%" align="right">Stage Name </th>
  	        	<th scope="col" class="rounded" width="40%" align="right">Description </th>
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
				if(TransportStage!=null && TransportStage.size()>0)
				{ 
				for(int i=0,j=1;i<TransportStage.size();i++,j++)
				{					newRole=(HashMap)TransportStage.get(i);
					String newdescription=(String)newRole.get("transportstagedescription");
					out.print("<tr valign='top'>");
					out.print("<td class='tablelight' >"+j+"</td>");
				
					out.print("<td class='tablelight' >"+newRole.get("transportstagename")+"</td>"); 
					if(newdescription == null || newdescription.equals("") || newdescription.equals("-") || newdescription.equalsIgnoreCase("null"))
					{
						out.print("<td class='tablelight' width='30%'>-</td>");

					}
					else
					{

						   String des_temp=newRole.get("transportstagedescription")+"";
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
							<%=(newRole.get("transportstagedescription")+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
						</div>
							</div>
							<% }
							else
							{
								out.print("<td class='tablelight'>"+newRole.get("transportstagedescription")+"</td>");

							}			
					}
					out.print("<td class='tablelight'  ><a href='#' onclick='DeleteFun(this)'  transportstageid='"+newRole.get("transportstageid")+"' ><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_logout.png' alt='delete' title='"+bundle.getString("label.role.delete")+"' border='0' /></td>");
					out.print("<td class='tablelight' ><a href='#' onclick='RestoreFun(this)' transportstageid='"+newRole.get("transportstageid")+"' ><img src='"+request.getContextPath()+"/jsp/kycpanel/images/16-undo1.png' alt='restore' title='"+bundle.getString("label.role.restore")+"' border='0' /></td>");

					out.print("</tr>");

				}
				}
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
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