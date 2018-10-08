<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-EN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - PDF Report Index View | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<link rel=stylesheet href="<%=request.getContextPath() %>/css/jquerystyle.css">
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">

function goBack()
{
		document.pdfGenForm.action="PDFReportIndex.jsp";
		document.pdfGenForm.submit();
}
function stdSchd()
{
		document.pdfGenForm.action="./StandardSchedule.jsp";
		document.pdfGenForm.submit(); 
}
function studList()
{
		document.pdfGenForm.action="./StudentReportPDF.jsp";
		document.pdfGenForm.submit();
}
function staffAllot()
{
		document.pdfGenForm.action="./SubjectAllotment.jsp";
		document.pdfGenForm.submit();
}

function timeTable()
{
		document.pdfGenForm.action="./ScheduleSelect.jsp";
		document.pdfGenForm.submit();
}

function feeStruct()
{
		document.pdfGenForm.action="./FeesStructureSelect.jsp";
		document.pdfGenForm.submit();
}

function feeReport()
{
		document.pdfGenForm.action="./FeesReportPDF.jsp";
		document.pdfGenForm.submit();
}

function examName()
{
		document.pdfGenForm.action="./ExamnameView.jsp";
		document.pdfGenForm.submit();
}

function examSchd()
{
		document.pdfGenForm.action="./ExamView.jsp";
		document.pdfGenForm.submit();
}

function examResult()
{
		document.pdfGenForm.action="./ExamReportPDF.jsp";
		document.pdfGenForm.submit();
}

function schoolSchd()
{
		document.pdfGenForm.action="./SchoolCalendarView.jsp";
		document.pdfGenForm.submit();
}

function doCompletion(pdfGenJsp)
	{

		var url = "";
		var url = pdfGenJsp+"?req_sessionid="+document.pdfGenForm.req_sessionid.value+"&req_sessionname="+document.pdfGenForm.req_sessionname.value+"&req_boardid="+document.pdfGenForm.req_boardid.value+"&req_boardname="+document.pdfGenForm.req_boardname.value;
		
		var req =initRequest();
		req.onreadystatechange = function()
		{
			if (req.readyState == 4)
			{
				{
					parseMessages1(req.responseXML,"download");
				}
			}else if(req.readyState ==500)
			{
				alert("Problem in download,Please try again");
			}
		};
	
		req.open("GET", url, true);
		req.send(null);
	
	}
	function parseMessages1(parseXML,flag)
	{
		//alert(parseXML.getElementsByTagName("var"))
			if(flag=="download")
			{
				var rootObj=parseXML.getElementsByTagName("duplicate");
				var cNode_1=rootObj[0].childNodes.length;
				for(var i=0;i<parseInt(cNode_1);i++)
				{
					var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
					if(temp=="NoPath")
					{
					alert("Storage Path was not Found");
					}
					else if(temp=="true")
					{
						zipathvalue=rootObj[0].childNodes.item(i).childNodes.item(1).firstChild.nodeValue;
						document.getElementById("fileopener").src=zipathvalue+"&r3=download";
	
					}
					else
					{
						alert("No Data to generate PDF");
					}      
				}
			}
	}
	

</script>

</head>
<body>
<form name="pdfGenForm" action="" method="post">
<input type=hidden name=req_sessionid value="<%=request.getParameter("req_sessionid")%>">
<input type=hidden name=req_sessionname value="<%=request.getParameter("req_sessionname") %>">
<input type=hidden name=req_boardid value="<%=request.getParameter("req_boardid")%>">
<input type=hidden name=req_boardname value="<%=request.getParameter("req_boardname") %>">

<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">

	<%
		ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.reports.pdfreports")%></h2>
   <%@ page import="java.util.ArrayList,java.util.ResourceBundle,java.util.HashMap,com.iGrandee.Application.ApplicationQuery"%>

  
	<%
    try
    {	
    com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();	
	com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();
		ArrayList valueList = null;
	
	    String instituteid = null;
	    //ArrayList BoardList = null;

	 		
			//String temp=applicationQuery.receiptNo();

	    	  instituteid = (String)session.getValue("instituteid");
	    	  //ArrayList yearList = applicationQuery.listYearofSession(instituteid);
	    	 //BoardList = standardQuery.listBoard(instituteid);
	    
		//out.println("temp-->"+temp);
	%>

	<table id="rounded-corner" border=0 summary="Department List" width="100%">
	    <thead>
	    	<tr>
	            <th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
	            <th scope="col" class="rounded-q4" width="10%"></th>        
	        </tr>
	    </thead>
	    
	        <tfoot>
	    	<tr>
	        	<td class="rounded-foot-left"><em></em></td>
	        	<td class="rounded-foot-right">&nbsp;</td>
	       </tr>
	    </tfoot>
	    
	    <tr>
	    	<td>
	    		<table border=0 align=center id="rounded-corner1" width="100%">
					<tr>
						<td class=tablebold width="25%"><%=bundle.getString("label.schedule.academicyear")%></td><td class=tablelight >
						<td class=tablebold>:</td><td><%=request.getParameter("req_sessionname") %></td>
						<td class=tablebold><%=bundle.getString("label.schedule.board")%></td>
						<td class=tablebold>:</td>
						<td class=tablelight><%=request.getParameter("req_boardname") %></td>
					</tr>
				</table>
			</td>
			<td></td>
		</tr>
	</table>

    	<% 
	     }catch(Exception e){}
		%>   
    
    	
<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
    		<th scope="col" class="rounded-company" width="80%">Generate PDF For</th>
            <th scope="col" class="rounded-q4" width="20%">&nbsp;</th>

        </tr>
    </thead>
 <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
<tr><td colspan=2 class=tablebold align=center>	
<table >
<tr><td></td><td class='tablebold' align=left><%=bundle.getString("label.schedule.studentlist")%></td><td class='tablelight'><a href='javascript:void(0)' onclick='doCompletion("StudentReportPDFhide.jsp")'><%=bundle.getString("label.schedule.generatepdf")%></a></td></tr>
<tr><td></td><td class='tablebold' align=left><%=bundle.getString("label.schedule.feeslist")%></td><td class='tablelight'><a href='javascript:void(0)' onclick='doCompletion("FeesReportPDFhide.jsp")'><%=bundle.getString("label.schedule.generatepdf")%></a></td></tr>
<tr><td></td><td class='tablebold' align=left><%=bundle.getString("label.schedule.examlistdetails")%></td><td class='tablelight'><a href='javascript:void(0)' onclick='doCompletion("ExamDetailspdf.jsp")'><%=bundle.getString("label.schedule.generatepdf")%></a></td></tr>
<tr><td></td><td class='tablebold' align=left><%=bundle.getString("label.schedule.standardwiseexamlist")%></td><td class='tablelight'><a href='javascript:void(0)' onclick='doCompletion("ExamDetailsStdwisepdf.jsp")'><%=bundle.getString("label.schedule.generatepdf")%></a></td></tr>
<tr><td></td><td class='tablebold' align=left><%=bundle.getString("label.schedule.marklist")%></td><td class='tablelight'><a href='javascript:void(0)' onclick='doCompletion("ExamReportPDFhide.jsp")'><%=bundle.getString("label.schedule.generatepdf")%></a></td></tr>
<tr><td></td><td class='tablebold' align=left><%=bundle.getString("label.schedule.subjectallotment")%></td><td class='tablelight'><a href='javascript:void(0)' onclick='doCompletion("pdfcreation.jsp")'><%=bundle.getString("label.schedule.generatepdf")%></a></td></tr>
<tr><td></td><td class='tablebold' align=left><%=bundle.getString("label.schedule.attendance")%></td><td class='tablelight'><a href='javascript:void(0)' onclick='doCompletion("pdfcreationforattendance.jsp")'><%=bundle.getString("label.schedule.generatepdf")%></a></td></tr>
<tr><td></td><td class='tablebold' align=left><%=bundle.getString("label.schedule.schoolcalendar")%></td><td class='tablelight'><a href='javascript:void(0)' onclick='doCompletion("Calenderpdf.jsp")'><%=bundle.getString("label.schedule.generatepdf")%></a></td></tr>

</table>
</td></tr>
</table>
	
	<iframe width="0" height="0" id="fileopener" style="display:none">
	  <p>Your browser does not support iframes.</p>
	</iframe>
		
<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>	

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>


</form>


</body>

</html>
