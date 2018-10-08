<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>igEducation - Online Exam Started Now | Powered by i-Grandee</title>
<style type="text/css">
.tablelight{font-family:"Arial",Times,arial;font-size:10pt;font-style:normal;}
.tablebold{font-family:"Arial",Arial,arial;font-size:10pt;font-weight:bold;}
.tableheading{font-family:"Arial",Arial,arial;font-size:10pt;font-weight:bold;background-color: #60c8f2;}
</style>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/xmlhttpobject.js"></script>
<script type="text/javascript">

	function loadAnswerDetails()
	{
		var qsid	= document.exam_form.qsid.value;
		var req		= initRequest();
		var url		= "<%=request.getContextPath()%>/ResultServlet?action=loadAnswerDetails&qsid="+qsid;
	
		req.onreadystatechange = function() // Callback function
		{
			document.getElementById("Loading").style.visibility = "visible"
			if (req.readyState == 4)
			{
				document.getElementById("Loading").style.visibility = "hidden";
				var rootObject	= req.responseXML.getElementsByTagName("result");
				var cNode_1		= rootObject[0].childNodes.length;
	
				if(cNode_1>0)
				{
					var incvalue				= 1;
					var totmark					= 0;
					var answeredQustion			= 0;
					var notAnsweredQuestion		= 0;
					var correctAnswerQuestion	= 0;
					var percent					= 0;
					
					for(var i=0;i<parseInt(cNode_1);i++)
					{
						var questionid		= rootObject[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
						var questionname	= rootObject[0].childNodes.item(i).childNodes.item(1).firstChild.nodeValue;
						var correctanswer	= rootObject[0].childNodes.item(i).childNodes.item(2).firstChild.nodeValue;
						var mark			= rootObject[0].childNodes.item(i).childNodes.item(3).firstChild.nodeValue;
						var youranswer		= rootObject[0].childNodes.item(i).childNodes.item(4).firstChild.nodeValue;

						if(correctanswer!=null && correctanswer!="-")
						{
							correctanswer	= correctanswer.toUpperCase();
						}

						if(youranswer!=null && youranswer!="-")
						{
							youranswer		= youranswer.toUpperCase();
							answeredQustion	= answeredQustion+1;
							if(youranswer==correctanswer)
							{
								correctAnswerQuestion	= correctAnswerQuestion+1;
							}
						}
						else
						{
							notAnsweredQuestion	= notAnsweredQuestion+1;
						}
	
						var tbody 	= document.createElement("tbody");
						tr			= document.createElement("tr");
						if(incvalue%2==0)
							tr.bgColor="white";
						else
							tr.bgColor="#f4f4f4";
							
						tr.height="22";
	
						td=document.createElement("td");
						td.className="tablelight";
						td.align="left";
						td.innerHTML=""+incvalue+".";
						tr.appendChild(td);

						td=document.createElement("td");
						td.className="tablelight";
						td.align="left";
						td.innerHTML=""+questionname+".";
						tr.appendChild(td);

						td=document.createElement("td");
						td.className="tablelight";
						td.innerHTML=""+correctanswer+" &nbsp;/&nbsp;"+mark+"";
						tr.appendChild(td);

						td=document.createElement("td");
						td.className="tablelight";

						if(correctanswer==youranswer)
						{

							td.innerHTML=""+youranswer+"&nbsp;/&nbsp;"+mark+"";
						}
						else
						{
							td.innerHTML=""+youranswer+"&nbsp;/&nbsp;0";

						}

						tr.appendChild(td);
						tbody.appendChild(tr);
						document.getElementById("answerTable").appendChild(tbody);
						incvalue++;
						totmark=totmark+parseInt(mark);
						percent=((correctAnswerQuestion*100)/totmark);
	
					}
	
					var percent = Math.round(percent);
					document.getElementById("examtotal").innerHTML		= ""+cNode_1+"";
					document.getElementById("totmark").innerHTML		= ""+totmark+"";
					document.getElementById("attended").innerHTML		= ""+answeredQustion+"";
					document.getElementById("notAttended").innerHTML	= ""+notAnsweredQuestion+"";
					document.getElementById("obtainmark").innerHTML		= ""+correctAnswerQuestion+"";
					document.getElementById("percent").innerHTML		= ""+percent+"%";
					//resultFun(percent);
	
					var score		= parseInt(percent,10);
					//document.getElementById("score").innerHTML=""+score+"%";
					var passmark	= document.exam_form.passmark.value;
					
					var tbody 		= document.createElement("tbody");
					tr				= document.createElement("tr");
					tr.height		= "20";
					obtmarkval 		= document.getElementById("obtainmark");
	
					for(var x=0;x<100;x++)
					{
						if(score>=x)
						{
							td=document.createElement("td");
							td.height="20";

							if(parseInt(obtmarkval.firstChild.nodeValue)>=passmark)
							{
								td.bgColor="#00ff00";
								tr.appendChild(td);
							}
							else
							{
								td.bgColor="#ff0000";
							}
						}
						else
						{
							td=document.createElement("td");
							td.bgColor="white";
							tr.appendChild(td);
						}
					}

					tbody.appendChild(tr);
					//document.getElementById("bgTable").appendChild(tbody);
				}
			}
		}
		req.open("GET", url, true);
		req.send(null);
	}
	
	function doSomething(e) {
		
		var code;
		if (!e) var e = window.event;
		if (e.keyCode) code = e.keyCode;
		else if (e.which) code = e.which;
	
		var character = String.fromCharCode(code);

		 if(code == 8)
			 {
			 	if(window.event != null)
			 	{
					window.event.keyCode 	= 505;
					event.cancelBubble		= true;
					event.returnValue		= false;
	
				}
				else
				{
					e.preventDefault();
				 }
				 				 return false;
	
			 }
			 else if(code == 116)
			 {
	
				 if(window.event != null)
				 {
					 window.event.keyCode 	= 505;
					 event.cancelBubble		= true;
					 event.returnValue		= false;
	
				 }else
				 {
					e.preventDefault();
	
			 	}return false;
		 }
		 else if(code == 117)
	 	{
	
	 			 if(window.event != null)
	 			 {
	 				 window.event.keyCode 	= 505;
	 				 event.cancelBubble		= true;
	 				 event.returnValue		= false;
	
	 			 }else
	 			 {
	 				e.preventDefault();
	
	 		 	}return false;
	 	 }
		 else if(code == 114)
	 	{
	
	 			 if(window.event != null)
	 			 {
	 				 window.event.keyCode 	= 505;
	 				 event.cancelBubble		= true;
	 				 event.returnValue		= false;
	
	 			 }else
	 			 {
	 				e.preventDefault();
	
	 		 	}return false;
	 	 } else if(code == 13)
	 	{
	
	 			 if(window.event != null)
	 			 {
	 				 window.event.keyCode 	= 505;
	 				 event.cancelBubble		= true;
	 				 event.returnValue		= false;
	
	 			 }else
	 			 {
	 				e.preventDefault();
	
	 		 	}return false;
	 	 }
	 	 else if(code == 32)
		  	{
	
		  			 if(window.event != null)
		  			 {
		  				 window.event.keyCode 	= 505;
		  				 event.cancelBubble		= true;
		  				 event.returnValue		= false;
	
		  			 }else
		  			 {
		  				e.preventDefault();
	
		  		 	}return false;
	 	 }else if(code == 122)
		  	{
	
		  			 if(window.event != null)
		  			 {
		  				 window.event.keyCode 	= 505;
		  				 event.cancelBubble		= true;
		  				 event.returnValue		= false;
	
		  			 }else
		  			 {
		  				e.preventDefault();
	
		  		 	}return false;
	 	 }
	
	}		
	
	function disableselect(e){
		return false
	}

	function reEnable()
	{
		return true
	}

	//if IE4+
	document.onselectstart=new Function ("return false")
	document.oncontextmenu=new Function ("return false")
	
	//if NS6
	if (window.sidebar){
		document.onmousedown=disableselect
		document.onclick=reEnable
	}

</script>
</head>
<body onLoad='loadAnswerDetails()'  onkeyup='doSomething(event)'  onkeydown='doSomething(event)' onkeypress='doSomething(event)'>
<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,java.text.NumberFormat,java.util.Locale,com.iGrandee.ExamManagement.OnlineExam" %>
<form name="exam_form" action="" method="post">
		
	<table width='100%' height='100%' border='1' cellspacing='0' cellpadding='5'>
		<tr><td class='tablebold'><h2><%=session.getValue("institutename")%></h2></td></tr>
		<tr><td class='tablebold' align='right'>Welcome <%=session.getValue("prefix")%> <%=session.getValue("userfullname") %>, | Role : Student | <a href="#cls" onclick='window.close()' class="logout">Close</a></td></tr>
		<tr class='tableheading' height='25'><td>Online Exam</td></tr>
		<tr>
			<td valign='middle' align='center'>
			<br><br>
			
			<%
			
				try{
			    	
			    	if(session.getValue("userid") == null){
						 out.print("<script>window.opener.location.replace('"+request.getContextPath()+"/jsp/Student/OnlineExamNew.jsp');window.close();</script>");
			    	}
			    }catch(Exception e){
					 out.print("<script>window.opener.location.replace('"+request.getContextPath()+"/jsp/Student/OnlineExamNew.jsp');window.close();</script>");
			    }
		    
				String studentid 			= (String)session.getValue("studentid");
				String qsid					= request.getParameter("qsid");
				String examname				= request.getParameter("examname");
				String examdate				= request.getParameter("createddate");
				String duration				= request.getParameter("duration");
				String subjectname			= request.getParameter("subjectname");
				String rcause				= request.getParameter("rcause");
			%>
		
				<table border='1' summary="Exam Details" width='90%' cellpadding='5' cellspacing='0'>
			    	<tr>  
			        	<th class="tableheading" width='100%' align='center'>Exam Details</th>
			        </tr>
			     	<tr>
			     		<td>
			     			<table border='0' width='100%' cellpadding="6" cellspacing="0">
			     				<tr>
			     					<td width='20%' class='tablebold' align='left' >Subjct Name</td>
			     					<td width='1%' 	class='tablebold' align='left' >:</td>
			     					<td width='79%' class='tablelight' colspan='4' align='left' ><%=subjectname%></td>
			     				</tr>
			     				<tr>
			     					<td width='20%' class='tablebold' align='left' >Exam Name</td>
			     					<td width='1%' 	class='tablebold' align='left' >:</td>
			     					<td width='79%' class='tablelight' colspan='4' align='left' ><%=examname%></td>
			     				</tr>
			     				<tr>
			     					<td width='20%' class='tablebold'  align='left' >Created Date</td>
			     					<td width='1%' 	class='tablebold'  align='left' >:</td>
			     					<td width='29%' class='tablelight' align='left' ><%=examdate%></td>
			     					<td width='25%' class='tablebold'  align='left' >Duration</td>
			     					<td width='1%' 	class='tablebold'  align='left' >:</td>
			     					<td width='24%' class='tablelight' align='left' ><%=duration%></td>
			     				</tr>
			     				<tr>
			     					<td width='20%' class='tablebold' align='left' >Total Question</td>
			     					<td width='1%' 	class='tablebold' align='left' >:</td>
			     					<td width='29%' class='tablelight' align='left' ><span id='examtotal'></span></td>
			     					<td width='25%' class='tablebold' align='left' >Total Mark</td>
			     					<td width='1%' 	class='tablebold' align='left' >:</td>
			     					<td width='24%' class='tablelight' align='left' ><span id='totmark'></span></td>
			     				</tr>
			     				<tr>
			     					<td width='20%' class='tablebold' align='left' >Question Attended</td>
			     					<td width='1%' 	class='tablebold' align='left' >:</td>
			     					<td width='29%' class='tablelight' align='left' ><span id='attended'></span></td>
			     					<td width='25%' class='tablebold' align='left' >Question Not Attended</td>
			     					<td width='1%' 	class='tablebold' align='left' >:</td>
			     					<td width='24%' class='tablelight' align='left' ><span id='notAttended'></span></td>
			     				</tr>
			     				<tr>
			     					<td width='20%' class='tablebold' align='left' >Mark Scored</td>
			     					<td width='1%' 	class='tablebold' align='left' >:</td>
			     					<td width='29%' class='tablelight' align='left' ><span id='obtainmark'></span></td>
			     					<td width='25%' class='tablebold' align='left' >Percentage</td>
			     					<td width='1%' 	class='tablebold' align='left' >:</td>
			     					<td width='24%' class='tablelight' align='left' ><span id='percent'></span></td>
			     				</tr>
			     			</table>
			     		</td>
			     	</tr>
			 	</table>
			 	
			 	<%
			 		if(rcause != null && !rcause.equals("") && !rcause.equalsIgnoreCase("null")){
				%>			 
				<br>			
				<table border='1' summary="Exam Details" width='90%' cellpadding='5' cellspacing='0'>
			    	<tr>  
			        	<th class="tableheading" width='100%' align='center'><font color='red'><%=rcause%></font></th>
			        </tr>
			     </table>			 	
			     <%		
			 		}
			 	%>
			 	
			 	
			 	<br>
			 	<span id="Loading" style="visibility:hidden" valign="bottom" class="loading">&nbsp; Loading...</span>
			 	
				<table border='1' summary="Questions" width='90%'	cellpadding='5' cellspacing='0'>
			    	<tr>  
			        	<th class="tableheading" width='100%' align=center>Answer Details</th>
			        </tr>
			     	<tr>
			     		<td>
			     			<table width='100%' cellpadding="5" cellspacing="0" id='answerTable'>
								<tr>
									<td class='tablebold' width="05%" align="left">Sl.No</td>
									<td class='tablebold' width="65%" align="left">Question</td>
									<td class='tablebold' width="15%" align="left">Correct Answer / Mark</td>
									<td class='tablebold' width="15%" align="left">Your Answer / Mark</td>
								</tr>
			     			</table>
			     		</td>
			     	</tr>
			 	</table>			
				<br>
				<table width="100%" cellpadding="4" align="center" cellspacing="0" border="0">
					<tr align="center">
						<td>
							<input type=button class="buttonTab" name="submit1" style="height=25; width=120;" value="Close" onClick="window.close()">
						</td>
					</tr>
				</table>
				
			</td>
		</tr>
	</table>
	

	 	
	 	<input type='hidden' name='qsid' 				value='<%=qsid %>'/>
		<input type='hidden' name='passmark' 			value='0'/>
		
		
	</form>
	
</body>
</html>		