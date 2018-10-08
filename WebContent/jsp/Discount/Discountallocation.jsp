<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@page import="java.util.ArrayList,java.util.HashMap"%>
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle1.getString("label.feescollection.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">

function loadStudent1()
{
if(check_ForParticularElements(document.discountform.rollnumbertext,"text"))
	{
		document.discountform.action="./FeesCollectionStudentinfo.jsp";
		document.discountform.submit();
	}
}

function loadStudent()
{
if(check_ForParticularElements(document.discountform.rollnumbertext,"text"))
	{
	
	document.discountform.action="./Discountallocation.jsp";
	document.discountform.submit();	
	
 	   }	
}


function operations(obj)
{ 
	
	 if(confirm("Are you sure want to "+obj.getAttribute("mode")+"?")){
	 
		document.discountform.discountcategoryid.value=obj.getAttribute("discountcategoryid")
		document.discountform.discountusersid.value=obj.getAttribute("discountusersid");
		document.discountform.operation.value=obj.getAttribute("mode");
		document.discountform.action="./Discountallocationinsert.jsp";
		document.discountform.submit();	 
	 }
}

</script>
</head>
<jsp:useBean id="query_obj" class="com.iGrandee.Discount.DiscountAction"></jsp:useBean>
<body>
<%
try{
	
	ArrayList Discounthistorylist=null;
	ArrayList Discountallocationlist=null;
	HashMap innermap=null;
	
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

    <h2>Discount / Discount Category Allocation</h2>
<form name="discountform" action="" method="post">

<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>
    
        	<th scope="col" class="rounded-company" width="80%">Discount Category Allocation</th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle1.getString("label.feescollection.MandatoryFields")%></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     

     <%
	     String instituteid = null;String studentapprovalid=null;String studentname=null;String userid=null;
	     String sessionid	=null;
     
    	  instituteid = (String)session.getValue("instituteid");
    	  ArrayList StudentList=null;String rollnumber=null;
    	 
    	
    	 
    %>
    
    <tr><td colspan=2><table id="rounded-corner1" width="100%">
    	<tr>
    	<td>
	    	<table border="0" cellpadding="0" cellspacing="0" width="60%" align="center">
	    	<tr><td class="tablebold" align=center>
		    	 Enter Student Roll Number 	&nbsp;<font color="red">*</font>&nbsp;&nbsp;
		    	
		    	<input type=text name="rollnumbertext" validate="Roll Number" class=tablelight"/> 
	       </td></tr></table>
	    </td>
	    </tr>
     
    </table></td></tr>
    </tbody>
</table>
 
     <a href="#" onclick=loadStudent() class="bt_blue"><span class="bt_blue_lft"></span><strong>Search </strong><span class="bt_blue_r"></span></a>

     <input type=hidden name="boardid">
	<input type=hidden name="boardname">
	<input type=hidden name="yearofsessionname">
	<input type=hidden name="yearofsessionid">
	<input type=hidden name="discountusersid">
	
	
	<br><br>
	<%
	
	 if(request.getParameter("rollnumbertext")!=null){
		  rollnumber=request.getParameter("rollnumbertext");
		  StudentList=query_obj.getstudentdetails(rollnumber,instituteid);
	
	%>
	<h2>Student Information for the Roll Number <%=rollnumber%></h2>
	
<table id="rounded-corner" border=0 summary="Department List" width="100%" >
    <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="90%">Student Information</th>
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
	    	if(StudentList!=null && StudentList.size()>0)
	    	{
	    		int inc = 1;
	//standardscheduleid, sectionscheduleid, studentallocationid, sectionname, standardname, groupname, boardname,
	//mediumname, firstname, middlename, lastname, emailid, imagepath, prefix,studentapprovalid   		 		
	    		HashMap feesScheduleListMap=(HashMap)StudentList.get(0);
	    		 
	    		standardscheduleid     = (String)feesScheduleListMap.get("standardscheduleid");
	    		 studentapprovalid=(String)feesScheduleListMap.get("studentapprovalid");
   				 sessionid	= (String)feesScheduleListMap.get("sessionid");
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
	    		String emailid      = (String)feesScheduleListMap.get("emailid");
	    		String imagepath      = (String)feesScheduleListMap.get("imagepath");
	    		String studprefix      = (String)feesScheduleListMap.get("prefix");
	    		studentapprovalid      = (String)feesScheduleListMap.get("studentapprovalid");
	    		
	    		if(middlename==null || middlename.equals("") ||  middlename.equals("-"))
	    		studentname = studprefix+""+firstname+""+lastname;
	    		else
	    			studentname = studprefix+""+firstname+""+middlename+""+lastname;
	    		
	    		if(studentgroupname ==null || studentgroupname.equals("-"))
	    			studentstandardname = studentstandardname;
	    		else
	    			studentstandardname = studentstandardname+""+studentgroupname;
	    		
	    		userid					= (String)feesScheduleListMap.get("userid");
	    		
	    	%>
	    	
	    	<tr>
	    		<td class=tablebold><%=bundle1.getString("label.studentfeescollection.StudentRollNumber")%></td>
	    		<td class=tablebold>:</td><td><%=rollnumber %></td>
	    		<td class=tablebold><%=bundle1.getString("label.studentfeescollection.StudentName")%></td>
	    		<td class=tablebold>:</td><td><%=studentname %></td>
	    		
	    		</tr>
	    	<tr>
	    		<td class=tablebold><%=bundle1.getString("label.studentfeescollection.Standard")%></td>
	    		<td class=tablebold>:</td><td><%=studentstandardname%></td>
	    		<td class=tablebold><%=bundle1.getString("label.studentfeescollection.Section")%></td>
	    		<td class=tablebold>:</td><td><%=studentsectionname%></td>
	    		</tr>
	    	<%
		    }else 
		    	{
			    	
		    		out.print("<tr align='center' class='tablebold'><td colspan='2'><font color='red'>Data Not Found</font></td></tr>");
			    	
		    	}%>	 
	       </tr></table>
	    </td>
	    </tr>
    </table>
    <br>
    </br>
    </td></tr>
    </tbody>
</table>
</br>	
<%
if(StudentList!=null && StudentList.size()>0) 
{
	Discounthistorylist=query_obj.getdiscounthistory(studentapprovalid, sessionid);
	
%>
<!-- Discount details -->
<br><br>
<h2>Student Discount Category Allocation History</h2>
<table id="rounded-corner" border="0" summary="selectd Information" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%">SL.No</th>
        	<th scope="col" class="rounded" width="30%">Discount Category Name</th>
        	<th scope="col" class="rounded" width="40%">Percentage</th>
        	
        	<th scope="col" class="rounded" width="10%">Status</th>
        	
        	<th scope="col" class="rounded-q4" width="10%"></th>
        </tr>
    </thead>
    <tfoot>
    	<tr> 
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>  

 <%
 int count=0;
 if(Discounthistorylist!=null && Discounthistorylist.size()>0){

 for(int k=0;k<Discounthistorylist.size();k++)
 	{
	 innermap=(HashMap)Discounthistorylist.get(k);
	 count++;
 %>
		  <tr>
		 	<td><%=count%></td> 
			 <td><%=innermap.get("discountcategoryname") %></td> 
			 
			 <td><%=innermap.get("discountpercentage")+"%" %></td>
		<td><%=innermap.get("status") %></td>
		 
			<td></td> 
			 </tr>    
			 
		 
<%
 	}
 }
 else{

		out.print("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");

 }
%>	  
	 
	 </tbody>
	 </table>

</br>	

<%

Discountallocationlist=query_obj.getdiscountallocation(studentapprovalid, sessionid);
if(Discountallocationlist!=null){

%>
<br><br>
<h2>Discount Category Allocation</h2>
<table id="rounded-corner" border="0" summary="selectd Information" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%">SL.No</th>
        	<th scope="col" class="rounded" width="30%">Discount Category Name</th>
        	<th scope="col" class="rounded" width="30%">Percentage</th>
        	
        	<th scope="col" class="rounded" width="25%">Option</th>
        	
        	<th scope="col" class="rounded-q4" width="5%"></th>
        </tr>
    </thead>
    <tfoot>
    	<tr> 
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>  

 <%boolean discountallocateverificationflag = false;
 int allotcount=0;
 if(Discountallocationlist!=null){
 for(int k=0;k<Discountallocationlist.size();k++){
	 innermap=(HashMap)Discountallocationlist.get(k);
	 allotcount++;
 %>
  <tr>
 	<td><%=allotcount%></td> 
	 <td><%=innermap.get("discountcategoryname") %></td> 
	 
	 <td><%=innermap.get("discountpercentage")+"%" %></td>
<%
if(innermap.get("status")==null || innermap.get("status").equals("D")){
	out.println("<td><a href='#' mode='allocate' discountcategoryid="+innermap.get("discountcategoryid")+" onclick='operations(this)' >allocate</a></td>");
}
else{
	
	
	
	 discountallocateverificationflag=query_obj.verifyDiscountUserAllocation(studentapprovalid, (String)innermap.get("discountusersid"));
	 
	 if(!discountallocateverificationflag)
	 {	 
		out.println("<td width='25%'><a href='#' mode='cancel' discountcategoryid="+innermap.get("discountcategoryid")+" onclick='operations(this)' >cancel</a> &nbsp;| &nbsp; <a href='#' mode='remove' onclick='operations(this)' discountusersid="+innermap.get("discountusersid")+" onclick='operations(this)'> remove</a></td>");
	 }
	 else
	 {
		 out.println("<td width='25%'><a href='#' mode='cancel' discountcategoryid="+innermap.get("discountcategoryid")+" onclick='operations(this)' >cancel</a> &nbsp;| &nbsp;Fees Collected</td>");
	 }
}	
%>	 
	
	<td></td> 
	 </tr>    
	
	 <%
 	}
	 %>
	 </tbody>
	 </table>

</br>	
	<%
 		}
 else{
	 
		out.print("<tr align='center' class='tablebold'><td colspan='2'><font color='red'>Data Not Found</font></td></tr>");

	 
 }
	}
}
	 }
	%>
	
	<input type="hidden" name="discountcategoryid" value=""/> 
	<input type="hidden" name="operation" value=""/>
	<input type="hidden" name="studentapprovalid" value="<%=studentapprovalid%>"/>
		<input type="hidden" name="rollno" value="<%=rollnumber%>"/>
	
	
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    <%
	  

	}
	
	catch(Exception e){
		e.printStackTrace();
	}
%>

</div>
</body>
</html>