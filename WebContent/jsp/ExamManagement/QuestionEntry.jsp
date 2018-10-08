<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>i-Grandee Education - Question Entry | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
	
	var rowcounter		= 0;
	var curobject;
	
	function setCurObj(obj){
		curobject	= obj;
	}
	
	function symbolFun(obj){
		
		if(curobject != null)
			curobject.value	+= obj.getAttribute("value");
	}

	function addNextQuestion(){
		
		if(rowcounter	< 9){
			rowcounter++;
			document.getElementById("row"+rowcounter).style.display = '';
			enableValues(rowcounter)
			
		}
		else{
			alert("You can't add more than 10 questions at a time!");
		}
	
	}

	function removePreviousQuestion(){
	
		if(rowcounter	!= 0){
			document.getElementById("row"+rowcounter).style.display = 'none';
			disableValues(rowcounter)
			rowcounter--;
		}
		else{
			alert("You can't remove the first question.!");
		}
	
	}
	
	function enableValues(counter){
	
		if(document.question_form.questiontype.value == "Objectives"){
		
			document.question_form.question[counter].disabled	= false;
			document.question_form.answer[counter*7].disabled	= false;
			document.question_form.answer[counter*7+1].disabled	= false;
			
		}else if(document.question_form.questiontype.value == "Matching"){
		
			document.question_form.question[counter*7].disabled			= false;
			document.question_form.question[counter*7+1].disabled		= false;			
			document.question_form.answercombo[counter*7].disabled		= false;
			document.question_form.answercombo[counter*7+1].disabled	= false;
			document.question_form.answer[counter*7].disabled			= false;
			document.question_form.answer[counter*7+1].disabled			= false;
			
		
		}else{

			document.question_form.question[counter].disabled	= false;
			document.question_form.answer[counter].disabled		= false;
		
		}
		
		document.question_form.mark[counter].disabled			= false;
		document.question_form.time[counter].disabled			= false;
		document.question_form.files[counter].disabled			= false;
		document.question_form.totalanswer[counter].disabled	= false;
		document.question_form.checkedanswer[counter].disabled	= false;
		
		
		
	}
	
	function disableValues(counter){

		if(document.question_form.questiontype.value == "Objectives"){
		
			document.question_form.question[counter].disabled	= true;
			document.question_form.answer[counter*7].disabled	= true;
			document.question_form.answer[counter*7+1].disabled	= true;
		
		}else if(document.question_form.questiontype.value == "Matching"){
		
			document.question_form.question[counter*7].disabled			= true;
			document.question_form.question[counter*7+1].disabled		= true;			
			document.question_form.answercombo[counter*7].disabled		= true;
			document.question_form.answercombo[counter*7+1].disabled	= true;
			document.question_form.answer[counter*7].disabled			= true;
			document.question_form.answer[counter*7+1].disabled			= true;
		
		}else{
		
			document.question_form.question[counter].disabled	= true;
			document.question_form.answer[counter].disabled		= true;
		
		}
	
		document.question_form.mark[counter].disabled			= true;
		document.question_form.time[counter].disabled			= true;
		document.question_form.files[counter].disabled			= true;
		document.question_form.totalanswer[counter].disabled	= true;
		document.question_form.checkedanswer[counter].disabled	= true;
		
	}
	
	function addAnswer(obj){
		
		var ival	= obj.getAttribute("i");
		
		var count	= 0;
		var count1	= 0;
		var flag	= false;
		
		for(var i=0;i<5;i++){
		
			count	= i+2;
			count1	= ival*7+count;
			flag	= false;
			
			if(document.getElementById("answertable"+ival+"row"+count).style.display == 'none'){
			
				document.question_form.answer[count1].disabled		= false;
				document.getElementById("answertable"+ival+"row"+count).style.display = '';
				flag	= true;
				break;
			}
		}
		
		if(!flag){
			alert("You can add only 7 options.")
		}
		
	}
	
	function addAnswerMatching(obj){
		
		var ival	= obj.getAttribute("i");
		
		var count	= 0;
		var count1	= 0;
		var flag	= false;
		
		for(var i=0;i<5;i++){
		
			count	= i+2;
			count1	= ival*7+count;
			flag	= false;
			
			if(document.getElementById("questiontable"+ival+"row"+count).style.display == 'none'){
			
				document.question_form.question[count1].disabled	= false;
				document.question_form.answercombo[count1].disabled	= false;
				document.question_form.answer[count1].disabled		= false;
				document.getElementById("questiontable"+ival+"row"+count).style.display 	= '';
				document.getElementById("answertable"+ival+"row"+count).style.display 		= '';
				flag	= true;
				break;
			}
		}
		
		if(!flag){
			alert("You can add only 7 options.")
		}
		
	}	
	
	function removeAnswer(obj){
	
		var ival	= obj.getAttribute("i");
		
		var count	= 0;
		var count1	= 0;
		var flag	= false;
		var nflag	= false;
		
		for(var i=5;i>0;i--){
		
			count	= i+1;
			count1	= ival*7+count;
			flag	= false;

			if(document.getElementById("answertable"+ival+"row"+count).style.display == '' || document.getElementById("answertable"+ival+"row"+count).style.display == 'block'){
				document.question_form.answer[count1].disabled		= true;
				document.question_form.answer[count1].value			= "";
				document.getElementById("answertable"+ival+"row"+count).style.display = 'none';
				flag	= true;
				break;
			
			}
		}
		
		if(!flag){
			alert("You should have minimum 2 options.");
		}		
	}
	
	function removeAnswerMatching(obj){
	
		var ival	= obj.getAttribute("i");
		
		var count	= 0;
		var count1	= 0;
		var flag	= false;
		
		for(var i=5;i>0;i--){
		
			count	= i+1;
			count1	= ival*7+count;
			flag	= false;

			
			if(document.getElementById("questiontable"+ival+"row"+count).style.display == '' || document.getElementById("questiontable"+ival+"row"+count).style.display == 'block'){
			
				document.question_form.question[count1].disabled	= true;
				document.question_form.question[count1].value		= "";
				document.question_form.answercombo[count1].disabled	= true;
				document.question_form.answer[count1].disabled		= true;
				document.question_form.answer[count1].value			= "";
				document.getElementById("questiontable"+ival+"row"+count).style.display = 'none';
				document.getElementById("answertable"+ival+"row"+count).style.display = 'none';
				flag	= true;
				break;
			}
		}
		
		if(!flag){
			alert("You should have minimum 2 options.");
		}		
	}	
	
	function submitQuestion(){
	
		var submitflag	= false;

		if(document.question_form.questiontype.value == "Objectives"){

			for(var i=0;i<10;i++){
				
				if(document.getElementById("row"+i).style.display == '' || document.getElementById("row"+i).style.display == 'block'){
				
					if(!check_ForParticularElements(document.question_form.question[i],"textarea")){
						submitflag = true;
						break;
					}
					else{
					
						for(var j=0;j<7;j++){
							
							var pos	= i*7+j;
							
							if(!document.question_form.answer[pos].disabled){
								if(!check_ForParticularElements(document.question_form.answer[pos],"text")){
									submitflag = true;
									break;
								}
							}
							else
								break;
						}		
						
						var temp	= 0;
						var temp_c	= "";
						
						if(!submitflag)
						for(var j=0;j<7;j++){
							
							var pos	= i*7+j;
							if(!document.question_form.answer[pos].disabled){
								temp++;
								if(document.question_form.correctanswer[pos].checked){
									temp_c	+= document.question_form.correctanswer[pos].value+",";
								}
							}
							else
								break
						}	
						
						if(temp == 0 && !submitflag){
						
							alert("Please select a Answer");
							submitflag = true;
							return false;
						}
					
						if(temp_c.length>1)
							temp_c = temp_c.substring(0,temp_c.length-1);
						
						document.question_form.totalanswer[i].value		= temp;
						document.question_form.checkedanswer[i].value	= temp_c;	
						
						
						var index_attach = document.question_form.files[i].value;
						
						if(index_attach != "")
						{
							var ext	   = index_attach.substring(index_attach.lastIndexOf(".")+1);
							ext		   = ext.toLowerCase();
							if(!(ext == "gif" || ext == "jpg" || ext == "jpeg" || ext == "bmp" || ext == "png"))
							{
								alert("Only the following file formats are allowed in reference file. \n *.gif,*.jpg,*.jpeg,*.bmp,*.png");
								submitflag = true;
								return false;
							}
						}
						
						
						
						
					}						
				
					if(submitflag)
						break;
				
				}
			}
		}else if(document.question_form.questiontype.value == "Matching"){
		
			for(var i=0;i<10;i++){
			
				if(document.getElementById("row"+i).style.display == '' || document.getElementById("row"+i).style.display == 'block'){
					
					document.question_form.checkedanswer[i].value	= "";
					for(var j=0;j<7;j++){
						
						var pos	= i*7+j;
						if(!document.question_form.question[pos].disabled){
							document.question_form.totalanswer[i].value		= j+1;
							document.question_form.checkedanswer[i].value	+= document.question_form.answercombo[pos].options[document.question_form.answercombo[pos].options.selectedIndex].text+",";
							if(!check_ForParticularElements(document.question_form.question[pos],"text",document.question_form.answer[pos],"text")){
								submitflag = true;
								break;
							}
						}
						else
							break;
					}
					
					document.question_form.checkedanswer[i].value	= document.question_form.checkedanswer[i].value.substring(0,document.question_form.checkedanswer[i].value.length-1);
					
					
					var index_attach = document.question_form.files[i].value;
					
					if(index_attach != "")
					{
						var ext	   = index_attach.substring(index_attach.lastIndexOf(".")+1);
						ext		   = ext.toLowerCase();
						if(!(ext == "gif" || ext == "jpg" || ext == "jpeg" || ext == "bmp" || ext == "png"))
						{
							alert("Only the following file formats are allowed in reference file. \n *.gif,*.jpg,*.jpeg,*.bmp,*.png");
							submitflag = true;
							return false;
						}
					}
					
					
					
					if(submitflag)
						break;
				
				}		
			}		
		}else{
			for(var i=0;i<10;i++){
			
				if(document.getElementById("row"+i).style.display == '' || document.getElementById("row"+i).style.display == 'block'){
					if(!check_ForParticularElements(document.question_form.question[i],"textarea",document.question_form.answer[i],"textarea",document.question_form.time[i],"text",document.question_form.mark[i],"text")){
						submitflag = true;
						break;
					}
					
					
					var index_attach = document.question_form.files[i].value;
					
					if(index_attach != "")
					{
						var ext	   = index_attach.substring(index_attach.lastIndexOf(".")+1);
						ext		   = ext.toLowerCase();
						if(!(ext == "gif" || ext == "jpg" || ext == "jpeg" || ext == "bmp" || ext == "png"))
						{
							alert("Only the following file formats are allowed in reference file. \n *.gif,*.jpg,*.jpeg,*.bmp,*.png");
							submitflag = true;
							return false;
						}
					}
					
					
				}	
				else
					break;
			}
		}
		
		if(!submitflag){	
			
			document.question_form.action		= "QuestionSubmit.jsp";
			document.question_form.submit();
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
	<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime"%>

    <h2>Exam Management System / Question Entry</h2>
    <%
    	DateTime datetime			= new DateTime();
    	HashMap	hashmap				= null;
    	String today				= datetime.showTime("calendar");
    	String questiontype			= request.getParameter("questiontype");
    
    %>
    
    <form name="question_form" action="" method="post"  enctype="multipart/form-data">
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
							<td width='15%' class='tablebold'>Board - Medium Name</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
								<%=request.getParameter("boardname")%>
							</td>
						</tr>			
						<tr>
							<td width='15%' class='tablebold'>Standard Name</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
							<%=request.getParameter("standardname")%>
							</td>
						</tr>
						<tr>
							<td width='15%' class='tablebold'>Subject Name - Subject Code</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=request.getParameter("subjectname")%>
							</td>
						</tr>
						<tr>
							<td width='15%' class='tablebold'>Lesson Name</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=request.getParameter("lessonname")%>
							</td>
						</tr>		
						<tr>
							<td width='15%' class='tablebold'>Exam Type</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=request.getParameter("examtypename")%>
							</td>
						</tr>
						<tr>
							<td width='15%' class='tablebold'>Question Type</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
							<%=request.getParameter("questiontype")%>
							</td>
							<td width='20%' class='tablebold'>Difficulty Factor</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
							<%=request.getParameter("difficultyfactor")%>
							</td>

						</tr>
						<tr>
							<td width='15%' class='tablebold'>Life Time</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
							From &nbsp;&nbsp;<%=request.getParameter("startdate")%><input type='hidden' name='startdate' value='<%=request.getParameter("startdate")%>' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To &nbsp;&nbsp;&nbsp;<%=request.getParameter("enddate")%><input  type='hidden' name='enddate' value='<%=request.getParameter("enddate")%>' >
							</td>
							<td width='20%' class='tablebold'>No. of Occurrence</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' width='20%'>
								<%=request.getParameter("occurence")%>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
		
		<table id="rounded-corner" cellspacing=0  class=tablelight width="100%">
			  <thead>
			  	<tr>
					<th scope="col"  class="rounded-company" width='5%'>Sl.No.</th>
					<th scope="col"  class="rounded" width='25%'>Question</th>
					<th scope="col"  class="rounded" width='35%'>Answer</th>
					<th scope="col"  class="rounded" width='10%'>Time Limit</th>
					<th scope="col"  class="rounded" width='10%'>Mark</th>
					<th scope="col"  class="rounded-q4" width='15%'>Reference</th>
				</tr>
			  </thead>
			<%
				for(int i=0;i<10;i++){
					if(i == 0)
						out.print("<tr><td valign='top' id='row"+i+"'>"+(i+1)+".</td>");
					else
						out.print("<tr style='display:none' id='row"+i+"'><td valign='top'>"+(i+1)+".</td>");

					
					if(questiontype != null && questiontype.equals("Matching")){
						
						if(i == 0)
							out.print("<td><table width='100%' id='questiontable"+i+"'><tr id='questiontable"+i+"row0'><td>&nbsp;</td></tr><tr><td>1.&nbsp;<input type='text' name='question' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Question'></td></tr><tr id='questiontable"+i+"row1'><td>2.&nbsp;<input type='text' name='question' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Question'></td></tr><tr id='questiontable"+i+"row2' style='display:none'><td>3.&nbsp;<input type='text' name='question' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Question' disabled></td></tr><tr id='questiontable"+i+"row3' style='display:none'><td>4.&nbsp;<input type='text' name='question' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Question' disabled></td></tr><tr id='questiontable"+i+"row4' style='display:none'><td>5.&nbsp;<input type='text' name='question' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Question' disabled></td></tr><tr id='questiontable"+i+"row5' style='display:none'><td>6.&nbsp;<input type='text' name='question' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Question' disabled></td></tr><tr id='questiontable"+i+"row6' style='display:none'><td>7.&nbsp;<input type='text' name='question' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Question' disabled></td></tr></table></td>");
						else
							out.print("<td><table width='100%' id='questiontable"+i+"'><tr id='questiontable"+i+"row0'><td>&nbsp;</td></tr><tr><td>1.&nbsp;<input type='text' name='question' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Question' disabled></td></tr><tr id='questiontable"+i+"row1'><td>2.&nbsp;<input type='text' name='question' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Question' disabled></td></tr><tr id='questiontable"+i+"row2' style='display:none'><td>3.&nbsp;<input type='text' name='question' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Question' disabled></td></tr><tr id='questiontable"+i+"row3' style='display:none'><td>4.&nbsp;<input type='text' name='question' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Question' disabled></td></tr><tr id='questiontable"+i+"row4' style='display:none'><td>5.&nbsp;<input type='text' name='question' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Question' disabled></td></tr><tr id='questiontable"+i+"row5' style='display:none'><td>6.&nbsp;<input type='text' name='question' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Question' disabled></td></tr><tr id='questiontable"+i+"row6' style='display:none'><td>7.&nbsp;<input type='text' name='question' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Question' disabled></td></tr></table></td>");
					}
					else{
						
						if(i == 0)
							out.print("<td  valign='top'><textarea name='question' cols='20' rows='5' onfocus='setCurObj(this)' validate='Question' onkeyup=calculateRemaining(this,2000,'remain"+i+"') onkeydown=calculateRemaining(this,2000,'remain"+i+"')></textarea><br><label id='remain"+i+"' class='tablelight'><font color='red'>2000 Charecter(s) Left</font></label></td>");
						else
							out.print("<td  valign='top'><textarea name='question' cols='20' disabled rows='5' onfocus='setCurObj(this)' validate='Question' onkeyup=calculateRemaining(this,2000,'remain"+i+"') onkeydown=calculateRemaining(this,2000,'remain"+i+"')></textarea><br><label id='remain"+i+"' class='tablelight'><font color='red'>2000 Charecter(s) Left</font></label></td>");
					}
					
					if(questiontype != null && questiontype.equals("Objectives")){
						if(i == 0)
							out.print("<td><table width='100%' cellspacing='0' cellpadding='0' id='answertable"+i+"'><tr><td align='center'><a href='#cls' i='"+i+"' onclick='removeAnswer(this)'>&lt;&lt;</a>&nbsp;&nbsp&nbsp;<a href='#cls' i='"+i+"' onclick='addAnswer(this)'>&gt;&gt;</a></td></tr><tr id='answertable"+i+"row0'><td>A.&nbsp;<input type='checkbox' name='correctanswer' value='A'><input type='text' name='answer' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row1'><td>B.&nbsp;<input type='checkbox' name='correctanswer' value='B'><input type='text' name='answer' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row2' style='display:none'><td>C.&nbsp;<input type='checkbox' name='correctanswer' value='C'><input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row3' style='display:none'><td>D.&nbsp;<input type='checkbox' name='correctanswer' value='D'><input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row4' style='display:none'><td>E.&nbsp;<input type='checkbox' name='correctanswer' value='E'><input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row5' style='display:none'><td>F.&nbsp;<input type='checkbox' name='correctanswer' value='F'><input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)'  validate='Answer'></td></tr><tr id='answertable"+i+"row6' style='display:none'><td>G.&nbsp;<input type='checkbox' name='correctanswer' value='G'><input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)'  validate='Answer'></td></tr></table></td>");
						else
							out.print("<td><table width='100%' cellspacing='0' cellpadding='0' id='answertable"+i+"'><tr><td align='center'><a href='#cls' i='"+i+"' onclick='removeAnswer(this)'>&lt;&lt;</a>&nbsp;&nbsp&nbsp;<a href='#cls' i='"+i+"' onclick='addAnswer(this)'>&gt;&gt;</a></td></tr><tr id='answertable"+i+"row0'><td>A.&nbsp;<input type='checkbox' name='correctanswer' value='A'><input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row1'><td>B.&nbsp;<input type='checkbox' name='correctanswer' value='B'><input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row2' style='display:none'><td>C.&nbsp;<input type='checkbox' name='correctanswer' value='C'><input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row3' style='display:none'><td>D.&nbsp;<input type='checkbox' name='correctanswer' value='D'><input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row4' style='display:none'><td>E.&nbsp;<input type='checkbox' name='correctanswer' value='E'><input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row5' style='display:none'><td>F.&nbsp;<input type='checkbox' name='correctanswer' value='F'><input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)'  validate='Answer'></td></tr><tr id='answertable"+i+"row6' style='display:none'><td>G.&nbsp;<input type='checkbox' name='correctanswer' value='G'><input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr></table></td>");
					}
					else if(questiontype != null && questiontype.equals("Matching")){
						if(i == 0)
							out.print("<td><table width='100%' cellspacing='0' cellpadding='0' id='answertable"+i+"'><tr><td align='center'><a href='#cls' i='"+i+"' onclick='removeAnswerMatching(this)'>&lt;&lt;</a>&nbsp;&nbsp&nbsp;<a href='#cls' i='"+i+"' onclick='addAnswerMatching(this)'>&gt;&gt;</a></td></tr><tr id='answertable"+i+"row0'><td>A.&nbsp;<select name='answercombo'><option selected>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row1'><td>B.&nbsp;<select name='answercombo'><option>1</option><option selected>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row2' style='display:none'><td>C.&nbsp;<select name='answercombo'  disabled><option>1</option><option>2</option><option selected>3</option><option>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row3' style='display:none'><td>D.&nbsp;<select name='answercombo' disabled  onfocus='setCurObj(this)'><option >1</option><option>2</option><option>3</option><option selected>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row4' style='display:none'><td>E.&nbsp;<select name='answercombo' disabled><option>1</option><option>2</option><option>3</option><option>4</option><option selected>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)'></td></tr><tr id='answertable"+i+"row5' style='display:none'><td>F.&nbsp;<select name='answercombo' disabled><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option selected>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled  onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row6' style='display:none'><td>G.&nbsp;<select name='answercombo' disabled><option selected>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option selected>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr></table></td>");
						else
							out.print("<td><table width='100%' cellspacing='0' cellpadding='0' id='answertable"+i+"'><tr><td align='center'><a href='#cls' i='"+i+"' onclick='removeAnswerMatching(this)'>&lt;&lt;</a>&nbsp;&nbsp&nbsp;<a href='#cls' i='"+i+"' onclick='addAnswerMatching(this)'>&gt;&gt;</a></td></tr><tr id='answertable"+i+"row0'><td>A.&nbsp;<select name='answercombo' disabled><option selected>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row1'><td>B.&nbsp;<select name='answercombo' disabled><option>1</option><option selected>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row2' style='display:none'><td>C.&nbsp;<select name='answercombo'  disabled><option>1</option><option>2</option><option selected>3</option><option>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row3' style='display:none'><td>D.&nbsp;<select name='answercombo' disabled><option >1</option><option>2</option><option>3</option><option selected>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row4' style='display:none'><td>E.&nbsp;<select name='answercombo' disabled><option>1</option><option>2</option><option>3</option><option>4</option><option selected>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)'></td></tr><tr id='answertable"+i+"row5' style='display:none'><td>F.&nbsp;<select name='answercombo' disabled><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option selected>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled  onfocus='setCurObj(this)' validate='Answer'></td></tr><tr id='answertable"+i+"row6' style='display:none'><td>G.&nbsp;<select name='answercombo' disabled><option selected>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option selected>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr></table></td>");
					}
					else{
						if(i == 0)
							out.print("<td  valign='top'><textarea name='answer' cols='20' rows='5' onfocus='setCurObj(this)'  validate='Answer' onkeyup=calculateRemaining(this,1000,'remain"+(i+10)+"') onkeydown=calculateRemaining(this,1000,'remain"+(i+10)+"')></textarea><br><label id='remain"+(i+10)+"' class='tablelight'><font color='red'>1000 Charecter(s) Left</font></label></td>");
						else
							out.print("<td  valign='top'><textarea name='answer' cols='20' rows='5' disabled onfocus='setCurObj(this)' validate='Answer' onkeyup=calculateRemaining(this,1000,'remain"+(i+10)+"') onkeydown=calculateRemaining(this,1000,'remain"+(i+10)+"')></textarea><br><label id='remain"+(i+10)+"' class='tablelight'><font color='red'>1000 Charecter(s) Left</font></label></td>");
					}
					
					if(i == 0)
						out.print("<td  valign='top'><input type='text' name='time' size='5' maxlength='5' value='01:00' validate='Time' onblur='checkTimeFormat(document.question_form.time["+i+"])'></td><td  valign='top'><input type='text' name='mark' size='5' maxlength='2' value='1' validate='Mark' onkeypress='checkNumber(event)'></td><td  valign='top'><input type='file' name='files' size='5'><input type='hidden' name='totalanswer' value='0'><input type='hidden' name='checkedanswer' value='' ></td></tr>");
					else
						out.print("<td  valign='top'><input type='text' name='time' size='5' maxlength='5' value='01:00' disabled validate='Time' onblur='checkTimeFormat(document.question_form.time["+i+"])'></td><td  valign='top'><input type='text' name='mark' size='5' maxlength='2' value='1' disabled validate='Mark' onkeypress='checkNumber(event)'></td><td  valign='top'><input type='file' name='files' disabled size='5'><input type='hidden' name='totalanswer' value='0' disabled><input type='hidden' name='checkedanswer' value='' disabled></td></tr>");

				}
			%>
		</table>
			

		<a href="#" class="bt_blue" onclick='document.location.replace("ExamHome.jsp")''><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_blue" onclick='addNextQuestion()'><span class="bt_blue_lft"></span><strong>Next Question</strong><span class="bt_blue_r"></span></a>
		<a href="#" id="rembut"   class="bt_red" onclick='removePreviousQuestion()'><span class="bt_red_lft"></span><strong>Remove Question</strong><span class="bt_red_r"></span></a>
		<a href="#" id="savebut"  class="bt_green" onclick='submitQuestion()'><span class="bt_green_lft"></span><strong>Submit Question</strong><span class="bt_green_r"></span></a>
		  			
		  			
		<input type='hidden' name='examtype' 			value='<%=request.getParameter("examtype")%>'>
		<input type='hidden' name='lessonid' 			value='<%=request.getParameter("lesson")%>'>
		<input type='hidden' name='occurence' 			value='<%=request.getParameter("occurence")%>'>
		<input type='hidden' name='difficultyfactor' 	value='<%=request.getParameter("difficultyfactor")%>'>
		<input type='hidden' name='questiontype' 		value='<%=request.getParameter("questiontype")%>'>		
		
		
</form>		
    
    


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>