<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Exam Detail List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
	var count	= 0; 
	function loadExam()
	{
		document.Schedule_Form.submit();
	}
	function loadexamdetails(obj)
	{
		document.Schedule_Form.examId.value = obj.getAttribute("examId");
		document.Schedule_Form.examname.value = obj.getAttribute("examname");
		document.Schedule_Form.action="./ExamScheduleView.jsp";
		document.Schedule_Form.submit();
	}
	
	function changeSession()
	{
	if(check_ForParticularElements(document.Schedule_Form.academicsession,"select"))
	{
	document.Schedule_Form.reg_sessionname.value=document.Schedule_Form.academicsession.options[document.Schedule_Form.academicsession.selectedIndex].text;
	document.Schedule_Form.submit();    

	}
	}
	function changeBoard()
	{
	if(check_ForParticularElements(document.Schedule_Form.academicsession,"select",document.Schedule_Form.reg_board,"select"))
	{
	document.Schedule_Form.reg_boardnname.value=document.Schedule_Form.reg_board.options[document.Schedule_Form.reg_board.selectedIndex].text;
	document.Schedule_Form.submit();     
	
	}
	}
	function CreatePdf()
	{
	document.Schedule_Form.action="ExamDetailspdf.jsp";
		document.Schedule_Form.submit();
	}
function doCompletion()
{
	var url = "";

	 var url = "ExamDetailspdf.jsp?req_sessionid="+document.Schedule_Form.academicsession.options[document.Schedule_Form.academicsession.selectedIndex].value+"&req_sessionname="+document.Schedule_Form.reg_sessionname.value+"&req_boardid="+document.Schedule_Form.reg_board.options[document.Schedule_Form.reg_board.selectedIndex].value+"&req_boardname="+document.Schedule_Form.reg_boardnname.value;
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
	
		if(flag=="download")
		{
			var rootObj=parseXML.getElementsByTagName("duplicate");
			var cNode_1=rootObj[0].childNodes.length;
			for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
				if(temp=="true")
				{
					zipathvalue=rootObj[0].childNodes.item(i).childNodes.item(1).firstChild.nodeValue;
					document.getElementById("fileopener").src=zipathvalue+"&r3=download";

				}      
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

    <h2>Reports / Exam Details</h2>
	<form name="Schedule_Form" action="" method="post">
    <input type=hidden name=examId />
    <input type=hidden name=examname />
    <input type=hidden name=academicname />
    	
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime"%>
<%@ page language="java"
	import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery"%>
<%

ArrayList academicList=null;
HashMap	hashmap				= null;
String academicsession 	= null;
String reg_board 	= null;

String req_subjectscheduleid="";
String reg_boardnname="";
ArrayList ExamList=null;
		com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
			ExamAllotmentQuery exallot	= new ExamAllotmentQuery(); 
		
		String instituteid = null;
		ArrayList BoardList=null;
		
		String reg_sessionname=request.getParameter("reg_sessionname");
		instituteid			= (String)session.getValue("instituteid");
		
		 academicList 		= examQuery.loadRKYear(instituteid);
		 
		 academicsession=request.getParameter("academicsession")+"";
	 reg_board=request.getParameter("reg_board")+"";
	 reg_boardnname=request.getParameter("reg_boardnname")+"";
	 
if(academicsession!=null && !academicsession.equals("null") && !academicsession.equals("") && reg_board!=null && !reg_board.equals("null") && !reg_board.equals(""))
{
			ExamList=examQuery.LoadExamnameListRK(instituteid,academicsession,reg_board); 
}

	
		
		

			
%>
<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	cellpadding=0>
	<tr valign='top'>
<td>
<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr >
					<th scope="col" class="rounded-company" width="70%" >Select Academic Year</th>
					<th scope="col" class="rounded" width="10"></th>
					<th scope="col" class="rounded" width="10"></th>
					<th scope="col" class="rounded-q4" width="10"></th>
					

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=3 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
<tr>
<td class='tablebold'> Academic Year</td>
<td>
<select name="academicsession" validate="Session" onchange="changeSession()">
<option>-Select Session-</option>
<%

if(academicList!=null && academicList.size()>0)
{  
	for(int b=0;b<academicList.size();b++)
	{
		hashmap		= (HashMap)academicList.get(b);
		String sessionname=(String)hashmap.get("sessionname");	  
		String sessionid=(String)hashmap.get("sessionid");
		if(!academicsession.equals("null")  && academicsession.equals(sessionid))
		{
		out.print("<option  value='"+sessionid+"'  selected=true>"+sessionname+"</option>");
		}
		else      
		{
		out.print("<option  value='"+sessionid+"' >"+sessionname+"</option>");
	
		}

	}
	
}
%>
</select>
</td>
<td class='tablebold'>Select Board </td>

<td>
<select name="reg_board" validate="Board" onchange="changeBoard(this)">
<option>-Select Board-</option>
<%
String boardid1="";

				ArrayList boardnameList		= exallot.LoadBoardList(instituteid);  
				HashMap boardmap=null;
					if(boardnameList != null && boardnameList.size()>0)
						{
							for(int z=0;z<boardnameList.size();z++)
								{
									boardmap		= (HashMap)boardnameList.get(z);
									String boardid = (String)boardmap.get("boardid");
									String boardname = (String)boardmap.get("boardname");
									String mediumId      = (String)boardmap.get("mediumid");
									String mediumName      = (String)boardmap.get("mediumname");
									if(!reg_board.equals("null")  && reg_board.equals(boardid))
									{
									out.print("<option value='"+boardid+"' selected>"+boardname+"-"+mediumName+" </option>");
									}
									else
									{
										out.print("<option value='"+boardid+"'>"+boardname+"-"+mediumName+"</option>");
	
									}
						}
						}
										
			%>
</select>
</td>
</tr>
</tbody>
</table>
</td>
</tr>


	
	
					   	<%
					   	
					  	try
					   	{
					   	ArrayList subjectList=null;
					      	if(ExamList!=null && ExamList.size()>0)
							{
			  		 			for (int i = 0, j = 1; i < ExamList.size(); i++) 
			  		 			{

									HashMap ExamListMap=(HashMap)ExamList.get(i);
									String examId     = (String)ExamListMap.get("examnameid");
									String examName      = (String)ExamListMap.get("examname");
									String examallotmentid= (String)ExamListMap.get("examallotmentid");
			  		 				subjectList=examQuery.LoadExamSubjectList(examId,academicsession);  
			  		 				 out.print("<br>");    
			  		 				   
									if(subjectList!=null && subjectList.size()>0)
									{
									 out.print("<tr>");
									 out.print("<td >");
									out.print("<table align='center' width='100%' border=0>");
				  		 			 out.print("<tr><td class='tablebold'>Exam Name</td><td class='tablebold'>:</td><td class='tablelight'>"+examName+"</td></tr>");
				  		 		    out.print("</table>");
				  		 		    out.print("<tr>");
								    out.print("<td >");  
									out.print("<table id='rounded-corner' width='90%' align='center' border='0' summary='Subject List' ><thead>");
									out.print("<tr>");
									out.print("<th scope='col' class='rounded-company' width='10%'>SL No.</th>");
									out.print(" <th scope='col' class='rounded' width='20%'>Standard Name </th>");
									out.print(" <th scope='col' class='rounded' width='20%'>Subject Name </th>");
									out.print(" <th scope='col' class='rounded' width='20%'>Exam Date</th>");
									out.print(" <th scope='col' class='rounded' width='10%'>Start Time</th>");
									out.print(" <th scope='col' class='rounded' width='10%'>End Time</th>");
									out.print(" <th scope='col' class='rounded-q4' width='10%'>Duration</th>");
    								out.print(" </tr>");
    								
									out.print("<tfoot>");
									out.print("<tr>");
									out.print("<td colspan='6' class='rounded-foot-left'><em></em></td>");
									out.print("<td class='rounded-foot-right'>&nbsp;</td>");
									out.print("</tr>");
									out.print("</tfoot>");
									
									out.print("<br>");
									
									out.println("<tr>");

									//int duration=0;
									String duration=null;
									  if(subjectList!=null && subjectList.size()>0)
										{ 
									 		out.println("<td >"+j+"</td>");

										  int inc = 1;
										  String standardscheduleid="";
									 	for (int i1 = 0; i1 < subjectList.size(); i1++)
									 	{
									 		
										HashMap subjectListMap=(HashMap)subjectList.get(i1);
										String groupname      = (String)subjectListMap.get("groupname")+"";
										String standardname      = (String)subjectListMap.get("standardname");
										if(!groupname.equals("null"))
										{
										standardname=standardname+"  -"+groupname;
										}
										String subjectname      = (String)subjectListMap.get("subjectname");
										String standardid      = (String)subjectListMap.get("standardscheduleid");
										String examdate      = (String)subjectListMap.get("examdate");
										String examtimein      = (String)subjectListMap.get("examtimein");
										//char timein[] =examtimein.toCharArray();
										//examtimein=timein[0]+""+timein[1]+":"+timein[2]+""+timein[3];
										String examtimeout      = (String)subjectListMap.get("examtimeout");
										String examtimeinampm      = (String)subjectListMap.get("examtimeinampm");
										String examtimeoutampm      = (String)subjectListMap.get("examtimeoutampm");
										duration      = (String)subjectListMap.get("duration");
										//char timeout[] =examtimeout.toCharArray();
										//examtimeout=timeout[0]+""+timeout[1]+":"+timeout[2]+""+timeout[3];

										if(examdate == null){
											examdate= " ";}
										if(examtimein == null){
											examtimein= " ";}
										if(examtimeout == null){
											examtimeout= " ";}
										//if(subjectListMap.get("examtimein") != null && subjectListMap.get("examtimeout")!=null)
										//duration = Integer.parseInt((String)subjectListMap.get("examtimeout"))-Integer.parseInt((String)subjectListMap.get("examtimein"));
										//String duration_temp=duration+"";
										//char duratiochar[] =duration_temp.toCharArray();
									//duration = examQuery.getHourMin(examtimein,examtimeout);

										if(!standardscheduleid.equals(standardid))
										{
									 		out.println("<td >"+standardname+"</td>");
									 		standardscheduleid=standardid;
										}
								 		else
								 		{
								 			out.print("<td></td><td></td>");
								 		}
										//duration = examQuery.getHourMin(examtimein,examtimeout);

								 		out.println("<td>"+subjectname+"</td>");
								 		out.println("<td>"+examdate+"</td>");
								 		out.println("<td>"+examtimeinampm+"</td>");
								 		out.println("<td>"+examtimeoutampm+"</td>");
								 		out.println("<td>"+duration+"</td>");
								 		/*if((duration_temp.length())>3)
								 		{
									 		out.println("<td>"+duratiochar[0]+duratiochar[1]+":"+duratiochar[2]+duratiochar[3]+"</td>");

								 		}
								 		else
								 		{
								 		out.println("<td>"+duratiochar[0]+":"+duratiochar[1]+duratiochar[2]+"</td>");
								 		}*/
								 		out.println("</tr>");
								 		inc++;

								}
								
								}
								  else
									  {
										out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
								   		//out.println("<tr><td colspan=7 align=center>Data not found</td></tr>");    	 
								   	  }
									out.println("</tr>");
									j++;
									out.print("</table>");
									}
			  		 			}
						  	 }
					      	else
					      	{
					      		out.println("<tr>");
								//out.println("<td align='center' colspan='2'>Data Not Found </td>");
								out.println("</tr>");
					      	}
					   	}
					   	catch(Exception e)
					   	{
					   		//System.out.print(e);
					   	}
						%>
		
		<iframe src ="" width="0" height="0" id="fileopener">
  <p>Your browser does not support iframes.</p>
</iframe>

	</table>
	<% 
	if(ExamList!=null && ExamList.size()>0)
							{	%>
							     <a href="#" class="bt_green" onclick='doCompletion()'><span class="bt_green_lft"></span><strong>Create Pdf</strong><span class="bt_green_r"></span></a>
							
	<%
							}
	else
{

}
	%>
	<input type="hidden" name="reg_sessionname" value="<%=reg_sessionname %>">
	
		<input type="hidden" name="reg_boardnname" value="<%=reg_boardnname %>">
	
</form>	
    </div><!-- end of right content-->
	</div>   <!--end of center content -->

   <div class="clear"></div>
   </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
</div>
</body>
</html>