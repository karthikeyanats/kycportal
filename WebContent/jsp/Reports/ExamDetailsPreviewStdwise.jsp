<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Archival Reports | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">

	function resetBoard()
	{
		document.ApplicantSearch.boardname.value = "00";
		document.ApplicantSearch.course.value = "00";
		document.ApplicantSearch.reg_sessionid.value  = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
		document.ApplicantSearch.req_sessionname.value = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("sessionname");
	}
	
	function loadStandard()
	{
		document.ApplicantSearch.reg_sessionid.value  = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value
		document.ApplicantSearch.req_sessionname.value = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("sessionname");
		document.ApplicantSearch.reg_boardid.value  = document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
		document.ApplicantSearch.reg_boardname.value = document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].getAttribute("boardName");
	
		document.ApplicantSearch.action="ExamDetailsPreviewStdwise.jsp?reg_sessionid="+document.ApplicantSearch.reg_sessionid.value+"&reg_boardid="+document.ApplicantSearch.reg_boardid.value;
		document.ApplicantSearch.submit();
	
	}

	function generatepdf()
	{
	document.ApplicantSearch.action="ExamDetailsStdwisepdf.jsp";
	document.ApplicantSearch.submit();
	}
	function doCompletion()
	{
	var url = "";

	 //var url = "ExamDetailsStdwisepdf.jsp?req_sessionid="+document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.selectedIndex].value+"&req_sessionname="+document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.selectedIndex].text+"&req_boardid="+document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.selectedIndex].value+"&req_boardnname="+document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.selectedIndex].text+"&req_standardid="+document.ApplicantSearch.course.options[document.ApplicantSearch.course.selectedIndex].value+"&req_standardname="+document.ApplicantSearch.course.options[document.ApplicantSearch.course.selectedIndex].text;
	 var url = "ExamDetailsStdwisepdf.jsp?req_sessionid="+document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.selectedIndex].value+"&req_sessionname="+document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.selectedIndex].text+"&req_boardid="+document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.selectedIndex].value+"&req_boardname="+document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.selectedIndex].text;
	var req =initRequest();
	req.onreadystatechange = function()
	{
		if (req.readyState == 4)
		{
			{
				parseMessages1(req.responseXML,"download");
			}
		}else if(req.readyState ==500)
		{
			alert("Problem in download,Please try again");
		}
	};

	req.open("GET", url, true);
	req.send(null);




}
function parseMessages1(parseXML,flag)
{  
	
		if(flag=="download")
		{
			var rootObj=parseXML.getElementsByTagName("duplicate");
			var cNode_1=rootObj[0].childNodes.length;
			for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
				
				if(temp=="true")
				{
					zipathvalue=rootObj[0].childNodes.item(i).childNodes.item(1).firstChild.nodeValue;
					document.getElementById("fileopener").src=zipathvalue+"&r3=download";

				} 
				else
				{
				alert("No Data To Generate");     
			}
		}
}
	}
</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>
<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery"%>
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

    <h2>Reports / Archival Report Menu </h2>


	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    		<tr>
        		<th scope="col" class="rounded-company" width="10"></th>
            	<th scope="col" class="rounded" width="100%">Archival Reports</th>
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
		<input type=hidden name=reg_coursename>
		<input type=hidden name=reg_coursepubid>
		<input type=hidden name="req_sessionname">
		

		<%
	
			com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();	
			com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
			ArrayList standardList =  null;
			String reg_boardid 	 = null;
			if(request.getParameter("reg_sessionid") == null)
			{
			}
			else if(request.getParameter("reg_sessionid") != null && request.getParameter("reg_boardid") != null)
			{
				String reg_sessionid = request.getParameter("reg_sessionid");
				reg_boardid = request.getParameter("reg_boardid");
				standardList = registrationQuery.listStandard(reg_sessionid,reg_boardid);
			}
		    String instituteid = null;
		    ArrayList BoardList = null;
		    try
		    {
		    	instituteid = (String)session.getValue("instituteid");
		    	BoardList = standardQuery.listBoard(instituteid);
		    }catch(Exception e){}

			ArrayList yearList = registrationQuery.listArchiveYearofSession(instituteid);
			
			
			ArrayList ExamList=null;
			com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
			ExamAllotmentQuery exallot	= new ExamAllotmentQuery();
		
		
			
			
			String reg_sessionid=request.getParameter("reg_sessionid")+"";
			String req_sessionname=request.getParameter("req_sessionname")+"";

			String reg_boardname=request.getParameter("reg_boardname")+"";

			
			
		%>
			<tr><td><td><table border=0 align=center id="rounded-corner1" width="100%">
			<tr>
				<td class=tablebold>Academic Year<font color="red">*</font></td><td>
					<select name=sessionname class=tablelight onchange=resetBoard()>
						<option value="00">-Select Academic-</option>
						<%
							for(int s=0;s<yearList.size();s++)
							{
								HashMap map=(HashMap)yearList.get(s);
								String sessionid=(String)map.get("sessionid");
								String yearofsession=(String)map.get("sessionname");
								String session_status=(String)map.get("sessionstatus");
								if(request.getParameter("reg_sessionid") != null)
								{
									if(request.getParameter("reg_sessionid").equals(sessionid))
										out.println("<option selected value='"+sessionid+"' archivestatus='"+session_status+"' sessionname='"+yearofsession+"' >"+yearofsession+"</option>");
									else
										out.println("<option value='"+sessionid+"' archivestatus='"+session_status+"'>"+yearofsession+"</option>");
								}
								else
								{
									out.println("<option value='"+sessionid+"' archivestatus='"+session_status+"'>"+yearofsession+"</option>");
								}
							}
						%>
					</select>
				</td>
			
				<td class=tablebold>Board <font color="red">*</font></td>
				<td>
					<select name=boardname class=tablelight onchange=loadStandard()>
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
									
									if(boardId.equals(reg_boardid))
									{
										out.println("<option selected value='"+boardId+"' boardName='"+boardName+"' class=tablelight >"+boardName+"-"+mediumName+"</option>");
									}
									else
									{
										out.println("<option value='"+boardId+"' boardName='"+boardName+"' class=tablelight >"+boardName+"-"+mediumName+"</option>");
									}
									
									//out.println("<option value='"+boardid+"' class=tablelight >"+boardname+"-"+mediumname+"</option>");
						  		 }
							}
						%>
					</select>
				</td>
			</tr>
		<!--	<tr>
				<td class=tablebold>Standard <font color="red">*</font></td>
				<td><select name=course class=tablelight >
					<option value="00" >-Select Standard-</option>-->
					<%
				/*	if(standardList !=null && standardList.size() >0)
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
							        out.println("<option value='"+standardscheduleid+"' standardname='"+standardname+"' >"+standardname+"</option>");

							    
						}
					}
						*/
					%>
				<!--	</select>
				</td>
			</tr>-->
				
			</table></td><td>
			
			
	
					  
		<iframe src ="" width="0" height="0" id="fileopener">
  <p>Your browser does not support iframes.</p>
</iframe>
			
			
			</td></tr>
			</table>

				
    			<a href="#" class="bt_green" onclick="doCompletion()"><span class="bt_green_lft"></span><strong>Generate pdf</strong><span class="bt_green_r"></span></a>
				
	</div><!-- end of right content-->


	</div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->

	<%@ include file="../include/footer.jsp" %>

	</div>
</form>
</body>
</html>