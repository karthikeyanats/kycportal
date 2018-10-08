
<jsp:useBean id="query_object" 	scope="page" class="com.iGrandee.Announcement.AnnouncementEntry" />
<jsp:useBean id="instituteBean" 	scope="page" class="com.iGrandee.Announcement.AnnouncementBean" />
<%!int no_of_rows = 0;
	String mode = "";%>
<%
	try {
		mode = request.getParameter("mode_of_operation");
		String[] content_id = request.getParameterValues("head_id");
		String[] content = request.getParameterValues("content_hide");
		String ipaddress = request.getRemoteAddr();

		instituteBean.setAnnoucementdetails(content);
		instituteBean.setAnnouncementid(content_id);
		instituteBean.setMode(mode);
		instituteBean.setIpaddress(ipaddress);

		no_of_rows = query_object.udpateAnnouncement(instituteBean);
		String op="";
		if (mode.equals("DELETE"))
		{
			 op = "Deleted";
		}
		else if (mode.equals("TRASH"))
		{
			 op = "Trashed";
		} else if (mode.equals("DEACTIVATE"))
		{
			 op = "Deactived";
		} else if (mode.equals("ACTIVATE"))
		{
			 op = "Activated";
		} else if (mode.equals("UPDATE"))
		{
			 op = "Updated";
		}

		
		
		
			String message="";
		if(no_of_rows >0)
			message = "Announcement Successfully  "+op;
		else
			message = "Announcement "+op+" Failed";	

			String return_file =request.getContextPath()+"/jsp/Announcement/Update_Announcement.jsp";
		 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);
		 	
		

	} catch (NullPointerException e) {
		e.printStackTrace();

	}
%>
>