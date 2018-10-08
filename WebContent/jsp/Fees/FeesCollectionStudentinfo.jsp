<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
	
	ResourceBundle bundle1  = ResourceBundle.getBundle("resources.ApplicationResources");

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle1.getString("label.studentfeescollection.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">


	var pendingamount	= 0;
	

	function showterm(obj)
	{
		
		var spanvalue			= document.getElementById("termselected");
		spanvalue.innerHTML 	= " for "+obj.getAttribute("termname") +"  and   Term Fees Amount :"+obj.getAttribute("pendamount") +"";
		
		document.feescollectionform.pendingamount.value		= obj.getAttribute("pendamount");
		document.feescollectionform.radioname.value			= obj.getAttribute("termname");
		document.feescollectionform.termamount.value		= obj.getAttribute("termamount");
		document.feescollectionform.termcheckid.value 		= obj.value;
		
		pendingamount	= parseFloat(obj.getAttribute("pendamount"),10);
		
		for(var i=0;i<document.feescollectionform.feecollections.length-1;i++)
		{
			if(document.feescollectionform.feecollections[i].checked)
				document.feescollectionform.feecollections[i].click();
		}
		
	}

	function checkAmountFees(obj){
		
		var position	= parseInt(obj.getAttribute("position"));
		
		if(obj.checked){
			
			
			if(check_ForParticularElements(document.feescollectionform.termcheck,"radio", document.feescollectionform.paymenttype[position],"select")){
				
				if(document.feescollectionform.paymenttype[position].options[document.feescollectionform.paymenttype[position].options.selectedIndex].text == "DD"){
					
					if(!check_ForParticularElements(document.feescollectionform.bankname[position],"text",document.feescollectionform.ddnumber[position],"text",document.feescollectionform.dddate[position],"text")){
						obj.checked	= false;
						return false;
					}
					else{
						
						/* var pattern	= /^\d{0,10000000}$/g; */
						var pattern	= /^[a-zA-Z0-9]{1,11}$/;
						
						if(!pattern.test(document.feescollectionform.ddnumber[position].value)){
							
							alert("Please enter a valid DD Number.(Alphanumeric characters only)");
							obj.checked	= false;
							return false;
						}
					}
				}
				
				
				if(check_ForParticularElements(document.feescollectionform.ddamount[position],"text")){
					
					
					if(!isNaN(document.feescollectionform.ddamount[position].value)){
						
						document.feescollectionform.ddamount[position].value	= parseFloat(document.feescollectionform.ddamount[position].value).toFixed(2);
						
						if(parseFloat(document.feescollectionform.ddamount[position].value,10)>0){
						
							if(parseFloat(document.feescollectionform.ddamount[position].value,10) <= pendingamount){
								
						
								pendingamount	-= parseFloat(document.feescollectionform.ddamount[position].value,10).toFixed(2);
								console.log("decrement--"+pendingamount);
								
								document.feescollectionform.bankname[position].disabled			= true;
								document.feescollectionform.ddnumber[position].disabled			= true;
								document.feescollectionform.dddate[position].disabled			= true;
								document.feescollectionform.ddamount[position].disabled			= true;
								document.feescollectionform.ddamount[position].disabled			= true;
								document.feescollectionform.paymenttype[position].disabled		= true;
								document.feescollectionform.scholarshiptype[position].disabled	= true;
								
								
							}
							else{
								alert("Paying amount exceeds pending amount.");
								obj.checked	= false;
								return false;
							}
						}
						else{

							alert("Paying amount must be greater than zero.");
							obj.checked	= false;
							return false;
						}
					}
					else{
						
						alert("Please enter a valid amount.");
						obj.checked		= false;
						document.feescollectionform.ddamount[position].value	= "";
						return false;
					}
					
				}
				else{
					
					obj.checked		= false;
					return false;
				}

				
			}
			else{
				obj.checked		= false;
				return false;
			}
			
		}else{
			
			pendingamount	+= parseFloat(document.feescollectionform.ddamount[position].value,10);
			
			document.feescollectionform.bankname[position].disabled			= false;
			document.feescollectionform.ddnumber[position].disabled			= false;
			document.feescollectionform.dddate[position].disabled			= false;
			document.feescollectionform.ddamount[position].disabled			= false;
			document.feescollectionform.ddamount[position].disabled			= false;
			document.feescollectionform.paymenttype[position].disabled		= false;
			document.feescollectionform.scholarshiptype[position].disabled	= false;
			
		}
		
		document.getElementById("termselected").innerHTML 	= " for "+ document.feescollectionform.radioname.value +"  and   Term Fees Amount :"+ pendingamount +"";
				
	}
	
	
	

	function addFeesAllocation()
	{

		if(check_ForParticularElements(document.feescollectionform.termcheck,"radio", document.feescollectionform.feecollections,"checkbox")){
			
			
			for(var i=0;i<document.feescollectionform.feecollections.length-1;i++)
			{
				if(document.feescollectionform.feecollections[i].checked)
				{

					document.feescollectionform.bankname[i].disabled		= false;
					document.feescollectionform.ddnumber[i].disabled		= false;
					document.feescollectionform.dddate[i].disabled			= false;
					document.feescollectionform.ddamount[i].disabled		= false;
					document.feescollectionform.ddamount[i].disabled		= false;
					document.feescollectionform.paymenttype[i].disabled		= false;
					document.feescollectionform.scholarshiptype[i].disabled	= false;
					
				}
				else{
					
					document.feescollectionform.bankname[i].disabled		= true;
					document.feescollectionform.ddnumber[i].disabled		= true;
					document.feescollectionform.dddate[i].disabled			= true;
					document.feescollectionform.ddamount[i].disabled		= true;
					document.feescollectionform.ddamount[i].disabled		= true;
					document.feescollectionform.paymenttype[i].disabled		= true;
					document.feescollectionform.scholarshiptype[i].disabled	= true;
					
				}
			}
			
			document.feescollectionform.action		= "./FeesCollectionStudentinfoPreview.jsp";
			document.feescollectionform.submit();
		}
	}

	var count			= 0;
	var temp			= false;
	var numberOfcount	= 0;


	function checkNumber(e) {


		var code;
		if (!e) var e = window.event;
		if (e.keyCode) code = e.keyCode;
		else if (e.which) code = e.which;
	
		var character = String.fromCharCode(code);


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
		 	count	= count+1;
		 	temp	= true;
		 	
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
				return false;
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
					return false;	
			  }		 
		 	
		 	
		 	
		}
}
	
	function changetype(obj)
	{
	//	alert(obj.getAttribute("pos")+"__"+obj.selectedIndex)
	//	alert(document.feescollectionform.paymenttype[obj.getAttribute("pos")].options[obj.selectedIndex].text)
		document.feescollectionform.bankname[obj.getAttribute("pos")].disabled		= false;
			document.feescollectionform.ddnumber[obj.getAttribute("pos")].disabled		= false;
			document.feescollectionform.dddate[obj.getAttribute("pos")].disabled		= false;
		if(document.feescollectionform.paymenttype[obj.getAttribute("pos")].options[obj.selectedIndex].text=="Cash")
		{		
			document.feescollectionform.bankname[obj.getAttribute("pos")].disabled		= true;
			document.feescollectionform.ddnumber[obj.getAttribute("pos")].disabled		= true;
			document.feescollectionform.dddate[obj.getAttribute("pos")].disabled		= true;
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

    <h2><%=bundle1.getString("label.studentfeescollection.rootpath")%></h2>
<form name="feescollectionform" action="" method="post">
  <%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,java.text.NumberFormat,java.util.Locale"%>

     <%
      
     com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();  
     
    String userid	 						= "";
    String instituteid 						= null;
    ArrayList studentfeescollectionList 	= null;
    ArrayList feesScheduleList 				= null;
    String reqrollnumbertext 				= null;
    String studentstandard 					= null;
    String studentname 						= null;
    String studentsection 					= null;
    ArrayList loadscholarshipList  			= null;
    String today							= null;
    String formattedCurrency 				= null;
    String paidformattedCurrency 			= null;
    ResourceBundle bundle 					= 	ResourceBundle.getBundle("resources.serversetup");
	Locale localcurrency 					= new Locale(bundle.getString("language"), bundle.getString("code"));
    String formattedCurrency1 				= null;
     String paidformattedCurrency1 			= null;
     String remformattedCurrency 			= null;
     String remformattedCurrency1 			= null;
     String colformattedCurrency 			= null;
     String schformattedCurrency 			= null;
     String schformattedCurrency1 			= null;
     String fathername = null;
     float totalamount 						= 0f;
     float totalPaidamount 					= 0f;
     float temptotalamount 					= 0f;
     float temptotalPaidamount 				= 0f;
     
     int count								= 0;

     String studentapprovalid 				= null;
     
     try
     {
    	  instituteid = (String)session.getAttribute("instituteid");
    	//  out.println("instituteid"+instituteid);
    	  reqrollnumbertext=request.getParameter("rollnumbertext");
    	  feesScheduleList = feesscheduleQuery.checkandLoadStudent(reqrollnumbertext,instituteid);
    	  loadscholarshipList =  feesscheduleQuery.loadscholarship(instituteid);
    	  today				= DateTime.showTime("calendar"); 
    	  
    	
    }catch(Exception e){
    	
    	e.printStackTrace();
    	
    }
    
    if(feesScheduleList!=null && feesScheduleList.size()>0)
	{
    %>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="90%"><%=bundle1.getString("label.studentfeescollection.StudentInformation")%></th>
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
	    		String emailid      = (String)feesScheduleListMap.get("emailid");
	    		String imagepath      = (String)feesScheduleListMap.get("imagepath");
	    		String studprefix      = (String)feesScheduleListMap.get("prefix");
	    		studentapprovalid      = (String)feesScheduleListMap.get("studentapprovalid");
	    		if(feesScheduleListMap.get("fathername") == null)
	    			fathername="-";
	    		else
	    			fathername      = (String)feesScheduleListMap.get("fathername");
	    		
	    		
	    		if(middlename==null || middlename.equals("") ||  middlename.equals("-"))
	    		studentname = studprefix+" "+firstname+" "+lastname;
	    		else
	    			studentname = studprefix+" "+firstname+" "+middlename+" "+lastname;
	    		
	    		if(studentgroupname ==null || studentgroupname.equals("-"))
	    			studentstandardname = studentstandardname;
	    		else
	    			studentstandardname = studentstandardname+""+studentgroupname;
	    		
	    		userid					= (String)feesScheduleListMap.get("userid");
	    		
	    	%>
	    	
	    	<tr>
	    		<td class=tablebold><%=bundle1.getString("label.studentfeescollection.StudentRollNumber")%></td>
	    		<td class=tablebold>:</td><td><%=reqrollnumbertext %></td>
	    		<td class=tablebold><%=bundle1.getString("label.studentfeescollection.StudentName")%></td>
	    		<td class=tablebold>:</td><td><%=studentname %></td>
	    		<td  rowspan=2 valign=top><img src='<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=imagepath %>' width=60 height=47></td>
	    		</tr>
	    		
<tr>
	    	<td class=tablebold>Father Name</td>
		    	<td class=tablebold>:</td><td colspan=2><%=fathername %></td>
	    	
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

<br><br><br>




<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company"><%=bundle1.getString("label.studentfeescollection.Select")%></th>
        	<th scope="col" class="rounded" ><%=bundle1.getString("label.studentfeescollection.TermName")%></th>
        	<th scope="col" class="rounded"><%=bundle1.getString("label.studentfeescollection.DueDate")%></th>
        	<th scope="col" class="rounded"><%=bundle1.getString("label.studentfeescollection.Amount")%></th>
        	<th scope="col" class="rounded">Scholarship Amount</th>
        	<th scope="col" class="rounded">Scholarship Name</th>
        	<th scope="col" class="rounded"><%=bundle1.getString("label.studentfeescollection.PaidAmount")%></th>
        	<th scope="col" class="rounded-q4"><%=bundle1.getString("label.studentfeescollection.PendingAmount")%></th>
        	
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=7 class="rounded-foot-left"><em></em></td>
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
     <%if(pendingamount > 0) {%>
     	<td><input type=radio name=termcheck value="<%=termfeesid %>" termname="<%=termname %>"  termamount="<%=termfeesamount %>"  showtermamount="<%=formattedCurrency %>" pendamount="<%=pendingamount%>" onclick="showterm(this)" validate="Term Name" /></td>
     <%}
     else{
     %>
     <td><input type=radio disabled name=termcheck value="<%=termfeesid %>" termname="<%=termname %>"  termamount="<%=termfeesamount %>"  showtermamount="<%=formattedCurrency %>" pendamount="<%=pendingamount%>" onclick="showterm(this)" validate="Term Name" /></td>	
     <%} %>
     
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
     <tr><td></td><td class=tablebold><%=bundle1.getString("label.studentfeescollection.TotalAmount")%></td><td></td><td><%= formattedCurrency1 %></td><td><%=schformattedCurrency1%></td></td><td></td><td><%= paidformattedCurrency1 %></td><td><%= remformattedCurrency1 %></td>

     </tbody>
     </table>
<br><br><br>




<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"><%=bundle1.getString("label.studentfeescollection.SL.No")%></th>
        	<th scope="col" class="rounded"><%=bundle1.getString("label.studentfeescollection.BankName")%></th>
        	<th scope="col" class="rounded"> <%=bundle1.getString("label.studentfeescollection.DDNumber")%> </th>
        	<th scope="col" class="rounded"> <%=bundle1.getString("label.studentfeescollection.DDDate")%> </th>
        	<th scope="col" class="rounded"> <%=bundle1.getString("label.studentfeescollection.Amount")%></th>
        	<th scope="col" class="rounded"> <%=bundle1.getString("label.studentfeescollection.CollectionDate")%></th>
        	<th scope="col" class="rounded-q4"> <%=bundle1.getString("label.studentfeescollection.PaymentType1")%></th>
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
	     <br></br>
	  	<table border=0 cellpadding=0 cellspacing=0 width="80%">
	    	<tr>
	    		<td class=tablebold colspan=2><%=bundle1.getString("label.studentfeescollection.FeesamountEntry")%> <span id="termselected"></span><input type=hidden name="termcheckid"></td>
	     	</tr>
			<tr>
				<td colspan=2>&nbsp;</td>
			</tr>
    	</table>
    
<table border="0" id="rounded-corner1"  cellpadding=5 cellspacing=0 width="100%">
    <tr class="tableheading">
    	<td>Check</td>
		<td >Payment</td>    	
    	<td><%=bundle1.getString("label.studentfeescollection.Bank/BranchName")%></td>
    	<td><%=bundle1.getString("label.studentfeescollection.DD.Number")%></td>
    	<td><%=bundle1.getString("label.studentfeescollection.DDDate")%></td>
    	<td width="30"><%=bundle1.getString("label.studentfeescollection.Amount")%></td>
    	<%-- <td><%=bundle1.getString("label.studentfeescollection.PaymentType")%></td> --%>
    </tr>
	<%int inc=1;for(int x1=0;x1<=4;x1++){ %><tr>
		
		<td><input class="amtcheckcol1" type="checkbox" name="feecollections" onclick="checkAmountFees(this)" position="<%=x1%>" validate="Fee Amount" /></td>
		<td>
			<select name="paymenttype" class=tablelight  validate="Payment Type" pos="<%=x1%>" onchange=changetype(this)>
				<option value="">-Type-</option>
				<option value="Cash">Cash</option>
				<option value="DD">DD</option>
			</select>
		</td>		
		<td><input type="text" name="bankname" maxlength="100" size="10"  class=tablelight validate="Bank Name"/></td>
		<td><input type="text" name="ddnumber" maxlength="10"  size="10"  class=tablelight validate="DD Number" /></td>
		<td><input type='text' name='dddate' size='11' validate='DD Date' onfocus='this.blur()'/><input type='button' name="datbutton" value='^' onclick=Calendar_Fun("<%= request.getContextPath()%>/js/Calendar/CalendarWindow.html",'feescollectionform.dddate[<%= count%>]','0',event,'Not_Less_Than_TodayDDdate',feescollectionform.todaydate)></input></td>
		<td><input type="hidden" name="scholarshiptype" /><input type="text" name="ddamount" class=tablelight validate='Amount' maxlength="25" size="10"/></td>
		<%-- <td><select name="scholarshiptype" class=tablelight row='<%=x1%>' validate="Scholarship Type">
		<option value="">-Select Scholarship Type-</option>
		<%
		HashMap hashmap =null;
				if(loadscholarshipList != null && loadscholarshipList.size()>0){
					for(int y=0;y<loadscholarshipList.size();y++){
						hashmap		= (HashMap)loadscholarshipList.get(y);	
						out.println("<option value='"+hashmap.get("scholarshipid")+"'>"+hashmap.get("scholarshipname")+"</option>");
					}
			}
				
		%>
		</select><input type="hidden" name="paymenttypename"/></td>--%>
	</tr>
	<%count++;}%>
	<tr><td></td></tr>
    </table>
	
	<a href="./FeesCollection_pre.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle1.getString("button.studentfeescollection.Back")%></strong><span class="bt_blue_r"></span></a>
    <a href="#" class="bt_green" onclick="addFeesAllocation()"><span class="bt_green_lft"></span><strong><%=bundle1.getString("button.studentfeescollection.Save")%></strong><span class="bt_green_r"></span></a>
      
 <%}
    else
    {
    	out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");
    	//out.println("Data Not Found");
        out.print("<a href='./FeesCollection_pre.jsp' class='bt_blue'><span class='bt_blue_lft'></span><strong>"+bundle1.getString("button.studentfeescollection.Back")+"</strong><span class='bt_blue_r'></span></a>");
    }
    %>
    <input type='hidden' name='pendingamount' 		value=''/>
    <input type='hidden' name='termamount' 			value=''/>
   	<input type='hidden' name='radioname' 			value=''/>
	<input type='hidden' name='todaydate' 			value='<%=today%>'/>
	<input type='hidden' name="studentapprovalid" 	value="<%=studentapprovalid %>"/>
	<input type='hidden' name="reqrollnumbertext" 	value="<%=reqrollnumbertext%>"/>
	
	<input type='hidden' name="termcheck" 			disabled/>
	<input type='hidden' name="bankname" 			disabled/>
	<input type='hidden' name="ddnumber" 			disabled/>
	<input type='hidden' name="dddate" 				disabled/>
	<input type='hidden' name="ddamount" 			disabled/>
	<input type='hidden' name="paymenttype" 		disabled/>
	<input type='hidden' name="scholarshiptype" 	disabled/>
	<input type='hidden' name="feecollections" 		disabled/>
	
	
	
	
	
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>