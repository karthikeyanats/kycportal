<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.SchoolCalender.SchoolCalenderEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.SchoolCalender.SchoolCalenderBean" />
	<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime"%>
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - School Calender | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">
function createpdf()
{
document.ApplicantSearch.action= "Calenderpdf.jsp";
document.ApplicantSearch.submit();
}
function loadsession()
{
if(check_ForParticularElements(document.ApplicantSearch.sessionname,"select"))
	{
 document.ApplicantSearch.req_sessionname.value  =document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text;
	document.ApplicantSearch.submit();
	}
}
function changeBoard()
	{
	if(check_ForParticularElements(document.ApplicantSearch.sessionname,"select",document.ApplicantSearch.reg_board,"select"))
	{
	document.ApplicantSearch.reg_boardnname.value=document.ApplicantSearch.reg_board.options[document.ApplicantSearch.reg_board.selectedIndex].text;
	document.ApplicantSearch.submit();     
	
	}
	}
function doCompletion()
{
	var url = "";

	 var url = "Calenderpdf.jsp?req_sessionid="+document.ApplicantSearch.sessionname.value+"&req_sessionname="+document.ApplicantSearch.sessionname.options[document.ApplicantSearch.sessionname.options.selectedIndex].text+"&req_boardid="+document.ApplicantSearch.reg_board.options[document.ApplicantSearch.reg_board.selectedIndex].value+"&req_boardnname="+document.ApplicantSearch.reg_boardnname.value;
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
<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>
<%@ page import="java.io.*,java.util.*"%>

<%
String reg_board 	= null;
String reg_boardnname 	= null;
String req_sessionstatus="";

String sessionname=request.getParameter("sessionname")+"";
String req_sessionname=request.getParameter("req_sessionname")+"";
reg_board=request.getParameter("reg_board")+"";
reg_boardnname=request.getParameter("reg_boardnname")+"";

req_sessionstatus=  request.getParameter("req_sessionstatus");
String instituteid = (String)session.getValue("instituteid");
instituteBean.setSessionid(sessionname);
instituteBean.setboardid(reg_board);
instituteBean.setinstituteid(instituteid);
ArrayList eventList = query_object.eventListRK(instituteBean);

%>
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

    <h2>General / School Calendar</h2>
<form name="ApplicantSearch" action="" method="post">
 
<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	cellpadding=0>
	<tr valign='top'>
<td>
<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr >
				<TH scope="col" class="rounded-company"></TH>
					<th scope="col" class="rounded" width="100%" COLSPAN=4>Select Academic Year</th>

					<th scope="col" class="rounded-q4" width="10"></th>
					

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=5 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
    <tr>
    <TD></TD>
<td class='tablebold'> Academic Year</td>  
<td>
    <select name="sessionname" id="year" onchange="loadsession(this)">
    <option value="0" class="tablelight">--Select Academic Session--</option>
    <%
   
	ArrayList yearList = query_object.listYearofSessionRK(instituteid);


											for(int s=0;s<yearList.size();s++)
											{
												HashMap map=(HashMap)yearList.get(s);
												String sessionid=(String)map.get("sessionid");
												String yearofsession=(String)map.get("sessionname");
												String session_status=(String)map.get("sessionstatus");
												if(!sessionname.equals("null") && sessionname.equals(sessionid))
												{
												out.println("<option value='"+sessionid+"' sessionstatus='"+session_status+"' selected=true class='tablelight'>"+yearofsession+"</option>");
											}
												else
												{
													out.println("<option value='"+sessionid+"' sessionstatus='"+session_status+"' class='tablelight'>"+yearofsession+"</option>");

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
com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
ExamAllotmentQuery exallot	= new ExamAllotmentQuery(); 

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
</td><td></td>  
    </tr>
  	 </table>
	 </td>
	 </tr>
	</table>
	
	 
	
     
        <input type=hidden name=req_sessionid value="">
<input type=hidden name=req_sessionname value="<%=req_sessionname %>">  
<input type=hidden name=req_sessionstatus value="">  
		<input type="hidden" name="reg_boardnname" value="<%=reg_boardnname %>">

  <iframe src ="" width="0" height="0" id="fileopener">
  <p>Your browser does not support iframes.</p>
</iframe>      
    
    </thead>
</table>
    
 
 //<% 
	//if(eventList!=null && eventList.size()>0)
						//	{	%>
      <a href="#" class="bt_green" onclick="doCompletion()" ><span class="bt_green_lft"></span><strong>Genereate pdf </strong><span class="bt_green_r"></span></a>
							
	//<%
					//		}
//	else
//{

//}
	//%>
     </td>
     </tr>
     </TABLE>
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>