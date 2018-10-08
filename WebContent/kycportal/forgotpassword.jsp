<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child -Student Assignment | Powered by i-Grandee</title>
<LINK REL=stylesheet HREF="<%=request.getContextPath()%>/css/kyccss.css">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script language='javascript'>

function backfun()
{

document.f1.action= "HomePage.jsp";
document.f1.submit();

}
function openfile(obj)
{	
var questionfile=obj.getAttribute("questionfile")

window.open("<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2="+questionfile);

}
</script>
</head>
<body>
<div id="main_container">

<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">

<h2>Student Search / Student Assignment Details</h2>
<form name="f1" method="post" action=""><%@ page
	import="java.util.*"%> <%
 
 %> <%@ page import="com.iGrandee.StudentSearch.StudentSearchEntry"%>

<%
	String date_str = "";
	StudentSearchEntry studentquery = new StudentSearchEntry(); 
	String rollnumber = "";
	 rollnumber=request.getParameter("rollnumber");
	
 			
 			
 			HashMap stdmap = null;
 			HashMap secmap = null;
 			HashMap NoofAlloteddiarymap = null;
 			ArrayList Studentpersonminidetails=new ArrayList();
 			ArrayList noofalloteddiary=new ArrayList();
 			ArrayList sectionarry=new ArrayList();
 			ArrayList standardarray=new ArrayList();
 			ArrayList studentidarray=new ArrayList();
 			ArrayList NoofAlloteddiaryArray=new ArrayList();
 			ArrayList getAllalloteddiaryarray=new ArrayList();
 	 		HashMap map = null;
 	 		HashMap studentidmap = null;
 	 		HashMap getAllalloteddiarymap = null;
 			
 			String sectionid="";
 			String standardid="";
 			String sectionname="";
 			String standardname="";
 			String name="";
 			String studentid="";
 			String diarystate="";
 			int Delayed=0;
 			int ontime=0;
 			String alloted="";
 			 Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber);
 			studentidarray = studentquery.getStudentId(rollnumber);
 			
 			
 			 if (studentidarray != null && studentidarray.size() > 0) {
 				studentidmap = (HashMap) studentidarray.get(0);
 				studentid = (String) studentidmap.get("studentid");
 			 }
 			 
 			 
 			
					//out.println("Delayed"+Delayed);
					//out.println("ontime"+ontime);
				 
 			 if (Studentpersonminidetails != null && Studentpersonminidetails.size() > 0) {
 					
 					map = (HashMap) Studentpersonminidetails.get(0);
 					name = (String) map.get("uname");
 					standardid = (String) map.get("standardid");
 					sectionid = (String) map.get("sectionid");

 			 }
 			 
 			 sectionarry= studentquery.getsectionname(sectionid);
 			 standardarray= studentquery.getstandatdname(standardid); 
 			

 			 if ((standardarray != null && standardarray.size() > 0) || (sectionarry != null && sectionarry.size() > 0)) {
 					
 				 stdmap = (HashMap) standardarray.get(0);
 				secmap = (HashMap) sectionarry.get(0);

 					standardname = (String) stdmap.get("standardname");
 					sectionname = (String) secmap.get("sectionname");

 			 }

 			ArrayList questionList=new ArrayList();
 			HashMap	hashmap					= null;

			questionList=studentquery.loadAssignmentViewForStudent(sectionid,studentid);
			//out.println(questionList);
			
			String standardscheduleid="";
 			String sessionname="";
 			ArrayList Yearofsessionarr=new ArrayList();
 			ArrayList getstandardscheduleid=new ArrayList();
 			HashMap getstandardscheduleidmap = null;
 			HashMap Yearofsessionarrmap=null;
 			 getstandardscheduleid = studentquery.getstandardscheduleid(rollnumber);
 			for(int k=0;k<getstandardscheduleid.size();k++)
 			{
 				getstandardscheduleidmap=(HashMap)getstandardscheduleid.get(k);
 				standardscheduleid=(String)getstandardscheduleidmap.get("standardscheduleid") ;
 				sectionid=(String)getstandardscheduleidmap.get("sessionid") ;

 			}
 			Yearofsessionarr=studentquery.getYearOfSession(standardscheduleid);
 			if(Yearofsessionarr!=null && Yearofsessionarr.size()>0)
 			{
 				for(int m=0;m<Yearofsessionarr.size();m++)
 				{
 					Yearofsessionarrmap=(HashMap)Yearofsessionarr.get(m);
 					sessionname=(String)Yearofsessionarrmap.get("sessionname");
 				}
 			}
 			
 %>
<form name="f1" method="post" action="">
<input type="hidden" name="rollnumber" value="<%=rollnumber %>">
<TABLE BORDER=0 class="tablecolor" CELLSPACING=0 WIDTH=100% align=center
	HEIGHT="100%" CELLPADDING=0>
	
	<tr>
		<td valign='top'>
				<table border=0 id="rounded-corner" width="80%">

			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="25%">Student Detail</th>
					<th scope="col" class="rounded" width="25%"></th>
					<th scope="col" class="rounded" width="25%"></th>
					<th scope="col" class="rounded-q4" width="25%"></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=3 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
				</tfoot>
				<tr>
					<td class="tablebold">Roll No :</td>
					<td class="tablelight"><%=rollnumber%></td>
					<td class="tablebold">Student Name :</td>
					<td class="tablelight"><%=name%></td>
				</tr>
				<tr>
					<td class="tablebold" >Year Of Session :</td>
					<td class="tablelight" ><%=sessionname%></td>
					<td class="tablebold">Standard :</td>
					<td class="tablelight"><%=standardname%></td>
				</tr>
				<tr>
					
					<td class="tablebold">Section :</td>
					<td class="tablelight" colspan=4><%=sectionname%></td>
				</tr>
		
		</table>
		</td>
	</tr>
	</table>
	
<br>
	<tr>
							<td align='left'>
							
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								        	<th scope="col" class="rounded-company" width="1%"></th>
								            <th scope="col" class="rounded" width="98%">Assignment Details</th>
								            <th scope="col" class="rounded-q4" width="1%"></th>
								        </tr>
								    </thead>
								    <tr>		
								    	<td colspan='3'>						
											<%
												String lessonscheduleid			= "";
												String templessonscheduleid		= "";
												String subjectscheduleid		= "";
												String tempsubjectscheduleid	= "";
												int assignmentcount				= 0;
												String questionfile				= "";
											
												if(questionList != null && questionList.size()>0){
													
													for(int y=0;y<questionList.size();y++){
														hashmap				= (HashMap)questionList.get(y);
														subjectscheduleid	= (String)hashmap.get("subjectscheduleid");
														lessonscheduleid	= (String)hashmap.get("lessonscheduleid");
														questionfile		= (String)hashmap.get("questionfile");
														
														if(tempsubjectscheduleid.equals("") || !tempsubjectscheduleid.equals(subjectscheduleid)){
															if(y != 0)
																out.print("</table>");
															
															out.print("<table  border='0' align='center' width='100%' cellspacing='0' cellpadding='5'>");
															//out.print("<tr><td>Subject Name</td><td>"+hashmap.get("subjectname")+"</td>");
															if(hashmap.get("staffname") == null)
																out.print("<tr><td colspan='6'><table width='100%' border='0'><tr><td width='13%' class='tablebold'>Subject Name</td><td width='1%' class='tablebold'>:</td><td width='36%' class='tablelight'>"+hashmap.get("subjectname")+"</td><td width='13%' class='tablebold'>Faculty Name</td><td width='1%' class='tablebold'>:</td><td width='36%'>Not Yet Allotted</td></tr></table></td></tr>");
															else
																out.print("<tr><td colspan='6'><table width='100%' border='0'><tr><td width='13%' class='tablebold'>Subject Name</td><td width='1%' class='tablebold'>:</td><td width='36%'  class='tablelight'>"+hashmap.get("subjectname")+"</td><td width='13%' class='tablebold'>Faculty Name</td><td width='1%' class='tablebold'>:</td><td width='36%'  class='tablelight'>"+hashmap.get("staffname")+"</td></tr></table></td></tr>");
															out.print("<tr><td class='tablebold' >SL No.</td><td class='tablebold'>Topic</td><td class='tablebold'>Start Date</td><td class='tablebold'>End Date</td><td class='tablebold'>Mark</td><td class='tablebold'>Reference</td></tr>");
															
															tempsubjectscheduleid	= subjectscheduleid;
															templessonscheduleid	= "";
															assignmentcount			= 0;
														}
														
														if(templessonscheduleid.equals("") || !templessonscheduleid.equals(lessonscheduleid)){
															out.print("<tr><td class='tablebold'>Lesson Name</td><td colspan='5'  class='tablelight'>"+hashmap.get("lessonname")+"</td>");
															templessonscheduleid	= lessonscheduleid;
														}
														
														if(hashmap.get("assignmentid") != null){
															out.print("<tr><td colspan='6'>No Question Found</td></tr>");
														}
														else{
															assignmentcount++;
															String questionname=(String)hashmap.get("questionname");
															if(questionname == null || questionname.equals("") || questionname.equals("-") || questionname.equalsIgnoreCase("null"))
																questionname="-";
															else
																questionname=(String)hashmap.get("questionname");
															
															out.print("<tr><td  class='tablelight'>"+assignmentcount+"</td><td>"+questionname+"</td><td  class='tablelight'  class='tablelight'>"+hashmap.get("assignmentdate")+"</td><td  class='tablelight'>"+hashmap.get("submissiondate")+"</td><td  class='tablelight'>"+hashmap.get("questionmark")+"</td>");
															
															/*if(questionfile == null || questionfile.equals("") || questionfile.equals("-") || questionfile.equalsIgnoreCase("null"))
																out.print("<td>-</td></tr>");
															else
																out.print("<td><a href='#' questionfile='"+questionfile+"' onClick=openfile(this)>View</a></td></tr>");
															*/
															
															if(hashmap.get("studentremarks") == null){
																out.print("<tr><td colspan='6'>Not Yet Submitted.</td></tr>");
															}
															else{
																out.print("<tr><td class='tablebold'>Student Remarks</td><td  class='tablelight'>"+hashmap.get("studentremarks")+"</td><td class='tablebold'>Submitted Date</td><td  class='tablelight'>"+hashmap.get("studentdate")+"</td>");
																questionfile	= (String)hashmap.get("file");
																if(questionfile == null || questionfile.equals("") || questionfile.equals("-") || questionfile.equalsIgnoreCase("null"))
																	out.print("<td>-</td></tr>");
																else
																	out.print("<td><a href='#' questionfile='"+questionfile+"' onClick=openfile(this)>View</a></td></tr>");
															}
															
															if(hashmap.get("facultyremarks") == null){
																out.print("<tr><td colspan='6'>No Remarks Given.</td></tr>");
															}
															else{
																out.print("<tr><td class='tablebold'>Faculty Remarks</td><td  class='tablelight'>"+hashmap.get("facultyremarks")+"</td><td class='tablebold'>Remarks Date</td><td  class='tablelight'>"+hashmap.get("facultydate")+"</td><td class='tablebold'>Mark</td><td  class='tablelight'>"+hashmap.get("mark")+"</td></tr>");
															}												
														}
													}
													out.print("</table>");
													
												}
												else{
													
												}
											%>
										</td>
									</tr>
								</table>
							</td>
						</tr>
	
		  <a href="#" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong>BACK</strong><span class="bt_blue_r"></span></a>

	
</form>
</div>
<!-- end of right content--></div>
<!--end of center content -->
<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>