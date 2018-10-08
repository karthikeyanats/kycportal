<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Exam Result Publish | Powered by i-Grandee</title>
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
		document.ExammarkEntryForm.reg_examid.value  = document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].value;
		document.ExammarkEntryForm.submit();
	
	}

	function loadStandard()
	{
		document.ExammarkEntryForm.reg_boardid.value  = document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_examid.value  = document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].value;
		document.ExammarkEntryForm.submit();
	
	}
	
	function loadSection()
	{
		document.ExammarkEntryForm.reg_boardid.value  			=	document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_coursepubid_hidden.value = 	document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_examid.value  			= document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].value;
		document.ExammarkEntryForm.submit();
	
	}
	function loadSubject()
	{
		document.ExammarkEntryForm.reg_boardid.value  			=	document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_coursepubid_hidden.value = 	document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_examid.value  			= document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_sectionpubid.value		= document.ExammarkEntryForm.section.options[document.ExammarkEntryForm.section .options.selectedIndex].value;
		document.ExammarkEntryForm.reg_subjectschid.value		= document.ExammarkEntryForm.subjectname.options[document.ExammarkEntryForm.subjectname.options.selectedIndex].value;
		document.ExammarkEntryForm.submit();
	
	}
		function viewStudent()
	{
		document.ExammarkEntryForm.reg_boardid.value  = document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_coursepubid.value  = document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].value;
	//	document.ExammarkEntryForm.reg_sectionpubid.value  = document.ExammarkEntryForm.section.options[document.ExammarkEntryForm.section.options.selectedIndex].value;
		var flag=true;
	
	
		 if(document.ExammarkEntryForm.reg_boardid.value=="00")
		{
			alert("Select Board")
			document.ExammarkEntryForm.boardname.focus();
		
		}
		else if(document.ExammarkEntryForm.examname.value=="00")
		{
			alert("Select Exam")
			document.ExammarkEntryForm.examname.focus();
		
		}
		else if(document.ExammarkEntryForm.reg_coursepubid.value=="00")
		{
			alert("Select Standard")
			document.ExammarkEntryForm.course.focus();
		
		}
		/* else if(document.ExammarkEntryForm.reg_sectionpubid.value=="00")
		{
			alert("Select Section")
			document.ExammarkEntryForm.section.focus();
		
		} */
			else
		{
			
		
			document.ExammarkEntryForm.reg_boardid.value  	= document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].value;
			document.ExammarkEntryForm.reg_boardname.value  	= document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].text;
	
			document.ExammarkEntryForm.reg_examid.value  	= document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].value;
			document.ExammarkEntryForm.reg_examname.value  	= document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].text;
			
			//document.ExammarkEntryForm.reg_ctypeid.value  	= document.ExammarkEntryForm.ctype.options[document.ExammarkEntryForm.ctype.options.selectedIndex].value;
			//document.ExammarkEntryForm.reg_ctypetext.value  = document.ExammarkEntryForm.ctype.options[document.ExammarkEntryForm.ctype.options.selectedIndex].text;
		
			document.ExammarkEntryForm.reg_coursepubid.value  = document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].value;
			document.ExammarkEntryForm.reg_coursename.value  	= document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].text;
//hidden by rams,reason- load the result based on the standard
			/* document.ExammarkEntryForm.reg_sectionpubid.value = document.ExammarkEntryForm.section.options[document.ExammarkEntryForm.section.options.selectedIndex].value;
			document.ExammarkEntryForm.reg_sectionname.value  = document.ExammarkEntryForm.section.options[document.ExammarkEntryForm.section.options.selectedIndex].text; */
			
			document.ExammarkEntryForm.reg_coursepubid_hidden.value = document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].value;
			document.ExammarkEntryForm.action="ExamResultPublishView.jsp";
			document.ExammarkEntryForm.submit();
		}
	}
	</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,java.util.ResourceBundle,com.iGrandee.Application.RegistrationProcess"%>
<body bgcolor="#2B303E" topmargin="0" bottommargin="0">
<form name="ExammarkEntryForm" action="" method="post">
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

    <h2><%=bundle.getString("hmlabel.examresultpublish.rootpath")%></h2>



    	<table id="rounded-corner" border=0 width="100%">
    	<thead>
    	<tr>
        	 <th scope="col" class="rounded-company" width="80%" colspan=5><%=bundle.getString("hmlabel.examresultpublish.studentlist")%></th>      
        	<th scope="col" class="rounded-q4" width="20%" ><font style="float:right;"> <font color=red>* </font><%=bundle.getString("label.common.mandatory") %></font></th> 
        </tr>
       </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left" colspan=5><em></em></td>
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
			if(session.getValue("sessionid")== null)
			{
				
			}
			else if(session.getValue("sessionid") != null && request.getParameter("reg_boardid") != null && request.getParameter("reg_coursepubid_hidden") != null )
			{
				String reg_coursepubid = request.getParameter("reg_coursepubid_hidden"); 
				String reg_sessionid =session.getValue("sessionid")+"";
				reg_boardid = request.getParameter("reg_boardid");
				reg_examid = request.getParameter("reg_examid");
				standardList = registrationQuery.listStandard(reg_sessionid,reg_boardid);
				sectionList = registrationQuery.listSections(reg_coursepubid);
				//System.out.println("reg_coursepubid11-->"+reg_coursepubid+"sectionList11-->"+sectionList);
			}

			
				
			
			else if(session.getValue("sessionid") != null && request.getParameter("reg_boardid") != null)
			{
				String reg_sessionid =session.getValue("sessionid")+"";
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

			//ArrayList yearList = registrationQuery.listYearofSession();
		%>
			<tr>
				<td class=tablebold><%=bundle.getString("hmlabel.examresultpublish.academicyear")%> </td><td width=1px class=tablebold>:</td><td>
					<%=session.getValue("sessionname") %>
				</td>
				<td class=tablebold><%=bundle.getString("hmlabel.examresultpublish.board")%><font color=red>&nbsp;*</font></td>
				<td width=1px class=tablebold>:</td><td>
					<select name=boardname class=tablelight onchange=loadExam() style='width:150px'>
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
				<td class=tablebold><%=bundle.getString("hmlabel.examresultpublish.exam")%>:<font color=red>&nbsp;*</font></td>
				<td width=1px class=tablebold>:</td><td>
					<select name=examname class=tablelight onchange=loadStandard() style='width:150px'>
						<option value="00">-Select Exam Name-</option>
						<%
						if(session.getValue("sessionid")!=null)
							try{
								String reg_sessionid = session.getValue("sessionid")+"";
								//System.out.println("reg_sessionid>>>>"+reg_sessionid);
								//ExamList=examAllotmentQuery.LoadExamnameList(reg_sessionid);
								ExamList=registrationQuery.loadAllotedExamforSession(reg_sessionid);
								//System.out.println("ExamList>>>>"+ExamList);
								}catch(Exception e){}
					      	if(ExamList!=null && ExamList.size()>0)
							{
					      		ArrayList templist=new ArrayList();

			  		 			for (int i = 0, j = 1; i < ExamList.size(); i++) 
			  		 			{
									HashMap ExamListMap=(HashMap)ExamList.get(i);
									String examId     = (String)ExamListMap.get("examnameid");
									//System.out.println("examId>>>>>>>>>>"+examId);
									String examName      = (String)ExamListMap.get("examname");
									String examallotmentId     = (String)ExamListMap.get("examallotmentid");
									//System.out.println("EXAM ID-->"+examId+"<-->"+reg_examid);
									if(!templist.contains(examId))
									{									
									if(examId.equals(reg_examid))
									{
										out.println("<option selected value='"+examId+"' class=tablelight >"+examName+"</option>");
									}
									else
									{
										out.println("<option value='"+examId+"' class=tablelight >"+examName+"</option>");
									}
									templist.add(examId);
									}
						  		 }
							}
						%>
					</select>
				</td>
				<td class=tablebold><%=bundle.getString("hmlabel.examresultpublish.standard")%><font color=red>&nbsp;*</font></td>
				<!-- //hidden by rams,reason- load the result based on the standard
				<td width=1px class=tablebold>:</td><td><select name=course class=tablelight onchange=loadSection() style='width:150px'> -->
				<td width=1px class=tablebold>:</td><td><select name=course class=tablelight  style='width:150px'>
				
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
								
								//out.println("<option value='"+standardscheduleid+"'>"+standardname+"</option>");
							}
						}
					%>
					</select>
				</td>
			</tr>
			<%--
			//hidden by rams,reason- load the result based on the standard <tr>
				<td class=tablebold><%=bundle.getString("hmlabel.examresultpublish.section")%>:<font color=red>&nbsp;*</font></td>
				<td width=1px class=tablebold>:</td><td colspan=4><select name=section class=tablelight  style='width:150px'>
					<option value="00">-Select Section-</option>
					<%
					//System.out.println("sectionList-->"+sectionList);

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
								//reg_sectionpubid
								//out.println("<option value='"+sectionSchedId+"'>"+sectionName+"</option>");
							}
						}
					//out.println("<option value='1'>A</option>");
					%>
					</select>
				</td>
			</tr> --%>
				</table>
			<a href="#" class="bt_blue" onclick="viewStudent()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("hmbutton.examresultpublish.viewstudents")%></strong><span class="bt_blue_r"></span></a>

	</div><!-- end of right content-->


	</div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->

	<%@ include file="../include/footer.jsp" %>

	</div>
</form>
</body>
</html>