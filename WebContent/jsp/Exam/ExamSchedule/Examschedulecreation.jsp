<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Exam Schedule List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
	var count	= 0;
	
	function loadBoard()
	{
		document.Schedule_Form.reg_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.submit(); 
	}
	 
	function loadExam()
	{
		document.Schedule_Form.reg_boardid.value  = document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		document.Schedule_Form.reg_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.reg_examid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.submit();
	}

	function loadStandard()
	{
		document.Schedule_Form.reg_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.reg_boardid.value  = document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		document.Schedule_Form.reg_examid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.submit();
	}
	function loadSubjects()
	{
		document.Schedule_Form.reg_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.reg_boardid.value  = document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		document.Schedule_Form.reg_examid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.reg_standardschid.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].value;	
		
		
		document.Schedule_Form.submit();
	}
	function checkCount(obj)
	{
		var pos	= obj.getAttribute("pos");
		var schedPosSplit;
		
		//alert("pos-->"+pos);
		//var values=document.forms["Schedule_Form"].elements["starts"];
		//alert("values-->"+values[pos].value);
		
		var scheddateArr = document.Schedule_Form.schedDates.value.split("@");
		//alert(scheddateArr[1])
		//alert(document.Schedule_Form.schedPos.value)
		if(document.Schedule_Form.schedPos.value != ""){
			//alert(document.Schedule_Form.schedPos.value)
			var schedPosArr = document.Schedule_Form.schedPos.value.split("@");
		//alert(schedPosArr[1]);
		for(var schedPosCount=1;schedPosCount<=(schedPosArr.length-1);schedPosCount++)
		{
		//alert("schedPosCount-->"+schedPosCount)
			schedPosSplit  = schedPosArr[schedPosCount];
		//alert("schedPosSplit-->"+schedPosSplit)
		//alert(document.Schedule_Form.starts[schedPosSplit].value+"=="+document.Schedule_Form.starts[pos].value);	
			if(document.Schedule_Form.starts[schedPosSplit].value==document.Schedule_Form.starts[pos].value)
			{
				alert("Already Scheduled for the Same Date");
				obj.checked = false;
				count++;
			}		
		}
		
		//alert("schedPosArr'len-->"+schedPosArr.length)
		}	
		
		for(var examDateCount=0;examDateCount<document.Schedule_Form.starts.length;examDateCount++)
		{
		//alert("examDateCount-->"+examDateCount+"checked-->"+document.Schedule_Form.checkstandard[examDateCount].checked)
			if(examDateCount!=pos && document.Schedule_Form.starts[examDateCount].value!=""){
			//alert("examDateCount1-->"+examDateCount+"document.Schedule_Form.starts[examDateCount].checked-->"+document.Schedule_Form.starts[examDateCount].checked);
				if(document.Schedule_Form.checkstandard[examDateCount].checked){
				//alert("examDateCountPos1-->"+examDateCount+"examDateCountFlag"+document.Schedule_Form.starts[examDateCount].checked);
				//alert(document.Schedule_Form.starts[examDateCount].value+"--"+document.Schedule_Form.starts[pos].value)
				if(document.Schedule_Form.starts[examDateCount].value==document.Schedule_Form.starts[pos].value)
				{
					alert("Already Checked for the Same Date");
					obj.checked = false;
					count++;
				}
				}
			}
		}
		
		
		if(obj.checked)
		{
		//alert(document.Schedule_Form.starttime[pos].value);
			if(check_ForParticularElements(document.Schedule_Form.starts[pos],"text",document.Schedule_Form.starttime[pos],"text",document.Schedule_Form.endtime[pos],"text")){
					count++;
			}
			else
				obj.checked = false;
		}
		else
		{
			count--;
		}
		//alert(count)
		
	}
	
	function publishStandard()
	{
	var checkCount = 0;
	
				for(var i=0;i<document.Schedule_Form.checkstandard.length;i++)
				{
					if(document.Schedule_Form.checkstandard[i].checked)
					{
					checkCount++;
					}
				}
		//if(count>0)

		if(checkCount>0)
			{
				for(var i=0;i<document.Schedule_Form.checkstandard.length;i++)
				{
					if(!document.Schedule_Form.checkstandard[i].checked)
					{
						document.Schedule_Form.starts[i].disabled 		= true;
						document.Schedule_Form.starttime[i].disabled 	= true;
						document.Schedule_Form.endtime[i].disabled 		= true;
						document.Schedule_Form.duration[i].disabled 	= true;	
						document.Schedule_Form.reg_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value;					
						
					}
					else
					{
						checkCount++;
					}

				}

					if(confirm("Do you want to schedule the Exam?")){
						document.Schedule_Form.action = "ExamscheduleSubmit.jsp";
						document.Schedule_Form.submit();
			}
			else
			{
			alert("Please select subjects to publish");			
			}
	}
	function selectallfun()
	{
		if(document.Schedule_Form.checkstandard.length == null)
			{
				document.Schedule_Form.checkstandard.checked=true;
			}
			else
			{
				for(var x=0;x<document.Schedule_Form.checkstandard.length;x++)
					{
						document.Schedule_Form.checkstandard[x].checked=true;
					}
			}
	}
	function deselectallfun()
	{
		if(document.Schedule_Form.checkstandard.length == null)
			{
				document.Schedule_Form.checkstandard.checked=false;
			}
		else
			{
				for(var x=0;x<document.Schedule_Form.checkstandard.length;x++)
					{
						document.Schedule_Form.checkstandard[x].checked=false;
					}
			}
	}
function validateTimeEntry(start_time_entry,end_time_entry)
{
     setFlag = check_ForEmpty(start_time_entry.value);

      if(setFlag)
       {
	 setFlag = check_TimeEntry(start_time_entry.value,"Start");
	 if(setFlag)
	 {
           // for valid start time format

           setFlag = check_ForEmpty(end_time_entry.value);

           if(setFlag)
           {
               // for valid start time format and un checked endtime
	       setFlag = check_TimeEntry(end_time_entry.value,"End");

		 if(setFlag)
		 {

		    // for valid end time format
		    // to check if endtime > starttime
		    var stime_str=start_time_entry.value.toString();
		    var etime_str=end_time_entry.value.toString();
		    var stime=stime_str.split(":");
		    var etime=etime_str.split(":");
		    stime=new Number(stime[0]+stime[1]);
		    etime=new Number(etime[0]+etime[1]);


		    if(etime > stime)

		    {
		    // if the start time and end time is valid by all means
		      setDuration = true;
		      end_time_entry.disabled = true;
		      end_time_entry.className="tablehead_disabled"
		      start_time_entry.disabled = true;
		      start_time_entry.className="tablehead_disabled"
		    }
		    else
		        {
		        // if endtime < starttime

		           end_time_entry.focus();
		           end_time_entry.value = "";
		           setDuration = false;
		           alert(" The end time is not negotiable with the start time ! ");

		         }

		 }
		 else // if invalid time format
		 {
	       	     if(setFlag != 0)


	     	     end_time_entry.value = "";
	     	     end_time_entry.focus();
	             setDuration = false;
	             alert("Invalid time format");
		 }
	     }
	     else
	     {
		end_time_entry.focus();
		setDuration = false;
		alert("Empty end time is not allowed");
	     }
	 }
	 else
	 {
	     if(setFlag != 0)
	       alert("Invalid date format");

	     end_time_entry.value = "";
	     start_time_entry.value = "";
	     start_time_entry.focus();
	     setDuration = false;
	 }
     }
     else
     {
	 end_time_entry.value = "";
	 start_time_entry.focus();
	 setDuration = false;
	 alert("Empty start time is not allowed");
     }
   return setDuration;
}
function editSchedule()
{

		document.Schedule_Form.req_sessionid.value  	= document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.req_sessionname.value  	= document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].text
		document.Schedule_Form.req_boardid.value  		= document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		document.Schedule_Form.req_boardname.value  	= document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].text;
		document.Schedule_Form.req_examnameid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.req_examname.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].text;
		document.Schedule_Form.req_standardscheduleid.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].value;
		document.Schedule_Form.standardnamegp.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].text;
	
	if(confirm("Do you want to Edit the Scheduled Exam...?")){
		document.Schedule_Form.action = "ExamScheduleUpdate.jsp";
		document.Schedule_Form.submit();
	}

}

function trashSchedule()
{
		document.Schedule_Form.req_sessionid.value  	= document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.req_sessionname.value  	= document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].text
		document.Schedule_Form.req_boardid.value  		= document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		document.Schedule_Form.req_boardname.value  	= document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].text;
		document.Schedule_Form.req_examnameid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.req_examname.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].text;
		document.Schedule_Form.req_standardscheduleid.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].value;
		document.Schedule_Form.standardnamegp.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].text;
	
	if(confirm("Do you want to Trash the Scheduled Exam...?")){
		document.Schedule_Form.action = "ExamScheduleTrash.jsp";
		document.Schedule_Form.submit();
	}

}
	
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2>Exam / Exam Schedule</h2>
<form name="Schedule_Form" action="" method="post">
	<input type=hidden name=reg_sessionid />
    <input type=hidden name=reg_boardid />
    <input type=hidden name=reg_boardname />
    <input type=hidden name=reg_examid />
    <input type=hidden name=reg_examname />
    <input type=hidden name=reg_standardschid />
    	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    		<tr>
        		<th scope="col" class="rounded-company" width="10"></th>
            	<th scope="col" class="rounded" width="100%">Exam Schedule</th>
            	<th scope="col" class="rounded-q4" width="10"></th>        
        	</tr>
    	</thead>
       

<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime"%>

<%
		com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
		String instituteid = null;
		ArrayList BoardList=null;
		instituteid			= (String)session.getValue("instituteid");
		ArrayList academicList 		= examQuery.loadAcademicYear(instituteid);
		
		if(request.getParameter("req_sessionid") != null && request.getParameter("req_sessionid") != "00")
				BoardList = examQuery.LoadBoardList(instituteid);
		
		HashMap	hashmap				= null;
		HashMap	hashmap1			= null;
		String req_subjectscheduleid="";
		ArrayList ExamList=null;
		ArrayList standardList=null;
		ArrayList subjectList=null;
		ArrayList subjectscheduleList=null;
		String standardscheduleid	= null;
		String subjectscheduleid=null;
		String stdschid="";
		String today	= DateTime.showTime("calendar");
		int count	= 0;
		String reg_sessionid 	= null;
		String reg_boardid=null;
		String reg_examid=null;
		String req_standardscheduleid=null;
		String reg_standardschid=null;
		String examallotmentid=null;
try{
		if(request.getParameter("reg_sessionid") == null)
		{
			
		}
		else if(request.getParameter("reg_sessionid") != null && request.getParameter("reg_boardid") != null  )
		{
			//String reg_coursepubid = request.getParameter("reg_coursepubid_hidden"); 
			 reg_sessionid = request.getParameter("reg_sessionid");
			reg_boardid = request.getParameter("reg_boardid");
			reg_examid = request.getParameter("reg_examid");
			//standardList = examQuery.listStandard(reg_sessionid,reg_boardid);
			standardList = examQuery.listStandardforexam(reg_sessionid,reg_boardid,reg_examid);
			//out.println("standardList>>>>"+standardList);
			ExamList=examQuery.LoadAllotedExamnameList(reg_sessionid);
			//System.out.println("ExamList-->"+ExamList+"req_sessionid-->"+reg_sessionid);
			
		}
				 			
	    else if(request.getParameter("reg_standardschid") != null)
	    {
	    	
			//System.out.println("subjectList>>>"+subjectList);
	    }
		
}catch(Exception e){}
			
%>
			
		<table width='100%' align='center' id="rounded-corner1" border='0' >
			<tr height='23'>
		<td class=tablebold>Academic Year<font color="red">*</font></td><td>
					<select name=sessionname class=tablelight onchange=loadBoard()>
						<option value="00">-Select Academic-</option>
						<%
							for(int s=0;s<academicList.size();s++)
							{
								HashMap map=(HashMap)academicList.get(s);
								String sessionid=(String)map.get("sessionid");
								String yearofsession=(String)map.get("sessionname");
								if(request.getParameter("reg_sessionid") != null)
								{
									if(request.getParameter("reg_sessionid").equals(sessionid))
										out.println("<option selected value='"+sessionid+"'>"+yearofsession+"</option>");
									else
										out.println("<option value='"+sessionid+"'>"+yearofsession+"</option>");
								}
								else
								{
									out.println("<option value='"+sessionid+"'>"+yearofsession+"</option>");
								}
							}
						%>
					</select>
				</td>

		<td class=tablebold>Board <font color="red">*</font></td>
				<td>
					<select name=boardname class=tablelight onchange=loadExam()>
						<option value="00">-Select Board-</option>
						<%
					      	if(BoardList!=null && BoardList.size()>0)
							{
			  		 			for (int i = 0, j = 1; i < BoardList.size(); i++) 
			  		 			{
									HashMap boardListMap=(HashMap)BoardList.get(i);
									String boardId     = (String)boardListMap.get("boardid");
									String boardName      = (String)boardListMap.get("boardname");
									String mediumId      = (String)boardListMap.get("mediumid");
									String mediumName      = (String)boardListMap.get("mediumname");
									//System.out.println("BOARDID-->"+boardId+"<-->"+reg_boardid);
									if(boardId.equals(reg_boardid))
									{
										out.println("<option selected value='"+boardId+"' class=tablelight >"+boardName+"-"+mediumName+"</option>");
									}
									else
									{
										out.println("<option value='"+boardId+"' class=tablelight >"+boardName+"-"+mediumName+"</option>");
									}
									
									//out.println("<option value='"+boardid+"' class=tablelight >"+boardname+"-"+mediumname+"</option>");
						  		 }
							}
						%>
					</select>
				</td>
	</tr>

	<tr height='23'>
				<td class=tablebold>Exam <font color="red">*</font></td>
				<td>
					<select name=examname class=tablelight onchange=loadStandard() >
						<option value="00">-Select Exam Name-</option>
						<%
							
					      	if(ExamList!=null && ExamList.size()>0)
							{
			  		 			for (int i = 0, j = 1; i < ExamList.size(); i++) 
			  		 			{
									HashMap ExamListMap=(HashMap)ExamList.get(i);
									String examId     = (String)ExamListMap.get("examnameid");
									//System.out.println("examId>>>>>>>>>>"+examId);
									String examName      = (String)ExamListMap.get("examname");
									//System.out.println("EXAM ID-->"+examId+"<-->"+reg_examid);
																		
									if(examId.equals(reg_examid))
									{
										out.println("<option selected value='"+examId+"' class=tablelight title='"+examName+"'>"+examName+"</option>");
									}
									else
									{
										out.println("<option value='"+examId+"' class=tablelight title='"+examName+"'>"+examName+"</option>");
									}
						  		 }
							}
						%>
					</select>
				</td>
		
		<td class=tablebold>Standard <font color="red">*</font></td>
				<td><select name=course class=tablelight onchange=loadSubjects() >
					<option value="00">-Select Standard-</option>
					<%
					

						if(standardList !=null && standardList.size() >0)
						{
							for(int s1=0;s1<standardList.size();s1++)
							{
								HashMap map1=(HashMap)standardList.get(s1);
								String standardid=(String)map1.get("standardid");
								String standardname=(String)map1.get("standardname");
								 standardscheduleid=(String)map1.get("standardscheduleid");
								String groupname=(String)map1.get("groupname");
								if(!groupname.equals("NoGroup"))
								{												
									standardname = standardname+" - "+groupname; 
								}
								//System.out.println("standardscheduleid-->"+standardscheduleid);
								//System.out.println("reg_coursepubid-->"+request.getParameter("reg_coursepubid_hidden"));
								if(standardscheduleid.equals(request.getParameter("reg_standardschid")))
								{
									out.println("<option selected value='"+standardscheduleid+"' class=tablelight >"+standardname+"</option>");
								}
								else
								{
									out.println("<option value='"+standardscheduleid+"' class=tablelight >"+standardname+"</option>");
								}
								
								//out.println("<option value='"+standardscheduleid+"'>"+standardname+"</option>");
							}
						}
					%>
					</select>
				</td>
	</tr>
</table>
	         <tfoot>
    	<tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       	</tr>
    	</tfoot>
    	<br>
	

	<!--  <table border=0 cellpadding=3 cellspacing=0 width="100%" align=center>
	<tr><td align=right>
	<a href="#" onclick=selectallfun() class=tablebold>Select All</a> &nbsp;
	<a href="#" onclick=deselectallfun() class=tablebold>Deselect All</a>
	</td></tr>
	</table>-->

		<table width='90%' align='center' border='0' >

			<tr>
				<td width='20%' class='tablebold'>
				
					<table id="rounded-corner" border=0 summary="Subject List" width="80%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="10%">SL No.</th>
					            <th scope="col" class="rounded" 		width="30%">Subject Name</th>
					            <th scope="col" class="rounded" 		width="17%">Exam Date</th>
					            <th scope="col" class="rounded" 		width="10%">Start Time</th>
					            <th scope="col" class="rounded" 		width="10%">End Time</th>
					            <th scope="col" class="rounded" 		width="10%">Duration</th>
					            <th scope="col" class="rounded-q4" 		width="13%">Check</th>
					        </tr>
					    </thead>
					    
				  <tfoot>
				    	<tr>
				        	<td colspan="6" class="rounded-foot-left"><em></em></td>
				        	<td class="rounded-foot-right">&nbsp;</td>
				       	</tr>
				    	</tfoot>					    
					        
		<%
			String scheduledExamDates = "";
			String scheduledExamPubDates = "";
			String scheduledExamPos = "";
			String examScheduleStatus = "";
			String examScheduleHMStatus = "";
			
			String req_sessionname = null;
			int visibleCheck = 0;
		
			reg_standardschid = request.getParameter("reg_standardschid");
    		//subjectList		= examQuery.loadScheduledStandardSubjects(reg_standardschid);
    		subjectList=examQuery.loadScheduledStandardSubjectsforexam(reg_standardschid,reg_examid);
    	   
    		int duration=0;
    		
    		  req_sessionname = request.getParameter("req_sessionname");
    		  String name = req_sessionname;
			  if(subjectList!=null && subjectList.size()>0)
			{
				
				  int inc = 1;
			
			 	for (int i1 = 0; i1 < subjectList.size(); i1++) {
			
				HashMap subjectListMap=(HashMap)subjectList.get(i1);
				String examsubscheduleid     = (String)subjectListMap.get("examsubscheduleid");
				subjectscheduleid     = (String)subjectListMap.get("subjectscheduleid");
				String subjectname      = (String)subjectListMap.get("subjectname");
				String subjectid      = (String)subjectListMap.get("subjectid");
				String standardid      = (String)subjectListMap.get("standardid");
				String examdate      = (String)subjectListMap.get("examdate");
				String examtimein      = (String)subjectListMap.get("examtimein");
				String examtimeout      = (String)subjectListMap.get("examtimeout");
				 examallotmentid      = (String)subjectListMap.get("examallotmentid");
				 //out.println("examallotmentid>>>>>>"+examallotmentid);
				
				if(examdate == null){
					examdate= " ";}
				if(examtimein == null){
					examtimein= " ";}
				if(examtimeout == null){
					examtimeout= " ";}
				if(subjectListMap.get("examtimein") != null && subjectListMap.get("examtimeout")!=null)
					duration = Integer.parseInt((String)subjectListMap.get("examtimeout"))-Integer.parseInt((String)subjectListMap.get("examtimein"));
				
		 		//out.println("duration>>>"+duration);
					
	if(examsubscheduleid != null)
	{
		examScheduleStatus = (String)subjectListMap.get("examschedulestatus");
		if(examScheduleStatus.equals("A")){
			examScheduleHMStatus = "Published";
			scheduledExamPubDates = scheduledExamPubDates+"@"+examdate;
		}
		else{
			examScheduleHMStatus = "-";
		}
			
		out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td>"+examdate+"<input type='hidden' readonly name='starts' validate='Exam Date' size='11' value='"+examdate+"' /></td><td>"+examtimein+"<input type ='hidden' readonly  size='5' name='starttime' maxlength='5' validate='Start Time' value='"+examtimein+"'/></td><td>"+examtimeout+"<input type ='hidden' readonly name='endtime' maxlength='5' size='5' validate='End Time' value='"+examtimeout+"'/></td><td>"+duration+"<input type ='hidden' size='5' validate='Duration' maxlength='5' name='duration' value='"+duration+"'/></td><td>"+examScheduleHMStatus+"<input type='checkbox' name='checkstandard' pos='"+count+"' value='"+subjectscheduleid+"' style='visibility:hidden'></td></tr>");
		//out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td>"+examdate+"</td><td>"+examtimein+"</td><td>"+examtimeout+"</td><td>"+duration+"</td><td>-<input type='checkbox' name='checkstandard' pos='"+count+"' value='"+subjectscheduleid+"' style='visibility:hidden'></td></tr>");
		scheduledExamDates = scheduledExamDates+"@"+examdate;
		scheduledExamPos  = scheduledExamPos+"@"+i1;
	}
	else
		{
		out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td><input type='text' validate='Exam Date' name='starts' size='11' value='' onfocus='this.blur()'><input type='button' name='' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.starts["+(count)+"]','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)></td><td><input type ='text' name='starttime' size='5' maxlength='5' validate='Start Time'></td><td><input type ='text' name='endtime' maxlength='5' size='5' validate='End Time' ></td><td><input type ='text' name='duration' size='5' validate='Duration' maxlength='5'></td><td><input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+subjectscheduleid+"'></td><input type=hidden name=exallotid value='"+examallotmentid+"'</tr>");
		visibleCheck++;																																																																																																																																																																	
		}
	count++;	
	}
		
		}
		  else
			  {
			  out.println("<tr align='center' class='tablebold'><td colspan='9'><font color='red'>Data Not Found</font></td></tr>");
			  //out.println("<tr><td colspan=9 align=center>Data not found</td></tr>");    	 
		   	  }
		%>
		</table>
		</td>
		</tr>
		</table>
		
		<% 

		if(visibleCheck<subjectList.size()){
		%>
						<a href="#" class="bt_red" onclick='trashSchedule()'><span class="bt_red_lft"></span><strong>Trash</strong><span class="bt_red_r"></span></a>
						<a href="#" class="bt_blue" onclick='editSchedule()'><span class="bt_blue_lft"></span><strong>Edit</strong><span class="bt_blue_r"></span></a>
		<%
		}
		if(visibleCheck>0){
		%>
		<a href="#" class="bt_green" onclick='publishStandard()'><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>
		<%
		}
		%>
		<input type='hidden' name='todaydate' 					value='<%=today %>'/>
		<!--  <input type='hidden' name='starts' 			disabled	value='<%=today %>'/>-->
		<input type='hidden' name='schedDates' value='<%=scheduledExamDates%>'/>
		<input type='hidden' name='schedPos' value='<%=scheduledExamPos%>'/>
		<input type='hidden' name='schedPubDates' value='<%=scheduledExamPubDates%>'/>

		
		<input type='hidden' name='req_instituteid'/>
		
		<input type='hidden' name='req_sessionid' />
		<input type='hidden' name='req_sessionname' />
		<input type='hidden' name='req_boardid' />
		<input type='hidden' name='req_boardname' />
		<input type='hidden' name='req_examnameid' />
		<input type='hidden' name='req_examname' />
		<input type='hidden' name='req_standardscheduleid' />
		<input type='hidden' name='standardnamegp' />
	</table>
</form>	
    </div><!-- end of right content-->
	</div>   <!--end of center content -->

   <div class="clear"></div>
   </div> <!--end of main content-->
<%@ include file="../../include/footer.jsp" %>
</div>
</body>
</html>