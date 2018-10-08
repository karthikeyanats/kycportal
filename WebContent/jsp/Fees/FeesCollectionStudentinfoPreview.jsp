<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
	ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle1.getString("label.studentfeescollection.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">

function addFeesAllocation()
{
		if(confirm("Do you want to submit the fees amount?"))
		{
			document.feescollectionform.action="./Feescollectionsubmit.jsp";
			document.feescollectionform.submit();
		}
}
function backfun()
{
		document.feescollectionform.action="./FeesCollectionStudentinfo.jsp";
		document.feescollectionform.submit();
}


function showterm(obj)
{
	var spanvalue		= document.getElementById("termselected");
	spanvalue.innerHTML = " for "+obj.getAttribute("termname");
	document.feescollectionform.termcheckid.value = obj.value;
//termselected.innerHTML = obj.value;
}

var count=0;
var temp=false;
var numberOfcount=0;

function checkNumber(e) {


	var code;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;

	var character = String.fromCharCode(code);


	//alert(code);

//code >48,49,50,51,52,53,54,55,56,57,58 <codeFeesCollectionStudentinfo
//if(code > 48 && 59<code)
//{
//	alert("enter onlynumeric value");
//}

	 //if(code == 8)
	 /*if(code > 48 && 59<code)
		 {
		 	if(window.event != null)
		 	{
				window.event.keyCode 	= 505;
				event.cancelBubble		= true;
				event.returnValue		= false;

			}
			else
			{
				e.preventDefault();
			 }
			 				 return false;

		 }*/
	 	if(code == 8 || code == 9)
	 	{
			return false;
	 	}
 		if (code==47||code<46||code>57)
 		{
				code=0;
				alert("Enter a Number only")

			if(window.event != null)
		 	{
				window.event.keyCode 	= 505;
				event.cancelBubble		= true;
				event.returnValue		= false;

			}
			else
			{
				e.preventDefault();
			 }
			 	 return false;
		}
		if(code==46)
		{
		 count=count+1;
		 temp=true;
		}
		if(count>1)
		{
			code=0;
			alert("Only One Dot Allowed")
			document.ApplicantSearch.applicationCost.value="";
			numberOfcount=0;
			temp=false;
			count=0;
				if(window.event != null)
					{
					window.event.keyCode 	= 505;
					event.cancelBubble		= true;
					event.returnValue		= false;
				
				}
				else
				{
					e.preventDefault();
				}
		}
      if(temp==true)
      {
		  numberOfcount=numberOfcount+1;
	  }
	  if (numberOfcount==4)
	  {
		  alert("After Dot Two Digit Only Allowed");
		  code=0;
		  numberOfcount=0;
		  document.ApplicantSearch.applicationCost.value="";
		  temp=false;
		  count=0;
				if(window.event != null)
					{
					window.event.keyCode 	= 505;
					event.cancelBubble		= true;
					event.returnValue		= false;
				
				}
				else
				{
					e.preventDefault();
				}		  
	  }		 
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

    <h2> <%=bundle1.getString("label.studentfeescollection.rootpathpreview")%></h2>
	
	<form name="feescollectionform" action="" method="post">
  	
  	<%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,java.text.NumberFormat,java.util.Locale"%>
    <%
     
     	com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();  
		ResourceBundle bundle 		= 	ResourceBundle.getBundle("resources.serversetup");
		Locale localcurrency 		= new Locale(bundle.getString("language"), bundle.getString("code"));
     	String instituteid 			= null;
     	ArrayList studentfeescollectionList = null;
     	ArrayList feesScheduleList 	= null;
     
	    String reqrollnumbertext	= null;
	    
	    String userid				= null;
	    
		String paymenttype1		= request.getParameter("paymenttype");
		String paymenttypeall[]	= request.getParameterValues("paymenttype");
	    String bankname[]		= request.getParameterValues("bankname"); 
		String ddnumber[]		= request.getParameterValues("ddnumber") ;
		String dddate[]			= request.getParameterValues("dddate");
		String ddamount[]		= request.getParameterValues("ddamount");
		String paymenttype[]	= request.getParameterValues("scholarshiptype");
		String paymenttypename[]= request.getParameterValues("paymenttypename");
		String termcheckid		= request.getParameter("termcheckid");
		String Termname			= request.getParameter("radioname");
		String termamount		= request.getParameter("termamount");
	
		String studentname			= "";
	    int count					= 0;
	    String studentapprovalid 	= null;
     
   
    	  instituteid 				= (String)session.getAttribute("instituteid");
    	  reqrollnumbertext			= request.getParameter("reqrollnumbertext");
    	  feesScheduleList 			= feesscheduleQuery.checkandLoadStudent(reqrollnumbertext,instituteid);
    	
    	HashMap hashMap				= null;
    	ArrayList loadscholarshipList =  feesscheduleQuery.loadscholarship(instituteid);
    	
    	HashMap scholarshipMap		= new HashMap(); 
    	
    	if(loadscholarshipList != null && loadscholarshipList.size()>0)
    	for(int y=0;y<loadscholarshipList.size();y++){
    		hashMap		= (HashMap)loadscholarshipList.get(y);
    		scholarshipMap.put(hashMap.get("scholarshipid"), hashMap.get("scholarshipname"));
    	}
    	
    	
    	ArrayList scholarshipDetail	= null;

    	  
    	
    
    if(feesScheduleList!=null && feesScheduleList.size()>0)
	{
    %>
    <input type="hidden" name=paymenttype1 value="<%=paymenttype1%>">
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        
        	<th scope="col" class="rounded-company" width="90%"><%=bundle1.getString("label.studentfeescollection.StudentInformation")%></th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   
    <tr><td colspan=2><table id="rounded-corner1" width="100%">
    	<tr>
    	<td>
	    	<table border="0" cellpadding="0" cellspacing="0" width="90%" align="center">
	    	<%
	    	String standardscheduleid     = null;
	    	if(feesScheduleList!=null && feesScheduleList.size()>0)
	    	{ int inc = 1;

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
	    		String emailid      = (String)feesScheduleListMap.get("emailid");
	    		String imagepath      = (String)feesScheduleListMap.get("imagepath");
	    		String studprefix      = (String)feesScheduleListMap.get("prefix");
	    		studentapprovalid      = (String)feesScheduleListMap.get("studentapprovalid");
	    		
	    		userid		= (String)feesScheduleListMap.get("userid");
	    		
	    		if(middlename==null || middlename.equals("") ||  middlename.equals("-"))
	    		studentname = studprefix+" "+firstname+" "+lastname;
	    		else
	    			studentname = studprefix+" "+firstname+" "+middlename+" "+lastname;
	    		
	    		if(studentgroupname ==null || studentgroupname.equals("-"))
	    			studentstandardname = studentstandardname;
	    		else
	    			studentstandardname = studentstandardname+""+studentgroupname;
	    		
	    		 Double lObj2 = Double.valueOf(termamount);
		    	    NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
		    	  String  formattedtermamount = format.format(lObj2);
	    	%>
	    	
	    	<tr><td class=tablebold><%=bundle1.getString("label.studentfeescollection.StudentRollNumber")%></td><td  class=tablebold width=1px>:</td><td><%=reqrollnumbertext %><td class=tablebold><%=bundle1.getString("label.studentfeescollection.StudentName")%></td><td class=tablebold width=1px>:</td><td><%=studentname %></td></tr>
	    	<tr><td class=tablebold><%=bundle1.getString("label.studentfeescollection.Standard")%></td><td class=tablebold width=1px>:</td><td><%=studentstandardname%><td class=tablebold><%=bundle1.getString("label.studentfeescollection.Section")%></td><td class=tablebold width=1px>:</td><td><%=studentsectionname%></td></tr>
	    	<tr><td class=tablebold><%=bundle1.getString("label.studentfeescollection.TermName")%></td><td class=tablebold width=1px>:</td><td ><%=Termname%></td><td class=tablebold><%=bundle1.getString("label.studentfeescollection.TermAmount")%></td><td class=tablebold width=1px>:</td><td ><%=formattedtermamount%></td></tr>
	    	
	    	<%
		    }else
		    	{
		    	out.println("<tr align='center' class='tablebold'><td colspan='2'><font color='red'>Data Not Found</font></td></tr>");
		    	}%>	 
	       </table>
	    </td>
	    </tr>
    </table>
    </td></tr>
    </tbody>
</table>

  <br><br><br>
  
	<table border="0" cellpadding=5 cellspacing=0 width="100%" id=rounded-corner>
	    <thead>
		    <tr>
			    <th scope="col" 	class="rounded-company"><%=bundle1.getString("label.studentfeescollection.SL.No")%></th>
			    <th scope="col" 	class="rounded"><%=bundle1.getString("label.studentfeescollection.PaymentType1")%></th>
			    <th scope="col" 	class="rounded"><%=bundle1.getString("label.studentfeescollection.Bank/BranchName")%></th>
			    <th scope="col" 	class="rounded"><%=bundle1.getString("label.studentfeescollection.DD.Number")%></th>
			    <th scope="col" 	class="rounded"><%=bundle1.getString("label.studentfeescollection.DDDate")%></th>
			    <th scope="col" 	class="rounded"><%=bundle1.getString("label.studentfeescollection.Amount")%></th>
			    <th scope="col" 	class="rounded-q4"></th>
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
	String  formattedtotalamount	= "";
	int serialnumber				= 0;


	scholarshipDetail		= feesscheduleQuery.getScholarshipDetails(termcheckid, userid, studentapprovalid);
	
	float totalamount=0;
	
	if(bankname != null && bankname.length>0)
	{
		for(int i=0;i<bankname.length;i++)
		{
			serialnumber++;
			%>
			
			<tr>
				<td><%=serialnumber%></td>
				<td><%=paymenttypeall[i]%><input type="hidden" name="paymenttype" value="<%=paymenttypeall[i]%>"></td>
			<%
			
			if(paymenttypeall[i] != null &&  paymenttypeall[i].equals("DD"))
			{
			%>
				<td><%=bankname[i]%><input type="hidden" name="bankname" value="<%=bankname[i]%>"></td>
				<td><%=ddnumber[i]%><input type="hidden" name="ddnumber" value="<%=ddnumber[i]%>"></td>
				<td><%=dddate[i]%><input type="hidden" name="dddate" value="<%=dddate[i]%>"></td>
			<%
			}
			else{
			%>
				<td>-<input type="hidden" name="bankname" value="-"></td>
				<td>-<input type="hidden" name="ddnumber" value="-"></td>
				<td>-<input type="hidden" name="dddate" value="-"></td>
			<%
			}
				
			Double lObj2 = Double.valueOf(ddamount[i]);
	    	  NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
	    	  String  formattedddamount = format.format(lObj2);
		%>
			<td><%=formattedddamount%><input type="hidden" name="ddamount" value="<%=ddamount[i]%>"><input type="hidden" name="schemeforstudentid" value="null"></td>
			<td><input type="hidden" name="scholarshiptype" value=""></td>
		</tr>
		
		<%
		totalamount +=Float.parseFloat(ddamount[i]);
			
		}
		
		Double lObj2 = Double.valueOf(totalamount);
  	    NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
  	    formattedtotalamount = format.format(lObj2);
		
	} 
	if(scholarshipDetail != null && scholarshipDetail.size()>0)
	{
		for(int i=0;i<scholarshipDetail.size();i++)
		{
			
			hashMap		= (HashMap)scholarshipDetail.get(i);
			serialnumber++;
			%>
			
			<tr>
				<td><%=serialnumber%></td>
				<td>Scholarship<input type="hidden" name="paymenttype" value="Cash"></td>
				<td>-<input type="hidden" name="bankname" value="-"></td>
				<td>-<input type="hidden" name="ddnumber" value="-"></td>
				<td>-<input type="hidden" name="dddate" value="-"></td>

			<%
				
			  Double lObj2 = Double.valueOf((String)hashMap.get("amount"));
	    	  NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
	    	  String  formattedddamount = format.format(lObj2);
		%>
			<td><%=formattedddamount%><input type="hidden" name="ddamount" value="<%=hashMap.get("amount")%>"><input type="hidden" name="schemeforstudentid" value="<%=hashMap.get("schemeforstudentid")%>"></td>
			<td><%=hashMap.get("scholarshipname")%><input type="hidden" name="scholarshiptype" value="<%=hashMap.get("scholarshipid")%>"></td>
		</tr>
		
		<%
		totalamount +=Float.parseFloat((String)hashMap.get("amount"));
			
		}
		
		Double lObj2 = Double.valueOf(totalamount);
  	    NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
  	    formattedtotalamount = format.format(lObj2);
		
	} 

	%>

    <tr><td></td><td></td><td></td><td></td><td class=tablebold><%=bundle1.getString("label.studentfeescollection.TotalAmount")%></td><td><%= formattedtotalamount %><input type="hidden" name="paidamount" value="<%= totalamount %>"></input></td><td></td></tr>
		
	</tbody>
    </table>
    
	<a href="#" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong><%=bundle1.getString("button.studentfeescollection.Back")%></strong><span class="bt_blue_r"></span></a>
    <a href="#" class="bt_green" onclick="addFeesAllocation()"><span class="bt_green_lft"></span><strong><%=bundle1.getString("button.studentfeescollection.Save")%></strong><span class="bt_green_r"></span></a>
      
 <%}
    else
    {
    	out.println("Data Not Found");
        out.print("<a href='./FeesCollection_pre.jsp' class='bt_blue'><span class='bt_blue_lft'></span><strong>"+bundle1.getString("button.studentfeescollection.Back")+"</strong><span class='bt_blue_r'></span></a>");
    }

    
    %>
    
    
    <input type="hidden" name="termamount" 			value="<%=termamount%>"/>
	<input type="hidden" name="termcheckid" 		value="<%=termcheckid%>"/>
	<input type="hidden" name="studentapprovalid" 	value="<%=studentapprovalid%>"/>
	<input type="hidden" name="rollnumbertext" 		value="<%=reqrollnumbertext%>"/>
	<input type="hidden" name="termname" 			value="<%=Termname%>"/>
	
	
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    
</div>
</body>
</html>