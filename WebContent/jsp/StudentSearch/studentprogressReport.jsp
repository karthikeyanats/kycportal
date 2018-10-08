<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.studentsearch.progressreporttitle") %> | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script language='javascript'>

function backfun()
{

document.f1.action= "HomePage.jsp";
			document.f1.submit();

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

<h2><%=bundle.getString("label.studentsearch.progressreportrootpath") %></h2>
<form name="f1" method="post" action=""><%@ page
	import="java.util.*"%> <%
 
 %> <%@ page import="com.iGrandee.StudentSearch.StudentSearchEntry,com.iGrandee.GradeSetting.GradeScaleQuery"%>

<%
	String date_str = "";
	StudentSearchEntry studentquery = new StudentSearchEntry();
	GradeScaleQuery  gradescaleQuery = new GradeScaleQuery();

	String rollnumber = "";
	 rollnumber=request.getParameter("rollnumber");
	
 			
 			
 			
 			ArrayList Studentpersonminidetails=new ArrayList();
 			ArrayList studentidarray=new ArrayList();
 			ArrayList LoadExamnameList=new ArrayList();
 			ArrayList getstandardscheduleid=new ArrayList();
 	 		HashMap map3 = null;
 	 		HashMap studentidmap = null;
 	 		HashMap getstandardscheduleidmap = null;
 			
 			String sectionid="";
 			String standardid="";
 			String sectionname="";
 			String standardname="";
 			String name="";
 			String diarystate="";
 			String standardscheduleid="";
 			String sessionid="";
 			String groupname = null;
 			String sessionname="";
 	       	int count=0;

 			String Sessionid="";
 			String studentallocationid="";
    	
 			ArrayList GradeList=null;
 			 
 			Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber,(String)session.getValue("sessionid"));
 			//Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber);
 			 
 			getstandardscheduleid = studentquery.getstandardscheduleid(rollnumber);
 			for(int k=0;k<getstandardscheduleid.size();k++)
 			{
 				getstandardscheduleidmap=(HashMap)getstandardscheduleid.get(k);
 				standardscheduleid=(String)getstandardscheduleidmap.get("standardscheduleid") ;
 				sectionid=(String)getstandardscheduleidmap.get("sessionid") ;

 			}
 			
 			LoadExamnameList=studentquery.newStandardSubjectSchedule(standardscheduleid);
 				 
 			 if (Studentpersonminidetails != null && Studentpersonminidetails.size() > 0) {
 					

 				map3 = (HashMap) Studentpersonminidetails.get(0);
 				name = (String) map3.get("uname");
 				standardid = (String) map3.get("standardid");
 				sectionid = (String) map3.get("sectionid");
 				
 				standardname = (String) map3.get("standardname");
 				sectionname = (String) map3.get("sectionname");
 				standardscheduleid = (String) map3.get("standardscheduleid");
 				sessionname = (String) map3.get("sessionname");
 				studentallocationid = (String) map3.get("studentallocationid");
 				Sessionid= (String) map3.get("sessionid");
 				groupname = (String) map3.get("groupname");
 				if(groupname==null)
 					groupname = "";
 				else
 					groupname = " - "+groupname;
 			 }
 			 
			

 			
 		
        	
 			//GradeList=studentquery.LoadGradeList(Sessionid);
 			GradeList=studentquery.LoadGradeList(Sessionid);
 			GradeList	=	(ArrayList)gradescaleQuery.LoadGradeScaleList(standardscheduleid);
        	
 %>
<form name="f1" method="post" action="">
<input type="hidden" name="rollnumber" value="<%=rollnumber %>">
<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	height="100%" cellpadding=0>
	
	<tr>
		<td valign='top'>
				<table border=0 id="rounded-corner" width="80%">

			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="25%"><%=bundle.getString("label.studentsearch.hometableheading") %></th>
					<th scope="col" class="rounded" width="1%"></th>
					<th scope="col" class="rounded" width="23%"></th>
					<th scope="col" class="rounded" width="25%"></th>
					<th scope="col" class="rounded" width="1%"></th>
					<th scope="col" class="rounded-q4" width="25%"></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=5 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
				</tfoot>
				<tr>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.rollno") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=rollnumber%></td>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.studentname") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=name%></td>
				</tr>
				<tr>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.academicyear") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=sessionname%></td>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.standard") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=standardname%><%=groupname %></td>
				</tr>
				<tr>
					
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.section") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" colspan=4 width="20%"><%=sectionname%></td>
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
						out.print("<th scope='col' class='rounded' width='15%' rowspan='2'>Total</th>");
						out.print("<th scope='col' class='rounded-q4'  rowspan='2'>"+bundle.getString("label.progressreport.Grade")+"</th>");
			        	out.print("<tr class='tableheading'><th>"+bundle.getString("label.progressreport.ExamName")+"</th></tr>");//rangefrom,rangeto,gradename
						out.print("</thead>");
			        %>
				</tr>
			</thead>
			<%
	boolean flag 	= false;
	ArrayList tempList	= new ArrayList();
	ArrayList ResultList=studentquery.listmark(standardscheduleid,rollnumber,studentallocationid); 
	%>
	   <tbody>
		    <%
		    try{
		    	int date_foundcount=0;
		    	
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
													try
													{
													total+=Integer.parseInt(map1.get("marktaken")+"");
													}catch(NumberFormatException ne){}
													int theoryexternalmin=Integer.parseInt(map1.get("theoryexternalmin")+"");
													if(!innermark.equals("null"))
													{try
													{
														marks=Integer.parseInt(innermark);
													}catch(NumberFormatException ne){marks=999;}
														if(marks<theoryexternalmin)
															{
															//out.print("marks"-theoryexternalmin-->"+marks+""+theoryexternalmin);
																grade="No";
																if(marks!=999)
																out.print("<td><font color=red>"+marks+"</font></td>");
																else
																	out.print("<td><font color=red>AB</font></td>");
																	
															}
														else
															{
															if(marks==999)
																out.print("<td>AB</td>");
															else
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
												Gradename="<i><font color=red>No Grade</font></i>";									}
											}	
									out.print("<td>"+Gradename+"</td>");
								}
							}
							else
							{		date_foundcount++;
									if(date_foundcount==ResultList.size())	
									out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");

							}
						}
					
				}
			else
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
     <%=bundle.getString("label.progressreport.Note") %></a><br>
			<a class=tablebold><i><%=bundle.getString("label.progressreport.NE-NotEntered") %></i>
		</a><br>
		<a class="tablebold">AB-<i><%=bundle.getString("label.progressreport.Absent") %></i></a>

   		
		
<a href="#" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentsearch.back") %></strong><span class="bt_blue_r"></span></a>
	
</form>
	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>

</div>
</body>
</html>