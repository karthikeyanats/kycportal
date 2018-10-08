<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
	ResourceBundle bundle=ResourceBundle.getBundle("resources.ApplicationResources");
%>

<title><%=bundle.getString("label.product.name") %> - Question View From Excel | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
	
	function submitQuestion(){
	
		document.question_form.action		= "QuestionSubmitExcel.jsp";
		document.question_form.submit();
	}	
	
	function backFun(){
	
		document.question_form.action		= "QuestionEntryExcel.jsp";
		document.question_form.submit();

	}
	
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/examheader.jsp" %>

    <div class="center_content">

    <div class="left_content">

    </div>

    <div class="right_content">
	<%@ page language="java" import="java.io.FileInputStream,java.io.InputStream,java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,com.iGrandee.ExamManagement.QuestionUploadExcel,com.iGrandee.ExamManagement.ExcelParser"%>
	<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
	<%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
	<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
	<%@ page import="org.apache.poi.hssf.usermodel.HSSFRow"%>

    <h2>Exam Management System / Question Entry</h2>
    <%
    	DateTime datetime			= new DateTime();
    	QuestionUploadExcel upload	= new QuestionUploadExcel(request);
    	ResourceBundle rbundle		= ResourceBundle.getBundle("resources.serversetup");
    	upload.startProcess();
    	HashMap	hashmap				= null;
    	String storagepath			= rbundle.getString("storagepath");
    	String today				= datetime.showTime("calendar");
    	String questiontype			= upload.getParameter("questiontype");
    	storagepath					+= upload.getFileNames()[0];
    %>
    
    <form name="question_form" action="" method="post"  enctype="multipart/form-data">
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="99%">Question Entry Details</th>
		            <th scope="col" class="rounded-q4" 		width="1%"></th>
		        </tr>
		    </thead>
		    <tr>
		    	<td colspan='2'>						
						
					<table width='100%' align='center' border='0' cellpadding='5'>
						<tr>
							<td width='15%' class='tablebold'>Board - Medium Name</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
								<%=upload.getParameter("boardname")%>
							</td>
						</tr>			
						<tr>
							<td width='15%' class='tablebold'>Standard Name</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
							<%=upload.getParameter("standardname")%>
							</td>
						</tr>
						<tr>
							<td width='15%' class='tablebold'>Subject Name - Subject Code</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=upload.getParameter("subjectname")%>
							</td>
						</tr>
						<tr>
							<td width='15%' class='tablebold'>Lesson Name</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=upload.getParameter("lessonname")%>
							</td>
						</tr>		
						<tr>
							<td width='15%' class='tablebold'>Exam Type</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=upload.getParameter("examtypename")%>
							</td>
						</tr>
						<tr>
							<td width='15%' class='tablebold'>Question Type</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
							<%=upload.getParameter("questiontype")%>
							</td>
							<td width='20%' class='tablebold'>Difficulty Factor</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
							<%=upload.getParameter("difficultyfactor")%>
							</td>

						</tr>
						<tr>
							<td width='15%' class='tablebold'>Life Time</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
							From &nbsp;&nbsp;<%=upload.getParameter("startdate")%><input type='hidden' name='startdate' value='<%=upload.getParameter("startdate")%>' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To &nbsp;&nbsp;&nbsp;<%=upload.getParameter("enddate")%><input  type='hidden' name='enddate' value='<%=upload.getParameter("enddate")%>' >
							</td>
							<td width='20%' class='tablebold'>No. of Occurrence</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' width='20%'>
								<%=upload.getParameter("occurence")%>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
		
		<table id="rounded-corner" cellspacing=0  class=tablelight width="100%">
			  <thead>
			  	<tr>
					<th scope="col"  class="rounded-company" width='8%'>S.No.</th>
					<th scope="col"  class="rounded" width='37%'>Question</th>
					<th scope="col"  class="rounded" width='25%'>Answer</th>
					<th scope="col"  class="rounded" width='15%'>Correct Answer</th>
					<th scope="col"  class="rounded-q4" width='15%'>Mark</th>
				</tr>
			  </thead>
			<%
			
			 String question 			= null;
			 String answer   			= null;
			 String totalans 			= null;
			 String A       			= null;
			 String B        			= null;
			 String C        			= null;
			 String D        			= null;
			 String E        			= null;
			 String F        			= null;
			 String G        			= null;
			 String mark     			= null;


			 HSSFWorkbook workBook 		= ExcelParser.getWorkBook(new FileInputStream(storagepath));
			 int sheets 				= workBook.getNumberOfSheets();


			 for (int i = 0; i < sheets; i++)
			 {

				HSSFSheet sheet 	= workBook.getSheetAt(i);
				int rows 			= sheet.getPhysicalNumberOfRows();

				for(int j=0;j<rows;j++)
				{

						HSSFRow row 	= sheet.getRow(j);
						int cells 		= row.getPhysicalNumberOfCells();

						if(cells == 11)
						{
							if(j>0)
							{

								HSSFCell cell0 		= row.getCell((short)0);
								question 			= (String)ExcelParser.getValueOfCell(cell0,"CHAR");

								HSSFCell cell1 		= row.getCell((short)1);
								A		 			= (String)ExcelParser.getValueOfCell(cell1,"CHAR");

								HSSFCell cell2 		= row.getCell((short)2);
								B 					= (String)ExcelParser.getValueOfCell(cell2,"CHAR");

								HSSFCell cell3 		= row.getCell((short)3);
								C 					= (String)ExcelParser.getValueOfCell(cell3,"CHAR");

								HSSFCell cell4 		= row.getCell((short)4);
								D 					= (String)ExcelParser.getValueOfCell(cell4,"CHAR");

								HSSFCell cell5 		= row.getCell((short)5);
								E 					= (String)ExcelParser.getValueOfCell(cell5,"CHAR");

								HSSFCell cell6 		= row.getCell((short)6);
								F 					= (String)ExcelParser.getValueOfCell(cell6,"CHAR");

								HSSFCell cell7 		= row.getCell((short)7);
								G 					= (String)ExcelParser.getValueOfCell(cell7,"CHAR");

								HSSFCell cell8 		= row.getCell((short)8);
								mark 				= (String)ExcelParser.getValueOfCell(cell8,"CHAR");

								HSSFCell cell9 		= row.getCell((short)9);
								answer 				= (String)ExcelParser.getValueOfCell(cell9,"CHAR");

								HSSFCell cell10 	= row.getCell((short)10);
								totalans 			= (String)ExcelParser.getValueOfCell(cell10,"CHAR");

								try{
									int countanswer = Integer.parseInt(totalans);
									out.print("<tr class=tablelight>");

										out.print("<td valign='top'>"+j+".</td>");
										out.print("<td valign='top'><input type='hidden' name='questions' value='"+question+"'>"+question+"</td>");
										out.print("<td valign='top'><input type='hidden' name='countanswer' value='"+totalans+"'>");

											out.print("<table cellspacing='0' cellpadding='5'>");
												for(int y=0;y<countanswer;y++)
												{
													if(y==0)
														out.print("<tr><td><input type='hidden' name='answers' value='"+A+"'>A."+A+"</td></tr>");
													else if(y==1)
														out.print("<tr><td><input type='hidden' name='answers' value='"+B+"'>B."+B+"</td></tr>");
													else if(y==2)
														out.print("<tr><td><input type='hidden' name='answers' value='"+C+"'>C."+C+"</td></tr>");
													else if(y==3)
														out.print("<tr><td><input type='hidden' name='answers' value='"+D+"'>D."+D+"</td></tr>");
													else if(y==4)
														out.print("<tr><td><input type='hidden' name='answers' value='"+E+"'>E."+E+"</td></tr>");
													else if(y==5)
														out.print("<tr><td><input type='hidden' name='answers' value='"+F+"'>F."+F+"</td></tr>");
													else if(y==6)
														out.print("<tr><td><input type='hidden' name='answers' value='"+G+"'>G."+G+"</td></tr>");
												}
											out.print("</table>");

										out.print("</td>");
										out.print("<td valign='top'><input type='hidden' name='correctanswer' value='"+answer+"'>"+answer+"</td>");
										out.print("<td valign='top'><input type='hidden' name='mark' value='"+mark+"'><input type='hidden' name='filenames' value='-'><input type='hidden' name='timelimit' value='01:00'>"+mark+"</td>");

									out.print("</tr>");
								}
								catch(NumberFormatException nfe)
								{
								}
							}

						}
				  }
			}

		%>
		</table>

		<a href="#" class="bt_blue" onclick='backFun()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_green" onclick='submitQuestion()'><span class="bt_green_lft"></span><strong>Submit Question</strong><span class="bt_green_r"></span></a>
		  			
		  			
		<input type='hidden' name='examtype' 			value='<%=upload.getParameter("examtype")%>'>
		<input type='hidden' name='lessonid' 			value='<%=upload.getParameter("lesson")%>'>
		<input type='hidden' name='occurence' 			value='<%=upload.getParameter("occurence")%>'>
		<input type='hidden' name='startdate' 			value='<%=upload.getParameter("startdate")%>'>
		<input type='hidden' name='enddate' 			value='<%=upload.getParameter("enddate")%>'>
		<input type='hidden' name='difficultyfactor' 	value='<%=upload.getParameter("difficultyfactor")%>'>
		<input type='hidden' name='questiontype' 		value='<%=upload.getParameter("questiontype")%>'>		
		
		
</form>		
    
    


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>