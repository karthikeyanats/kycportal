<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Card Issue | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
function loadStandard()
{
document.Student_Form.submit();
}
function backfun()
{
document.Student_Form.action="./CardIssueSection.jsp";
document.Student_Form.submit();
}
function loadStudentProfile(obj)
{
document.Student_Form.StudentPersonid.value=obj.getAttribute("personid");
document.Student_Form.action="./StudentProfileView.jsp";
document.Student_Form.submit();
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

	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="left_content">

    </div>

    <div class="right_content">

<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Library.Report.BookJournalReport"%>
<%

		BookJournalReport reportquery			= new BookJournalReport();
		HashMap	hashmap				= null;
		String instituteid			= (String)session.getValue("instituteid");
		ArrayList StudentList		= null;
		String standardname=request.getParameter("standardname")+"";
		String standardscheduleid=request.getParameter("standardscheduleid")+"";
		String sectionname=request.getParameter("sectionname")+"";
		String sectionscheduleid=request.getParameter("sectionscheduleid")+"";
		String sex=request.getParameter("sex")+"";
		String boardid=request.getParameter("board")+"";
		String boardname=request.getParameter("boardname")+"";
		String academicyear=request.getParameter("academicyear")+"";
		
		String sessionid=null;//request.getParameter("session")+"";
		String sessionname=null;
		String	status  = "A";
		String totalcount_temp="";
		String issuedcount="";

	   sessionid=request.getParameter("req_sessionid")+"";
	   sessionname=request.getParameter("req_sessionname")+"";
	   totalcount_temp=request.getParameter("totalcount")+"";
	   issuedcount=request.getParameter("issuedcount")+"";
		
		if(!sectionscheduleid.equals("null") && !sectionscheduleid.equals("null") && !sex.equals("null"))
		{ 
			StudentList=reportquery.loadstudentforsectionscheduleidwithstatus(sectionscheduleid,status); 
		}
		

%>
    <h2><%=bundle.getString("label.cardissue.entryrootpathstudentlist")%> </h2>

<form name="Student_Form" action="" method="post">
						<input type="hidden" name="standardscheduleid" value="<%=standardscheduleid %>">
						<input type="hidden" name="hiddensession" value="<%=sessionid%>">
						<input type="hidden" name="hiddenboard" value="<%=boardid%>">
						<input type="hidden" name="standardname" value="<%=standardname%>">
						<input type="hidden" name="StudentPersonid" value="">
						<input type="hidden" name="sectionname" value="<%=sectionname %>">
						<input type="hidden" name="sessioninstituteid" value="<%=instituteid %>">
						<input type="hidden" name="sectionscheduleid" value="<%=sectionscheduleid %>">
						<input type="hidden" name="sex" value="<%=sex %>">
						<input type="hidden" name="req_sessionid" value="<%=sessionid %>">
						<input type="hidden" name="req_sessionname" value="<%=sessionname%>">
						<input type="hidden" name="boardname" value="<%=boardname%>">
						<input type="hidden" name=req_sessionstatus value="<%=request.getParameter("req_sessionstatus") %>">
						<input type="hidden" name="totalcount" value="<%=totalcount_temp%>">
						<input type="hidden" name="issuedcount" value="<%=issuedcount%>">
						<input type="hidden" name="academicyear" value="<%=academicyear%>">
						<input type="hidden" name="board" value="<%=boardid%>">
						
						
			<table id="rounded-corner" border=0 summary="Department List"
							width="100%">
							<thead>
								<tr>
									<th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.cardissue.selectedinfo")%></th>
									<th scope="col" class="rounded-q4" width="1%"></th>
								</tr>
							</thead>
							 <tfoot>
    			<tr>
        			<td  class="rounded-foot-left"><em></em></td>
        			<td class="rounded-foot-right">&nbsp;</td>
       			</tr>
    			</tfoot>
    			<tbody>
    			<tr>
    			<td colspan=2>
    			<table border=0 cellpadding=0 width="100%">
    			<tr>
		    			<td class=tablebold >
		    			<%=bundle.getString("label.cardissue.AcademicYear")%>
		    			</td>
		    			<td class=tablebold>:</td>
		    			
		    			<td class='tablelight'>
		    			<%=sessionname%>
		    			</td>
	    			
		    			<td  class=tablebold >
		    			<%=bundle.getString("label.cardissue.Board")%>
		    			</td>
		    			<td class=tablebold>:</td>
		    			
		    			<td class='tablelight'>
		    			<%=boardname%>
		    			</td>
	    		</tr>
	    		<tr>
	    			
	    			<td  class=tablebold width=20%>
	    			<%=bundle.getString("label.cardissue.standardname")%>
	    			</td>
	    			<td class=tablebold>:</td>
	    			
	    			<td class='tablelight'>
	    			<%=standardname%>
	    			</td>
	    			<td class=tablebold  width=20%><%=bundle.getString("label.cardissue.sectionname")%></td>
	    			<td class=tablebold>:</td>
	    			
	    			<td class='tablelight'><%=sectionname %></td>
	    		</tr>
	    		</table></td></tr>
	    		</tbody>
	    		
    			</table>
    			<br>
				<table align='center'  id=rounded-corner  width="100%">
				<thead>
					<tr>
						<th scope="col" class="rounded-company" width="5%" ><%=bundle.getString("label.cardissue.slno")%></th>
						<th scope="col" class="rounded" width="30%"><%=bundle.getString("label.cardissue.studentname")%></th>
						<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.cardissue.rollno")%></th>
						<th scope="col" class="rounded" width="15%"><%=bundle.getString("label.cardissue.issuedstatus")%></th>
						<th scope="col" class="rounded-q4" width="15%"><%=bundle.getString("label.cardissue.dateofissued")%></th>
						
					</tr>
			</thead>
		
		<%
							int Totalstudent=0;
							if(StudentList != null && StudentList.size()>0)
								{
								for(int y=0,i=1;y<StudentList.size();y++,i++)
								{
									hashmap		= (HashMap)StudentList.get(y);
									String rollno=hashmap.get("rollno")+"";
									if(rollno.equals("null"))
									rollno="<i>NYG</i>";
									String uname=hashmap.get("uname")+"";
									String personid=hashmap.get("personid")+"";
									String studentallocationid=hashmap.get("studentallocationid")+"";
									String issuedate=(String)hashmap.get("issuedate");
									if(issuedate==null)
									{  
									issuedate="-";
									}  
									//Totalstudent +=	Integer.parseInt(totalcount);				
									//rollno=R1100, uname=Mr.Bharat khan, personid=29, studentallocationid=5
									if(studentallocationid!=null  && !studentallocationid.equalsIgnoreCase("null") )
									{
									out.print("<tr align=left  ><td width='5%' class='tablelight'>"+i+"</td>");
									out.println("<td align=left width='30%' class='tablelight'>"+uname+"</td>");
									out.println("<td align=left width='20%' class='tablelight'>"+rollno+"</td>");
									out.println("<td align=left width='15%' class='tablelight'>Issued</td>");
									out.println("<td align=left width='15%' class='tablelight'>"+issuedate+"</td>");

									}
									else
									{
										out.print("<tr align=left  ><td width='5%'><font color='red' class='tablelight'>"+i+"</font></td>");
										out.println("<td align=left width='30%'><font color='red' class='tablelight'>"+uname+"</font></td>");
										out.println("<td align=left width='20%'><font color='red' class='tablelight'>"+rollno+"</font></td>");
										out.println("<td align=left width='15%'><font color='red' class='tablelight'>Not Issued</font></td>");
										out.println("<td align=left width='15%'><font color='red' class='tablelight'>"+issuedate+"</font></td>");

									}
									out.println("</tr>");
								}
								
								}
							else
							{
								out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
								//out.print("<tr><td colspan='3' align=center>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");

							}
						%>
						
					
		 <tfoot>
    			<tr>
        			<td  colspan=4 class="rounded-foot-left"><em></em></td>
        			<td class="rounded-foot-right">&nbsp;</td>
       			</tr>
    			</tfoot>
    		
    </table>
   <b> Note :- </b><br>
    <b>NYG - Not Yet Generated</b>

		 <a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		</form>		

    </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>

</html>