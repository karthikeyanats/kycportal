<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript">
function loadStandard()
{
document.Student_Form.submit();
}
function backfun()
{
document.Student_Form.action="./ReligionStdView.jsp";
document.Student_Form.submit();
}
function loadStudentProfile(obj)
{
document.Student_Form.StudentPersonid.value=obj.getAttribute("personid");
document.Student_Form.action="../../Principal/StudentProfileView.jsp";
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



    <div class="left_content">

    </div>
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="right_content">

<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Report.Reports,com.iGrandee.Common.DateTime"%>
<%

		Reports reportQuery			= new Reports();
		HashMap	hashmap				= null;
		String instituteid			= (String)session.getValue("instituteid");
		//ArrayList sessionList		= prinicipal.loadyearofsession(instituteid);
		//ArrayList BoardList			= prinicipal.loadboard(instituteid);
		ArrayList StudentList		= null;
		String standardname=request.getParameter("standardname")+"";
		String standardscheduleid=request.getParameter("standardscheduleid")+"";
		String sectionname=request.getParameter("sectionname")+"";
		String sectionscheduleid=request.getParameter("sectionscheduleid")+"";
		String operation=request.getParameter("operation")+"";
		String boardid=request.getParameter("board")+"";
		String sessionid=null;//request.getParameter("session")+"";
		String sessionname=null;
		String boardname=request.getParameter("boardname")+"";
		String rootlabel="";
		String	status  = "A";
		int rollNoNote = 0;
		if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
		 	status = "A','D','C";
		if(((session.getValue("userrolename")+"").toLowerCase()).startsWith("admin"))
		{
			   sessionid=request.getParameter("req_sessionid")+"";
			   sessionname=request.getParameter("req_sessionname")+"";
			   rootlabel=bundle.getString("label.reports.reportsreligionstudentlist");
		}
		else
		{
			sessionid=session.getValue("sessionid")+"";
			sessionname=session.getValue("sessionname")+"";
			rootlabel=bundle.getString("label.reports.standardstandardlist");

		}

		String operationlabel="";
		String operationquery="";
		
		if(operation.equalsIgnoreCase("religion")){
			operationquery = "pm.religion="+request.getParameter("religionid")+" and ";
			operationlabel="/ "+request.getParameter("religionname")+" List";
		}
		else if (operation.equalsIgnoreCase("exserviceman")){
			operationquery = "cm.exserviceman='Yes' and ";
			operationlabel="/ Son or Daughter of Ex-Service Man";
		}
		else if (operation.equalsIgnoreCase("phychal")){
			operationquery = "cm.physicallyfit='Yes' and ";
			operationlabel="/ Physically Challenged List";
		}

			StudentList=reportQuery.loadstudentforcommunitywithstatus(standardscheduleid,operationquery,status); 
		
		String today				= DateTime.showTime("calendar");
		

		//out.println(StudentList);   
%>
    <h2> <%=rootlabel %> <%=operationlabel%></h2>

<form name="Student_Form" action="" method="post">
						<input type="hidden" name="todaydate" value="<%=today %>">
						<input type="hidden" name="standardscheduleid" value="<%=standardscheduleid %>">
						<input type="hidden" name="session" value="<%=sessionid%>">
						<input type="hidden" name="hiddenboard" value="<%=boardid%>">
						<input type="hidden" name="hiddensession" value="<%=sessionid%>">
						<input type="hidden" name="board" value="<%=boardid%>">
						<input type="hidden" name="standardname" value="<%=standardname%>">
						<input type="hidden" name="StudentPersonid" value="">
						<input type="hidden" name="sessioninstituteid" value="<%=instituteid %>">
						<input type="hidden" name="operation" value="<%=operation %>">
						<input type="hidden" name="condition" value="religionview">
						<input type="hidden" name=operationlabel value="<%=operationlabel%>">
						<input type="hidden" name="req_sessionid" value="<%=sessionid %>">
						<input type="hidden" name="req_sessionname" value="<%=sessionname%>">
						<input type="hidden" name="boardname" value="<%=boardname%>">
						<input type=hidden name=religionid value="<%=request.getParameter("religionid")%>">
						<input type=hidden name=religionname value="<%=request.getParameter("religionname") %>">
						<input type=hidden name=req_sessionstatus value="<%=request.getParameter("req_sessionstatus") %>">
						
			<table id="rounded-corner" border=0 summary="Department List"
							width="100%">
							<thead>
								<tr>
									<th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
									<th scope="col" class="rounded-q4" width="1%"></th>
								</tr>
							</thead>
							 <tfoot>
    			<tr>
        			<td class="rounded-foot-left"><em></em></td>
        			<td class="rounded-foot-right">&nbsp;</td>
       			</tr>
    			</tfoot>
    			<tbody>
    			<tr>
    			<td colspan=2>
    			<table border=0 cellpadding=0 width="100%">
    			<tr>
    			
	    			<td class=tablebold ><%=bundle.getString("label.schedule.academicyear")%></td>
	    			<td class=tablebold>:</td>
	    			<td>
	    			<%=sessionname%>
	    			</td>
	    			<td  class=tablebold align=right>
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
	    			<td colspan=3>
	    			<%=standardname%>
	    			</td>
	    			
	    			</tr>
	    			</table></td></tr>
    			</tbody>
    			</table>
    			<br>
			
		<table   align='center' border='0' id=rounded-corner bordercolor=white width="100%" >
			<thead>
			<tr >
				<th scope="col" class="rounded-company"  ><%=bundle.getString("label.schedule.slno")%></th>
				<th scope="col" class="rounded"  ><%=bundle.getString("label.schedule.studentname")%></th>
				<th scope="col" class="rounded" ><%=bundle.getString("label.schedule.rollno")%></th>
				<th scope="col" class="rounded" >Contact Info</th>
				<th scope="col" class="rounded-q4" >Image</th>			
			</tr>
			</thead>
		
		<tbody>
		<%
		int Totalstudent=0;
							if(StudentList != null && StudentList.size()>0)
								{
								String tempsectionid="";
								for(int y=0,i=1;y<StudentList.size();y++,i++){
									hashmap		= (HashMap)StudentList.get(y);
									String rollno=hashmap.get("rollno")+"";
									if(rollno.equals("null")){
										rollno="<font color=red><i>-NYG-</i></font>";
										rollNoNote = rollNoNote+1;
									}
									String uname=hashmap.get("uname")+"";
									String personid=hashmap.get("personid")+"";
									String studentallocationid=hashmap.get("studentallocationid")+"";
									String imagepath	= hashmap.get("imagepath")+"";
									if(imagepath.equals("null"))
										imagepath="-";									
									
									//Totalstudent +=	Integer.parseInt(totalcount);
									String sectionid=hashmap.get("sectionid")+"";
									if(!sectionid.equals(tempsectionid))
									{
										out.print("<tr align=left class=tablebold ><td colspan=5>"+hashmap.get("sectionname")+""+"</td></tr>");
										tempsectionid=sectionid;
									}
									out.print("<tr align=left valign=top ><td>"+i+"</td>");
									out.println("<td align=left valign=top><a href='#studenthref' name='studenthref'  studentallocationid='"+studentallocationid+"' personid='"+personid+"' onclick='loadStudentProfile(this)'>"+uname+"</a></td>");
									out.println("<td align=left valign=top>"+rollno+"</td>");
									out.println("<td valign=top>"+hashmap.get("smscontactno")+"<br><a href='mailto:"+hashmap.get("emailid")+"'>"+hashmap.get("emailid")+"</a></td>");
									out.println("<td  valign=top><img src='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+imagepath+"' width=60 height=47></td>");						
									out.println("</tr>");
								}
								}
							else
							{
								out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
								//out.print("<tr><td colspan='3' align=center>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");

							}
						%>
		</tbody>
		<tfoot>
		<tr >
				<td colspan='5'>&nbsp;</td>
			</tr>
			<tr>
				<td colspan='5' ></td>
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

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>

</html>