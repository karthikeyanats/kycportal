<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.studentsearch.diarytitle") %> | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script language='javascript'>

function backfun()
{

document.f1.action= "HomePage.jsp";
			document.f1.submit();

}
function allotedfun(flag)
{
document.f1.action= "ListDiary.jsp?flag="+flag;
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

<h2><%=bundle.getString("label.studentsearch.diaryrootpath")%></h2>
<form name="f1" method="post" action=""><%@ page
	import="java.util.*"%> <%
 
 %> <%@ page import="com.iGrandee.StudentSearch.StudentSearchEntry"%>

<%
	String date_str = "";
	StudentSearchEntry studentquery = new StudentSearchEntry(); 
	String rollnumber = "";
	 rollnumber=request.getParameter("rollnumber");
	
 			
 			int alloteddiarycount=0;
 			HashMap stdmap = null;
 			HashMap secmap = null;
 			HashMap NoofAlloteddiarymap = null;
 			ArrayList Studentpersonminidetails=new ArrayList();
 			ArrayList studentidarray=new ArrayList();
 			ArrayList NoofAlloteddiaryArray=new ArrayList();
 	 		HashMap map = null;
 	 		HashMap studentidmap = null;
 			
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
 			String groupname = null;
 			 //Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber);
 			 Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber,(String)session.getValue("sessionid"));
 			//studentidarray = studentquery.getStudentId(rollnumber);
 			
			 String standardscheduleid="";
			 String sessionname="";

			 if (Studentpersonminidetails != null && Studentpersonminidetails.size() > 0) {
					
				map = (HashMap) Studentpersonminidetails.get(0);
				name = (String) map.get("uname");
				standardid = (String) map.get("standardid");
				sectionid = (String) map.get("sectionid");
				
				standardname = (String) map.get("standardname");
				sectionname = (String) map.get("sectionname");
				standardscheduleid = (String) map.get("standardscheduleid");
				sessionname = (String) map.get("sessionname");
				studentid	= (String) map.get("studentallocationid");
				groupname = (String) map.get("groupname");
 				if(groupname==null)
 					groupname = "";
 				else
 					groupname = " - "+groupname;
			 }
 			
 			 //if (studentidarray != null && studentidarray.size() > 0) {
 				//studentidmap = (HashMap) studentidarray.get(0);
 				//studentid = (String) studentidmap.get("studentid");
 			 //}
 			 
 //System.out.print("studentid-->"+studentid);			 
				NoofAlloteddiaryArray = studentquery.NoofAlloteddiary(studentid);
				 if (NoofAlloteddiaryArray != null && NoofAlloteddiaryArray.size() > 0)
				 {
					 for(int i=0;i<NoofAlloteddiaryArray.size();i++)
					 {
						 NoofAlloteddiarymap = (HashMap) NoofAlloteddiaryArray.get(i);
					 diarystate = (String) NoofAlloteddiarymap.get("diarystate");
					 alloted = (String) NoofAlloteddiarymap.get("alloted");
					if(diarystate.equals("delayed"))
					{
						Delayed++;
					}
					else if(diarystate.equals("ontime"))
					{
						ontime++;
					}
				 }
		 		}
					

 			 
 			
 			
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
	


		
				<table border=0 id="rounded-corner" width="80%">

			<thead>
				<tr>
        	<th scope="col" class="rounded-company" width="25%"><%=bundle.getString("label.studentsearch.StudentDiary")%></th>
					<th scope="col" class="rounded" width="25%"></th>
					<th scope="col" class="rounded" width="25%"></th>
					<th scope="col" class="rounded-q4" width="25%" colspan=2></th>
            
        </tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=4 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
				</tfoot>
			
				<tr>
				<td class="tablebold" colspan=3 align=center><%=bundle.getString("label.studentsearch.NumberofallotedDiary")%>
				</td>
				<td class="tablelight" colspan=2>
				<%
				alloteddiarycount=studentquery.getcountalloteddiary(rollnumber);
				
					%>
					<a href="#" onclick=allotedfun('alloted')><%=alloteddiarycount%></a>
					<%
				
				%>
				</td>
				</tr>
												
				<tr>
				<td class="tablebold" colspan=3 align=center><%=bundle.getString("label.studentsearch.NumberofonTimeDiary")%>
				</td>
				<td class="tablelight" colspan=2>
				<%
				if(ontime>0){
				%>
				<a href="#" onclick=allotedfun('ontime')><%=ontime%></a>
				<%
				}else{
				out.print("0");
				}
				%>
				
				</td>
				</tr>
				<tr>
				<td class="tablebold" colspan=3 align=center><%=bundle.getString("label.studentsearch.NumberofDelyaedDiary")%>
				</td>
				<td class="tablelight" colspan=2>
				<%
				if(Delayed>0){
				%>
				<a href="#" onclick=allotedfun('Delayed')><%=Delayed%></a>
				<%
				}else{
				out.print("0");
				}
				%>
				
				</td>
				</tr>
			
		</table>
		
		</td>
	</tr>

		  <a href="#" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentsearch.back")%></strong><span class="bt_blue_r"></span></a>

	
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