<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Staff | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
function loadsession()
{
document.Staff_Form.submit();
}
function doCompletion1()
{
if(check_ForParticularElements(document.Staff_Form.session,"select",document.Staff_Form.board,"select"))
	doCompletion();
}
function doCompletion()
{
var url = "";
	url = "<%=request.getContextPath()%>/jsp/Reports/pdfcreation.jsp?req_sessionid="+document.Staff_Form.session.value+"&req_sessionname="+document.Staff_Form.session.options[document.Staff_Form.session.options.selectedIndex].text+"&req_boardid="+document.Staff_Form.board.value+"&req_boardname="+document.Staff_Form.board.options[document.Staff_Form.board.options.selectedIndex].text;
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

    <h2>Staff / Subject Allotment List</h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Report.Reports,com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Common.DateTime"%>
<%

		PrinicipalQuery prinicipal			= new PrinicipalQuery();
		Reports obj			= new Reports();
		HashMap	hashmap				= null;
		ArrayList sessionList		=null;
		ArrayList DepartList		=null;
		ArrayList RoleList			=null;
		String sessionid="";
		String standardid="";
		String roleid="";
		String boardid ="";
		String status				= "";

		ArrayList StandardList		= null;
		ArrayList StaffList		= null;
		ArrayList BoardList=new ArrayList();
		try{
		String instituteid			= (String)session.getValue("instituteid");
		sessionList		= obj.ArchivalAcademicYear(instituteid);
		sessionid=request.getParameter("session")+"";
		boardid=request.getParameter("board")+"";

		standardid=request.getParameter("standard")+"";
		roleid=request.getParameter("role")+"";
		if(!sessionid.equals("null") && !sessionid.equals("0"))
		{
			 BoardList			= prinicipal.loadboard(instituteid);
		}
		if(!sessionid.equals("null") && !sessionid.equals("0") && !boardid.equals("null") && !boardid.equals("0"))
		{
		 StandardList=prinicipal.loadstandardusingsessionid(sessionid,boardid);
		}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		String today				= DateTime.showTime("calendar");
%>
<form name="Staff_Form" action="" method="post">
		<table width='80%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
				<th scope="col" class="rounded-company" width="5"></th>
				<th scope="col" class="rounded" width="100%" colspan=5></th>
				<th scope="col" class="rounded-q4" width="5"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan=6 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody ><tr>
		<td></td>
				<td width='20%' class='tablebold'>Academic Year</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
			<select name='session' id='session' validate='Academic Year' style="width:200px" onchange="loadsession()">
						<option value='0'>-Select Academic Year-</option>
						<%
							if(sessionList != null && sessionList.size()>0)
								for(int y=0;y<sessionList.size();y++){
									hashmap		= (HashMap)sessionList.get(y);
									String sessionname=hashmap.get("sessionname")+"";
									String status1=hashmap.get("sessionstatus")+"";

									if(status1.equalsIgnoreCase("R"))
									{
									if(hashmap.get("sessionid").equals(sessionid))
									out.print("<option value='"+hashmap.get("sessionid")+"' selected=true>"+sessionname+"</option>");
									else
										out.print("<option value='"+hashmap.get("sessionid")+"'>"+sessionname+"</option>");
									}
								}
						%>
					</select>
				</td>
				<td width='5%' class='tablebold'>Board</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
					<select name='board' id='board' validate='Board Name' style="width:200px"  onchange="loadsession()">
						<option value='0'>-Select Board-</option>
						<%
							if(BoardList != null && BoardList.size()>0)
								for(int y=0;y<BoardList.size();y++){
									hashmap		= (HashMap)BoardList.get(y);
									String boardname=hashmap.get("boardname")+"";
									String mediumname=hashmap.get("mediumname")+"";
									if(!mediumname.equals("null"))
										boardname=boardname+" -"+mediumname;
									if(hashmap.get("boardid").equals(boardid))
									out.print("<option value='"+hashmap.get("boardid")+"' selected=true>"+boardname+"</option>");
									else
										out.print("<option value='"+hashmap.get("boardid")+"'>"+boardname+"</option>");
								}
						%>
					</select>
				</td>
			</tr>
		</tbody>
		</table>
		<iframe src ="" width="0" height="0" id="fileopener">
  			<p>Your browser does not support iframes.</p>
		</iframe>
		<a href="#but" name="but"    id="but" class="bt_green"  onclick='doCompletion1()'><span class="bt_green_lft"></span><strong>Generate Pdf</strong><span class="bt_green_r"></span></a>
		</form>		

    </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>