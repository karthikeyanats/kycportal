<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>i-Grandee Education - Assign Online Exam | Powered by i-Grandee</title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/clearselects.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/xmlhttpobject.js"></script>


<script type="text/javascript">
	
	function submitQuestion(){
	
		if(check_ForParticularElements(document.question_form.academicyear,"select",document.question_form.board,"select",document.question_form.standard,"select",document.question_form.subject,"select",document.question_form.template,"select",document.question_form.passmark,"select")){
			
			document.question_form.action		= "OnlineExamSubmit.jsp";
			document.question_form.submit();
			
		}
	}	
	
	function startTransaction(str)
	{
		
		var url = "";
		if(str == "board")
		{
			var sessionid 	= document.getElementById("academicyear").value;
			document.getElementById("creationdate").innerHTML	= "";
			
			clearObjects("board","standard","subject","template","passmark");
			clearTable();
			loadNDF();
			
			if(check_ForParticularElements(document.question_form.academicyear,"select"))
				url="QuestionPrepareAjax.jsp?action=boardonline&sessionid="+sessionid;
			else
				return false;
		}
		else if(str == "standard")
		{
			var sessionid 	= document.getElementById("academicyear").value;
			var boardid 	= document.getElementById("board").value;
			
			document.getElementById("creationdate").innerHTML	= "";
			
			clearObjects("standard","subject","template","passmark");
			clearTable();
			loadNDF();
			
			if(check_ForParticularElements(document.question_form.academicyear,"select",document.question_form.board,"select"))
				url="QuestionPrepareAjax.jsp?action=standardonline&sessionid="+sessionid+"&boardid="+boardid;
			else
				return false;
		}
		else if(str == "subject")
		{
			var sessionid 	= document.getElementById("academicyear").value;
			var standardid 	= document.getElementById("standard").value;
			document.getElementById("creationdate").innerHTML	= "";
			clearObjects("subject","template","passmark");
			clearTable();
			loadNDF();
		
			if(check_ForParticularElements(document.question_form.academicyear,"select",document.question_form.board,"select",document.question_form.standard,"select"))
				url="QuestionPrepareAjax.jsp?action=subjectonline&sessionid="+sessionid+"&standardid="+standardid;
			else
				return false;
		}
		else if(str == "template")
		{
			var sessionid 	= document.getElementById("academicyear").value;
			var standardid 	= document.getElementById("standard").value;
			var subjectid 	= document.getElementById("subject").value;
			document.getElementById("creationdate").innerHTML	= "";
			clearObjects("template","passmark");
			clearTable();
			loadNDF();
		
			if(check_ForParticularElements(document.question_form.academicyear,"select",document.question_form.board,"select",document.question_form.standard,"select",document.question_form.subject,"select"))
				url="QuestionPrepareAjax.jsp?action=templateonline&sessionid="+sessionid+"&subjectid="+subjectid;
			else
				return false;
		}
		else if(str == "loaddetails")
		{
			clearObjects("passmark");
			var templateid 	= document.getElementById("template").value;
			document.getElementById("creationdate").innerHTML	= "";
		
			if(check_ForParticularElements(document.question_form.academicyear,"select",document.question_form.board,"select",document.question_form.standard,"select",document.question_form.subject,"select",document.question_form.template,"select")){
				loadPassMark()
				url="QuestionPrepareAjax.jsp?action=templatedetailsonline&templateid="+templateid;
			
			}
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
					else if(str == "template")
						loadTemplate(req.responseXML)
					else
						parseMessages(req.responseXML,str);
				}
			}
		};
		req.open("GET", url, true);
		req.send(null);
	}	
	
	function loadTemplate(xml){
	
		var resultObj	= document.getElementById("template");
		var rootObj		= xml.getElementsByTagName("MainEntity");
		var cNode_1		= rootObj[0].childNodes.length;
		
		for(var i=0;i<parseInt(cNode_1);i++){
			resultObj.options[resultObj.options.length] = new Option(rootObj[0].childNodes[i].childNodes[1].childNodes[0].nodeValue,rootObj[0].childNodes[i].childNodes[0].childNodes[0].nodeValue);
			resultObj.options[resultObj.options.length-1].setAttribute("totalmark",rootObj[0].childNodes[i].childNodes[2].childNodes[0].nodeValue);
			resultObj.options[resultObj.options.length-1].setAttribute("createddate",rootObj[0].childNodes[i].childNodes[3].childNodes[0].nodeValue);
		}
	}	
	
	function loadPassMark(){
	
		var obj		= document.getElementById("template");
		var obj1	= document.getElementById("passmark");
		
		var mark	= parseInt(obj.options[obj.options.selectedIndex].getAttribute("totalmark"),10);
		document.getElementById("creationdate").innerHTML	= obj.options[obj.options.selectedIndex].getAttribute("createddate");
		for(var y=1;y<=mark;y++){
			obj1.options[obj1.options.length] = new Option(y,y);
		}
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
				
			}
			tabobj.appendChild(tbodyobj);
			
		}
		else
			loadNDF();
	}
	
	function clearTable(){
	
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
		tdobj.innerHTML	= '<a class=nodata>Data Not Found</a>';	
		trobj.appendChild(tdobj);
		tbodyobj.appendChild(trobj);
		tabobj.appendChild(tbodyobj);
	}	
	
	
	function checkFees(){
	
		if(!numeric_Validation(document.question_form.examfee,"Exam Fee")){
			document.question_form.examfee.value	= "";
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
	<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.ExamManagement.OnlineExam"%>

    <h2><%=bundle.getString("label.exam.onlineexamroot")%></h2>
    <%
    	OnlineExam prepare 			= new  OnlineExam();
		String instituteid			= (String)session.getValue("instituteid");
		String userid				= (String)session.getValue("userid");
    	HashMap	hashmap				= null;
    	ArrayList sessionList		= prepare.loadSessionForOnlineExam(instituteid);
    %>
    
    <form name="question_form" action="" method="post">
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" 		width="99%"><%=bundle.getString("label.exam.onlineexamdetails")%></th>
		            <th scope="col" class="rounded-q4" 		width="1%"></th>
		        </tr>
		    </thead>
		    <tr>
		    	<td colspan='2'>						
					<table width='100%' align='center' border='0' cellpadding='5'>
						
						<tr height=20>
							<td class=tablebold width="25%" align="left"><%=bundle.getString("label.exam.academicyear")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="75%" align="left">
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
							<td class=tablebold width="25%" align="left"><%=bundle.getString("label.exam.boardname")%></td>
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
							<td class=tablebold width="25%" align="left"><%=bundle.getString("label.exam.subjectname")%></td>
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
							<td class=tablebold width="25%" align="left"><%=bundle.getString("label.exam.passmark")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="75%" align="left">
								<select id='passmark' name='passmark' validate="Pass Mark" class=tablelight>
									<option>- Select Pass Mark -</option>
								</select>
							</td>
						</tr>
						<tr height=20>
							<td class=tablebold width="25%" align="left"><%=bundle.getString("label.exam.templatecreationdate")%></td>
							<td class=tablebold width="1%" align="left">:</td>
							<td width="75%" align="left">
								<span id='creationdate'></span>							
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
		
		<a href="./OnlineExamTemplateDeallocationSearch.jsp" id="savebut"  class="bt_green"><span class="bt_green_lft"></span><strong>Online Exam Deallocation</strong><span class="bt_green_r"></span></a>

		<a href="#" id="savebut"  class="bt_green" onclick='submitQuestion()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.exam.assignforonlineexam")%></strong><span class="bt_green_r"></span></a>
		  			
		<input type='hidden' name='examname' 			value=''>
		<input type='hidden' name='yearname' 			value=''>
		<input type='hidden' name='standardname' 		value=''>
		<input type='hidden' name='templatename' 		value=''>
		<input type='hidden' name='examtypename' 		value=''>
		<input type='hidden' name='subjectname' 		value=''>
		<input type='hidden' name='status' 				value=''>
		
</form>		
    
    


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>