<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Student Mark  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>

<script type="text/javascript">

	
function Publishresult()
{
	if(confirm("Do you want to Publish the Result...?"))
		{
		document.ResultSubmitForm.action="./ExamResultPublishSubmit.jsp";
		document.ResultSubmitForm.submit();
		}
}	
function goBack()
{
		document.ResultSubmitForm.action="ExamResultPublish.jsp";
		document.ResultSubmitForm.submit();
}	
</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,java.util.ResourceBundle,com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.GradeSetting.GradeScaleQuery"%>
<body bgcolor="#2B303E" topmargin="0" bottommargin="0">
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
    </div>
    <div class="main_content">

<%@ include file="../include/header.jsp" %>

<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>
    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("hmlabel.examresultpublishview.rootpath")%> </h2>

<form name="ResultSubmitForm" action="" method="post">

	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    		<tr>
            	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("hmlabel.examresultpublishview.selectedinformation")%></th>
            	<th scope="col" class="rounded-q4" width="10%"></th>  
        	</tr>
    	</thead>
    
        <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       	</tr>
       		</tfoot>
       		
      <%
      PrinicipalQuery  examAllotmentQuery = new PrinicipalQuery();
      GradeScaleQuery  gradescaleQuery = new GradeScaleQuery();
      
		StringBuffer head=new StringBuffer();
		int colspancount=0;
		boolean  markstatus=true;

      	String Regno=null;
		String applicantName=null;
		String applicationNo=null;
		String studentallocationid="";
		String dateofallocation=null;
		String rollgenerationStatus=null;
		HashMap subname =new HashMap();

		String rollNo="";
		String marktaken="";
		String sessionid=session.getValue("sessionid")+"";
		
 		String boardid=request.getParameter("reg_boardid");
 		
 		//out.println("boardid==>"+boardid);
 		String stdscheduleid=request.getParameter("course");
 		//out.println("stdscheduleid==>"+stdscheduleid);
 		String yearofsession=request.getParameter("reg_sessiontext");
		String boardName=request.getParameter("reg_boardname");
		
		String reg_examid=request.getParameter("reg_examid");
		
		String courseid=request.getParameter("course");
		
		String examName=request.getParameter("reg_examname");
		String courseName=request.getParameter("reg_coursename");
		//String secName=request.getParameter("reg_sectionname");
		
		//String secSchedId=request.getParameter("reg_sectionpubid");
		
		String subjName=request.getParameter("reg_subjectname");
		
		
		ArrayList registeredList= null;
		ArrayList GradeList= null;
		//registeredList	=	(ArrayList)examAllotmentQuery.LoadsectionwiseStudentList(secSchedId);
	    String instituteid = null;
	    
	    try
	    {
	    	//System.out.print(reg_examid+"--"+courseid+"--"+secSchedId);
	    	
	    	//hidden by rams. reason - existing load the students based on the section wise. now load the student based on the standard.
			//registeredList	=	(ArrayList)examAllotmentQuery.LoadexammarkforPublish(reg_examid,courseid,secSchedId);
			registeredList	=	(ArrayList)examAllotmentQuery.LoadexammarkforPublish(reg_examid,courseid);
			//out.println(registeredList);
	    	instituteid = (String)session.getValue("instituteid");
	    	//GradeList	=	(ArrayList)examAllotmentQuery.LoadGradeList(sessionid);
	    	GradeList	=	(ArrayList)gradescaleQuery.LoadGradeScaleList(stdscheduleid);
	    }catch(Exception e){}

		
       %>

	

<tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="30%"><%=bundle.getString("hmlabel.examresultpublishview.academicyear")%></td><td class=tablebold>:</td><td class=tablelight  width="35%"><%=session.getValue("sessionname") %></td>
	<td class=tablebold  width="10%"><%=bundle.getString("hmlabel.examresultpublishview.board")%></td><td class=tablebold>:</td><td class=tablelight  width="40%"><%=boardName %></td>
</tr>
<tr><td class=tablebold><%=bundle.getString("hmlabel.examresultpublishview.examname")%></td><td class=tablebold>:</td><td class=tablelight><%=examName %></td>
<td class=tablebold ><%=bundle.getString("hmlabel.examresultpublishview.standard")%></td><td class=tablebold>:</td><td class=tablelight><%=courseName %></td>
</tr>
<%	

	int count=0;
	boolean flag 	= false;
	ArrayList tempList	= new ArrayList();
	String examallocationid="0";
	String markpublishstatus="yes";
String sectionid = null;
String sectionname = null;
	try
	{
	if(registeredList.size()!=0)
	{
		for(int i=0,s=1;i<registeredList.size();i++)
		{
			HashMap map=(HashMap)registeredList.get(i);
			String subjectname=map.get("subjectname")+"";
			examallocationid=map.get("examallotmentid")+"";
		
			
			 String markpublishsta=map.get("markpublishstatus")+"";
				if(markpublishsta.equalsIgnoreCase("P"))   
				{
					markpublishstatus="no";
				}
				
			if(!tempList.contains(subjectname))
			{
				subjectname=subjectname.trim();
				head.append("<th>S"+s+"</th>");
				colspancount++;
				subname.put("S"+s,subjectname);
				tempList.add(subjectname);
				s++;
			}
		}
		for(int i=0,s=1;i<registeredList.size();i++)
		{
			HashMap map=(HashMap)registeredList.get(i);
			String subjectname=map.get("subjectname")+"";
			if(!tempList.contains(subjectname))
			{
				subjectname=subjectname.trim();
				head.append("<th>S"+s+"</th>");
				colspancount++;
				subname.put("S"+s,subjectname);
				tempList.add(subjectname);
				s++;
			}
		}
	}
	else
	{
		markpublishstatus="";

	}
	
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	%>
	<tr>
	<td class=tablebold  align=left><%=bundle.getString("hmlabel.examresultpublishview.resultpublishstatus")%></td><td class=tablebold>:</td><td class=tablebold colspan=3>
	<% 	if(markpublishstatus.equals("yes") )
				{
						out.println("<font color='green'>Result Already Published</font>");
				}
		else
				{
						out.println("<font color='red'>Result Not Yet  Published</font>");
				}
	%></td>
	</tr>
	<%
	if(GradeList.size()==0)
		{
			%>
			  <tr>
			  	<td class=tablebold colspan=4 align=center><div class=warning_box style="width:600px;">Grade is  Not Yet Generate</div></td>
			  </tr>
			<%
		}
	 %>
	</table>
	</td></tr>
  	</table>
  	<br>
	<table id="rounded-corner1" border=0 summary="Department List" width="100%">
    <thead>
    	<tr class=tableheading  >
        	<th scope="col" class="rounded-company" width="10%" rowspan=2><%=bundle.getString("hmlabel.examresultpublishview.slno")%></th>
            <th scope="col" class="rounded" width="30%"  rowspan=2 ><%=bundle.getString("hmlabel.examresultpublishview.studentname")%></th>
            <th scope="col" class="rounded" width="10%"  rowspan=2>Section Name</th>
            <th scope="col" class="rounded" width="10%"  rowspan=2><%=bundle.getString("hmlabel.examresultpublishview.rollno")%></th>
            <th scope="col" class="rounded" width="20%" colspan=<%=colspancount %>><%=bundle.getString("hmlabel.examresultpublishview.markobtained")%></th>
            <th scope="col" class="rounded" width="10%" rowspan=2><%=bundle.getString("hmlabel.examresultpublishview.total")%></th>
            <th scope="col" class="rounded-q4" width="20%" rowspan=2><%=bundle.getString("hmlabel.examresultpublishview.grade")%></th>
            <tr  class=tableheading><%=head %>
		     </tr>
		    </thead>
      		<tfoot>
		    	<tr>
		        	<td colspan="<%=(colspancount+3) %>" class="rounded-foot-left"><em></em></td>
		        	<td class="rounded-foot-right" colspan='2'>&nbsp;</td>
		       </tr>
		    </tfoot>
		    <tbody>
		    <%
		    try{
		    if(registeredList.size()!=0)
				{
		    	String canid="";
					for(int i=0,s=1;i<registeredList.size();i++)
						{
				    	int total=0;

							HashMap map=(HashMap)registeredList.get(i);
							String candidateid=map.get("candidateregisterid")+"";

							//out.println(candidateid+"==="+canid);
							if(!candidateid.equals(canid))
							{   
								String innermark="";

								String grade="yes";
								String rollno = null;
								out.print("<tr align='center'>");
								out.print("<td>"+s+"</td>");
								out.print("<td align='left'>"+map.get("uname")+"</td>");
								out.print("<td align='left'>"+map.get("sectionname")+"</td>");
								
								if(map.get("rollno") != null)
								 rollno = (String)map.get("rollno");
								else
									rollno = "NYG";
								
								out.print("<td align='left'>"+rollno+"</td>");
								
								
								
								for(int i1=0;i1<registeredList.size();i1++)
								{

									HashMap map1=(HashMap)registeredList.get(i1);
									String candidateid1=map1.get("candidateregisterid")+"";
								
									if(candidateid1.equals(candidateid))
									{
										innermark=map1.get("marktaken")+"";
										int marks=0;
										String absent = map1.get("marktaken")+"";
										if(innermark.equals("A"))
											innermark="0";
										String maxmark=map1.get("theoryexternalmin")+"";
										if(maxmark.equals("null"))
											maxmark="0";
										int theoryexternalmin=Integer.parseInt(maxmark);
										if(!innermark.equals("null"))
										{
											marks=Integer.parseInt(innermark);
											if(marks<theoryexternalmin)
												{
													grade="No";
													if(absent == "A" || absent.equals("A")){
														out.print("<td><font color=red>"+absent+"</font></td>");
													}
													else
														out.print("<td><font color=red>"+marks+"</font></td>");													

													if(i==0)
													out.print("<input type='hidden' name='examscheduleid' value='"+map1.get("examscheduleid")+"'>");
													out.print("</td>");
												}
											else
												{
													out.print("<td>"+marks);
													if(i==0)
														out.print("<input type='hidden' name='examscheduleid' value='"+map1.get("examscheduleid")+"'>");
													out.print("</td>");

												}
										}
										else
										{
											out.print("<td><font color=red>NE</font></td>");
											markstatus=false;
										}
										total +=marks;
									}
								}
								out.print("<td>"+total+"</td>");
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
								out.print("</tr>");
								canid=candidateid;
								s++;
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
		
		<%
		if(!markstatus)
		{
			out.println("<div class=warning_box>Mark Not Entered So You Can't Publish the Result</div>");
		}
		if(subname.size()>0)
		{
		out.println("<a class=tablebold>Note :<br>");
		for(int sub=1;sub<=subname.size();sub++)
		{
			out.println("S"+sub+" :"+subname.get("S"+sub)+"<br>");
		}
		out.println("NE :Not Entered<br>");
		out.println("NYG:Not Yet Generated");
		}
		%>
		
		
		
		</a>
		<input type="hidden" name="examallocationid" value="<%=examallocationid %>" size=5/>
		
      <a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("hmbutton.examresultpublishview.back")%></strong><span class="bt_blue_r"></span></a>
     <%
     if(markstatus)
     {
		if(GradeList.size()!=0)
			{
				
		      if(markpublishstatus.equals("no"))
				{
		  %>
		      <a href="#" class="bt_green" onclick="Publishresult()"><span class="bt_green_lft"></span><strong><%=bundle.getString("hmbutton.examresultpublishview.publish")%></strong><span class="bt_green_r"></span></a>
		  <%    
		  		}
			}
     }
	  %>
      </form>
      
	</div><!-- end of right content-->


	</div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->

	<%@ include file="../include/footer.jsp" %>

	</div>
</body>
</html>
       	