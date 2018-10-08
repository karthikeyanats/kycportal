<%@ page import="com.iGrandee.Registration.InstitutionUpload" %>
<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.PhotoGallery.PhotoGalleryQuery,com.iGrandee.PhotoGallery.PhotoGalleryBean"%>

<%
try
{
	int returnfile=0;
	String status="";
	PhotoGalleryQuery photoquery = new PhotoGalleryQuery();
	PhotoGalleryBean photobean=new PhotoGalleryBean();
	String message=null;
	String eventphotogalleryid=null;
	String userid=(String)session.getValue("userid");
	String curriculareventid=request.getParameter("curriculareventid");
	eventphotogalleryid=request.getParameter("eventphotogalleryid");
	
	String curricularcategory_temp=request.getParameter("curricularcategory_temp");
	String yearofsession_temp=request.getParameter("yearofsession_temp");
	String reqsessionid=request.getParameter("reqsessionid");
	String curriculareventname=request.getParameter("curriculareventname");
	photobean.setEventphotogalleryid(eventphotogalleryid);
	photobean.setCreatedby(userid);
	String flage=request.getParameter("flage");
	String venue=request.getParameter("venue");
	String eventdate=request.getParameter("eventdate");
	String sessionstatus_temp=request.getParameter("sessionstatus_temp");
	if(flage.equals("T"))
	{
		
	photobean.setGallerystatus("T");
	returnfile=photoquery.updateStatus(photobean);
	if(returnfile >0)
		message = "Curricular Event Photo Details Successfully Trashed";
	else
		message = "Curricular Event Photo Trash Failed";	
		String return_file =request.getContextPath()+"/jsp/PhotoGallery/phodetails.jsp?curriculareventid="+curriculareventid+"&curricularcategory_temp="+curricularcategory_temp+"&yearofsession_temp="+yearofsession_temp+"&yearofsession="+reqsessionid+"&curriculareventname="+curriculareventname+"&venue="+venue+"&eventdate="+eventdate+"&sessionstatus_temp="+sessionstatus_temp;
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+returnfile+"&returnurl="+return_file);
	 	
	}
	else if(flage.equals("R"))
	{
	returnfile=photoquery.updateStatus(photobean);
	photobean.setGallerystatus("A");
	returnfile=photoquery.updateStatus(photobean);
	if(returnfile >0)
		message = "Curricular Event Photo Details Successfully Restored";
	else
		message = "Curricular Event Photo Restore Failed";	
		String return_file =request.getContextPath()+"/jsp/PhotoGallery/phototrashlist.jsp?curriculareventid="+curriculareventid+"&curricularcategory_temp="+curricularcategory_temp+"&yearofsession_temp="+yearofsession_temp+"&yearofsession="+reqsessionid+"&curriculareventname="+curriculareventname+"&venue="+venue+"&eventdate="+eventdate+"&sessionstatus_temp="+sessionstatus_temp;
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+returnfile+"&returnurl="+return_file);
	}
	else if(flage.equals("D"))
	{
	returnfile=photoquery.deleteStatus(photobean);
	if(returnfile >0)
		message = "Curricular Event Photo Details Successfully Deleted";
	else
		message = "Curricular Event Photo Deletion Failed";	
		String return_file =request.getContextPath()+"/jsp/PhotoGallery/phototrashlist.jsp?curriculareventid="+curriculareventid+"&curricularcategory_temp="+curricularcategory_temp+"&yearofsession_temp="+yearofsession_temp+"&yearofsession="+reqsessionid+"&curriculareventname="+curriculareventname+"&venue="+venue+"&eventdate="+eventdate+"&sessionstatus_temp="+sessionstatus_temp;
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+returnfile+"&returnurl="+return_file);
	}
	
	}

catch(Exception e)
{
	System.out.println("JSP");
	System.out.println(e);
	}
%>