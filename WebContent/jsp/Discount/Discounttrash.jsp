<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Discount.DiscountAction" />



<%@ page language="java" import="java.util.*"%>
<%
try{
	String curstatus = "T";

	String discountcategoryid = request.getParameter("discountcategoryid");
	
	int trashlist = query_object.changediscount(discountcategoryid, "T");
	
	String message=""; 
	if(trashlist >0)
		message = "Discount Category Successfully Trashed";
	else
		message = " Discount Category Trash Failed";	

		String return_file =request.getContextPath()+"/jsp/Discount/Discountlist.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
}
catch(Exception e){ 
	
	e.printStackTrace();
	
}
	 	
%>
