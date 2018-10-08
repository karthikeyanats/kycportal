<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Financial Report View  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">
	
	function backfun()
	{
	document.Amount_Form.action="./AmountCollection.jsp";
	document.Amount_Form.submit();
	}
	
	function printfun()
	{
	window.open("./AmountCollectionPrint.jsp?req_sessionname="+document.Amount_Form.req_sessionname.value+"&req_sessionid="+document.Amount_Form.req_sessionid.value+"&appFrom="+document.Amount_Form.appFrom.value+"&appTo="+document.Amount_Form.appTo.value+"&req_sessionstatus="+document.Amount_Form.req_sessionstatus.value+"&req_chkBoxId="+document.Amount_Form.req_chkBoxId.value+"&req_process="+document.Amount_Form.process.value+"&req_month="+document.Amount_Form.req_month.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
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

	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>


    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.reports.reportsfinanicialreportsview")%></h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
	<%@ page import="com.iGrandee.Common.DateTime" %>
	
<%@ page language="java" import="com.iGrandee.Report.Reports,com.iGrandee.Common.DateTime,java.text.NumberFormat,java.util.Locale"%>
<%
		try
		{
		Reports reportQuery			= new Reports();
		HashMap	hashmap				= null;
		HashMap	hashmap1			= null;
		ArrayList 	studentList		=null;
		ArrayList 	collectionList		=null;
		DateTime dateobj=new DateTime();
		String sessionid			= request.getParameter("req_sessionid");
		String sessionname			= request.getParameter("req_sessionname");
		String sessionstatus		= request.getParameter("req_sessionstatus");
		
		String fromdate				= request.getParameter("hiddenfromdate");
		String todate				= request.getParameter("hiddentodate");
		//String forMonth="";
		//String convMonthPick = request.getParameter("monthdate")+"";
		//out.println("convMonthPick"+convMonthPick);
		int totalmonth=0;
		String process	= request.getParameter("amountradio");
		String sessionuserid		= (String)session.getValue("userid");
		String instituteid			= (String)session.getValue("instituteid");
		String today				= DateTime.showTime("calendar");
		String[] chkBoxId=null;
		String collectFrom = "";
		if(sessionid != null && fromdate!= null && todate!= null) {
 			
			//applicationCountList	=	(ArrayList)applicationQuery.getReport(request.getParameter("req_sessionid"),request.getParameter("req_boardid"),instituteid,"Application");
			collectionList = reportQuery.getAmountCollection(request.getParameter("req_sessionid"),request.getParameter("hiddenfromdate"),request.getParameter("hiddentodate"));
			//out.print("ID"+request.getParameter("req_sessionid"));
			//out.print("NAME"+request.getParameter("req_sessionname"));
			//out.print("FROM"+request.getParameter("hiddenfromdate"));
			//out.print("TO"+request.getParameter("hiddentodate"));
			//out.print("CHK"+request.getParameterValues("amountcheck"));
			//out.print("RDO"+request.getParameter("amountradio"));
//out.print("collectionList-->"+collectionList);
			
			chkBoxId= request.getParameterValues("amountcheck");
			
			//out.print("CHKLEN"+chkBoxId.length);
			

			//studentList			= attencequery.loadstudent(standardscheduleid,sessionid,sectionscheduleid,instituteid);
		}
			
%>

<form name="Amount_Form" action="" method="post">
		<input type=hidden name=req_sessionid value="<%=sessionid%>">

		<input type=hidden name=process value="<%=process%>">
		
		<input type="hidden" name="req_sessionname" value='<%=sessionname%>'>
		<input type="hidden" name="req_sessionstatus" value="<%=sessionstatus%>">
		
		<input type="hidden" name="appFrom" value='<%=fromdate%>'>
		<input type="hidden" name="appTo" value='<%=todate%>'>

		
		<table width='90%' id=rounded-corner align='center' border='0' >
		 <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
		        	<th scope="col" class="rounded-q4" width="1%"></th>
		        </tr>
		    </thead>

		<tfoot>
			<tr>
				<td class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tr>
			<td colspan='2'>
				<table width='100%' border='0' >
					<tr>
						<td width='15%' class='tablebold'><%=bundle.getString("label.schedule.academicyear")%> :</td>
						<td colspan=7 class='tablelight' width='40%'>
						<%=sessionname%>
						</td>
					</tr>
					<tr>
					<%
					if(process.equals("today"))
					{%>
					<td class='tablebold'>
					<%=bundle.getString("label.schedule.todaydate")%> :
					</td>
					<td colspan=8>
					<%=request.getParameter("hiddenfromdate")%>
					</td>
		
						<%}
					else if(process.equals("fromtodate"))
					{%>
					<td class='tablebold'>
					<%=bundle.getString("label.schedule.fromdate")%> :
					</td>
					<td>
					<%=request.getParameter("hiddenfromdate")%>
					</td>
					<td ></td>
					<td class='tablebold'>
					<%=bundle.getString("label.schedule.todate")%> :
					</td>
					<td>
					<%=request.getParameter("hiddentodate")%>
					</td>
					<td colspan=2></td>
						<%}
					else if(process.equals("month"))
					{%>
						<td width='20%' class='tablebold' ><%=bundle.getString("label.schedule.month")%></td>
						<td class='tablelight' colspan=5>
							<%=request.getParameter("hiddenmonth")%>
						</td>
						<td width='1%' class='tablebold'></td>
						<td></td>
						
					<%}%>
					</tr>
				</table>
			</td>
		</tr>
		</table>
		<br>

<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="1%"><%=bundle.getString("label.applicationreport.SL.No")%></th>
            <th scope="col" class="rounded" width="45%"><%=bundle.getString("label.schedule.amountcollectedfrom")%></th>
            <th scope="col" class="rounded-q4" width="40%"><%=bundle.getString("label.applicationreport.AmountCollected")%></th>                
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>


<% 

		int totalAmount = 0;
		String amount      = null;
		String appTotCostCurrency = null;
		String totCostCurrency = null;
		String checkBoxParamet = "";
		
		ResourceBundle serBundle 	= 	ResourceBundle.getBundle("resources.serversetup");
	    Locale localcurrency = new Locale(serBundle.getString("language"), serBundle.getString("code"));

		 if(chkBoxId != null && chkBoxId.length>0)
		 {
				for(int j=0;j<chkBoxId.length;j++){
					//String[] var=null;
					//regId=chkBoxId[j].split("@");
					//out.print(chkBoxId[j]);
					if(chkBoxId[j].equals("AI"))
						collectFrom = "Application Issue";
					if(chkBoxId[j].equals("AD"))
						collectFrom = "Admission";
					if(chkBoxId[j].equals("FC"))
						collectFrom = "Fees Collection";
					
					checkBoxParamet = checkBoxParamet+chkBoxId[j]+"@";
					
				   	 if(collectionList!=null && collectionList.size()>0)
						{
						 	HashMap collectionListMap=(HashMap)collectionList.get(0);
							amount      = (String)collectionListMap.get(chkBoxId[j]);
							
							if(amount==null || amount.equals("null")){
								amount = "0";
							}
							else
							{
								totalAmount += Integer.parseInt(amount);
							}
						}
				   	 
					    Long appTotCostObj 					= Long.valueOf(amount); 
						NumberFormat appTotCostObjFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
						appTotCostCurrency 					= appTotCostObjFormat.format(appTotCostObj);

						
					out.print("<tr><td>"+(j+1)+"</td><td>"+collectFrom+"</td><td>"+appTotCostCurrency+"</td></tr>");
					
				}
				
			    Long totCostObj 					= Long.valueOf(totalAmount+""); 
				NumberFormat totCostObjFormat 		= NumberFormat.getCurrencyInstance(localcurrency);
				totCostCurrency 					= totCostObjFormat.format(totCostObj);

				out.print("<tr><td colspan=3></td></tr><tr><td class=tablebold colspan=1></td><td class=tablebold colspan=1>"+bundle.getString("label.applicationreport.Total")+"</td><td style='background-color:lightblue'>"+totCostCurrency+"</td></tr>");
					
		//studentList			= attencequery.loadstudent(standardscheduleid,sessionid,sectionscheduleid,instituteid);
		}
	%>
				<input type="hidden" name="req_chkBoxId" value=<%=checkBoxParamet%>>
			<input type="hidden" name="req_month" value="<%=request.getParameter("hiddenmonth")%>">
	<%	 
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	%>
	
			
</table>
</table>
</td><td></td></tr>
</table>  
<br>
							
							<a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
							<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.print")%></strong><span class="bt_green_r"></span></a>
		
</form>		
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>