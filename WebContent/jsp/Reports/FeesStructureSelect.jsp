<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.feesstructure.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>

<script type="text/javascript">

function resetBoard()
{
	document.ApplicantSearch.boardname.value = "00";
	document.ApplicantSearch.course.value = "00";
	//document.ApplicantSearch.req_sessionid.value  = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
	//document.ApplicantSearch.req_sessionstatus.value = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("archivestatus");
}

function loadStandard()
{
	//alert(document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value);
	//alert(document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value);
	//document.ApplicantSearch.req_sessionid.value  = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value
	//document.ApplicantSearch.req_sessionstatus.value = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("archivestatus");
	//document.ApplicantSearch.reg_ctypeid.value  = document.ApplicantSearch.ctype.options[document.ApplicantSearch.ctype.options.selectedIndex].value;
	document.ApplicantSearch.req_boardid.value  = document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;

	document.ApplicantSearch.action="FeesStructureSelect.jsp?req_sessionid="+document.ApplicantSearch.req_sessionid.value+"&req_boardid="+document.ApplicantSearch.req_boardid.value;
	document.ApplicantSearch.submit();

}

function viewFeeStruct()
{
	//document.ApplicantSearch.req_sessionid.value  = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
	document.ApplicantSearch.req_boardid.value  = document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
	document.ApplicantSearch.standardpublishid.value  = document.ApplicantSearch.course.options[document.ApplicantSearch.course.options.selectedIndex].value;
	
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
	
	else
	{
		//document.ApplicantSearch.req_sessionid.value  	= document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
		//document.ApplicantSearch.req_sessionstatus.value = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("archivestatus");
		//document.ApplicantSearch.req_sessionname.value  = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
		document.ApplicantSearch.req_boardid.value  	= document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
		document.ApplicantSearch.req_boardname.value  	= document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].text;
		document.ApplicantSearch.standardpublishid.value= document.ApplicantSearch.course.options[document.ApplicantSearch.course.options.selectedIndex].value;
		document.ApplicantSearch.standardnamegp.value= document.ApplicantSearch.course.options[document.ApplicantSearch.course.options.selectedIndex].text;
	
		document.ApplicantSearch.action="FeesStructureView.jsp";
		document.ApplicantSearch.submit();
	}

}

	function checkStatus()
	{
		//alert(document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value);
		//alert(document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value);
		//document.ApplicantSearch.req_sessionid.value  = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value
		//document.ApplicantSearch.req_sessionstatus.value = document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].getAttribute("archivestatus");
		//document.ApplicantSearch.reg_ctypeid.value  = document.ApplicantSearch.ctype.options[document.ApplicantSearch.ctype.options.selectedIndex].value;
		document.ApplicantSearch.req_boardid.value  = document.ApplicantSearch.boardname.options[document.ApplicantSearch.boardname.options.selectedIndex].value;
		document.ApplicantSearch.standardpublishid.value  = document.ApplicantSearch.course.options[document.ApplicantSearch.course.options.selectedIndex].value;
		
		document.ApplicantSearch.action="FeesStructureSelect.jsp?req_sessionid="+document.ApplicantSearch.req_sessionid.value+"&req_boardid="+document.ApplicantSearch.req_boardid.value;
		document.ApplicantSearch.submit();
	
	}	

function goBack(){
		document.ApplicantSearch.action="./FinanciarReportIndexView.jsp";
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

    <h2><%=bundle.getString("label.feesstructure.rothpathinreport")%></h2>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="100%" colspan="2" ><%=bundle.getString("label.feesstructure.FeesStructure")%></th>
            <th scope="col" class="rounded-q4" width="10"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>

		<input type=hidden name="req_sessionname" value='<%=request.getParameter("req_sessionname") %>'>
		<input type=hidden name="req_sessionid" value=<%=request.getParameter("req_sessionid") %>>
		<input type=hidden name="req_boardname">
		<input type=hidden name="req_boardid">
		<input type=hidden name="standardnamegp">
		<input type=hidden name="standardpublishid">
		<input type=hidden name="req_sessionstatus" value=<%=request.getParameter("req_sessionstatus") %>>
		
			<%
			com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();	
			com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
			ArrayList standardList =  null;
			String req_boardid 	 = null;
			if(request.getParameter("req_sessionid") == null)
			{
			}
			else if(request.getParameter("req_sessionid") != null && request.getParameter("req_boardid") != null)
			{
				String req_sessionid = request.getParameter("req_sessionid");
				//String reg_ctypeid = request.getParameter("reg_ctypeid");
				req_boardid = request.getParameter("req_boardid");
				standardList = registrationQuery.listStandard(req_sessionid,req_boardid);
			
			}
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
				<td class=tablebold width='20%'><%=bundle.getString("label.feesstructure.AcademicYear")%></td>
				<td  class='tablebold' width='1' valign=top >:</td>
				<td><%=request.getParameter("req_sessionname")%></td>
				<!--  <td>session.getValue("sessionname")%></td>-->
				<!--  <td>
				<select name=sessionname class=tablelight  onchange=resetBoard()>
					<option value="00">-Select Academic-</option>
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
								out.println("<option selected value='"+sessionid+"' archivestatus='"+session_status+"'>"+yearofsession+"</option>");
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
			
				</td>-->
			</tr>
				
			  <tr>
				<td class=tablebold width='20%'><%=bundle.getString("label.feesstructure.Board")%> <font color="red">*</font></td>
				<td  class='tablebold' width='1' valign=top >:</td>
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
			</select></td></tr>
			<tr>
				<td class=tablebold width='20%'><%=bundle.getString("label.feesstructure.Standard")%> <font color="red">*</font></td>
				<td  class='tablebold' width='1' valign=top >:</td>
				<td><select name=course class=tablelight onchange=checkStatus()>
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
								if(standardscheduleid.equals(request.getParameter("standardpublishid")))
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
				</select></td>
			</tr>
			<%
			if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
			{
			%>
			
			<tr class='tablebold' height='23'>
					<td  class='tablebold' width='20%' valign=top ><%=bundle.getString("label.feesstructure.ArchivalDetails")%></td>
					<td  class='tablebold' width='1' valign=top >:</td>
					<td valign=top class='tablelight' align=left><h2><%=bundle.getString("label.feesstructure.ThisisanArchivedYear")%></h2></td>
			</tr>
			<%
			} 
			%>					
			</table></td><td></td></tr>

						</table>
<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.feesstructure.Back")%></strong><span class="bt_blue_r"></span></a>
    <a href="#" class="bt_green" onclick="viewFeeStruct()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.feesstructure.ViewFeesStructure")%></strong><span class="bt_green_r"></span></a>
  

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</form>
</body>

</html>