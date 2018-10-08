<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.StudentDiary.StudentDiaryQuery" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.StudentDiary.StudentDiaryBean" />
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Community | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">






</script>
</head>
<body>
<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>
<%@ page import="java.io.*,java.util.*"%>

<%

String studentdiaryid="";
String date_str="";
String subjectname1="";
String sectionid="";
String sectionname="";
String standardid="";
String standardname="";
String sectionscheduleid="";
String subjectscheduleid="";
String startdate="";
ArrayList allexisting=new ArrayList();



studentdiaryid=request.getParameter("studentdiaryid");

HashMap newallexisting=new HashMap();






String userid=(String)session.getValue("userid");

 

//out.println(standards);

 standardname=request.getParameter("standardname");
 sectionname=request.getParameter("sectionname");
 subjectname1=request.getParameter("subjectname");
 sectionscheduleid=request.getParameter("sectionscheduleid");
 String k=request.getParameter("k");
 startdate=request.getParameter("startdate"+k);
 instituteBean.setstudentdiaryid(studentdiaryid);
 instituteBean.setsectionscheduleid(sectionscheduleid);
 instituteBean.setCreatedBy("1");
 //System.out.println("***startdate***"+startdate);
 instituteBean.setsubmissiondate(startdate);

 //out.println("standardname=="+standardname+"sectionname=="+sectionname+"subjectname1=="+subjectname1+"sectionscheduleid=="+sectionscheduleid);
 
 int assigns=query_object.StudentDiaryAssign(instituteBean);


%>
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

    <h2>Master Entries / Student Existing Diary</h2>
<form name="communityform" action="" method="post">
    
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	<tr><td align="right" class="tablelight"><a href="<%=request.getContextPath()%>/jsp/StudentDiary/StudentDiaryStaff.jsp">Back</a></td></tr>
	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
        	<th scope="col" class="rounded" width="100%">Student Existing Diary</th>
        	<th scope="col" class="rounded-q4" width="10" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>
  <table id="rounded-corner" border=0 summary="Department List" width="100%">


    <thead>   
    <tr>
    <td><a class=tablebold>Standard </a></td><td><%=standardname %> </td>
     <td>Section </td><td><%=sectionname %>  </td>
    </tr>
    <tr >
    <td>Subject </td><td colspan="3"><%=subjectname1 %> </td></tr>
    <tr>
        <td colspan="4" align="center">Allocated Successfully</td>
    
    </tr>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    
    </thead>
   <tfoot>
    	<tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
       <tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
     <tbody>
   
     </tbody>
     
</table>


     
    
        <input type=hidden name=details value="">
        <input type=hidden name=creation value="">
        <input type=hidden name=subjectname value="">
        
        <input type=hidden name=standardname value="<%=standardname%>">
        <input type=hidden name=sectionname value="<%=sectionname%>">
        <input type=hidden name=subject value="<%=subjectname1%>">
                <input type=hidden name=studentdiaryid value="<%=studentdiaryid%>">
                
        
    
      
     </td>
     </tr>
     </TABLE>
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>