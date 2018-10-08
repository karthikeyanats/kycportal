<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-EN">
<head>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquerymenufun.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquerymenu.js"></script>
	
	<link rel=stylesheet href="<%=request.getContextPath() %>/css/jquerystyle.css">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Report - Powered by iGrandee</title>
	<!--[if lt IE 8]>
   <style type="text/css">
   li a {display:inline-block;}
   li a {display:block;}
   </style>
   <![endif]-->
</head>
<body>
	<ul id="menu4" class="menu collapsible">
		<li><a href="#" onclick=stdSchd()>Standard Scheduled </a></li>
		<li><a href="#" onclick=studList()>Student List</a></li>
		<li><a href="#" onclick=staffAllot()>Staff Allotted </a></li>
		<li><a href="#" onclick=timeTable()>Time Table</a></li>

		<li>
			<a href="#">Fees</a>
			<ul>
				<li><a href="#" onclick=feeStruct()>Fees Structure</a></li>
				<li><a href="#" onclick=feeReport()>Fees Report</a></li>
			</ul>
		</li>
		<li>
			<a href="#">Exam</a>
			<ul>
				<li><a href="#" onclick=examName()>Exam Name</a></li>
				<li><a href="#" onclick=examSchd()>Exam Schedule</a></li>
				<li><a href="#" onclick=examResult()>Result</a></li>
			</ul>
		</li>
		<li><a href="#" onclick=schoolSchd()>School Calendar</a> </li>
	</ul>
</body>
</html>