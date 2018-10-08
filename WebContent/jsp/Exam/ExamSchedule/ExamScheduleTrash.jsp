<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<title><%=bundle.getString("label.product.name")%> - Exam Schedule Trash | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
	var count	= 0;
	
	function loadBoard()
	{
		document.Schedule_Form.req_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.submit(); 
	}
	 
	function loadExam()
	{
		document.Schedule_Form.req_boardid.value  = document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		document.Schedule_Form.req_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.req_examnameid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.submit();
	}

	function loadStandard()
	{
		document.Schedule_Form.req_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.req_boardid.value  = document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		document.Schedule_Form.req_examnameid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.submit();
	}
	function loadSubjects()
	{
		document.Schedule_Form.req_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.req_boardid.value  = document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		document.Schedule_Form.req_examnameid.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.req_standardscheduleid.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].value;	
		document.Schedule_Form.submit();
	}
	


	function checkCount(obj)
	{
		var pos	= obj.getAttribute("pos");
		var flag = true;
		//alert("pos-->"+pos);
		if(obj.checked)
		{
				if(flag){				
					count++;
					}
				else{
					obj.checked = false;
				}
		}
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
						document.Schedule_Form.examdates[i].disabled 	= true;
						document.Schedule_Form.starttime1[i].disabled 	= true;
						document.Schedule_Form.starttime2[i].disabled 	= true;
						document.Schedule_Form.endtime1[i].disabled 	= true;
						document.Schedule_Form.endtime2[i].disabled 	= true;
						document.Schedule_Form.duration[i].disabled 	= true;	
						//document.Schedule_Form.req_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value;					
						
					}
					else
					{
						checkCount++;
					}

				}

					if(confirm("Are you sure want to schedule the Exam?")){
					
						for(var i=0;i<document.Schedule_Form.checkstandard.length;i++)
						{
							if(!document.Schedule_Form.checkstandard[i].checked)
							{
								document.Schedule_Form.examdates[i].disabled 	= true;
								document.Schedule_Form.starttime1[i].disabled 	= true;
								document.Schedule_Form.starttime2[i].disabled 	= true;
								document.Schedule_Form.endtime1[i].disabled 	= true;
								document.Schedule_Form.endtime2[i].disabled 	= true;
								document.Schedule_Form.duration[i].disabled 	= true;	
								//document.Schedule_Form.req_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value;					
								
							}
							else
							{
								document.Schedule_Form.examdates[i].disabled 	= false;
								checkCount++;
							}
		
						}
						document.Schedule_Form.action = "ExamscheduleSubmit.jsp";
						document.Schedule_Form.submit();
				}
			}
			else
			{
			alert("Select Check Box");			
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
function validateTimeEntry1(start_time_entry,end_time_entry)
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

		document.Schedule_Form.req_sessionid1.value  	= document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.req_sessionname1.value  	= document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].text
		document.Schedule_Form.req_boardid1.value  		= document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		document.Schedule_Form.req_boardname1.value  	= document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].text;
		document.Schedule_Form.req_examnameid1.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.req_examname1.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].text;
		document.Schedule_Form.req_standardscheduleid1.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].value;
		document.Schedule_Form.standardnamegp1.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].text;
	
	if(confirm("Are you sure want to Edit the Scheduled Exam?")){
		document.Schedule_Form.action = "ExamScheduleEdit.jsp";
		document.Schedule_Form.submit();
	}

}

	function updateSchedule()
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
						//document.Schedule_Form.examdates[i].disabled 	= true;
						document.Schedule_Form.starttime1[i].disabled 	= true;
						document.Schedule_Form.starttime2[i].disabled 	= true;
						document.Schedule_Form.endtime1[i].disabled 	= true;
						document.Schedule_Form.endtime2[i].disabled 	= true;
						document.Schedule_Form.duration[i].disabled 	= true;	
						//document.Schedule_Form.req_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value;					
						
					}
					else
					{
						//document.Schedule_Form.examdates[i].disabled 	= false;
						checkCount++;
					}

				}

					if(confirm("Are you sure want to Update the Scheduled Exam?")){
					
						for(var i=0;i<document.Schedule_Form.checkstandard.length;i++)
						{
							if(!document.Schedule_Form.checkstandard[i].checked)
							{
								document.Schedule_Form.examdates[i].disabled 	= false;
								document.Schedule_Form.starttime1[i].disabled 	= true;
								document.Schedule_Form.starttime2[i].disabled 	= true;
								document.Schedule_Form.endtime1[i].disabled 	= true;
								document.Schedule_Form.endtime2[i].disabled 	= true;
								document.Schedule_Form.duration[i].disabled 	= true;	
								//document.Schedule_Form.req_sessionid.value  = document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value;					
								
							}
							else
							{
								document.Schedule_Form.examdates[i].disabled 	= false;
								checkCount++;
							}
		
						}
						document.Schedule_Form.action = "ExamScheduleUpdateSubmit.jsp";
						document.Schedule_Form.submit();
				}
			}
			else
			{
			alert("Select Check Box");			
			}
	}

	function statusChangeSchedule(obj)
	{
	
	var checkCount = 0;
		if(document.Schedule_Form.checkstandard.length == undefined)
		{
			if(document.Schedule_Form.checkstandard.checked==true)
			{
				if(confirm("Are you sure want to "+obj.getAttribute("statusval")+" the Scheduled Exam?"))
				{
					document.Schedule_Form.action = "ExamScheduleStatusSubmit.jsp?status="+obj.getAttribute("status");
					document.Schedule_Form.submit();			
				}
			}
			else
			{
				alert("Select Check Box");
			}			
		}
		else
		{
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
					if(confirm("Are you sure want to "+obj.getAttribute("statusval")+" the Scheduled Exam?")){
						document.Schedule_Form.action = "ExamScheduleStatusSubmit.jsp?status="+obj.getAttribute("status");
						document.Schedule_Form.submit();
				}
			}
			else
			{
			alert("Select Check Box");			
			}
		}			
	}
	
	function trashScheduleView()
	{
			document.Schedule_Form.action = "ExamScheduleTrashView.jsp";
			document.Schedule_Form.submit();
	}		
function trashSchedule1()
{
		document.Schedule_Form.req_sessionid1.value  	= document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].value
		document.Schedule_Form.req_sessionname1.value  	= document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].text
		document.Schedule_Form.req_boardid1.value  		= document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].value;
		document.Schedule_Form.req_boardname1.value  	= document.Schedule_Form.boardname.options[document.Schedule_Form.boardname.options.selectedIndex].text;
		document.Schedule_Form.req_examnameid1.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].value;
		document.Schedule_Form.req_examname1.value  = document.Schedule_Form.examname.options[document.Schedule_Form.examname.options.selectedIndex].text;
		document.Schedule_Form.req_standardscheduleid1.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].value;
		document.Schedule_Form.standardnamegp1.value  = document.Schedule_Form.course.options[document.Schedule_Form.course.options.selectedIndex].text;
	
	if(confirm("Are you sure want to Trash the Scheduled Exam?")){
		document.Schedule_Form.action = "ExamScheduleTrash.jsp";
		document.Schedule_Form.submit();
	}

}

    function validateHhMm(inputField,timeVal) {
//alert(inputField)    
        var isValid = /^([0-1]?[0-9]|2[0-3]):([0-5][0-9])(:[0-5][0-9])?$/.test(inputField);

//alert(isValid)
        if (isValid) {
            //inputField.style.backgroundColor = '#bfa';
        } else {
        	alert("Invalid "+timeVal+" Time")
            //inputField.style.backgroundColor = '#fba';
        }

        return isValid;
    }

function validateTimeEntry(start_time_entry,end_time_entry)
{
//alert(start_time_entry+"---"+end_time_entry)
		var setFlag = true;
		var setDuration;
      if(setFlag)
       {
	 //setFlag = check_TimeEntry(start_time_entry.value,"Start");
	 if(setFlag)
	 {
           // for valid start time format

           //setFlag = check_ForEmpty(end_time_entry.value);

           if(setFlag)
           {
               // for valid start time format and un checked endtime
	       //setFlag = check_TimeEntry(end_time_entry.value,"End");

		 if(setFlag)
		 {

		    // for valid end time format
		    // to check if endtime > starttime
		    var stime_str=start_time_entry;
		    var etime_str=end_time_entry;
		    var stime=stime_str.split(":");
		    var etime=etime_str.split(":");
		    stime=new Number(stime[0]+stime[1]);
		    etime=new Number(etime[0]+etime[1]);


		    if(etime > stime)

		    {
		    //alert("OK")
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
				//alert("endtime < starttime")	
		           //end_time_entry.focus();
		           //end_time_entry.value = "";
		           setDuration = false;
		           alert("End Time should be greater than Start Time!");

		         }

		 }
		 else // if invalid time format
		 {
	       	     if(setFlag != 0)

				alert("Invalid");
	     	     //end_time_entry.value = "";
	     	     //end_time_entry.focus();
	             setDuration = false;
	             alert("Invalid time format");
		 }
	     }
	     else
	     {
	     alert("Empty end time");
		//end_time_entry.focus();
		setDuration = false;
		alert("Empty end time is not allowed");
	     }
	 }
	 else
	 {
	     if(setFlag != 0)
	       alert("Invalid date format");

	     //end_time_entry.value = "";
	     //start_time_entry.value = "";
	     //start_time_entry.focus();
	     setDuration = false;
	 }
     }
     else
     {
	 //end_time_entry.value = "";
	 //start_time_entry.focus();
	 setDuration = false;
	 alert("Empty start time is not allowed");
     }
   return setDuration;
}	

// sub functon to calculate the the duration of exam

function calculateDuration(starthour,startmin,endhour,endmin)
{
	 var e_suffix_hr = endhour;
	 var e_suffix_mn = endmin;
	 var s_suffix_hr = starthour;
	 var s_suffix_mn = startmin;

     if(e_suffix_hr.charAt(0) == "0")
         e_suffix_hr = e_suffix_hr.charAt(1);

     if(e_suffix_mn.charAt(0) == "0")
         e_suffix_mn = e_suffix_mn.charAt(1);

     if(s_suffix_hr.charAt(0) == "0")
         s_suffix_hr = s_suffix_hr.charAt(1);

     if(s_suffix_mn.charAt(0) == "0")
         s_suffix_mn = s_suffix_mn.charAt(1);

		 hrsdiff  = new Number(e_suffix_hr) - new Number(s_suffix_hr);
		 mindiff  = new Number(e_suffix_mn) - new Number(s_suffix_mn);
	
		 mindiff1 = hrsdiff*60;
		 total_dur_mins = mindiff1+mindiff;

         if(total_dur_mins >= 60)
         {
            dur_hr = Math.floor(total_dur_mins/60);
            if (dur_hr <10)
            {
                dur_hr = "0"+dur_hr;
            }
            dur_hr = dur_hr + ":";

            dur_min = Math.floor(total_dur_mins%60);
            if (dur_min<10)
	    	{
	        dur_min = "0"+dur_min;
            }
            dur = dur_hr + dur_min;

         }

         else
         {
            if (total_dur_mins<10)
	    	{
	       total_dur_mins = "0"+ total_dur_mins;
            }
           dur = "00:"+total_dur_mins;
         }
         return dur;
}

function checkLength(obj)
{
	//alert("pos-->"+obj.getAttribute("pos"))
	var pos = obj.getAttribute("timepos");
	var focusName = obj.getAttribute("name");
	var minVal = obj.value;
	//alert("minVal1-->"+minVal.length)
	if(minVal.length == 2){
		if(focusName == "starttime1")
			document.Schedule_Form.starttime2[pos].focus();
		if(focusName == "starttime2")
			document.Schedule_Form.endtime1[pos].focus();
		if(focusName == "endtime1")
			document.Schedule_Form.endtime2[pos].focus();
		//if(focusName == "endtime2")
			//document.Schedule_Form.starttime1[pos].focus();
	} 
	
}


	function goBack()
	{
		document.Schedule_Form.action = "ExamScheduleCreate.jsp";
		document.Schedule_Form.submit();	
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

    <h2><%=bundle.getString("label.exam.examschedulerootpathtrash")%></h2>
<form name="Schedule_Form" action="" method="post">
	<input type=hidden name=req_sessionid value='<%=request.getParameter("req_sessionid")%>'>
	<input type=hidden name=req_sessionname value='<%=request.getParameter("req_sessionname")%>'>
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
		//String reg_sessionid 	= null;
		String req_sessionid 	= null;
		//String reg_boardid=null;
		String req_boardid=null;
		//String reg_examid=null;
		String req_examnameid=null;
		String req_standardscheduleid=null;
		//String reg_standardschid=null;
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
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.exam.selectinfo")%></th>
            <th scope="col" class="rounded-q4" width="10"></th>        
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
	<td class=tablebold width="25%"><%=bundle.getString("label.exam.AcademicYear")%></td><td class=tablebold width="2%">:</td><td class=tablelight ><%=request.getParameter("req_sessionname")%></td>
	<td class=tablebold><%=bundle.getString("label.exam.Board")%></td><td class=tablebold width="2%">:</td><td  colspan=2  class=tablelight><%=request.getParameter("req_boardname") %></td>
</tr>
<tr><td class=tablebold width="25%"><%=bundle.getString("label.exam.ExamName")%></td><td class=tablebold width="2%">:</td><td class=tablelight><%=request.getParameter("req_examname")%></td>
<td class=tablebold width="25%"><%=bundle.getString("label.exam.Standard")%></td><td class=tablebold width="2%">:</td><td class=tablelight><%=request.getParameter("standardnamegp") %></td>

</tr>
</table>
</td></tr>
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
					        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.exam.SL.No")%></th>
					            <th scope="col" class="rounded" 		width="15%"><%=bundle.getString("label.exam.SubjectName")%></th>
					            <th scope="col" class="rounded" 		width="17%"><%=bundle.getString("label.exam.ExamDate")%></th>
					            <th scope="col" class="rounded" 		width="15%"><%=bundle.getString("label.exam.StartTime")%><br>hh : mm(12 hrs)</th>
					            <th scope="col" class="rounded" 		width="15%"><%=bundle.getString("label.exam.EndTime")%><br>hh : mm(12 hrs)</th>
					            <th scope="col" class="rounded" 		width="10%"><%=bundle.getString("label.exam.Duration")%><br>hh : mm</th>
					            <th scope="col" class="rounded" 		width="8%"><%=bundle.getString("label.exam.examtype")%></th>
					            <th scope="col" class="rounded-q4" 		width="13%">Check</th>
					        </tr>
					    </thead>
					    
				  <tfoot>
				    	<tr>
				        	<td colspan="7" class="rounded-foot-left"><em></em></td>
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
			int slNo = 0;
		
			req_standardscheduleid = request.getParameter("req_standardscheduleid");
    		//subjectList		= examQuery.loadScheduledStandardSubjects(req_standardscheduleid);
    		subjectList=examQuery.loadScheduledExamToUpdate(req_standardscheduleid,req_examnameid);
    		//subjectList=examQuery.loadScheduledExamUpdate(request.getParameter("req_standardscheduleid"),request.getParameter("req_examnameid"),"P");
    	   
    		//int duration=0;
    		String duration=null;
    		String examtype=null;
    		
    		  req_sessionname = request.getParameter("req_sessionname");
    		  String name = req_sessionname;
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
				examtype				=	(String)subjectListMap.get("examtype");
				
				 examallotmentid      = (String)subjectListMap.get("examallotmentid");
				
				if(examdate == null){
					examdate= " ";}
				if(examtimein == null){
					examtimein= " ";}
				if(examtimeout == null){
					examtimeout= " ";}
				//if(subjectListMap.get("examtimein") != null && subjectListMap.get("examtimeout")!=null)
					//duration = examQuery.getHourMin(examtimein,examtimeout);
					//duration = Integer.parseInt((String)subjectListMap.get("examtimeout"))-Integer.parseInt((String)subjectListMap.get("examtimein"));
				
		 		//out.println("duration>>>"+duration);
					
	if(examsubscheduleid != null)
	{
		examScheduleStatus = (String)subjectListMap.get("examschedulestatus");
		if(examScheduleStatus.equals("A")){
			examScheduleHMStatus = "Published";
			scheduledExamPubDates = scheduledExamPubDates+"@"+examdate;
			
			//out.print("<tr><td>"+(slNo+1)+".</td><td>"+subjectname+"</td><td>"+examdate+"<input type='hidden' validate='Exam Date' name='examdates' size='11' value='"+examdate+"' onfocus='this.blur()'><input type='button' name='calButton' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.examdates["+(count)+"]','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate) style=visibility:hidden></td><td>"+examtimein+"<input type ='hidden' name='starttime1' size='2' maxlength='2' validate='Start Hour' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimein.split(":")[0]+"'><input type ='hidden' name='starttime2' size='2' maxlength='2' validate='Start Minute' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimein.split(":")[1]+"'><input type ='hidden' readonly  size='5' name='starttime' maxlength='4' validate='Start Time' value=''/></td><td>"+examtimeout+"<input type ='hidden' name='endtime1' maxlength='2' size='2' validate='End Hour' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimeout.split(":")[0]+"'><input type ='hidden' name='endtime2' maxlength='2' size='2' validate='End Minute' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimeout.split(":")[1]+"'><input type ='hidden' readonly  size='5' name='endtime' maxlength='4' validate='Start Time' value=''/></td><td><input type ='hidden' name='duration1' size='2' validate='Duration' maxlength='2'><input type ='hidden' readonly name='duration' size='5' validate='Duration' maxlength='5' value='"+duration+"'>"+duration+"<span id='durationid'></span></td><td>"+examScheduleHMStatus+"<input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+examscheduleid+"@"+count+"' style='visibility:hidden'></td><input type=hidden name=exallotid value='"+examallotmentid+"'</tr>");
			//out.print("<tr><td>"+(slNo+1)+".</td><td>"+subjectname+"</td><td>"+examdate+"<input type='hidden' validate='Exam Date' name='examdates' size='11' value='"+examdate+"' onfocus='this.blur()'><input type='button' name='calButton' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.examdates["+(count)+"]','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate) style=visibility:hidden></td><td>"+examtimein+"<input type ='hidden' name='starttime1' size='2' maxlength='2' validate='Start Hour' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimein.split(":")[0]+"'><input type ='hidden' name='starttime2' size='2' maxlength='2' validate='Start Minute' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimein.split(":")[1]+"'><input type ='hidden' readonly  size='5' name='starttime' maxlength='4' validate='Start Time' value=''/></td><td>"+examtimeout+"<input type ='hidden' name='endtime1' maxlength='2' size='2' validate='End Hour' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimeout.split(":")[0]+"'><input type ='hidden' name='endtime2' maxlength='2' size='2' validate='End Minute' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimeout.split(":")[1]+"'><input type ='hidden' readonly  size='5' name='endtime' maxlength='4' validate='Start Time' value=''/></td><td><input type ='hidden' name='duration1' size='2' validate='Duration' maxlength='2'><input type ='hidden' readonly name='duration' size='5' validate='Duration' maxlength='5' value='"+duration+"'>"+duration+"<span id='durationid'></span></td><td>"+examScheduleHMStatus+"<input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+subjectscheduleid+"' style='visibility:hidden'></td><input type=hidden name=exallotid value='"+examallotmentid+"'</tr>");
		}
		else{
			examScheduleHMStatus = "Waiting for Approval";
			out.print("<tr><td>"+(slNo+1)+".</td><td>"+subjectname+"</td><td>"+examdate+"<input type='hidden' validate='Exam Date' name='examdates' size='11' value='"+examdate+"' onfocus='this.blur()'><input type='button' name='calButton' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.examdates["+(count)+"]','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate) style='visibility:hidden'></td><td><input type ='hidden' name='starttime1' size='2' maxlength='2' validate='Start Hour' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimein.split(":")[0]+"'><input type ='hidden' name='starttime2' size='2' maxlength='2' validate='Start Minute' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimein.split(":")[1]+"'><input type ='hidden' readonly  size='5' name='starttime' maxlength='4' validate='Start Time' value=''/>"+examtimeinampm+"</td><td><input type ='hidden' name='endtime1' maxlength='2' size='2' validate='End Hour' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimeout.split(":")[0]+"'><input type ='hidden' name='endtime2' maxlength='2' size='2' validate='End Minute' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimeout.split(":")[1]+"'><input type ='hidden' readonly  size='5' name='endtime' maxlength='4' validate='Start Time' value=''/>"+examtimeoutampm+"</td><td><input type ='hidden' name='duration1' size='2' validate='Duration' maxlength='2'><input type ='hidden' readonly name='duration' size='5' validate='Duration' maxlength='5' value='"+duration+"'>"+duration+"<span id='durationid"+count+"'></span></td><td>"+examtype+"</td><td><input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+examscheduleid+"@"+count+"'></td><input type=hidden name=exallotid value='"+examallotmentid+"'</tr>");
			//out.print("<tr><td>"+(slNo+1)+".</td><td>"+subjectname+"</td><td><input type='text' validate='Exam Date' name='examdates' size='11' value='"+examdate+"' onfocus='this.blur()'><input type='button' name='calButton' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.examdates["+(count)+"]','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)></td><td><input type ='text' name='starttime1' size='2' maxlength='2' validate='Start Hour' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimein.split(":")[0]+"'>:<input type ='text' name='starttime2' size='2' maxlength='2' validate='Start Minute' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimein.split(":")[1]+"'><input type ='hidden' readonly  size='5' name='starttime' maxlength='4' validate='Start Time' value=''/></td><td><input type ='text' name='endtime1' maxlength='2' size='2' validate='End Hour' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimeout.split(":")[0]+"'>:<input type ='text' name='endtime2' maxlength='2' size='2' validate='End Minute' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimeout.split(":")[1]+"'><input type ='hidden' readonly  size='5' name='endtime' maxlength='4' validate='Start Time' value=''/></td><td><input type ='hidden' name='duration1' size='2' validate='Duration' maxlength='2'><input type ='hidden' readonly name='duration' size='5' validate='Duration' maxlength='5' value='"+duration+"'><span id='durationid"+count+"'></span></td><td><input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+subjectscheduleid+"'></td><input type=hidden name=exallotid value='"+examallotmentid+"'</tr>");
			slNo++;
			visibleCheck++;
		}
		
		//out.print("<tr><td>"+(slNo+1)+".</td><td>"+subjectname+"</td><td><input type='text' validate='Exam Date' name='examdates' size='11' value='"+examdate+"' onfocus='this.blur()'><input type='button' name='calButton' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.examdates["+(count)+"]','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)></td><td><input type ='text' name='starttime1' size='2' maxlength='2' validate='Start Hour' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimein.split(":")[0]+"'>:<input type ='text' name='starttime2' size='2' maxlength='2' validate='Start Minute' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimein.split(":")[1]+"'><input type ='hidden' readonly  size='5' name='starttime' maxlength='4' validate='Start Time' value=''/></td><td><input type ='text' name='endtime1' maxlength='2' size='2' validate='End Hour' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimeout.split(":")[0]+"'>:<input type ='text' name='endtime2' maxlength='2' size='2' validate='End Minute' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)' value='"+examtimeout.split(":")[1]+"'><input type ='hidden' readonly  size='5' name='endtime' maxlength='4' validate='Start Time' value=''/></td><td><input type ='hidden' name='duration1' size='2' validate='Duration' maxlength='2'><input type ='text' readonly name='duration' size='5' validate='Duration' maxlength='5' value='"+duration+"'></td><td>"+examScheduleHMStatus+"<input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+subjectscheduleid+"'></td><input type=hidden name=exallotid value='"+examallotmentid+"'</tr>");
		//out.print("<tr><td>"+(slNo+1)+".</td><td>"+subjectname+"</td><td>"+examdate+"<input type='hidden' readonly name='examdates' validate='Exam Date' size='11' value='"+examdate+"' /><input type='button' name='calButton'  style=display:none></td><td>"+examtimein+"<input type ='hidden' readonly  name='starttime1' value='"+examtimein.split(":")[0]+"' disabled/> <input type ='hidden' readonly  name='starttime2' value='"+examtimein.split(":")[1]+"' disabled/> <input type ='hidden' readonly name='starttime' maxlength='4' size='5' validate='Start Time' value='"+examtimein+"' disabled/></td><td>"+examtimeout+"<input type ='hidden' readonly  name='endtime1' value='"+examtimeout.split(":")[0]+"' disabled/><input type ='hidden' readonly  name='endtime2' value='"+examtimeout.split(":")[1]+"' disabled/><input type ='hidden' readonly name='endtime' maxlength='4' size='5' validate='End Time' value='"+examtimeout+"' disabled/></td><td>"+duration+"<input type ='hidden' readonly size='5' validate='Duration' maxlength='2' name='duration' value='"+duration+"'/></td><td>"+examScheduleHMStatus+"<input type='checkbox' name='checkstandard' pos='"+count+"' value='"+subjectscheduleid+"' style='visibility:hidden'></td></tr>");
		//out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td>"+examdate+"<input type='hidden' readonly name='examdates' validate='Exam Date' size='11' value='"+examdate+"' /><input type='button' name='calButton'  style=display:none></td><td>"+examtimein+"<input type ='hidden' readonly  size='5' name='starttime' maxlength='4' validate='Start Time' value='"+examtimein+"' disabled/><input type ='hidden' readonly  name='starttime1' value='"+examtimein.split(":")[0]+"' disabled /><input type ='hidden' readonly  name='starttime2' value='"+examtimein.split(":")[1]+"' disabled/><input type ='hidden' readonly  size='5' name='starttime' maxlength='4' validate='Start Time' value='"+examtimein+"' disabled/></td><td>"+examtimeout+"<input type ='hidden' readonly  name='endtime1' value='"+examtimeout.split(":")[0]+"' disabled/><input type ='hidden' readonly  name='endtime2' value='"+examtimeout.split(":")[1]+"' disabled/><input type ='hidden' readonly name='endtime' maxlength='4' size='5' validate='End Time' value='"+examtimeout+"' disabled/></td><td>"+duration+"<input type ='hidden' readonly size='5' validate='Duration' maxlength='2' name='duration' value='"+duration+"'/></td><td>"+examScheduleHMStatus+"<input type='checkbox' name='checkstandard' pos='"+count+"' value='"+subjectscheduleid+"' style='visibility:hidden'></td></tr>");
		//out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td>"+examdate+"</td><td>"+examtimein+"</td><td>"+examtimeout+"</td><td>"+duration+"</td><td>-<input type='checkbox' name='checkstandard' pos='"+count+"' value='"+subjectscheduleid+"' style='visibility:hidden'></td></tr>");
		scheduledExamDates = scheduledExamDates+"@"+examdate;
		scheduledExamPos  = scheduledExamPos+"@"+slNo;

		count++;
	}
	else
		{
		//out.print("<tr><td>"+(i1+1)+".</td><td>"+subjectname+"</td><td><input type='text' validate='Exam Date' name='examdates' size='11' value='' onfocus='this.blur()'><input type='button' name='calButton' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.examdates["+(count)+"]','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)></td><td><input type ='text' name='starttime1' size='2' maxlength='2' validate='Start Hour' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)'>:<input type ='text' name='starttime2' size='2' maxlength='2' validate='Start Minute' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)'><input type ='hidden' readonly  size='5' name='starttime' maxlength='4' validate='Start Time' value=''/></td><td><input type ='text' name='endtime1' maxlength='2' size='2' validate='End Hour' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)'>:<input type ='text' name='endtime2' maxlength='2' size='2' validate='End Minute' onkeypress='checkNumber(event)' timepos='"+count+"' onkeyup='checkLength(this)'><input type ='hidden' readonly  size='5' name='endtime' maxlength='4' validate='Start Time' value=''/></td><td><input type ='hidden' name='duration1' size='2' validate='Duration' maxlength='2'><input type ='text' readonly name='duration' size='5' validate='Duration' maxlength='5'></td><td><input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+subjectscheduleid+"'></td><input type=hidden name=exallotid value='"+examallotmentid+"'</tr>");
		//visibleCheck++;																																																																																																																																																																	
		}
		
	}
		if(slNo==0)	 	
			out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
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

		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.exam.Back")%></strong><span class="bt_blue_r"></span></a>		 
		<%
		if(visibleCheck>0){
		%>
		<a href="#" class="bt_red" statusval="Trash" status="T" onclick='statusChangeSchedule(this)'><span class="bt_red_lft"></span><strong><%=bundle.getString("button.exam.trash")%></strong><span class="bt_red_r"></span></a>
		<!--  <a href="#" class="bt_green" onclick='publishStandard()'><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>-->
		<%
		}
		%>
		<a href="#" class="bt_green" onclick='trashScheduleView()'><span class="bt_green_lft"></span><strong><%=bundle.getString("button.exam.viewtrash")%></strong><span class="bt_green_r"></span></a>
		<input type='hidden' name='todaydate' 					value='<%=today %>'/>
		<!--  <input type='hidden' name='examdates' 			disabled	value='<%=today %>'/>-->
		<input type='hidden' name='schedDates' value='<%=scheduledExamDates%>'/>
		<input type='hidden' name='schedPos' value='<%=scheduledExamPos%>'/>
		<input type='hidden' name='schedPubDates' value='<%=scheduledExamPubDates%>'/>

		
	
</form>	
    </div><!-- end of right content-->
	</div>   <!--end of center content -->

   <div class="clear"></div>
   </div> <!--end of main content-->
<%@ include file="../../include/footer.jsp" %>
</div>
</body>
</html>