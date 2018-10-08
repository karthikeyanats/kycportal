<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
java.util.ResourceBundle bundle  =java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - ExtraCurricularActivity | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script>
function gotoaction(obj)
{   
var curriculareventname=obj.getAttribute("curriculareventname");
var eventdate=obj.getAttribute("eventdate");
var venue=obj.getAttribute("venue");

	document.wprkallotment.reqcurriculareventid.value = obj.getAttribute("curriculareventid");
	window.open("../PhotoGallery/PhotoGallerySlideShow.jsp?reqcurriculareventid="+document.wprkallotment.reqcurriculareventid.value+"&curriculareventname="+curriculareventname+"&eventdate="+eventdate+"&venue="+venue+"&flage=studentparent","Msg","top=250,left=350,help:no,center:no,status:no,width=1100,height=800,scrollbars=1;")
	


	//document.wprkallotment.reqcurriculareventid.value = obj.getAttribute("curriculareventid");
	//window.open("../PhotoGallery/PhotoGallerySlideShow.jsp?reqcurriculareventid="+document.wprkallotment.reqcurriculareventid.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=800,scrollbars=1;")
	
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

    <h2><%=bundle.getString("label.extracurricularview.title")%></h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java"	import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery,com.iGrandee.PhotoGallery.PhotoGalleryQuery"%>
<%
	HashMap	hashmap				= null;
	String studentid	= (String)session.getValue("studentid");
	String instituteid	= "";
	instituteid=(String)session.getValue("instituteid");
	String sessionid=(String)session.getValue("sessionid");
	//out.println(sessionid);

	ExtraCurricularQuery curricularquery=new ExtraCurricularQuery();
	PhotoGalleryQuery photogalleryQuery=new PhotoGalleryQuery();
	
	ArrayList studentdetails=new ArrayList(); 
	studentdetails=curricularquery.listEventstudentdetails(studentid);

	
%>


<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
	<form name='wprkallotment' method='post'>
	<input type="hidden" name="reqcurriculareventid" value="">
			<table class="bodyinnercolor" border='0' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>
						<tr>
							<td align='left' width='100%' height='100%'>
								<table  border='0' align="center" width="100%" cellspacing=5 cellpadding=0>

									<tr  height='25'>
										<td valign='top'>
											<table id="rounded-corner" border=0 summary="Department List" width="100%">
											    <thead>
											    <tr>
											            <th scope="col" class="rounded-company" width="10%" ><%=bundle.getString("hmlabel.sectionwiselist.slno") %></th>
											            <th scope="col" class="rounded" width="18%" ><%=bundle.getString("label.extracurricularview.EventName") %></th>
											            <th scope="col" class="rounded" width="18%" ><%=bundle.getString("label.extracurricularview.Activity") %></th>
											            <th scope="col" class="rounded" width="15%" ><%=bundle.getString("label.extracurricularview.Venu") %></th>
											            <th scope="col" class="rounded" width="13%" ><%=bundle.getString("label.extracurricularview.DateOfEvent") %></th>
											          	<th scope="col" class="rounded" width="12%" ><%=bundle.getString("label.extracurricularview.AwardDetails") %></th>
											            <th scope="col" class="rounded-q4" width="15%"><%=bundle.getString("label.extracurricularview.ShowPhotos") %></th>
											        </tr>
											   </thead>
											   <tfoot>
													<tr>
														<td colspan=6 class="rounded-foot-left"><em></em></td>
														<td class="rounded-foot-right">&nbsp;</td>
														</tr>
												</tfoot>
							<%
				if(studentdetails.size()>0)
					{
					for(int y=0,z=1;y<studentdetails.size();y++,z++)
								{
									hashmap=(HashMap)studentdetails.get(y);
									String curriculareventid=hashmap.get("curriculareventid")+"";
									out.println("<tr>");
									//out.println("<td>");
									//out.println("</td>");
									out.println("<td>");
									out.println(z);
									out.println("</td>");
									out.println("<td>");
									out.println(hashmap.get("curriculareventname"));
									out.println("</td>");
									out.println("<td>");
									out.println(hashmap.get("extracurricularname"));
									out.println("</td>");
									out.println("<td>");
									out.println(hashmap.get("venu"));
									out.println("</td>");
									out.println("<td>");
									out.println(hashmap.get("eventdate"));
									out.println("</td>");
									out.println("<td>");
									out.println(hashmap.get("awarddetails"));
									out.println("</td>");
									
									ArrayList photolist=new ArrayList();
									photolist =	photogalleryQuery.getPhotos(curriculareventid,instituteid);
									if(photolist!=null && photolist.size()>0) 
									{	out.println("<td>"); 
										out.println("<a href='#' venue='"+hashmap.get("venu")+"' curriculareventname='"+hashmap.get("curriculareventname")+"' eventdate='"+hashmap.get("eventdate")+"' curriculareventid='"+hashmap.get("curriculareventid")+"' onclick='gotoaction(this)'>"+bundle.getString("hlink.extracurricularview.ShowPhotos")+"</a>");
										out.println("</td>");

									}else
									{
										out.println("<td class='tablelight'>");
										out.println("No Photo");
										out.println("</td>");
									}
										
									out.println("</tr>");
								}
					}
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
					//out.println("<tr>");
					//out.println("<td colspan=7 align =center>");
					//out.println("Data Not Found");
					//out.println("</td>");
					//out.println("</tr>");
				}

								%>		
								</table>	
									
								</table>
							</td>
						</tr>					
					</table>
				</td>
			</tr>
		</table>
	</form>
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>