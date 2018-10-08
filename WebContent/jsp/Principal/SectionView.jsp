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
document.Section_Form.submit();
}
function backfun()
{
document.Section_Form.action="./StandardView.jsp";
document.Section_Form.submit();
}
function loadStudent(obj)
{
document.Section_Form.sectionscheduleid.value=obj.getAttribute("sectionscheduleid");
document.Section_Form.sex.value=obj.getAttribute("sex");
document.Section_Form.sectionname.value=obj.getAttribute("sectionname");
document.Section_Form.action="./SectionWiseStudentView.jsp";
document.Section_Form.submit();
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
		ArrayList StandardList		= null;
		String standardname=request.getParameter("standardname")+"";
		String standardscheduleid=request.getParameter("standardscheduleid")+"";
		String boardid=request.getParameter("hiddensession")+"";
		String boardname=request.getParameter("boardname")+"";

		String sessionid=null;//request.getParameter("hiddenboard")+"";
		String sessionname=null;
		String rootlabel="";
		String	status  = "A";
		if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
		 	status = "A','D','C";
		if(((session.getValue("userrolename")+"").toLowerCase()).startsWith("admin"))
		{
			   sessionid=request.getParameter("req_sessionid")+"";
			   sessionname=request.getParameter("req_sessionname")+"";
			   rootlabel=bundle.getString("label.reports.reportsconsolidatedstandardwise");

		}
		else
		{
			sessionid=session.getValue("sessionid")+"";
			sessionname=session.getValue("sessionname")+"";
			rootlabel=bundle.getString("label.reports.standardstandardliststandardwise");

		}
		if(!standardname.equals("null") && !standardscheduleid.equals("null"))
		{
			StandardList=prinicipal.loadsectionforviewwithstatus(standardscheduleid,status);
		}
		String today				= DateTime.showTime("calendar");
		//out.println(StandardList);
%>
    <h2><%=rootlabel %> </h2>

<form name="Section_Form" action="" method="post">
						<input type="hidden" name="todaydate" value="<%=today %>">
						<input type="hidden" name="standardscheduleid" value="<%=standardscheduleid %>">
						<input type="hidden" name="session" value="<%=sessionid%>">
						<input type="hidden" name="board" value="<%=boardid%>">
						<input type="hidden" name="standardname" value="<%=standardname %>">
						<input type="hidden" name="sectionname" value="">
						<input type="hidden" name="sectionscheduleid" value="">
						<input type="hidden" name="sex" value="">
						<input type="hidden" name="sessioninstituteid" value="<%=instituteid %>">
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
	    			<td colspan=5>
	    			<%=standardname%>
	    			</td>
	    			
    			
    			</tr>
    			</table>
    			</td></tr></tbody></table>
    			<br>
		<table   align='center' border='0' id=rounded-corner1 bordercolor=white width="100%" cellpadding=3 cellspacing=3>
			<thead>
			<tr class=tableheading>
				<th scope="col" class="rounded-company" width="10%" rowspan=2><%=bundle.getString("label.schedule.slno")%></th>
				<th scope="col" class="rounded" width="30%" rowspan=2><%=bundle.getString("label.schedule.section")%></th>
				<th scope="col" class="rounded" width="20%" colspan=2><%=bundle.getString("label.reports.students")%></th>
				<th scope="col" class="rounded" width="20%"  rowspan=2><%=bundle.getString("label.reports.totalstudents")%></th>
				<tr class=tableheading><th scope="col" class="rounded" width="20%" ><%=bundle.getString("label.reports.male")%></th>
				<th scope="col" class="rounded-q4" width="20%" ><%=bundle.getString("label.reports.female")%></th>
			</tr>
			</thead>
		
		<tbody>
		<%
		int Totalstudent=0;
							if(StandardList != null && StandardList.size()>0)
								{
								for(int y=0,i=1;y<StandardList.size();y++,i++){
									hashmap		= (HashMap)StandardList.get(y);
									String sectionschedid=hashmap.get("sectionscheduleid")+"";
									String sectionname=hashmap.get("sectionname")+"";
									String groupname=hashmap.get("groupname")+"";
									if(!groupname.equals("null"))
									standardname=standardname+" -"+groupname;
									String malecount=hashmap.get("malecount")+"";
									String totalcount=hashmap.get("totalcount")+"";
									String femalecount=hashmap.get("femalecount")+"";
									String sectioncount=hashmap.get("sectioncount")+"";
									Totalstudent +=	Integer.parseInt(totalcount);				
									
									out.print("<tr align=center  ><td>"+i+"</td><td align=left>"+sectionname+"");
									out.print("</td>");
									if(!malecount.equals("null") && !malecount.equals("0"))
										out.println("<td><a href='#malecounthref' name='malecounthref' sex='M' sectionname='"+sectionname+"' sectionscheduleid='"+sectionschedid+"' onclick='loadStudent(this)'>[ "+malecount+" ]</a></td>");
									else
										out.println("<td>"+malecount+"</td>");
									if(!femalecount.equals("null") && !femalecount.equals("0"))
										out.println("<td><a href='#femalecounthref' name='femalecounthref' sex='F' sectionname='"+sectionname+"' sectionscheduleid='"+sectionschedid+"' onclick='loadStudent(this)'>[ "+femalecount+" ]</a></td>");
									else
										out.println("<td>"+femalecount+"</td>");
									if(!totalcount.equals("null") && !totalcount.equals("0"))
										out.println("<td><a href='#totalcounthref' name='totalcounthref' sex='T' sectionname='"+sectionname+"' sectionscheduleid='"+sectionschedid+"' onclick='loadStudent(this)'>[ "+totalcount+" ]</a></td>");
									else
										out.println("<td>"+totalcount+"</td>");
										out.println("</tr>");
								}
								}
							else
							{
								out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
								//out.print("<tr><td colspan='6' align=center>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");

							}
						%>
		</tbody>
		<tfoot>
		<tr >
				<td colspan='6'>&nbsp;</td>
			</tr>
			<tr>
				<td colspan='2' ></td><td colspan='2' class=tablebold align=right><%=bundle.getString("label.reports.totalnoofstudents")%>:</td><td  align=center class=tablebold><%=Totalstudent %></td>
			</tr>
		</tfoot>
		</table>

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