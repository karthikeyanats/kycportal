<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>i-Grandee Education - Template Approvel View | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">
	
	
	function submitQuestion(str){
		
		var temp	= "";
		if(str == "A"){
			temp	= "Are you sure want to Approve this Template?";
			document.question_form.actionstatus.value		= "A";		
		}
		else{
			temp	= "Are you sure want to Delete this Template?";
			document.question_form.actionstatus.value		= "X";		
		}
	
		document.question_form.action				= "QuestionApprovalSubmit.jsp";
		document.question_form.submit();
	}	
	
	function callBack(){
		  	
	  	document.question_form.action="QuestionApprove.jsp";
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

    <h2><%=bundle.getString("label.exam.templatepproveroot")%></h2>
    <%
    	QuestionPreparation prepare = new QuestionPreparation();
		String instituteid			= (String)session.getValue("instituteid");
    	HashMap	hashmap				= null;
    	String examname				= request.getParameter("examname");
    	String yearname				= request.getParameter("yearname");
    	String standardname			= request.getParameter("standardname");
    	String templatename			= request.getParameter("templatename");
    	String boardname			= request.getParameter("boardname");
    	String templateid			= request.getParameter("template");
    	String templatetype			= request.getParameter("templatetype");
		String subjectname			= request.getParameter("subjectname");     	
    	ArrayList questionList		= prepare.questionSheetDetails(templateid);
    	String status				= null;
    	String gstatus				= null;
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
							<td class=tablebold width="20%" align="left"><%=bundle.getString("label.common.academicyear")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="75%" align="left">
								<%=yearname%>							
							</td>
						</tr>
						<tr height=20>
							<td class=tablebold width="20%" align="left"><%=bundle.getString("label.common.boardmediumname")%></td>
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
							<td class=tablebold width="20%" align="left"><%=bundle.getString("label.exam.subjectname")%>-<%=bundle.getString("label.common.subjectcode")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="75%" align="left">
								<%=subjectname%>							
							</td>
						</tr>
						<tr height=20>
							<td class=tablebold width="20%" align="left"><%=bundle.getString("label.exam.templatename")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="75%" align="left">
								<%=templatename%>							
							</td>
						</tr>
						<tr height=20>
							<td class=tablebold width="20%" align="left"><%=bundle.getString("label.exam.templatetype")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="75%" align="left">
								<%=templatetype%>							
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.exam.slno")%></th>
		            <th scope="col" class="rounded" 		width="25%"><%=bundle.getString("label.exam.lessonname")%></th>
		            <th scope="col" class="rounded" 		width="15%"><%=bundle.getString("label.exam.type")%></th>
		            <th scope="col" class="rounded" 		width="15%"><%=bundle.getString("label.exam.difficultyfactor")%></th>
		            <th scope="col" class="rounded" 		width="15%"><%=bundle.getString("label.exam.noofquestion")%></th>
		            <th scope="col" class="rounded" 		width="10%"><%=bundle.getString("label.exam.markperquestion")%></th>
		            <th scope="col" class="rounded-q4" 		width="10%"><%=bundle.getString("label.exam.totalmark")%></th>
		        </tr>
		    </thead>
		    <%
		    	String noqn			= "0";
		    	String marksperqn	= "0";
		    	if(questionList != null && questionList.size()>0){
		    		for(int y=0;y<questionList.size();y++){

		    			hashmap		= (HashMap)questionList.get(y);
		    			status		= (String)hashmap.get("questionsheetstatus");
		    			gstatus		= (String)hashmap.get("status");
		    			noqn		= (String)hashmap.get("noqn");
		    			marksperqn	= (String)hashmap.get("marksperqn");
		    			out.print("<tr><td>"+(y+1)+".</td><td>"+hashmap.get("lessonname")+"</td><td>"+hashmap.get("type")+"</td><td>"+hashmap.get("df")+"</td><td>"+noqn+"</td><td>"+marksperqn+"</td><td>"+(Integer.parseInt(noqn)*Integer.parseInt(marksperqn))+"</td></tr>");
		    		}
		    	}
		    	else
    				out.print("<tr><td colspan='7' align='center' class='nodata'>"+bundle.getString("label.exam.datanotfound")+"</td></tr>");
		    %>
		</table>
		
		<a href="#" class="bt_blue" onclick='callBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.exam.back")%></strong><span class="bt_blue_r"></span></a>
		
		<%if(status != null && status.equals("D")) {%>
			<a href="#" class="bt_red" onclick='submitQuestion("X")'><span class="bt_red_lft"></span><strong><%=bundle.getString("label.exam.rejecttemplate")%></strong><span class="bt_red_r"></span></a>
			<a href="#" class="bt_green" onclick='submitQuestion("A")'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.exam.approvetemplate")%></strong><span class="bt_green_r"></span></a>
		<%}else if(status != null && status.equals("X")) { %>
			<a href="#" class="bt_green" onclick='submitQuestion("A")'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.exam.approvetemplate")%></strong><span class="bt_green_r"></span></a>
		<%} else if(status != null && status.equals("A")) { %>
			<%if(gstatus != null && gstatus.equals("Generated")){ %>
				<h3>You can not reject a template after question generation.</h3>
			<%}else{ %>
			<a href="#" class="bt_red" onclick='submitQuestion("X")'><span class="bt_red_lft"></span><strong><%=bundle.getString("label.exam.rejecttemplate")%></strong><span class="bt_red_r"></span></a>
		<%}} %>
		
		  			
		  			
		<input type='hidden' name='examname' 			value='<%=examname%>'>
		<input type='hidden' name='yearname' 			value='<%=yearname%>'>
		<input type='hidden' name='standardname' 		value='<%=standardname%>'>
		<input type='hidden' name='templatename' 		value='<%=templatename%>'>
		<input type='hidden' name='templatetype' 		value='<%=templatetype%>'>
		<input type='hidden' name='template' 			value='<%=templateid%>'>
		<input type='hidden' name='boardname' 			value='<%=boardname%>'>
		<input type='hidden' name='actionstatus' 		value=''>
		
</form>		
    
    


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>