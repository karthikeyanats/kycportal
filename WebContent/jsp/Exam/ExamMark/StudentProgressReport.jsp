<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.progressreport.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript">
function editExamname(obj)
{

	document.examscheduleviewform.examnameid_hidden.value = obj.getAttribute("examnameid");
	document.examscheduleviewform.examname_hidden.value=obj.getAttribute("examname");
	document.examscheduleviewform.examnameremarks_hidden.value=obj.getAttribute("examnameremarks");
	document.examscheduleviewform.createdby_hidden.value=obj.getAttribute("createdby");
	document.examscheduleviewform.action="ExamnameUpdate.jsp";
	document.examscheduleviewform.submit();
}
function onchangesubmitfun()
{
	document.examscheduleviewform.examnameid.value =	document.examscheduleviewform.examnameid.options[document.examscheduleviewform.examnameid.options.selectedIndex].value
	document.examscheduleviewform.submit();
}
function loadExam()
{
	document.examscheduleviewform.req_sessionids.value=document.examscheduleviewform.sessionname.options[document.examscheduleviewform.sessionname.options.selectedIndex].value;
	document.examscheduleviewform.submit();

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

   <h2><%=bundle.getString("label.progressreport.rootpath")%></h2>
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
		name=session.getValue("userfullname")+"";
		rollnumber=session.getValue("studentrollno")+"";
		if(session.getValue("studentrollno")==null)
			rollnumber = "Not yet Generated";
		/*String nave[] =session.getValueNames();
		for(int i=0;i<nave.length;i++)
		{
		out.println("<br>"+nave[i]);  
		}*/
		ArrayList StudentList=new ArrayList();
		HashMap Yearofsessionarrmap=null;
		LoadExamnameList=Examquery.newStandardSubjectSchedule(standardscheduleid);
		//ArrayList assd=Examquery.listStudentmark(standardscheduleid,studentid);
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
      %>
	<form name="f1" method="post" action="">

		<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.progressreport.StudentDetail")%></th>
					<th scope="col" class="rounded-q4" width="2%"></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tr>
				<td colspan='2'>
					<table width='100%' cellpadding='5'>
						<tr>
							<td class="tablebold" width='20%'><%=bundle.getString("label.progressreport.StudentName")%> </td>
							<td class=tablebold>:</td><td class="tablelight" width='30%'><%=prefix%><%=name%></td>
							<td class="tablebold" width='20%'><%=bundle.getString("label.progressreport.YearOfSession")%> </td>
							<td class=tablebold>:</td><td class="tablelight" width='30%'><%=sessionname%></td>
						</tr>
						<tr>
							
							<td class="tablebold"><%=bundle.getString("label.progressreport.Standard")%></td>
							<td class=tablebold>:</td><td class="tablelight"><%=standardname%></td>
							<td class="tablebold"><%=bundle.getString("label.progressreport.Section")%></td>
							<td class=tablebold>:</td><td class="tablelight" ><%=sectionname%></td>
						</tr>
						<tr>
							<td class="tablebold"> <%=bundle.getString("label.progressreport.RollNumber")%></td><td class=tablebold>:</td><td class="tablelight" colspan=3><%= rollnumber%></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		
		<br>
		
		
		<table border=0 id="rounded-corner1" width="100%">
			<thead>
				<tr class="tableheading">
					<th scope="col" class="rounded-company"  width="15%"><%=bundle.getString("label.progressreport.SubjectName")%></th>
			       	<%
			        	HashMap hashmap=null;
			        	if(LoadExamnameList!=null && LoadExamnameList.size()>0 ){
			        		
							for(int y=0,z=1;y<LoadExamnameList.size();y++,z++){
								hashmap=(HashMap)LoadExamnameList.get(y);
								out.print("<th scope='col' class='rounded'  rowspan='2'>"+hashmap.get("subjectname")+"</th>");
								count++;
							}
			
						}
						out.print("<th scope='col' class='rounded' width='15%' rowspan='2'>"+bundle.getString("label.progressreport.Total")+"</th>");
						out.print("<th scope='col' class='rounded-q4'  rowspan='2'>"+bundle.getString("label.progressreport.Grade")+"</th>");
			        	out.print("<tr class='tableheading'><th>"+bundle.getString("label.progressreport.ExamName")+"</th></tr>");//rangefrom,rangeto,gradename
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
								nodata++;
								if(!examnameid.equals(examid))
								{   
									String innermark="";
									String grade="yes";
									out.print("<tr align='center'>");
									out.print("<td>"+map.get("examname")+"</td>");
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
													total+=Integer.parseInt(map1.get("marktaken")+"");
													int theoryexternalmin=Integer.parseInt(map1.get("theoryexternalmin")+"");
													if(!innermark.equals("null"))
													{
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
													//out.print("<td align='left'>"+map1.get("marktaken")+"</td>");   
												} 
											}
										}
										if(stat.equals("no"))
										{   
											out.print("<td align='center'><font color=red>NE</font></td>");     
										} 
									}
									examid=examnameid;
									out.print("<td align='center'>"+total+"</td>"); 
									String Gradename="<i><font color=red>No Grade</font></i>";

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
												Gradename="<i><font color=red>No Grade</font></i>";									}
											}	
									out.print("<td>"+Gradename+"</td>");
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
      <br><br>   
      <a class=tablebold>
      <%=bundle.getString("label.progressreport.Note")%>:<br>
			<%=bundle.getString("label.progressreport.NE-NotEntered")%>  
		</a>

  		
		

	
</form>
	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>