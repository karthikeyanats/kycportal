<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<jsp:useBean id="validate" scope="page"
	class="com.iGrandee.Common.CommonDataAccess" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Student Application Search</title>

<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/niceforms.js"></script>

<script language="JavaScript">

function onchangefun()
	{
		document.MainForm.board.options[0].selected=true;
		document.MainForm.submit();
	}
	function onchangefun1()  
	{
		document.MainForm.standard.options[0].selected=true;
		document.MainForm.submit();  
	}
	function onchangefun2()
	{
		document.MainForm.submit();  
	}
function backfun()
{
document.MainForm.action= "./StudentApplicationSearch.jsp";
document.MainForm.submit();
}
function profileedit(obj)
{
if(confirm("Do you want to Enter the Applicant Details...?"))
	{
		var applicationno=obj.getAttribute("applicationno");
		document.MainForm.ApplicationNumber.value=applicationno;
		document.MainForm.action= "./StudentApplicationEntry.jsp";
		document.MainForm.submit();
}
}
function profileview(obj)
{
if(confirm("Do you want to Update the Applicant Details...?"))
	{
		var studentid=obj.getAttribute("studentapprovalid");
		document.MainForm.req_boardname.value=document.MainForm.board.options[document.MainForm.board.options.selectedIndex].text;
		document.MainForm.stundentapproveid.value=studentid;
		document.MainForm.action= "./Studentprofileview.jsp";
		document.MainForm.submit();  
	}
}

function deletecandidate(obj){
	var applicationid=obj.getAttribute("applicationid")
	var personid= obj.getAttribute("personid")
	
	if(confirm("Are you sure want to delete?")) 
	{
		
		document.MainForm.action= "./Deletecandiate.jsp?applicationid="+applicationid+"&personid="+personid+"";
		document.MainForm.submit();  
	}
	
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
         <h2>Enrollment / Student Enrollment / Registered Student List  </h2>
     
<%@ page import="java.io.*,java.util.*,com.iGrandee.Attendance.AttendanceQuery,com.iGrandee.Registration.StudentRegistrationQuery"%>
<%
StudentRegistrationQuery registraquery =new StudentRegistrationQuery();
AttendanceQuery attencequery			= new AttendanceQuery();
String sessionstatus= "";
	String instituteid = null;
	ArrayList yearofsessionList = null;
	ArrayList boradlist = null;
	ArrayList Standardlist = null;
	ArrayList Studentlist = null;
	String standardscheduleid = null;

String Sessionid=request.getParameter("yearofsession")+"";
String Boardid="";  
String Standardscheduleid="";
	try {
		instituteid = (String) session.getValue("instituteid");
		yearofsessionList = attencequery.loadyearofsession(instituteid);
		if(!Sessionid.equalsIgnoreCase("null") && !Sessionid.equalsIgnoreCase("0"))
		{
			boradlist = registraquery.loadboard(instituteid);
		}
		if(!Sessionid.equalsIgnoreCase("null") && !Sessionid.equalsIgnoreCase("0") && !Boardid.equalsIgnoreCase("null") && !Boardid.equalsIgnoreCase("0"))
		{
			Boardid=request.getParameter("board")+"";  
			Standardlist = registraquery.loadstandard(Boardid,Sessionid,instituteid);
		}
		if(!Sessionid.equalsIgnoreCase("null") && !Sessionid.equalsIgnoreCase("0") && !Boardid.equalsIgnoreCase("null") && !Boardid.equalsIgnoreCase("0") && !Standardscheduleid.equalsIgnoreCase("null") && !Standardscheduleid.equalsIgnoreCase("0") && Standardlist.size()>0)
		{
			Standardscheduleid=request.getParameter("standard")+"";
			Studentlist = registraquery.loadstudentsessionandstandardvise(Standardscheduleid,Sessionid,instituteid);
		}

	} catch (Exception e) {e.printStackTrace();
		
	}
%>
<form name="MainForm" method="post" action="">    

<input type=hidden name=instituteid value="<%=instituteid %>">
<input type=hidden name=stundentapproveid value="">
<input type=hidden name=ApplicationNumber value="">
<input type=hidden name=req_boardname value="">


<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
		<tr>
		<td>
	<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>
        
        	<th scope="col" class="rounded-company" width="90%" >Registered Student Search</th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td   class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <tr>
       <td colspan=2>
     <table  border=0 summary="Department List" width="100%">
   			<tr>
				<td class="tablebold" width="25%">Academic Year</td>
				<td class=tablebold>:</td>
				<td>
				<select name=yearofsession onchange="onchangefun()">
				<option value="0">Select Academic Year</option><%
				if(yearofsessionList.size()!=0)
				{
					HashMap innermap=null;
					for(int i=0;i<yearofsessionList.size();i++)
					{
						innermap=(HashMap)yearofsessionList.get(i);
						String sessionid=(String)innermap.get("sessionid");
						String sessionname=(String)innermap.get("sessionname");
						if(Sessionid.equalsIgnoreCase(sessionid))
							out.println("<option value='"+sessionid+"' selected=true>"+sessionname+"</option>");
						else
						out.println("<option value='"+sessionid+"'>"+sessionname+"</option>");
					}
				}
				%>
				</select></td>
				<td class="tablebold" align=right>Board</td>
				<td class=tablebold>:</td>
				<td>
				<select name=board onchange="onchangefun1()">
				<option value="0">Select Board</option><%
				if(boradlist!=null && boradlist.size()!=0)
				{
					HashMap innermap=null;
					for(int i=0;i<boradlist.size();i++)
					{
						innermap=(HashMap)boradlist.get(i);
						String boardid=(String)innermap.get("boardid");
						String boardname=(String)innermap.get("boardname");
						String mediumname=(String)innermap.get("mediumname")+"";

						if(mediumname.equals("null"))
							boardname=boardname;
						else
							boardname=boardname+" -"+mediumname;
						if(Boardid.equalsIgnoreCase(boardid))
							out.println("<option value='"+boardid+"' selected=true>"+boardname+"</option>");

						else
						out.println("<option value='"+boardid+"'>"+boardname+"</option>");
					}
				}
				%>
				</select></td>
			</tr>
				<tr>
				<td class="tablebold" align=left width="25%">Standard Name</td>
				<td class=tablebold>:</td>
				<td >
				<select name=standard onchange="onchangefun2()">
				<option value="0">Select Standard</option>
				<%

				if(Standardlist!=null && Standardlist.size()!=0)
				{
					HashMap innermap=null;
					for(int i=0;i<Standardlist.size();i++)
					{
						innermap=(HashMap)Standardlist.get(i);
						standardscheduleid=(String)innermap.get("standardscheduleid");
						String standardname=(String)innermap.get("standardname");
						String groupname=innermap.get("groupname")+"";
						if(!groupname.equals("null"))
							standardname=standardname+" -"+groupname; 
						
						if(Standardscheduleid.equalsIgnoreCase(standardscheduleid))
						{
							out.println("<option value='"+standardscheduleid+"' selected=true>"+standardname+"</option>");
							//out.println("standardscheduleid====>>>"+standardscheduleid);
						}
						else
						{
						out.println("<option value='"+standardscheduleid+"'>"+standardname+"</option>");
						}
					}
				}
				%>
				</select></td>
				
			</tr>
			
		</table>
		</td>
		</tr>
</tbody>
</table>
<br>
<table id="rounded-corner" border=0   width="100%">
    <thead>
    	<tr>
        	<th  width="7%" scope="col" class="rounded-company">Sl.No</th>
            <th width="20%"  class="rounded" >Applicant Name</th>
            <th  width="15%"  class="rounded" >Application No.</th>
            <th  width="20%" class="rounded">Date of Admission</th>
            <th  width="20%" class="rounded">Profile Entry Status</th>
            <th  width="30%" class="rounded-q4">Action</th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=5  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    <tbody>
    <%
    try{
				if(Studentlist!=null && Studentlist.size()!=0)
				{
					HashMap innermap=null;
					for(int i=0;i<Studentlist.size();i++)
					{
						innermap=(HashMap)Studentlist.get(i);
						 
						 String applicationid=(String)innermap.get("applicationid")+"";
						 String personid=(String)innermap.get("personid")+"";
						 String studentapprovalid=(String)innermap.get("studentapprovalid")+"";
						 String applicationno=(String)innermap.get("applicationno")+"";
						 String applicantname=(String)innermap.get("applicantname")+"";
						 String dateofregistration=(String)innermap.get("dateofregistration")+"";
						 String candiregsterid=(String)innermap.get("candidateregisterid")+"";
						 sessionstatus=(String)innermap.get("sessionstatus")+"";
						 String studentallocationstatus=(String)innermap.get("studentallocationstatus")+"";

						out.println("<tr>");
						out.println("<td>"+(i+1)+"</td>");
					    if(sessionstatus.equals("R"))
					    {
							out.println("<td>"+applicantname+"</td>");
					    }
					    else
					    {
							if(!candiregsterid.equals("null"))
							{
								if(!studentallocationstatus.equals("C"))
								{
									out.println("<td><a href='#' studentapprovalid='"+studentapprovalid+"' applicationid='"+applicationid+"' onclick='profileview(this)'>"+applicantname+"</a></td>");
								}else{
									out.println("<td>"+applicantname+"</td>");
								}
							}
							else
							{
								out.println("<td>"+applicantname+"</td>");
							}
					    }
						out.println("<td>"+applicationno+"</td>");
						out.println("<td>"+dateofregistration+"</td>");
						if(!candiregsterid.equals("null"))
						{
							out.println("<td>Entered</td>");
						}
						else
						{
							if(sessionstatus.equals("R"))
							{
								out.println("<td><font color=grey>Not Entered</font></td>");
							}
							else
							{
								out.println("<td>y<a href='#'  applicationno='"+applicationno+"'  onclick='profileedit(this)'>Not Entered</a></td>");

							}
						}
						if(studentallocationstatus.equals("C"))
						{
							out.println("<td><i>TC Issued</i></td>");
						}
						else if(innermap.get("allocationstatus").equals("notallocated"))
						{
							out.println("<td><a href='#' studentapprovalid ="+studentapprovalid+"  applicationid='"+applicationid+"' personid='"+personid+"'  onclick='deletecandidate(this)'>Delete User</a></td>");
							
						}
						else {
							out.println("<td>"+innermap.get("allocationstatus")+"</td>");
							
						}
						
						
					}
				}
				else
				{
					out.println("<td colspan='5' align=center><font color='red'><b>Data Not Found</b></font></td>");
					//out.println("<td colspan=5 align=center><font color=red>Data Not Found</font></td>");
				}
    
    			
				%>
    </tbody>
    </table>
    <br>
    <%
    if(sessionstatus.equals("R")){
		out.println("<div class=warning_box>This Academic Year is Archived So You Can't Edit or Delete </div>");}
    }catch(Exception e){e.printStackTrace();}
    %>
	
<a href="#"  onclick="backfun()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong>Back</strong><span
		class="bt_blue_r"></span></a> 
</TABLE>
</div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../include/footer.jsp" %>

</div>
<input type="hidden" name="Standardscheduleid" value="<%=Standardscheduleid %>" >
    </form>
	
</body>
</html>