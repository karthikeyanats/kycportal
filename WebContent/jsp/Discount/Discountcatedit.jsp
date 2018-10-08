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
<title>Discount Edit</title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
<script language="JavaScript">


function goToBack()
{
	document.routeform.action= "Discountlist.jsp";
document.routeform.submit();
}
function goToUpdate()
{
if(check_ForParticularElements(document.routeform.discountcategoryname,"text"))
	{
		
if(confirm("Do you want to Update the Discount Category...?"))
{
	document.routeform.action= "Discountupdate.jsp";
document.routeform.submit();
}
else{}

}
}
function charcount()
{
var countlen=2000-document.routeform.discountcategorydescription.value.length;
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
         
                  <h2>Discount  / Discount Category / Discount Category List / Discount Category Edit</h2>
         
<%@ page language="java" import="java.util.*"%>
<%
try{


	String discountcategoryid = request.getParameter("discountcategoryid");
	
	String instituteid = (String)session.getValue("instituteid");
	
	

	ArrayList getEditdetails=query_object.discounteditlist(discountcategoryid); 
	HashMap DetailsForuadate=null;
	String discountcategoryname=null;
	String discountcategorydescription=null;
	for(int k=0;k<getEditdetails.size();k++)
	{
		DetailsForuadate=(HashMap)getEditdetails.get(k);
		 discountcategoryname=(String)DetailsForuadate.get("discountcategoryname");
		 discountcategorydescription=(String)DetailsForuadate.get("discountcategorydescription");

	}
	if(discountcategorydescription.equals(""))
	{
	discountcategorydescription="-";
	}
	
%>
<form name="routeform" method="post" action="">
  <input type="hidden" name="discountcategoryid" value="<%=discountcategoryid %>">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	

	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	
            
              <th scope="col" class="rounded-company" width="20%">Discount Category Update</th>
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
				<td  class="tablebold">Discount Category Name <font color=red>*</font></td>
				<td width="1%" class="tablebold">:</td>
				<td class="tablelight"><input type="text" name="discountcategoryname"  validate="Discount Category Name" maxlength=45 size=50 value="<%=discountcategoryname.replaceAll("\"","&quot;")%>"></td>
			</tr>
			<tr valign="top">
				<td a class="tablebold">Discount Category Description </td>
							
			<td width="1%" class="tablebold">:</td>
			<td class="tablelight">
			<textarea validate="Discount Category Description"   class="tablelight" cols=75 rows=2 name="discountcategorydescription" maxlength="400"><%=discountcategorydescription %></textarea>			</td>	
			</tr>
			
		
		</table>
		     		  <a href="Discountlist.jsp"  class="bt_blue"><span class="bt_blue_lft"></span><strong>Back </strong><span class="bt_blue_r"></span></a>
		
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