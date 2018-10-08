<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.exammark.title")%>  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">

	function loadExam()
	{
		document.ExammarkEntryForm.req_boardid.value  = document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].value
		//document.ExammarkEntryForm.req_sessionid.value  = document.ExammarkEntryForm.sessionname.options[document.ExammarkEntryForm.sessionname.options.selectedIndex].value
		document.ExammarkEntryForm.req_examnameid.value  = document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].value;
		document.ExammarkEntryForm.submit();
	
	}

	function loadStandard()
	{
		//document.ExammarkEntryForm.req_sessionid.value  = document.ExammarkEntryForm.sessionname.options[document.ExammarkEntryForm.sessionname.options.selectedIndex].value
		document.ExammarkEntryForm.req_boardid.value  = document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].value;
		document.ExammarkEntryForm.req_examnameid.value  = document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].value;
		//alert(document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].value)
		document.ExammarkEntryForm.submit();
	
	}
	
	function loadSection()
	{
		//document.ExammarkEntryForm.req_sessionid.value			=	document.ExammarkEntryForm.sessionname.options[document.ExammarkEntryForm.sessionname.options.selectedIndex].value
		document.ExammarkEntryForm.req_boardid.value  			=	document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_standardpubid_hidden.value = 	document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].value;
		document.ExammarkEntryForm.req_examnameid.value  			= document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].value;
		document.ExammarkEntryForm.submit();
	
	}
	function loadSubject()
	{
		//document.ExammarkEntryForm.req_sessionid.value			=	document.ExammarkEntryForm.sessionname.options[document.ExammarkEntryForm.sessionname.options.selectedIndex].value
		document.ExammarkEntryForm.req_boardid.value  			=	document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].value;
		document.ExammarkEntryForm.reg_standardpubid_hidden.value = 	document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].value;
		document.ExammarkEntryForm.req_examnameid.value  			= document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].value;
		document.ExammarkEntryForm.req_sectionpubid.value		= document.ExammarkEntryForm.section.options[document.ExammarkEntryForm.section .options.selectedIndex].value;
		document.ExammarkEntryForm.req_subjectschid.value		= document.ExammarkEntryForm.subjectname.options[document.ExammarkEntryForm.subjectname.options.selectedIndex].value;
		document.ExammarkEntryForm.submit();
	
	}
	
	function viewStudent()
	{
		//document.ExammarkEntryForm.req_sessionid.value  = document.ExammarkEntryForm.sessionname.options[document.ExammarkEntryForm.sessionname.options.selectedIndex].value;
		document.ExammarkEntryForm.req_boardid.value  = document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].value;
		document.ExammarkEntryForm.req_standardpubid.value  = document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].value;
		document.ExammarkEntryForm.req_sectionpubid.value  = document.ExammarkEntryForm.section.options[document.ExammarkEntryForm.section.options.selectedIndex].value;
		var flag=true;
		if(document.ExammarkEntryForm.req_boardid.value=="00")
		{
			alert("Select Board")
			document.ExammarkEntryForm.boardname.focus();
		
		}
		else if(document.ExammarkEntryForm.examname.value=="00")
		{
			alert("Select Exam")
			document.ExammarkEntryForm.examname.focus();
		
		}
		else if(document.ExammarkEntryForm.req_standardpubid.value=="00")
		{
			alert("Select Standard")
			document.ExammarkEntryForm.course.focus();
		
		}
		else if(document.ExammarkEntryForm.req_sectionpubid.value=="00")
		{
			alert("Select Section")
			document.ExammarkEntryForm.section.focus();
		
		}
			else
		{
			//document.ExammarkEntryForm.req_sessionid.value  	= document.ExammarkEntryForm.sessionname.options[document.ExammarkEntryForm.sessionname.options.selectedIndex].value;
			//document.ExammarkEntryForm.req_sessionname.value  = document.ExammarkEntryForm.sessionname.options[document.ExammarkEntryForm.sessionname.options.selectedIndex].text;
		
			document.ExammarkEntryForm.req_boardid.value  	= document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].value;
			document.ExammarkEntryForm.req_boardname.value  	= document.ExammarkEntryForm.boardname.options[document.ExammarkEntryForm.boardname.options.selectedIndex].text;
			document.ExammarkEntryForm.req_examnameid.value  	= document.ExammarkEntryForm.examname.value;
			document.ExammarkEntryForm.req_examname.value  	= document.ExammarkEntryForm.examname.options[document.ExammarkEntryForm.examname.options.selectedIndex].text;
			
			//document.ExammarkEntryForm.reg_ctypeid.value  	= document.ExammarkEntryForm.ctype.options[document.ExammarkEntryForm.ctype.options.selectedIndex].value;
			//document.ExammarkEntryForm.reg_ctypetext.value  = document.ExammarkEntryForm.ctype.options[document.ExammarkEntryForm.ctype.options.selectedIndex].text;
		
			document.ExammarkEntryForm.req_standardpubid.value  = document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].value;
			document.ExammarkEntryForm.req_standardnamegp.value  	= document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].text;

			document.ExammarkEntryForm.req_sectionpubid.value = document.ExammarkEntryForm.section.options[document.ExammarkEntryForm.section.options.selectedIndex].value;
			document.ExammarkEntryForm.req_sectionname.value  = document.ExammarkEntryForm.section.options[document.ExammarkEntryForm.section.options.selectedIndex].text;
			
			document.ExammarkEntryForm.reg_standardpubid_hidden.value = document.ExammarkEntryForm.course.options[document.ExammarkEntryForm.course.options.selectedIndex].value;
			document.ExammarkEntryForm.action="ExamMarkView.jsp";
			document.ExammarkEntryForm.submit();
		}
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
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.exammark.rootpathadmin")%></h2>


	<table id="rounded-corner" border=0 width="100%">
    	<thead>
    	<tr>
        	 <th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.exammark.ExamMark")%></th>      
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.common.mandatory") %></th> 
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       	</tr>
    	</tfoot>

		<input type=hidden name=req_sessionid value=<%=session.getValue("sessionid")%>>
		<input type=hidden name=req_boardid>
		<input type=hidden name=req_boardname>
		<input type=hidden name=req_examnameid>
		<input type=hidden name=req_examname>
		<input type=hidden name=req_sessionname value="<%=session.getValue("sessionname")%>">
		<input type=hidden name=req_standardnamegp>
		<input type=hidden name=req_standardpubid>
		<input type=hidden name=reg_standardpubid_hidden>
		<input type=hidden name=req_sectionname>
		<input type=hidden name=req_sectionpubid>
		<input type=hidden name=req_subjectschid>
		<input type=hidden name=req_subjectname>

				

		<%
			com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();	
			com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
			com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examAllotmentQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
			
			ArrayList standardList =  null;
			ArrayList sectionList =  null;
			ArrayList subjectList =  null;
			String req_boardid 	 = null;
			String req_subjectschid 	 = null;
			String req_sectionpubid=null;
			String req_examnameid 	 = null;
			ArrayList ExamList = null;
			if(request.getParameter("req_sessionid") == null)
			{
				//System.out.println("reg_coursepubid11-->"+session.getValue("sessionid")+"sectionList11-->"+sectionList);

			}
			else if(request.getParameter("req_sessionid") != null && request.getParameter("req_boardid") != null && request.getParameter("reg_standardpubid_hidden") != null )
			{
				String req_standardpubid = request.getParameter("reg_standardpubid_hidden"); 
				String req_sessionid = request.getParameter("req_sessionid");
				req_boardid = request.getParameter("req_boardid");
				req_examnameid = request.getParameter("req_examnameid");
				standardList = registrationQuery.listStandard(req_sessionid,req_boardid);
				sectionList = registrationQuery.listSections(req_standardpubid);
			}
			else if(request.getParameter("req_sessionid") != null && request.getParameter("req_boardid") != null)
			{
				String req_sessionid = request.getParameter("req_sessionid");
				req_boardid = request.getParameter("req_boardid");
				standardList = registrationQuery.listStandard(req_sessionid,req_boardid);
			}
			
			
			
			//System.out.println("REQUEST"+request.getParameter("req_sessionid")+"--"+request.getParameter("req_boardid")+"--"+request.getParameter("reg_standardpubid_hidden"));			
		    String instituteid = null;
		    ArrayList BoardList = null;
		    
		    
		    try
		    {
		    	instituteid = (String)session.getValue("instituteid");
		    	BoardList = standardQuery.listBoard(instituteid);
		    }catch(Exception e){}

			//ArrayList yearList = registrationQuery.listYearofSession();
		%>
			<tr><td colspan="2"><table border=0 align=center id="rounded-corner1" width="100%">
			<tr>
				<td class=tablebold><%=bundle.getString("label.exam.AcademicYear")%></td>
				<td class=tablebold width="2%">:</td>
				<td><%=session.getValue("sessionname") %></td>
				<td class=tablebold><%=bundle.getString("label.exam.Board")%><font color="red">*</font></td>
				<td class=tablebold width="2%">:</td>
				<td>
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
					</select>
				</td>
			</tr>
			<tr>
				<td class=tablebold><%=bundle.getString("label.exam.ExamName")%><font color="red">*</font></td>
				<td class=tablebold width="2%">:</td>
				<td>
					<select name=examname class=tablelight onchange=loadStandard() style='width:150px'>
						<option value="00" >-Select Exam Name-</option>
						<%
						if(request.getParameter("req_sessionid")!=null)
							try{
								String req_sessionid = request.getParameter("req_sessionid");
								//System.out.println("req_sessionid>>>>"+req_sessionid);
								//ExamList=examAllotmentQuery.LoadExamnameList(req_sessionid);
								ExamList=registrationQuery.loadAllotedExamforSession(req_sessionid);
								//System.out.println("req_sessionid>>>>"+req_sessionid);

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
									//System.out.println("EXAM ID-->"+examId+"<-->"+req_examnameid);
									if(!templist.contains(examId))
									{			
									if(examId.equals(req_examnameid))
									{
										out.println("<option selected=true value='"+examId+"' class=tablelight >"+examName+"</option>");
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
				<td class=tablebold><%=bundle.getString("label.exam.Standard")%> <font color="red">*</font></td>
				<td class=tablebold width="2%">:</td>
				<td><select name=course class=tablelight onchange=loadSection() style='width:150px'>  
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
								//System.out.println("req_standardpubid-->"+request.getParameter("reg_standardpubid_hidden"));
								if(standardscheduleid.equals(request.getParameter("reg_standardpubid_hidden")))
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
			<tr>
				<td class=tablebold><%=bundle.getString("label.exam.Section")%> <font color="red">*</font></td>
				<td class=tablebold width="2%">:</td>
				<td><select name=section class=tablelight style='width:150px'>
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
								if(sectionSchedId.equals(request.getParameter("req_sectionpubid")))
								{
									out.println("<option selected value='"+sectionSchedId+"' class=tablelight >"+sectionName+"</option>");
								}
								else
								{
									out.println("<option value='"+sectionSchedId+"' class=tablelight >"+sectionName+"</option>");
								}
								//req_sectionpubid
								//out.println("<option value='"+sectionSchedId+"'>"+sectionName+"</option>");
							}
						}
					//out.println("<option value='1'>A</option>");
					%>
					</select>
				</td>
			</tr>
				</table></td></tr>
			</table>

				<a href="#" class="bt_blue" onclick="viewStudent()"><span class="bt_blue_lft"></span><strong>View Students</strong><span class="bt_blue_r"></span></a>

	</div><!-- end of right content-->


	</div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->

	<%@ include file="../include/footer.jsp" %>

	</div>
</form>
</body>
</html>