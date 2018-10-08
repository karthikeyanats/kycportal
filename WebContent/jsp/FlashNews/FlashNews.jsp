<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>	

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.flashnews.entrytitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>    
<script type="text/javascript">
function submitNews(val)
{
	if(check_ForParticularElements(document.main_Form.message,"textarea"))
	{
		document.main_Form.action = "./Insert_Flash.jsp";
		document.main_Form.submit();
	}
}

function viewFlash()
{
	document.main_Form.action = "./Update_Flash.jsp";
	document.main_Form.submit();
}
function listFun(list)
{

if(list=="TRASHlIST")
{
document.main_Form.list.value=list
document.main_Form.action = "./List_Flash.jsp";
	document.main_Form.submit();
	}
	else
	{
	document.main_Form.list.value=list
		document.main_Form.action = "./List_DeactFlash.jsp";
	document.main_Form.submit();
	}
}
</script>
</head>
<body>
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<jsp:useBean id="date_obj" scope="page"
	class="com.iGrandee.Common.DateTime" />
<jsp:useBean id="flash_query" scope="page"
	class="com.iGrandee.FlashNews.FlashNewsEntry" />

<%
	String date_str = null;
	ArrayList alist = null;
	ArrayList asdad = null;
%>
<%
String instituteid=(String)session.getValue("instituteid");
	try {
		if (session.getValue("userid") == null)
		{
			
		} else 
		{
			date_str = date_obj.showTime("WithTime");
			alist = flash_query.getAllFlashNews(instituteid);
		}
	} catch (NullPointerException ne) {
	}
%>
<div id="main_container">
<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">


<div class="left_content"></div>

<div class="right_content">

<h2><%=bundle.getString("label.flashnews.entryrootpath") %></h2>
<form name="main_Form" method="post" action="">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>

	<tr>
		<td>
		<table id="rounded-corner" border=0 summary="Department List"
			width="100%" cellspacing=0 cellpadding=0>
			<thead>
				<tr>
					
					<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.flashnews.entrytableheading") %></th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.flashnews.mandatoryfields") %></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td  class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
		</table>
	<tbody>
	<tr>
		<td colspan=2>
		
		<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			<thead>
				<tr valign='top' height=20><td class="tablebold"><%=bundle.getString("label.flashnews.enterflash") %>  <font color=red> *</font></td>
				<td width="1%" class="tablebold">:</td>
					<td><textarea rows="5" cols="60" class="tabledivision"
						name="message"
						onkeydown="textCounter_label(document.main_Form.message,document.getElementById('labelid'),2000)"
						onkeyup="textCounter_label(document.main_Form.message,document.getElementById('labelid'),2000)"></textarea>&nbsp;
					<br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.flashnews.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.flashnews.charactersleft") %></font></i>
					</td>     

				</tr>
		</table>
		</td></tr></tbody>
		<table width=100%><tr><td>
 <a href="#" class="bt_red" onclick="listFun('TRASHlIST')"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.flashnews.trashedlist") %></strong><span class="bt_red_r"></span></a>
	  <a href="#" class="bt_blue" onclick="listFun('DEACTIVElIST')"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.flashnews.deactivatedlist") %></strong><span class="bt_blue_r"></span></a>
		<a href="#" onclick="viewFlash()" class="bt_blue"><span
			class="bt_blue_lft"></span><strong><%=bundle.getString("button.flashnews.view") %> </strong><span
			class="bt_blue_r"></span></a> <a href="#" class="bt_green"
			onclick="submitNews()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.flashnews.submit") %></strong><span
			class="bt_green_r"></span></a>
			</td></tr>
	  
</table>
<tr>
	<td>
	<table id="rounded-corner" border=0 summary="Department List"
		width="100%">
		<thead>
			<tr>
				<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.flashnews.slno") %></th>
				<th scope="col" class="rounded" width="65%"><%=bundle.getString("label.flashnews.content") %></th>
				<th scope="col" class="rounded" width="20"><%=bundle.getString("label.flashnews.createddate") %></th>
				<th scope="col" class="rounded-q4" width="10%" align="right"><%=bundle.getString("label.flashnews.status") %></th>


			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan=3 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody>


			<%String[] count=null;
				if (alist != null && alist.size() > 0) {
					String state_str = null;
					int inc_i = 0;
					int inc_i1 = 1;
					for (int t = 0; t < alist.size(); t++) {
						HashMap hm = (HashMap) alist.get(t);
						String cdate = (String) hm.get("newdates");
						String contentid = (String) hm.get("flashid");
						String content = (String) hm.get("flashmessage");
						String status = (String) hm.get("flashstatus");
						if (status.equals("A"))
							state_str = "<font color=green>"+bundle.getString("label.flashnews.active")+"</font>";
						else if (status.equals("D"))
							state_str = "<font color=red>"+bundle.getString("label.flashnews.deactive")+"</font>";
						out
								.println("<tr class=tablelight id='tabs"
										+ inc_i
										+ "'><td valign=top  width='5%'>"
										+ (inc_i + 1)
										+ "</td>");
						if(content == null || content.equals("") || content.equals("-") || content.equalsIgnoreCase("null"))
						{
						
						out.print("<td class='tablelight'>-</td>");
						}
						else{
							
							   count=content.split(" ");
								if((count.length-1)>15)
								{
									out.print("<td class='tablelight' ");
									String des_tempnew="";
									for(int k=0;k<15;k++)
									{
										des_tempnew+=count[k]+" ";
									}%>
									<div>
									<%=content%><a href="index.htm" onclick="return hs.htmlExpand(this)">
								[<font color="red">More..</font>]
							</a>  
							<div class="highslide-maincontent">
								<h3></h3>
								<%=(content).replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
							</div>
								</div>
								<% }
								else
								{
									out.print("<td class='tablelight'>"+content+"</td>");

								}
								}	
										out.print("</td><td valign=top align=left class=tablelight>"
										+ cdate
										+ "</td><td valign=top align=left class=tablebold>"
										+ state_str + "</td></tr>");
						inc_i++;
					}
				} else {
					out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>Data Not Found</font></td></tr>");
					//out.println("<tr class=tablebold><td align=center colspan=4>Data Not Found</td></tr>");
				}
			%>
		
	</table>
	<input type=hidden name=mode_of_operation value="Insert"><input
		type=hidden name="server_date" value="<%= date_str%>"></TD>
		<input type=hidden name=list value="">
</TR>
</TABLE>

</form>
</thead>
</table>


</td>
</tr>
</TABLE>
</div>
<!-- end of right content--></div>
<!--end of center content -->




<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>

</form>

</div>
</body>
</html>