<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.ResourceBundle"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>i-Grandee Education - Template Preparation | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/clearselects.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/xmlhttpobject.js"></script>

<script type="text/javascript">
	
	
	function submitQuestion(){
	
		if(check_ForParticularElements(document.question_form.academicyear,"select",document.question_form.board,"select",document.question_form.standard,"select",document.question_form.templatetype,"select")){
			
			//document.question_form.examname.value		= document.question_form.exam.options[document.question_form.exam.options.selectedIndex].text;
			document.question_form.yearname.value		= document.question_form.academicyear.options[document.question_form.academicyear.options.selectedIndex].text;
			document.question_form.boardname.value		= document.question_form.board.options[document.question_form.board.options.selectedIndex].text;
			document.question_form.standardname.value	= document.question_form.standard.options[document.question_form.standard.options.selectedIndex].text;
			document.question_form.action				= "Preparation.jsp";
			document.question_form.submit();
		}
	}	
	
	function startTransaction(str)
	{

		var url = "";
		
		if(str == "standard")
		{
			var sessionid 	= document.getElementById("academicyear").value;
			var boardid 	= document.getElementById("board").value;
			
			clearObjects("standard");
			
			if(check_ForParticularElements(document.question_form.academicyear,"select",document.question_form.board,"select"))
				url="QuestionPrepareAjax.jsp?action=standardprepare&boardid="+boardid+"&sessionid="+sessionid;
			else
				return false;
		}
		else if(str == "board")
		{

			var sessionid 	= document.getElementById("academicyear").value;

			clearObjects("board","standard");
					
			if(check_ForParticularElements(document.question_form.academicyear,"select"))
				url="QuestionPrepareAjax.jsp?action=boardprepare&sessionid="+sessionid;
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
		req.open("GET", url, true);
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
	<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.ExamManagement.QuestionPreparation"%>

    <h2><%=bundle.getString("label.exam.templateprepareroot")%></h2>
    <%

    	QuestionPreparation prepare = new QuestionPreparation();
		String instituteid			= (String)session.getValue("instituteid");
    	HashMap	hashmap				= null;
    	ArrayList sessionList		= prepare.loadSession(instituteid);
    	
    %>
    
    <form name="question_form" action="" method="post">
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.exam.templatepreparedetails")%></th>
		            <th scope="col" class="rounded-q4" 		width="1%"></th>
		        </tr>
		    </thead>
		    <tr>
		    	<td colspan='2'>						
					<table width='100%' align='center' border='0' cellpadding='5'>
						<tr height=20>
							<td class=tablebold width="20%" align="left"><%=bundle.getString("label.exam.academicyear")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="79%" align="left">
								<select name="academicyear" id="academicyear" validate="Academic Year" class=tablelight  onChange='startTransaction("board")'>
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
							<td class=tablebold align="left"><%=bundle.getString("label.common.boardmediumname")%></td>
							<td class=tablebold align="left">:</td>
							<td align="left"><select name="board" id="board" validate='Board Name' class=tablelight  onChange='startTransaction("standard")'>
								<option value="0">- Select Board Name -</option>
							</select></td>
						</tr>
		
						<tr height=20>
							<td class=tablebold align="left"><%=bundle.getString("label.exam.standardname")%></td>
							<td class=tablebold align="left">:</td>
							<td align="left"><select name="standard" id='standard' validate="Standard Name" class=tablelight>
								<option selected>- Select Standard Name -</option>
								</select>
							</td>
						</tr>
						<tr height=20>
							<td class=tablebold align="left"><%=bundle.getString("label.exam.templatetype")%></td>
							<td class=tablebold align="left">:</td>
							<td align="left">
								<select name=templatetype validate="Template Type" class=tablelight>
									<option>- Select Template Type -</option>
									<option>Self Assessment</option>
									<option>Online Exam</option>
									<option>Offline Exam</option>
								</select>
							</td>
						</tr>

					</table>
				</td>
			</tr>
		</table>
		<br>

		<a href="#" id="savebut"  class="bt_green" onclick='submitQuestion()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.exam.gotoform")%></strong><span class="bt_green_r"></span></a>
		  			
		<input type='hidden' name='examname' 			value=''>
		<input type='hidden' name='yearname' 			value=''>
		<input type='hidden' name='standardname' 		value=''>
		<input type='hidden' name='boardname' 			value=''>
		
</form>		
    
    


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>