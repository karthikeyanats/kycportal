<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.exam.examscheduletitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">
function loadboard()
{
	document.examnameviewform.standard.options[0].selected='true';
	document.examnameviewform.examname.options[0].selected='true';

	document.examnameviewform.submit();
}
function loadstandard()
{
	document.examnameviewform.examname.options[0].selected='true';
	document.examnameviewform.submit();
	
}
function loadexam()
{
	document.examnameviewform.submit();
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



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.exam.examschedulerootpath_1") %></h2>
<form name="examnameviewform" action="" method="post">
<input type=hidden name=examnameid1_hidden value=""/>
<input type=hidden name=examname_hidden/>
<input type=hidden name=examnameremarks_hidden/>
<input type=hidden name=createdby_hidden/>
<input type=hidden name="req_sessionids"/>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Exam.ExamnameEntry"%>
	<%@ page language="java"
	import="com.iGrandee.Assignment.Assignment"%>
	
<%
com.iGrandee.Exam.ExamnameEntry  examnameEntry = new com.iGrandee.Exam.ExamnameEntry();
com.iGrandee.Assignment.Assignment AssignQuery=new com.iGrandee.Assignment.Assignment();
com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();	

HashMap	hashmap			= null;
String req_sessionids 	= null;
String examnameid_hidden="";

String userid=(String)session.getValue("userid");
ArrayList LoadExamScheduleList = null;
ArrayList ExamList=null;
ArrayList standardList =  null;
ArrayList BoardList = null;

String instituteid	= (String)session.getValue("instituteid");
String sessionid	= (String)session.getValue("sessionid");
String req_boardid  = request.getParameter("boardname");
String req_standardscheduleid  = request.getParameter("standard");
String examid  = request.getParameter("examname");
BoardList = registrationQuery.loadBoardForStaff(userid,instituteid,sessionid);

if(req_boardid!=null)
{
	standardList = registrationQuery.loadStandardForStaff(userid,sessionid,req_boardid);
}
if(req_standardscheduleid!=null)
{
	standardList = registrationQuery.loadStandardForStaff(userid,sessionid,req_boardid);
}
if(req_boardid!=null && req_standardscheduleid!=null)
{
	ExamList = examnameEntry.LoadExamnameforstaff(userid,sessionid,req_boardid,req_standardscheduleid);
}
if(req_boardid!=null && req_standardscheduleid!=null && examid!=null)
{
	LoadExamScheduleList = examnameEntry.LoadScheduledExamListforstandard(examid,userid,req_standardscheduleid);
}

%>
<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="85%"><%=bundle.getString("label.examlist.ExamSchedule") %></th>
            <th scope="col" class="rounded-q4" width="15%"><font color=red>*</font><%=bundle.getString("label.common.mandatory") %></th>
        </tr>
    </thead>
   
     <tbody>
     <tr>
     <td colspan=2 >
     <table width="100%">
     <tr>
     <td class=tablebold><%=bundle.getString("label.exam.AcademicYear") %> </td>
				 <td class=tablebold>:</td><td  align=left><%=session.getValue("sessionname") %></td>
				<td class=tablebold><%=bundle.getString("label.exam.Board") %> <font color="red">*</font></td>
				 <td class=tablebold>:</td><td  align=left>
					<select name=boardname class=tablelight onchange=loadboard()>
						<option value="00">-Select Board-</option>
						<%
					      	if(BoardList!=null && BoardList.size()>0)
							{
			  		 			for (int i = 0, j = 1; i < BoardList.size(); i++) 
			  		 			{
									HashMap boardListMap=(HashMap)BoardList.get(i);
									String boardId     = (String)boardListMap.get("boardid");
									String boardName      = (String)boardListMap.get("boardname");
									String mediumId      = (String)boardListMap.get("mediumid");
									String mediumName      = (String)boardListMap.get("mediumname");
									
									if(boardId.equals(req_boardid))
									{
										out.println("<option selected value='"+boardId+"' class=tablelight >"+boardName+"-"+mediumName+"</option>");
									}
									else
									{
										out.println("<option value='"+boardId+"' class=tablelight >"+boardName+"-"+mediumName+"</option>");
									}
									
									//out.println("<option value='"+boardid+"' class=tablelight >"+boardname+"-"+mediumname+"</option>");
						  		 }
							}
						%>
					</select>
				</td>
			</tr> 	
				<tr>
				
				<td class=tablebold><%=bundle.getString("label.exam.Standard") %> <font color="red">*</font></td>
				 <td class=tablebold>:</td><td align=left><select name=standard class=tablelight onchange=loadstandard()>
					<option value="00">-Select Standard-</option>
					<%
					

						if(standardList !=null && standardList.size() >0)
						{
							for(int s1=0;s1<standardList.size();s1++)
							{
								HashMap map1=(HashMap)standardList.get(s1);
								//String standardid=(String)map1.get("standardid");
								String standardname=(String)map1.get("standardname");
								String standardscheduleid=(String)map1.get("standardscheduleid");
								String groupname=(String)map1.get("groupname");
								if(!groupname.equals("NoGroup"))
								{												
									standardname = standardname+" - "+groupname; 
								}
								//System.out.println("standardscheduleid-->"+standardscheduleid);
								//System.out.println("standardpublishid-->"+request.getParameter("reg_coursepubid_hidden"));
								if(standardscheduleid.equals(req_standardscheduleid))
								{
									out.println("<option selected value='"+standardscheduleid+"' class=tablelight >"+standardname+"</option>");
								}
								else
								{
									out.println("<option value='"+standardscheduleid+"' class=tablelight >"+standardname+"</option>");
								}
								
								//out.println("<option value='"+standardscheduleid+"'>"+standardname+"</option>");
							}
						}
					%>
					</select>
				</td>
				<td class=tablebold><%=bundle.getString("label.exam.Exam") %> <font color="red">*</font></td>
				 <td class=tablebold>:</td><td   align=left><select name=examname class=tablelight onchange=loadexam()>
					<option value="00">-Select Exam Name-</option>
					<%
					//System.out.println("ExamList-->"+ExamList);

			      	if(ExamList!=null && ExamList.size()>0)
					{
	  		 			for (int i = 0, j = 1; i < ExamList.size(); i++) 
	  		 			{
							HashMap ExamListMap=(HashMap)ExamList.get(i);
							String examId     = (String)ExamListMap.get("examnameid");
							//System.out.println("examId>>>>>>>>>>"+examId);
							String examName      = (String)ExamListMap.get("examname");
							String examallotmentId     = (String)ExamListMap.get("examallotmentid");
													
																							
							if(examId.equals(examid))   
							{
								out.println("<option  value='"+examId+"' class=tablelight selected>"+examName+"</option>");
							}
							else
							{
								out.println("<option value='"+examId+"' class=tablelight >"+examName+"</option>");
							}
				  		 }
					}					//out.println("<option value='1'>A</option>");
					%>
					</select>
				</td>
			</tr>
     </table></td></tr>
    	
    </tbody>
     <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
</table>

<br>
<table id="rounded-corner" border=0 summary="Examschedule List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.exam.SL.No") %></th>
            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.exam.SubjectName") %></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.exam.ExamDate") %></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.exam.StartTime") %></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.exam.EndTime") %></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.exam.Duration") %></th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.exam.examtype") %></th>
                     
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Exam.ExamnameEntry"%>

     <%
     
     try
     {
    	 	String examnameid			= request.getParameter("examnameid1_hidden");
    	 	String duration 			= null;
    	 	String examtype 			= null;
    	    
    	  
    	String temp_standardid = "";
    	 if(LoadExamScheduleList!=null && LoadExamScheduleList.size()>0)
			{
    		
    		 for (int i = 0, j = 1; i < LoadExamScheduleList.size(); i++) {
			
				HashMap ExamScheduleListMap=(HashMap)LoadExamScheduleList.get(i);
				
				String standardname       	= (String)ExamScheduleListMap.get("standardname");
				String subjectname 		  	= (String)ExamScheduleListMap.get("subjectname");
				String examdate  	= (String)ExamScheduleListMap.get("examdate");
				String examtimein      	= (String)ExamScheduleListMap.get("examtimein");
				String examtimeout=(String)ExamScheduleListMap.get("examtimeout");
				String examtimeinampm      	= (String)ExamScheduleListMap.get("examtimeinampm");
				String examtimeoutampm=(String)ExamScheduleListMap.get("examtimeoutampm");
				duration=(String)ExamScheduleListMap.get("duration");
				examtype=(String)ExamScheduleListMap.get("examtype");
				
				String standardid=(String)ExamScheduleListMap.get("standardid");
				String groupname =(String)ExamScheduleListMap.get("groupname");
				
				if(groupname != null)
					standardname = standardname+" - "+groupname;
				
				//if(ExamScheduleListMap.get("examtimein") != null && ExamScheduleListMap.get("examtimeout")!=null)
					//duration = examQuery.getHourMin(examtimein,examtimeout);
				
				%>
				
			<tr>
			 <td><%=j++ %></td>
            <td><%=subjectname %></td>
            <td><%=examdate %></td>
            <td><%=examtimeinampm %></td>
            <td><%=examtimeoutampm %></td>
            <td><%=duration %></td>
            <td><%=examtype %></td>
                                   
        </tr>
				<%
    		 }
			}
    	 	else{
    	 		out.println("<tr align='center' class='tablebold'><td colspan='11'><font color='red'>Data Not Found</font></td></tr>");
     			//out.println("<tr><td colspan=10 align=center>Data not found</td></tr>");    	 
    	 	}
    	    
     }catch(Exception e){}
          
     %>
    	
    </tbody>
</table>
</form>

	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>