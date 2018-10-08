<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
function loadStandard()
{
document.Student_Form.submit();
}
function backfun()
{
document.Student_Form.action="./SectionView.jsp";
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
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">

	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="left_content">

    </div>

    <div class="right_content">

<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Common.DateTime"%>
<%

		PrinicipalQuery prinicipal			= new PrinicipalQuery();
		HashMap	hashmap				= null;
		String instituteid			= (String)session.getValue("instituteid");
		ArrayList sessionList		= prinicipal.loadyearofsession(instituteid);
		ArrayList BoardList			= prinicipal.loadboard(instituteid);
		ArrayList StudentList		= null;
		String standardname=request.getParameter("standardname")+"";
		String standardscheduleid=request.getParameter("standardscheduleid")+"";
		String sectionname=request.getParameter("sectionname")+"";
		String sectionscheduleid=request.getParameter("sectionscheduleid")+"";
		String sex=request.getParameter("sex")+"";
		String boardid=request.getParameter("board")+"";
		String boardname=request.getParameter("boardname")+"";

		String sessionid=null;//request.getParameter("session")+"";
		String sessionname=null;
		String rootlabel="";
		String	status  = "A";
		int rollNoNote = 0;
		if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
		 	status = "A','D','C";
		if(((session.getValue("userrolename")+"").toLowerCase()).startsWith("admin"))
		{
			   sessionid=request.getParameter("req_sessionid")+"";
			   sessionname=request.getParameter("req_sessionname")+"";
			   rootlabel=bundle.getString("label.reports.reportsconsolidatedsectionwise");

		}
		else
		{
			sessionid=session.getValue("sessionid")+"";
			sessionname=session.getValue("sessionname")+"";
			rootlabel=bundle.getString("label.reports.standardstandardlistsectionwise");

		}
		if(!sectionscheduleid.equals("null") && !sectionscheduleid.equals("null") && !sex.equals("null"))
		{
			StudentList=prinicipal.loadstudentforsectionscheduleidwithstatus(sectionscheduleid,sex,status); 
		}
		String sexlabel="";
		if(sex.equalsIgnoreCase("f"))
				sexlabel="/ Female List";
		else if (sex.equalsIgnoreCase("m"))
			sexlabel="/ Male List";

		String today				= DateTime.showTime("calendar");

		//out.println(StudentList);
%>
    <h2><%=rootlabel %>  <%=sexlabel%></h2>

<form name="Student_Form" action="" method="post">
						<input type="hidden" name="todaydate" value="<%=today %>">
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
						<input type=hidden name=req_sessionstatus value="<%=request.getParameter("req_sessionstatus") %>">
						
			<table id="rounded-corner" border=0 summary="Department List"
							width="100%">
							<thead>
								<tr>
									<th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
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
		    			<%=bundle.getString("label.schedule.academicyear")%>
		    			</td>
		    			<td class=tablebold>:</td>
		    			
		    			<td>
		    			<%=sessionname%>
		    			</td>
	    			
		    			<td  class=tablebold >
		    			<%=bundle.getString("label.schedule.board")%>
		    			</td>
		    			<td class=tablebold>:</td>
		    			
		    			<td>
		    			<%=boardname%>
		    			</td>
	    		</tr>
	    		<tr>
	    			
	    			<td  class=tablebold width=20%>
	    			<%=bundle.getString("label.schedule.standardname")%>
	    			</td>
	    			<td class=tablebold>:</td>
	    			
	    			<td>
	    			<%=standardname%>
	    			</td>
	    			<td class=tablebold  width=20%><%=bundle.getString("label.schedule.section")%></td>
	    			<td class=tablebold>:</td>
	    			
	    			<td><%=sectionname %></td>
	    		</tr>
	    		</table></td></tr>
	    		</tbody>
	    		
    			</table>
    			<br>
				<table align='center'  id=rounded-corner  width="100%">
				<thead>
					<tr>
						<th scope="col" class="rounded-company"  ><%=bundle.getString("label.schedule.slno")%></th>
						<th scope="col" class="rounded" ><%=bundle.getString("label.schedule.studentname")%></th>
						<th scope="col" class="rounded-q4" ><%=bundle.getString("label.schedule.rollno")%></th>
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
									if(rollno.equals("null")){
										rollno="<font color=red><i>-NYG-</i></font>";
										rollNoNote = rollNoNote+1;
									}
									String uname=hashmap.get("uname")+"";
									String firstname		= (String)hashmap.get("firstname");
									String middlename		= (String)hashmap.get("middlename");
									String lastname		= (String)hashmap.get("lastname");
									 
									 if(middlename==null || middlename.equals("") || middlename.equals("-")){
										 middlename="";
									 }
									 else
									 {
										 middlename=" "+middlename;
									 }
									 
									 if(lastname==null || lastname.equals("") || lastname.equals("-")){
										 lastname="";
								}
								 else
								 {
									 lastname=" "+lastname;
								 }
									 uname = firstname+middlename+lastname;
									String personid=hashmap.get("personid")+"";
									String studentallocationid=hashmap.get("studentallocationid")+"";
									//Totalstudent +=	Integer.parseInt(totalcount);				
									//rollno=R1100, uname=Mr.Bharat khan, personid=29, studentallocationid=5
									out.print("<tr align=left  ><td width='20%'>"+i+"</td>");
									out.println("<td align=left width='40%'><a href='#studenthref' name='studenthref'  studentallocationid='"+studentallocationid+"' personid='"+personid+"' onclick='loadStudentProfile(this)'>"+uname+"</a></td>");
									out.println("<td align=left width='40%'>"+rollno+"</td>");
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
        			<td  colspan=2 class="rounded-foot-left"><em></em></td>
        			<td class="rounded-foot-right">&nbsp;</td>
       			</tr>
    			</tfoot>
    		
    </table>
		<% 
		if(rollNoNote>0)
		{
		%>
		<br>
		<tr>
		<td valign=top colspan=2>
			<b>Note: </b></td><td>&nbsp;</td><td>NYG - Not Yet Generated</td>
		</tr>  
		<br>
		<%}%>
		 <a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		</form>		

    </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>