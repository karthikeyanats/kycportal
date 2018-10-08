<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.FlashNews.FlashNewsEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.FlashNews.FlashNewsBean" />
	


<%
int no_of_rows = 0;
	String mode = "";%>
<%
try {
	mode = request.getParameter("mode_of_operation");
	String content_id = request.getParameter("head_id");
	String ipaddress = request.getRemoteAddr();
	String instituteid=(String)session.getValue("instituteid");

	instituteBean.setflashidd(content_id);
	instituteBean.setMode(mode);
	instituteBean.setIpaddress(ipaddress);
	instituteBean.setInstituteid(instituteid);
	no_of_rows = query_object.updateDeteleQuery_Flash(instituteBean);
	String op="";
	String return_file ="";
	if (mode.equals("Delete")) {
		 op = "Deleted";
			 return_file =request.getContextPath()+"/jsp/FlashNews/List_Flash.jsp";

	} else if (mode.equals("Restore")) {
		 op = "Restored";
			 return_file =request.getContextPath()+"/jsp/FlashNews/List_Flash.jsp";

	} 
	else if (mode.equals("Active")) {
		 op = "Activated";
			 return_file =request.getContextPath()+"/jsp/FlashNews/List_DeactFlash.jsp";

	} 


	
	String message="";
	if(no_of_rows >0)
		message = "FlashNews Successfully  "+op;
	else
		message = "FlashNews "+op+" Failed";	

	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);
	 	
	 	

} catch (NullPointerException e)
{//System.out.println("IN JSP PAGE");
	e.printStackTrace();

}
%>
