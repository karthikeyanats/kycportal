<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.topperweaker.header")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>


<script type="text/javascript">

	function View()
	{
		document.GradeWiseForm.action="ApplicantView.jsp";
		document.GradeWiseForm.submit();
	}
	function loadExam()
	{
		document.GradeWiseForm.reg_boardid.value  = document.GradeWiseForm.boardname.options[document.GradeWiseForm.boardname.options.selectedIndex].value
		document.GradeWiseForm.reg_examid.value  = document.GradeWiseForm.examname.options[document.GradeWiseForm.examname.options.selectedIndex].value;
		document.GradeWiseForm.submit();
	
	}

	function loadStandard()
	{
		document.GradeWiseForm.reg_boardid.value  = document.GradeWiseForm.boardname.options[document.GradeWiseForm.boardname.options.selectedIndex].value;
		document.GradeWiseForm.reg_examid.value  = document.GradeWiseForm.examname.options[document.GradeWiseForm.examname.options.selectedIndex].value;
		document.GradeWiseForm.submit();
	
	}
	
	function loadSection()
	{
		document.GradeWiseForm.reg_boardid.value  			=	document.GradeWiseForm.boardname.options[document.GradeWiseForm.boardname.options.selectedIndex].value;
		document.GradeWiseForm.reg_coursepubid_hidden.value = 	document.GradeWiseForm.course.options[document.GradeWiseForm.course.options.selectedIndex].value;
		document.GradeWiseForm.reg_examid.value  			= document.GradeWiseForm.examname.options[document.GradeWiseForm.examname.options.selectedIndex].value;
		document.GradeWiseForm.submit();
	
	}
	function loadSubject()
	{
		document.GradeWiseForm.reg_boardid.value  			=	document.GradeWiseForm.boardname.options[document.GradeWiseForm.boardname.options.selectedIndex].value;
		document.GradeWiseForm.reg_coursepubid_hidden.value = 	document.GradeWiseForm.course.options[document.GradeWiseForm.course.options.selectedIndex].value;
		document.GradeWiseForm.reg_examid.value  			= document.GradeWiseForm.examname.options[document.GradeWiseForm.examname.options.selectedIndex].value;
		document.GradeWiseForm.reg_sectionpubid.value		= document.GradeWiseForm.section.options[document.GradeWiseForm.section .options.selectedIndex].value;
		document.GradeWiseForm.submit();
	
	}
	function ViewStudentChart()
	{
		document.GradeWiseForm.reg_boardid.value  = document.GradeWiseForm.boardname.options[document.GradeWiseForm.boardname.options.selectedIndex].value;
		document.GradeWiseForm.reg_coursepubid.value  = document.GradeWiseForm.course.options[document.GradeWiseForm.course.options.selectedIndex].value;
		document.GradeWiseForm.reg_sectionpubid.value  = document.GradeWiseForm.section.options[document.GradeWiseForm.section.options.selectedIndex].value;
		var flag=true;
	
		 if(document.GradeWiseForm.reg_boardid.value=="00")
		{
			alert("Select Board")
			document.GradeWiseForm.boardname.focus();
			return false;
		
		}
		if(document.GradeWiseForm.examname.value=="00")
		{
			alert("Select Exam")
			document.GradeWiseForm.examname.focus();
			return false;
		
		}
		if(document.GradeWiseForm.reg_coursepubid.value=="00")
		{
			alert("Select Standard")
			document.GradeWiseForm.course.focus();
			return false;
		
		}
		if(document.GradeWiseForm.reg_sectionpubid.value=="00")
		{
			alert("Select Section")
			document.GradeWiseForm.section.focus();
			return false;
		}
		if(!check_ForParticularElements(document.GradeWiseForm.grade,"select"))
		{
			return false;
		}
		else
		{
			
			document.GradeWiseForm.reg_boardid.value  	  = document.GradeWiseForm.boardname.options[document.GradeWiseForm.boardname.options.selectedIndex].value;
			document.GradeWiseForm.reg_boardname.value 	  = document.GradeWiseForm.boardname.options[document.GradeWiseForm.boardname.options.selectedIndex].text;
	
			document.GradeWiseForm.reg_examid.value  	  = document.GradeWiseForm.examname.options[document.GradeWiseForm.examname.options.selectedIndex].value;
			document.GradeWiseForm.reg_examname.value  	  = document.GradeWiseForm.examname.options[document.GradeWiseForm.examname.options.selectedIndex].text;
			
			document.GradeWiseForm.reg_coursepubid.value  = document.GradeWiseForm.course.options[document.GradeWiseForm.course.options.selectedIndex].value;
			document.GradeWiseForm.reg_coursename.value   = document.GradeWiseForm.course.options[document.GradeWiseForm.course.options.selectedIndex].text;

			document.GradeWiseForm.reg_sectionpubid.value = document.GradeWiseForm.section.options[document.GradeWiseForm.section.options.selectedIndex].value;
			document.GradeWiseForm.reg_sectionname.value  = document.GradeWiseForm.section.options[document.GradeWiseForm.section.options.selectedIndex].text;
			var gradename="";
			for( var i=0;i<document.GradeWiseForm.grade.options.length;i++)
			{
				if(document.GradeWiseForm.grade.options[i].selected==true)
					{
					gradename +=document.GradeWiseForm.grade.options[i].text ;
					gradename +=",";
					}
			}
	
			document.GradeWiseForm.gradename.value  = gradename;
			document.GradeWiseForm.reg_coursepubid_hidden.value = document.GradeWiseForm.course.options[document.GradeWiseForm.course.options.selectedIndex].value;
			document.GradeWiseForm.action="GradeWiseStudentView.jsp";
			document.GradeWiseForm.submit();
		}
	}
</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.GradeSetting.GradeScaleQuery"%>
<body bgcolor="#2B303E" topmargin="0" bottommargin="0">
<form name="GradeWiseForm" action="" method="post">
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
<%

if(loginusercategory.equals("SA"))
{
%>
    <h2><%=bundle.getString("label.topperweaker.rootpath")%></h2>
<%
}else
{ %>
<h2><%=bundle.getString("label.topperweaker.princirootpath")%></h2>  
<%} %>

	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    		<tr>
            	<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.topperweaker.header")%></th>
            	<th scope="col" class="rounded-q4" width="10"></th>        
        	</tr>
    	</thead>
    
        <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
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
		<input type=hidden name=gradename>
		
		

		<%
			com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();	
			com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
			com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examAllotmentQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
		      PrinicipalQuery  principalQuery = new PrinicipalQuery();
		      GradeScaleQuery gradescaleQuery = new GradeScaleQuery();

			ArrayList standardList =  null;
			ArrayList sectionList =  null;
			ArrayList subjectList =  null;
			String reg_boardid 	 = null;
			String reg_sessionid = session.getValue("sessionid")+"";
			String reg_subjectschid 	 = null;
			String reg_sectionpubid=null;
			String reg_examid 	 = null;
			ArrayList ExamList = null;
		    ArrayList	GradeList	=	new ArrayList();;
			com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();

			if(session.getValue("sessionid")== null)
			{
				
			}
			else if(session.getValue("sessionid") != null && request.getParameter("reg_boardid") != null && request.getParameter("reg_coursepubid_hidden") != null )
			{
				String reg_coursepubid = request.getParameter("reg_coursepubid_hidden"); 
				 reg_sessionid =session.getValue("sessionid")+"";
				reg_boardid  = request.getParameter("reg_boardid");
				reg_examid   = request.getParameter("reg_examid");
				standardList = examQuery.listStandardforexam(reg_sessionid,reg_boardid,reg_examid);
				sectionList  = registrationQuery.listSections(reg_coursepubid);
				//out.print(reg_coursepubid);
				//GradeList	 =	(ArrayList)principalQuery.LoadGradeList(reg_sessionid);
				GradeList	 =	(ArrayList)gradescaleQuery.LoadGradeScaleList(reg_coursepubid);
			}
			else if(session.getValue("sessionid") != null && request.getParameter("reg_boardid") != null)
			{
				 reg_sessionid =session.getValue("sessionid")+"";
				reg_boardid = request.getParameter("reg_boardid");
				reg_examid = request.getParameter("reg_examid");
				standardList = examQuery.listStandardforexam(reg_sessionid,reg_boardid,reg_examid);
			}
			
			
			
			//System.out.println("REQUEST"+request.getParameter("reg_sessionid")+"--"+request.getParameter("reg_boardid")+"--"+request.getParameter("reg_coursepubid_hidden"));			
		    String instituteid = null;
		    ArrayList BoardList = null;
		    
		    
		    try
		    {
		    	instituteid = (String)session.getValue("instituteid");
		    	//BoardList = standardQuery.listBoard(instituteid);
		    	BoardList	= examQuery.loadBoardListMarkPublished(instituteid,reg_sessionid);
		    }catch(Exception e){}

			//ArrayList yearList = registrationQuery.listYearofSession();
		%>
			<tr><td colspan="2"><table border=0 align=center id="rounded-corner1" width="100%">
			<tr>
				<td class=tablebold><%=bundle.getString("label.topperweaker.AcademicYear")%></td>
				<td class=tablebold width="2%">:</td>
				<td>
					<%=session.getValue("sessionname") %>
				</td>
				
				<td class=tablebold><%=bundle.getString("label.topperweaker.Board")%> </td>
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
				<td class=tablebold><%=bundle.getString("label.topperweaker.ExamName")%> </td>
				<td class=tablebold width="2%">:</td>
				<td>
					<select name=examname class=tablelight onchange=loadStandard() style='width:150px'>
						<option value="00">-Select Exam Name-</option>
						<%
						if(session.getValue("sessionid")!=null)
							try{
								reg_sessionid = session.getValue("sessionid")+"";
								//System.out.println("reg_sessionid>>>>"+reg_sessionid);
								//ExamList=examAllotmentQuery.LoadExamnameList(reg_sessionid);
								//ExamList=registrationQuery.loadAllotedExamforSession(reg_sessionid);
								ExamList			= examQuery.loadExamNameMarkPublished(reg_sessionid,reg_boardid);
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
				<td class=tablebold><%=bundle.getString("label.topperweaker.Standard")%> </td>
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
			<tr valign=top>
				<td class=tablebold><%=bundle.getString("label.topperweaker.section")%> </td>
				<td class=tablebold width="2%">:</td>
				<td><select name=section class=tablelight onchange=loadSubject() style='width:150px'>
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
							
							}
						}
					%>
					</select>
				</td>
				<td class=tablebold><%=bundle.getString("label.topperweaker.grade")%> </td>
				<td class=tablebold width="2%">:</td>
				<td><select name=grade class=tablelight style='width:150px' multiple size=4>
					<option value="00">-Select Grade-</option>
					<%
					if(GradeList !=null && GradeList.size() >0)
					{	
						for(int i2=0;i2<GradeList.size();i2++)
						{
							HashMap map=(HashMap)GradeList.get(i2);
							String Gradename=map.get("gradename")+"";
							//String gradeid=(String)map.get("gradesystemid");
							String gradeid=(String)map.get("gradeid");
							out.println("<option value='"+gradeid+"' class=tablelight >"+Gradename+"</option>");
						}
					}
					%>
					</select>
				</td>
			</tr>
				</table></td></tr>
			</table>
				<a href="#" class="bt_blue" onclick="ViewStudentChart()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.topperweaker.view")%></strong><span class="bt_blue_r"></span></a>
	</div><!-- end of right content-->
	</div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->

	<%@ include file="../include/footer.jsp" %>

	</div>
</form>
</body>
</html>