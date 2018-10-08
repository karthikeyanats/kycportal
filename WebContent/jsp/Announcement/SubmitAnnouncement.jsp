<%@ page language="java" %>
<jsp:useBean id="query_object" 	scope="page" class="com.iGrandee.Announcement.AnnouncementEntry" />
<jsp:useBean id="instituteBean" 	scope="page" class="com.iGrandee.Announcement.AnnouncementBean" />


<%
	try
	{
      	
		String[] content	= request.getParameterValues("content");

String ipaddress = request.getRemoteAddr();
		String instituteid=(String)session.getValue("instituteid");
      	instituteBean.setAnnoucementdetails(content);
      	instituteBean.setInstituteid(instituteid);
      	String createdby=(String)session.getValue("userid");
      	instituteBean.setCreatedby(createdby);
      	instituteBean.setIpaddress(ipaddress);
      	String s1=request.getContextPath();
     	String op="";


		int no_of_rows 		= 0;
		no_of_rows			= query_object.insertAnnouncement_multiple(instituteBean);
     	 op= "Inserted";

     	 
     	String message="";
		if(no_of_rows >0)
			message = "Announcement Successfully  Inserted";
		else
			message = "Announcement insertion Failed";	

			String return_file =request.getContextPath()+"/jsp/Announcement/announcement.jsp";
		 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);
		 	
	}
	catch(NullPointerException ee)
	{
	}
 %>










