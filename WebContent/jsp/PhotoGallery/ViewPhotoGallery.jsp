<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.photogallery.photodetailsviewtitle")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">

function loadEventdetails(obj)
{	
if(check_ForParticularElements(document.curricularevententryform.yearofsession,"select"))
		{
	var extracurricularcategoryid=obj.value;
		document.curricularevententryform.reqsessionid.value = document.curricularevententryform.yearofsession.options[document.curricularevententryform.yearofsession.options.selectedIndex].value;
		document.curricularevententryform.reqcategoryids.value = document.curricularevententryform.curricularcategory.options[document.curricularevententryform.curricularcategory.options.selectedIndex].value;
		document.curricularevententryform.extracurricularcategoryid.value =extracurricularcategoryid;
	
	
	
	document.curricularevententryform.yearofsession_temp.value = document.curricularevententryform.yearofsession.options[document.curricularevententryform.yearofsession.options.selectedIndex].text;
		document.curricularevententryform.curricularcategory_temp.value = document.curricularevententryform.curricularcategory.options[document.curricularevententryform.curricularcategory.options.selectedIndex].text;
		
		document.curricularevententryform.action="ViewPhotoGallery.jsp";
		document.curricularevententryform.submit();
}  

}
function gotoaction(obj)
{   
var curriculareventname=obj.getAttribute("curriculareventname");
var eventdate=obj.getAttribute("eventdate");
var venue=obj.getAttribute("venue");
	document.curricularevententryform.reqcurriculareventid.value = obj.getAttribute("curriculareventid");
	window.open("PhotoGallerySlideShow.jsp?reqcurriculareventid="+document.curricularevententryform.reqcurriculareventid.value+"&yearname="+document.curricularevententryform.yearofsession.options[document.curricularevententryform.yearofsession.options.selectedIndex].text+"&categoryname="+document.curricularevententryform.curricularcategory.options[document.curricularevententryform.curricularcategory.options.selectedIndex].text+"&curriculareventname="+curriculareventname+"&eventdate="+eventdate+"&venue="+venue+"&flage=admin","Msg","top=0,left=0,help:no,center:yes,status:yes,width=1500,height=700,scrollbars=1;")
	     
}


</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.photogallery.photodetailsviewrootpath")%> </h2>
<form name="curricularevententryform" action="" method="post">

<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.PhotoGallery.PhotoGalleryQuery"%>

<%
com.iGrandee.PhotoGallery.PhotoGalleryQuery PhotoGalleryQuery = new com.iGrandee.PhotoGallery.PhotoGalleryQuery();
com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityEntry curricularactivity = new com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityEntry(); 

String instituteid= null;
ArrayList eventCategoryList = null;
ArrayList sessionList = null;
String yearofsession=request.getParameter("yearofsession")+"";

String curricularcategory=request.getParameter("curricularcategory")+"";
//String yearofsession=request.getParameter("yearofsession");


		
		String yearofsession_temp="";
		String curricularcategory_temp="";
		String userid= null;
try
{
	userid = (String)session.getValue("userid");
	 yearofsession_temp=request.getParameter("yearofsession_temp");
	 curricularcategory_temp=request.getParameter("curricularcategory_temp");
instituteid = (String)session.getValue("instituteid");
//eventCategoryList = PhotoGalleryQuery.listExtraCurricularCategoryList(instituteid,"A");
eventCategoryList = curricularactivity.get_All_Extracurricularactivity("A",userid,instituteid);

}catch(Exception e){}
%>
<table border=0 id="rounded-corner2" cellpadding=0 cellspacing=0 width="100%">

    

<tr class=tablebold><td> <%=bundle.getString("label.photogallery.academicsession")%> : <select name="yearofsession" validate='Year Of Session' class="tablelight" >
<option>-Select Session-</option>
 <%
  		 sessionList =  PhotoGalleryQuery.listYearofSession(instituteid);
        	if(sessionList!=null && sessionList.size()>0)  
			{
   		 	for (int i = 0, j = 1; i < sessionList.size(); i++) {
			
				HashMap sessionListMap=(HashMap)sessionList.get(i);
				String sessionid     = (String)sessionListMap.get("sessionid");
				String sessionname      = (String)sessionListMap.get("sessionname");
				if(yearofsession!=null && yearofsession.equals(""+sessionid) )
				{
       		      out.println("<option value='"+sessionid+"' class=tablelight selected>"+sessionname+"</option>");
				}
				else
				{
		       		 out.println("<option value='"+sessionid+"' class=tablelight >"+sessionname+"</option>");

				}
				}
			}
   		 %>
</select>
</td>
<td>
<%=bundle.getString("label.extracurricularactivity.curricularactivity")%> : <select name="curricularcategory" class="tablelight" onchange="loadEventdetails(this)">
<option>-Select Activity-</option>
 <%
 /*String extracurricularcategoryid ="";	
        	if(eventCategoryList!=null && eventCategoryList.size()>0)
			{
   		 	for (int i = 0, j = 1; i < eventCategoryList.size(); i++) {
			
				HashMap eventCategoryListMap=(HashMap)eventCategoryList.get(i);
				 extracurricularcategoryid     = (String)eventCategoryListMap.get("extracurricularcategoryid");
				String extcurricularcategoryname      = (String)eventCategoryListMap.get("extcurricularcategoryname");
       		
				if(curricularcategory!=null && curricularcategory.equals(""+extracurricularcategoryid) )
				{
       		     	
				out.println("<option value='"+extracurricularcategoryid+"' selected class=tablelight >"+extcurricularcategoryname+"</option>");
				}
				else
				{
					out.println("<option value='"+extracurricularcategoryid+"' class=tablelight >"+extcurricularcategoryname+"</option>");

				}
				}
			}*/
			String extracurricularactivityid ="";	
			if(eventCategoryList!=null && eventCategoryList.size()>0)
			{
		 	for (int i = 0, j = 1; i < eventCategoryList.size(); i++) {
			
				HashMap eventCategoryListMap=(HashMap)eventCategoryList.get(i);
				extracurricularactivityid     = (String)eventCategoryListMap.get("extracurricularactivityid");
				String extracurricularname      = (String)eventCategoryListMap.get("extracurricularname");
			
				if(curricularcategory!=null && curricularcategory.equals(""+extracurricularactivityid) )
				{
			     	
				out.println("<option value='"+extracurricularactivityid+"' selected class=tablelight >"+extracurricularname+"</option>");
				}
				else
				{
					out.println("<option value='"+extracurricularactivityid+"' class=tablelight >"+extracurricularname+"</option>");

				}
				}
			}
   		 %>
</select>
</td></tr>
</table></td></tr>
</table>
<br>
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.photogallery.slno")%></th>
        	<th scope="col" class="rounded" width="30%" ><%=bundle.getString("label.photogallery.eventname")%></th>
        	<th scope="col" class="rounded" width="15%"><%=bundle.getString("label.photogallery.venue")%></th>
        	<th scope="col" class="rounded" width="15%"><%=bundle.getString("label.photogallery.eventdate")%></th>
        	<th scope="col" class="rounded-q4" width="20%"><%=bundle.getString("label.photogallery.showphotos")%></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=4 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>

	<%
	String extracurricularcategoryid1="";
	if(request.getParameter("reqsessionid") != null && request.getParameter("reqcategoryids") !=null)
	{
		
	String reqsessionid = request.getParameter("reqsessionid");
	String reqcategoryid = request.getParameter("reqcategoryids");
	 extracurricularcategoryid1=request.getParameter("extracurricularcategoryid");
	ArrayList eventList = PhotoGalleryQuery.listExtraCurricularEventList(reqcategoryid,reqsessionid,"A");
	if(eventList!=null && eventList.size()>0)
	{
	 	for (int i = 0, j = 1; i < eventList.size(); i++) {
	
		HashMap eventListMap=(HashMap)eventList.get(i);
		String curriculareventid     = (String)eventListMap.get("curriculareventid");
		String curriculareventname      = (String)eventListMap.get("curriculareventname");
		String venue      = (String)eventListMap.get("venu");
		if(venue == null || venue.equals(""))
			venue = "-";
		String eventdate      = (String)eventListMap.get("eventdate");
		int photoCount      = Integer.parseInt((String)eventListMap.get("photocount"));
		
		out.println("<tr><td>"+(j++)+"</td><td class=tablelight>"+curriculareventname+"</td>");
		out.println("<td class=tablelight>"+venue+"</td>");
		out.println("<td class=tablelight>"+eventdate+"</td>");
		
		if(photoCount>0)
		{
		out.println("<td><a href=\"#\" curriculareventname='"+curriculareventname+"' eventdate='"+eventdate+"' venue='"+venue+"' curriculareventid='"+curriculareventid+"'  onclick=gotoaction(this)>"+bundle.getString("label.photogallery.showphotos")+"</a></td>");
		}
		else
		{
			out.println("<td class='tablelight'>No Photo</td>");
		}
		
		//ArrayList photolist=PhotoGalleryQuery.getPhotos(curriculareventid,instituteid);
		
		//if(photolist!=null && photolist.size()>0)
		//{
		//out.println("<td><a href=\"#\" curriculareventname='"+curriculareventname+"' eventdate='"+eventdate+"' venue='"+venue+"' curriculareventid='"+curriculareventid+"'  onclick=gotoaction(this)>"+bundle.getString("label.photogallery.showphotos")+"</a></td>");
		//}
		//else
		//{
			//out.println("<td class='tablelight'>No Photo</td>");
		//}
		out.println("</tr>");
	 }
	 }
	
	
	else
	{
		out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
		//out.println("<td colspan=5 align=center>Data not found</td>");
	}
	}
	else{
		out.println("<tr align='center' class='tablebold'><td colspan='5'>Select Academic Session and Extracurricular Activity</td></tr>");
	}
	%>
	 </tbody>
	 </table>
	</td><td width="30%">&nbsp;</td></tr></table>	
	
	 
     	<input type=hidden name="reqcategoryids"/>
		<input type=hidden name="reqsessionid"/>
			<input type=hidden name="operationstatus"/>
		<input type=hidden name="reqcurriculareventid"/>
					<input type=hidden name="extracurricularcategoryid" value="<%=extracurricularcategoryid1 %>">
		
		
		
			<input type=hidden name="yearofsession_temp" value="<%=yearofsession_temp %>">
		<input type=hidden name="curricularcategory_temp" value="<%=curricularcategory_temp %>">
</form>
     </div><!-- end of right content-->
  </div>   <!--end of center content -->
    <div class="clear"></div>
    </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
</div>
</body>
</html>