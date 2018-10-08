<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="applicationQuery" scope="page" class="com.iGrandee.Application.ApplicationQuery"/>
<%@ page language="java" import="java.util.ArrayList,java.util.HashMap" %>
<html>
<link rel=stylesheet href="../css/vlearn_sty.css">
<link rel=stylesheet href="<%=request.getContextPath() %>/css/kyccss.css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>KYC - Application Issue Previous</title>
<script language="javascript">
function search()
{
	if(document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value =="00")
	{
		alert("Select Academic Year");
		document.ApplicantSearch.sessionname.focus();
		return false;
	}
	document.ApplicantSearch.req_sessionid.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
    document.ApplicantSearch.req_sessionname.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;

	ApplicantSearch.action="ApplicantDateWise_Pre.jsp";
	ApplicantSearch.submit();
}
function todayapplication()
{
	if(document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value =="00")
	{
		alert("Select Academic Year");
		document.ApplicantSearch.sessionname.focus();
		return false;
	}
	document.ApplicantSearch.req_sessionid.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
    document.ApplicantSearch.req_sessionname.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;

	ApplicantSearch.action="TodayApplicants.jsp";
	ApplicantSearch.submit();
}


function Insert()
{
	if(document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value =="00")
	{
		alert("Select Academic Year");
		document.ApplicantSearch.sessionname.focus();
		return false;
	}
		document.ApplicantSearch.req_sessionid.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
		document.ApplicantSearch.req_sessionname.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
		document.ApplicantSearch.action="ApplicationIssue.jsp";
		document.ApplicantSearch.submit();
}

function samePage()
{
	document.ApplicantSearch.action="ApplicationIssue.jsp";
	document.ApplicantSearch.submit();
}
function View()
{
	if(document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value =="00")
	{
		alert("Select Academic Year");
		document.ApplicantSearch.sessionname.focus();
  		return false;
	}
		document.ApplicantSearch.req_sessionid.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
		document.ApplicantSearch.req_sessionname.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
		document.ApplicantSearch.action="ApplicantView.jsp";
		document.ApplicantSearch.submit();
}
function showreport()
{
	if(document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value =="00")
	{
		alert("Select Academic Year");
		document.ApplicantSearch.sessionname.focus();
		return false;
	}
		document.ApplicantSearch.req_sessionid.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].value;
		document.ApplicantSearch.req_sessionname.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
		document.ApplicantSearch.action="ApplicationReport.jsp";
		document.ApplicantSearch.submit();
}

</script>
</head>
<body bgcolor="#2B303E" topmargin="0" bottommargin="0" onload="document.ApplicantSearch.sessionname.focus()">
<form name="ApplicantSearch" action="" method="post">
<input type=hidden name=req_sessionid>
<input type=hidden name=req_sessionname>
	<table align="center" border="0" valign=top  width="710" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0">
<!--  <tr valign=top>
		<td valign="top">include banner</td>
	  </tr> -->

	<tr valign=top>
		<td vAlign="top">

	<table border="0" width="100%" cellspacing="0" cellpadding="0">
<!--  <tr>
		<td>include menu</td>
	  </tr>-->	

	<tr>
		<td width="910" >
			<TABLE  align=center width="100%" height="100%"  cellspacing=0 cellpadding=8>
				<TR>
					<TH class=tableBody_BG align=left valign=bottom>
        			<!-- img src="../../images/v_image/template_ball.gif"&nbsp; -->
					<font class=tableBody>Application Issue  </font>
					</TH>
				</TR>
				<TR height="425">
					<TD valign=top align=center>
						<TABLE border=0 bgcolor=white cellspacing=0 width=100% align=center  cellpadding=5>
						<tr>
						</tr>

							<td colspan=2>
								<table border="1" width="60%" height="100%" bordercolor="#EEEEEE" cellpadding="8" align=center cellspacing="0" rules="groups">
									<tr class="tablehead">
											<td colspan="2">
													Application Issue - List of Session
											</td>
									</tr>
								<%
								String instituteid = null;
								instituteid = (String)session.getValue("instituteid");
								ArrayList valueList = null;
								ArrayList yearList = applicationQuery.listYearofSession(instituteid);
								String temp=applicationQuery.receiptNo();
								//out.println("temp-->"+temp);
								%>
									<tr>
										<td class=tablebold>Academic Year</td><td>
										<select name=sessionname class=tablelight>
											<option value="00">-Select Academic Year-</option>
											<%

											for(int s=0;s<yearList.size();s++)
											{
												HashMap map=(HashMap)yearList.get(s);
												String sessionid=(String)map.get("sessionid");
												String yearofsession=(String)map.get("sessionname");
												String session_status=(String)map.get("sessionstatus");
												out.println("<option value='"+sessionid+"'>"+yearofsession+"</option>");
											}

											%>
										</select>

										</td>
									</tr>

									<tr class="tablehead">
										<td colspan="3" align="center"><input type="button" class="buttons" value="Submit" onclick="Insert()">
										<input value="View" type="button" class="buttons" onclick="View()"><input value="Cancel" type="hidden" class="buttons" onclick="samePage()" >

										<input value="Today Application view" type="button" class="buttons" onclick="todayapplication()">
										<input value="Search" type="button" class="buttons" onclick="search()" >
										<input value="Report" type="button" class="buttons" name=report onclick="showreport()" >
										</td>
									</tr>

								</table><br>
							</td>

							</table>

						</td>
						</tr>
						</table>
					</td>
				</tr>
			</table>
			</td></tr></table>

</form>
</body>
</html>