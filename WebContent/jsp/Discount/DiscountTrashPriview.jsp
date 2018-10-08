<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Discount.DiscountAction" />
<jsp:useBean id="instituteBean" scope="page"
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
<title>Discount TrashList Preview</title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script language="JavaScript">
function goToBack()
{
	document.routeform.action= "Discountlist.jsp";
document.routeform.submit();
}
function goToTrash()
{
if(confirm("Do you want to trash the Discount Category...?"))
{
	document.routeform.action= "Discounttrash.jsp";
document.routeform.submit();
}
else{}
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
         
                  <h2>Discount  / Discount Category / Discount Category List / Discount Category TrashList Preview</h2>
                  
         
<%@ page import="java.io.*,java.util.*"%>

<%
	String curstatus = "T";

	String discountcategoryid 		= request.getParameter("discountcategoryid");
	String noofdept		= "";
	String rolecount	= "";
	String noofdesp		= "";
	String noofdesp1	= "";
	HashMap as1			= null;
	
	ArrayList getDetailsForuadate=query_object.geteditdiscountcategory(discountcategoryid); 
	HashMap DetailsForuadate=null;
	String discountcategoryname=null;
	String discountcategorydescription=null;
	for(int k=0;k<getDetailsForuadate.size();k++) 
	{
		DetailsForuadate=(HashMap)getDetailsForuadate.get(k);
		 discountcategoryname=(String)DetailsForuadate.get("discountcategoryname");
		 discountcategorydescription=(String)DetailsForuadate.get("discountcategorydescription");

	}
	if(discountcategorydescription.equals(""))
	{
	discountcategorydescription="-";
	}
	
%>
<form name="routeform" method="post" action="">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	

	<tr>
		<td>
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="90%">Discount TrashList Preview </th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
			<tr bordercolor=white>
				<td  class="tablebold" width="20%">Discount Name </td><td width="1%" class="tablebold">:</td><td class="tablelight" ><%=discountcategoryname %></td>
			</tr>
			<tr bordercolor=white>
				<td  class="tablebold" width="20%">Discount Description </td><td width="1%" class="tablebold">:</td><td class="tablelight"><%=discountcategorydescription %></td>
			</tr>

			
			</thead>
		</table>
		<br>
			 	 <a href="#" onclick="goToBack()"class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		
						     <a href="#" class="bt_green" onclick="goToTrash()"><span class="bt_green_lft"></span><strong>Trash</strong><span class="bt_green_r"></span></a>
			
	 
	<input type="hidden" name="discountcategoryid" value="<%=discountcategoryid %>">
	
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