<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
	ResourceBundle bundle=ResourceBundle.getBundle("resources.ApplicationResources");
%>

<title><%=bundle.getString("label.product.name") %> - Exam Type Entry | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/xmlhttpobject.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/clearselects.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">
	
	function submitFun(){
	
		if(check_ForParticularElements(document.question_form.examtype,"text")){
			document.question_form.status.value = "Add";
			document.question_form.action 		= "ExamTypeSubmit.jsp";
			document.question_form.submit();
		
		}
	}
	
	function updateFun(){
	
		if(check_ForParticularElements(document.question_form.existing,"select",document.question_form.examtype,"text")){
			document.question_form.status.value = "Update";
			document.question_form.action 		= "ExamTypeSubmit.jsp";
			document.question_form.submit();
		}
	}	
	
	function deleteFun(){
	
		if(check_ForParticularElements(document.question_form.existing,"select")){
			document.question_form.status.value = "Delete";
			document.question_form.action 		= "ExamTypeSubmit.jsp";
			document.question_form.submit();
		}
	}	
	
	function changeFun(){
	
		if(check_ForParticularElements(document.question_form.existing,"select")){
			
			document.question_form.examtype.value = document.question_form.existing.options[document.question_form.existing.options.selectedIndex].text;
		}
		else
			document.question_form.examtype.value = "";
		
	}		
	
	function goBack(){
		document.question_form.action = "ExamHome.jsp";
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



    <div class="left_content">

    </div>

    <div class="right_content">
	<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,java.util.ResourceBundle,com.iGrandee.ExamManagement.QuestionEntry"%>

    <h2>Exam Management System / Exam Type Entry</h2>
    <%
		String instituteid			= (String)session.getValue("instituteid");
		String userid				= (String)session.getValue("userid");
    	QuestionEntry question		= new QuestionEntry(); 
    	ArrayList examtypelist		= question.loadExamType(userid);
    	HashMap	hashmap				= null;

    %>
    
    <form name="question_form" action="" method="post">
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="99%">Exam Type Details</th>
		            <th scope="col" class="rounded-q4" 		width="1%"></th>
		        </tr>
		    </thead>
		    <tr>
		    	<td colspan='2'>						
						
					<table width='100%' align='center' border='0' cellpadding='5'>
						<tr>
							<td width='20%' class='tablebold'>Existing Exam Type(s)</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<select name='existing' validate='Existing Exam Type' onchange='changeFun()'>
									<option>-Select Exam Type-</option>
									<%
										if(examtypelist != null && examtypelist.size()>0)
										for(int y=0;y<examtypelist.size();y++){
											hashmap		= (HashMap)examtypelist.get(y);
											out.print("<option value='"+hashmap.get("examtypeid")+"'>"+hashmap.get("examtypename")+"</option>");
										}
									%>
								</select>
							</td>
						</tr>			
					
						<tr>
							<td width='20%' class='tablebold'>Exam Type Name</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<input type='text' name='examtype' validate='Exam Type' value='' maxlength='40'>
							</td>
						</tr>			
					</table>
				</td>
			</tr>
		</table>

		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
     	<a href="#" class="bt_red" 	 onclick='deleteFun()'><span class="bt_red_lft"></span><strong>Delete</strong><span class="bt_red_r"></span></a>
		<a href="#" class="bt_green" onclick='updateFun()'><span class="bt_green_lft"></span><strong>Update</strong><span class="bt_green_r"></span></a>
		<a href="#" class="bt_green" onclick='submitFun()'><span class="bt_green_lft"></span><strong>Add</strong><span class="bt_green_r"></span></a>
		
		<input type='hidden' name='examtypeid' 	value=''>
		<input type='hidden' name='status'		value=''>

</form>		
    
    


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>