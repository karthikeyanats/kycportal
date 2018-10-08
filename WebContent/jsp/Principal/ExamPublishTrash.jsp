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
	function trashexampublish(obj)
	{
		if(confirm("Do you want to Trash the Selected Subject?"))
		{
			document.Schedule_Form.subjectname.value=obj.getAttribute("subjectname");
			document.Schedule_Form.examscheduleid.value=obj.getAttribute("examscheduleid");
			document.Schedule_Form.examallotmentid.value=obj.getAttribute("examallotmentid");
			document.Schedule_Form.action = "ExamPublishDetails.jsp";
			document.Schedule_Form.submit();
		}
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

	function trashPublishView()
	{
		document.Schedule_Form.action = "ExamPublishTrashView.jsp";
		document.Schedule_Form.submit();	
	}
		
	function statusChangeSchedule(obj)
	{
			if(count>0)
			{
				if(confirm("Are you sure want to "+obj.getAttribute("statusval")+" the Published Subject(s)?"))
				{
					document.Schedule_Form.action = "ExamPublishStatusSubmit.jsp?status="+obj.getAttribute("status");
					document.Schedule_Form.submit();
				}
			}
			else
			{
			alert("Please select subjects to publish");			
			}
	}
	
	function goBack()
	{
		document.Schedule_Form.action = "ExamSchedulePublishView.jsp";
		document.Schedule_Form.submit();
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

    <h2><%=bundle.getString("hmlabel.exampublishtrash.rootpath")%></h2>
<form name="Schedule_Form" action="" method="post">
	<input type=hidden name=req_sessionid value='<%=session.getValue("sessionid")%>'>
    <input type=hidden name=req_boardid value='<%=request.getParameter("req_boardid")%>'>
    <input type=hidden name=req_boardname value='<%=request.getParameter("req_boardname")%>'>
    <input type=hidden name=req_examnameid value='<%=request.getParameter("req_examnameid")%>'>
    <input type=hidden name=req_examname value='<%=request.getParameter("req_examname")%>'>
    <input type=hidden name=req_standardscheduleid value='<%=request.getParameter("req_standardscheduleid")%>'>
	<input type=hidden name=standardnamegp value='<%=request.getParameter("standardnamegp")%>'>
       
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
		            <th scope="col" class="rounded-company" width="100%"><%=bundle.getString("hmlabel.exampublishtrash.exampublish")%> </th>
		            <th scope="col" class="rounded-q4" width="10"></th>        
		        </tr>
		    </thead>
		    
		        <tfoot>
		    	<tr>
		        	<td class="rounded-foot-left"><em></em></td>
		        	<td class="rounded-foot-right">&nbsp;</td>
		       </tr>
		    </tfoot>
		

		
		<tr><td colspan="2"><table border=0 align=center id="rounded-corner1" width="100%">
		<tr>
			<td class=tablebold width="25%"><%=bundle.getString("hmlabel.exampublishtrash.academicyear")%></td>
			<td class=tablebold>:</td>
			<td>
			<%=session.getValue("sessionname")%>	
			</td>

				<td class=tablebold><%=bundle.getString("hmlabel.exampublishtrash.board")%></td>
					<td class=tablebold>:</td><td><%=request.getParameter("req_boardname")%></td>
		</tr>
		<tr>
			<td class=tablebold width="25%"><%=bundle.getString("hmlabel.exampublishtrash.examname")%></td>
			<td class=tablebold>:</td><td><%=request.getParameter("req_examname")%></td>
		
			<td class=tablebold width="25%"><%=bundle.getString("hmlabel.exampublishtrash.standard")%></td>
			<td class=tablebold>:</td><td><%=request.getParameter("standardnamegp")%></td>
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
					        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("hmlabel.exampublishtrash.slno")%></th>
					            <th scope="col" class="rounded" 		width="30%"><%=bundle.getString("hmlabel.exampublishtrash.subjectname")%></th>
					            <th scope="col" class="rounded" 		width="20%"><%=bundle.getString("hmlabel.exampublishtrash.examdate")%></th>
					            <th scope="col" class="rounded" 		width="10%"><%=bundle.getString("hmlabel.exampublishtrash.starttime")%></th>
					            <th scope="col" class="rounded" 		width="10%"><%=bundle.getString("hmlabel.exampublishtrash.endtime")%></th>
					            <th scope="col" class="rounded" 		width="10%"><%=bundle.getString("hmlabel.exampublishtrash.duration")%></th>
					            <th scope="col" class="rounded" 		width="8%"><%=bundle.getString("label.exam.examtype")%></th>
					            <th scope="col" class="rounded-q4" 		width="10%"><%=bundle.getString("hmlabel.exampublishtrash.check")%></th>
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
    		String duration = null;
    		String examtype = null;
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
					
	if((examsubscheduleid != null)&&(examschedulestatus .equals("P")))
	{
		//out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td><input type='text' readonly validate='Start Date' size='11' value='"+examdate+"' /></td><td><input type ='text' readonly  size='5' maxlength='4' validate='Start Time' value='"+examtimein+"'/></td><td><input type ='text' readonly maxlength='4' size='5' validate='End Time' value='"+examtimeout+"'/></td><td><input type ='text' size='5' validate='Duration' maxlength='2' value='"+duration+"'/></td><td><input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+subjectscheduleid+"'></td><input type=hidden name=exallotid value='"+examallotmentid+"'></tr>");
		//out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td>"+examdate+"</td><td>"+examtimein+"</td><td>"+examtimeout+"</td><td>"+duration+"</td><td><input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+examscheduleid+"'></td><input type=hidden name=exallotid value='"+examallotmentid+"'></tr>");
		checkedCount++;
	}
	else if((examsubscheduleid != null)&&(exampublishstatus .equals("A"))) 
		{
		//<img src='"+as+"/jsp/kycpanel/images/trash.png' alt='' title='"+bundle.getString("hlink.department.trash")+"' border=0 />
			//out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td><input type='text' readonly validate='Start Date' size='11' value='"+examdate+"' /></td><td><input type ='text' readonly  size='5' maxlength='4' validate='Start Time' value='"+examtimein+"'/></td><td><input type ='text' readonly maxlength='4' size='5' validate='End Time' value='"+examtimeout+"'/></td><td><input type ='text' size='5' validate='Duration' maxlength='2' value='"+duration+"'/></td><td>-</td></tr>");
		out.print("<tr><td>"+(trashCount+1)+".</td><td>"+subjectname+"</td><td>"+examdate+"</td><td>"+examtimeinampm+"</td><td>"+examtimeoutampm+"</td><td>"+duration+"</td><td>"+examtype+"</td><td><a href='#' onclick='trashexampublish(this)' examscheduleid='"+examscheduleid+"' subjectname='"+subjectname+"' examallotmentid='"+examallotmentid+"' ><img src='"+request.getContextPath()+"/jsp/kycpanel/images/trash.png' alt='' title='"+bundle.getString("hlink.department.trash")+"' border=0 /></a></td></tr>");
		trashCount++;																																																																																																																																																																	
		}
	count++;	
	}
			 if(trashCount==0)
				 out.println("<tr><td colspan=8 class=tablebold align=center><font color=red>Data Not found</font></td></tr>"); 
		
		}
		  else
			  {
		   		out.println("<tr><td colspan=8 class=tablebold align=center><font color=red>Data Not found</font></td></tr>");    	 
		   	  }
		%>
		</table>
		</td>
		</tr>
		</table>
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("hmbutton.exampublishtrash.back")%></strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_green" onclick='trashPublishView()'><span class="bt_green_lft"></span><strong><%=bundle.getString("hmbutton.exampublishtrash.viewtrashed")%> </strong><span class="bt_green_r"></span></a>		
		<input type='hidden' name='todaydate' 					value='<%=today %>'/>
		<input type='hidden' name='starts' 			disabled	value='<%=today %>'/>
		<input type='hidden' name='examscheduleid' 				value=''/>
		<input type='hidden' name='examallotmentid' 			value=''/>
		<input type='hidden' name='subjectname' 			value=''/>
	
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