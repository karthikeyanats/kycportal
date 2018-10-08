<%@ page import="com.iGrandee.Registration.InstitutionUpload" %>
<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.PhotoGallery.PhotoGalleryQuery,com.iGrandee.PhotoGallery.PhotoGalleryUpload,com.iGrandee.PhotoGallery.PhotoGalleryBean"%>

<%
try
{
	PhotoGalleryUpload photoupload = new PhotoGalleryUpload(request);
	PhotoGalleryQuery photoquery = new PhotoGalleryQuery();
	PhotoGalleryBean photobean=new PhotoGalleryBean();
	
HashMap mainmap=photoupload.startProcess(); 
//out.println(mainmap);
HashMap pathmap=new HashMap();
HashMap namemap=new HashMap();
String name[]=null;
String path[]=null;
String userid=(String)session.getValue("userid");

String[] chk 	= photoupload.getParameterValues("chkno");
String[] photo_description 	= null;
if(chk.length>0)
{

	photo_description 	= new String [chk.length];
	for(int i=0;i<chk.length;i++)
	{
		photo_description[i]=photoupload.getParameter("photo_description"+chk[i]);
	}
}


String sessionid=photoupload.getParameter("yearofsession");
String extracurricularcategoryid=photoupload.getParameter("extracurricularcategoryid");

String reqcurriculareventid=photoupload.getParameter("reqcurriculareventid");



if(mainmap.size()>0)
{
	pathmap=(HashMap)mainmap.get("path");
	namemap=(HashMap)mainmap.get("name");
	name =new String[namemap.size()];
	path =new String[pathmap.size()];
	//out.print(path);

}
if(pathmap.size()>0 && namemap.size()>0)
{
	for(int i=0;i<pathmap.size();i++)
	{
		path[i] =pathmap.get("path_"+(i+1))+"";
		name[i] =namemap.get("name_"+(i+1))+"";
		out.print(path[i]);

		//System.out.println(name[i]);


	}
}


String message=null;
photobean.setCaption(photo_description);
photobean.setCreatedby(userid);
photobean.setSessionid(sessionid);
photobean.setExtracurricularcurriculareventid(reqcurriculareventid);
photobean.setGallerypath(path); 
photobean.setPhotoname(name); 


String sessionstatus=photoupload.getParameter("sessionstatus");
String yearofsession=photoupload.getParameter("yearofsession");
String curriculareventname=photoupload.getParameter("curriculareventname");
String yearofsession_temp=photoupload.getParameter("yearofsession_temp");
String curricularcategory_temp=photoupload.getParameter("curricularcategory_temp");
String venue=photoupload.getParameter("venue");
String eventdate=photoupload.getParameter("eventdate");

int returnfile=photoquery.insertphotots(photobean);
if(returnfile >0)
	message = "Curricular Event Photo Successfully Inserted";
else
	message = " Curricular Event Photo Insertion Failed";	

	String return_file =request.getContextPath()+"/jsp/PhotoGallery/PhotoGalleryUpload.jsp?yearofsession="+yearofsession+"&curriculareventname="+curriculareventname+"&yearofsession_temp="+yearofsession_temp+"&extracurricularcategoryid="+extracurricularcategoryid+"&curricularcategory_temp="+curricularcategory_temp+"&reqcurriculareventid="+reqcurriculareventid+"&venue="+venue+"&eventdate="+eventdate;
 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+returnfile+"&returnurl="+return_file);
}

catch(Exception e)
{
	System.out.println("JSP");
	System.out.println(e);
	}
%>