<%@ page import="com.iGrandee.Registration.InstitutionUpload" %>
<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.PhotoGallery.PhotoGalleryQuery,com.iGrandee.PhotoGallery.PhotoGalleryUpload,com.iGrandee.PhotoGallery.PhotoGalleryBean"%>

<%
try
{
	PhotoGalleryUpload photoupload = new PhotoGalleryUpload(request);
	PhotoGalleryQuery photoquery = new PhotoGalleryQuery();
	PhotoGalleryBean photobean=new PhotoGalleryBean();
	HashMap mainmap=photoupload.startProcess();

//String photo=photoupload.startProcessbystring();    
HashMap pathmap=new HashMap();
HashMap namemap=new HashMap();
String name[]=null;
String path[]=null;

String userid=(String)session.getValue("userid");

String eventphotogalleryid=photoupload.getParameter("eventphotogalleryid");
String gallerypath=photoupload.getParameter("gallerypath");
String photoname=photoupload.getParameter("photoname");

String descryption=photoupload.getParameter("descryption");
String reqsessionid=photoupload.getParameter("reqsessionid");
String sessionstatus_temp=photoupload.getParameter("sessionstatus_temp");
String photopath[]={gallerypath,"---"};
String photoname1[]={photoname,"---"};


String sessionid=photoupload.getParameter("yearofsession");
String curriculareventid=photoupload.getParameter("curriculareventid");

String venue=photoupload.getParameter("venue");
String eventdate=photoupload.getParameter("eventdate");

if(mainmap.size()>0)
{
	pathmap=(HashMap)mainmap.get("path");
	namemap=(HashMap)mainmap.get("name");
	name =new String[namemap.size()];
	path =new String[pathmap.size()];
	
}


if(pathmap.size()>0 && namemap.size()>0)
{
	for(int i=0;i<pathmap.size();i++)
	{
		path[i] =pathmap.get("path_"+(i+1))+"";
		name[i] =namemap.get("name_"+(i+1))+"";
		
	}
}


photobean.setEventphotogalleryid(eventphotogalleryid);
photobean.setExtracurricularcurriculareventid(curriculareventid);
photobean.setcaption(descryption);

if(pathmap.size()>0 && namemap.size()>0)
{
	photobean.setGallerypath(path);
	photobean.setPhotoname(name);   

}
else
{
	photobean.setGallerypath(photopath);
	photobean.setPhotoname(photoname1);   

}


photobean.setCreatedby(userid);  
photobean.setSessionid(reqsessionid);

String curricularcategory_temp=photoupload.getParameter("curricularcategory_temp");
String yearofsession_temp=photoupload.getParameter("yearofsession_temp");
String curriculareventname=photoupload.getParameter("curriculareventname");


int returnfile=photoquery.updatePhotogalley(photobean);
String message=null;

if(returnfile >0)
	message = "Curricular Event Photo Details Successfully Updated ";
else
	message = "Curricular Event Photo Details Updation Failed";	

	String return_file =request.getContextPath()+"/jsp/PhotoGallery/phodetails.jsp?curriculareventid="+curriculareventid+"&curricularcategory_temp="+curricularcategory_temp+"&yearofsession_temp="+yearofsession_temp+"&yearofsession="+reqsessionid+"&curriculareventname="+curriculareventname+"&venue="+venue+"&eventdate="+eventdate+"&sessionstatus_temp="+sessionstatus_temp;
 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+returnfile+"&returnurl="+return_file);
}

catch(Exception e)
{
	System.out.println("JSP");
	System.out.println(e);
	
	}
%>