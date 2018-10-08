<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportStageAction" />

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>Stage wise Students</title>

<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>  
<script language="JavaScript">

function gostudentview(obj)
{ 
	document.discountform.sessionid.value=obj.getAttribute("sessionid");
	document.discountform.transportstageid.value=obj.getAttribute("transportstageid");
	document.discountform.transportstagename.value=obj.getAttribute("transportstagename");
	document.discountform.action= "ReportStageStudentview.jsp";
	document.discountform.submit();
}

 
function backfun()
{
document.discountform.action= "ReportStage.jsp";
document.discountform.submit();
}



</script>
</head>

<body>
<form name="discountform" method="post" >

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
         
        <h2>Transport Fees / Stage Report  / Session wise Students / Stage wise Students</h2>
         
<%@ page import="java.util.*"%>

<%
ArrayList StageList=new ArrayList();
HashMap sessionMap=new HashMap();
String roleids="";
String instituteid=null;
if(session.getValue("instituteid")!=null){
	instituteid=(String)session.getValue("instituteid");
} 
String sessionid=null;String transportstageid=null;

if(request.getParameter("sessionid")!=null)
{
	sessionid=(String)request.getParameter("sessionid");
	
}

if(request.getParameter("transportstageid")!=null)
{
	transportstageid=(String)request.getParameter("transportstageid");
	
}

StageList=query_object.getstagenamepersession(sessionid);
%>
<input type="hidden" name="sessionid" value="">
<input type="hidden" name="transportstageid" value="">
<input type="hidden" name="transportstagename" value="">
<%
if(request.getParameter("sessionname")!=null){
	//System.out.println("sessionname>>>>>>>>"+request.getParameter("sessionname"));
%>
<input type="hidden" name="sessionname" value="<%=request.getParameter("sessionname")%>">


 <h2>Session Name: &nbsp;<%=query_object.getsessioname(request.getParameter("sessionid"))%></h2>
 
<% 
}
%>  

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="20%">Sl.No</th>
        	<th scope="col" class="rounded" width="30%">Stage Name  </th>
        	<th scope="col" class="rounded" width="30%">Route Name  </th>
  	        <th scope="col" class="rounded-q4" width="20%">No.of.Students </th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=3  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
				<% 
				int count=0;
				if(StageList!=null && StageList.size()>0)
				{	String as=request.getContextPath();						

					for(int i=0;i<StageList.size();i++)
					{
						count++;
						out.print("<tr valign='top'>");
						sessionMap=(HashMap)StageList.get(i);
						out.print("<td class='tablelight' valign='top'>"+(count)+"</td>");
						out.print("<td class='tablelight' valign='top'>"+sessionMap.get("transportstagename")+"</td>");
						out.print("<td class='tablelight' valign='top'>"+query_object.getrouteaname(sessionMap.get("transportstageid")+"")+"</td>");
						if(query_object.getindividualstagecount(sessionid+"",sessionMap.get("transportstageid")+"")!=0)
							out.print("<td class='tablelight' valign='top'><a href='#' sessionid="+sessionid+"   transportstageid="+sessionMap.get("transportstageid")+" transportstagename="+sessionMap.get("transportstagename")+"  onclick='gostudentview(this)'>"+query_object.getindividualstagecount(sessionid+"",sessionMap.get("transportstageid")+"")+"</a></td>");
						else
							out.print("<td class='tablelight' valign='top'>"+query_object.getindividualstagecount(sessionid+"",sessionMap.get("transportstageid")+"")+"</td>");

				} 
				}
				else 
				{ 
					out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");


				} 
				

				%>
			
			 
		</table>
				
	 
				 		<a href="#" class="bt_blue" onClick='backfun()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
	
	 
		   
		  	
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