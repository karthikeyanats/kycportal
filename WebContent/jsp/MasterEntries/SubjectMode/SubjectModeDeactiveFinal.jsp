<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.SubjetMode.SubjectModeEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.SubjetMode.SubjectModeBean" />
<html>
<head>
<title>Subject Mode</title>

<LINK rel=stylesheet href="../css/kyccss.css">
<link rel="stylesheet" type="text/css" href="../../../jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="../jsp/kycpanel/niceforms-default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language="JavaScript" src="../../../js/Validation.js"></SCRIPT>
<script type="text/javascript" src="../jsp/jconfirmaction.jquery.js"></script>


<script language="javascript" type="text/javascript" src="niceforms.js"></script>

<script language="JavaScript">


function goToBack()
{
document.MainForm.action= "SubjectModeList.jsp";
document.MainForm.submit();
}

</script>
</head>

<body>
<form name="MainForm" method="post" action="">

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
         <h2></h2>

<%@ page language="java" import="java.util.*"%>
<%

String subjectmodeid=request.getParameter("subjectmodeid");
String createdby = "1";
String instituteid = (String)session.getValue("instituteid");
String LogStatus = "Deactive";

String ipaddress = request.getLocalAddr();

instituteBean.setCreatedBy(createdby);
instituteBean.setinstituteid(instituteid);
instituteBean.setsubjectmodeid(subjectmodeid);



instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);
instituteBean.setCreatedBy(createdby);
	//String LogStatus = "Deactivated";
	instituteBean.setsubjectmodelogstatus(LogStatus);
	
	int trashlist = query_object.groupsDeactivate(instituteBean);
	
	/*ArrayList checkdeactive=query_object.checkdeactive();
	out.println(checkdeactive.size());
	int courseList1=0;
	
	if(checkdeactive.size()>0)
	{
		for(int i=0;i<checkdeactive.size();i++)
		{
		HashMap h1=(HashMap)checkdeactive.get(i);
		if(h1.get("logstatus")=="Deactivated");
		{
			out.println("*********ok");
			 courseList1 = query_object.ChangeAllStatus();

		}
		}
	}
	else
	{
		 courseList1 = query_object.insertDepartmentsLogs();

	}*/

%>
<form name="MainForm" method="post" action="">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	

		<tr>
		<td>
<table border=1 width="90%" bordercolor='#e3e3e3' cellpadding=10
	cellspacing=1>
	<tr bordercolor=white>
		<td align=center class="tablebold"><font color="black"><i>Successfully
		Deactivated</i></td>
	</tr>
</table>
<br>
</td>
</tr>
<tr>
<td>
<table border=0 width="90%" cellpadding=0 cellspacing=0 align="center">
	<tr align="center">
		<td><input type="button" name=back class=buttonTab
			 value="Backs" onclick="goToBack()"></td>
	</tr>
</table>
</td>
</tr>
<br>
		
	
</TABLE>
</div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>