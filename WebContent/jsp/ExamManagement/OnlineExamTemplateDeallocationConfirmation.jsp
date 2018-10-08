<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>i-Grandee Education - Online Exam Deallocation | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script> 
<script type="text/javascript">
	
function deallocatefun()
{
	var len=document.question_form.chk.length;
	var status=false;
	if(len!=undefined)
	{
		for(var i=0;i<len;i++)
			{
				if(document.question_form.chk[i].checked)
				{
					status=true;
				}
			}
	}
	else
	{
		if(document.question_form.chk.checked)
		{
			status=true;
		}
	}
	if(status)
		{
	if(confirm("Do you Want to Deallocate Online Exam...?"))
	{
	  	document.question_form.action="./OnlineExamDeallocationSubmit.jsp";
	  	document.question_form.submit();
	}
		}
	else
		{
		alert("Select Any One Template to Deallocate");  
		}
}
	function callBack(){
		  	
	  	document.question_form.action="./OnlineExamTemplateDeallocationView.jsp";
	  	document.question_form.submit();
	  	
	}

</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/examheader.jsp" %>

    <div class="center_content">

	<%ResourceBundle bundle = ResourceBundle.getBundle("resources.ApplicationResources");%>

    <div class="left_content">

    </div>

    <div class="right_content">
	<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.ExamManagement.QuestionPreparation"%>
	<%@page import="com.iGrandee.ExamManagement.ExamReport"%>

    <h2><%=bundle.getString("label.exam.Deallocationroot_2")%></h2>
    <%
    	QuestionPreparation prepare = new QuestionPreparation();
		String instituteid			= (String)session.getValue("instituteid");
    	HashMap	hashmap				= null;
    	String examname				= request.getParameter("examname");
    	String yearname				= request.getParameter("yearname");
    	String standardname			= request.getParameter("standardname");
    	String standardid			= request.getParameter("standard");
    	String chkid	[]			= request.getParameterValues("chk");
    	String boardname			= request.getParameter("boardname");
    	String templateid			= request.getParameter("template");
    	String templatetype			= request.getParameter("templatetype");
		String subjectname			= request.getParameter("subjectname");   
		String sessionid			= request.getParameter("academicyear");   
    	String subjectid			= request.getParameter("subject");
    	ExamReport 			prepare1 = new ExamReport();

    	String standardscheduleid	= prepare1.standardScheduleId(standardid,sessionid);

    	ArrayList TemplateList=new ArrayList();
  		TemplateList	= prepare.LoadTemplateOnlineExamDetails(sessionid,subjectid,standardscheduleid);    
  		  
  		String status				= null;
    %>
    
    <form name="question_form" action="" method="post">
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.exam.selectedinfo")%></th>
		            <th scope="col" class="rounded-q4" 		width="1%"></th>
		        </tr>
		    </thead>
		    <tr>
		    	<td colspan='2'>						
					<table width='100%' align='center' border='0' cellpadding='5'>
						<tr height=20>
							<td class=tablebold width="20%" align="left"><%=bundle.getString("label.exam.academicyear")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="75%" align="left">
								<%=yearname%>							
							</td>
						</tr>
						<tr height=20>
							<td class=tablebold width="20%" align="left"><%=bundle.getString("label.exam.boardname")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="75%" align="left">
								<%=boardname%>							
							</td>
						</tr>
						<tr height=20>
							<td class=tablebold width="20%" align="left"><%=bundle.getString("label.exam.standardname")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="75%" align="left">
								<%=standardname%>							
							</td>
						</tr>
						<tr height=20>
							<td class=tablebold width="20%" align="left"><%=bundle.getString("label.exam.subjectname")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="75%" align="left">
								<%=subjectname%>							
							</td>
						</tr>
						<tr height=20>
							<td class=tablebold width="20%" align="left"><%=bundle.getString("label.exam.templatetype")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="75%" align="left">
							Exam 	
							</td>
						</tr>
					</table>
				</td>
			</tr>
			  <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
		</table>
		<br>
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
					<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.exam.slno")%></th>
		            <th scope="col" class="rounded" 		width="20%"><%=bundle.getString("label.exam.templatename")%></th>
		            <th scope="col" class="rounded" 		>Remarks</th>
		            <th scope="col" class="rounded-q4"  	>Action</th>
		    </thead>
		        <tfoot>
    	<tr>
        	<td class="rounded-foot-left" colspan=3><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    <tbody>
		    <%
		    	String noqn			= "0";
		    	String marksperqn	= "0";
		    	if(TemplateList != null && TemplateList.size()>0){
		    		for(int y=0;y<TemplateList.size();y++){

		    			hashmap		= (HashMap)TemplateList.get(y);
		    			String innerexamname				= (String)hashmap.get("examname");
		    			String assigneddate					= (String)hashmap.get("assigneddate");
		    			String onlineexamid							= (String)hashmap.get("onlineexamid");
		    			String subscribedstatus				= (String)hashmap.get("subscribedstatus");
		    			String requestedusers				= (String)hashmap.get("requestedusers");
		    			String attendedusers				= (String)hashmap.get("attendedusers");
		    			String ontimeusers					= (String)hashmap.get("ontimeusers");
						int count=Integer.parseInt(subscribedstatus)+Integer.parseInt(requestedusers)+Integer.parseInt(attendedusers)+Integer.parseInt(ontimeusers);
		    			out.print("<tr><td>"+(y+1)+".</td><td>");
		    			out.println(innerexamname+"</td><td>");
		    			if(count>0)		    			
			    			out.println("Subscribed");
							else
				    			out.println("Not Subscribed");
		    			out.println("</td><td>");

						if(count>0)		
						{
			    			out.println("<input type='checkbox' name='chk' value='"+onlineexamid+"' disabled/>");
						}
						else
						{
							String chkstatus="";  
							if(chkid!=null && chkid.length>0)
							{
								for(int i=0;i<chkid.length;i++)
								{
									if(chkid[i].equals(onlineexamid))
										chkstatus="Yes";
								}
							}
								if(chkstatus.equals("Yes"))
			    				out.println("<input type='checkbox' name='chk' value='"+onlineexamid+"' checked=true/>");
								else
					    		out.println("<input type='checkbox' name='chk' value='"+onlineexamid+"' />");
						}
		    			out.println("</td></tr>");
		    		}
		    	}
		    	else
    				out.print("<tr><td colspan='4' align='center' class='nodata'>"+bundle.getString("label.exam.datanotfound")+"</td></tr>");
		    %>
		    </tbody>
		</table>
		<a href="#" class="bt_blue" onclick='deallocatefun()'><span class="bt_blue_lft"></span><strong>Deallocate</strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_blue" onclick='callBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.exam.back")%></strong><span class="bt_blue_r"></span></a>
		<input type='hidden' name='examname' 			value='<%=examname%>'>
		<input type='hidden' name='yearname' 			value='<%=yearname%>'>
		<input type='hidden' name='standardname' 		value='<%=standardname%>'>
		<input type='hidden' name='templatetype' 		value='<%=templatetype%>'>
		<input type='hidden' name='template' 			value=''>
		<input type='hidden' name='templatename' 			value=''>
		<input type='hidden' name='boardname' 			value='<%=boardname%>'>
		<input type='hidden' name='actionstatus' 		value=''>
		<input type='hidden' name='academicyear' 		value='<%=sessionid%>'>
		<input type='hidden' name='subject' 			value='<%=subjectid%>'>
		<input type='hidden' name='subjectname' 		value='<%=subjectname%>'>  
		
</form>		
    
    


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>