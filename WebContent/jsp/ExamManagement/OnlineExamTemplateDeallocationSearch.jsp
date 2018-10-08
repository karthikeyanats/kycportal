<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>i-Grandee Education - Template Approve | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/clearselects.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/xmlhttpobject.js"></script>


<script type="text/javascript">
	
	function OnlineExam(){
		
		if(check_ForParticularElements(document.question_form.academicyear,"select",document.question_form.standard,"select",document.question_form.subject,"select")){
			
			document.question_form.yearname.value		= document.question_form.academicyear.options[document.question_form.academicyear.options.selectedIndex].text;
			document.question_form.boardname.value		= document.question_form.board.options[document.question_form.board.options.selectedIndex].text;
			document.question_form.standardname.value	= document.question_form.standard.options[document.question_form.standard.options.selectedIndex].text;
			document.question_form.subjectname.value	= document.question_form.subject.options[document.question_form.subject.options.selectedIndex].text;
			document.question_form.action				= "./OnlineExamTemplateDeallocationView.jsp";
			document.question_form.submit();
		}
	}
	
	function startTransaction(str)
	{
		
		var url = "";
		if(str == "board")
		{
			var sessionid 	= document.getElementById("academicyear").value;
			
			clearObjects("board","standard","subject");
		
			if(check_ForParticularElements(document.question_form.academicyear,"select"))
				url="QuestionPrepareAjax.jsp?action=boardapprove&sessionid="+sessionid;
			else
				return false;
		}
		else if(str == "standard")
		{
			var sessionid 	= document.getElementById("academicyear").value;
			var boardid 	= document.getElementById("board").value;
			
			clearObjects("standard","subject");

			if(check_ForParticularElements(document.question_form.academicyear,"select",document.question_form.board,"select"))
				url="QuestionPrepareAjax.jsp?action=standardapprove&sessionid="+sessionid+"&boardid="+boardid;
			else
				return false;
		}
		else if(str == "subject")
		{
			var sessionid 	= document.getElementById("academicyear").value;
			var standardid 	= document.getElementById("standard").value;
			
			clearObjects("subject");

			if(check_ForParticularElements(document.question_form.academicyear,"select",document.question_form.board,"select",document.question_form.standard,"select"))
				url="QuestionPrepareAjax.jsp?action=subjectapprove&sessionid="+sessionid+"&standardid="+standardid;
			else
				return false;
		}
			
		var req = initRequest();
		req.onreadystatechange = function()
		{
			if(req.readyState == 4)
			{
				if(req.status == 200)
				{
					parseMessages(req.responseXML,str);
				}
			}
		};
		req.open("get", url, true);
		req.send(null);
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

    <h2><%=bundle.getString("label.exam.Deallocationroot")%></h2>
    <%
    	QuestionPreparation prepare = new QuestionPreparation();
		String instituteid			= (String)session.getValue("instituteid");
    	HashMap	hashmap				= null;
    	ArrayList sessionList		= prepare.loadSessionForApproval(instituteid);
    %>
    
    <form name="question_form" action="" method="post">
    
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.exam.templatepprovaldetails")%></th>
		            <th scope="col" class="rounded-q4" 		width="1%"></th>
		        </tr>
		    </thead>
		    <tr>
		    	<td colspan='2'>						
					<table width='100%' align='center' border='0' cellpadding='5'>
						
						<tr height=20>
							<td class=tablebold width="20%" align="left"><%=bundle.getString("label.exam.academicyear")%></td>
							<td class="tablebold" width='1%' valign='top'>:</td>
							<td width="79%" align="left">
								<select name="academicyear" id="academicyear" validate="Academic Year" onChange='startTransaction("board")' class=tablelight style=width:200>
									<option value="0">- Select Academic Year -</option>
									<%
										if(sessionList!=null && sessionList.size()>0)
										for(int j=0;j<sessionList.size();j++){
											
											hashmap 				= (HashMap)sessionList.get(j);
											out.print("<option value="+hashmap.get("sessionid")+">"+hashmap.get("sessionname")+"</option>");
										}
									%>
								</select>
							</td>
						</tr>
						<tr height=20>
							<td class=tablebold align="left"><%=bundle.getString("label.exam.boardname")%></td>
							<td class="tablebold" valign='top'>:</td>
							<td align="left">
								<select name="board" id="board" validate='Board Name' onChange='startTransaction("standard")' class=tablelight>
									<option value="0">- Select Board Name -</option>
								</select>
							</td>
						</tr>
						<tr height=20>
							<td class=tablebold align="left"><%=bundle.getString("label.exam.standardname")%></td>
							<td class="tablebold" valign='top'>:</td>
							<td align="left">
								<select name="standard" id='standard' validate="Standard Name" class=tablelight onChange='startTransaction("subject")'>
									<option selected>- Select Standard Name -</option>
								</select>
							</td>
						</tr>
						<tr height=20>
							<td class=tablebold align="left"><%=bundle.getString("label.exam.subjectname")%></td>
							<td class="tablebold" valign='top'>:</td>
							<td align="left">
								<select name="subject" id='subject' validate="Subject Name" class=tablelight >
									<option selected>- Select Subject Name -</option>
								</select>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
		<a href="./AssignOnlineExam.jsp" class="bt_blue" ><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.exam.back")%></strong><span class="bt_blue_r"></span></a>
		
		<a href="#" id="savebut"  class="bt_green" onclick='OnlineExam()'><span class="bt_green_lft"></span><strong>View Template</strong><span class="bt_green_r"></span></a>
		
		<input type='hidden' name='examname' 		value=''>
		<input type='hidden' name='yearname' 		value=''>
		<input type='hidden' name='standardname' 	value=''>
		<input type='hidden' name='templatename' 	value=''>
		<input type='hidden' name='subjectname' 	value=''>
		<input type='hidden' name='boardname' 		value=''>
	</form>		
    
    


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>