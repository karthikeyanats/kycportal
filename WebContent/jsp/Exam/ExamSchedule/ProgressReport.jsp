<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name") %> - <%=bundle.getString("label.progressreportparent.entrytitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/highslide/highslide.css" />
<script type="text/javascript">
hs.graphicsDir = '<%=request.getContextPath()%>/jsp/kycpanel/highslide/graphics/';
hs.outlineType = 'rounded-white';
hs.wrapperClassName = 'draggable-header';

</script>

<script type="text/javascript">


function clickExamName(obj)
{
document.f1.examnameid.value=obj.getAttribute("examnameid");
document.f1.examname.value=obj.getAttribute("examname");

document.f1.action="SubjectwiseRank.jsp";
document.f1.submit();
}

</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">


<%@ include file="../../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

   <h2><%=bundle.getString("label.progressreportparent.entrytitle") %></h2>
    <!--<table border=0 cellpadding=3 cellspacing=2 width=100%>
    <tr><td align="right"><a href="<%=request.getContextPath()%>/jsp/Exam/MarkComparison.jsp" onclick="return hs.htmlExpand(this, { objectType: 'iframe',headingText: 'Student Mark Chart', maincontentId: 'credits', align: 'center', width: 800, height: 600 } )" >
		Student Mark Chart</a>
   </td></tr> 
   
   </table>-->
	<%@ page import="java.util.*"%> 
	<%@ page import="com.iGrandee.Exam.ExamnameEntry,com.iGrandee.GradeSetting.GradeScaleQuery"%>

	<%
		String date_str = "";
		ExamnameEntry Examquery = new ExamnameEntry();
		GradeScaleQuery  gradescaleQuery = new GradeScaleQuery();
		HashMap stdmap = null;
		HashMap secmap = null;
		ArrayList GradeList=new ArrayList();
		ArrayList LoadExamnameList=new ArrayList();
 		String standardscheduleid=session.getValue("standardscheduleid")+"";
		String sectionscheduleid=(String)session.getValue("sectionscheduleid")+"";

 		String studentid=session.getValue("studentid")+"";
		String sectionid="";
		String standardid="";
		String sectionname="";
		String standardname="";
		String Sessionid ="";
		String name="";
		String diarystate="";
		String sessionid="";
		String alloted="";
		String groupname="";
       	int count=0;

		String sessionname="";
		String rollnumber = "";
		sectionname = session.getValue("sectionname")+"";
		prefix=session.getValue("prefix")+"";
		name=session.getValue("studentname")+"";
		rollnumber=session.getValue("studentrollno")+"";
		if(session.getValue("studentrollno")==null)
			rollnumber = "Not yet Generated";
		
		
		ArrayList StudentList=new ArrayList();
		HashMap Yearofsessionarrmap=null;
		LoadExamnameList=Examquery.newStandardSubjectSchedule(standardscheduleid);
		ArrayList assd=Examquery.listStudentmark(standardscheduleid,studentid);
		StudentList=Examquery.StudentDetails(standardscheduleid);
		if(StudentList.size()>0)
		{
			for(int i=0;i<StudentList.size();i++)
			{
				HashMap detail=(HashMap)StudentList.get(i);
				sessionname		=detail.get("sessionname")+"";
			standardname 	=detail.get("standardname")+"";
 			groupname		=detail.get("groupname")+"";
 			if(!groupname.equals("null"))
 				standardname=standardname+" -"+groupname;
 			Sessionid		=detail.get("sessionid")+"";
			}
		}
		//GradeList=Examquery.LoadGradeList(Sessionid);
		GradeList	=	(ArrayList)gradescaleQuery.LoadGradeScaleList(standardscheduleid);
		
		String[] sessionvalus=session.getValueNames();
		for(int h=0;h<sessionvalus.length;h++)
		{
			//out.println(sessionvalus[h]+"  ");
		}
      %>
	<form name="f1" method="post" action="">

	<table id="rounded-corner" border=0 summary="Department List" width="100%">
					    <thead>
					    	<tr>
					        	
					            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.progressreportparent.StudentDetails") %></th>
					            <th scope="col" class="rounded-q4" width="2%"></th>
					        </tr>
					    </thead>
					    <tr>		
					    	<td colspan='2'>					
				
								<%
									out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
									out.print("<tr><td width='17%' class='tablebold'>"+bundle.getString("label.progressreportparent.StudentName")+"</td><td width='1%' class='tablebold'>:</td><td>"+session.getValue("studentname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.progressreportparent.AcademicYear")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
									if(session.getValue("groupname") == null)
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.progressreportparent.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"</td></tr>");
									else
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.progressreportparent.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.progressreportparent.SectionName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sectionname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.progressreportparent.BoardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("boardname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.progressreportparent.MediumName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("mediumname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.progressreportparent.RollNo.")+"</td><td class='tablebold'>:</td><td>"+session.getValue("rollno") + "</td></tr>");

									out.print("</table>");
								%>	
							</td>
						</tr>
					</table>	
					<br>
					
	
		
		<br>
		
		
		<table border=0 id="rounded-corner1" width="100%">
			<thead>
				<tr class="tableheading">
					<th scope="col" class="rounded-company"  width="15%"><%=bundle.getString("label.progressreportparent.SubjectName") %></th>
			       	<%
			        	HashMap hashmap=null;
			        	if(LoadExamnameList!=null && LoadExamnameList.size()>0 ){
			        		
							for(int y=0,z=1;y<LoadExamnameList.size();y++,z++){
								hashmap=(HashMap)LoadExamnameList.get(y);
								out.print("<th scope='col' class='rounded'  rowspan='2'>"+hashmap.get("subjectname")+"</th>");
								count++;
							}
			
						}
						out.print("<th scope='col' class='rounded' width='15%' rowspan='2'>"+bundle.getString("label.progressreportparent.Total")+"</th>");
						out.print("<th scope='col' class='rounded-q4'  rowspan='2'>"+bundle.getString("label.progressreportparent.Grade")+"</th>");
						out.print("<th scope='col' class='rounded-q4'  rowspan='2'>"+bundle.getString("label.progressreportparent.ClassPass%")+" </th>");
			        	out.print("<tr class='tableheading'><th>"+bundle.getString("label.progressreportparent.ExamName")+"</th></tr>");//rangefrom,rangeto,gradename
						out.print("</thead>");
			        %>
				</tr>
			</thead>
			<%
	boolean flag 	= false;
	ArrayList tempList	= new ArrayList();
	ArrayList ResultList	=	(ArrayList)Examquery.LoadExamMarksForstudent(studentid,standardscheduleid);  
	%>
	   <tbody>
		    <%
			String passpresentage="";
		    int nodata=0;
		    try{
		    if(ResultList!=null && ResultList.size()!=0)
				{
		    	String examid="";
					for(int i=0,s=1;i<ResultList.size();i++)
						{
				    		int total=0;
							HashMap map=(HashMap)ResultList.get(i);
							String examnameid=map.get("examnameid")+"";
							if(!examnameid.equals("null"))
							{
								if(!examnameid.equals(examid))
								{   nodata++;
									String innermark="";
									String grade="yes";
									out.print("<tr align='center'>");
									out.print("<td><a href='#' examnameid='"+map.get("examnameid")+"' examname='"+map.get("examname")+"' onclick='clickExamName(this)'>"+map.get("examname")+"</td>");
									for(int x=0;x<LoadExamnameList.size();x++)
									{
										String stat="no";
										HashMap map2=(HashMap)LoadExamnameList.get(x);
										String subjectscheduleid1=map2.get("subjectscheduleid")+"";
										for(int j=0;j<ResultList.size();j++)
										{
											HashMap map1=(HashMap)ResultList.get(j);
											String examnameid1=map1.get("examnameid")+"";
											String subjectscheduleid=map1.get("subjectscheduleid")+"";
											if(!examnameid1.equals("null"))
											{   
												if(examnameid.equals(examnameid1) && subjectscheduleid1.equals(subjectscheduleid))
												{               

													int marks=0;
													stat="yes";   
													innermark=map1.get("marktaken")+"";  

													int theoryexternalmin=Integer.parseInt(map1.get("theoryexternalmin")+"");
													if(!innermark.equals("null") && !innermark.equals("A"))
													{	total+=Integer.parseInt(map1.get("marktaken")+"");

														marks=Integer.parseInt(innermark);
														if(marks<theoryexternalmin)
															{
																grade="No";
																out.print("<td><font color=red>"+marks+"</font></td>");
															}
														else
															{
																out.print("<td>"+marks+"</td>");  
															}
													}
													else
													{
														out.print("<td class='tablelight'>A</td>");  

													}
													
													//out.print("<td align='left'>"+map1.get("marktaken")+"</td>");   
												} 
											}
										}
										if(stat.equals("no"))
										{   
											out.print("<td align='center'><font color=red>"+bundle.getString("label.progressreportparent.NE")+"</font></td>");     
										} 
									}
									examid=examnameid;
									out.print("<td align='center'>"+total+"</td>"); 
									String Gradename="<i><font color=red>- NYG -</font></i>";
									for(int i2=0;i2<GradeList.size();i2++)
									{
										HashMap map2=(HashMap)GradeList.get(i2);
										int to=Integer.parseInt(map2.get("rangeto")+"");
										int from=Integer.parseInt(map2.get("rangefrom")+"");
										
										if(from<=total && to>=total)
											if(grade.equals("yes") && !innermark.equals("null"))
											{
												Gradename=map2.get("gradename")+"";
												//out.print("<td>"+Gradename+"</td>");
											}
											else
											{
												Gradename="<i><font color=red>No Grade</font></i>";
											}
									}	
									out.print("<td>"+Gradename+"</td>");
				        			passpresentage	= Examquery.loadSectionwisePassPresentageView(examnameid,standardscheduleid,sectionscheduleid);
				        			if(passpresentage!=null)
				        			{    
				        				if(passpresentage.length()>5)
				        				{ 
				        					passpresentage=passpresentage.substring(0,5);
				        				}
				        				else  
				        				{ 
				        					passpresentage=passpresentage;
				        				}

				        			   out.println("<td align='center' class='tablelight'>"+passpresentage+" %"+"</td>");
				        			}
				        			else
				        			{
					        		out.println("<td align='center'><font color='red'>"+bundle.getString("label.progressreportparent.NE")+"</font></td>"); 
				        			}

								}

							}
						}
					
				}
			else
				  {
					  out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");
				  } 
		    if(nodata==0)    
			  {
			   	  out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");
			  } 
		    }
		    catch(Exception e)
		    {
		    	e.printStackTrace();
		    }
		  %>
		  </tbody>
      </table>  
      <iframe   frameborder=0 src="<%=request.getContextPath()%>/jsp/Exam/MarkComparison.jsp" style="width:100%;height:1100px;"></iframe>    
       <br><br>   
       
      <a class=tablebold>
 <%=  bundle.getString("label.progressreportparent.Note")%> :<br>
			<%=  bundle.getString("label.progressreportparent.NE")%> - <%= bundle.getString("label.progressreportparent.NotEntered")   %>
			<br><%= bundle.getString("label.progressreportparent.%")%> - <%= bundle.getString("label.progressreportparent.Percentage") %>
			<br><%= bundle.getString("label.progressreportparent.A")%> - <%=  bundle.getString("label.progressreportparent.Absent") %>
			<%out.println("NE :Not Entered<br>NYG :Not Yet Generated</a>"); %>
			
		</a>

  		
  		
		
<input type="hidden" name="examnameid">
	<input type="hidden" name="examname">
	
</form>
	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %> 
    

</div>
</body>
</html>