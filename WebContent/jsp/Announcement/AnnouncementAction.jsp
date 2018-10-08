

<jsp:useBean id="query_object" 	scope="page" class="com.iGrandee.Announcement.AnnouncementEntry" />
<jsp:useBean id="instituteBean" 	scope="page" class="com.iGrandee.Announcement.AnnouncementBean" />
<%!int no_of_rows = 0;
	String mode = "";%>
<%
	try {
		
		mode = request.getParameter("mode_of_operation");
		String content_id = request.getParameter("head_id");
		String ipaddress = request.getRemoteAddr();
        String instituteid=(String)session.getValue("instituteid");
		instituteBean.setannouncementidd(content_id);
		instituteBean.setMode(mode);
		instituteBean.setIpaddress(ipaddress);
		instituteBean.setInstituteid(instituteid);
		String mode1="";
		no_of_rows = query_object.udpateAnnouncement(instituteBean);
		String op="";
		String return_file ="";
		if (mode.equals("Delete")) {
			 op = "Deleted";
			 mode1="TRASHlIST";
			return_file =request.getContextPath()+"/jsp/Announcement/List_Announcement.jsp?list="+mode1;

		} else if (mode.equals("Restore")) {
			 op = "Restored";
			 mode1="TRASHlIST";
				 return_file =request.getContextPath()+"/jsp/Announcement/List_Announcement.jsp?list="+mode1;

		} else if (mode.equals("Active"))
		{
			 op = "Activated";
			 mode1="DEACTIVElIST";
				 return_file =request.getContextPath()+"/jsp/Announcement/List_DeactAnnouncement.jsp?list="+mode1;

		}
		
		
		String message="";
		if(no_of_rows >0)
			message = "Announcement Successfully  "+op;
		else
			message = "Announcement "+op+" Failed";	
		 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);
		 	
		 	
		

	} catch (NullPointerException e) {
		e.printStackTrace();

	}
%>
