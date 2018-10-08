<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>i-Grandee Education - Question Generation | Powered by i-Grandee</title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/clearselects.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/xmlhttpobject.js"></script>


<script type="text/javascript">
	
	function submitQuestion(){
	
		if(check_ForParticularElements(document.question_form.academicyear,"select",document.question_form.board,"select",document.question_form.standard,"select",document.question_form.subject,"select",document.question_form.template,"select",document.question_form.examtype,"select",document.question_form.instruction,"textarea")){
			
			document.question_form.yearname.value		= document.question_form.academicyear.options[document.question_form.academicyear.options.selectedIndex].text;
			document.question_form.boardname.value		= document.question_form.board.options[document.question_form.board.options.selectedIndex].text;
			document.question_form.standardname.value	= document.question_form.standard.options[document.question_form.standard.options.selectedIndex].text;
			document.question_form.subjectname.value	= document.question_form.subject.options[document.question_form.subject.options.selectedIndex].text;
			document.question_form.templatename.value	= document.question_form.template.options[document.question_form.template.options.selectedIndex].text;
			document.question_form.examtypename.value	= document.question_form.examtype.options[document.question_form.examtype.options.selectedIndex].text;			


			if(document.question_form.assignstatus.value == "Assigned"){

				alert("Template already allotted for online Exam. So can't generate question now.");

				document.question_form.instruction.value	= document.question_form.oldinstruction.value;
				document.question_form.action				= "QuestionGenerateView.jsp";
				document.question_form.submit();
				
			}else{
			
				if(document.question_form.status.value == "Generated"){
					if(confirm("Question already Generated for this Template.\nClick 'Ok' to Generate new Question or 'Cancel' to view existing Question.")){
						document.question_form.action				= "QuestionGenerateSubmit.jsp";
						document.question_form.submit();
					}else{
						document.question_form.action				= "QuestionGenerateView.jsp";
						document.question_form.submit();
					}
				}
				else{
					document.question_form.action				= "QuestionGenerateSubmit.jsp";
					document.question_form.submit();
				}
			
			
			}
		}
	}	
	
	function startTransaction(str)
	{
		
		var url = "";
		
		if(str == "board")
		{
			var sessionid 	= document.getElementById("academicyear").value;
			
			clearObjects("board","standard","subject","template");
			clearTable();
			loadNDF();
			
			if(check_ForParticularElements(document.question_form.academicyear,"select"))
				url="QuestionPrepareAjax.jsp?action=boardgenerate&sessionid="+sessionid;
			else
				return false;
		}
		else if(str == "standard")
		{
			var sessionid 	= document.getElementById("academicyear").value;
			var boardid 	= document.getElementById("board").value;
			
			clearObjects("standard","subject","template");
			clearTable();
			loadNDF();
			
			if(check_ForParticularElements(document.question_form.academicyear,"select",document.question_form.board,"select"))
				url="QuestionPrepareAjax.jsp?action=standardgenerate&sessionid="+sessionid+"&boardid="+boardid;
			else
				return false;
		}
		else if(str == "subject")
		{
			var sessionid 	= document.getElementById("academicyear").value;
			var standardid 	= document.getElementById("standard").value;
			
			clearObjects("subject","template");
			clearTable();
			loadNDF();
		
			if(check_ForParticularElements(document.question_form.academicyear,"select",document.question_form.board,"select",document.question_form.standard,"select"))
				url="QuestionPrepareAjax.jsp?action=subjectgenerate&sessionid="+sessionid+"&standardid="+standardid;
			else
				return false;
		}
		else if(str == "template")
		{
			var sessionid 	= document.getElementById("academicyear").value;
			var standardid 	= document.getElementById("standard").value;
			var subjectid 	= document.getElementById("subject").value;
			
			clearObjects("template");
			clearTable();
			loadNDF();
		
			if(check_ForParticularElements(document.question_form.academicyear,"select",document.question_form.board,"select",document.question_form.standard,"select",document.question_form.subject,"select"))
				url="QuestionPrepareAjax.jsp?action=templategenerate&sessionid="+sessionid+"&subjectid="+subjectid;
			else
				return false;
		}
		else if(str == "loaddetails")
		{
			var templateid 	= document.getElementById("template").value;
		
			if(check_ForParticularElements(document.question_form.academicyear,"select",document.question_form.board,"select",document.question_form.standard,"select",document.question_form.subject,"select",document.question_form.template,"select"))
				url="QuestionPrepareAjax.jsp?action=templatedetails&templateid="+templateid;
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
					if(str == "loaddetails")
						loadTables(req.responseXML)
					else
						parseMessages(req.responseXML,str);
				}
			}
		};
		req.open("GET", url, true);
		req.send(null);
	}		
	
	function loadTables(xml){
	
		clearTable();
		var tabobj		= document.getElementById("questiondetails");
		var tbodyobj 	= document.createElement("tbody");
		var trobj;
		var tdobj;

		var rootObj		= xml.getElementsByTagName("MainEntity");
		var cNode_1		= rootObj[0].childNodes.length;
		if(cNode_1 >0){
		
			for(var i=0;i<parseInt(cNode_1);i++){
				
				trobj		= document.createElement("tr");
				
				tdobj		= document.createElement("td");
				tdobj.width = "10%";
				tdobj.innerHTML	= (i+1);	
				
				
				trobj.appendChild(tdobj);
				
				tdobj		= document.createElement("td");
				tdobj.width = "25%";
				tdobj.innerHTML	= rootObj[0].childNodes[i].childNodes[2].childNodes[0].nodeValue;	
				trobj.appendChild(tdobj);

				tdobj		= document.createElement("td");
				tdobj.width = "15%";
				tdobj.innerHTML	= rootObj[0].childNodes[i].childNodes[4].childNodes[0].nodeValue;	
				trobj.appendChild(tdobj);
				
				tdobj		= document.createElement("td");
				tdobj.width = "15%";
				tdobj.innerHTML	= rootObj[0].childNodes[i].childNodes[3].childNodes[0].nodeValue;	
				trobj.appendChild(tdobj);
				
				tdobj		= document.createElement("td");
				tdobj.width = "15%";
				tdobj.innerHTML	= rootObj[0].childNodes[i].childNodes[5].childNodes[0].nodeValue;	
				trobj.appendChild(tdobj);
				
				tdobj		= document.createElement("td");
				tdobj.width = "10%";
				tdobj.innerHTML	= rootObj[0].childNodes[i].childNodes[6].childNodes[0].nodeValue;	
				trobj.appendChild(tdobj);
			
				tdobj		= document.createElement("td");
				tdobj.width = "10%";
				tdobj.innerHTML	= parseInt(rootObj[0].childNodes[i].childNodes[6].childNodes[0].nodeValue,10)*parseInt(rootObj[0].childNodes[i].childNodes[5].childNodes[0].nodeValue);	
				trobj.appendChild(tdobj);
				
				tbodyobj.appendChild(trobj);
			
				if(i==0){
					
					document.question_form.status.value			= rootObj[0].childNodes[i].childNodes[8].childNodes[0].nodeValue;
					document.question_form.instruction.value	= rootObj[0].childNodes[i].childNodes[9].childNodes[0].nodeValue;
					document.question_form.assignstatus.value	= rootObj[0].childNodes[i].childNodes[10].childNodes[0].nodeValue;

					document.question_form.oldinstruction.value	= document.question_form.instruction.value;
					document.getElementById("remain").innerHTML	= "<font color='red'>"+(500 - document.question_form.instruction.value.length)+" characters remaining</font>";
					
				}
			}
			tabobj.appendChild(tbodyobj);
		}
		else
			loadNDF();
	}
	
	function clearTable(){
	
		document.question_form.instruction.value	= "";
		
		document.getElementById("remain").innerHTML	= "<font color='red'>500 characters remaining</font>";
		
		
		var tabobj	= document.getElementById("questiondetails");
		for(var i=tabobj.rows.length;i>0;i--){
			tabobj.deleteRow(i-1);
		}
	
	}
	
	function loadNDF(){
		var tabobj	= document.getElementById("questiondetails");
		var tbodyobj 	= document.createElement("tbody");
		var trobj		= document.createElement("tr");
		trobj.className = "tablelight";
		var tdobj		= document.createElement("td");
		tdobj.height	= '30';
		tdobj.align		= 'center';	
		tdobj.colSpan	= '7';	
		tdobj.innerHTML	= '<a class="nodata">Data Not Found</a>';	
		trobj.appendChild(tdobj);
		tbodyobj.appendChild(trobj);
		tabobj.appendChild(tbodyobj);
	}	
	
	function checkTimeFormat(){
	
		var patt1	=/[00-23]:[00-59]/;
		if(!(patt1.test(document.question_form.duration.value))){
		
			alert("Please enter a valid Time.")
			document.question_form.duration.value	= "01:00";
			return false;		
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

	<%ResourceBundle bundle = ResourceBundle.getBundle("resources.ApplicationResources");%>

    <div class="left_content">

    </div>

    <div class="right_content">
	<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.ExamManagement.QuestionPreparation"%>

    <h2><%=bundle.getString("label.exam.templategenerateroot")%></h2>
    <%
    	QuestionPreparation prepare = new QuestionPreparation();
		String instituteid			= (String)session.getValue("instituteid");
		String userid				= (String)session.getValue("userid");
    	HashMap	hashmap				= null;
    	ArrayList sessionList		= prepare.loadSessionForGeneration(instituteid);
    	ArrayList examTypeList		= prepare.getExamType(userid);
    %>
    
    <form name="question_form" action="" method="post">
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.exam.questiongenerationdetails")%></th>
		            <th scope="col" class="rounded-q4" 		width="1%"></th>
		        </tr>
		    </thead>
		    <tr>
		    	<td colspan='2'>						
					<table width='100%' align='center' border='0' cellpadding='5'>
						<tr height=20>
							<td class=tablebold width="20%" align="left"><%=bundle.getString("label.exam.academicyear")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="80%" align="left">
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
							<td class=tablebold width="25%" align="left"><%=bundle.getString("label.common.boardmediumname")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="75%" align="left">
								<select name="board" id='board' validate="Board Name" class=tablelight onChange='startTransaction("standard")'>
									<option selected>- Select Board Name -</option>
								</select>
							</td>
						</tr>
						<tr height=20>
							<td class=tablebold width="25%" align="left"><%=bundle.getString("label.exam.standardname")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="75%" align="left">
								<select name="standard" id='standard' validate="Standard Name" class=tablelight onChange='startTransaction("subject")'>
									<option selected>- Select Standard Name -</option>
								</select>
							</td>
						</tr>
						<tr height=20>
							<td class=tablebold width="25%" align="left"><%=bundle.getString("label.exam.subjectname")%> - <%=bundle.getString("label.common.subjectcode")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="75%" align="left">
								<select name='subject' id='subject' validate="Subject Name" class=tablelight onChange='startTransaction("template")'>
									<option selected>- Select Subject Name -</option>
								</select>
							</td>
						</tr>
						
						<tr height=20>
							<td class=tablebold width="25%" align="left"><%=bundle.getString("label.exam.templatename")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="75%" align="left"><select id=template name=template validate="Template Name" class=tablelight onChange='startTransaction("loaddetails")'>
								<option>- Select Template Name -</option>
							</select></td>
						</tr>
						<tr height=20>
							<td class=tablebold width="25%" align="left"><%=bundle.getString("label.exam.examtype")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="75%" align="left"><select id=examtype name=examtype validate="Exam Type" class=tablelight>
								<option>- Select Exam Type -</option>
								<%
									if(examTypeList!=null && examTypeList.size()>0)
									for(int j=0;j<examTypeList.size();j++){
										hashmap 				= (HashMap)examTypeList.get(j);
										out.print("<option value="+hashmap.get("examtypeid")+">"+hashmap.get("examtypename")+"</option>");
									}
								%>
							</select></td>
						</tr>
						<tr height=20>
							<td class=tablebold width="25%" align="left" valign='top'><%=bundle.getString("label.exam.instructions")%></td>
							<td class=tablebold width="1%" align="left" valign='top'>:</td>
							<td width="75%" align="left" class='tablelight'>
								<textarea name='instruction' validate='Instruction' rows='5' cols='70' onkeyup=calculateRemaining(this,500,'remain') onkeydown=calculateRemaining(this,500,'remain')></textarea><br><label id='remain' class='tablelight'><font color='red'>500 characters remaining</font></label>
							</td>
						</tr>
						<tr height=20>
							<td align="center" colspan='3'>
								<input type='radio' name='repetation' value='without' checked><%=bundle.getString("label.exam.withoutrepeatation")%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='radio' name='repetation' value='with' checked><%=bundle.getString("label.exam.withrepeatation")%>
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
		    	<tr>
		    		<td colspan='7' align='center'>
						<table id="questiondetails" border=0 summary="Department List" width="100%">
					    	<tr>
					    		<td colspan='7' align='center'>
					    			<a class='nodata'><%=bundle.getString("label.exam.datanotfound")%></a>
					    		</td>
					    	</tr>
						</table>
					</td>
		    	</tr>
		 </table>
		

		<a href="#" id="savebut"  class="bt_green" onclick='submitQuestion()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.exam.generatequestion")%></strong><span class="bt_green_r"></span></a>
		  			
		<input type='hidden' name='examname' 			value=''>
		<input type='hidden' name='yearname' 			value=''>
		<input type='hidden' name='standardname' 		value=''>
		<input type='hidden' name='templatename' 		value=''>
		<input type='hidden' name='boardname' 			value=''>
		<input type='hidden' name='examtypename' 		value=''>
		<input type='hidden' name='subjectname' 		value=''>
		<input type='hidden' name='restartname' 		value=''>
		<input type='hidden' name='attemptname' 		value=''>
		<input type='hidden' name='status' 				value=''>
		<input type='hidden' name='oldinstruction' 		value=''>
		<input type='hidden' name='assignstatus' 		value=''>
		

		
</form>		
    
    


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>