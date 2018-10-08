<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.tracking.studentlisttitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">

	function resetBoard()
	{
		document.ApplicantSearch.boardname.value = "00";
		document.ApplicantSearch.course.value = "00";
		document.ApplicantSearch.section.value = "00";
	}
	
	function loadStandard()
	{
		//document.ApplicantSearch.req_sessionid.value  = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value
		document.ApplicantSearch.req_boardid.value  = document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
		//alert(document.ApplicantSearch.req_sessionid.value+"--"+document.ApplicantSearch.req_boardid.value)
		document.ApplicantSearch.submit();
	
	}
	
	function loadSection()
	{
		//document.ApplicantSearch.req_sessionid.value			=	document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value
		document.ApplicantSearch.req_boardid.value  			=	document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
		document.ApplicantSearch.reg_coursepubid_hidden.value  	= 	document.ApplicantSearch.course.options[document.ApplicantSearch.course.options.selectedIndex].value;
		document.ApplicantSearch.submit();
	}
	
	function viewStudent()
	{
		//document.ApplicantSearch.req_sessionid.value  = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
		document.ApplicantSearch.req_boardid.value  = document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
		document.ApplicantSearch.standardpublishid.value  = document.ApplicantSearch.course.options[document.ApplicantSearch.course.options.selectedIndex].value;
		document.ApplicantSearch.req_sectionpubid.value  = document.ApplicantSearch.section.options[document.ApplicantSearch.section.options.selectedIndex].value;
		
		var flag=true;
	
	
		//if(document.ApplicantSearch.req_sessionid.value=="00")
		//{
			//alert("Select Academic Year")
					//document.ApplicantSearch.sessionname.focus();
		
		//}
		
		if(document.ApplicantSearch.req_boardid.value=="00")
		{
			alert("Select Board")
			document.ApplicantSearch.boardname.focus();
		
		}
		else if(document.ApplicantSearch.standardpublishid.value=="00")
		{
			alert("Select Standard")
			document.ApplicantSearch.course.focus();
		
		}
		else if(document.ApplicantSearch.req_sectionpubid.value=="00")
		{
			alert("Select Section")
			document.ApplicantSearch.section.focus();
		
		}
		
		else
		{
			//document.ApplicantSearch.req_sessionid.value  	= document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
			//document.ApplicantSearch.req_sessionname.value  = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
		
			document.ApplicantSearch.req_boardid.value  	= document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
			document.ApplicantSearch.req_boardname.value  	= document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].text;
		
			document.ApplicantSearch.standardpublishid.value  = document.ApplicantSearch.course.options[document.ApplicantSearch.course.options.selectedIndex].value;
			document.ApplicantSearch.standardnamegp.value  	= document.ApplicantSearch.course.options[document.ApplicantSearch.course.options.selectedIndex].text;

			document.ApplicantSearch.req_sectionpubid.value = document.ApplicantSearch.section.options[document.ApplicantSearch.section.options.selectedIndex].value;
			document.ApplicantSearch.req_sectionname.value  = document.ApplicantSearch.section.options[document.ApplicantSearch.section.options.selectedIndex].text;
	
			document.ApplicantSearch.action="MyStudentsView.jsp";
			document.ApplicantSearch.submit();
		}
	
	}
	
</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>
<body bgcolor="#2B303E" topmargin="0" bottommargin="0">
<form name="ApplicantSearch" action="" method="post">
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

    <h2><%=bundle.getString("label.tracking.studentlistrootpath") %></h2>


	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    		<tr>
        	
            	<th scope="col" class="rounded-company" width="85%"><%=bundle.getString("label.tracking.MyStudentList") %></th>
            	<th scope="col" class="rounded-q4" width="15%"><font color=red>*</font><%=bundle.getString("label.common.mandatory") %></th>        
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
		<input type=hidden name=req_sessionname value="<%=session.getValue("sessionname")%>">
		<input type=hidden name=standardnamegp>
		<input type=hidden name=standardpublishid>
		<input type=hidden name=reg_coursepubid_hidden>
		<input type=hidden name=req_sectionname>
		<input type=hidden name=req_sectionpubid>
		

		<%
		try
	    {
    	
	    	//out.println("<script>alert('"+session.getValue("userid")+"')</script>");
	    	//BoardList = standardQuery.listBoard(instituteid);
   
			
			com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();	
			com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
			ArrayList standardList =  null;
			ArrayList sectionList =  null;
			String req_boardid 	 = null;
		    String instituteid = null;
		    String personid = null;
		    String sessionid		= (String)session.getValue("sessionid");
		    ArrayList BoardList = null;
		    		    
	    	instituteid	= (String)session.getValue("instituteid");
	    	personid	= (String)session.getValue("userid");
	    	ArrayList yearList = registrationQuery.listActiveYearofSession(instituteid);
	    	if(request.getParameter("req_sessionid") == null)
			{
			}
			else if(request.getParameter("req_sessionid") != null && request.getParameter("req_boardid") != null && request.getParameter("reg_coursepubid_hidden") != null)
			{
				String standardpublishid = request.getParameter("reg_coursepubid_hidden"); 
				String req_sessionid = request.getParameter("req_sessionid");
				req_boardid = request.getParameter("req_boardid");
				//standardList = registrationQuery.listStandard(req_sessionid,req_boardid);
				standardList = registrationQuery.loadStandardForStaff(personid,req_sessionid,req_boardid);
				//sectionList = registrationQuery.listSections(standardpublishid);
				sectionList = registrationQuery.loadSectionForStaff(personid,standardpublishid);
				//System.out.println("reg_coursepubid11-->"+standardpublishid+"sectionList11-->"+sectionList);
			}
			else if(request.getParameter("req_sessionid") != null && request.getParameter("req_boardid") != null)
			{
				String req_sessionid = request.getParameter("req_sessionid");
				req_boardid = request.getParameter("req_boardid");
				//standardList = registrationQuery.listStandard(req_sessionid,req_boardid);
				standardList = registrationQuery.loadStandardForStaff(personid,req_sessionid,req_boardid);
				
			}
			
			//System.out.println("standardList-->"+standardList);
			//System.out.println("REQUEST"+request.getParameter("req_sessionid")+"--"+request.getParameter("req_boardid")+"--"+request.getParameter("reg_coursepubid_hidden"));			
	
		%>
			<tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">

			<tr>
				<td class=tablebold><%=bundle.getString("label.tracking.AcademicYear") %></td>
				<td class=tablebold>:</td><td>
				<%=session.getValue("sessionname")%>				
				</td>
			</tr>			
			<!--  <tr>
				<td class=tablebold>Academic Year<font color="red">*</font></td><td>
					<select name=sessionname class=tablelight onchange=resetBoard()>
						<option value="00">-Select Academic-</option>
						<%
							for(int s=0;s<yearList.size();s++)
							{
								HashMap map=(HashMap)yearList.get(s);
								sessionid=(String)map.get("sessionid");
								String yearofsession=(String)map.get("sessionname");
								//String session_status=(String)map.get("status");
								if(request.getParameter("req_sessionid") != null)
								{
									if(request.getParameter("req_sessionid").equals(sessionid))
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
			</tr>-->

			<tr>
				<td class=tablebold><%=bundle.getString("label.tracking.Board") %> <font color="red">*</font></td>
				<td class=tablebold>:</td><td>
					<select name=boardname class=tablelight onchange=loadStandard()>
						<option value="00">-Select Board-</option>
						<%
						BoardList = registrationQuery.loadBoardForStaff(personid,instituteid,sessionid);
					      	if(BoardList!=null && BoardList.size()>0)
							{
			  		 			for (int i = 0, j = 1; i < BoardList.size(); i++) 
			  		 			{
									HashMap boardListMap=(HashMap)BoardList.get(i);
									String boardId     = (String)boardListMap.get("boardid");
									String boardName      = (String)boardListMap.get("boardname");
									String mediumId      = (String)boardListMap.get("mediumid");
									String mediumName      = (String)boardListMap.get("mediumname");
									
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
				<td class=tablebold><%=bundle.getString("label.tracking.Standard") %> <font color="red">*</font></td>
				<td class=tablebold>:</td><td><select name=course class=tablelight onchange=loadSection()>
					<option value="00">-Select Standard-</option>
					<%
					

						if(standardList !=null && standardList.size() >0)
						{
							for(int s1=0;s1<standardList.size();s1++)
							{
								HashMap map1=(HashMap)standardList.get(s1);
								//String standardid=(String)map1.get("standardid");
								String standardname=(String)map1.get("standardname");
								String standardscheduleid=(String)map1.get("standardscheduleid");
								String groupname=(String)map1.get("groupname");
								if(!groupname.equals("NoGroup"))
								{												
									standardname = standardname+" - "+groupname; 
								}
								//System.out.println("standardscheduleid-->"+standardscheduleid);
								//System.out.println("standardpublishid-->"+request.getParameter("reg_coursepubid_hidden"));
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
			<tr>
				<td class=tablebold><%=bundle.getString("label.tracking.Section") %> <font color="red">*</font></td>
				<td class=tablebold>:</td><td><select name=section class=tablelight >
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
								out.println("<option value='"+sectionSchedId+"'>"+sectionName+"</option>");
							}
						}
					//out.println("<option value='1'>A</option>");
					%>
					</select>
				</td>
			</tr>

						
			</table></td></tr>
			</table>

				<!--  <a href="#" class="bt_red" onclick="goBack()"><span class="bt_red_lft"></span><strong>Back</strong><span class="bt_red_r"></span></a>-->
    			<a href="#" class="bt_blue" onclick="viewStudent()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.tracking.ViewStudents") %></strong><span class="bt_blue_r"></span></a>
  			<% }catch(Exception e){}%>  			
	</div><!-- end of right content-->


	</div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->

	<%@ include file="../include/footer.jsp" %>

	</div>
</form>
</body>
</html>