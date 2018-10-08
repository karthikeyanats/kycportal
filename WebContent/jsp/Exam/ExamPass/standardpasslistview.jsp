<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.exampass.secwisepass")%>  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
	function backfun()
	{
	document.StudentReport_Form.action="./standardpasslist.jsp";
	document.StudentReport_Form.submit();
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

    <h2> <%=bundle.getString("label.exampass.stdrootpathview")%> </h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
	<%@ page import="com.iGrandee.Common.DateTime" %>
	
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Common.DateTime"%>

<form name="StudentReport_Form" action="" method="post">

		
		<%
			String	status  = "A";
			if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R")){
			 	status = "D";
		%>
		<table>		
		<tr>
			<td width='20%' valign=top class='tablebold'>Archival Details</td>
			<td width='1%' valign=top class='tablebold'>:</td>
			<td valign=top class='tablelight' width='79%'>
				<h2>This is an Archived Year</h2>
			</td>
		</tr>
		</table>
		<%		
			}
		%>		
<%

		PrinicipalQuery prinicipalquery			= new PrinicipalQuery();
		HashMap	hashmap				= null;
		HashMap	hashmap1			= null;
		ArrayList 	studentList		=null;	
		DateTime dateobj=new DateTime();
		//String sessionid			= request.getParameter("session");
		String sessionid			= (String)session.getValue("sessionid");
		String boardid				= request.getParameter("board");
		String standardscheduleid	= request.getParameter("standardscheduleid");
		
		//String sessionname			= request.getParameter("req_sessionname");
		String sessionname			= (String)session.getValue("sessionname");
		String boardname			= request.getParameter("req_boardname");
		String standardschedulename	= request.getParameter("req_standardnamegp");
		String sectionschedulename	= request.getParameter("req_sectionname");

		String condition	= request.getParameter("attendanceradio");
		String sessionuserid		= (String)session.getValue("userid");
		String instituteid			= (String)session.getValue("instituteid");
		String today				= DateTime.showTime("calendar");
		
		if(sessionid != null && boardid!= null && standardscheduleid!= null ) {
			studentList			= prinicipalquery.loadStandardwisePassListView(standardscheduleid);
		}
		
%>
		<input type=hidden name=hiddensession value="<%=sessionid%>">
		<input type=hidden name=hiddenboard value="<%=boardid%>">
		<input type=hidden name=standardscheduleid value="<%=standardscheduleid%>">
		
		<input type="hidden" name="req_sessionname" value="<%=sessionname%>">
		<input type="hidden" name="req_sessionstatus" value="<%=request.getParameter("req_sessionstatus")%>">
		<input type="hidden" name="req_boardname" value="<%=boardname%>">
		<input type="hidden" name="req_standardnamegp" value="<%=standardschedulename%>">
		<input type="hidden" name="req_sectionname" value="<%=sectionschedulename%>">
		<input type="hidden" name="req_rollno" >
		
		<input type="hidden" name="StudentPersonid" value="">
		<input type="hidden" name="condition" value="studentlist">
		
		
		<table width='80%' id=rounded-corner align='center' border='0' >
		 <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" colspan=6 width="100%"><%=bundle.getString("label.exampass.selectinfo")%></th>
		        	<th scope="col" class="rounded-q4"   ></th>
		        </tr>
		    </thead>
	    
			<tfoot>
			   	<tr>
			       	<td colspan="6" class="rounded-foot-left"><em></em></td>
			       	<td class="rounded-foot-right">&nbsp;</td>
			    </tr>
			</tfoot>		    
			<tr>
				<td width='20%' class='tablebold'><%=bundle.getString("label.exampass.academic")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
				<%=sessionname%>
				</td>
				<td width='5%' class='tablebold'><%=bundle.getString("label.exampass.board")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
					<%=boardname%>
				</td>
				<td></td>
			</tr>
			<tr>
				<td width='20%' class='tablebold' ><%=bundle.getString("label.exampass.standard")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' colspan=4>
					<%=standardschedulename%>
				</td>
				
				<td></td>
			</tr>
			</table>
			<%
			
			if(studentList.size() > 0)
			{%>
		<br><table border=0 id="rounded-corner1" width="100%">
			<thead>
				<tr class="tableheading">
					<th scope="col" class="rounded-company"  width="15%"><%=bundle.getString("label.exampass.examname")%></th>
			       	<%
			       	//out.print(studentList);
			       	int total=0;
			        	HashMap examnamehash=null;
			        	HashMap subjectnamenamehash=null;
			        	String examnameid_temp="";
			        	String subjectscheduleid_temp="";
			        	ArrayList examnameList=new ArrayList();
			        	ArrayList subjectList_temp=new ArrayList();
			        	ArrayList subjectnameList_temp=new ArrayList();
			        	
			        	String marktaken="";
						int presentage=0;
						String exam_name_id="";
						String studentListMark="";
			        	if(studentList!=null && studentList.size()>0 )
			        	{
			        		
							for(int y=0;y<studentList.size();y++)
							{
								examnamehash=(HashMap)studentList.get(y);
								if(!examnameid_temp.equals((String)examnamehash.get("examnameid")+""))
								{
								 out.print("<th scope='col' class='rounded'  rowspan='2'>"+examnamehash.get("examname")+"</th>");
								 examnameid_temp=(String)examnamehash.get("examnameid");
								 examnameList.add(examnameid_temp);
								}
								
								
							}
							
							
						out.print("</tr>");
			
						 out.print("<tr class='tableheading'><th>"+bundle.getString("label.exampass.subject")+"</th></tr>");
						 for(int y=0;y<studentList.size();y++)
							{  
				        		subjectnamenamehash=(HashMap)studentList.get(y);
				        		subjectscheduleid_temp=(String)subjectnamenamehash.get("subjectscheduleid");
				        		 exam_name_id=(String)subjectnamenamehash.get("examnameid");
								if(!subjectList_temp.contains(subjectscheduleid_temp))	
								{		 
								 out.print("<tr>");
								 subjectscheduleid_temp=(String)subjectnamenamehash.get("subjectscheduleid");
								 subjectList_temp.add(subjectscheduleid_temp);
								 subjectnameList_temp.add(subjectnamenamehash.get("subjectname"));
								}
								else
								{								
								}
								out.print("</td>");
							}
				        	
				        	for(int z=0;z<subjectList_temp.size();z++){
				        		out.print("<tr>");   
				        		out.println("<th align='justify' >"+subjectnameList_temp.get(z)+"</th>");
				        		for(int z1=0;z1<examnameList.size();z1++){ 
				        			studentListMark			= prinicipalquery.loadStandardisePassListMarkView(examnameList.get(z1)+"",subjectList_temp.get(z)+"",standardscheduleid);
				        			if(studentListMark!=null)
				        			{
				        				if(studentListMark.length()>5)
				        				{ 
				        					studentListMark=studentListMark.substring(0,5);
				        				}
				        				else  
				        				{ 
				        					studentListMark=studentListMark;
				        				}

				        			   out.println("<td align='center' class='tablelight'>"+studentListMark+" %"+"</td>");
				        			}
				        			else
				        			{
					        		out.println("<td align='center'><font color='red'>NE</font></td>"); 
				        			}

				        			
				        		}
				        		out.print("</tr>");
				        	}
				        	
				        	}
				        	else
				        	{
				        		out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>Data Not Found</font></td></tr>");
				        	}
							out.print("</thead>");
							out.print("</table>");
				        %>
				</tr>
			</thead>
			<%
			if(studentList!=null && studentList.size()>0 )
			        	{
			        	%>	
			<br><a><%=bundle.getString("label.exampass.note")%> :</a><br>
			<%=bundle.getString("label.exampass.ne")%>		    
						<%
			        	}
						%>
		  		
				

		</table>
		<%}else
    	{
    		out.print("<br><br><table id='rounded-corner1' border=0 width=\"100%\"><tr class=tableheading><td>Exam Name</td></tr><tr><td class=tablebold align=center align='center'><font color=red>Data Not found</font></td></tr></table>");
    	} %>
		<a href="#" class="bt_blue" onClick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.exampass.back")%></strong><span class="bt_blue_r"></span></a>
		
</form>		
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>

</html>