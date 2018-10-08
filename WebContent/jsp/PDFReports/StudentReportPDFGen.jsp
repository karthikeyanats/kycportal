<%@
page import="
java.io.*,
java.util.*,
com.lowagie.text.pdf.*,
com.lowagie.text.*"
%>
<script type="text/javascript">
function openPDF()
{
window.open("../../OpenDocument?r1=storagepath&r2=PDFReports/Student List for "+document.StudentReport_Form.req_sessionname.value+"--"+document.StudentReport_Form.req_boardname.value+".pdf")
}
</script>
<body onLoad=openPDF()>
<form name="StudentReport_Form" action="" method="post">
<%

//response.setContentType("application/pdf");

com.iGrandee.Application.RegistrationProcess  applicationQuery = new com.iGrandee.Application.RegistrationProcess();
com.iGrandee.PDFReport.StudentReportPDF  studentReportPDF = new com.iGrandee.PDFReport.StudentReportPDF();
ArrayList studentList = null;
//applicantList = applicationQuery.loadApplicantList("1","1","1","A");
studentList = applicationQuery.displayStudentListforPdf(request.getParameter("req_sessionid"),request.getParameter("req_boardid"));

//String sessionname = (String)session.getValue("sessionname");
String req_sessionname = request.getParameter("req_sessionname");
String req_boardname = request.getParameter("req_boardname");
//String institutelogo 	= (String)session.getValue("institutelogo");
//String institutename 	= (String)session.getValue("institutename");
String instituteid 	= (String)session.getValue("instituteid");
//pdfGenQuery.generatePdf(studentList,sessionname,institutelogo,institutename);
if(studentList.size()>0){
	studentReportPDF.generatePdf(studentList,req_sessionname,req_boardname,instituteid);
	out.print("<script>openPDF()</script>");
	out.print("<script>alert('PDF Generated Successfully')</script>");
	out.print("<script>history.back(-1)</script>");
	
}
else{
	out.print("<script>alert('No Data to Generate PDF')</script>");
	out.print("<script>history.back(-1)</script>");
}
//out.print("<script>window.open('../../OpenDocument?r1=storagepath&r2=PDFReports/Student List for "+req_sessionname+"--"+req_boardname+".pdf')</script>");
//System.out.print(applicantList);

%>
<input type='hidden' name='req_sessionname' value='<%=request.getParameter("req_sessionname") %>'>
<input type='hidden' name='req_boardname' value='<%=request.getParameter("req_boardname") %>'>
</form>
</body>