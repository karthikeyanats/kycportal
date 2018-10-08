<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<% 	
	java.util.ResourceBundle bundle 	= 	java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Exam Mark List | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">
<script type="text/javascript">
	function goBack()
	{
	window.close();
	}
	
	function printfun()
	{	
	document.getElementById("printbutt").style.visibility='hidden';
	document.getElementById("backbutt").style.visibility='hidden';
	window.print();
	document.getElementById("printbutt").style.visibility='visible';
	document.getElementById("backbutt").style.visibility='visible';	
	}
	
</script>
</head>
<body>
<%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,java.text.NumberFormat,java.util.Locale"%>
<jsp:useBean id="date_object" scope="page" class="com.iGrandee.Common.DateTime"/>
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.SchoolCalender.SchoolCalenderBean" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Registration.InstitutionQurey"%>
	<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime"%>
	

	<%
	 	String date_str = date_object.showTime("WithTime");	 
	 	com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();	
	 	InstitutionQurey insquery=new InstitutionQurey();
		String instituteid			= (String)session.getValue("instituteid");
		ArrayList insdetails=insquery.getInstituteDetails(instituteid);
		String yearofsession=request.getParameter("sessionname");
		String boardName=request.getParameter("boardname");
		String checkoption=request.getParameter("amountradio");

 		String fromdate=date_object.getMySQLFormat(request.getParameter("appFromdate")+"")+"";
		String todate=date_object.getMySQLFormat(request.getParameter("appTodate")+"")+"";
		String todaydate=date_object.getMySQLFormat(request.getParameter("todaydate")+"")+"";
		//String datewisedate=date_object.getMySQLFormat(request.getParameter("datewise")+"")+"";

		ArrayList feesCollectionList= null;
		String appCostCurrency=null;
		String regCostCurrency=null;
		String feeCostCurrency=null;
		
		String appTotCostCurrency=null;
		String regTotCostCurrency=null;
		String feeTotCostCurrency=null;

		java.util.ResourceBundle serBundle 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");
	    Locale localcurrency = new Locale(serBundle.getString("language"), serBundle.getString("code"));
	    /*if(checkoption.equalsIgnoreCase("datewise"))
	    	feesCollectionList	=	(ArrayList)applicationQuery.getAllFeesReport(request.getParameter("sessionid"),request.getParameter("boardid"),instituteid,datewisedate,datewisedate);
	    else*/  if(checkoption.equalsIgnoreCase("today"))
	    	feesCollectionList	=	(ArrayList)applicationQuery.getAllFeesReport(request.getParameter("sessionid"),request.getParameter("boardid"),instituteid,todaydate,todaydate);
	    else
		    feesCollectionList	=	(ArrayList)applicationQuery.getAllFeesReport(request.getParameter("sessionid"),request.getParameter("boardid"),instituteid,fromdate,todate);

       %>

<form name="Schedule_Form" action="" method="post">

		<table  border=0  width=640 >
		<tr height=50px><td align=left>
		<%@ include file="../include/reportprintheader.jsp"%>
		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
		<tr><td width="35%" valign=top align=center>Standard Wise Financial Report
		</td></tr>
		<tr><td>
		<br>
		<table  border=0 summary="Department List" width="100%">
   
<tr><td><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%"><%=bundle.getString("label.applicationreport.AcademicYear")%>  </td><td>:</td><td class=tablelight ><%=yearofsession %></td>
	<td class=tablebold><%=bundle.getString("label.applicationreport.Board")%> </td><td>:</td><td   class=tablelight><%=boardName %></td>
</tr>
	<% 
	if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R")){
		 if(checkoption.equalsIgnoreCase("today"))
				out.print("<tr><td class=tablebold width='25%'> Today  </td><td>:</td><td class=tablelight >"+date_str.substring(0,11)+"</td></tr>");
			 else
			 {
				out.print("<tr><td class=tablebold width='25%' > From Date </td><td> :</td><td class=tablelight colspan=4>"+request.getParameter("appFromdate")+"</td></tr>");
				out.print("<tr><td class=tablebold width='25%'> To Date  </td><td>:</td><td class=tablelight  colspan=4>"+request.getParameter("appTodate")+"</td></tr>");
			 }
				out.print("<tr><td class=tablebold width='25%'>"+bundle.getString("label.applicationreport.ArchivalDetails")+"</td><td>:</td><td class=tablelight >"+bundle.getString("label.applicationreport.message")+"</td></tr>");
	}
	else{
		 if(checkoption.equalsIgnoreCase("today"))
			out.print("<tr><td class=tablebold width='25%'> Today  </td><td>:</td><td class=tablelight >"+date_str.substring(0,11)+"</td></tr>");
		 else
		 {
			out.print("<tr><td class=tablebold width='25%' > From Date </td><td> :</td><td class=tablelight colspan=4>"+request.getParameter("appFromdate")+"</td></tr>");
			out.print("<tr><td class=tablebold width='25%'> To Date  </td><td>:</td><td class=tablelight  colspan=4>"+request.getParameter("appTodate")+"</td></tr>");
		 }
		 
	}
	%>	


</table>
</td><td></td></tr>
</table>
<br><br>
<table id=rounded-corner1 bordercolor=grey width="100%" border =1 cellpadding=3 cellspacing=0>
    	<tr class=tableheading>
        	<th scope="col" class="rounded-company" width="1%"><%=bundle.getString("label.applicationreport.SL.No")%></th>
            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.applicationreport.StandardName")%></th>
            <th scope="col" class="rounded" width="23%"><%=bundle.getString("label.applicationissue.title")%></th>
            <th scope="col" class="rounded" width="23%"><%=bundle.getString("label.schedule.admission")%></th>
            <th scope="col" class="rounded-q4" width="23%"><%=bundle.getString("label.schedule.feescollection")%></th>                                   
        </tr>
<% 
int datacount=0;
		if(feesCollectionList.size()!=0)
		{
			ArrayList standardList 	= new ArrayList();
			int count 				= 0;
			float applicationTotCost 	= 0f;
			float applicationCost	 	= 0f;
			float admissionTotCost 	= 0f;
			float admissionCost	 	= 0f;
			float feeCollectionTotCost= 0f;
			float feeCollectionCost	= 0f;				
			String appCost 			= "";
			String regCost 			= "";
			String feeCost 			= "";
			String standardName		= "";
			String groupName 		="";
			
			for(int i=0;i<feesCollectionList.size();i++)
			{

				HashMap map					=	(HashMap)feesCollectionList.get(i);
				standardName				=	(String)map.get("standardname");
				groupName					=	(String)map.get("groupname"); 
				appCost 					= 	(String)map.get("appCost");
				regCost						=	(String)map.get("regCost");
				feeCost 					=	(String)map.get("feeCost");
				
				if(!groupName.equals("NoGroup"))
				{												
					standardName = standardName+" - "+groupName; 
				}
			
				if(appCost==null)
					appCost = "0";
				if(regCost==null)
					regCost = "0";
				if(feeCost==null)
					feeCost = "0";				
				//applicationCount = Integer.parseInt(appCount);
				 //applicationTotCount +=applicationCount;

				applicationCost = Float.parseFloat(appCost);
				applicationTotCost +=applicationCost;

				admissionCost = Float.parseFloat(regCost);
				admissionTotCost +=admissionCost;
					 
				feeCollectionCost = Float.parseFloat(feeCost);
				feeCollectionTotCost +=feeCollectionCost;
				
			    //Long appCostObj 				= Long.valueOf(appCost);
			    Double appCostObj = Double.valueOf(appCost);
				NumberFormat appCostObjFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
				appCostCurrency 				= appCostObjFormat.format(appCostObj);

			    //Long regCostObj 				= Long.valueOf(regCost); 
			    Double regCostObj = Double.valueOf(regCost);
				NumberFormat regCostObjFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
				regCostCurrency 				= appCostObjFormat.format(regCostObj);
				
			    //Long feeCostObj 				= Long.valueOf(feeCost);
			    Double feeCostObj = Double.valueOf(feeCost);
				NumberFormat feeCostObjFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
				feeCostCurrency 				= feeCostObjFormat.format(feeCostObj);
				
				out.print("<tr class='tablelight' ><td>"+(i+1)+"</td><td>"+standardName+"</td><td  align=right>"+appCostCurrency+"</td><td  align=right>"+regCostCurrency+"</td><td  align=right>"+feeCostCurrency+"</td>");
				datacount++;
			}
			//Long appTotCostObj 					= Long.valueOf(applicationTotCost);
			Double appTotCostObj = Double.valueOf(applicationTotCost);
			NumberFormat appTotCostObjFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
			appTotCostCurrency 					= appTotCostObjFormat.format(appTotCostObj);
			
			//Long regTotCostObj 					= Long.valueOf(admissionTotCost);
			Double regTotCostObj = Double.valueOf(admissionTotCost);
			NumberFormat regTotCostObjFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
			regTotCostCurrency 					= appTotCostObjFormat.format(regTotCostObj);

			//Long feeTotCostObj 					= Long.valueOf(feeCollectionTotCost);
			Double feeTotCostObj = Double.valueOf(feeCollectionTotCost);
			NumberFormat feeTotCostObjFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
			feeTotCostCurrency 					= feeTotCostObjFormat.format(feeTotCostObj);
			
			out.print("<tr><td class=tablebold colspan=2 align=right>"+bundle.getString("label.applicationreport.Total")+"</td><td class=tablebold  align=right>"+appTotCostCurrency+"</td><td class=tablebold align=right>"+regTotCostCurrency+"</td><td class=tablebold  align=right>"+feeTotCostCurrency+"</td></tr>");
		}
		else
		{			
			out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");	
		}
	%>
</table>
</td></tr>
		<tr align=center><td>&nbsp;
		</td></tr>
		<tr align=center><td>
		<% 
		//out.print("datacount-->"+datacount);
		if(datacount>0){
		%>	
			<input type=button  name=printbutt id=printbutt  onclick='printfun()'  value=Print >
		<%}%>
		<input type=button name=backbutt id=backbutt onclick='goBack()' value=Close >
		
		</td></tr>
		</table>
		</form>		
</body>

</html>