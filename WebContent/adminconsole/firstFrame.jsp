<html>
<head>

 <title>virtualhr Main</title>
<script src="<%=request.getContextPath()%>/js/dtree.js" >
</script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/sty.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/dtree.css">
</head>

<body leftmargin=0 rightmargin=0
           topmargin=0 bottommargin=0>
     <table border="0" cellpadding="0" class=tablebackground cellspacing="0" width="100%" height="100%">

     <tr>
       <td valign='top'>

 	<script type="text/javascript">

 	   d = new dTree('d');

           d.add(0,-1,"VirtualHR",'','','','<%=request.getContextPath()%>/img/tree/globe.gif','','');
           	d.add(100,0,"<a href='#'>Service Register</a>",'','','','/virtualhr/img/tree/folder.gif','','');
           	d.add(1,100,"<a href='<%= request.getContextPath()%>/jsp/ServiceRegister/TrainingAttend.jsp\' title=\"Training\" target=\"parent\">Training</a>",'','','','/virtualhr/img/tree/services.gif','','');
           	d.add(2,100,"<a href=\"<%= request.getContextPath()%>/jsp/ServiceRegister/Deputation.jsp\" title=\"Deputation\" target=\"parent\">Deputation</a>",'','','','/virtualhr/img/tree/services.gif','','');
           	d.add(3,100,"<a href=\"<%= request.getContextPath()%>/jsp/ServiceRegister/AbroadVisit.jsp\" title=\"AbroadVisit\" target=\"parent\">Abroad Visit</a>",'','','','/virtualhr/img/tree/services.gif','','');
           	d.add(4,100,"<a href=\"<%= request.getContextPath()%>/jsp/ServiceRegister/Promotions.jsp\" title=\"Promotion\" target=\"parent\">Promotion</a>",'','','','/virtualhr/img/tree/services.gif','','');
           	d.add(5,100,"<a href=\"<%= request.getContextPath()%>/jsp/ServiceRegister/Awards.jsp\" title=\"Prize &amp; Awards\" target=\"parent\">Prize & Awards</a>",'','','','/virtualhr/img/tree/services.gif','','');

           	d.add(200,0,"<a href='#'>Recruitment</a>",'','','','/virtualhr/img/tree/folder.gif','','');
           		d.add(1,200,"<a href=\"<%= request.getContextPath()%>/jsp/Recruitment/Raise_Man_Power.jsp\" title=\"Raise Man Power\"  target=\"parent\">Raise Man Power</a>",'','','','/virtualhr/img/tree/services.gif','','');
           		d.add(2,200,"<a href=\"<%= request.getContextPath()%>/jsp/Recruitment/HR_View.jsp\" title=\"HR View\" target=\"parent\">HR View</a>",'','','','/virtualhr/img/tree/services.gif','','');
           		d.add(3,200,"<a href=\"<%= request.getContextPath()%>/jsp/Recruitment/Job_Entry.jsp\" title=\"Job Card\" target=\"parent\">Job Card</a>",'','','','/virtualhr/img/tree/services.gif','','');
           		d.add(4,200,"<a href=\"<%= request.getContextPath()%>/jsp/Recruitment/HR_Selection_Process.jsp\" title=\"Selection\" target=\"parent\">Selection</a>",'','','','/virtualhr/img/tree/services.gif','','');
           		d.add(5,200,"<a href=\"<%= request.getContextPath()%>/jsp/Recruitment/Call_Letter.jsp\" title=\"Call Letter\" target=\"parent\">Call Letter</a>",'','','','/virtualhr/img/tree/services.gif','','');
           		d.add(6,200,"<a href=\"<%= request.getContextPath()%>/jsp/Recruitment/Exam_Settings.jsp\" title=\"Mark Settings\" target=\"parent\">Mark Settings</a>",'','','','/virtualhr/img/tree/services.gif','','');
           		d.add(7,200,"<a href=\"<%= request.getContextPath()%>/jsp/Recruitment/Technical_Selection.jsp\" title=\"Tech Test\" target=\"parent\">Tech Test</a>",'','','','/virtualhr/img/tree/services.gif','','');
           		d.add(8,200,"<a href=\"<%= request.getContextPath()%>/jsp/Recruitment/View_List.jsp\" title=\"Interview\" target=\"parent\">Interview</a>",'','','','/virtualhr/img/tree/services.gif','','');
           		d.add(9,200,"<a href=\"<%= request.getContextPath()%>/jsp/Recruitment/Sort_List.jsp\" title=\"Sort List\" target=\"parent\">Sort List</a>",'','','','/virtualhr/img/tree/services.gif','','');
           		d.add(10,200,"<a href=\"<%= request.getContextPath()%>/jsp/Recruitment/Join_Report.jsp\" title=\"Join Report\" target=\"parent\">Join Report</a>",'','','','/virtualhr/img/tree/services.gif','','');
           		d.add(11,200,"<a href=\"<%= request.getContextPath()%>/jsp/Recruitment/Company_Details.jsp\" title=\"Com Details\" target=\"parent\">Com Details</a>",'','','','/virtualhr/img/tree/services.gif','','');
           		d.add(12,200,"<a href=\"<%= request.getContextPath()%>/jsp/Recruitment/Candidate_List.jsp\" title=\"Candidate List\" target=\"parent\">Candidate List</a>",'','','','/virtualhr/img/tree/services.gif','','');



           	d.add(300,0,"<a href='#'>Organziation</a>",'','','','/virtualhr/img/tree/folder.gif','','');
           	d.add(400,0,"<a href='/sruportal/index.jsp' target='_top'>Logout</a>",'','','','/virtualhr/img/tree/folder.gif','','');

           	//d.add(100,0,"<a href=<%=request.getContextPath()%>/emp_profile/employeeprofile.jsp target='_body'>Employee Profile</a>",'','','','/virtualhr/img/tree/folder.gif','','');
           	//d.add(200,0,"<a href=<%=request.getContextPath()%>/emp_role/role.jsp target='_body'>Role Settings</a>",'','','','/virtualhr/img/tree/folder.gif','','');
           //	d.add(300,0,"<a>Salary</a>",'','','','<%=request.getContextPath()%>/img/tree/folder.gif','','');
 	   		//d.add(10,300,"<a href<%=request.getContextPath()%>/salary/profile/emp_profile.jsp target='_body'>Profile</a>",'','','','/virtualhr/img/tree/folder.gif','','');
 	   		//d.add(20,300,"<a href=<%=request.getContextPath()%>/salary/monthlysalary.jsp target='_body'>Monthly Wise Salary</a>",'','','','/virtualhr/img/tree/folder.gif','','');

 	   	//d.add(400,0,"<a>Attendance</a>",'','','','/virtualhr/img/tree/folder.gif','','');
 	   		//d.add(10,400,"<a href=<%=request.getContextPath()%>/emp_leave/e_leaveprofile.jsp target='_body'>Leave Entry</a>",'','','','/virtualhr/img/tree/folder.gif','','');
 	   document.write(d);
        </script>

       </td>
      </tr>

     </table>



 </body>
</html>