<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.gradesystem.gradeview")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
function loadfun()
{
	document.Grade_Form.sessionstatus.value=document.Grade_Form.sessionname.options[document.Grade_Form.sessionname.options.selectedIndex].getAttribute("status");
	document.Grade_Form.submit();
} 
	
	function TrashList()
	{
		if(check_ForParticularElements(document.Grade_Form.sessionname,"select"))
		 	{
			document.Grade_Form.academicname.value=document.Grade_Form.sessionname.options[document.Grade_Form.sessionname.options.selectedIndex].text;
			document.Grade_Form.action="./GradeTrashList.jsp";
			document.Grade_Form.submit();
			}
	}
	function Trashfun(obj)
		{
			if(confirm("Do You Want to Trash the Grade...?"))
			 	{
			 	document.Grade_Form.Gradeid.value=obj.getAttribute("gradesystemid");
				document.Grade_Form.editstatus.value="T";
				document.Grade_Form.action="./GradeEditSubmit.jsp";
				document.Grade_Form.submit();
				}
		}
		function Editfun(obj)
		{
			if(confirm("Do You Want to Update the Grade...?"))
			 	{
				 	document.Grade_Form.academicname.value=document.Grade_Form.sessionname.options[document.Grade_Form.sessionname.options.selectedIndex].text;
				 	document.Grade_Form.Gradeid.value=obj.getAttribute("gradesystemid");
					document.Grade_Form.action="./GradeEdit.jsp";
					document.Grade_Form.submit();
				}
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
 
    <h2><%=bundle.getString("label.gradesystem.rootpathview")%> </h2>
	<form name="Grade_Form" action="" method="post">
    <input type=hidden name=examId />
    <input type=hidden name=examname />
    <input type=hidden name=academicname />
      <input type=hidden name="editstatus"/>
          <input type=hidden name=Gradeid />
   <input type=hidden name=sessionstatus value="" />
      
    
    	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    		<tr>
            	<th scope="col" class="rounded-company" width="100%" colspan=2><%=bundle.getString("label.gradesystem.gradeview")%></th>
            	<th scope="col" class="rounded-q4" width="10"></th>        
        	</tr>
    	</thead>
        <tfoot>
    			<tr>
        			<td colspan="2" class="rounded-foot-left"><em></em></td>
        			<td class="rounded-foot-right">&nbsp;</td>
       			</tr>
    	</tfoot>
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Attendance.AttendanceQuery,com.iGrandee.Common.DateTime"%>

<%
		com.iGrandee.Exam.ExamnameEntry  examQuery = new com.iGrandee.Exam.ExamnameEntry();
		String instituteid = null;
		AttendanceQuery yearobj=new AttendanceQuery();
		ArrayList GradeList=new ArrayList();
		instituteid			= (String)session.getValue("instituteid");
		ArrayList academicList 		= yearobj.loadyearofsession(instituteid);
		HashMap	hashmap				= null;
		String req_subjectscheduleid="";
		String reg_sessionid 	= null;
		String sessionstatus=request.getParameter("sessionstatus")+"";
	try{
	
		 if(request.getParameter("sessionname") != null )		{
			 reg_sessionid=request.getParameter("sessionname");
			GradeList=examQuery.LoadGradeList(reg_sessionid);

		}
		
		
}catch(Exception e){}
			
%>

<tbody>	
<tr height='23'>

		<td class=tablebold width='20%'><%=bundle.getString("label.gradesystem.academic")%></td>
		<td class=tablebold width="2%">:</td>
		<td width='78%'>
					<select name=sessionname Validate='Academic Year' class=tablelight onchange='loadfun()'>
						<option value="00">-Select Academic-</option>
						<%
							for(int s=0;s<academicList.size();s++)
							{
								HashMap map=(HashMap)academicList.get(s);
								String sessionid=(String)map.get("sessionid");
								String yearofsession=(String)map.get("sessionname");
								if(request.getParameter("sessionname") != null)
								{
									if(request.getParameter("sessionname").equals(sessionid))
										out.println("<option selected value='"+sessionid+"' status='"+map.get("sessionstatus")+"'>"+yearofsession+"</option>");
									else
										out.println("<option value='"+sessionid+"'  status='"+map.get("sessionstatus")+"'>"+yearofsession+"</option>");
								}
								else
								{
									out.println("<option value='"+sessionid+"'  status='"+map.get("sessionstatus")+"'>"+yearofsession+"</option>");
								}
							
							}
						%>
					</select>
				</td>
</tr>
	</tbody>
</table>
  <br>
		<table width='100%' align='center' border='0' >
			<tr>
				<td width='100%' class='tablebold' colspan=2>
				
					<table id="rounded-corner1"  border=0 summary="Subject List" width="100%" cellspacing='3' cellpadding='5'>
					    <thead>
					    	<tr class=tableheading>
					        	<th scope="col" class="rounded-company" width="10%" rowspan=2><%=bundle.getString("label.topperweaker.slno")%></th>
					        	<th scope="col" class="rounded" 		width="20%" rowspan=2><%=bundle.getString("label.gradesystem.gradename")%></th>
					        	<th scope="col" class="rounded" 		width="30%" colspan=2 align="center"><%=bundle.getString("label.gradesystem.range")%></th>
					        	<th scope="col" class="rounded-q4"		width="30%" rowspan=2><%=bundle.getString("label.gradesystem.action")%></th>
					        	<tr class=tableheading><th scope="col" class="rounded" 	width="15%"><%=bundle.getString("label.gradesystem.from")%></th><th scope="col" class="rounded" ><%=bundle.getString("label.gradesystem.to")%></th>
					        </tr>
					    </thead>
					    <tfoot>
    			<tr>
        			<td colspan="3" class="rounded-foot-left"><em></em></td>
        			<td class="rounded-foot-right">&nbsp;</td>
       			</tr>
    	</tfoot>
    	<tbody>
					   	<%
					   	if(request.getParameter("sessionname") != null && !(request.getParameter("sessionname")+"").equals("00"))
					   	{
					   	int j = 1;
					   	if(GradeList.size()>0 && GradeList!=null)
					   	{
					   		for (int i = 0; i < GradeList.size(); i++,j++) 
		  		 			{	
					   			hashmap=(HashMap)GradeList.get(i);
								out.println("<tr  align='center'>");
								out.println("<td>"+j+"</td><td class=tablelight >"+hashmap.get("gradename")+"</td>");
								out.println("<td class=tablelight align='center'>"+hashmap.get("rangefrom")+"</td><td align='center'>"+hashmap.get("rangeto")+"</td>");
								if(sessionstatus.equals("R"))
									out.println("<td class=tablelight ><a href='#edit' name='edit' gradesystemid='"+hashmap.get("gradesystemid")+"' ><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_edit.png' alt='EDIT' title='EDIT' border=0 /><a/>&nbsp;|&nbsp;<a href='#trash' name='trash' gradesystemid='"+hashmap.get("gradesystemid")+"' ><img src='"+request.getContextPath()+"/jsp/kycpanel/images/trash.png' alt='Trash' title='Trash' border=0 /><a/></td>");
								else
									out.println("<td class=tablelight ><a href='#edit' name='edit' gradesystemid='"+hashmap.get("gradesystemid")+"' onclick='Editfun(this)'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_edit.png' alt='EDIT' title='EDIT' border=0 /><a/>&nbsp;|&nbsp;<a href='#trash' name='trash' gradesystemid='"+hashmap.get("gradesystemid")+"' onclick='Trashfun(this)'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/trash.png' alt='Trash' title='Trash' border=0 /><a/></td>");

								out.println("</tr>");
							}
					 	}
					   	else
					   	{
					   		out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
							//out.println("<tr align='center' ><td colspan='5'>Data Not Found</td><tr>");
					   	}
					   	}
					   	else
					   	{
							out.println("<tr align='center' ><td colspan='5'>Select Academic Year</td><tr>");
					   	}
						%>
						</tbody>
		</table>
		</td>
		</tr>
	</table>
	<%if(!sessionstatus.equals("R")) 
	{%>
		 <a href="#sub" name="sub" class="bt_red" onclick='TrashList()'><span class="bt_red_lft"></span><strong><%=bundle.getString("button.gradesystem.trashlist")%></strong><span class="bt_red_r"></span></a>
	 <%}else
		 {
			out.println("<div class=warning_box>This Academic Year is Archived So You Can't Edit or Delete </div>");
		 }%>
</form>	
    </div><!-- end of right content-->
	</div>   <!--end of center content -->

   <div class="clear"></div>
   </div> <!--end of main content-->
<%@ include file="../../include/footer.jsp" %>
</div>
</body>
</html>