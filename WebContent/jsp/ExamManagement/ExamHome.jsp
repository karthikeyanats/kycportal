<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>i-Grandee Education - Question Entry | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/xmlhttpobject.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/clearselects.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">
	
	function doCompletion(flag)
	{
	   var url = "";
	
	   if(flag=="standard")
	   {
		   clearObjects("standard","subject","lesson");
		   url = "QuestionEntryAjax.jsp?action=standard&boardid="+document.getElementById("board").value;
	   }
	   else if(flag=="subject")
	   {
		   clearObjects("subject","lesson");
			url = "QuestionEntryAjax.jsp?action=subject&standardid="+document.getElementById("standard").value;
	   }
	   else if(flag=="lesson")
	   {
		   clearObjects("lesson");
		   url = "QuestionEntryAjax.jsp?action=lesson&subjectid="+document.getElementById("subject").value;
	   }
	   else
	   {
		   alert("The Key does not match with any value,URL is Empty, Please contact Administrator/Programmer");
	   }
	   var req =initRequest();
	   req.onreadystatechange = function()
	   {
		   if (req.readyState == 4)
		   {
			   if (req.status == 200)
			   {
					parseMessages(req.responseXML,flag);
			   }
		   }
	   };
	   req.open("GET", url, true);
	   req.send(null);
	}
	
	
	function submitFun(){
	
		if(check_ForParticularElements(document.question_form.board,"select",document.question_form.standard,"select",document.question_form.subject,"select",document.question_form.lesson,"select",document.question_form.examtype,"select",document.question_form.questiontype,"select",document.question_form.difficultyfactor,"select",document.question_form.occurence,"select",document.question_form.startdate,"text",document.question_form.enddate,"text")){
		
			document.question_form.boardname.value		= document.question_form.board.options[document.question_form.board.options.selectedIndex].text;
			document.question_form.standardname.value	= document.question_form.standard.options[document.question_form.standard.options.selectedIndex].text;
			document.question_form.subjectname.value	= document.question_form.subject.options[document.question_form.subject.options.selectedIndex].text;
			document.question_form.lessonname.value		= document.question_form.lesson.options[document.question_form.lesson.options.selectedIndex].text;
			document.question_form.examtypename.value	= document.question_form.examtype.options[document.question_form.examtype.options.selectedIndex].text;
			document.question_form.action 				= "QuestionEntry.jsp";
			document.question_form.submit();
		}
	}
	
	function viewFun(){
	
		if(check_ForParticularElements(document.question_form.board,"select",document.question_form.standard,"select",document.question_form.subject,"select",document.question_form.lesson,"select",document.question_form.examtype,"select",document.question_form.questiontype,"select",document.question_form.difficultyfactor,"select")){
		
			document.question_form.boardname.value		= document.question_form.board.options[document.question_form.board.options.selectedIndex].text;
			document.question_form.standardname.value	= document.question_form.standard.options[document.question_form.standard.options.selectedIndex].text;
			document.question_form.subjectname.value	= document.question_form.subject.options[document.question_form.subject.options.selectedIndex].text;
			document.question_form.lessonname.value		= document.question_form.lesson.options[document.question_form.lesson.options.selectedIndex].text;
			document.question_form.examtypename.value	= document.question_form.examtype.options[document.question_form.examtype.options.selectedIndex].text;
			document.question_form.action 				= "QuestionView.jsp";
			document.question_form.submit();
		}
	}	
	
	function xlsFun(){
	
		document.question_form.action 				= "QuestionEntryExcel.jsp";
		document.question_form.submit();
	}	
	
	
	function changeOccurence(){
		if(check_ForParticularElements(document.question_form.occurence,"select")){
			if(document.question_form.occurence.options.selectedIndex == 1)
				document.getElementById("displayoccurence").innerHTML="<font color='green'>Multi Time Occurences</font>";
			else
				document.getElementById("displayoccurence").innerHTML="<font color='green'>"+document.question_form.occurence.options[document.question_form.occurence.options.selectedIndex].text+" Time Occurrence(s)</font>";
				
		}
		else{
			document.getElementById("displayoccurence").innerHTML="";
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

<%@ include file="../include/examheader.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">
	<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.ExamManagement.QuestionEntry,com.iGrandee.Common.DateTime"%>

    <h2>Exam Management System / Question Entry</h2>
    <%
		String instituteid			= (String)session.getValue("instituteid");
		String userid				= (String)session.getValue("userid");
    	QuestionEntry question		= new QuestionEntry(); 
    	ArrayList boardlist			= question.loadBoard(instituteid);
    	ArrayList examtypelist		= question.loadExamType(userid);
    	HashMap	hashmap				= null;
    	String today				= DateTime.showTime("calendar");
    %>
    
    <form name="question_form" action="" method="post">
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="99%">Question Entry Details</th>
		            <th scope="col" class="rounded-q4" 		width="1%"></th>
		        </tr>
		    </thead>
		    <tr>
		    	<td colspan='2'>						
					<table width='100%' align='center' border='0' cellpadding='5'>
						<tr>
							<td width='20%' class='tablebold'>Board - Medium Name</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<select name='board' id='board' validate='Board Name' onchange='doCompletion("standard")'>
									<option>-Select Board Name-</option>
									<%
										if(boardlist != null && boardlist.size()>0)
										for(int y=0;y<boardlist.size();y++){
											hashmap		= (HashMap)boardlist.get(y);
											out.print("<option value='"+hashmap.get("boardid")+"'>"+hashmap.get("boardname")+"</option>");
										}
									%>
								</select>
							</td>
						</tr>			
						<tr>
							<td width='20%' class='tablebold'>Standard Name</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<select name='standard' id='standard' validate='Standard Name'  onchange='doCompletion("subject")'>
									<option>-Select Standard Name-</option>
								</select>
							</td>
						</tr>
						<tr>
							<td width='20%' class='tablebold'>Subject Name - Subject Code</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<select name='subject' id='subject' validate='Subject Name'   onchange='doCompletion("lesson")'>
									<option>-Select Subject Name-</option>
								</select>
							</td>
						</tr>
						<tr>
							<td width='20%' class='tablebold'>Lesson Name</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<select name='lesson' id='lesson' validate='Lesson Name'>
									<option>-Select Lesson Name-</option>
								</select>
							</td>
						</tr>		
						<tr>
							<td width='20%' class='tablebold'><a href='./ExamType.jsp'>Exam Type</a></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<select name='examtype' validate='Exam Type'>
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
							<td width='20%' class='tablebold'>Question Type</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<select name='questiontype' validate='Question Type'>
									<option>-Select Question Type-</option>
									<option>Objectives</option>
									<option>FillUps</option>
									<option>Definition</option>
									<option>ProblemSolving</option>
									<option>Matching</option>
								</select>
							</td>
						</tr>
						<tr>
							<td width='20%' class='tablebold'>Difficulty Factor</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<select name='difficultyfactor' validate='Difficulty Factor'>
									<option>-Select Difficulty Factor-</option>
									<option>Low</option>
									<option>Medium</option>
									<option>High</option>
									<option>Severe</option>
								</select>
							</td>
						</tr>
						<tr>
							<td width='20%' class='tablebold'>Life Time</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
							From &nbsp;&nbsp;<input type='text' name='startdate' value='<%=today%>' size='11' onfocus='this.blur()'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To &nbsp;&nbsp;&nbsp;<input  size='11' type='text' name='enddate' value='' onfocus='this.blur()'><input type='button' value='^' onclick="document.question_form.enddate.value='';this.blur();Calendar_Fun('../../js/Calendar/CalendarWindow.html','question_form.enddate','0',event,'Not_Less_Than_CurrentDate',document.question_form.startdate);">
							</td>
						</tr>
						<tr>
							<td width='20%' class='tablebold'>No. of Occurrence</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<select name='occurence' validate='Total Occurrence' onchange='changeOccurence()'>
									<option>-Select Total Occurrence-</option>
									<%
										for(int a=0;a<251;a++)
											out.print("<option>"+a+"</option>");
									%>
								</select>
								<br><label id='displayoccurence' class='tablebold'></label>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		
		<a href="#" class="bt_blue" onclick='viewFun()'><span class="bt_blue_lft"></span><strong>View Question</strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_blue" onclick='submitFun()'><span class="bt_blue_lft"></span><strong>Enter Question</strong><span class="bt_blue_r"></span></a>

		<input type='hidden' name='standardname' 	value=''>
		<input type='hidden' name='boardname'		value=''>
		<input type='hidden' name='examtypename' 	value=''>
		<input type='hidden' name='lessonname' 		value=''>
		<input type='hidden' name='subjectname' 	value=''>
		
</form>		
    
    


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>