<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - ExtraCurricularActivity | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>

	function backSchedule()
	{
		document.wprkallotment.action = "Schedule.jsp";
		document.wprkallotment.submit();
	}
	function previousweek()
	{
		document.wprkallotment.searchdate.value=document.wprkallotment.previousdate.value;
		document.wprkallotment.submit();
	}
	function nextweek()
	{
		document.wprkallotment.searchdate.value=document.wprkallotment.nextdate.value;
		document.wprkallotment.submit();
	}
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

    <h2><%=bundle.getString("label.parentextracurricularactivities.StudentExtraCurricularActivityView") %></h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java"	import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery,com.iGrandee.PhotoGallery.PhotoGalleryQuery"%>
<%
	HashMap	hashmap				= null;
	String studentid	= (String)session.getValue("studentid");
	ExtraCurricularQuery curricularquery=new ExtraCurricularQuery();
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
					        	
					            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.parentextracurricularactivities.StudentDetails") %></th>
					            <th scope="col" class="rounded-q4" width="2%"></th>
					        </tr>
					    </thead>
					    <tr>		
					    	<td colspan='2'>					
				
								<%
									out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
									out.print("<tr><td width='17%' class='tablebold'>"+bundle.getString("label.parentextracurricularactivities.StudentName")+"</td><td width='1%' class='tablebold'>:</td><td>"+session.getValue("studentname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.parentextracurricularactivities.AcademicYear")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
									if(session.getValue("groupname") == null)
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.parentextracurricularactivities.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"</td></tr>");
									else
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.parentextracurricularactivities.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.parentextracurricularactivities.SectionName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sectionname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.parentextracurricularactivities.BoardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("boardname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.parentextracurricularactivities.MediumName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("mediumname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.parentextracurricularactivities.RollNo.")+"</td><td class='tablebold'>:</td><td>"+session.getValue("rollno") + "</td></tr>");

									out.print("</table>");  
								%>	
							</td>
						</tr>
					</table>	
										
										<br><br>
										
											<table id="rounded-corner" border=0 summary="Department List" width="100%">
											    <thead>
											    <tr>
											        	<th scope="col" class="rounded-company" width="1%"></th>
											            <th scope="col" class="rounded" width="5%" ><%=bundle.getString("label.parentextracurricularactivities.SL.No") %></th>
											            <th scope="col" class="rounded" width="20%" ><%=bundle.getString("label.parentextracurricularactivities.EventName") %></th>
											            <th scope="col" class="rounded" width="10%" ><%=bundle.getString("label.extracurricularactivity.curricularactivity") %></th>
											            <th scope="col" class="rounded" width="15%" ><%=bundle.getString("label.parentextracurricularactivities.Venu") %></th>
											            <th scope="col" class="rounded" width="17%" ><%=bundle.getString("label.parentextracurricularactivities.DateOfEvent") %></th>
											          	<th scope="col" class="rounded" width="18%" ><%=bundle.getString("label.parentextracurricularactivities.AwardDetails") %></th>
											            <th scope="col" class="rounded-q4" width="15%"><%=bundle.getString("label.parentextracurricularactivities.ShowPhotos") %></th>
											        </tr>
											   </thead>
											   <tfoot>
													<tr>
														<td colspan=7 class="rounded-foot-left"><em></em></td>
														<td class="rounded-foot-right">&nbsp;</td>
														</tr>
												</tfoot>
							<%
							String instituteid=session.getValue("instituteid")+"";
							PhotoGalleryQuery photogalleryQuery=new PhotoGalleryQuery();

				if(studentdetails.size()>0) 
					{
					for(int y=0,z=1;y<studentdetails.size();y++,z++)
								{
									hashmap=(HashMap)studentdetails.get(y);
									String curriculareventid=hashmap.get("curriculareventid")+"";
									out.println("<tr>");
									out.println("<td>");
									out.println("</td>");
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
									ArrayList photolist =	photogalleryQuery.getPhotos(curriculareventid,instituteid);
									if(photolist!=null && photolist.size()>0) 
									{	
									out.println("<td>");
									out.println("<a href='#' venue='"+hashmap.get("venu")+"' curriculareventname='"+hashmap.get("curriculareventname")+"' eventdate='"+hashmap.get("eventdate")+"' curriculareventid='"+hashmap.get("curriculareventid")+"' onclick='gotoaction(this)'>Show Photos</a>");
									out.println("</td>");
									}
									else
									{
									out.println("<td calss='tablelight'>No Photo");
									out.println("</td>");
									}
									out.println("</tr>");
								}
					}
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");
					//out.println("<tr>");
					//out.println("<td colspan=8 align =center>");
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