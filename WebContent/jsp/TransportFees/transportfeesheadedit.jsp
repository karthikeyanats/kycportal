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
<title>TransportRoute Edit</title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
<script language="JavaScript">


function goToBack()
{
	document.routeform.action= "transportroutelist.jsp";
document.routeform.submit();
}
function goToUpdadfte()
{
if(check_ForParticularElements(document.routeform.routename,"text"))
	{
		
if(confirm("Do you want to Update the Role...?"))
{
	document.routeform.action= "transportrouteupdate.jsp";
document.routeform.submit();
}
else{}

}
}



function goToUpdate()
{
if(check_ForParticularElements(document.routeform.routename,"text"))
	{
		
if(confirm("Do you want to Update the Fees Head Name...?"))
{
	document.routeform.action= "transportfeesheadupdate.jsp";
document.routeform.submit();
}
else{}

}
}





function charcount()
{
var countlen=2000-document.routeform.routedescription.value.length;
document.getElementById("labelid").innerHTML	= countlen;

}	

	 
</script>
</head>

<body onload="charcount()">
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
         <h2>Transport / Transport Fees Head / Transport Fees Head List / Transport Fees Head Edit</h2>
<%@ page language="java" import="java.util.*"%>
<%
try{
	String transportfeesheadid = request.getParameter("transportfeesheadid");
	
	String instituteid = (String)session.getValue("instituteid");
	
	

	ArrayList getEditdetails=query_object.getedittranspotfeeshead(transportfeesheadid); 
	HashMap DetailsForuadate=null;
	String transportfeesheadname=null;
	for(int k=0;k<getEditdetails.size();k++)
	{
		DetailsForuadate=(HashMap)getEditdetails.get(k);
		transportfeesheadname=(String)DetailsForuadate.get("transportfeesheadname");

	}
		
%>
<form name="routeform" method="post" action="">
  <input type="hidden" name="transportfeesheadid" value="<%=transportfeesheadid %>">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	

	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	
            
              <th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.role.updatetableheading") %></th>
        	<th scope="col" class="rounded" width="1%"></th>
        	<th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.role.mandatoryfields") %></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=5  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>
	
		<table id="rounded-corner" border=0 summary="Department List" width="100%">


    <thead>

			<tr  valign="top">
				<td  class="tablebold">Transport Fees Head Name <font color=red>*</font></td>
				<td width="1%" class="tablebold">:</td>
				<td class="tablelight"><input type="text" name="routename"  validate="Transport Fees Head" maxlength=45 size=50 value="<%=transportfeesheadname.replaceAll("\"","&quot;")%>"></td>
			</tr>
						
		
		</table>
		     		  <a href="transportFeeslist.jsp"  class="bt_blue"><span class="bt_blue_lft"></span><strong>Back </strong><span class="bt_blue_r"></span></a>
		
	     <a href="#" class="bt_green" onclick="goToUpdate()"><span class="bt_green_lft"></span><strong>Update</strong><span class="bt_green_r"></span></a>
     
   <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
			</thead>
</table>
	

	</td>
</tr>
   <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
</TABLE>


     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../include/footer.jsp" %>
<%
}
catch(Exception e){
	e.printStackTrace();
	
	
}
%>
</div>

    </form>
	
</body>
</html>