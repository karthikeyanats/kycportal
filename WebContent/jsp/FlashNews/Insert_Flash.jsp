

<jsp:useBean id="photo_query" 			scope="page" class="com.iGrandee.FlashNews.FlashNewsEntry" />
<jsp:useBean id="flashBean" 			scope="page" class="com.iGrandee.FlashNews.FlashNewsBean" />

<%!
	int no_of_rows=0;
	String return_file = null;
	String op = null;
	String operation=null;
%>
<%
String return_file="";
String userid=(String)session.getValue("userid");
try
{
	 operation = request.getParameter("mode_of_operation");
	if(operation.equals("Insert"))
	{
		String instituteid=(String)session.getValue("instituteid");
		String ipaddress = request.getRemoteAddr();

		String content = request.getParameter("message");
		flashBean.setflashmessage(content);
		flashBean.setInstituteid(instituteid);
		flashBean.setMode(operation);
		flashBean.setCreatedby(userid);
		flashBean.setIpaddress(ipaddress);



		no_of_rows=photo_query.insertQuery_Flash(flashBean);
		op = "Inserted";
		 return_file =request.getContextPath()+"/jsp/FlashNews/FlashNews.jsp";

	}
	
	else if((operation.equals("UPDATE")) || (operation.equals("ACTIVATE")) || (operation.equals("DEACTIVATE")) || (operation.equals("DELETE")) || (operation.equals("TRASH")))
	{
		
		String instituteid=(String)session.getValue("instituteid");
		

		String ipaddress = request.getRemoteAddr();

		
		String[] upcontent 		= request.getParameterValues("content_hide");
		String[] flashid 		= request.getParameterValues("head_id");
		String[] status 		= request.getParameterValues("status_hide");
		
		flashBean.setFlashid(flashid);
		flashBean.setFlashmessage(upcontent);
		flashBean.setInstituteid(instituteid);
		flashBean.setMode(operation);
		flashBean.setStatus(status);

		flashBean.setCreatedby(userid);
		flashBean.setIpaddress(ipaddress);
		no_of_rows				= photo_query.updateDeteleQuery_Flash(flashBean);

		if(operation.equals("DELETE"))
		{
			op = "Deleted";
	    }
		if(operation.equals("UPDATE"))
		{
			op = "Updated";
	    }
		if(operation.equals("ACTIVATE"))
		{
		 	op="Actived";
	    }
	    if(operation.equals("DEACTIVATE"))
	    {
		 	op="Deactived";
	    }
	    if(operation.equals("TRASH"))
	    {
		 	op="Trashed";
	    }
		 return_file =request.getContextPath()+"/jsp/FlashNews/Update_Flash.jsp";

	}

	
	String message="";
	if(no_of_rows >0)
		message = "FlashNews Successfully  "+op;
	else
		message = "FlashNews "+op+" Failed";	

	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);
	
}
catch(Exception e)
{

	}
%>
