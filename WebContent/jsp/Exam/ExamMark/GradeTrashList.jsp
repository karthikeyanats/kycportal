<!DOCTYPE =html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<title><%=bundle.getString("label.product.name")%> - Grade Trash List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
function backfun()
{
			document.Grade_Form.action="./GradeView.jsp";
			document.Grade_Form.submit();
} 
	function Editfun(obj)
		{
		var editstatus=obj.getAttribute("editstatus");
		var editword="";
			if(editstatus=="A")
				{
					editword="Restore";
				}
			else if(editstatus=="X")
				{
					editword="Delete"
				}
			if(confirm("Do You Want To "+editword+" the Grade...?"))
			 	{
			 	document.Grade_Form.Gradeid.value=obj.getAttribute("gradesystemid");
				document.Grade_Form.editstatus.value=editstatus;
				document.Grade_Form.action="./GradeEditSubmit.jsp";
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

    <h2><%=bundle.getString("label.gradesystem.rootpathtrashlist")%> </h2>
	<form name="Grade_Form" action="" method="post">
    <input type=hidden name=examname />
    <input type=hidden name=academicname />
    <input type=hidden name="editstatus" value="T"/>
    <input type=hidden name=Gradeid />
    
    	<table id="rounded-corner" border=0  width="100%">
    	<thead>
    		<tr>
            	<th scope="col" class="rounded-company" width="100%" colspan=2><%=bundle.getString("label.gradesystem.selectinfo")%></th>
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
<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime"%>

<%
		com.iGrandee.Exam.ExamnameEntry  examQuery = new com.iGrandee.Exam.ExamnameEntry();
		String instituteid = null;
		ArrayList GradeList=new ArrayList();
		instituteid			= (String)session.getValue("instituteid");
		HashMap	hashmap				= null;
		String req_subjectscheduleid="";
		String reg_sessionid 	= null;
		String AcademicYear 	= null;

		
		//out.println("==============>>>>>>>>>"+request.getParameter("sessionname"));
	try{
	
		 if(request.getParameter("sessionname") != null )		{
			 reg_sessionid=request.getParameter("sessionname");
			 AcademicYear=request.getParameter("academicname");
			GradeList=examQuery.LoadGradeTrashList(reg_sessionid);

		}
		
		
}catch(Exception e){}
			
%>
			
<tbody>	
<tr height='23'>

		<td class=tablebold width='20%'><%=bundle.getString("label.gradesystem.academic")%></td>
		<td class=tablebold width="2%">:</td>
		<td width='80%'>
					<%=AcademicYear %>
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
					        	<th scope="col" class="rounded-company" width="10%" rowspan=2><%=bundle.getString("label.gradesystem.slno")%></th>
					        	<th scope="col" class="rounded" 		width="20%" rowspan=2><%=bundle.getString("label.gradesystem.gradename")%></th>
					        	<th scope="col" class="rounded" 		width="30%" colspan=2 align="center"><%=bundle.getString("label.gradesystem.range")%></th>
					        	<th scope="col" class="rounded-q4"		width="30%" rowspan=2><%=bundle.getString("label.gradesystem.action")%></th>
					        	<tr class=tableheading><th scope="col" class="rounded" 	><%=bundle.getString("label.gradesystem.from")%></th><th scope="col" class="rounded" 	><%=bundle.getString("label.gradesystem.to")%></th>
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
								out.println("<td>"+j+"</td><td class=tablelight align='left'>"+hashmap.get("gradename")+"</td>");
								out.println("<td class=tablelight align='center'>"+hashmap.get("rangefrom")+"</td><td align='center'>"+hashmap.get("rangeto")+"</td>");
								out.println("<td class=tablelight ><a href='#restore' name='restore' editstatus='A' gradesystemid='"+hashmap.get("gradesystemid")+"' onclick='Editfun(this)'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/16-undo1.png' alt='Restore' title='Restore' border=0 /><a/>&nbsp;|&nbsp;<a href='#Delete' name='Delete' editstatus='X' gradesystemid='"+hashmap.get("gradesystemid")+"' onclick='Editfun(this)'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_logout.png' alt='Delete' title='Delete' border=0 /><a/></td>");
								out.println("</tr>");
							}
					 	}
					   	else
					   	{
					   		out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
					   	}
					   	}
					   	else
					   	{
							out.println("<tr align='center' ><td colspan='5'>Select Acedamic Year</td><tr>");
					   	}
						%>
						</tbody>
		</table>
		</td>
		</tr>
	</table>
<a href="#sub" name="sub" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.gradesystem.back")%></strong><span class="bt_blue_r"></span></a>
 <input type=hidden name=sessionname value='<%=reg_sessionid %>'/>
		 
</form>	
    </div><!-- end of right content-->
	</div>   <!--end of center content -->

   <div class="clear"></div>
   </div> <!--end of main content-->
<%@ include file="../../include/footer.jsp" %>
</div>
</body>
</html>