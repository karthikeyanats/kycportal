<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>i-Grandee Education - Template Preparation | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/clearselects.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/xmlhttpobject.js"></script>

<script type="text/javascript">
	
	var summark			= 0;
	var sumquestion 	= 0;
	var addedarray      = new Array();
	var nexttemplateno	= 0;
	var c				= 1;
	
	function loadTempalteNumber(){
		nexttemplateno	= document.question_form.templateno.value;
	}
	

	function changeSubject(){
		//if(check_ForParticularElements(document.question_form.subject,"select")){
			document.question_form.submit();	
		//}
	}
	
	
	function startTransaction(str)
	{
		var url = "";
		if(str == "questiontype")
		{
			var lessonid 		= document.getElementById("lesson").value;
			clearObjects("questiontype","dfactor","examtype","mark","noofquestion");
			document.getElementById("totalquestion").innerHTML		= "0";
			document.getElementById("availablequestion").innerHTML	= "0";
			
			if(check_ForParticularElements(document.question_form.subject,"select",document.question_form.lesson,"select"))
				url="QuestionPrepareAjax.jsp?action=questiontype&lessonid="+lessonid;
			else
				return false;
		}
		else if(str == "dfactor")
		{
			var lessonid 	= document.getElementById("lesson").value;
			var qtype		= document.getElementById("questiontype").value;
			clearObjects("dfactor","examtype","mark","noofquestion");
			document.getElementById("totalquestion").innerHTML		= "0";
			document.getElementById("availablequestion").innerHTML	= "0";
		
			if(check_ForParticularElements(document.question_form.subject,"select",document.question_form.lesson,"select",document.question_form.questiontype,"select"))
				url="QuestionPrepareAjax.jsp?action=dfactor&lessonid="+lessonid+"&questiontype="+qtype;
			else
				return false;
		}
		else if(str == "examtype")
		{
			var lessonid 	= document.getElementById("lesson").value;
			var qtype		= document.getElementById("questiontype").value;
			var dfactor		= document.getElementById("dfactor").value;
			clearObjects("examtype","mark","noofquestion");
			document.getElementById("totalquestion").innerHTML		= "0";
			document.getElementById("availablequestion").innerHTML	= "0";
			
	
			if(check_ForParticularElements(document.question_form.subject,"select",document.question_form.lesson,"select",document.question_form.questiontype,"select",document.question_form.dfactor,"select"))
				url="QuestionPrepareAjax.jsp?action=examtype&lessonid="+lessonid+"&questiontype="+qtype+"&dfactor="+dfactor;
			else
				return false;
		}
		else if(str == "mark")
		{
			var lessonid 	= document.getElementById("lesson").value;
			var qtype		= document.getElementById("questiontype").value;
			var dfactor		= document.getElementById("dfactor").value;
			var examtype	= document.getElementById("examtype").value;
	
			clearObjects("mark","noofquestion");
			document.getElementById("totalquestion").innerHTML		= "0";
			document.getElementById("availablequestion").innerHTML	= "0";
			
	
			if(check_ForParticularElements(document.question_form.subject,"select",document.question_form.lesson,"select",document.question_form.questiontype,"select",document.question_form.dfactor,"select",document.question_form.examtype,"select"))
				url="QuestionPrepareAjax.jsp?action=mark&lessonid="+lessonid+"&questiontype="+qtype+"&dfactor="+dfactor+"&examtype="+examtype;
			else
				return false;
		}
		else if(str == "noofquestion")
		{
			var lessonid 	= document.getElementById("lesson").value;
			var qtype		= document.getElementById("questiontype").value;
			var dfactor		= document.getElementById("dfactor").value;
			var examtype	= document.getElementById("examtype").value;
			var subjectid 	= document.getElementById("subject").value;
			var mark 		= document.getElementById("mark").value;
					
			clearObjects("noofquestion");
			document.getElementById("totalquestion").innerHTML		= "0";
			document.getElementById("availablequestion").innerHTML	= "0";
			
	
			if(check_ForParticularElements(document.question_form.subject,"select",document.question_form.lesson,"select",document.question_form.questiontype,"select",document.question_form.dfactor,"select",document.question_form.examtype,"select",document.question_form.mark,"select"))
				url="QuestionPrepareAjax.jsp?action=noofquestion&lessonid="+lessonid+"&questiontype="+qtype+"&dfactor="+dfactor+"&examtype="+examtype+"&mark="+mark;
			else
				return false;
		}	
		else if(str == "loadexisting")
		{
			var qsid = document.getElementById("enames").value;
	
			if(check_ForParticularElements(document.question_form.subject,"select"))
				url="QuestionPrepareAjax.jsp?action=loadexisting&qsid="+qsid;
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
					if(str == "noofquestion")
						parseResponse(req.responseXML);
					else if(str == "loadexisting")
						loadData(req.responseXML)
					else
						parseMessages(req.responseXML,str);
				}
			}
		};
		req.open("GET", url, true);
		req.send(null);
	}	


	function parseResponse(parseXML)
	{
		var noobject			= document.getElementById("noofquestion")
		if((parseXML.documentElement) != null)
		{
			root_obj 			= parseXML.getElementsByTagName("MainEntity");
			var temp_name 		= root_obj[0].childNodes[0].childNodes[1].childNodes[0].nodeValue;
			document.getElementById("totalquestion").innerHTML		= root_obj[0].childNodes[0].childNodes[0].childNodes[0].nodeValue;
			document.getElementById("availablequestion").innerHTML	= root_obj[0].childNodes[0].childNodes[1].childNodes[0].nodeValue;
	
			for(var i=0;i<parseInt(temp_name);i++){
			
				noobject.options[noobject.options.length]= new Option(i+1,i+1);
			}
		}
	}


	function addArray(subjectid,lessonid,typeid,levelid,markid,idvalue,questions)
	{
		this.subjectid	= subjectid;
		this.lessonid	= lessonid;
		this.typeid		= typeid;
		this.levelid	= levelid;
		this.markid		= markid;
		this.idvalue	= idvalue;
		this.questions	= questions;
	}
	
	
	function addDirectValue()
	{
		if(check_ForParticularElements(document.question_form.subject,"select",document.question_form.lesson,"select",document.question_form.questiontype,"select",document.question_form.dfactor,"select",document.question_form.examtype,"select",document.question_form.mark,"select",document.question_form.noofquestion,"select"))
		{

			var flag		= false;
			var qnVal		= document.getElementById("noofquestion").value;
			var chapVal		= document.getElementById("lesson").value;
			var typeVal		= document.getElementById("questiontype").value;
			var jobVal 		= document.getElementById("examtype").value;
			var skillVal	= document.getElementById("subject").value;
			var markVal		= document.getElementById("mark").value;
			var levelVal 	= document.getElementById("dfactor").value;
			var availquest	= parseInt(document.getElementById("availablequestion").innerHTML,10);
			var added		= 0;

			
			for(var x=0;x<addedarray.length;x++)
			{
				if(addedarray[x].lessonid == chapVal && addedarray[x].typeid == typeVal && addedarray[x].levelid == levelVal && addedarray[x].markid ==markVal)
				{
					added		+= parseFloat(addedarray[x].questions,10);
				}
			}
			
	
			var subjectcode = document.question_form.subject.options[document.question_form.subject.options.selectedIndex].text;
			subjectcode		= subjectcode.substring(subjectcode.indexOf("-")+1)
			document.getElementById("exam_name").innerHTML	= subjectcode+"-SetExam-"+(parseInt(nexttemplateno,10)+1);
			document.question_form.description.value	= subjectcode+"-SetExam-"+(parseInt(nexttemplateno,10)+1);;
	
	
			for(var x=0;x<addedarray.length;x++)
			{
				if(addedarray[x].lessonid == chapVal && addedarray[x].typeid == typeVal && addedarray[x].levelid == levelVal && addedarray[x].markid ==markVal)
				{
					if(confirm("Selected Lesson,Type,Difficulty Factor,Mark already exists.Do you wish to overwrite the Number of Questions?"))
					{
	
						added		+= parseFloat(qnVal,10);
						added		-= parseFloat(addedarray[x].questions,10);
						
						
						if(added <= availquest){
						
						
							var str 		= document.getElementById("tottd"+addedarray[x].idvalue).innerHTML;
							str				= str.substring(str.indexOf("<"));
							var temptotal	= parseInt(qnVal,10)*parseInt(markVal,10);
							document.getElementById("tottd"+addedarray[x].idvalue).innerHTML = temptotal+""+str;
							flag			= true;
							document.getElementById("qn"+addedarray[x].idvalue).value 	= qnVal;
							document.getElementById("tot"+addedarray[x].idvalue).value 	= temptotal;
		
							summark			= summark - (parseInt(addedarray[x].markid,10)*parseInt(addedarray[x].questions,10));
							summark			= summark+temptotal;
		
							sumquestion		= sumquestion-parseInt(addedarray[x].questions,10);
							sumquestion		= sumquestion+parseInt(qnVal,10);
		
							document.getElementById("SelQn").innerHTML	= sumquestion;
							document.getElementById("SelMk").innerHTML	= summark;
		
							addedarray[x].questions = qnVal;
						
							Checkval();	
						
						}
						else{
						
							alert("You can't add more questions than Available question.");
							flag			= true;
							return false;
						
						}
						
						
					}
					break;
				}
			}
			
			if(!flag)
			{

				added		+= parseFloat(qnVal,10);
				
				
				if(added <= availquest){
				


					addedarray[addedarray.length]		= new addArray(skillVal,chapVal,typeVal,levelVal,markVal,c,qnVal);
		
					var tableobj 	= document.getElementById("qnTab");
					var tbodyobj 	= document.createElement("tbody");
		
		
					var trobj		= document.createElement("tr");
					trobj.className = "tablelight";
					trobj.bgColor	= "lightcyan";
					trobj.id		= "trobj"+c;
					var tdobj		= document.createElement("td");
					tdobj.height	= '30';
		
					tdobj.innerHTML	= "<input type=checkbox checked name='check"+c+"' qnid='"+qnVal+"' id='"+c+"' value='"+chapVal+"' type_val='"+typeVal+"' onClick=Checkval();changeColor(this)>";
					trobj.appendChild(tdobj);
		
					var tdobj		= document.createElement("td");
					tdobj.innerHTML	= document.question_form.lesson.options[document.question_form.lesson.selectedIndex].text+"<input type=hidden name='chap"+c+"' value='"+chapVal+"'><input type=hidden name='job"+c+"' value='"+jobVal+"'><input type=hidden name='skill"+c+"' value='"+skillVal+"'>";
					trobj.appendChild(tdobj);
		
		
					var tdobj		= document.createElement("td");
					tdobj.innerHTML	= typeVal+"<input type=hidden name='type"+c+"' value='"+typeVal+"'>";
					trobj.appendChild(tdobj);
		
		
					var tdobj		= document.createElement("td");
					levelVal		= document.question_form.dfactor.options[document.question_form.dfactor.options.selectedIndex].text;
					tdobj.innerHTML	= levelVal+"<input type=hidden name='level"+c+"' value='"+levelVal+"'>";
					trobj.appendChild(tdobj);
		
		
					var tdobj		= document.createElement("td");
					tdobj.innerHTML="<input type=text name='qn"+c+"' id='qn"+c+"' readonly size=1 class=tablelight value='"+qnVal+"' len="+c+">&nbsp;<font title='Available Questions'></font>";
					trobj.appendChild(tdobj);
		
		
					var tdobj		= document.createElement("td");
					tdobj.innerHTML="<input type=text name='mark"+c+"' readonly size=1 class=tablelight value='"+markVal+"' len="+c+">";
					trobj.appendChild(tdobj);
		
		
					var total=parseFloat(qnVal)*parseFloat(markVal);
		
					var tdobj		= document.createElement("td");
					idx 			= parseInt(c) - 1;
					tdobj.id		= "tottd"+c;
					tdobj.innerHTML	= total+"<input type=hidden name='tot"+c+"' id='tot"+c+"' value='"+total+"'>";
					trobj.appendChild(tdobj);
		
					tbodyobj.appendChild(trobj);
					tableobj.appendChild(tbodyobj);
					c				= c+1
	
					Checkval();	
				
				}else{
						
					alert("You can't add more questions than Available question.");
					return false;
				}
				
			}
			
			document.getElementById("templatetable").style.display 	= '';
			document.getElementById("qnTab").style.display 			= '';
			document.getElementById("marktable").style.display 		= '';
			
		}
	}
	
	function changeColor(obj){
	
		var ide		= obj.getAttribute("id");
		var trid	= document.getElementById("trobj"+ide);
		
		if(obj.checked)
			trid.bgColor	= "lightcyan";
		else
			trid.bgColor	= "white";
	
	}
	
	
	function Checkval()
	{
		var sum		= 0;
		var sum1	= 0;
		var qnobj	= document.getElementById("qnTab");
		
	  	for(var i=qnobj.rows.length;i>1;i--){
	  	
		   if(eval("document.question_form.check"+(i-1)+".checked"))
		   {
				sum		= parseFloat(sum)+parseFloat(eval("document.question_form.qn"+(i-1)+".value"));
				sum1	= parseFloat(sum1)+parseFloat(eval("document.question_form.mark"+(i-1)+".value"))*parseFloat(eval("document.question_form.qn"+(i-1)+".value"));
		   }
	  	}

		 document.getElementById("SelQn").innerHTML	= sum;
		 document.getElementById("SelMk").innerHTML	= sum1;
	}
	

	function submitQuestion()
	{
	  	var count		= 0;
	  	var hideobj		= document.getElementById("hideTab");
	  	var qnobj		= document.getElementById("qnTab");
	  	var tbodyobj	= document.createElement("tbody");
	  	
		if(hideobj.rows.length>1)
		{
		  for(var j=hideobj.rows.length;j>1;j--)
		  {
		  	hideobj.deleteRow(j-1);
		  }
		}
	
	  	for(var i=qnobj.rows.length;i>1;i--){
	    	if(eval("document.question_form.check"+(i-1)+".checked")){
				count++;
	    	}
	  	}
	
	  	if(count==0){
	  
	  		alert("Please select atleast a checkbox");
	  		return false;
	  	
	  	}else{
	  	
		  	for(var i=qnobj.rows.length;i>1;i--){

				if(eval("document.question_form.check"+(i-1)+".checked"))
				{
					var trobj		= document.createElement("tr");
					var tdobj		= document.createElement("td");
					var chap		= eval("document.question_form.chap"+(i-1)+".value");
					var type		= eval("document.question_form.type"+(i-1)+".value");
					var level		= eval("document.question_form.level"+(i-1)+".value");
					var qn			= eval("document.question_form.qn"+(i-1)+".value");
					var mark		= eval("document.question_form.mark"+(i-1)+".value");
					tdobj.innerHTML	= "<input type=hidden name=chap value='"+chap+"'><input type=hidden name=type value='"+type+"'><input type=hidden name=level value='"+level+"'><input type=hidden name=qn value='"+qn+"'><input type=hidden name=marks value='"+mark+"'>";
					trobj.appendChild(tdobj);
					tbodyobj.appendChild(trobj);
				}
			}
		  
			hideobj.appendChild(tbodyobj);
		  	document.question_form.action="PreparationSubmit.jsp";
		  	document.question_form.submit();
	
	 	}
	}


function loadData(obj)
{
	var rootObj		= obj.getElementsByTagName("Row");
	var subjectid 	= document.getElementById("subject").value;
	var progid 		= "0";
	var flag		= false;


	if(rootObj != null)
	for(var j=0;j<rootObj.length;j++)
	{
		var qsdid	 	= rootObj[j].childNodes[0].childNodes[0].nodeValue;
		var lessonid 	= rootObj[j].childNodes[1].childNodes[0].nodeValue;
		var df	 		= rootObj[j].childNodes[2].childNodes[0].nodeValue;
		var type 		= rootObj[j].childNodes[3].childNodes[0].nodeValue;
		var noqn		= rootObj[j].childNodes[4].childNodes[0].nodeValue;
		var mpqn 		= rootObj[j].childNodes[5].childNodes[0].nodeValue;
		var lessonname	= rootObj[j].childNodes[6].childNodes[0].nodeValue;


		var subjectcode 	= document.question_form.subject.options[document.question_form.subject.options.selectedIndex].text;
		subjectcode			= subjectcode.substring(subjectcode.indexOf("-")+1)
		document.getElementById("exam_name").innerHTML	= subjectcode+"-SetExam-"+(parseInt(nexttemplateno,10)+1);
		document.question_form.description.value	= subjectcode+"-SetExam-"+(parseInt(nexttemplateno,10)+1);;

		for(var x=0;x<addedarray.length;x++)
		{
			if(addedarray[x].subjectid == subjectid && addedarray[x].lessonid == lessonid && addedarray[x].typeid == type && addedarray[x].levelid == df && addedarray[x].markid == mpqn)
			{
				if(confirm("Selected Lesson,Type,Difficulty Factor,Mark already exists.Do you wish to overwrite the Number of Questions?"))
				{

					var str 		= document.getElementById("tottd"+addedarray[x].idvalue).innerHTML;
					str				= str.substring(str.indexOf("<"));
					var temptotal	= parseInt(noqn,10)*parseInt(mpqn,10);
					document.getElementById("tottd"+addedarray[x].idvalue).innerHTML = temptotal+""+str;
					flag			= true;
					document.getElementById("qn"+addedarray[x].idvalue).value 	= noqn;
					document.getElementById("tot"+addedarray[x].idvalue).value 	= temptotal;
					addedarray[x].questions = noqn;
					
					Checkval();	
					
				}
				break;
			}
		}


		if(!flag)
		{
			addedarray[addedarray.length]		= new addArray(subjectid,lessonid,type,df,mpqn,c,noqn);

			var tableobj 	= document.getElementById("qnTab");
			var tbodyobj 	= document.createElement("tbody");


			var trobj		= document.createElement("tr");
			trobj.className = "tablelight";
			trobj.bgColor	= "lightcyan";
			trobj.id		= "trobj"+c;
			var tdobj		= document.createElement("td");
			tdobj.height	= '30';

			tdobj.innerHTML	= "<input type=checkbox checked name='check"+c+"' qnid='"+noqn+"' id='"+c+"' value='"+lessonid+"' type_val='"+type+"' onClick=Checkval();changeColor(this)>";
			trobj.appendChild(tdobj);

			var tdobj		= document.createElement("td");
			tdobj.innerHTML	= lessonname+"<input type=hidden name='chap"+c+"' value='"+lessonid+"'><input type=hidden name='job"+c+"' value='"+progid+"'><input type=hidden name='skill"+c+"' value='"+subjectid+"'>";
			trobj.appendChild(tdobj);

			var tdobj		= document.createElement("td");
			tdobj.innerHTML	= type+"<input type=hidden name='type"+c+"' value='"+type+"'>";
			trobj.appendChild(tdobj);


			var tdobj		= document.createElement("td");
			tdobj.innerHTML	= df+"<input type=hidden name='level"+c+"' value='"+df+"'>";
			trobj.appendChild(tdobj);


			var tdobj		= document.createElement("td");
			tdobj.innerHTML="<input type=text name='qn"+c+"' id='qn"+c+"' readonly size=1 class=tablelight value='"+noqn+"' len="+c+">&nbsp;<font title='Available Questions'></font>";
			trobj.appendChild(tdobj);


			var tdobj		= document.createElement("td");
			tdobj.innerHTML="<input type=text name='mark"+c+"' readonly size=1 class=tablelight value='"+mpqn+"' len="+c+">";
			trobj.appendChild(tdobj);


			var total=parseFloat(noqn)*parseFloat(mpqn);

			var tdobj		= document.createElement("td");
			idx 			= parseInt(c) - 1;
			tdobj.id		= "tottd"+c;
			tdobj.innerHTML	= total+"<input type=hidden name='tot"+c+"' id='tot"+c+"' value='"+total+"'>";
			trobj.appendChild(tdobj);

			tbodyobj.appendChild(trobj);
			tableobj.appendChild(tbodyobj);
			c				= c+1

			Checkval();	

		}

		document.getElementById("templatetable").style.display 	= '';
		document.getElementById("qnTab").style.display 			= '';
		document.getElementById("marktable").style.display 		= '';
		
	}
}

	function callBack(){
		  	
	  	document.question_form.action="QuestionPreparation.jsp";
	  	document.question_form.submit();
	  	
	}

</script>

</head>
<body onload='loadTempalteNumber()'>
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

    <h2><%=bundle.getString("label.exam.templateprepareroot")%></h2>
    <%
    	QuestionPreparation prepare = new QuestionPreparation();
    	HashMap	hashmap				= null;
    	ArrayList lessonList		= null;
    	ArrayList existingList		= null;
    	String templateno			= "0";
		String standardname			= request.getParameter("standardname");
		String examname				= request.getParameter("examname");
		String examid				= request.getParameter("exam");
		String standardid			= request.getParameter("standard");
		String boardid				= request.getParameter("board");		
		String sessionname			= request.getParameter("yearname");
		String sessionid			= request.getParameter("academicyear");
		String templatetype			= request.getParameter("templatetype");
		ArrayList subjectlist		= prepare.loadSubjects(standardid);
		String subjectid			= request.getParameter("subject");
		String boardname			= request.getParameter("boardname");
		
		if(subjectid != null){
			lessonList				= prepare.loadLessons(subjectid);
			existingList			= prepare.loadExistingTempates(subjectid);
			templateno				= prepare.getMaxTemplateNumber(subjectid);
		}
		
    %>
    
		    <form name="question_form" action="" method="post">
				<table id="rounded-corner" border=0 summary="Department List" width="80%">
				    <thead>
				    	<tr>
				            <th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.exam.selectedinfo")%></th>
				            <th scope="col" class="rounded-q4" 		width="1%"></th>
				        </tr>
				    </thead>
				    <tr>
				    	<td colspan='2'>						
							<table width='100%' align='center' border='0' cellpadding='5'>
								<tr height=20>
									<td class=tablebold width="20%" align="left"><%=bundle.getString("label.common.academicyear")%></td>
									<td class=tablebold width="1%" align="left">:</td>
									<td width="79%" align="left"><%=sessionname%></td>
								</tr>
				
								<tr height=20>
									<td class=tablebold align="left"><%=bundle.getString("label.common.boardmediumname")%></td>
									<td class=tablebold align="left">:</td>
									<td align="left"><%=boardname%></td>
								</tr>
				
								<tr height=20>
									<td class=tablebold align="left"><%=bundle.getString("label.exam.standardname")%></td>
									<td class=tablebold align="left">:</td>
									<td align="left"><%=standardname%></td>
								</tr>
								<tr height=20>
									<td class=tablebold align="left"><%=bundle.getString("label.exam.templatetype")%></td>
									<td class=tablebold align="left">:</td>
									<td align="left"><%=templatetype%></td>
								</tr>
								 <tr height="20">
									<td class="tablebold" valign='top'><%=bundle.getString("label.exam.subjectname")%> - <%=bundle.getString("label.common.subjectcode")%></td>
									<td class="tablebold" valign='top'>:</td>
									<td class='tablelight' valign='top'>
										<select  name='subject' id='subject' validate="Subject Name" onChange="changeSubject()">
											<option>- Select Subject Name -</option>
											<%
												if(subjectlist != null && subjectlist.size()>0)
												for(int i=0;i<subjectlist.size();i++)
												{
													hashmap	= (HashMap)subjectlist.get(i);
													if(subjectid != null && subjectid.equals((String)hashmap.get("subjectscheduleid")))
														out.print("<option selected value='"+hashmap.get("subjectscheduleid")+"' >"+hashmap.get("subjectname")+"</option>");
													else
														out.print("<option value='"+hashmap.get("subjectscheduleid")+"' >"+hashmap.get("subjectname")+"</option>");
														
												}
											%>
										</select>
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
				            <th scope="col" class="rounded-company" 		width="99%"><%=bundle.getString("label.exam.existingtemplates")%></th>
				            <th scope="col" class="rounded-q4" 		width="1%"></th>
				        </tr>
				    </thead>
				    <tr>
				    	<td colspan='2'>						
							<table width='100%' align='center' border='0' cellpadding='5'>
								 <tr height="20">
									<td class="tablebold" width='18%'  valign='top'><%=bundle.getString("label.exam.existingtemplate")%></td>
									<td class="tablebold" width='1%'   valign='top'>:</td>
									<td class='tablelight' colspan='4' valign='top'>
										<select name='enames' id='enames' size='5' class=tablelight onclick='startTransaction("loadexisting")'>
											<option>-Select Template-</option>
											<%
											if(existingList != null && existingList.size()>0)
												for(int i=0;i<existingList.size();i++)
												{
													hashmap	= (HashMap)existingList.get(i);
													out.print("<option value='"+hashmap.get("qsid")+"' >"+hashmap.get("examname")+"</option>");
												}
											%>
										</select>	
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
				            <th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.exam.templatedetails")%></th>
				            <th scope="col" class="rounded-q4" 		width="1%"></th>
				        </tr>
				    </thead>
				    <tr>
				    	<td colspan='2'>						
							<table width='100%' align='center' border='0' cellpadding='5'>
								<tr height="20">
									<td class="tablebold" width='18%'><%=bundle.getString("label.exam.lessonname")%></td>
									<td class="tablebold" width='1%'>:</td>
									<td class='tablelight' colspan='4'>
										<select name="lesson" id="lesson" validate="Lesson Name" onChange="startTransaction('questiontype')">
								 			<option selected>Select Lesson</option>
											<%
												if(lessonList != null && lessonList.size()>0)
												for(int i=0;i<lessonList.size();i++)
												{
													hashmap	= (HashMap)lessonList.get(i);
													out.print("<option value='"+hashmap.get("lessonid")+"' >"+hashmap.get("lessonname")+"</option>");
												}
											%>
								 			
								 	 	</select>
								 	 </td>
								 </tr>
								<tr height="20">
									<td class="tablebold" width='18%'><%=bundle.getString("label.exam.questiontype")%></td>
									<td class="tablebold" width='1%'>:</td>
									<td class='tablelight'>
										<select name='questiontype' id='questiontype' validate="Question Type" onChange="startTransaction('dfactor')">
											<option>Select Type</option>
										</select>
									</td>
									<td class="tablebold" width='18%'><%=bundle.getString("label.exam.difficultyfactor")%></td>
									<td class="tablebold" width='1%'>:</td>
									<td class='tablelight' >
										<select name="dfactor" id='dfactor' validate="Difficulty Factor" onChange="startTransaction('examtype')">
								    		<option selected>Select DF</option>
								    	</select>					
									</td>
								</tr>
								<tr height="20">
									<td class="tablebold" width='18%'><%=bundle.getString("label.exam.examtype")%></td>
									<td class="tablebold" width='1%'>:</td>
									<td class='tablelight' colspan='4'>
								 	  	<select name="examtype" id='examtype' validate="Exam Type" onchange="startTransaction('mark')">
									   		 <option>Select ExamType</option>
									    </select>
									</td>
								 </tr>
								<tr height="20">
									<td class="tablebold" width='18%'><%=bundle.getString("label.exam.mark")%></td>
									<td class="tablebold" width='1%'>:</td>
									<td class='tablelight' >
										<select name='mark' id='mark' validate="Mark" class=tablelight  onChange="startTransaction('noofquestion')">
									    	<option>Select Mark</option>
									    </select>
									    <span id=tmrk class=tablelight></span>
									</td>
									<td class="tablebold" width='18%'><%=bundle.getString("label.exam.noofquestion")%></td>
									<td class="tablebold" width='1%'>:</td>
								 	<td class='tablelight' >
								 		<select name="noofquestion" id="noofquestion" validate="No of Question" class=tablelight >
								  			<option>Select No. of Question</option>
								    	</select>
								    </td>
								</tr>
								<tr height="30">
									<td class="tablebold" width='18%'><%=bundle.getString("label.exam.totalquestion")%></td>
									<td class="tablebold" width='1%'>:</td>
									<td class='tablelight'><font color=darkcyan class=tablebold><span id='totalquestion'>0</span></font></td>
									<td class="tablebold" width='18%'><%=bundle.getString("label.exam.availablequestion")%></td>
									<td class="tablebold" width='1%'>:</td>
									<td class='tablelight'><font color=darkcyan class=tablebold><span id=availablequestion>0</span></font></td>
								</tr>
								<tr height="30">
									<td class="tablebold" colspan='6'>
										<a href="#" class="bt_blue" onclick='addDirectValue()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.exam.addnext")%></strong><span class="bt_blue_r"></span></a>
									</td>
								</tr>
								
							</table>
						</td>
					</tr>
				</table>
				<br>
				
				<table  border='0'  width="100%" id='templatetable' style='display:none' cellspacing='0' cellpadding='0'>
					<tr height='28'>
						<td class='tablebold' width='20%'><%=bundle.getString("label.exam.dynamictemplatename")%></td>
				    	<td class='tablebold' width='1%'>:</td>
				    	<td class='tablebold'><font color=red><span id='exam_name' class=tablebold></span></font></td>
					</tr>
				</table>
				<br>
				<table border='1' width="100%" id="qnTab"  	style='display:none' cellspacing='0' cellpadding='5'>
			    	<tr class='tableheading' height='30'>
			        	<th scope="col" class="rounded-company" 	width="5%"><%=bundle.getString("label.exam.check")%></th>
			            <th scope="col" class="rounded" 			width="40%"><%=bundle.getString("label.exam.lesson")%></th>
			            <th scope="col" class="rounded" 			width="10%"><%=bundle.getString("label.exam.type")%></th>
			            <th scope="col" class="rounded" 			width="10%"><%=bundle.getString("label.exam.df")%></th>
			            <th scope="col" class="rounded" 			width="15%"><%=bundle.getString("label.exam.noofquestion")%></th>
			            <th scope="col" class="rounded" 			width="10%"><%=bundle.getString("label.exam.markperqn")%></th>
			            <th scope="col" class="rounded-q4" 			width="10%"><%=bundle.getString("label.exam.totalmark")%></th>
			        </tr>
			    </table>
			    <br>
				<table border=0 width="100%" id="marktable"  		style='display:none' cellspacing='0' cellpadding='5'>
					<tr height='28'>
						<td class='tablebold' width='20%'><%=bundle.getString("label.exam.selectedquestion")%></td>
				    	<td class='tablebold' width='1%'>:</td>
				    	<td class='tablebold'><font color=red class=tablebold><span id='SelQn'>0</span></font> </td>
						<td class='tablebold' width='20%'><%=bundle.getString("label.exam.totalmarks")%></td>
				    	<td class='tablebold' width='1%'>:</td>
				    	<td class='tablebold'><font color=red><span class=tablebold id='SelMk'>0</span></font></td>
					</tr>
				</table>

				
				<table border=0 id=hideTab>
					<tr>
						<td>&nbsp;</td>
					</tr>
				</table>
				
				<a href="#" class="bt_blue" onclick='callBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.exam.back")%></strong><span class="bt_blue_r"></span></a>
				<a href="#" id="savebut"  class="bt_green" onclick='submitQuestion()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.exam.submit")%></strong><span class="bt_green_r"></span></a>

				<input type='hidden' name='examname' 			value='<%=examname%>'>
				<input type='hidden' name='yearname' 			value='<%=sessionname%>'>
				<input type='hidden' name='standardname' 		value='<%=standardname%>'>
				<input type='hidden' name='exam' 				value='<%=examid%>'>
				<input type='hidden' name='boardname' 			value='<%=boardname%>'>
				<input type='hidden' name='academicyear' 		value='<%=sessionid%>'>
				<input type='hidden' name='standard' 			value='<%=standardid%>'>		
				<input type='hidden' name='templatetype' 		value='<%=templatetype%>'>
				<input type='hidden' name="description"         value=''>
				<input type='hidden' name="templateno"          value='<%=templateno%>'>
				
		</form>		


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>