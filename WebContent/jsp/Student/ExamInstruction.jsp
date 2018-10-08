<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>igEducation - Online Exam Started Now | Powered by i-Grandee</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/xmlhttpobject.js"></script>
<style type="text/css">
.tablelight{font-family:"Arial",Times,arial;font-size:10pt;font-style:normal;}
.tablebold{font-family:"Arial",Arial,arial;font-size:10pt;font-weight:bold;}
.tableheading{font-family:"Arial",Arial,arial;font-size:10pt;font-weight:bold;background-color: #60c8f2;}
</style>
<script type="text/javascript">

	function loadExamInfo()
	{
		var quesId		= document.exam_form.qsid.value;
		var req			= initRequest();
		var url			= "<%=request.getContextPath()%>/OnlineExamServlet?action=loadExamInfo&qsid="+quesId;
		req.onreadystatechange = function()
		{
	
			document.getElementById("Loading").style.visibility = "visible"
	
			if (req.readyState == 4)
			{
				document.getElementById("Loading").style.visibility = "hidden";
				viewFlog2(req.responseXML);
			}
		}
		req.open("GET", url, true);
		req.send(null);
	}

	function viewFlog2(parseXml1)
	{
		parseXml		= parseXml1;
		
		if(parseXml!=null)
		{
			var rootObject=parseXml.getElementsByTagName("examdetails");
			var cNode_2=rootObject[0].childNodes.length;
			
			document.getElementById("datetimespan").innerHTML="Loading";
			
			var examname		= rootObject[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
			var subjectname		= rootObject[0].childNodes.item(0).childNodes.item(1).firstChild.nodeValue;
			var createddate		= rootObject[0].childNodes.item(0).childNodes.item(2).firstChild.nodeValue;
			var instruction		= rootObject[0].childNodes.item(0).childNodes.item(3).firstChild.nodeValue;
			var currentime		= rootObject[0].childNodes.item(0).childNodes.item(4).firstChild.nodeValue;
			var duration		= rootObject[0].childNodes.item(0).childNodes.item(5).firstChild.nodeValue;
			var remaining		= rootObject[0].childNodes.item(0).childNodes.item(6).firstChild.nodeValue;
			var estatus			= rootObject[0].childNodes.item(0).childNodes.item(7).firstChild.nodeValue;
			
			document.exam_form.subjectname.value 	= subjectname;
			document.exam_form.examname.value 		= examname;
			document.exam_form.createddate.value 	= createddate;
			document.exam_form.duration.value 		= duration;
			
			document.getElementById("subjectname1").innerHTML		= subjectname;
			document.getElementById("examname1").innerHTML			= examname;
			document.getElementById("createddate1").innerHTML		= createddate;
			document.getElementById("duration1").innerHTML			= duration;
			document.getElementById("datetimespan").innerHTML		= currentime;
			document.getElementById("instructionTable").innerHTML	= instruction;
			document.exam_form.timeremaining.value					= remaining;
			document.exam_form.estatus.value						= estatus;
			
		}
		getTotalQuestion();
	}

	function getTotalQuestion()
	{
		var quesId		= document.exam_form.qsid.value;
		var req			= initRequest();
		var url			= "<%=request.getContextPath()%>/OnlineExamServlet?action=getTotalQuesCount&qsid="+quesId;
		
		req.onreadystatechange = function()
		{
			document.getElementById("Loading").style.visibility = "visible"

			if (req.readyState == 4)
			{
				document.getElementById("Loading").style.visibility = "hidden"
				viewFlog3(req.responseXML);
			}
		}
		req.open("GET", url, true);
		req.send(null);
	}

	function viewFlog3(parseXml1)
	{
		parseXml	= parseXml1;
		if(parseXml	!= null)
		{
			var rootObject3		= parseXml.getElementsByTagName("countquestion");
			if(rootObject3[0]!=null)
			{
				var cNode_3	= rootObject3[0].childNodes.length;
				if(cNode_3	!= 0)
				{
					var count	= rootObject3[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
					document.exam_form.questiontotal.value	= count;
				}
			}
		}
		
		if(document.exam_form.estatus.value 	== "E"){
			document.exam_form.submit1.value	= "Click here to View Result";
		}
		else{
			document.exam_form.submit1.value	= "Click here to Start Exam";
		} 	
		
		
	}
	
	function goToExam(){
	
		if(document.exam_form.estatus.value == "A"){
			document.exam_form.action	= "<%=request.getContextPath()%>/jsp/Student/StartExam.jsp";
			document.exam_form.submit();
		}
		else{
			document.exam_form.action	= "<%=request.getContextPath()%>/jsp/Student/Result_window.jsp";
			document.exam_form.submit();
		}
	}
	
</script>
</head>
<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,java.text.NumberFormat,java.util.Locale,com.iGrandee.ExamManagement.OnlineExam" %>
<body onLoad='loadExamInfo()'>
<form name="exam_form" action="" method="post">

	<%    
		try{
    	
	    	if(session.getValue("userid") == null){
				 out.print("<script>window.opener.location.replace('"+request.getContextPath()+"/jsp/Student/OnlineExamNew.jsp');window.close();</script>");
	    	}
	    }catch(Exception e){
			 out.print("<script>window.opener.location.replace('"+request.getContextPath()+"/jsp/Student/OnlineExamNew.jsp');window.close();</script>");
	    }
    %>
	<table width='100%' height='100%' border='1' cellspacing='0' cellpadding='5'>
		<tr><td class='tablebold'><h2><%=session.getValue("institutename")%></h2></td></tr>
		<tr><td class='tablebold' align='right'>Welcome <%=session.getValue("prefix")%> <%=session.getValue("userfullname") %>, | Role : Student | <a href="#cls" onclick='window.close()' class="logout">Close</a></td></tr>
		<tr class='tableheading' height='25'><td>Online Exam</td></tr>
		<tr>
			<td valign='middle' align='center'>
			<br><br>
			<%
				String qsid					= request.getParameter("qsid");
			%>
			
				<table border='1' width='90%' cellspacing='0' cellpadding='5'>
			    	<tr class='tableheading'>  
			        	<th class="tablebold" width='100%' align='left'>Exam Details</th>
			        </tr>
			     	<tr>
			     		<td>
			     			<table width='100%' cellpadding="6" cellspacing="0">
			     				<tr>
			     					<td width='15%' class='tablebold' align='left'>Subjct Name</td>
			     					<td width='1%' 	class='tablebold' align='left'>:</td>
			     					<td width='84%' class='tablelight' align='left'><span id='subjectname1'></span></td>
			     				</tr>
			     				<tr>
			     					<td class='tablebold' align='left'>Exam Name</td>
			     					<td class='tablebold' align='left'>:</td>
			     					<td class='tablelight' align='left'><span id='examname1'></span></td>
			     				</tr>
			     				<tr>
			     					<td class='tablebold' align='left'>Created Date</td>
			     					<td class='tablebold' align='left'>:</td>
			     					<td class='tablelight' align='left'><span id='createddate1'></span></td>
			     				</tr>
			     				<tr>
			     					<td class='tablebold' align='left'>Duration</td>
			     					<td class='tablebold' align='left'>:</td>
			     					<td class='tablelight' align='left'><span id='duration1'></span></td>
			     				</tr>
			     				<tr>
			     					<td class='tablebold' align='left'>Current Time</td>
			     					<td class='tablebold' align='left'>:</td>
			     					<td class='tablelight' align='left'><span id='datetimespan'></span></td>
			     				</tr>
			     			</table>
			     		</td>
			     	</tr>
			 	</table>
			 	<br>
				
			 	<span id="Loading" style="visibility:hidden" valign="bottom" class="loading">&nbsp; Loading...</span>

				<table cellpadding="5" cellspacing="0" border='1' width='90%'>
			    	<tr class='tableheading'>  
			        	<th width='100%' align='left'>Points to follow</th>
			        </tr>
			     	<tr>
			     		<td>
			     			<table width='100%' cellpadding="5" cellspacing="0">
			     				<tr>
			     					<td class='tablebold' align='left' valign='top' width='15%'>
			     						Instruction(s)
			     					</td>
			     					<td class='tablebold' align='left' valign='top'  width='1%'>
										:
			     					</td>
			     					<td id='instructionTable' class='tablelight' align='left'>
			     					</td>
			     				</tr>
			     			</table>
			     		</td>
			     	</tr>
			 	</table>	 	
				<br>
				<table width="100%" cellpadding="4" align="center" cellspacing="0" border="0">
					<tr align="center">
						<td>
							<input type=button class="buttonTab" name="submit1" style="height=25; width=120;" value="Click here to Start Exam" onClick="goToExam()">
						</td>
					</tr>
				</table>
		
				<input type='hidden' name='qsid' 			value='<%=qsid%>'/>
				<input type='hidden' name='subjectname' 	value=''/>
				<input type='hidden' name='examname' 		value=''/>
				<input type='hidden' name='createddate'		value=''/>
				<input type='hidden' name='duration'		value=''/>
				<input type='hidden' name='questiontotal'	value=''/>
				<input type='hidden' name='timeremaining'	value=''/>
				<input type='hidden' name='estatus'			value=''/>
				
			</td>
		</tr>
	</table>

	</form>
	
    

</body>
</html>		