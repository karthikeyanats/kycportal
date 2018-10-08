<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
	ResourceBundle bundle=ResourceBundle.getBundle("resources.ApplicationResources");
%>

<title><%=bundle.getString("label.product.name") %> - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
	
	var curobject;
	
	function setCurObj(obj){
		curobject	= obj;
	}
	
	
	function goBack(){
			
		document.question_form1.action		= "QuestionView.jsp";
		document.question_form1.submit();
	}
	
	function prevQuestion(){
	
		document.question_form1.startsat.value	= parseInt(document.question_form1.startsat.value,10)-10; 
		document.question_form.startsat.value	= parseInt(document.question_form.startsat.value,10)-10; 
		document.question_form1.submit();
	
	}
	
	function nextQuestion(){

		document.question_form1.startsat.value	= parseInt(document.question_form1.startsat.value,10)+10; 
		document.question_form.startsat.value	= parseInt(document.question_form.startsat.value,10)+10; 
		document.question_form1.submit();
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
	
	
	var selcount	= 0;
	
	function submitQuestion(){
	
		var submitflag	= false;

		if(document.question_form.questiontype.value == "Objectives"){
		
			for(var i=0;i<document.question_form.question.length-1;i++){
			
				if(document.question_form.questionid[i].checked){
				
					selcount++;
				
					//if(document.getElementById("row"+i).style.display == '' || document.getElementById("row"+i).style.display == 'block'){
					
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
					
					//}
				}
			}
		}else if(document.question_form.questiontype.value == "Matching"){
		
			for(var i=0;i<document.question_form.questionid.length-1;i++){
			
				if(document.question_form.questionid[i].checked){
				
				selcount++;
			
					//if(document.getElementById("row"+i).style.display == '' || document.getElementById("row"+i).style.display == 'block'){
						
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
						
						
						
						document.question_form.checkedanswer[i].value	= document.question_form.checkedanswer[i].value.substring(0,document.question_form.checkedanswer[i].value.length-1);
						
						if(submitflag)
							break;
					
					//}		
				}
			}		
		}else{

			for(var i=0;i<document.question_form.question.length-1;i++){
			
				if(document.question_form.questionid[i].checked){
				
				selcount++;
			
					//if(document.getElementById("row"+i).style.display == '' || document.getElementById("row"+i).style.display == 'block'){
						if(!check_ForParticularElements(document.question_form.question[i],"textarea",document.question_form.answer[i],"textarea",document.question_form.time[i],"text",document.question_form.mark[i],"text")){
							submitflag = true;
							break;
						}
					//}	
					//else
					//	break;
					
					
					
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
			}
		}
		
		if(!submitflag){	
		
			if(selcount>0){
			
				for(var i=0;i<document.question_form.questionid.length-1;i++){
				
					if(!document.question_form.questionid[i].checked){

						if(document.question_form.questiontype.value == "Objectives"){
						
							document.question_form.question[i].disabled			= true;
							document.question_form.answer[i*7].disabled			= true;
							document.question_form.answer[i*7+1].disabled		= true;
							document.question_form.answer[i*7+2].disabled		= true;
							document.question_form.answer[i*7+3].disabled		= true;
							document.question_form.answer[i*7+4].disabled		= true;
							document.question_form.answer[i*7+5].disabled		= true;
							document.question_form.answer[i*7+6].disabled		= true;
						
						}else if(document.question_form.questiontype.value == "Matching"){
						
							document.question_form.question[i*7].disabled		= true;
							document.question_form.question[i*7+1].disabled		= true;
							document.question_form.question[i*7+2].disabled		= true;			
							document.question_form.question[i*7+3].disabled		= true;			
							document.question_form.question[i*7+4].disabled		= true;			
							document.question_form.question[i*7+5].disabled		= true;			
							document.question_form.question[i*7+6].disabled		= true;			
							
							document.question_form.answercombo[i*7].disabled	= true;
							document.question_form.answercombo[i*7+1].disabled	= true;
							document.question_form.answercombo[i*7+2].disabled	= true;
							document.question_form.answercombo[i*7+3].disabled	= true;
							document.question_form.answercombo[i*7+4].disabled	= true;
							document.question_form.answercombo[i*7+5].disabled	= true;
							document.question_form.answercombo[i*7+6].disabled	= true;
							
							document.question_form.answer[i*7].disabled			= true;
							document.question_form.answer[i*7+1].disabled		= true;
							document.question_form.answer[i*7+2].disabled		= true;
							document.question_form.answer[i*7+3].disabled		= true;
							document.question_form.answer[i*7+4].disabled		= true;
							document.question_form.answer[i*7+5].disabled		= true;
							document.question_form.answer[i*7+6].disabled		= true;
						
						}else{
						
							document.question_form.question[i].disabled		= true;
							document.question_form.answer[i].disabled		= true;
						
						}
					
						document.question_form.mark[i].disabled				= true;
						document.question_form.time[i].disabled				= true;
						document.question_form.files[i].disabled			= true;
						document.question_form.totalanswer[i].disabled		= true;
						document.question_form.checkedanswer[i].disabled	= true;

					}
				}
			
				document.question_form.action		= "QuestionUpdate.jsp";
				document.question_form.submit();

			}
			else{
				alert("Please select atleast one question to update.");
			}
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
	<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,java.util.ResourceBundle,com.iGrandee.ExamManagement.QuestionEntry"%>

    <h2>Exam Management System / Question Modify</h2>
    <%
		String instituteid			= (String)session.getValue("instituteid");
		String userid				= (String)session.getValue("userid");
    	QuestionEntry equestion		= new QuestionEntry(); 
    	HashMap	hashmap				= null;
    	String questiontype			= request.getParameter("questiontype");
    	String difficultyfactor		= request.getParameter("difficultyfactor");
    	String examtype				= request.getParameter("examtype");
    	String lesson				= request.getParameter("lesson");
    	
    	String boardname			= request.getParameter("boardname");
    	String standardname			= request.getParameter("standardname");
    	String subjectname			= request.getParameter("subjectname");
    	String lessonname			= request.getParameter("lessonname");
    	String examtypename			= request.getParameter("examtypename");
    	String startsat_str			= request.getParameter("startsat");
    	
    	int startsat_int			= 0;
    	int questionscount			= 0;
    	int currentpos				= 0;

    	
    	try{
	    	if(startsat_str != null && !startsat_str.equals("") && !startsat_str.equals("-") && !startsat_str.equalsIgnoreCase("null"))
	    		startsat_int		= Integer.parseInt(startsat_str);
    	}
    	catch(Exception e){
    		startsat_int			= 0;
    	}
    	
    	ArrayList questionlist		= equestion.loadQuestion(questiontype,difficultyfactor,examtype,lesson,startsat_int);
   		
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
								<%=boardname%>
							</td>
						</tr>			
						<tr>
							<td width='15%' class='tablebold'>Standard Name</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
							<%=standardname%>
							</td>
						</tr>
						<tr>
							<td width='15%' class='tablebold'>Subject Name - Subject Code</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=subjectname%>
							</td>
						</tr>
						<tr>
							<td width='15%' class='tablebold'>Lesson Name</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=lessonname%>
							</td>
						</tr>		
						<tr>
							<td width='15%' class='tablebold'>Exam Type</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=examtypename%>
							</td>
						</tr>
						<tr>
							<td width='15%' class='tablebold'>Question Type</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=questiontype%>
							</td>
						</tr>
						<tr>
							<td width='20%' class='tablebold'>Difficulty Factor</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=difficultyfactor%>
							</td>

						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
		
		<table cellspacing=0  class=tablelight width="100%" border='1' cellpadding='5' cellspacing='0'>
			  <thead>
			  	<tr class='tableheading'>
					<th scope="col"  class="rounded-company" width='5%'>Sl.No.</th>
					<th scope="col"  class="rounded" width='25%'>Question</th>
					<th scope="col"  class="rounded" width='30%'>Answer</th>
					<th scope="col"  class="rounded" width='20%'>Start Date / End Date / Occurrence</th>
					<th scope="col"  class="rounded" width='15%'>Time / Mark / Image</th>
					<th scope="col"  class="rounded-q4" width='5%'>Check</th>
				</tr>
			  </thead>
			<%
				String file			= "";
				String ansvalue 	= "";
 				String questionArr[]= null; 
 				String answerArr[]	= null; 
 				String question		= null;
 				String answer		= null;
 				String canswer		= null;
 				int qremainging		= 0;
 				int aremainging		= 0;
 				HashMap answermap	= new HashMap();
 				
				if(questionlist != null && questionlist.size()>0){
					currentpos	 		= questionlist.size();
					for(int y=0;y<questionlist.size();y++){
						
						hashmap			= (HashMap)questionlist.get(y);
						answermap.clear();
						question		= (String)hashmap.get("question");
						file			= (String)hashmap.get("image");
						canswer			= (String)hashmap.get("correctans");
						
						if(question != null)
							qremainging	= 2000-question.length();
						
						if(canswer != null)
							questionArr	= canswer.split(",");
						
						if(questionArr != null && questionArr.length>0)
							for(int u=0;u<questionArr.length;u++){
								if(!answermap.containsKey(questionArr[u]))
									answermap.put(questionArr[u].toUpperCase(),questionArr[u].toUpperCase());							
							}
						
						out.print("<tr><td valign='top'>"+(startsat_int+y+1)+".</td>");
						
						if(questiontype != null && questiontype.equals("Objectives")){
							
							out.print("<td  valign='top'><textarea name='question' cols='20' rows='5' onfocus='setCurObj(this)' validate='Question' onkeyup=calculateRemaining(this,2000,'remain"+y+"') onkeydown=calculateRemaining(this,2000,'remain"+y+"')>"+question+"</textarea><br><label id='remain"+y+"' class='tablelight'><font color='red'>"+qremainging+" Character(s) Left</font></label></td>");
							
							out.print("<td><table width='100%' id='answertable"+y+"'><tr><td align='center'><a href='#cls' i='"+y+"' onclick='removeAnswer(this)'>&lt;&lt;</a>&nbsp;&nbsp&nbsp;<a href='#cls' i='"+y+"' onclick='addAnswer(this)'>&gt;&gt;</a></td></tr>");
							
								if(answermap.containsKey("A")){
									out.print("<tr id='answertable"+y+"row0'><td valign='top'>A.&nbsp;<input type='checkbox' value='A' checked name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='"+hashmap.get("A")+"'></td></tr>");
								}
								else{
									out.print("<tr id='answertable"+y+"row0'><td valign='top'>A.&nbsp;<input type='checkbox' value='A' name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='"+hashmap.get("A")+"'></td></tr>");
								}
								
								if(answermap.containsKey("B")){
									out.print("<tr id='answertable"+y+"row1'><td valign='top'>B.&nbsp;<input type='checkbox' value='B' checked name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='"+hashmap.get("B")+"'></td></tr>");
								}
								else{
									out.print("<tr id='answertable"+y+"row1'><td valign='top'>B.&nbsp;<input type='checkbox' value='B' name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='"+hashmap.get("B")+"'></td></tr>");
								}
								
								if(hashmap.get("C") == null){
									out.print("<tr id='answertable"+y+"row2'  style='display:none'><td valign='top'>C.&nbsp;<input type='checkbox' value='C' name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='' disabled></td></tr>");
									
								}else{
									
									if(answermap.containsKey("C")){
										out.print("<tr id='answertable"+y+"row2' style='display:block'><td valign='top'>C.&nbsp;<input type='checkbox' value='C' checked name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='"+hashmap.get("C")+"'></td></tr>");
									}
									else{
										out.print("<tr id='answertable"+y+"row2' style='display:block'><td valign='top'>C.&nbsp;<input type='checkbox' value='C' name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='"+hashmap.get("C")+"'></td></tr>");
									}									
								}
								
								if(hashmap.get("D") == null){
									out.print("<tr id='answertable"+y+"row3'  style='display:none'><td valign='top'>D.&nbsp;<input type='checkbox' value='D' name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='' disabled></td></tr>");
									
								}else{
									
									if(answermap.containsKey("D")){
										out.print("<tr id='answertable"+y+"row3' style='display:block'><td valign='top'>D.&nbsp;<input type='checkbox' value='D' checked name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='"+hashmap.get("D")+"'></td></tr>");
									}
									else{
										out.print("<tr id='answertable"+y+"row3' style='display:block'><td valign='top'>D.&nbsp;<input type='checkbox' value='D' name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='"+hashmap.get("D")+"'></td></tr>");
									}									
								}	
								
								if(hashmap.get("E") == null){
									out.print("<tr id='answertable"+y+"row4'  style='display:none'><td valign='top'>E.&nbsp;<input type='checkbox' value='E' name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='' disabled></td></tr>");
									
								}else{
									
									if(answermap.containsKey("E")){
										out.print("<tr id='answertable"+y+"row4' style='display:block'><td valign='top'>E.&nbsp;<input type='checkbox' value='E' checked name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='"+hashmap.get("E")+"'></td></tr>");
									}
									else{
										out.print("<tr id='answertable"+y+"row4' style='display:block'><td valign='top'>E.&nbsp;<input type='checkbox' value='E' name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='"+hashmap.get("E")+"'></td></tr>");
									}									
								}	
								
								if(hashmap.get("F") == null){
									out.print("<tr id='answertable"+y+"row5'  style='display:none'><td valign='top'>F.&nbsp;<input type='checkbox' value='F' name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='' disabled></td></tr>");
									
								}else{
									
									if(answermap.containsKey("F")){
										out.print("<tr id='answertable"+y+"row5' style='display:block'><td valign='top'>F.&nbsp;<input type='checkbox' value='F' checked name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='"+hashmap.get("F")+"'></td></tr>");
									}
									else{
										out.print("<tr id='answertable"+y+"row5' style='display:block'><td valign='top'>F.&nbsp;<input type='checkbox' value='F' name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='"+hashmap.get("F")+"'></td></tr>");
									}									
								}			
								
								if(hashmap.get("G") == null){
									out.print("<tr id='answertable"+y+"row6'  style='display:none'><td valign='top'>G.&nbsp;<input type='checkbox' value='G' name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='' disabled></td></tr>");
									
								}else{
									
									if(answermap.containsKey("G")){
										out.print("<tr id='answertable"+y+"row6' style='display:block'><td valign='top'>G.&nbsp;<input type='checkbox' value='G' checked name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='"+hashmap.get("G")+"'></td></tr>");
									}
									else{
										out.print("<tr id='answertable"+y+"row6' style='display:block'><td valign='top'>G.&nbsp;<input type='checkbox' value='G' name='correctanswer'>&nbsp;<input type='text' name='answer' validate='Answer'  size='20' maxlength='1000' value='"+hashmap.get("G")+"'></td></tr>");
									}									
								}
								
								out.print("</table></td>");
						
						}else if(questiontype != null && questiontype.equals("Matching")){
							if(question != null)
								questionArr	= question.split("\333");
							
							
							out.print("<td><table width='100%' id='questiontable"+y+"' cellspacing='0' cellpadding='5'>");
							
								for(int n=0;n<7;n++){
									
									if(questionArr != null && questionArr.length>n)
										out.print("<tr id='questiontable"+y+"row"+n+"' style='display:block'><td>&nbsp;</td></tr><tr><td>"+(n+1)+".&nbsp;<input type='text' name='question' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Question' value='"+questionArr[n]+"'></td></tr>");
									else
										out.print("<tr id='questiontable"+y+"row"+n+"' style='display:none'><td>"+(n+1)+".&nbsp;<input type='text' name='question' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Question' disabled></td></tr>");
									
								}

							out.print("</table></td>");
							
							
							out.print("<td valign='top'><table width='100%' cellspacing='0' cellpadding='5' id='answertable"+y+"'><tr><td align='center'><a href='#cls' i='"+y+"' onclick='removeAnswerMatching(this)'>&lt;&lt;</a>&nbsp;&nbsp&nbsp;<a href='#cls' i='"+y+"' onclick='addAnswerMatching(this)'>&gt;&gt;</a></td></tr>");
							
								if(canswer != null)
									answerArr	=	canswer.split(",");
								
								
								String tempArr[] = {"A","B","C","D","E","F","G"};
							
								for(int n=0;n<7;n++){
									
									if(answerArr != null && answerArr.length>n){
										
										if(answerArr[n] != null && answerArr[n].equals("2"))
											out.print("<tr id='answertable"+y+"row"+n+"' style='display:block'><td>"+tempArr[n]+".&nbsp;<select name='answercombo'><option>1</option><option selected>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Answer' value='"+hashmap.get(tempArr[n])+"'></td></tr>");
										if(answerArr[n] != null && answerArr[n].equals("3"))
											out.print("<tr id='answertable"+y+"row"+n+"' style='display:block'><td>"+tempArr[n]+".&nbsp;<select name='answercombo'><option>1</option><option>2</option><option selected>3</option><option>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Answer' value='"+hashmap.get(tempArr[n])+"'></td></tr>");
										if(answerArr[n] != null && answerArr[n].equals("4"))
											out.print("<tr id='answertable"+y+"row"+n+"' style='display:block'><td>"+tempArr[n]+".&nbsp;<select name='answercombo'><option>1</option><option>2</option><option>3</option><option selected>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Answer' value='"+hashmap.get(tempArr[n])+"'></td></tr>");
										if(answerArr[n] != null && answerArr[n].equals("5"))
											out.print("<tr id='answertable"+y+"row"+n+"' style='display:block'><td>"+tempArr[n]+".&nbsp;<select name='answercombo'><option>1</option><option>2</option><option>3</option><option >4</option><option selected>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Answer' value='"+hashmap.get(tempArr[n])+"'></td></tr>");
										if(answerArr[n] != null && answerArr[n].equals("6"))
											out.print("<tr id='answertable"+y+"row"+n+"' style='display:block'><td>"+tempArr[n]+".&nbsp;<select name='answercombo'><option>1</option><option selected>2</option><option>3</option><option>4</option><option>5</option><option selected>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Answer' value='"+hashmap.get(tempArr[n])+"'></td></tr>");
										if(answerArr[n] != null && answerArr[n].equals("7"))
											out.print("<tr id='answertable"+y+"row"+n+"' style='display:block'><td>"+tempArr[n]+".&nbsp;<select name='answercombo'><option>1</option><option selected>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option selected>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Answer' value='"+hashmap.get(tempArr[n])+"'></td></tr>");
										else if(answerArr[n] != null && answerArr[n].equals("1"))
											out.print("<tr id='answertable"+y+"row"+n+"' style='display:block'><td>"+tempArr[n]+".&nbsp;<select name='answercombo'><option selected>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' onfocus='setCurObj(this)' validate='Answer' value='"+hashmap.get(tempArr[n])+"'></td></tr>");
											
									}
									else{
										
										if(n == 0)
											out.print("<tr id='answertable"+y+"row"+n+"' style='display:none'><td>A.&nbsp;<select name='answercombo' disabled><option selected>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr>");
										else if(n == 1)
											out.print("<tr id='answertable"+y+"row"+n+"' style='display:none'><td>B.&nbsp;<select name='answercombo' disabled><option selected>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr>");
										else if(n == 2)
											out.print("<tr id='answertable"+y+"row"+n+"' style='display:none'><td>C.&nbsp;<select name='answercombo' disabled><option selected>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr>");
										else if(n == 3)
											out.print("<tr id='answertable"+y+"row"+n+"' style='display:none'><td>D.&nbsp;<select name='answercombo' disabled><option selected>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr>");
										else if(n == 4)
											out.print("<tr id='answertable"+y+"row"+n+"' style='display:none'><td>E.&nbsp;<select name='answercombo' disabled><option selected>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr>");
										else if(n == 5)
											out.print("<tr id='answertable"+y+"row"+n+"' style='display:none'><td>F.&nbsp;<select name='answercombo' disabled><option selected>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr>");
										else if(n == 6)
											out.print("<tr id='answertable"+y+"row"+n+"' style='display:none'><td>G.&nbsp;<select name='answercombo' disabled><option selected>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option></select>&nbsp;<input type='text' name='answer' size='20' maxlength='1000' disabled onfocus='setCurObj(this)' validate='Answer'></td></tr>");
									}
									
								}

							out.print("</table></td>");							

						}
						else{
							answer			= (String)hashmap.get("correctans");
							if(answer != null)
								aremainging	= 1000-answer.length();
							
							out.print("<td  valign='top'><textarea name='question' cols='20' rows='5' onfocus='setCurObj(this)' validate='Question' onkeyup=calculateRemaining(this,2000,'remain"+y+"') onkeydown=calculateRemaining(this,2000,'remain"+y+"')>"+question+"</textarea><br><label id='remain"+y+"' class='tablelight'><font color='red'>"+qremainging+" Character(s) Left</font></label></td>");
							out.print("<td  valign='top'><textarea name='answer' cols='20' rows='5' onfocus='setCurObj(this)'  validate='Answer' onkeyup=calculateRemaining(this,1000,'remain"+(y+10)+"') onkeydown=calculateRemaining(this,1000,'remain"+(y+10)+"')>"+answer+"</textarea><br><label id='remain"+(y+10)+"' class='tablelight'><font color='red'>"+aremainging+" Character(s) Left</font></label></td>");
						}
						
						if(file == null || file.equals("-"))
							file	= "";
						else
							file	= "<br><a href='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+file+"' target='_new'>Existing</a>";
						
					
						out.print("<td  valign='top'><input type='text' name='startdate' size='11' maxlength='11' value='"+hashmap.get("fromdate")+"' validate='Start Date' readonly><br><input type='text' name='enddate' size='11' maxlength='11' value='"+hashmap.get("todate")+"' validate='End Date' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('../../js/Calendar/CalendarWindow.html','question_form.enddate["+y+"]','0',event,'Not_Less_Than_StartDate',document.question_form.startdate["+y+"])><br><input type='text' name='occurance' size='4' maxlength='3' value='"+hashmap.get("occurance")+"' validate='Occurrance'  onkeypress='checkNumber(event)'></td><td  valign='top'><input type='text' name='time' size='5' maxlength='5' value='"+hashmap.get("timelimit")+"' validate='Time' onblur='checkTimeFormat(document.question_form.time["+y+"])'><br><input type='text' name='mark' size='5' maxlength='2' value='"+hashmap.get("mark")+"' validate='Mark' onkeypress='checkNumber(event)'><br><input type='file' name='files' size='5'>"+file+"<input type='hidden' name='totalanswer' value='0'><input type='hidden' name='checkedanswer' value='' ></td><td><input type='checkbox' name='questionid' value='"+hashmap.get("examquestionid")+"'></td></tr>");
					
					}
				}
				else
					out.print("<tr><td colspan='5' align='center'>Data Not Found</td></tr>");
			%>
		</table>
			

		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		
		<%if(currentpos == 10) {%>
			<a href="#" class="bt_blue" onclick='nextQuestion()'><span class="bt_blue_lft"></span><strong>Next</strong><span class="bt_blue_r"></span></a>
		<%} %>

		<%if(startsat_int != 0) {%>
		<a href="#" class="bt_blue" onclick='prevQuestion()'><span class="bt_blue_lft"></span><strong>Previous</strong><span class="bt_blue_r"></span></a>
		<%} %>

		<a href="#" id="savebut"  class="bt_green" onclick='submitQuestion()'><span class="bt_green_lft"></span><strong>Update Question</strong><span class="bt_green_r"></span></a>
		  			
		<input type='hidden' name='examtype' 			value='<%=examtype%>'>
		<input type='hidden' name='lesson' 				value='<%=lesson%>'>
		<input type='hidden' name='difficultyfactor' 	value='<%=difficultyfactor%>'>
		<input type='hidden' name='questiontype' 		value='<%=questiontype%>'>		
		<input type='hidden' name='boardname' 			value='<%=boardname%>'>		
		<input type='hidden' name='standardname' 		value='<%=standardname%>'>		
		<input type='hidden' name='subjectname' 		value='<%=subjectname%>'>		
		<input type='hidden' name='lessonname' 			value='<%=lessonname%>'>		
		<input type='hidden' name='examtypename' 		value='<%=examtypename%>'>	
		<input type='hidden' name='startsat' 			value='<%=startsat_int%>'>
		
		<input type='hidden' name='question' 		value='' disabled>		
		<input type='hidden' name='answer' 			value='' disabled>		
		<input type='hidden' name='startdate' 		value='' disabled>		
		<input type='hidden' name='enddate' 		value='' disabled>		
		<input type='hidden' name='occurance' 		value='' disabled>		
		<input type='hidden' name='mark' 			value='' disabled>		
		<input type='hidden' name='time' 			value='' disabled>		
		<input type='hidden' name='questionid' 		value='' disabled>		
		<input type='hidden' name='totalanswer' 	value='' disabled>		
		<input type='hidden' name='checkedanswer' 	value='' disabled>		
		<input type='hidden' name='files' 			value='' disabled>		
		
</form>		
    
<form name="question_form1"  action="" method="post">

	<input type='hidden' name='examtype' 			value='<%=examtype%>'>
	<input type='hidden' name='lesson' 				value='<%=lesson%>'>
	<input type='hidden' name='difficultyfactor' 	value='<%=difficultyfactor%>'>
	<input type='hidden' name='questiontype' 		value='<%=questiontype%>'>		
	<input type='hidden' name='boardname' 			value='<%=boardname%>'>		
	<input type='hidden' name='standardname' 		value='<%=standardname%>'>		
	<input type='hidden' name='subjectname' 		value='<%=subjectname%>'>		
	<input type='hidden' name='lessonname' 			value='<%=lessonname%>'>		
	<input type='hidden' name='examtypename' 		value='<%=examtypename%>'>
	<input type='hidden' name='startsat' 			value='<%=startsat_int%>'>
	
	
				
</form>    


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>