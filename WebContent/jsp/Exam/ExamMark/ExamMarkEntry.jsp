<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Student Mark Entry | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>

<script type="text/javascript">

	function View()
	{
		document.ExammarkEntryForm.action="ApplicantView.jsp";
		document.ExammarkEntryForm.submit();
	}
	function loadExam()
	{
		document.ExammarkEntryForm.reg_boardid.value  = document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].value
		document.ExammarkEntryForm.reg_sessionid.value  = document.ExammarkEntryForm.sessionname.options[document.ExammarkEntryForm.sessionname.options.selectedIndex].value
		document.ExammarkEntryForm.reg_examid.value  = document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].value;
		document.ExammarkEntryForm.submit();
	
	}

	function loadStandard()
	{
		document.ExammarkEntryForm.reg_sessionid.value  = document.ExammarkEntryForm.sessionname.options[document.ExammarkEntryForm.sessionname.options.selectedIndex].value
		document.ExammarkEntryForm.reg_boardid.value  = document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_examid.value  = document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].value;
		//alert(document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].value)
		document.ExammarkEntryForm.submit();
	
	}
	
	function loadSection()
	{
		document.ExammarkEntryForm.reg_sessionid.value			=	document.ExammarkEntryForm.sessionname.options[document.ExammarkEntryForm.sessionname.options.selectedIndex].value
		document.ExammarkEntryForm.reg_boardid.value  			=	document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_coursepubid_hidden.value = 	document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_examid.value  			= document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].value;
		document.ExammarkEntryForm.submit();
	
	}
	function loadSubject()
	{
		document.ExammarkEntryForm.reg_sessionid.value			=	document.ExammarkEntryForm.sessionname.options[document.ExammarkEntryForm.sessionname.options.selectedIndex].value
		document.ExammarkEntryForm.reg_boardid.value  			=	document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_coursepubid_hidden.value = 	document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_examid.value  			= document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_sectionpubid.value		= document.ExammarkEntryForm.section.options[document.ExammarkEntryForm.section .options.selectedIndex].value;
		document.ExammarkEntryForm.reg_subjectschid.value		= document.ExammarkEntryForm.subjectname.options[document.ExammarkEntryForm.subjectname.options.selectedIndex].value;
		document.ExammarkEntryForm.submit();
	
	}
	
	function viewStudent()
	{
		document.ExammarkEntryForm.reg_sessionid.value  = document.ExammarkEntryForm.sessionname.options[document.ExammarkEntryForm.sessionname.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_boardid.value  = document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_coursepubid.value  = document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_sectionpubid.value  = document.ExammarkEntryForm.section.options[document.ExammarkEntryForm.section.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_subjectschid.value  = document.ExammarkEntryForm.subjectname.options[document.ExammarkEntryForm.subjectname.options.selectedIndex].value;
		
		var flag=true;
	
	
		if(document.ExammarkEntryForm.reg_sessionid.value=="00")
		{
			alert("Select Academic Year")
			document.ExammarkEntryForm.sessionname.focus();
		
		}
		
		else if(document.ExammarkEntryForm.reg_boardid.value=="00")
		{
			alert("Select Board")
			document.ExammarkEntryForm.boardname.focus();
		
		}
		else if(document.ExammarkEntryForm.reg_examid.value=="00")
		{
			alert("Select Exam")
			document.ExammarkEntryForm.course.focus();
		
		}
		else if(document.ExammarkEntryForm.reg_coursepubid.value=="00")
		{
			alert("Select Standard")
			document.ExammarkEntryForm.course.focus();
		
		}
		else if(document.ExammarkEntryForm.reg_sectionpubid.value=="00")
		{
			alert("Select Section")
			document.ExammarkEntryForm.section.focus();
		
		}
		else if(document.ExammarkEntryForm.reg_subjectschid.value=="00")
		{
			alert("Select Subject")
			document.ExammarkEntryForm.subjectname.focus();
		
		}
		
		else
		{
			document.ExammarkEntryForm.reg_sessionid.value  	= document.ExammarkEntryForm.sessionname.options[document.ExammarkEntryForm.sessionname.options.selectedIndex].value;
			document.ExammarkEntryForm.reg_sessiontext.value  = document.ExammarkEntryForm.sessionname.options[document.ExammarkEntryForm.sessionname.options.selectedIndex].text;
		
			document.ExammarkEntryForm.reg_boardid.value  	= document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].value;
			document.ExammarkEntryForm.reg_boardname.value  	= document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].text;
	
			document.ExammarkEntryForm.reg_examid.value  	= document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].value;
			document.ExammarkEntryForm.reg_examname.value  	= document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].text;
			
			//document.ExammarkEntryForm.reg_ctypeid.value  	= document.ExammarkEntryForm.ctype.options[document.ExammarkEntryForm.ctype.options.selectedIndex].value;
			//document.ExammarkEntryForm.reg_ctypetext.value  = document.ExammarkEntryForm.ctype.options[document.ExammarkEntryForm.ctype.options.selectedIndex].text;
		
			document.ExammarkEntryForm.reg_coursepubid.value  = document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].value;
			document.ExammarkEntryForm.reg_coursename.value  	= document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].text;

			document.ExammarkEntryForm.reg_sectionpubid.value = document.ExammarkEntryForm.section.options[document.ExammarkEntryForm.section.options.selectedIndex].value;
			document.ExammarkEntryForm.reg_sectionname.value  = document.ExammarkEntryForm.section.options[document.ExammarkEntryForm.section.options.selectedIndex].text;
			
			document.ExammarkEntryForm.reg_coursepubid_hidden.value = document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].value;
			document.ExammarkEntryForm.reg_subjectschid.value = document.ExammarkEntryForm.subjectname.options[document.ExammarkEntryForm.subjectname.options.selectedIndex].value;
			document.ExammarkEntryForm.reg_subjectname.value  = document.ExammarkEntryForm.subjectname.options[document.ExammarkEntryForm.subjectname.options.selectedIndex].text;	
			document.ExammarkEntryForm.action="ExamMarkStudentList.jsp";
			document.ExammarkEntryForm.submit();
		}
	
	}
	function fun(list)
	{
		//alert(list.options[list.selectedIndex].getAttribute("exmsid"));
		document.ExammarkEntryForm.reg_examschid.value=list.options[list.selectedIndex].getAttribute("exmsid");
		//alert(document.ExammarkEntryForm.reg_examschid.value);
	}
</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>
<body bgcolor="#2B303E" topmargin="0" bottommargin="0">
<form name="ExammarkEntryForm" action="" method="post">
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

    <h2>Exam / Exam Mark Entry / Students List</h2>


	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    		<tr>
        		<th scope="col" class="rounded-company" width="10"></th>
            	<th scope="col" class="rounded" width="100%">Student List</th>
            	<th scope="col" class="rounded-q4" width="10"></th>        
        	</tr>
    	</thead>
    
        <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       	</tr>
    	</tfoot>
		<input type=hidden name=reg_sessionid>
		<input type=hidden name=reg_boardid>
		<input type=hidden name=reg_boardname>
		<input type=hidden name=reg_examid>
		<input type=hidden name=reg_examname>
		<input type=hidden name=reg_sessiontext>
		<input type=hidden name=reg_coursename>
		<input type=hidden name=reg_coursepubid>
		<input type=hidden name=reg_coursepubid_hidden>
		<input type=hidden name=reg_sectionname>
		<input type=hidden name=reg_sectionpubid>
		<input type=hidden name=reg_subjectschid>
		<input type=hidden name=reg_subjectname>
		<input type=hidden name=reg_examschid value="">
		

		<%
			com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();	
			com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
			com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examAllotmentQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
			
			ArrayList standardList =  null;
			ArrayList sectionList =  null;
			ArrayList subjectList =  null;
			String reg_boardid 	 = null;
			String reg_subjectschid 	 = null;
			String reg_sectionpubid=null;
			String reg_examid 	 = null;
			ArrayList ExamList = null;
			if(request.getParameter("reg_sessionid") == null)
			{
				
			}
			else if(request.getParameter("reg_sessionid") != null && request.getParameter("reg_boardid") != null && request.getParameter("reg_coursepubid_hidden") != null )
			{
				String reg_coursepubid = request.getParameter("reg_coursepubid_hidden"); 
				String reg_sessionid = request.getParameter("reg_sessionid");
				reg_boardid = request.getParameter("reg_boardid");
				reg_examid = request.getParameter("reg_examid");
				standardList = examAllotmentQuery.listStandardforexam(reg_sessionid,reg_boardid,reg_examid);
				sectionList = registrationQuery.listSections(reg_coursepubid);
				//System.out.println("reg_coursepubid11-->"+reg_coursepubid+"sectionList11-->"+sectionList);
			}

			
				
			
			else if(request.getParameter("reg_sessionid") != null && request.getParameter("reg_boardid") != null)
			{
				String reg_sessionid = request.getParameter("reg_sessionid");
				reg_boardid = request.getParameter("reg_boardid");
				standardList = registrationQuery.listStandard(reg_sessionid,reg_boardid);
			}
			
			
			
			//System.out.println("REQUEST"+request.getParameter("reg_sessionid")+"--"+request.getParameter("reg_boardid")+"--"+request.getParameter("reg_coursepubid_hidden"));			
		    String instituteid = null;
		    ArrayList BoardList = null;
		    
		    
		    try
		    {
		    	instituteid = (String)session.getValue("instituteid");
		    	BoardList = standardQuery.listBoard(instituteid);
		    }catch(Exception e){}

			ArrayList yearList = registrationQuery.listYearofSession(instituteid);
		%>
			<tr><td><td><table border=0 align=center id="rounded-corner1" width="100%">
			<tr>
				<td class=tablebold>Academic Year<font color="red">*</font></td><td>
					<select name=sessionname class=tablelight>
						<option value="00">-Select Academic-</option>
						<%
							for(int s=0;s<yearList.size();s++)
							{
								HashMap map=(HashMap)yearList.get(s);
								String sessionid=(String)map.get("sessionid");
								String yearofsession=(String)map.get("sessionname");
								//String session_status=(String)map.get("status");
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
			</tr>
				
			<tr>
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
			<tr>
				<td class=tablebold>Exam <font color="red">*</font></td>
				<td>
					<select name=examname class=tablelight onchange=loadStandard() >
						<option value="00">-Select Exam Name-</option>
						<%
						if(request.getParameter("reg_sessionid")!=null)
							try{
								String reg_sessionid = request.getParameter("reg_sessionid");
								//System.out.println("reg_sessionid>>>>"+reg_sessionid);
								ExamList=examAllotmentQuery.LoadAllotedExamnameList(reg_sessionid);
								//System.out.println("ExamList>>>>"+ExamList);
								}catch(Exception e){}
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
			</tr>
			<tr>
				<td class=tablebold>Standard <font color="red">*</font></td>
				<td><select name=course class=tablelight onchange=loadSection() >
					<option value="00">-Select Standard-</option>
					<%
					

						if(standardList !=null && standardList.size() >0)
						{
							for(int s1=0;s1<standardList.size();s1++)
							{
								HashMap map1=(HashMap)standardList.get(s1);
								String standardid=(String)map1.get("standardid");
								String standardname=(String)map1.get("standardname");
								String standardscheduleid=(String)map1.get("standardscheduleid");
								String groupname=(String)map1.get("groupname");
								if(!groupname.equals("NoGroup"))
								{												
									standardname = standardname+" - "+groupname; 
								}
								//System.out.println("standardscheduleid-->"+standardscheduleid);
								//System.out.println("reg_coursepubid-->"+request.getParameter("reg_coursepubid_hidden"));
								if(standardscheduleid.equals(request.getParameter("reg_coursepubid_hidden")))
								{
									out.println("<option selected value='"+standardscheduleid+"' class=tablelight >"+standardname+"</option>");
								}
								else
								{
									out.println("<option value='"+standardscheduleid+"' class=tablelight >"+standardname+"</option>");
								}
								
								
							}
						}
					%>
					</select>
				</td>
			</tr>
			<tr>
				<td class=tablebold>Section <font color="red">*</font></td>
				<td><select name=section class=tablelight onchange=loadSubject() >
					<option value="00">-Select Section-</option>
					<%
					if(sectionList !=null && sectionList.size() >0)
						{
							for(int s1=0;s1<sectionList.size();s1++)
							{
								HashMap map1=(HashMap)sectionList.get(s1);
								String sectionId=(String)map1.get("sectionid");
								String sectionName=(String)map1.get("sectionname");
								String sectionSchedId=(String)map1.get("sectionscheduleid");
								if(sectionSchedId.equals(request.getParameter("reg_sectionpubid")))
								{
									out.println("<option selected value='"+sectionSchedId+"' class=tablelight >"+sectionName+"</option>");
								}
								else
								{
									out.println("<option value='"+sectionSchedId+"' class=tablelight >"+sectionName+"</option>");
								}
								
							}
						}
					%>
					</select>
				</td>
			</tr>
			<tr>
				<td class=tablebold>Subject<font color="red">*</font></td>
				<td><select name=subjectname class=tablelight onchange=fun(this)>
					<option value="00">-Select Subject-</option>
					<%
					if(request.getParameter("reg_coursepubid_hidden")!=null)
						try{
							String reg_coursepubid_hidden = request.getParameter("reg_coursepubid_hidden");
							//System.out.println("reg_coursepubid_hidden>>>>"+reg_coursepubid_hidden);
							subjectList=examAllotmentQuery.loadScheduledStandardSubjectsforexammark(reg_coursepubid_hidden,reg_examid);
							//System.out.println("subjectList>>>>"+subjectList);
							}catch(Exception e){}

						if(subjectList !=null && subjectList.size() >0)
						{
							for(int s1=0;s1<subjectList.size();s1++)
							{
								HashMap map1=(HashMap)subjectList.get(s1);
								String subjectId=(String)map1.get("subjectid");
								String subjectName=(String)map1.get("subjectname");
								String subjectSchedId=(String)map1.get("subjectscheduleid");
								String examscheduleid=(String)map1.get("examscheduleid");
								
								out.println("<option value='"+subjectSchedId+"' exmsid='"+examscheduleid+"'>"+subjectName+"</option>");
								
							}
						}
					//out.println("<option value='1'>A</option>");
					%>
					</select>
				</td>
			</tr>
						
			</table></td><td></td></tr>
			</table>

				<a href="#" class="bt_blue" onclick="viewStudent()"><span class="bt_blue_lft"></span><strong>View Students</strong><span class="bt_blue_r"></span></a>

	</div><!-- end of right content-->


	</div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->

	<%@ include file="../../include/footer.jsp" %>

	</div>
</form>
</body>
</html>