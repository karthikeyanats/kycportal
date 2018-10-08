<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Discount.DiscountAction" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleBean" />

<%@ page import="java.io.*,java.util.*"%>

<%

	String discountcategoryid = request.getParameter("discountcategoryid");

	
	
	
	int trashlist = query_object.changediscount(discountcategoryid, "A");
	
	String message="";
	if(trashlist >0)
		message = "Discount Category Successfully  Restored";
	else
		message = " Discount Category Restore  Failed";	 

		String return_file =request.getContextPath()+"/jsp/Discount/DiscountTrashListview.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
%>
