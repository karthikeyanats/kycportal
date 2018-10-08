<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.examallot.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language='javascript'>
function LoadExams(){
	//sessionid  = document.exallotmentform.sessionid.options[document.exallotmentform.sessionid.options.selectedIndex].value;
	//document.exallotmentform.action="Examallotment.jsp?req_sessionid="+sessionid;
	document.exallotmentform.action="Examallotment.jsp?req_sessionid="+document.exallotmentform.req_sessionid.value;
	document.exallotmentform.submit();
	}
	
function LoadBoard()
{
	document.exallotmentform.req_examnameid.value = document.exallotmentform.examnameid.options[document.exallotmentform.examnameid.options.selectedIndex].value;
	document.exallotmentform.action="Examallotment.jsp?req_sessionid="+document.exallotmentform.req_sessionid.value;
	document.exallotmentform.submit();


}
	
function loadStandards()
{
	if(check_ForParticularElements(document.exallotmentform.sessionid,"select",document.exallotmentform.boardid,"select")){
			document.exallotmentform.submit();
		}
}

function clickfun()
{
	//document.exallotmentform.req_sessionname.value = document.exallotmentform.sessionid.options[document.exallotmentform.sessionid.options.selectedIndex].text;
	//document.exallotmentform.req_sessionid.value = document.exallotmentform.sessionid.options[document.exallotmentform.sessionid.options.selectedIndex].value;
	//alert("session"+document.exallotmentform.req_sessionid.value);
	document.exallotmentform.req_examname.value = document.exallotmentform.examnameid.options[document.exallotmentform.examnameid.options.selectedIndex].text;
	document.exallotmentform.req_examnameid.value = document.exallotmentform.examnameid.options[document.exallotmentform.examnameid.options.selectedIndex].value;
	document.exallotmentform.req_boardname.value = document.exallotmentform.boardid.options[document.exallotmentform.boardid.options.selectedIndex].text;
	document.exallotmentform.req_boardid.value = document.exallotmentform.boardid.options[document.exallotmentform.boardid.options.selectedIndex].value;
	
	/*if(document.exallotmentform.sessionid.options[document.exallotmentform.sessionid.options.selectedIndex].value == "0")
	{
		alert("Please Select Year of Session");
		document.exallotmentform.sessionid.focus();
		return false;
	}*/
	if(document.exallotmentform.boardid.options[document.exallotmentform.boardid.options.selectedIndex].value == "0")
	{
		alert("Select Board");
		document.exallotmentform.boardid.focus();
		return false;
	}	
	else if(document.exallotmentform.examnameid.options[document.exallotmentform.examnameid.options.selectedIndex].value == "0")
	{
		alert("Select Exam Name");
		document.exallotmentform.examnameid.focus();
		return false;
	}
	else
	{
		document.exallotmentform.action="examallot_standard.jsp";
		document.exallotmentform.submit();
	}
}
</script>
</head>
<body>
<div id="main_container">
<div class="header"><%@ include
	file="../../include/userheader.jsp"%></div>

<div class="main_content"><%@ include
	file="../../include/header.jsp"%>

<div class="center_content">

<div class="left_content"></div>

<div class="right_content">

<h2><%=bundle.getString("label.examallot.rootpath")%></h2>

<form name='exallotmentform' method='post'>
<input type=hidden name=req_sessionname value="<%=session.getValue("sessionname")%>">
<input type=hidden name=req_sessionid value="<%=session.getValue("sessionid")%>">

<input type=hidden name=req_examnameid value="">
<input type=hidden name=req_boardid value="">
<input type=hidden name=req_boardname value="">
<input type=hidden name=req_examname value="">

<%@ page
	language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%> <%@ page
	language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery"%>

<%

	ExamAllotmentQuery exallot	= new ExamAllotmentQuery(); 
	boolean flag=false;
	String instituteid			= "";
		instituteid			= (String)session.getValue("instituteid").toString();
		String req_sessionid 	= "";

		//if(request.getParameter("req_sessionid") == null)
			//req_sessionid = "NO";
		//else
			//req_sessionid =  request.getParameter("req_sessionid");
		if(request.getParameter("req_sessionid") != null)
			req_sessionid =  request.getParameter("req_sessionid");
		
		ArrayList academicList		= exallot.loadAcademicYear(instituteid);
		//System.out.println("req_sessionid:::>>>>"+req_sessionid);
		
		
		
	%>

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="80%">Exam Allotment </th>
		            <th scope="col" class="rounded-q4" width="20%"><font color=red>*</font> <%=bundle.getString("label.examallot.mandatory")%></th>        
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
			<td class=tablebold width="25%"><%=bundle.getString("label.examallot.academic")%></td>
			<td class=tablebold width="2%">:</td>
			<td>
			<%=session.getValue("sessionname")%>	
			</td>

				<td class=tablebold><%=bundle.getString("label.examallot.board")%><font color=red> *</font></td>
				<td class=tablebold width="2%">:</td>
		<td class='tablelight' width='30%'><select name='boardid'
			validate='Board Name' onchange=''>
			<option value='0'>-Select Board-</option>
			<%
				ArrayList boardnameList		= exallot.LoadBoardList(instituteid);
				HashMap boardmap=null;
					if(boardnameList != null && boardnameList.size()>0)
						{
							for(int z=0;z<boardnameList.size();z++)
								{
									boardmap		= (HashMap)boardnameList.get(z);
									String boardid = (String)boardmap.get("boardid");
									String boardname = (String)boardmap.get("boardname");
									String mediumId      = (String)boardmap.get("mediumid");
									String mediumName      = (String)boardmap.get("mediumname");
									
									out.print("<option value='"+boardid+"'>"+boardname+"-"+mediumName+"</option>");
								}
						}
										
			%>
		</select></td>
		</tr>
		<tr>
			<td class=tablebold width="25%"><%=bundle.getString("label.examallot.examname")%><font color=red> *</font></td>
			<td class=tablebold width="2%">:</td>
		<td class='tablelight'><select name='examnameid'
			validate='Exam Name'>
			<option value='0'>-Select Exam Name-</option>
			<%
				ArrayList examnameList		= exallot.LoadExamnameList((String)session.getValue("sessionid"));
				
				HashMap exammap=null;
					for(int y=0;y<examnameList.size();y++)
					{
						exammap	= (HashMap)examnameList.get(y);
						String examnameid = (String)exammap.get("examnameid");
						String examname = (String)exammap.get("examname");
						out.print("<option value='"+examnameid+"'>"+examname+"</option>");
					}

				
	%>
		</select></td>
		

		
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
		
		

<a href="#" class="bt_blue" onclick='clickfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.examallot.loadstd")%></strong><span class="bt_blue_r"></span></a>
</form>

</table>

<!-- end of right content--></div>
<!--end of center content --></div>
<div class="clear"></div>
</div>
<!--end of main content--> 
<%@ include file="../../include/footer.jsp"%>
</div>
</body>
</html>