<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-EN">
<head>
<%
java.util.ResourceBundle bundle  =java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standardwise Archival Report | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">

	function resetBoard()
	{
		document.ApplicantSearch.boardname.value = "00";
		document.ApplicantSearch.course.value = "00";
		//document.ApplicantSearch.section.value = "00";
		document.ApplicantSearch.req_sessionid.value  = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
		document.ApplicantSearch.req_sessionstatus.value = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("archivestatus");
	}
	
	function loadStandard()
	{
		//alert(document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value);
		//alert(document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value);
		document.ApplicantSearch.req_sessionid.value  = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value
		document.ApplicantSearch.req_sessionstatus.value = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("archivestatus");
		//document.ApplicantSearch.reg_ctypeid.value  = document.ApplicantSearch.ctype.options[document.ApplicantSearch.ctype.options.selectedIndex].value;
		document.ApplicantSearch.req_boardid.value  = document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
	
		//document.ApplicantSearch.action="RollNoGenSelect.jsp?req_sessionid="+document.ApplicantSearch.req_sessionid.value+"&req_boardid="+document.ApplicantSearch.req_boardid.value;
		document.ApplicantSearch.submit();
	
	}
	
	function loadSection()
	{
		//alert(document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value);
		//alert(document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value);
		document.ApplicantSearch.req_sessionid.value			=	document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value
		document.ApplicantSearch.req_sessionstatus.value = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("archivestatus");
		document.ApplicantSearch.req_boardid.value  			=	document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
		document.ApplicantSearch.reg_coursepubid_hidden.value  	= 	document.ApplicantSearch.course.options[document.ApplicantSearch.course.options.selectedIndex].value;
	//alert(document.ApplicantSearch.standardpublishid.value);
		//document.ApplicantSearch.reg_stdschedid.value  	= 	document.ApplicantSearch.course.options[document.ApplicantSearch.course.options.selectedIndex].value;
		//document.ApplicantSearch.action="RollNoGenSelect.jsp?req_sessionid="+document.ApplicantSearch.req_sessionid.value+"&req_boardid="+document.ApplicantSearch.req_boardid.value;
		document.ApplicantSearch.submit();
	
	}

function doCompletion()
	{
		document.ApplicantSearch.req_sessionid.value  = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
		document.ApplicantSearch.req_sessionname.value  = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("yearofsession");
		document.ApplicantSearch.req_boardid.value  = document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
		document.ApplicantSearch.req_boardname.value  = document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].getAttribute("req_boardname");
		document.ApplicantSearch.standardpublishid.value  = document.ApplicantSearch.course.options[document.ApplicantSearch.course.options.selectedIndex].value;
		document.ApplicantSearch.standardnamegp.value  	= document.ApplicantSearch.course.options[document.ApplicantSearch.course.options.selectedIndex].text;
//alert(document.ApplicantSearch.standardnamegp.value)
		var url = "";
		var url = "StdwiseReportPDFhide.jsp?req_sessionid="+document.ApplicantSearch.req_sessionid.value+"&req_sessionname="+document.ApplicantSearch.req_sessionname.value+"&req_boardid="+document.ApplicantSearch.req_boardid.value+"&req_boardname="+document.ApplicantSearch.req_boardname.value+"&req_standardscheduleid="+document.ApplicantSearch.standardpublishid.value+"&req_standardname="+document.ApplicantSearch.standardnamegp.value;
		//alert(url)
		//alert(document.ApplicantSearch.req_sessionid.value);
		//alert(document.ApplicantSearch.req_boardid.value);
		//alert(document.ApplicantSearch.standardpublishid.value);
		
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
		//alert(parseXML.getElementsByTagName("var"))
			if(flag=="download")
			{
				var rootObj=parseXML.getElementsByTagName("duplicate");
				var cNode_1=rootObj[0].childNodes.length;
				for(var i=0;i<parseInt(cNode_1);i++)
				{
					var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
					if(temp=="NoPath")
					{
					alert("Storage Path was not Found");
					}
					else if(temp=="true")
					{
						zipathvalue=rootObj[0].childNodes.item(i).childNodes.item(1).firstChild.nodeValue;
						document.getElementById("fileopener").src=zipathvalue+"&r3=download";
	
					}
					else
					{
						alert("No Data to generate PDF");
					}      
				}
			}
	}
		
	function viewStudent1()
	{
		document.ApplicantSearch.req_sessionid.value  = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
		document.ApplicantSearch.req_sessionstatus.value = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("archivestatus");
		document.ApplicantSearch.req_boardid.value  = document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
		document.ApplicantSearch.standardpublishid.value  = document.ApplicantSearch.course.options[document.ApplicantSearch.course.options.selectedIndex].value;
		//document.ApplicantSearch.req_sectionpubid.value  = document.ApplicantSearch.section.options[document.ApplicantSearch.section.options.selectedIndex].value;
		
		var flag=true;
	
	
		if(document.ApplicantSearch.req_sessionid.value=="00")
		{
			alert("Select Academic Year")
					document.ApplicantSearch.sessionname.focus();
		
		}
		
		else if(document.ApplicantSearch.req_boardid.value=="00")
		{
			alert("Select Board")
			document.ApplicantSearch.boardname.focus();
		
		}
		else if(document.ApplicantSearch.standardpublishid.value=="00")
		{
			alert("Select Standard")
			document.ApplicantSearch.course.focus();
		
		}
		/*else if(document.ApplicantSearch.req_sectionpubid.value=="00")
		{
			alert("Select Section")
			document.ApplicantSearch.section.focus();
		
		}*/
		
		else
		{
			document.ApplicantSearch.req_sessionid.value  	= document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
			document.ApplicantSearch.req_sessionname.value  = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
			document.ApplicantSearch.req_sessionstatus.value = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("archivestatus");
		
			document.ApplicantSearch.req_boardid.value  	= document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
			document.ApplicantSearch.req_boardname.value  	= document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].text;
		
			//document.ApplicantSearch.reg_ctypeid.value  	= document.ApplicantSearch.ctype.options[document.ApplicantSearch.ctype.options.selectedIndex].value;
			//document.ApplicantSearch.reg_ctypetext.value  = document.ApplicantSearch.ctype.options[document.ApplicantSearch.ctype.options.selectedIndex].text;
		
			document.ApplicantSearch.standardpublishid.value  = document.ApplicantSearch.course.options[document.ApplicantSearch.course.options.selectedIndex].value;
			document.ApplicantSearch.standardnamegp.value  	= document.ApplicantSearch.course.options[document.ApplicantSearch.course.options.selectedIndex].text;

			//document.ApplicantSearch.req_sectionpubid.value = document.ApplicantSearch.section.options[document.ApplicantSearch.section.options.selectedIndex].value;
			//document.ApplicantSearch.req_sectionname.value  = document.ApplicantSearch.section.options[document.ApplicantSearch.section.options.selectedIndex].text;
	
			document.ApplicantSearch.action="PDFReportIndexStdwiseView.jsp";
			document.ApplicantSearch.submit();
		}
	
	}
	
	function goBack()
	{
		document.ApplicantSearch.action="PDFReportIndex.jsp";
		document.ApplicantSearch.submit();
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

    <h2><%=bundle.getString("label.reports.reportsarchivalreportsstdwise") %></h2>


	<table id="rounded-corner" border=0 width="100%">
    	<thead>
    		<tr>
            	<th scope="col" class="rounded-company" width="80%">Standardwise Archival Report</th>
            	<th scope="col" class="rounded-q4" width="20%"><font color=red>*</font> <%=bundle.getString("label.common.mandatory") %>
</th>            
        	</tr>
    	</thead>
    
        <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       	</tr>
    	</tfoot>
		
		<input type=hidden name=req_sessionid>
		<input type=hidden name=req_sessionname>
		<input type=hidden name=req_boardid>
		<input type=hidden name=req_boardname>
		<input type=hidden name=standardpublishid>
		<input type=hidden name=standardnamegp>		
		<input type=hidden name=reg_coursepubid_hidden>
		<input type=hidden name=req_sectionpubid>
		<input type=hidden name=req_sectionname>
		<input type=hidden name="req_sessionstatus">		
		

		<%
			com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();	
			com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
			ArrayList standardList =  null;
			ArrayList sectionList =  null;
			String req_boardid 	 = null;
			if(request.getParameter("req_sessionid") == null)
			{
			}
			else if(request.getParameter("req_sessionid") != null && request.getParameter("req_boardid") != null && request.getParameter("reg_coursepubid_hidden") != null )
			{
				String standardpublishid = request.getParameter("reg_coursepubid_hidden"); 
				String req_sessionid = request.getParameter("req_sessionid");
				req_boardid = request.getParameter("req_boardid");
				standardList = registrationQuery.listStandard(req_sessionid,req_boardid);
				sectionList = registrationQuery.listSections(standardpublishid);
				//System.out.println("reg_coursepubid11-->"+standardpublishid+"sectionList11-->"+sectionList);
			}
			else if(request.getParameter("req_sessionid") != null && request.getParameter("req_boardid") != null)
			{
				String req_sessionid = request.getParameter("req_sessionid");
				req_boardid = request.getParameter("req_boardid");
				standardList = registrationQuery.listStandard(req_sessionid,req_boardid);
			}
			
			
			//System.out.println("REQUEST"+request.getParameter("req_sessionid")+"--"+request.getParameter("req_boardid")+"--"+request.getParameter("reg_coursepubid_hidden"));			
		    String instituteid = null;
		    ArrayList BoardList = null;
		    try
		    {
		    	instituteid = (String)session.getValue("instituteid");
		    	BoardList = standardQuery.listBoard(instituteid);
		    }catch(Exception e){}

			//ArrayList yearList = registrationQuery.listYearofSession(instituteid);
			ArrayList yearList = registrationQuery.listArchiveYearofSession(instituteid);
			
		%>
			<tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">
			<tr>
				<td class=tablebold><%=bundle.getString("label.academicyear.apprsrc")%> <font color="red">*</font></td>
				<td class=tablebold width='2%'>:</td>
				<td>
					<select name=sessionname class=tablelight onchange=resetBoard()>
						<option value="00">-Select Academic Year-</option>
						<%
							for(int s=0;s<yearList.size();s++)
							{
								HashMap map=(HashMap)yearList.get(s);
								String sessionid=(String)map.get("sessionid");
								String yearofsession=(String)map.get("sessionname");
								String session_status=(String)map.get("sessionstatus");
								if(request.getParameter("req_sessionid") != null)
								{
									if(request.getParameter("req_sessionid").equals(sessionid))
										out.println("<option selected value='"+sessionid+"' yearofsession='"+yearofsession+"' archivestatus='"+session_status+"'>"+yearofsession+"</option>");
									else
										out.println("<option value='"+sessionid+"' yearofsession='"+yearofsession+"' archivestatus='"+session_status+"'>"+yearofsession+"</option>");
								}
								else
								{
									out.println("<option value='"+sessionid+"' yearofsession='"+yearofsession+"' archivestatus='"+session_status+"'>"+yearofsession+"</option>");
								}
							}
						%>
					</select>
				</td>
				<td class=tablebold><%=bundle.getString("label.boardmedium.apprsrc")%> <font color="red">*</font></td>
				<td class=tablebold width='2%'>:</td>
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
									
									if(boardId.equals(req_boardid))
									{
										out.println("<option selected value='"+boardId+"' req_boardname='"+boardName+"-"+mediumName+"' class=tablelight >"+boardName+"-"+mediumName+"</option>");
									}
									else
									{
										out.println("<option value='"+boardId+"'  req_boardname='"+boardName+"-"+mediumName+"' class=tablelight >"+boardName+"-"+mediumName+"</option>");
									}
									
									//out.println("<option value='"+boardid+"' class=tablelight >"+boardname+"-"+mediumname+"</option>");
						  		 }
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td class=tablebold><%=bundle.getString("label.standard.apprsrc")%> <font color="red">*</font></td>
				<td class=tablebold width='2%'>:</td>
				<td><select name=course class=tablelight onchange=loadSection()>
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
				<!--  <td class=tablebold><%=bundle.getString("label.section.apprsrc")%> <font color="red">*</font></td>
				<td class=tablebold width='2%'>:</td>
				<td><select name=section class=tablelight >
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
				</td>-->
			</tr>
			</table></td></tr>
			</table>
	<iframe width="0" height="0" id="fileopener" style="display:none">
	  <p>Your browser does not support iframes.</p>
	</iframe>
				<!--  <a href="#" class="bt_red" onclick="goBack()"><span class="bt_red_lft"></span><strong>Back</strong><span class="bt_red_r"></span></a>-->
    			<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
    			<a href="#" class="bt_green" onclick="doCompletion()"><span class="bt_green_lft"></span><strong>Generate PDF</strong><span class="bt_green_r"></span></a>

	</div><!-- end of right content-->


	</div>   <!--end of center content -->

    <div class="clear"></div>
    </div> <!--end of main content-->

	<%@ include file="../include/footer.jsp" %>

	</div>
</form>
</body>
</html>