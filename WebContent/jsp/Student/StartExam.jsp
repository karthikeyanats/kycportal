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

	function loadAnsweredQuestionCount()
	{
		var quesId	= document.exam_form.qsid.value;
		
		var req		= initRequest();
		var date2	= new Date();
	
		var url="<%=request.getContextPath()%>/OnlineExamServlet?action=getPreviousQuestion&quesId="+quesId+"&date2="+date2;
		req.onreadystatechange = function()
		{
			if (req.readyState == 4)
			{
				var rootObject2	= req.responseXML.getElementsByTagName("countquestion");
				var cNode_1		= rootObject2[0].childNodes.length;
				var time		= rootObject2[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
	
				document.exam_form.questionposition.value=time;
				rootFunction();
			}
		}
		req.open("GET", url, true);
		req.send(null);
	}
	
	function rootFunction()
	{
		var qvalue		= document.exam_form.questionposition.value;
		questionvalue	= parseInt(qvalue);
		var qsId		= document.exam_form.qsid.value;
		var req			= initRequest();
		var date3		= new Date();
		
		var url="<%=request.getContextPath()%>/QuestionServlet?action=getQuestions&qsId="+qsId+"&date3="+date3;
		
		req.onreadystatechange = function() // Callback function
		{

			document.getElementById("Loading").style.visibility = "visible"
			if (req.readyState == 4)
			{
				document.getElementById("Loading").style.visibility = "hidden";
				rootObject=req.responseXML.getElementsByTagName("question");
				rootSubFunction(questionvalue);
			}
		}
		req.open("GET", url, true);
		req.send(null);
	}
	
	var rtime		= "";
	var currenttime	= "";
	var timespent	= 0;

	function rootSubFunction()
	{
		var cNode_1		= rootObject[0].childNodes.length;
		totalNode		= cNode_1;
		
		document.getElementById("buttonTable").style.visibility = "hidden"
	
	
		if(cNode_1>0)
		{
	
			if(questionvalue==0)
			{
	
			}
			else
			{
				var tablelength=document.getElementById("questionTable").rows.length;
				for(var i=tablelength-1;i>-1;i--)
				{
					document.getElementById("questionTable").deleteRow(i);
				}
			}
	
			if(questionvalue==parseInt(cNode_1))
			{
				document.exam_form.action ="Result_window.jsp";
				document.exam_form.submit();
			}
	
			var i = questionvalue;
	
			if(i<parseInt(cNode_1))
			{
				var questionid		=		rootObject[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
				document.exam_form.oldqid.value=questionid;
				var questionname	=	rootObject[0].childNodes.item(i).childNodes.item(1).firstChild.nodeValue;
				var optiona			= rootObject[0].childNodes.item(i).childNodes.item(2).firstChild.nodeValue;
				var optionb			= rootObject[0].childNodes.item(i).childNodes.item(3).firstChild.nodeValue;
				var optionc			= rootObject[0].childNodes.item(i).childNodes.item(4).firstChild.nodeValue;
				var optiond			= rootObject[0].childNodes.item(i).childNodes.item(5).firstChild.nodeValue;
				var optione			= rootObject[0].childNodes.item(i).childNodes.item(6).firstChild.nodeValue;
				var optionf			= rootObject[0].childNodes.item(i).childNodes.item(7).firstChild.nodeValue;
				var optiong			= rootObject[0].childNodes.item(i).childNodes.item(8).firstChild.nodeValue;
				var answer			= rootObject[0].childNodes.item(i).childNodes.item(9).firstChild.nodeValue;
				var image			= rootObject[0].childNodes.item(i).childNodes.item(10).firstChild.nodeValue;
				var countans		= rootObject[0].childNodes.item(i).childNodes.item(11).firstChild.nodeValue;
				var timelimit		= rootObject[0].childNodes.item(i).childNodes.item(12).firstChild.nodeValue;
	
	
	
	
				if(timelimit.indexOf(":") == -1)
				{
					document.exam_form.qntime.value="01:00";
					timelimit="01:00";
				}
					document.exam_form.qntime.value=timelimit;
	
	
	
				var mark=			rootObject[0].childNodes.item(i).childNodes.item(13).firstChild.nodeValue;
	
				var examstatus=		rootObject[0].childNodes.item(i).childNodes.item(14).firstChild.nodeValue;
				if(currenttime=="")
				{
					currenttime=	rootObject[0].childNodes.item(i).childNodes.item(14).firstChild.nodeValue;
					document.getElementById("datetimespan").innerHTML=""+currenttime+"";
					window.setInterval("runningTimer()",1000);
				}
	
				//var remainingtime=	"";
	
				//if(rtime=="")
				//{
					//rtime=remainingtime
					//document.getElementById("remtime").innerHTML=""+remainingtime+"";
					//window.setInterval("runningTimer1()",1000);
				//}
	
	
	
				var sno=i+1;
	
	
				//document.getElementById("qnNoSpan").innerHTML=""+sno+"";
				var tbody = document.createElement("tbody");
	
				document.getElementById("dectime").innerHTML=""+timelimit+" <font color=red>Seconds</font>" ;
	
	
				tr=document.createElement("tr");
				tr.className="screentablehead";
	
				td=document.createElement("td");
				td.width="15%";
				td.className="tablebold";
				td.align="left";
				td.innerHTML="Question No :";
				tr.appendChild(td);
	
				td=document.createElement("td");
				td.className="tablelight";
				td.align="left";
				td.innerHTML=""+sno+".";
				td.width="5%";
	
				tr.appendChild(td);
	
				td=document.createElement("td");
				td.className="tablebold";
				td.align="left";
				td.innerHTML=""+questionname+"";
				td.width="";
				tr.appendChild(td);
				tbody.appendChild(tr);
				
				
	
	
				tr=document.createElement("tr");
				td=document.createElement("td");
				td.colSpan="3";
				td.align="left";
				td.className="tablelight";
				td.innerHTML="&nbsp;&nbsp;<input type='checkbox' name=check value='a'>a. "+optiona+"";
				tr.appendChild(td);
				tbody.appendChild(tr);
	
	
				tr=document.createElement("tr");
				td=document.createElement("td");
				td.colSpan="3";
				td.align="left";
				td.className="tablelight";
				td.innerHTML="&nbsp;&nbsp;<input type='checkbox' name=check value='b'>b. "+optionb+"";
				tr.appendChild(td);
				tbody.appendChild(tr);
				
				
				if(countans >=3){
	
					tr=document.createElement("tr");
					td=document.createElement("td");
					td.colSpan="3";
					td.align="left";
					td.className="tablelight";
					td.innerHTML="&nbsp;&nbsp;<input type='checkbox' name=check value='c'>c. "+optionc+"";
					tr.appendChild(td);
					tbody.appendChild(tr);
				}
				
				if(countans >=4){
	
					tr=document.createElement("tr");
					td=document.createElement("td");
					td.colSpan="3";
					td.align="left";
					td.className="tablelight";
					td.innerHTML="&nbsp;&nbsp;<input type='checkbox' name=check value='d'>d. "+optiond+"";
					tr.appendChild(td);
					tbody.appendChild(tr);
				}

				if(countans >=5){
	
					tr=document.createElement("tr");
					td=document.createElement("td");
					td.colSpan="3";
					td.align="left";
					td.className="tablelight";
					td.innerHTML="&nbsp;&nbsp;<input type='checkbox' name=check value='e'>e. "+optione+"";
					tr.appendChild(td);
					tbody.appendChild(tr);
				}
				
				if(countans >=6){
	
					tr=document.createElement("tr");
					td=document.createElement("td");
					td.colSpan="3";
					td.align="left";
					td.className="tablelight";
					td.innerHTML="&nbsp;&nbsp;<input type='checkbox' name=check value='f'>f. "+optionf+"";
					tr.appendChild(td);
					tbody.appendChild(tr);
				}
				
				if(countans >=7){
	
					tr=document.createElement("tr");
					td=document.createElement("td");
					td.colSpan="3";
					td.align="left";
					td.className="tablelight";
					td.innerHTML="&nbsp;&nbsp;<input type='checkbox' name=check value='g'>g. "+optiong+"";
					tr.appendChild(td);
					tbody.appendChild(tr);
				}
				
	
				document.getElementById("questionTable").appendChild(tbody);
	
				document.getElementById("buttonTable").style.visibility = "visible"
	
				questionvalue=parseInt(questionvalue)+1;
				pquestionid=questionid;
	
	
				if(questionvalue==parseInt(cNode_1))
				{
					document.getElementById("buttonTd").innerHTML="<input type=button name=submit1 class=buttonTab style='height=25; width=200;' onClick=resultFun() value='Click Here To View Result'>";
				}
	
				loadTime();
				timespent	= 0;
				start1 = window.setInterval("DecrementTime()",1000);
	
			}
		}
	}


	function resultFun()
	{
		var questionsheetid	= document.exam_form.qsid.value;
		var answervalues	= "";
			
		if(document.exam_form.check)
		{
			var checklength=document.exam_form.check.length;
			if(checklength!=undefined)
			{
				if(checklength>0)
				{
					var strArray=new Array();
					for(var i=0;i<checklength;i++)
					{
						if(document.exam_form.check[i].checked)
						{
							answervalues+=document.exam_form.check[i].value;
						}
					}
				}
			}
		}
	
		if(insertAnswer==4)
		{
			totalAnswers	= totalAnswers+answervalues+"@";
			totalQuestions	= totalQuestions+pquestionid+"@";
			totalTimes		= totalTimes+timespent+"@";
			document.forms[0].submit1.disabled = true
			document.getElementById("sendTable").style.visibility = "visible"
			document.getElementById("questionTable").style.visibility = "hidden";
			var req1		= initRequest();
			var date4		= new Date();
			var url			= "<%=request.getContextPath()%>/QuestionServlet?action=insertAnswerBatch&qsId="+questionsheetid+"&questionid="+totalQuestions+"&answer="+totalAnswers+"&date4="+date4+"&attempt="+document.exam_form.cattempt.value;
	
			req1.onreadystatechange = function() // Callback function
			{
				if (req1.readyState == 4)
				{
					document.getElementById("sendTable").style.visibility = "hidden";
					document.getElementById("questionTable").style.visibility = "visible";
					document.forms[0].submit1.disabled = false;
					if(req1.responseXML!=null)
					{
						var rootObj=req1.responseXML.getElementsByTagName("result");
						if(req1.status == 200)
						{
							var cNode_1=rootObj[0].childNodes.length;
							if(cNode_1>0)
							{
								submitFun();
							}
							else
							{
								alert("The remote host or network may be down.  Please try the request again.");
								window.close();
							}
						}
						else
						{
							alert("The remote host or network may be down.  Please try the request again.");
							window.close();
						}
					}
					else
					{
						alert("The remote host or network may be down.  Please try the request again.");
						window.close();
					}
				}
			}

			req1.open("GET", url, true);
			req1.send(null);

		}
		else
		{
			if(questionvalue==parseInt(totalNode))
			{
				totalAnswers	= totalAnswers+answervalues+"@";
				totalQuestions	= totalQuestions+pquestionid+"@";
				totalTimes		= totalTimes+timespent+"@";
				document.forms[0].submit1.disabled = true;
				document.getElementById("sendTable").style.visibility = "visible"
				document.getElementById("questionTable").style.visibility = "hidden";
				var req1		= initRequest();
				var date5		= new Date();
				var url			= "<%=request.getContextPath()%>/QuestionServlet?action=insertAnswerBatch&qsId="+questionsheetid+"&questionid="+totalQuestions+"&answer="+totalAnswers+"&date5="+date5+"&attempt="+document.exam_form.cattempt.value;
	
				req1.onreadystatechange = function() // Callback function
				{
					if (req1.readyState == 4)
					{
						document.getElementById("sendTable").style.visibility = "hidden";
						document.getElementById("questionTable").style.visibility = "visible";
						document.forms[0].submit1.disabled = false;
						if(req1.responseXML!=null)
						{
							var rootObj=req1.responseXML.getElementsByTagName("result");

							if(req1.status == 200)
							{
								var cNode_1=rootObj[0].childNodes.length;

								if(cNode_1>0)
								{
									submitFun();
								}
								else
								{
									alert("The remote host or network may be down.  Please try the request again.");
									window.close();
								}

							}
							else
							{
								alert("The remote host or network may be down.  Please try the request again.");
								window.close();

							}
						}
						else
						{
							alert("The remote host or network may be down.  Please try the request again.");
							window.close();
						}
					}
				}
				req1.open("GET", url, true);
				req1.send(null);
			}
			else
			{
				insertAnswer=insertAnswer+1;
				totalAnswers=totalAnswers+answervalues+"@";
				totalQuestions=totalQuestions+pquestionid+"@";
				rootSubFunction(questionvalue);
			}
		}
	}

	function submitFun()
	{
		document.exam_form.action ="Result_window.jsp";
		document.exam_form.submit();
	}

	var logoutAnswers	= "";
	var logoutQuestions	= "";
	
	function logout()
	{
		document.exam_form.questionposition.value 	= parseInt(document.exam_form.questionposition.value,10)+1;
		var questionsheetid	= document.exam_form.qsid.value;
		
		var answervalues	= "";
			
		if(document.exam_form.check)
		{
			var checklength=document.exam_form.check.length;
			if(checklength!=undefined)
			{
				if(checklength>0)
				{
					var strArray=new Array();
					for(var i=0;i<checklength;i++)
					{
						if(document.exam_form.check[i].checked)
						{
							answervalues+=document.exam_form.check[i].value;
						}
					}
				}
			}
		}
		
		totalAnswers	= totalAnswers+answervalues;
		totalQuestions	= totalQuestions+pquestionid;
		totalTimes		= totalTimes+timespent;
		document.forms[0].submit1.disabled = true
		document.getElementById("sendTable").style.visibility = "hidden"
		document.getElementById("questionTable").style.visibility = "hidden";
		var req				= initRequest();
		var date7			= new Date();
		var url				= "<%=request.getContextPath()%>/QuestionServlet?action=insertAnswerBatch&qsId="+questionsheetid+"&questionid="+totalQuestions+"&answer="+totalAnswers+"&date7="+date7+"&attempt="+document.exam_form.cattempt.value;
	
		req.onreadystatechange = function() // Callback function
		{
			if (req.readyState == 4)
			{
				document.getElementById("sendTable").style.visibility = "hidden";
				document.forms[0].submit1.disabled = false;
				window.close();
			}
		}
		req.open("GET", url, true);
		req.send(null);
	}

	function runningTimer()
	{
		var spanvalue		= document.getElementById("datetimespan");
		var datetimevalue="";
	
		if (navigator.appName == "Microsoft Internet Explorer")
		{
			 datetimevalue	= document.getElementById("datetimespan").innerText;
	
		}
		else if (navigator.appName == "Netscape")
		{
			 datetimevalue	= document.getElementById("datetimespan").textContent;
		}
	
		var datevalue		= datetimevalue.substring(0,datetimevalue.indexOf(" "));
		var timevalue		= datetimevalue.substring(datetimevalue.lastIndexOf(" "));
		var arr				= timevalue.split(":");
	
		var hrs=arr[0];
		var mins=arr[1];
		var secs=arr[2];
	
		if(hrs=="00"){hrs="0";}
		if(hrs=="09"){hrs="9";}
		if(hrs=="08"){hrs="8";}
		if(hrs=="07"){hrs="7";}
		if(hrs=="06"){hrs="6";}
		if(hrs=="05"){hrs="5";}
		if(hrs=="04"){hrs="4";}
		if(hrs=="03"){hrs="3";}
		if(hrs=="02"){hrs="2";}
		if(hrs=="01"){hrs="1";}
	
		if(mins=="00"){mins="0";}
		if(mins=="09"){mins="9";}
		if(mins=="08"){mins="8";}
		if(mins=="07"){mins="7";}
		if(mins=="06"){mins="6";}
		if(mins=="05"){mins="5";}
		if(mins=="04"){mins="4";}
		if(mins=="03"){mins="3";}
		if(mins=="02"){mins="2";}
		if(mins=="01"){mins="1";}
	
		if(secs=="00"){secs="0";}
		if(secs=="09"){secs="9";}
		if(secs=="08"){secs="8";}
		if(secs=="07"){secs="7";}
		if(secs=="06"){secs="6";}
		if(secs=="05"){secs="5";}
		if(secs=="04"){secs="4";}
		if(secs=="03"){secs="3";}
		if(secs=="02"){secs="2";}
		if(secs=="01"){secs="1";}
	
		var hr=parseInt(hrs,10);
		var min=parseInt(mins,10);
		var sec=parseInt(secs,10);
	
		sec++;
		if(sec>=60)
		{
			sec=0;
			min++;
			if(min>=60)
			{
				min=0;
				hr++;
				if(hr>=23)
				{
					hr=0;
				}
			}
		}
	
		if(hr==0){hrs="00";}
		else if(hr==1){hrs="01";}
		else if(hr==2){hrs="02";}
		else if(hr==3){hrs="03";}
		else if(hr==4){hrs="04";}
		else if(hr==5){hrs="05";}
		else if(hr==6){hrs="06";}
		else if(hr==7){hrs="07";}
		else if(hr==8){hrs="08";}
		else if(hr==9){hrs="09";}
		else{hrs=hr;}
	
		if(min==0){mins="00";}
		else if(min==1){mins="01";}
		else if(min==2){mins="02";}
		else if(min==3){mins="03";}
		else if(min==4){mins="04";}
		else if(min==5){mins="05";}
		else if(min==6){mins="06";}
		else if(min==7){mins="07";}
		else if(min==8){mins="08";}
		else if(min==9){mins="09";}
		else{mins=min;}
	
		if(sec==0){secs="00";}
		else if(sec==1){secs="01";}
		else if(sec==2){secs="02";}
		else if(sec==3){secs="03";}
		else if(sec==4){secs="04";}
		else if(sec==5){secs="05";}
		else if(sec==6){secs="06";}
		else if(sec==7){secs="07";}
		else if(sec==8){secs="08";}
		else if(sec==9){secs="09";}
		else{secs=sec;}
	
		if(isNaN(hrs))
		{
			TimerDate	= datevalue+" "+hrs+":"+mins+":"+secs;
		}
		else
		{
			TimerDate			= datevalue+" "+hrs+":"+mins+":"+secs;
			spanvalue.innerHTML	= TimerDate;
		}
	}
	
	function loadTime()
	{
	  hrs1 = "00";
	  min  = 59;
	
	  timelim  = document.exam_form.qntime.value.split(":");
	  min      = timelim[0];
	  secd     = timelim[1];
	  qnMin    = timelim[0];
	  qnSec    = timelim[1];
	
	  var newDate = new Date();
	  cur_Dat     = newDate.getDate();
	  cur_Year    = newDate.getFullYear();
	
	 	switch(cur_Dat)
	 	{
	 		case 1:
	 			cur_Dat='01'
	 			break;
	 		 case 2:
	 			cur_Dat='02'
	 			break;
	 		case 3:
	 			cur_Dat='03'
	 			break;
	 		case 4:
	 			cur_Dat='04'
	 			break;
	 		case 5:
	 			cur_Dat='05'
	 			break;
	 		case 6:
	 			cur_Dat='06'
	 			break;
	 		case 7:
	 			cur_Dat='07'
	 			break;
	 		case 8:
	 			cur_Dat='08'
	 			break;
	 		case 9:
	 			cur_Dat='09'
	 			break;
	 	}
	 	strMonth = new String(newDate);
	 	cur_Month = strMonth.substring(4,7);
	}

	function DecrementTime()
	{
		  timespent++;
		  dec = true;
		  decTarget = true;
	
		  if(secd==undefined)
		  {
			  secd="";
		  }
	
		  window.status = hrs1+":"+min+":"+secd;
	
		 if(isNaN(secd))
		 {
			 //alert("SSS");
		 }
		 else
		 {
			if(min!="")
			{
	
		  		document.getElementById("dectime").innerHTML = min+":"+secd+"&nbsp;<font color=red>Seconds</font>";
			}
	  	 }
	
	
		   if(hrs1=="00" && min=="00" && secd == "20" || hrs1=="00" && min=="00" && secd == "15" || hrs1=="00" && min=="00" && secd == "10" ||  hrs1=="00" && min=="00" && secd == "05")
		    {
	
		       document.getElementById("alerting").innerHTML = "<a class=subheadCol><b>"+parseInt(secd,10)+"</b></a><a class=subhead> <font color=darkcyan>seconds remaining</font> </a><font color=red size=4> !!! </font>";
	 		 }
	 		 else
	 		 {
				 document.getElementById("alerting").innerHTML = "";
			 }
	
		  if(secd > 0)
		  {
			   secd--;
		  }
	
		 if((parseInt(min,10) >= 1) && (secd == "00"))
		 {
		      secd = 59;
		   	  min--;
		 }
		 if(secd == "00")
		 {
			 if(min=="00" && secd=="00")
			 {
				callNextQuestion(questionvalue);
			 }
			 window.status = hrs1+":"+min+":"+secd+"0";
		 }
	
	  if(parseInt(secd,10) <=9)
	  {
		 if(secd.length >= 2)
	     {
			 secd = secd;
		 }
		 else
		 	secd = "0"+secd;
	 }
	
	  if(parseInt(min,10) <= 9)
	  {
		  if(min.length >= 2)
		  {
		  }
		  else
	    	min = "0"+min;
	  }
	}

	function callNextFun()
	{
	   dec       = false;
	   decTarget = false;
	}
	
	var insertAnswer	= 0;
	var totalAnswers	= "";
	var totalQuestions	= "";
	var totalTimes		= "";
	timespent
	
	function callNextQuestion()
	{
		window.clearInterval(start1);
	
		document.exam_form.questionposition.value = parseInt(document.exam_form.questionposition.value,10)+1;
		var questionsheetid=document.exam_form.qsid.value;
	
	
			var answervalues="";
	
			if(document.exam_form.check)
			{
				var checklength=document.exam_form.check.length;
	
				if(checklength!=undefined)
				{
					if(checklength>0)
					{
	
						var strArray=new Array();
						var flag=false;
	
						for(var i=0;i<checklength;i++)
						{
							if(document.exam_form.check[i].checked)
							{
								flag=true;
								answervalues+=document.exam_form.check[i].value+",";
	
							}
	
						}
						if(answervalues.length>1)
							answervalues = answervalues.substring(0,answervalues.length-1)
	
						if(!flag)
						{
							answervalues+="-";
						}
					}
				}
			}
	
			if(insertAnswer==4)
			{
				totalAnswers	= totalAnswers+answervalues+"@";
				totalQuestions	= totalQuestions+pquestionid+"@";
				totalTimes		= totalTimes+timespent+"@";
				document.forms[0].submit1.disabled = true;
				document.getElementById("sendTable").style.visibility = "visible";
				document.getElementById("questionTable").style.visibility = "hidden";
				var req			= initRequest();
				var date1		= new Date();
				var url			= "<%=request.getContextPath()%>/QuestionServlet?action=insertAnswerBatch&qsId="+questionsheetid+"&questionid="+totalQuestions+"&answer="+totalAnswers+"&date1="+date1+"&attempt="+document.exam_form.cattempt.value;
	
				req.onreadystatechange = function() // Callback function
				{
	
					if (req.readyState == 4)
					{
						document.getElementById("sendTable").style.visibility = "hidden";
						document.getElementById("questionTable").style.visibility = "visible";
						document.forms[0].submit1.disabled = false;
	
	
						totalAnswers	= "";
						totalQuestions	= "";
	
						if(req.responseXML!=null)
						{
	
	
							var rootObj=req.responseXML.getElementsByTagName("exam");
	
							if (req.status == 200)
							{
	
								var cNode_1=rootObj[0].childNodes.length;
	
								if(cNode_1>0)
								{
									var result=		rootObj[0].childNodes.item(0).firstChild.nodeValue;
	
									if(result=="Inserted")
									{
										rootSubFunction(questionvalue);
										insertAnswer=0;
									}
									else
									{
										alert("The remote host or network may be down.  Please try the request again.");
										window.close();
									}
								}
							}
							else
							{
								alert("The remote host or network may be down.  Please try the request again.");
								window.close();
							}
						}
						else
						{
							alert("The remote host or network may be down.  Please try the request again.");
							window.close();
						}
					}
				}
	
				req.open("GET", url, true);
				req.send(null);
	
			}
			else
			{
				insertAnswer=insertAnswer+1;
				totalAnswers=totalAnswers+answervalues+"@";
				totalQuestions=totalQuestions+pquestionid+"@";
				logoutAnswers=totalAnswers;
				logoutQuestions=totalQuestions
				rootSubFunction(questionvalue);
			}
	}
	
	function startTimer(){
	
		window.setInterval("remainingTimer()",1000);
		
	}
	
	function remainingTimer(){
	
		var spanvalue		= document.getElementById("remtimespan");
		var timevalue		= "";
	
		if (navigator.appName == "Microsoft Internet Explorer")
			 timevalue	= document.getElementById("remtimespan").innerText;
		else if (navigator.appName == "Netscape")
			 timevalue	= document.getElementById("remtimespan").textContent;

		var arr				= timevalue.split(":");
	
		var hrs				= arr[0];
		var mins			= arr[1];
		var secs			= arr[2];
		
	
		if(hrs=="00"){hrs="0";}
		if(hrs=="09"){hrs="9";}
		if(hrs=="08"){hrs="8";}
		if(hrs=="07"){hrs="7";}
		if(hrs=="06"){hrs="6";}
		if(hrs=="05"){hrs="5";}
		if(hrs=="04"){hrs="4";}
		if(hrs=="03"){hrs="3";}
		if(hrs=="02"){hrs="2";}
		if(hrs=="01"){hrs="1";}
	
		if(mins=="00"){mins="0";}
		if(mins=="09"){mins="9";}
		if(mins=="08"){mins="8";}
		if(mins=="07"){mins="7";}
		if(mins=="06"){mins="6";}
		if(mins=="05"){mins="5";}
		if(mins=="04"){mins="4";}
		if(mins=="03"){mins="3";}
		if(mins=="02"){mins="2";}
		if(mins=="01"){mins="1";}
	
		if(secs=="00"){secs="0";}
		if(secs=="09"){secs="9";}
		if(secs=="08"){secs="8";}
		if(secs=="07"){secs="7";}
		if(secs=="06"){secs="6";}
		if(secs=="05"){secs="5";}
		if(secs=="04"){secs="4";}
		if(secs=="03"){secs="3";}
		if(secs=="02"){secs="2";}
		if(secs=="01"){secs="1";}
	
		var hr=parseInt(hrs,10);
		var min=parseInt(mins,10);
		var sec=parseInt(secs,10);
	
		sec--;
		if(sec<=0)
		{
			if(min>0 || hr>0)
				sec=59;
			else
				sec=0;
				
			min--;
			if(min<=0)
			{
				if(hr>0)
					min=59;
				else
					min=0;
			
				hr--;
				if(hr<=0)
				{
					hr=0;
				}
			}
		}
	
		if(hr==0){hrs="00";}
		else if(hr==1){hrs="01";}
		else if(hr==2){hrs="02";}
		else if(hr==3){hrs="03";}
		else if(hr==4){hrs="04";}
		else if(hr==5){hrs="05";}
		else if(hr==6){hrs="06";}
		else if(hr==7){hrs="07";}
		else if(hr==8){hrs="08";}
		else if(hr==9){hrs="09";}
		else{hrs=hr;}
	
		if(min==0){mins="00";}
		else if(min==1){mins="01";}
		else if(min==2){mins="02";}
		else if(min==3){mins="03";}
		else if(min==4){mins="04";}
		else if(min==5){mins="05";}
		else if(min==6){mins="06";}
		else if(min==7){mins="07";}
		else if(min==8){mins="08";}
		else if(min==9){mins="09";}
		else{mins=min;}
	
		if(sec==0){secs="00";}
		else if(sec==1){secs="01";}
		else if(sec==2){secs="02";}
		else if(sec==3){secs="03";}
		else if(sec==4){secs="04";}
		else if(sec==5){secs="05";}
		else if(sec==6){secs="06";}
		else if(sec==7){secs="07";}
		else if(sec==8){secs="08";}
		else if(sec==9){secs="09";}
		else{secs=sec;}
	
		
		TimerDate			= hrs+":"+mins+":"+secs;
		spanvalue.innerHTML	= TimerDate;
		
		if(TimerDate == "00:00:00"){
			
			document.exam_form.action	= "<%=request.getContextPath()%>/jsp/Student/Result_window.jsp";
			document.exam_form.submit();
		}
	}
	
</script>
</head>
<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,java.text.NumberFormat,java.util.Locale,com.iGrandee.ExamManagement.OnlineExam" %>
<body onLoad='loadAnsweredQuestionCount();startTimer()' margintop='0' bottommargin='0' rightmargin='0' leftmargin='0' oncontextmenu window.event.returnValue false  onkeyup='doSomething(event)'  onkeydown='doSomething(event)' onkeypress='doSomething(event)'>
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
		<tr><td class='tablebold' align='right'>Welcome <%=session.getValue("prefix")%> <%=session.getValue("userfullname") %>, | Role : Student | <a href="#cls" onclick='logout()' class="logout">Close</a></td></tr>
		<tr class='tableheading' height='25'><td>Online Exam</td></tr>
		<tr>
			<td valign='middle' align='center'>
			<br><br>
			<%
				
				String studentid 		= (String)session.getValue("studentid");
				OnlineExam onlineexam	= new OnlineExam();
				HashMap hashmap			= null;
				String qsid				= request.getParameter("qsid");
				String examname			= request.getParameter("examname");
				String examdate			= request.getParameter("createddate");
				String duration			= request.getParameter("duration");
				String subjectname		= request.getParameter("subjectname");
				String cattempt			= request.getParameter("cattempt");
				String timespent		= request.getParameter("timespent");
				String timeremaining	= request.getParameter("timeremaining");
								
				

			
			%>
			
				<table border='1' width='90%' cellspacing='0' cellpadding='5'>
			    	<tr class='tableheading'>  
			        	<th class="tablebold" width='100%' align='left'>Exam Details</th>
			        </tr>
			     	<tr>
			     		<td>
			     			<table width='100%' cellpadding="6" cellspacing="0">
			     				<tr>
			     					<td width='15%' class='tablebold'  align='left'>Subject Name</td>
			     					<td width='1%' 	class='tablebold'  align='left'>:</td>
			     					<td width='84%' class='tablelight' align='left'><%=subjectname%></td>
			     				</tr>
			     				<tr>
			     					<td class='tablebold'  align='left'>Exam Name</td>
			     					<td class='tablebold'  align='left'>:</td>
			     					<td class='tablelight' align='left'><%=examname%></td>
			     				</tr>
			     				<tr>
			     					<td class='tablebold'  align='left'>Created Date</td>
			     					<td class='tablebold'  align='left'>:</td>
			     					<td class='tablelight' align='left'><%=examdate%></td>
			     				</tr>
			     				<tr>
			     					<td class='tablebold'  align='left'>Duration</td>
			     					<td class='tablebold'  align='left'>:</td>
			     					<td class='tablelight' align='left'><%=duration%></td>
			     				</tr>
			     				<tr>
			     					<td class='tablebold'  align='left'>Remaining Time</td>
			     					<td class='tablebold'  align='left'>:</td>
			     					<td class='tablelight' align='left'><span id='remtimespan'><%=timeremaining%></span></td>
			     				</tr>
			     				<tr>
			     					<td class='tablebold'  align='left'>Current Time</td>
			     					<td class='tablebold'  align='left'>:</td>
			     					<td class='tablelight' align='left'><span id='datetimespan'></span></td>
			     				</tr>
			     				<tr>
			     					<td class='tablebold'  align='left'>Question Time</td>
			     					<td class='tablebold'  align='left'>:</td>
			     					<td class='tablelight' align='left'><span id='dectime'></span></td>
			     				</tr>
			     			</table>
			     		</td>
			     	</tr>
			 	</table>
			 	<br>
				
			 	<span id="Loading" style="visibility:hidden" valign="bottom" class="loading">&nbsp; Loading...</span>
			 	<!-- <span id="qnNoSpan" class="loading"></span> -->
			 	<span id="alerting" class="loading"></span>
			 	
				<table cellpadding="5" cellspacing="0" border='1' width='90%'>
			    	<tr class='tableheading'>  
			        	<th width='100%' align='left'>Question</th>
			        </tr>
			     	<tr>
			     		<td>
			     			<table width='100%' cellpadding="5" cellspacing="0" id='questionTable'>
			     			</table>
			     		</td>
			     	</tr>
			 	</table>	 	
				<br>
				
				<span id="sendTable" class="tablebold" style="visibility:hidden"><font color=green>Sending Data  .......</font></span><br>
				<table id="buttonTable" style="visibility:hidden" width="100%" cellpadding="4" align="center" cellspacing="0" border="0">
					<tr align="center">
						<td id="buttonTd">
							<input type=button class="tablelight" name="submit1" style="height=25; width=120;" value="Next Question" onClick="callNextQuestion()">
						</td>
					</tr>
				</table>
		
				<input type='hidden' name='qsid' 				value='<%=qsid%>'/>
				<input type='hidden' name='subjectname' 		value='<%=subjectname%>'/>
				<input type='hidden' name='examname' 			value='<%=examname%>'/>
				<input type='hidden' name='createddate'			value='<%=examdate%>'/>
				<input type='hidden' name='duration'			value='<%=duration%>'/>
				<input type='hidden' name='questionposition' 	value=''/>
				<input type='hidden' name='oldqid' 				value=''/>
				<input type='hidden' name='qntime'				value=''/>
				<input type='hidden' name='cattempt'			value='<%=cattempt%>'/>
				<input type='hidden' name='timespent'			value='<%=timespent%>'/>
				<input type='hidden' name='timeremaining'		value='<%=timeremaining%>'/>
			
			</td>
		</tr>
	</table>

	</form>
	
    

</body>
</html>		