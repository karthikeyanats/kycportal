<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Exam Publish | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
	var count	= 0; 
	function loadExam()
	{
		document.Schedule_Form.req_boardid.value  = document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		//document.Schedule_Form.req_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.req_examnameid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.submit();
	}

	function loadStandard()
	{
		//document.Schedule_Form.req_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.req_boardid.value  = document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		document.Schedule_Form.req_examnameid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.submit();
	}
	function loadSubjects()
	{
		//document.Schedule_Form.req_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.req_boardid.value  = document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		document.Schedule_Form.req_examnameid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.req_standardscheduleid.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].value;	
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
			document.Schedule_Form.req_boardid.value  = document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
			document.Schedule_Form.req_examnameid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
			document.Schedule_Form.req_standardscheduleid.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].value;	
			document.Schedule_Form.req_boardname.value  = document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].text;
			document.Schedule_Form.req_examname.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].text;
			document.Schedule_Form.standardnamegp.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].text;	
			
				if(confirm("Are you sure want to Publish the Selected Subject(s)?"))
				{
					document.Schedule_Form.action = "ExamschedulepublishSubmit.jsp";
					document.Schedule_Form.submit();
				}
			}
			else
			{
			alert("Please select subjects to publish");			
			}
	}
	
	function trashPublishView(){
			if(check_ForParticularElements(document.Schedule_Form.boardname,"select",document.Schedule_Form.examname,"select",document.Schedule_Form.course,"select")){
			document.Schedule_Form.req_boardid.value  = document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
			document.Schedule_Form.req_examnameid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
			document.Schedule_Form.req_standardscheduleid.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].value;	
			document.Schedule_Form.req_boardname.value  = document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].text;
			document.Schedule_Form.req_examname.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].text;
			document.Schedule_Form.standardnamegp.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].text;	

		document.Schedule_Form.action = "ExamPublishTrash.jsp";
		document.Schedule_Form.submit();
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

	function statusChangeSchedule(obj)
	{
			if(count>0)
			{
				if(confirm("Are you sure want to Publish the Scheduled Subject(s)?"))
				{
					document.Schedule_Form.action = "ExamschedulepublishSubmit.jsp";
					document.Schedule_Form.submit();
				}
			}
			else
			{
			alert("Please select subjects to publish");			
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

	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>
    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("hmlabel.exampublish.rootpath")%></h2>
<form name="Schedule_Form" action="" method="post">
	<input type=hidden name=req_sessionid value=<%=session.getValue("sessionid")%>>
    <input type=hidden name=req_boardid />
    <input type=hidden name=req_boardname />
    <input type=hidden name=req_examnameid />
    <input type=hidden name=req_examname />
    <input type=hidden name=req_standardscheduleid />
	<input type=hidden name=standardnamegp />
       
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
		String req_sessionid 	= null;
		String req_boardid=null;
		String req_examnameid=null;
		String req_standardscheduleid=null;
		//String req_standardscheduleid=null;
		String examallotmentid=null;
try{
		if(request.getParameter("req_sessionid") == null)
		{
			
		}
		else if(request.getParameter("req_sessionid") != null && request.getParameter("req_boardid") != null  )
		{
			//String req_coursepubid = request.getParameter("req_coursepubid_hidden"); 
			 req_sessionid = request.getParameter("req_sessionid");
			req_boardid = request.getParameter("req_boardid");
			req_examnameid = request.getParameter("req_examnameid");
			//standardList = examQuery.listStandard(req_sessionid,req_boardid);
			standardList = examQuery.listStandardforexam(req_sessionid,req_boardid,req_examnameid);
			//out.println("standardList>>>>"+standardList);
			ExamList=examQuery.LoadAllotedExamnameList(req_sessionid);
			//System.out.println("ExamList-->"+ExamList+"req_sessionid-->"+req_sessionid);
			
		}
				 			
	    else if(request.getParameter("req_standardscheduleid") != null)
	    {
	    	
			//System.out.println("subjectList>>>"+subjectList);
	    }
		
}catch(Exception e){}
			
%>

	
		<table id="rounded-corner" border=0 width="100%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="80%"><%=bundle.getString("hmlabel.exampublishtrash.exampublish")%> </th>
		            <th scope="col" class="rounded-q4" width="20%"><font color=red>*</font> <%=bundle.getString("label.common.mandatory") %></th>        
		        </tr>
		    </thead>
		    
		        <tfoot>
		    	<tr>
		        	<td class="rounded-foot-left"><em></em></td>
		        	<td class="rounded-foot-right">&nbsp;</td>
		       </tr>
		    </tfoot>
		
		<br>
		
		<tr><td colspan="2"><table border=0 align=center id="rounded-corner1" width="100%">
		<tr>
			<td class=tablebold width="25%"><%=bundle.getString("hmlabel.exampublishtrash.academicyear")%> </td>
			<td width='1%' class='tablebold'>:</td>
			
			<td>
			<%=session.getValue("sessionname")%>	
			</td>

				<td class=tablebold><%=bundle.getString("hmlabel.exampublishtrash.board")%> <font color=red> *</font></td>
				<td width='1%' class='tablebold'>:</td>
				
					<td><select name=boardname validate='Board Name' class=tablelight onchange=loadExam()>
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
										//System.out.println("BOARDID-->"+boardId+"<-->"+req_boardid);
										if(boardId.equals(req_boardid))
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
						</select></td>
		</tr>
		<tr>
			<td class=tablebold width="25%"><%=bundle.getString("hmlabel.exampublishtrash.examname")%><font color=red> *</font></td>
					    			<td width='1%' class='tablebold'>:</td>
			
			<td>	
					<select name=examname validate='Exam Name' class=tablelight onchange=loadStandard() >
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
									//System.out.println("EXAM ID-->"+examId+"<-->"+req_examnameid);
																		
									if(examId.equals(req_examnameid))
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
					</select></td>
		
			<td class=tablebold width="25%"><%=bundle.getString("hmlabel.exampublishtrash.standard")%><font color=red> *</font></td>
			<td width='1%' class='tablebold'>:</td>
			
			<td><select name=course validate='Standard' class=tablelight onchange=loadSubjects() >
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
								//System.out.println("req_coursepubid-->"+request.getParameter("req_coursepubid_hidden"));
								if(standardscheduleid.equals(request.getParameter("req_standardscheduleid")))
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
					</select></td>
		</tr>
		</table>
		</td></tr>
		</table>
					
		<tfoot>
			<tr>
		   		<td colspan="2" class="rounded-foot-left"><em></em></td>
		   		<td class="rounded-foot-right">&nbsp;</td>
		  	</tr>
		</tfoot>				
		
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
					        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("hmlabel.exampublish.slno")%></th>
					            <th scope="col" class="rounded" 		width="30%"><%=bundle.getString("hmlabel.exampublish.subjectname")%></th>
					            <th scope="col" class="rounded" 		width="20%"><%=bundle.getString("hmlabel.exampublish.examdate")%></th>
					            <th scope="col" class="rounded" 		width="10%"><%=bundle.getString("hmlabel.exampublish.starttime")%></th>
					            <th scope="col" class="rounded" 		width="10%"><%=bundle.getString("hmlabel.exampublish.endtime")%></th>
					            <th scope="col" class="rounded" 		width="10%"><%=bundle.getString("hmlabel.exampublish.duration")%></th>
					            <th scope="col" class="rounded" 		width="5%"><%=bundle.getString("label.exam.examtype")%></th>
					            <th scope="col" class="rounded-q4" 		width="5%"><%=bundle.getString("hmlabel.exampublish.check")%></th>
					        </tr>
					    </thead>
					<tfoot>
					  	<tr>
					      	<td colspan="7" class="rounded-foot-left"><em></em></td>
					      	<td class="rounded-foot-right">&nbsp;</td>
					   	</tr>
					</tfoot>					    
					        
		<%
		req_standardscheduleid = request.getParameter("req_standardscheduleid");
    		//subjectList		= examQuery.loadScheduledStandardSubjects(req_standardscheduleid);
    		subjectList=examQuery.loadScheduledStandardSubjectsforexampublish(req_standardscheduleid,req_examnameid);
    	   
    		int checkedCount=0;
    		int trashCount=0;
    		int serialCount=0;
    		String duration = null;
    		String examtype=null;
			  if(subjectList!=null && subjectList.size()>0)
			{ 
				  int inc = 1;
			
			 	for (int i1 = 0; i1 < subjectList.size(); i1++) {
			
				HashMap subjectListMap=(HashMap)subjectList.get(i1);
				String examscheduleid     = (String)subjectListMap.get("examscheduleid");
				String examsubscheduleid     = (String)subjectListMap.get("examsubscheduleid");
				subjectscheduleid     = (String)subjectListMap.get("subjectscheduleid");
				String subjectname      = (String)subjectListMap.get("subjectname");
				String subjectid      = (String)subjectListMap.get("subjectid");
				String standardid      = (String)subjectListMap.get("standardid");
				String examdate      = (String)subjectListMap.get("examdate");
				String examtimein      = (String)subjectListMap.get("examtimein");
				String examtimeout      = (String)subjectListMap.get("examtimeout");
				String examtimeinampm      = (String)subjectListMap.get("examtimeinampm");
				String examtimeoutampm      = (String)subjectListMap.get("examtimeoutampm");
				duration      = (String)subjectListMap.get("duration");
				examtype      = (String)subjectListMap.get("examtype");
				examallotmentid      = (String)subjectListMap.get("examallotmentid");
			String examschedulestatus      = (String)subjectListMap.get("examschedulestatus");
			String exampublishstatus      = (String)subjectListMap.get("exampublishstatus");
			
				
				if(examdate == null){
					examdate= " ";}
				if(examtimein == null){
					examtimein= " ";}
				if(examtimeout == null){
					examtimeout= " ";}
				//if(subjectListMap.get("examtimein") != null && subjectListMap.get("examtimeout")!=null)
					//duration = examQuery.getHourMin(examtimein,examtimeout);
					
					//duration = Integer.parseInt((String)subjectListMap.get("examtimeout"))-Integer.parseInt((String)subjectListMap.get("examtimein"));
				
		 		//out.println("examschedulestatus>>>"+examschedulestatus);
					
	if((examsubscheduleid != null)&&(examschedulestatus.equals("P"))&&(exampublishstatus.equals("A")))
	{
		//out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td><input type='text' readonly validate='Start Date' size='11' value='"+examdate+"' /></td><td><input type ='text' readonly  size='5' maxlength='4' validate='Start Time' value='"+examtimein+"'/></td><td><input type ='text' readonly maxlength='4' size='5' validate='End Time' value='"+examtimeout+"'/></td><td><input type ='text' size='5' validate='Duration' maxlength='2' value='"+duration+"'/></td><td><input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+subjectscheduleid+"'></td><input type=hidden name=exallotid value='"+examallotmentid+"'></tr>");
		out.print("<tr><td>"+(serialCount+1)+".</td><td>"+subjectname+"</td><td>"+examdate+"</td><td>"+examtimeinampm+"</td><td>"+examtimeoutampm+"</td><td>"+duration+"</td><td>"+examtype+"</td><td><input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+examscheduleid+"'></td><input type=hidden name=exallotid value='"+examallotmentid+"'></tr>");
		checkedCount++;
		serialCount++;
	}
	else if((examsubscheduleid != null)&&(exampublishstatus.equals("A"))&&(examschedulestatus.equals("A"))) 
		{
			//out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td><input type='text' readonly validate='Start Date' size='11' value='"+examdate+"' /></td><td><input type ='text' readonly  size='5' maxlength='4' validate='Start Time' value='"+examtimein+"'/></td><td><input type ='text' readonly maxlength='4' size='5' validate='End Time' value='"+examtimeout+"'/></td><td><input type ='text' size='5' validate='Duration' maxlength='2' value='"+duration+"'/></td><td>-</td></tr>");
		out.print("<tr><td>"+(serialCount+1)+".</td><td>"+subjectname+"</td><td>"+examdate+"</td><td>"+examtimeinampm+"</td><td>"+examtimeoutampm+"</td><td>"+duration+"</td><td>"+examtype+"</td><td><font color=green>Published</font></td></tr>");
		trashCount++;
		serialCount++;
		}
	else if((examsubscheduleid != null)&&(exampublishstatus.equals("R"))&&(examschedulestatus.equals("R"))) 
	{
		//out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td><input type='text' readonly validate='Start Date' size='11' value='"+examdate+"' /></td><td><input type ='text' readonly  size='5' maxlength='4' validate='Start Time' value='"+examtimein+"'/></td><td><input type ='text' readonly maxlength='4' size='5' validate='End Time' value='"+examtimeout+"'/></td><td><input type ='text' size='5' validate='Duration' maxlength='2' value='"+duration+"'/></td><td>-</td></tr>");
	out.print("<tr><td>"+(serialCount+1)+".</td><td>"+subjectname+"</td><td>"+examdate+"</td><td>"+examtimeinampm+"</td><td>"+examtimeoutampm+"</td><td>"+duration+"</td><td>"+examtype+"</td><td><font color=green>Published</font></td></tr>");
	trashCount++;
	serialCount++;
	}
	count++;	
	}
		
		}
		  else
			  {
		   		out.println("<tr><td colspan=8 align=center class=tablebold><font color=red>Data not found</font></td></tr>");    	 
		   	  }
		%>
		</table>
		</td>
		</tr>
		</table>
		<% 
		//if(trashCount>0)
		{
		%>	
		<a href="#" class="bt_red" onclick='trashPublishView()'><span class="bt_red_lft"></span><strong><%=bundle.getString("hmbutton.exampublish.gototrash")%></strong><span class="bt_red_r"></span></a>
		<%}%>
		<% 
		if(checkedCount>0){
		%>	
		<a href="#" class="bt_green" onclick='publishStandard()'><span class="bt_green_lft"></span><strong><%=bundle.getString("hmbutton.exampublish.publish")%></strong><span class="bt_green_r"></span></a>
		<%} %>
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