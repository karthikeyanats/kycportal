<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Exam Schedule List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
	var count	= 0; 
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
		//var pos	= obj.getAttribute("pos");
		
		
		if(obj.checked)
			count++;
		else
			count--;
		
	}


	
	function publishStandard()
	{
	
		if(count>0)
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
						
				}
				document.Schedule_Form.action = "ExamschedulepublishSubmit.jsp";
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

    <h2>Exam / Exam Publish</h2>
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
            	<th scope="col" class="rounded" width="100%">Exam Publish</th>
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
					<select name=sessionname class=tablelight>
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
										out.println("<option selected value='"+examId+"' class=tablelight >"+examName+"</option>");
									}
									else
									{
										out.println("<option value='"+examId+"' class=tablelight >"+examName+"</option>");
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
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       	</tr>
    	</tfoot>
	<br>
		<table width='90%' align='center' border='0' >
			<tr>
				<td width='20%' class='tablebold'>
				
					<table id="rounded-corner" border=0 summary="Subject List" width="80%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="10%">SL No.</th>
					            <th scope="col" class="rounded" 		width="30%">Subject Name</th>
					            <th scope="col" class="rounded" 		width="20%">Exam Date</th>
					            <th scope="col" class="rounded" 		width="10%">Start Time</th>
					            <th scope="col" class="rounded" 		width="10%">End Time</th>
					            <th scope="col" class="rounded" 		width="10%">Duration</th>
					            <th scope="col" class="rounded-q4" 		width="10%">Check</th>
					        </tr>
					    </thead>
					        
		<%
			reg_standardschid = request.getParameter("reg_standardschid");
    		//subjectList		= examQuery.loadScheduledStandardSubjects(reg_standardschid);
    		subjectList=examQuery.loadScheduledStandardSubjectsforexampublish(reg_standardschid,reg_examid);
    	   
    		int duration=0;
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
			String examschedulestatus      = (String)subjectListMap.get("examschedulestatus");
				
				if(examdate == null){
					examdate= " ";}
				if(examtimein == null){
					examtimein= " ";}
				if(examtimeout == null){
					examtimeout= " ";}
				if(subjectListMap.get("examtimein") != null && subjectListMap.get("examtimeout")!=null)
					duration = Integer.parseInt((String)subjectListMap.get("examtimeout"))-Integer.parseInt((String)subjectListMap.get("examtimein"));
				
		 		//out.println("examschedulestatus>>>"+examschedulestatus);
					
	if((examsubscheduleid != null)&&(examschedulestatus .equals("P")))
	{
		out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td><input type='text' readonly validate='Start Date' size='11' value='"+examdate+"' /></td><td><input type ='text' readonly  size='5' maxlength='4' validate='Start Time' value='"+examtimein+"'/></td><td><input type ='text' readonly maxlength='4' size='5' validate='End Time' value='"+examtimeout+"'/></td><td><input type ='text' size='5' validate='Duration' maxlength='2' value='"+duration+"'/></td><td><input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+subjectscheduleid+"'></td><input type=hidden name=exallotid value='"+examallotmentid+"'></tr>");
	}
	else 
		{
			out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td><input type='text' readonly validate='Start Date' size='11' value='"+examdate+"' /></td><td><input type ='text' readonly  size='5' maxlength='4' validate='Start Time' value='"+examtimein+"'/></td><td><input type ='text' readonly maxlength='4' size='5' validate='End Time' value='"+examtimeout+"'/></td><td><input type ='text' size='5' validate='Duration' maxlength='2' value='"+duration+"'/></td><td>-</td></tr>");
																																																																																																																																																																			
		}
	count++;	
	}
		
		}
		  else
			  {
			  out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
		   		//out.println("<tr><td colspan=7 align=center>Data not found</td></tr>");    	 
		   	  }
		%>
		</table>
		</td>
		</tr>
		</table>
			
		<a href="#" class="bt_blue" onclick='publishStandard()'><span class="bt_blue_lft"></span><strong>Publish</strong><span class="bt_blue_r"></span></a>
		<input type='hidden' name='todaydate' 					value='<%=today %>'/>
		<input type='hidden' name='starts' 			disabled	value='<%=today %>'/>
	
	</table>
</form>	
    </div><!-- end of right content-->
	</div>   <!--end of center content -->

   <div class="clear"></div>
   </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
</div>
</body>
</html>