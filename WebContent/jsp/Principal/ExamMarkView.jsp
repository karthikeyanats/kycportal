<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<title><%=bundle.getString("label.product.name")%> - Student Mark  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">

	
function goBack()
{

		document.ExammarkEntrySubmitForm.action="ExamMarkSearch.jsp";
		document.ExammarkEntrySubmitForm.submit();
}	

function facultyRemarks(obj)
{
//alert(obj.getAttribute("studentallocationid"));
	document.ExammarkEntrySubmitForm.req_studentname.value = obj.getAttribute("studentname");
	document.ExammarkEntrySubmitForm.req_studentallocationid.value = obj.getAttribute("studentallocationid");
	document.ExammarkEntrySubmitForm.req_studentrollno.value = obj.getAttribute("studentrollno");
	
	
	document.ExammarkEntrySubmitForm.action="ExammarkforPrincipal.jsp";
	document.ExammarkEntrySubmitForm.submit();
}

</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.GradeSetting.GradeScaleQuery"%>
<body bgcolor="#2B303E" topmargin="0" bottommargin="0">
<form name="ExammarkEntrySubmitForm" action="" method="post">
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

    <h2>Exam / Exam Mark / Exam Mark View</h2>


	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    		<tr>
            	<th scope="col" class="rounded-company" width="100%">Selected Information</th>
            	<th scope="col" class="rounded-q4" width="10"></th>        
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
      	String Regno=null;
		String applicantName=null;
		String applicationNo=null;
		String studentallocationid="";
		String dateofallocation=null;
		String rollgenerationStatus=null;
		HashMap subname =new HashMap();

		String rollNo="";
		String marktaken="";
		String sessionid=request.getParameter("req_sessionid");
		
 		String boardid=request.getParameter("req_boardid");
 		
 		//out.println("boardid==>"+boardid);
 		String stdscheduleid=request.getParameter("req_standardpubid");
 		//out.println("stdscheduleid==>"+stdscheduleid);
 		String yearofsession=request.getParameter("req_sessionname");
		String boardName=request.getParameter("req_boardname");
		
		String req_examnameid=request.getParameter("req_examnameid");
		
		//String courseid=request.getParameter("course");
		
		String examName=request.getParameter("req_examname");
		String courseName=request.getParameter("req_standardnamegp");
		String secName=request.getParameter("req_sectionname");
		
		String secSchedId=request.getParameter("req_sectionpubid");
		
		String subjName=request.getParameter("req_subjectname");
		
		
		ArrayList registeredList= null;
		ArrayList GradeList= null;
		//registeredList	=	(ArrayList)examAllotmentQuery.LoadsectionwiseStudentList(secSchedId);
	    String instituteid = null;
	    
	    try
	    {
	    	registeredList	=	(ArrayList)examAllotmentQuery.LoadexammarkforStudentList(req_examnameid,stdscheduleid,secSchedId);
	    	instituteid = (String)session.getValue("instituteid");
	    	//GradeList	=	(ArrayList)examAllotmentQuery.LoadGradeList(sessionid);
	    	GradeList	=	(ArrayList)gradescaleQuery.LoadGradeScaleList(stdscheduleid);
	    	//out.print("stdscheduleid-->"+stdscheduleid);
	    	//out.print("GradeList-->"+GradeList);
	    }catch(Exception e){}

		
       %>

			<br>





<tr><td colspan="2"><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%"><%=bundle.getString("label.exam.AcademicYear")%></td><td class=tablebold width="2%">:</td><td class=tablelight  width="35%"><%=session.getValue("sessionname") %></td>
	<td class=tablebold  width="10%"><%=bundle.getString("label.exam.Board")%> </td><td class=tablebold width="2%">:</td><td class=tablelight  width="40%"><%=boardName %></td>
</tr>
<tr>
<td class=tablebold width=15%><%=bundle.getString("label.exam.Standard")%></td><td class=tablebold width="2%">:</td><td class=tablelight width=35%><%=courseName %></td>
<td class=tablebold width=15%><%=bundle.getString("label.exam.Section")%></td><td class=tablebold width="2%">:</td><td class=tablelight width=35%><%=request.getParameter("req_sectionname") %></td>
</tr>
<tr><td class=tablebold><%=bundle.getString("label.exam.ExamName")%></td><td class=tablebold width="2%">:</td><td class=tablelight><%=examName %></td>
</tr>
</table>
</td></tr>
  </table>
  <br>
  
    	<%
    String markpublishstatus="P";
	int count=0;
	boolean flag 	= false;
	ArrayList tempList	= new ArrayList();
	try
	{
	if(registeredList.size()!=0)
	{
		for(int i=0,s=1;i<registeredList.size();i++)
		{
			HashMap map=(HashMap)registeredList.get(i);
			String subjectname=map.get("subjectname")+"";
			 String markpublishsta=map.get("markpublishstatus")+"";
			if(markpublishsta.equals("R"))
			{
				 markpublishstatus=map.get("markpublishstatus")+"";
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
	
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	%>


	<table id="rounded-corner1" border=0 summary="Department List" width="100%">
    <thead>
    	<tr class=tableheading  >
        	<th scope="col" class="rounded-company" width="10%" rowspan=2><%=bundle.getString("label.exammark.SL.No")%></th>
            <th scope="col" class="rounded" width="30%"  rowspan=2 ><%=bundle.getString("label.exammark.StudentName")%></th>
            <th scope="col" class="rounded" width="20%"  rowspan=2><%=bundle.getString("label.exammark.RollNo")%></th>
            <th scope="col" class="rounded" width="20%" colspan=<%=colspancount %>><%=bundle.getString("label.exammark.MarkObt")%></th>
            <th scope="col" class="rounded" width="10%" rowspan=2><%=bundle.getString("label.exammark.Total")%></th>
            <th scope="col" class="rounded-q4" width="20%" rowspan=2><%=bundle.getString("label.exammark.Grade")%></th>
            <tr  class=tableheading><%=head %>
		     </tr>
		    </thead>
      		<tfoot>
		<input type=hidden name=req_examnameid value="<%=request.getParameter("req_examnameid") %>">
		<input type=hidden name=req_sessionname value="<%=request.getParameter("req_sessionname") %>">
		<input type=hidden name=req_boardname value="<%=request.getParameter("req_boardname") %>">
		<input type=hidden name=req_examname value="<%=request.getParameter("req_examname") %>">
		<input type=hidden name=req_standardnamegp value="<%=request.getParameter("req_standardnamegp") %>">
		<input type=hidden name=req_sectionname value="<%=request.getParameter("req_sectionname") %>">

		<input type=hidden name=req_sessionid value="<%=request.getParameter("req_sessionid") %>">
		<input type=hidden name=req_boardid value="<%=request.getParameter("req_boardid") %>">
		<input type=hidden name=req_examnameid value="<%=request.getParameter("req_examnameid") %>">
		<input type=hidden name=req_standardpubid value="<%=request.getParameter("req_standardpubid") %>">
		<input type=hidden name=req_sectionpubid value="<%=request.getParameter("req_sectionpubid") %>">
		
		<input type=hidden name=req_studentname>
		<input type=hidden name=req_studentallocationid>
		<input type=hidden name=req_studentrollno>
		


    		
    
		  		
		    	<tr>
		        	<td colspan="<%=(colspancount+3) %>" class="rounded-foot-left"><em></em></td>
		        	<td class="rounded-foot-right" colspan='2'>&nbsp;</td>
		       </tr>
		    </tfoot>
		    <tbody>
		    <%
		    try{
		  if(!markpublishstatus.equals("P"))
		  {
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
								String grade="yes";
								out.print("<tr align='center'>");
								out.print("<td>"+s+"</td>");
								out.print("<td align='left'>"+map.get("uname")+"&nbsp;&nbsp;&nbsp;<a href='#' studentname='"+map.get("uname")+"' studentallocationid='"+map.get("studentallocationid")+"' studentrollno='"+map.get("rollno")+"' onclick=facultyRemarks(this)>[Staff Remarks]</a></td>");
								out.print("<td align='left'>"+map.get("rollno")+"</td>");
								for(int i1=0;i1<registeredList.size();i1++)
								{
									HashMap map1=(HashMap)registeredList.get(i1);
									String candidateid1=map1.get("candidateregisterid")+"";
									if(candidateid1.equals(candidateid))
									{
										String innermark=map1.get("marktaken")+"";
										String absent = map1.get("marktaken")+"";
										if(innermark.equals("null") || innermark.equals("A"))
											innermark="0";
										int marks=Integer.parseInt(innermark);
										int theoryexternalmin=Integer.parseInt(map1.get("theoryexternalmin")+"");
										if(marks<theoryexternalmin)
										{
											grade="No";
											if(absent == "A" || absent.equals("A")){
												out.print("<td><font color=red>"+absent+"</font></td>");
											}
											else if(absent==null || absent.equals("null"))
												out.print("<td><font color=red>NE</font></td>");
											else
												out.print("<td><font color=red>"+marks+"</font></td>");
										}
										else
										{
											out.print("<td>"+marks+"</td>");
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
									{
										if(grade.equals("yes"))
										{
											Gradename=map2.get("gradename")+"";
											//out.print("<td>"+Gradename+"</td>");
										}
										else
										{
											Gradename="<i><font color=red>No Grade</font></i>";	  									}
										}
									
									}	
								out.print("<td>"+Gradename+"</td>");

								out.print("<tr>");
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
		  else
			  {
				  out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'><br>Result Not Yet Published</font></td></tr>");
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
		if(subname.size()>0)
		{
		out.println("<a class=tablebold>Note :<br>");
		for(int sub=1;sub<=subname.size();sub++)
		{
			out.println("S"+sub+" :"+subname.get("S"+sub)+"<br>");
		}
		out.println("NE :Not Entered<br>NYG :Not Yet Generated</a>");
		}
		%>
      <a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.exam.Back")%></strong><span class="bt_blue_r"></span></a>


		 
	</div><!-- end of right content-->


	</div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->

	<%@ include file="../include/footer.jsp" %>

	</div>
</form>
</body>
</html>
       	