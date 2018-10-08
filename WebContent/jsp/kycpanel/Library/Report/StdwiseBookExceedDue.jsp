<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.bookexceedduedate.entrytitle")%>  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">

	function loadStandard()
	{
		document.StdwiseBookForm.req_boardid.value  = document.StdwiseBookForm.boardname.options[document.StdwiseBookForm.boardname.options.selectedIndex].value;
		//document.StdwiseBookForm.req_examnameid.value  = document.StdwiseBookForm.examname.options[document.StdwiseBookForm.examname.options.selectedIndex].value;
		//alert(document.StdwiseBookForm.examname.options[document.StdwiseBookForm.examname.options.selectedIndex].value)
		document.StdwiseBookForm.submit();
	
	}
	
	function loadSection()
	{
		//document.StdwiseBookForm.req_sessionid.value			=	document.StdwiseBookForm.sessionname.options[document.StdwiseBookForm.sessionname.options.selectedIndex].value
		document.StdwiseBookForm.req_boardid.value  			=	document.StdwiseBookForm.boardname.options[document.StdwiseBookForm.boardname.options.selectedIndex].value;
		document.StdwiseBookForm.reg_standardpubid_hidden.value = 	document.StdwiseBookForm.course.options[document.StdwiseBookForm.course.options.selectedIndex].value;
		//document.StdwiseBookForm.req_examnameid.value  			= document.StdwiseBookForm.examname.options[document.StdwiseBookForm.examname.options.selectedIndex].value;
		document.StdwiseBookForm.submit();
	
	}
	
	function optionselect(obj)
	{
	var flage_temp=obj.value;
	if(flage_temp=="Book")
	{
	
			document.StdwiseBookForm.flage_temp.value="Book";
	
	}
	else
	{
			document.StdwiseBookForm.flage_temp.value="Journal";
	
	}
	}
	
	function viewStudent()
	{
		//document.StdwiseBookForm.req_sessionid.value  = document.StdwiseBookForm.sessionname.options[document.StdwiseBookForm.sessionname.options.selectedIndex].value;
		document.StdwiseBookForm.req_boardid.value  = document.StdwiseBookForm.boardname.options[document.StdwiseBookForm.boardname.options.selectedIndex].value;
		document.StdwiseBookForm.req_standardpubid.value  = document.StdwiseBookForm.course.options[document.StdwiseBookForm.course.options.selectedIndex].value;
		document.StdwiseBookForm.req_sectionpubid.value  = document.StdwiseBookForm.section.options[document.StdwiseBookForm.section.options.selectedIndex].value;
		var flag=true;
		if(document.StdwiseBookForm.req_boardid.value=="00")
		{
			alert("Select Board")
			document.StdwiseBookForm.boardname.focus();
		
		}
		else if(document.StdwiseBookForm.req_standardpubid.value=="00")
		{
			alert("Select Standard")
			document.StdwiseBookForm.course.focus();
		
		}
		else if(document.StdwiseBookForm.req_sectionpubid.value=="00")
		{
			alert("Select Section")
			document.StdwiseBookForm.section.focus();
		
		}
			else
		{
		
			var status=false;
			for(var i=0;i<document.StdwiseBookForm.selectoption.length;i++)
			{
				if(document.StdwiseBookForm.selectoption[i].checked)
				{
				status=true;
				}
				
			}
			if(status)
			{
			document.StdwiseBookForm.req_boardid.value  	= document.StdwiseBookForm.boardname.options[document.StdwiseBookForm.boardname.options.selectedIndex].value;
			document.StdwiseBookForm.req_boardname.value  	= document.StdwiseBookForm.boardname.options[document.StdwiseBookForm.boardname.options.selectedIndex].text;

			document.StdwiseBookForm.req_standardpubid.value  = document.StdwiseBookForm.course.options[document.StdwiseBookForm.course.options.selectedIndex].value;
			document.StdwiseBookForm.req_standardnamegp.value  	= document.StdwiseBookForm.course.options[document.StdwiseBookForm.course.options.selectedIndex].text;

			document.StdwiseBookForm.req_sectionpubid.value = document.StdwiseBookForm.section.options[document.StdwiseBookForm.section.options.selectedIndex].value;
			document.StdwiseBookForm.req_sectionname.value  = document.StdwiseBookForm.section.options[document.StdwiseBookForm.section.options.selectedIndex].text;
			
			document.StdwiseBookForm.reg_standardpubid_hidden.value = document.StdwiseBookForm.course.options[document.StdwiseBookForm.course.options.selectedIndex].value;
			document.StdwiseBookForm.action="StdwiseBookExceedDueList.jsp";
			document.StdwiseBookForm.submit();				
			
			}
			else
			{
				
			alert("Select Book or Journal Option");
			return false;
			}			
	

		}
	}
</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>
<body bgcolor="#2B303E" topmargin="0" bottommargin="0">
<form name="StdwiseBookForm" action="" method="post">
<input type="hidden" name="flage_temp" value="">
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

    <h2>Report / Due Date Exceeded / Standardwise Due Date Exceeded</h2>


	<table id="rounded-corner" border=0 width="100%">
    	<thead>
    	<tr>
        	 <th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.bookexceedduedate.entrytitle")%></th>      
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> Mandatory Fields</th> 
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
					<select name=boardname class=tablelight onchange=loadStandard() style='width:150px'>
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
			
			<tr>
	   		 <td align="center" colspan=6>
	   
		    <input type="radio" name="selectoption" value="Book" onclick="optionselect(this)"><font size=3>Book</font>&nbsp;&nbsp;
		    <input type="radio" name="selectoption" value="Journal" onclick="optionselect(this)"><font size=3>Journal</font>
   
		    </td>
		    </tr>			
				</table></td></tr>
				
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