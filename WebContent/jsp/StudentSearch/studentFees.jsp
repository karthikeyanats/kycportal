<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.studentsearch.feestitle") %> | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script language='javascript'>

function backfun()
{

document.f1.action= "HomePage.jsp";
			document.f1.submit();

}

</script>
</head>
<body>
<div id="main_container">

<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">

<h2><%=bundle.getString("label.studentsearch.feesrootpath") %></h2>
<form name="f1" method="post" action=""><%@ page
	import="java.util.*"%> <%
 
 %> <%@ page import="com.iGrandee.StudentSearch.StudentSearchEntry"%>

<%
	String date_str = "";
	StudentSearchEntry studentquery = new StudentSearchEntry(); 
	String rollnumber = "";
	try
	{
	 rollnumber=request.getParameter("rollnumber");
	
 			
 			
 			
 			ArrayList Studentpersonminidetails=new ArrayList();
 			
 	 		HashMap map = null;
 			
 			String sectionid="";
 			String standardid="";
 			String sectionname="";
 			String standardname="";
 			String name="";
 			String studentid="";
 			String diarystate="";
 			String groupname = null;
 			Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber,(String)session.getValue("sessionid"));
 			//Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber);
 		
 			 
 			 

  			String sessionname="";
  			String standardscheduleid="";

				 
 			 if (Studentpersonminidetails != null && Studentpersonminidetails.size() > 0) {
 					
 				map = (HashMap) Studentpersonminidetails.get(0);
 				name = (String) map.get("uname");
 				standardid = (String) map.get("standardid");
 				sectionid = (String) map.get("sectionid");
 				
 				standardname = (String) map.get("standardname");
 				sectionname = (String) map.get("sectionname");
 				standardscheduleid = (String) map.get("standardscheduleid");
 				sessionname = (String) map.get("sessionname");
 				groupname = (String) map.get("groupname");
 				if(groupname==null)
 					groupname = "";
 				else
 					groupname = " - "+groupname;

 			 }
 			 
 			
  			
 
 		
 %>
<form name="f1" method="post" action="">
<input type="hidden" name="rollnumber" value="<%=rollnumber %>">
<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	height="100%" cellpadding=0>
	<tr>
	<td>
<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	height="100%" cellpadding=0>
	
	<tr>
		<td valign='top'>
				<table border=0 id="rounded-corner" width="80%">

			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="25%"><%=bundle.getString("label.studentsearch.hometableheading") %></th>
					<th scope="col" class="rounded" width="1%"></th>
					<th scope="col" class="rounded" width="23%"></th>
					<th scope="col" class="rounded" width="25%"></th>
					<th scope="col" class="rounded" width="1%"></th>
					<th scope="col" class="rounded-q4" width="25%"></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=5 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
				</tfoot>
				<tr>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.rollno") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=rollnumber%></td>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.studentname") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=name%></td>
				</tr>
				<tr>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.academicyear") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=sessionname%></td>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.standard") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=standardname%><%=groupname %></td>
				</tr>
				<tr>
					
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.section") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" colspan=4 width="20%"><%=sectionname%></td>
				</tr>
				
			</thead>
		</table>
		</td>
	</tr>
	</table>
	</td>
	</tr>
	
<br>
	 <%@ page import=" java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,java.text.NumberFormat,java.util.Locale"%>

     <%
     
     ResourceBundle bundle1 	= 	ResourceBundle.getBundle("resources.serversetup");
     Locale localcurrency = new Locale(bundle1.getString("language"), bundle1.getString("code"));
     com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();  
     String instituteid = null;
     ArrayList studentfeescollectionList = null;
     ArrayList feesScheduleList = null;
     
     String reqrollnumbertext = null;
     String studentname = null;
     String studentsection = null;
     ArrayList loadscholarshipList  =null;
     String today		= null;
     String formattedCurrency = null;
     String paidformattedCurrency = null;
    // Locale localcurrency = new Locale("en", "IN");
     String formattedCurrency1 = null;
     String paidformattedCurrency1 = null;
     String remformattedCurrency = null;
     String remformattedCurrency1 = null;
     String schformattedCurrency 			= null;
     String schformattedCurrency1 			= null;
     String colformattedCurrency 			= null;
     float totalamount =0f;
     float totalPaidamount =0f;

     float temptotalamount =0f;
     float temptotalPaidamount =0f;

     int count					= 0;
     String studentapprovalid = null;
     try
     {
    	  instituteid = (String)session.getAttribute("instituteid");
    	//  out.println("instituteid"+instituteid);
    	  reqrollnumbertext=request.getParameter("rollnumber");
    	  feesScheduleList = feesscheduleQuery.checkandLoadStudent(reqrollnumbertext,instituteid);
    	  loadscholarshipList =  feesscheduleQuery.loadscholarship(instituteid);
    	  today				= DateTime.showTime("calendar"); 
    	  
    	
    }catch(Exception e){
    	
    	e.printStackTrace();
    	
    }
   
  
    		String studentstandardname  = null;
    		String sectionscheduleid    = null;
    		String studentsectionname   = null;
    		String studentgroupname     = null;
    		String studentboardname     = null;
    		String mediumname      		= null;
    		String firstname      		= null;
    		String middlename      		= null;
    		String lastname      		= null;
    		String emailid      		= null;
    		String imagepath      		= null;
    		String studprefix      		= null;
	    	String studentallocationid  = null;
	    	String userid = null;
	    	
	    	if(feesScheduleList!=null && feesScheduleList.size()>0)
	    	{ int inc = 1;
	   		 		
	    		for(int j=0;j<feesScheduleList.size();j++)
	    		{
				HashMap feesScheduleListMap=(HashMap)feesScheduleList.get(j);
	    		
	    		standardscheduleid     		= (String)feesScheduleListMap.get("standardscheduleid");
	    		sectionscheduleid    = (String)feesScheduleListMap.get("sectionscheduleid");
	    		studentallocationid     	= (String)feesScheduleListMap.get("studentallocationid");
	    		studprefix      		= (String)feesScheduleListMap.get("prefix");
	    		studentapprovalid      		= (String)feesScheduleListMap.get("studentapprovalid");
	    		userid      		= (String)feesScheduleListMap.get("userid");
	    	
	    		
	    		//out.println(userid);
	    		if(middlename==null || middlename.equals("") ||  middlename.equals("-"))
	    		studentname = studprefix+""+firstname+" "+lastname;
	    		else
	    			studentname = studprefix+""+firstname+" "+middlename+" "+lastname;
	    		
	    		if(studentgroupname ==null || studentgroupname.equals("-"))
	    			studentstandardname = studentstandardname;
	    		else
	    			studentstandardname = studentstandardname+" - "+studentgroupname;
	    		}
	    		
	    	%>
	    	
	    	<%
		    }else
		    	{
		    	out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
		    	//out.println("<tr><td colspan=7>Data not Found</td></tr>");
		    	}%>	 
	     
    
 
    
</table>

		
		
		
		<br><br>
<tr>
<td>
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
<%--         	<th scope="col" class="rounded-company"><%=bundle.getString("label.studentfeescollection.Select")%></th>
 --%>        	<th scope="col" class="rounded" ><%=bundle.getString("label.studentfeescollection.TermName")%></th>
        	<th scope="col" class="rounded"><%=bundle.getString("label.studentfeescollection.DueDate")%></th>
        	<th scope="col" class="rounded"><%=bundle.getString("label.studentfeescollection.Amount")%></th>
        	<th scope="col" class="rounded">Scholarship Amount</th>
        	<th scope="col" class="rounded">Scholarship Name</th>
        	<th scope="col" class="rounded"><%=bundle.getString("label.studentfeescollection.PaidAmount")%></th>
        	<th scope="col" class="rounded-q4"><%=bundle.getString("label.studentfeescollection.PendingAmount")%></th>
        	
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=6 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
	     <%
			ArrayList termList 			=  feesscheduleQuery.loadTermFeesDetails(standardscheduleid, userid);
	     
	     	float tempscholarship		= 0f;
	     	float temppscholarship		= 0f;
	     	float pendingamount			= 0f;
	     	float totalscholarship		= 0f;
	     
			HashMap termhashmap =null;
			if(termList != null && termList.size()>0){
				for(int y=0;y<termList.size();y++){
					
					
				termhashmap				= (HashMap)termList.get(y);
				String termfeesid  		= (String)termhashmap.get("termfeesid");	
				String termname  		= (String)termhashmap.get("termname");
				String termfeesamount  	= (String)termhashmap.get("termfeesamount");
				String duedate  		= (String)termhashmap.get("duedate");
				String scholarship  	= (String)termhashmap.get("scholarship");
				String paidbyscholarship= (String)termhashmap.get("paidbyscholarship");
				String schotype = feesscheduleQuery.getScholarshipamountdetails(termfeesid,userid);
				if(schotype == null)
					schotype = "-";
				
				
			 	if(termfeesamount == null)
					termfeesamount = "0";
				 
				if(scholarship == null || scholarship.equals("") || scholarship.equalsIgnoreCase("null"))
					scholarship	= "0";
				
				if(paidbyscholarship == null || paidbyscholarship.equals("") || paidbyscholarship.equalsIgnoreCase("null"))
					paidbyscholarship	= "0";
				
						 
				
				tempscholarship		= Float.parseFloat(scholarship);
				
				temppscholarship	= Float.parseFloat(paidbyscholarship);
		    	
				
	    	    Double lObj2 = Double.valueOf(termfeesamount);
	    	    NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
	    	    formattedCurrency = format.format(lObj2);
		    	    
		    	    
		    	temptotalamount 	=  Float.parseFloat(termfeesamount);
		    	totalamount 		+= Float.parseFloat(termfeesamount);
		    	    
				String paidTermFee 	=  feesscheduleQuery.paidTermFeesDetails(termfeesid,studentapprovalid);

				if(paidTermFee == null)
		    	{
					 paidTermFee = "0";
		    	}
				
				

				Double lObj3 = Double.valueOf(paidTermFee);
		    	    NumberFormat paidFormat = NumberFormat.getCurrencyInstance(localcurrency);
		    	    paidformattedCurrency = paidFormat.format(lObj3);      
		    	    
		    	   temptotalPaidamount = Float.parseFloat(paidTermFee);
		    	 totalPaidamount +=Float.parseFloat(paidTermFee);
		    	   
		    	  
		    	   //pendingamount	= temptotalamount - (tempscholarship + temptotalPaidamount - temppscholarship);
		    	    pendingamount	= temptotalamount -  temptotalPaidamount;
		    	    
		    	    
		    	    if(pendingamount <0)
		    	    	pendingamount	= 0f;

		    	    Double lObjR1 = Double.valueOf(pendingamount+"");
					NumberFormat remFormat = NumberFormat.getCurrencyInstance(localcurrency);
					remformattedCurrency = remFormat.format(lObjR1);					
		    	    
		    	    

					Double lObjR111 = Double.valueOf(tempscholarship+"");
					NumberFormat remFormat1 = NumberFormat.getCurrencyInstance(localcurrency);
					schformattedCurrency = remFormat1.format(lObjR111);		
					
					totalscholarship	+= tempscholarship;

		%>
     <tr>
     <%-- <%if(pendingamount > 0) {%>
     	<td><input type=radio name=termcheck value="<%=termfeesid %>" termname="<%=termname %>"  termamount="<%=termfeesamount %>"  showtermamount="<%=formattedCurrency %>" pendamount="<%=pendingamount%>" onclick="showterm(this)" validate="Term Name" /></td>
     <%}
     else{
     %>
     <td><input type=radio disabled name=termcheck value="<%=termfeesid %>" termname="<%=termname %>"  termamount="<%=termfeesamount %>"  showtermamount="<%=formattedCurrency %>" pendamount="<%=pendingamount%>" onclick="showterm(this)" validate="Term Name" /></td>	
     <%} %> --%>
     
     <td><%= termname%></td>
     <td><%= duedate%></td>
     <td><%= formattedCurrency%></td>
     <td><%= schformattedCurrency%></td>
     <td><%= schotype%></td>
     
     <td><%= paidformattedCurrency%></td>
     <td><%= remformattedCurrency%></td>
     
     </tr>
     <%
				}
			}
			
				
			Double lObj21 = Double.valueOf(totalamount+"");
    	    NumberFormat format1 = NumberFormat.getCurrencyInstance(localcurrency);
    	    formattedCurrency1 = format1.format(lObj21);

    	    Double lObj31 = Double.valueOf(totalPaidamount+"");
			NumberFormat paidFormat1 = NumberFormat.getCurrencyInstance(localcurrency);
			paidformattedCurrency1 = paidFormat1.format(lObj31);
			
			
			//float tototalamounts	= totalamount - (totalPaidamount+totalscholarship);
			float tototalamounts	= totalamount - totalPaidamount;
			
			if(tototalamounts<0)
				tototalamounts	= 0f;
			
			Double lObjR2 = Double.valueOf(tototalamounts+"");
			NumberFormat remFormat1 = NumberFormat.getCurrencyInstance(localcurrency);
			remformattedCurrency1 = remFormat1.format(lObjR2);	  

			Double lObjR21 = Double.valueOf(totalscholarship+"");
			NumberFormat remFormat12 = NumberFormat.getCurrencyInstance(localcurrency);
			schformattedCurrency1 = remFormat12.format(lObjR21);	  


	%>
     <tr><td class=tablebold><%=bundle.getString("label.studentfeescollection.TotalAmount")%></td><td></td><td><%= formattedCurrency1 %></td><td><%=schformattedCurrency1%></td></td><td></td><td><%= paidformattedCurrency1 %></td><td><%= remformattedCurrency1 %></td>

     </tbody>
     </table>
<br><br><br>




<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"><%=bundle.getString("label.studentfeescollection.SL.No")%></th>
        	<th scope="col" class="rounded"><%=bundle.getString("label.studentfeescollection.BankName")%></th>
        	<th scope="col" class="rounded"> <%=bundle.getString("label.studentfeescollection.DDNumber")%> </th>
        	<th scope="col" class="rounded"> <%=bundle.getString("label.studentfeescollection.DDDate")%> </th>
        	<th scope="col" class="rounded"> <%=bundle.getString("label.studentfeescollection.Amount")%></th>
        	<th scope="col" class="rounded"> <%=bundle.getString("label.studentfeescollection.CollectionDate")%></th>
        	<th scope="col" class="rounded-q4"> <%=bundle.getString("label.studentfeescollection.PaymentType1")%></th>
        	</tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=6  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   	    	<%
   	    	String temp_termid="";
      	  studentfeescollectionList = feesscheduleQuery.studentFeesCollectionDetails(standardscheduleid,studentapprovalid,"admin");
      	  
			if(studentfeescollectionList!=null && studentfeescollectionList.size()>0)
	    	{ int inc = 1;
	    	for(int y=0;y<studentfeescollectionList.size();y++){
				
	    		HashMap studentfeescollectionListMap		= (HashMap)studentfeescollectionList.get(y);
				
	    		String feescollectionid = (String)studentfeescollectionListMap.get("feescollectionid");
	    		String termfeesid      	= (String)studentfeescollectionListMap.get("termfeesid");
	    		String termid      		= (String)studentfeescollectionListMap.get("termid");
	    		String termname     	= (String)studentfeescollectionListMap.get("termname");
	    		String bankname      	= (String)studentfeescollectionListMap.get("bankname");
	    		String ddno     = (String)studentfeescollectionListMap.get("ddno");
	    		String dddate     = (String)studentfeescollectionListMap.get("dddate");
	    		if(dddate==null || dddate.equals("null"))
	    			dddate="-";
	    		String collectionamount      = (String)studentfeescollectionListMap.get("collectionamount");
	    		String scholarshipid      = (String)studentfeescollectionListMap.get("scholarshipid");
	    		String feescollectiondate      = (String)studentfeescollectionListMap.get("feescollectiondate");
	    		String feescollectionstatus      = (String)studentfeescollectionListMap.get("feescollectionstatus");
	    		String scholarshipname      = (String)studentfeescollectionListMap.get("scholarshipname");
	    		if(scholarshipname==null )
	    			scholarshipname="No Scholarship";
	    		
	    		
	    		String paymenttype      = (String)studentfeescollectionListMap.get("paymenttype");
	    		if(paymenttype!=null &&  paymenttype.equals("Online"))
	    			paymenttype="Online Payment";
	    		if(bankname==null || bankname.equals(""))
	    			bankname="-";
	    		if(ddno==null || ddno.equals("") )
	    			ddno="-";
				
	    		
	    	%>
		<tr>
		<%
		if(!temp_termid.equals(termid))
		{
		out.println("<tr><td colspan=7 class=tablebold>"+termname+"</td></tr>");
		temp_termid = termid;
		}

		Double lObjCollected = Double.valueOf(collectionamount);
		NumberFormat colFormat1 = NumberFormat.getCurrencyInstance(localcurrency);
		colformattedCurrency = colFormat1.format(lObjCollected);
		%>
		<td><%=inc++ %></td>
		<td><%= bankname%></td>
		<td><%=ddno%></td>
		<td><%=dddate %></td>
		<td><%=colformattedCurrency %></td>
<%-- 		<td><%= scholarshipname%></td>
 --%>		<td><%= feescollectiondate%></td>
		<td><%= paymenttype%></td>
		
	    	</tr>
	    	<%
				} }else
		    	{
					out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
		    	}%>	 
		    	</tbody>
	     </table>


	<input type='hidden' name='todaydate' value='<%=today %>'/>
	<input type=hidden name="studentapprovalid" value="<%=studentapprovalid %>"/>
	<input type=hidden name="reqrollnumbertext" value="<%=reqrollnumbertext%>"/>
	
	<%
	
   }catch(Exception e){e.printStackTrace();}
	 %>
		
		</table>
		
		</td>
	</tr>
	</table>
	
	
						</table>
				</tbody>
			</table>
			</td>
	</tr>
	</table>
		  <a href="#" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentsearch.back") %></strong><span class="bt_blue_r"></span></a>

	
</form>
</div>
<!-- end of right content--></div>
<!--end of center content -->
<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>