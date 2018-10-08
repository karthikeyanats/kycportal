<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle1.getString("label.feespaidlist.title")%>| Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
function showreceipt(obj)
{
	window.open("./academicfeesreceipt.jsp?feesreceitpid="+obj.getAttribute("academicfeesreceiptid")+"&rollnumbertext="+document.feescollectionform.reqrollnumbertext.value);

	//window.open("academicfeesreceipt.jsp?rollnumbertext="+document.feescollectionform.reqrollnumbertext.value+"&feesreceitpid="+obj.getAttribute("feesreceitpid")+"","Msg","top=250,left=350,help:no,center:no,status:no,width=435,height=480,scrollbars=1;")
}
function feesdetails(obj)
{
document.feescollectionform.feesdate.value=obj.getAttribute("feescollectiondate");
document.feescollectionform.disfeesdate.value=obj.getAttribute("feescollectdate");
document.feescollectionform.action="./FeesPaidListforDate.jsp";
document.feescollectionform.submit();
}
function backfun()
{
		document.feescollectionform.action="./FeesCollectionStudentinfo.jsp";
		document.feescollectionform.submit();
}
</script>
</head>
<body>
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

    <h2><%=bundle1.getString("label.feescollectionpaidlist.rootpath")%></h2>
<form name="feescollectionform" action="" method="post">
  <%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,java.text.NumberFormat,java.util.Locale"%>

     <%
     
     com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();  
String fathername = null;
     String instituteid = null;
     ArrayList studentfeescollectionList = null;
     ArrayList feesScheduleList = null;
     
     String reqrollnumbertext = null;
     String studentstandard = null;
     String studentname = null;
     String studentsection = null;
     ArrayList loadscholarshipList  =null;
     String today		= null;
     String formattedCurrency = null;
     String paidformattedCurrency = null;
     //Locale localcurrency = new Locale("en", "IN");
     ResourceBundle bundle 	= 	ResourceBundle.getBundle("resources.serversetup");
Locale localcurrency = new Locale(bundle.getString("language"), bundle.getString("code"));
     String formattedCurrency1 = null;
     String paidformattedCurrency1 = null;
     String remformattedCurrency = null;
     String remformattedCurrency1 = null;
     String colformattedCurrency = null;
     
     int totalamount =0;
     int totalPaidamount =0;

     int temptotalamount =0;
     int temptotalPaidamount =0;
     
     int count					= 0;
     String studentapprovalid = null;
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  reqrollnumbertext=request.getParameter("rollnumbertext");
    	  feesScheduleList = feesscheduleQuery.checkandLoadStudent(reqrollnumbertext,instituteid);
    	  today				= DateTime.showTime("calendar");
    	  
    	
    }catch(Exception e){}
    
    if(feesScheduleList!=null && feesScheduleList.size()>0)
	{
    %>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%"><%=bundle1.getString("label.feespaidlist.StudentInformation")%></th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   
    <tr><td colspan=2><table id="rounded-corner1" width="100%">
    	<tr>
    	<td>
	    	<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center">
	    	<%
	    	String standardscheduleid     = null;
	    	if(feesScheduleList!=null && feesScheduleList.size()>0)
	    	{ int inc = 1;
	//standardscheduleid, sectionscheduleid, studentallocationid, sectionname, standardname, groupname, boardname,
	//mediumname, firstname, middlename, lastname, emailid, imagepath, prefix,studentapprovalid   		 		
	    		HashMap feesScheduleListMap=(HashMap)feesScheduleList.get(0);
	    		
	    		standardscheduleid     = (String)feesScheduleListMap.get("standardscheduleid");
	    		String studentstandardname      = (String)feesScheduleListMap.get("standardname");
	    		String sectionscheduleid     = (String)feesScheduleListMap.get("sectionscheduleid");
	    		String studentsectionname      = (String)feesScheduleListMap.get("sectionname");
	    		String studentallocationid     = (String)feesScheduleListMap.get("studentallocationid");
	    		String studentgroupname      = (String)feesScheduleListMap.get("groupname");
	    		String studentboardname     = (String)feesScheduleListMap.get("boardname");
	    		String mediumname      = (String)feesScheduleListMap.get("mediumname");
	    		String firstname      = (String)feesScheduleListMap.get("firstname");
	    		String middlename      = (String)feesScheduleListMap.get("middlename");
	    		String lastname      = (String)feesScheduleListMap.get("lastname");
	    		if(feesScheduleListMap.get("fathername") == null)
	    			fathername="-";
	    		else
	    			fathername      = (String)feesScheduleListMap.get("fathername");
	    		
	    		String emailid      = (String)feesScheduleListMap.get("emailid");
	    		String imagepath      = (String)feesScheduleListMap.get("imagepath");
	    		String studprefix      = (String)feesScheduleListMap.get("prefix");
	    		studentapprovalid      = (String)feesScheduleListMap.get("studentapprovalid");
	    		
	    		if(middlename==null || middlename.equals("") ||  middlename.equals("-"))
	    		studentname = studprefix+" "+firstname+""+lastname;
	    		else
	    			studentname = studprefix+" "+firstname+" "+middlename+" "+lastname;
	    		
	    		if(studentgroupname ==null || studentgroupname.equals("-"))
	    			studentstandardname = studentstandardname;
	    		else
	    			studentstandardname = studentstandardname+""+studentgroupname;
	    		
	    		//System.out.print("standardscheduleid-->"+standardscheduleid);
	    	%>
	    	
	    	<tr>
		    	<td class=tablebold><%=bundle1.getString("label.feespaidlist.StudentRollNumber")%></td>
		    	<td class=tablebold>:</td><td><%=reqrollnumbertext %></td>
		    	<td class=tablebold><%=bundle1.getString("label.feespaidlist.StudentName")%></td>
		    	<td class=tablebold>:</td><td><%=studentname %></td>
	    	</tr>
	    	<tr>
	    	<td class=tablebold>Father Name</td>
		    	<td class=tablebold>:</td><td colspan=2><%=fathername %></td>
	    	
	    	</tr>
	    	<tr>
		    	<td class=tablebold><%=bundle1.getString("label.feespaidlist.Standard")%></td>
		    	<td class=tablebold>:</td><td><%=studentstandardname%></td>
		    	<td class=tablebold><%=bundle1.getString("label.feespaidlist.Section")%></td>
		    	<td class=tablebold>:</td><td><%=studentsectionname%></td>
	    	</tr>
	    	
	    	<%
		    }else
		    	{
		    	out.println("<tr align='center' class='tablebold'><td colspan='2'><font color='red'>Data Not Found</font></td></tr>");
		    	//out.println("<tr><td colspan=2>Data not Found</td></tr>");
		    	}%>	 
	       </table>
	    </td>
	    </tr>
    </table>
   
    </td></tr>
    </tbody>
</table>
<br><br>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"><%=bundle1.getString("label.feespaidlist.SL.No")%></th>
        	<th scope="col" class="rounded">Receipt No.</th>
        	<th scope="col" class="rounded">Paid Amount</th>
        	<th scope="col" class="rounded-q4">Date of Collection</th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=3  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   	    	<%
   	    	String temp_termid="";
      	  //  studentfeescollectionList = feesscheduleQuery.studentFeescollectionDetailsforfeescollectionid(studentapprovalid,standardscheduleid);
      	    studentfeescollectionList = feesscheduleQuery.paymentreceiptdetails(reqrollnumbertext);
			if(studentfeescollectionList!=null && studentfeescollectionList.size()>0)
	    	{ int inc = 1;
	    	for(int y=0;y<studentfeescollectionList.size();y++){
				//e.termid,e.termname,c.termfeesid,c.academicfeesreceiptid,c.academicfeesreceiptno,c.paidamount,
	    		HashMap studentfeescollectionListMap		= (HashMap)studentfeescollectionList.get(y);
				
	    		String termfeesid      = (String)studentfeescollectionListMap.get("termfeesid");
	    		String termid      = (String)studentfeescollectionListMap.get("termid");
	    		String termname     = (String)studentfeescollectionListMap.get("termname");
	    		String academicfeesreceiptid      = (String)studentfeescollectionListMap.get("academicfeesreceiptid");
	    		String academicfeesreceiptno     = (String)studentfeescollectionListMap.get("academicfeesreceiptno");
	    		String paidamount     = (String)studentfeescollectionListMap.get("paidamount");				
	    		String dateofpaid     = (String)studentfeescollectionListMap.get("dateofpaid");
	    		
	    	%>
		<%
		 if(!temp_termid.equals(termid))
		{
		out.println("<tr><td  class=tablebold colspan=4>"+termname+"</td></tr>");
			temp_termid = termid;
	
		} 
		out.println("<tr class=tablelight><td>"+inc+"</td><td><a href='#' academicfeesreceiptid='"+academicfeesreceiptid+"' onclick='showreceipt(this)'>"+academicfeesreceiptno+"</a></td><td>"+paidamount+"</td><td>"+dateofpaid+"</td></tr>");

		inc++;
		
		} }else
		    	{
			out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
		    	//out.println("<tr><td colspan=5>Data not Found</td></tr>");
		    	}%>	 
		    	
		   </tbody>
	     </table>
	  
<a href="./FeesCollection_pre.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle1.getString("button.feespaidlist.Back")%></strong><span class="bt_blue_r"></span></a>
      
 <%}
    else
    {
    	out.println("<font color=red><b>Data Not Found</b></font>");
        out.print("<a href='./FeesCollection_pre.jsp' class='bt_blue'><span class='bt_blue_lft'></span><strong>"+bundle1.getString("button.feespaidlist.Back")+"</strong><span class='bt_blue_r'></span></a>");
    }
    %>
	<input type='hidden' name='radioname' value=''/>
	<input type='hidden' name='disfeesdate' value=''/>
	<input type='hidden' name='feesdate' value=''/>
	<input type='hidden' name='todaydate' value='<%=today %>'/>
	<input type=hidden name="studentapprovalid" value="<%=studentapprovalid %>"/>
	<input type=hidden name="reqrollnumbertext" value="<%=reqrollnumbertext%>"/>
	</form>
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>