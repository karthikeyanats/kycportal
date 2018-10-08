<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<% 	
	java.util.ResourceBundle bundle 	= 	java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.admisionprocess.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">
function admitfun()
{
		//document.applicationform.reg_coursepubid.value  =document.applicationform.coursepublish.options[document.applicationform.coursepublish.options.selectedIndex].value;
    	//document.applicationform.reg_coursename.value  =document.applicationform.coursepublish.options[document.applicationform.coursepublish.options.selectedIndex].text;

    	//alert(document.applicationform.reg_coursepubid.value)

    	if(document.applicationform.regfees.value=="")
    	{
    		alert("Enter Admission Fee")
    		document.applicationform.regfees.focus();
    		return
    	}
    	else
    	{
    		if(confirm("Do you want to admit this Applicant..?"))
    		{
			document.applicationform.action="RegSubmit.jsp";
			document.applicationform.submit();
			}
		}
}
function loadfun()
{
	if(document.applicationform.regfees != null)
	{document.applicationform.regfees.focus()}
}

function back_fun()
{
	document.applicationform.action="RegistrationProcessList_Pre.jsp";
	document.applicationform.submit();
}

function printfun()
{
	var reg_sessiontext = document.applicationform.reg_sessiontext.value;
	var reg_boardname = document.applicationform.reg_boardname.value;
	var reg_coursename = document.applicationform.reg_coursename.value;
	window.open("RegPrintFinal.jsp?applicationid="+document.applicationform.applicationid.value+"&req_sessionname="+reg_sessiontext+"&req_boardname="+reg_boardname+"&standardnamegp="+reg_coursename,"Msg","top=250,left=350,help:no,center:no,status:no,width=500,height=300;")
}

	var count=0;
	var numberOfcount=0;
	var temp=false;
function checkNumber(e) {


	var code;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;

	var character = String.fromCharCode(code);

	 	if(code == 8)
	 	{
			return false;
	 	}
 		if (code==47||code<47||code>57)
 		{
				code=0;
				alert("Enter A Number only")

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
			document.applicationform.regfees.value="";
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
		  document.applicationform.regfees.value="";
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
<body onload="loadfun()">

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

    <h2><%=bundle.getString("label.admisionprocess.rootpath")%></h2>
<form name="applicationform" action="" method="post">
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.admisionprocess.AdmissionProcess")%></th>
        	<th scope="col" class="rounded" width="5%" ></th>
        	<th scope="col" class="rounded-q4" width="5%" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left" colspan=2><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>

     <%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,java.util.ResourceBundle,com.iGrandee.Application.RegistrationProcess,java.text.NumberFormat,java.util.Locale"%>

     <%
 	///ResourceBundle bundle 	= ResourceBundle.getBundle("ResourceBundle.English_eng");
     com.iGrandee.Application.RegistrationProcess  queryBean = new com.iGrandee.Application.RegistrationProcess();	
     com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();	

     //com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
     String state ="";
	 String reg_coursepubid = "";
 	 String reg_coursename = "";
	 reg_coursepubid = request.getParameter("reg_coursepubid");
	 reg_coursename = request.getParameter("reg_coursename");

     String appno=request.getParameter("appno");
     //System.out.println("Adpp no"+appno);
     //if(request.getParameter("state") ==null)
//     	state  = request.getParameter("state")
     String ivalue="";
     String req_sessionid = request.getParameter("reg_sessionid");
     ivalue=queryBean.checkAppNo(appno,reg_coursepubid);
     String req_str  ="";

     if(ivalue!="")
     {

     }
     else
     {
     	req_str = "Application No. Not Found";
     	//response.sendRedirect("Registration_Pre.jsp?alert=notfound");
     }

     ArrayList searchlist = null;
     searchlist=(ArrayList)queryBean.getApplicantDetails(appno);
     if(searchlist.size() ==0 )
     {
     	searchlist = (ArrayList)queryBean.getRegApplicantDetails(appno); 
     }

     HashMap searchmap = null;
     String applicantname=null;
     String applicationnos = null;
     String receipt_no=null;
     String applicationid=null;
     String do_creation=null;
     String type= null;
     String coursepublishid = "";
     String coursename = "";

     	String reg_sessionid = "";
     	String reg_sessiontext = "";
     	//String reg_ctypeid = "";
     	//String reg_ctypetext = "";
		String reg_boardid = "";
     	String reg_boardname = "";

  
    %>
    


 
     <tr><td colspan=2>
    <table id="rounded-corner1" width="100%" border=0>
     <%
     try
     {
     	if(req_str.equals("Application No. Not Found"))
     	{
     		out.println("<tr><td align=center><a class=tablebold><font color=red>"+req_str +"</font></a></td></tr>");
     		//out.println("<tr ><td class=tablebold>Academic Year </td><td>"+request.getParameter("reg_sessiontext")+"</td></tr>");
     		out.print("</table></td><td></td></tr></tbody></table><a href='#' class='bt_blue' onclick='back_fun()'><span class='bt_blue_lft'></span><strong>"+bundle.getString("button.admisionprocess.Back")+"</strong><span class='bt_blue_r'></span></a>");
 
     	}
     	else
     	{
     		
     	
   	 reg_sessionid = request.getParameter("reg_sessionid");
	 reg_sessiontext = request.getParameter("reg_sessiontext");
	 //reg_ctypeid = request.getParameter("reg_ctypeid");
	 //reg_ctypetext = request.getParameter("reg_ctypetext");
	 reg_boardid = request.getParameter("reg_boardid");
	 reg_boardname = request.getParameter("reg_boardname");
	 
     String instituteid = null;
     ArrayList BoardList = null;
     
	 	//ArrayList yearList = queryBean.listYearofSession();
	 	instituteid = (String)session.getValue("instituteid");
	 	ArrayList yearList = applicationQuery.listYearofSession(instituteid);
	 	ArrayList valueList=null;
	 	if(searchlist!=null)
	 	{
	 		if(searchlist.size() >0)
	 		{
	 			for(int i=0;i<searchlist.size();i++)
	 			{
	 				searchmap = (HashMap)searchlist.get(i);
	 				applicantname = (String)searchmap.get("applicantname");
	 				receipt_no=(String)searchmap.get("receiptno");
	 				applicationid=(String)searchmap.get("applicationid");
	 				do_creation=(String)searchmap.get("dateofcreation");
	 				applicationnos = (String)searchmap.get("applicationno");
	 				type =(String)searchmap.get("type");
	 				coursename =(String)searchmap.get("standardname");
	 				coursepublishid =(String)searchmap.get("standardscheduleid");
	
	 				valueList = applicationQuery.listYearofSessionStandard(reg_sessionid,type);
	 				ArrayList chkList = queryBean.checkRegistration(appno);
	 				  //com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
    
    %>

    <tr ><td class=tablebold><%=bundle.getString("label.admisionprocess.AcademicYear")%> </td><td class=tablebold width='2%'>:</td><td><%=reg_sessiontext %></td></tr>
    <tr><td class=tablebold><%=bundle.getString("label.admisionprocess.Standard")%></td><td class=tablebold width='2%'>:</td><td><%=reg_coursename %></td></tr>
        <tr><td class=tablebold><%=bundle.getString("label.admisionprocess.Board")%> </td><td class=tablebold width='2%'>:</td><td><%=reg_boardname%></td></tr>
  <tr ><td class=tablebold><%=bundle.getString("label.admisionprocess.ApplicationNo")%>. </td><td class=tablebold width='2%'>:</td><td><%=applicationnos %></td></tr>
    <tr><td class=tablebold><%=bundle.getString("label.admisionprocess.ReceiptNo")%>. </td><td class=tablebold width='2%'>:</td><td><%=receipt_no %></td></tr>
     <tr><td class=tablebold><%=bundle.getString("label.admisionprocess.ApplicantName")%> </td><td class=tablebold width='2%'>:</td><td><%=applicantname%><input type=hidden name="applicantname" value="<%= applicantname %>"></td></tr>
     <tr><td class=tablebold><%=bundle.getString("label.admisionprocess.ApplicationIssueDate")%> </td><td class=tablebold width='2%'>:</td><td><%=do_creation%></td></tr>
	<% 
	if(chkList.size() == 0)
	{
	%>
	<tr class="tablebold" align=left>
		<td class=tablebold><%=bundle.getString("label.admisionprocess.AdmissionFee")%><font color=red>*</font></td><td class=tablebold width='2%'>:</td><td><input type="text" class=tablelight name="regfees" maxlength="7" onkeypress="checkNumber(event)"> </td>
	</tr>
	<%
	out.print("</table></td><td></td></tr></tbody></table><a href='#' class='bt_blue' onclick='back_fun()'><span class='bt_blue_lft'></span><strong>"+bundle.getString("button.admisionprocess.Back")+"</strong><span class='bt_blue_r'></span></a>");
	out.print("<a href='#' class='bt_green' onclick='admitfun()'><span class='bt_green_lft'></span><strong>"+bundle.getString("button.admisionprocess.Admit")+"</strong><span class='bt_green_r'></span></a>");
	}
	else
	{
		     String formattedRegFeeCurrency = null;
		    // Locale localcurrency = new Locale("en", "IN");
		    ResourceBundle bundle1 	= 	ResourceBundle.getBundle("resources.serversetup");
Locale localcurrency = new Locale(bundle1.getString("language"), bundle1.getString("code"));
		
			HashMap chkmap = (HashMap)chkList.get(0);
			String registrationid = (String)chkmap.get("registrationid");
			String dateofcreation=(String)chkmap.get("dateofcreation");
			String registrationamount =(String)chkmap.get("registrationamount");

    	    Long regFeeObj = Long.valueOf(registrationamount);
    	    NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
    	    formattedRegFeeCurrency = format.format(regFeeObj);
    	    
			out.print("<tr><td class=tablebold>"+bundle.getString("label.admisionprocess.AdmissionFee")+"</td><td class=tablebold width='2%'>:</td><td>"+formattedRegFeeCurrency+"</td></tr>");
			out.print("<tr><td class=tablebold>Admission Date </td><td class=tablebold width='2%'>:</td><td>"+dateofcreation+"</td></tr>");
			out.print("<tr><td class=tablebold>Admission Status </td><td class=tablebold width='2%'>:</td><td>Already Admitted</td></tr>");
			out.print("</table></td><td></td></tr></tbody></table><a href='#' class='bt_blue' onclick='back_fun()'><span class='bt_blue_lft'></span><strong>"+bundle.getString("button.admisionprocess.Back")+"</strong><span class='bt_blue_r'></span></a>");
			out.print("<a href='#' class='bt_green' onclick='printfun()'><span class='bt_green_lft'></span><strong>Print</strong><span class='bt_green_r'></span></a>");
	}
	%>
	

		
		<%	}
		}
			else
			{
				out.println("<tr><td>No information, check again</td></tr>");
			}
		}
		else
		{
			out.println("<tr><td>No information, check again</td></tr>");
		}
%>

     <!--  <a href="./StandardList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong>View all Standards </strong><span class="bt_blue_r"></span></a>
	<a href="#" class="bt_red" onclick="back_fun()"><span class="bt_red_lft"></span><strong>Back</strong><span class="bt_red_r"></span></a>-->

<input type=hidden name="applicationid" value="<%= applicationid %>">
<input type=hidden name="applicationnos" value="<%= applicationnos %>">

<input type=hidden name="reg_coursepubid" value="<%= reg_coursepubid %>">
<input type=hidden name="reg_coursename" value="<%= reg_coursename %>">
<input type=hidden name="reg_sessiontext" value="<%= reg_sessiontext %>">
<input type=hidden name="reg_boardname" value="<%= reg_boardname %>">





<% 	 	
     	}
     	//out.print("</table></td><td></td></tr></tbody></table><a href='#' class='bt_blue' onclick='back_fun()'><span class='bt_blue_lft'></span><strong>Back</strong><span class='bt_blue_r'></span></a>");
     	out.print("</table></td></tr></tbody></table>");
     }
     catch(Exception e)
     {
    	 e.printStackTrace();
     	System.out.println("INTRAPORTAL"+e.getMessage());
     }
%>
 
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>