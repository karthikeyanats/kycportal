<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language="javascript">

function backfun()
{
	document.Circular_Form.action="./CircularEntry.jsp";
	document.Circular_Form.submit();
}
function Trashlish()
{
	document.Circular_Form.action="./CircularTrashList.jsp";
	document.Circular_Form.submit();
}
function ViewCircular(obj)
{
	var cirid=obj.getAttribute("circularid")
	document.Circular_Form.circularid.value=cirid;
	document.Circular_Form.action="./CircularWindow.jsp";
	document.Circular_Form.submit();
}
function TrashCircular(obj)
{
if(confirm("Do you want to Trash the Circular...?"))
{
	var cirid=obj.getAttribute("circularid")
	document.Circular_Form.circularid.value=cirid;
	document.Circular_Form.action="./CircularEditSubmit.jsp";
	document.Circular_Form.submit();
}
}
function EditCircular(obj)
{
if(confirm("Do you want to Update the circular...?"))
{
	var cirid=obj.getAttribute("circularid")
	document.Circular_Form.circularid.value=cirid;
	document.Circular_Form.action="./CircularUpdate.jsp";
	document.Circular_Form.submit();
}
}

function win(obj)
{
var attachment=obj.getAttribute("atta");
window.open("<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2="+attachment+"","Msg","top=250,left=350,help:no,center:no,status:no,width=500,height=300,scrollbars=1;")
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

    <h2>General / Circular / Circular View</h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"	import="com.iGrandee.Circular.CircularEntryQuery"%>
	
<%@ page language="java" import="java.util.*" %>
<%
	ResourceBundle bundle = null;
%>
<%
ArrayList list=new ArrayList();
CircularEntryQuery circular =new CircularEntryQuery();
	try
	{
			String resources_ln=   "";
			String userid=   session.getValue("userid")+"";
			bundle = ResourceBundle.getBundle("resources.ApplicationResources");
			session.putValue("resources_ln","English");
			list=circular.loadCircular(userid);
	}
	catch(NullPointerException e)
	{
		//System.out.println("Message ==\t\t"+e.getMessage());
	}
%>
<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
	<form name='Circular_Form' method='post'>
	<input type="hidden" name="Status" value="Trash">
	
	<input type='hidden' name='circularid' value=''>
		<table class="bodyinnercolor" border='0' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
	<table border=0  align=center class=tablehead cellpadding=0 cellspacing=0 width="80%">
		<tr>
		<td>
			<table id="rounded-corner" border=0  align=center  cellpadding=3 cellspacing=0 width="100%" >
			<thead>
				<tr  height=35>
					<th align=left width="5%" scope="col" class="rounded-company" >	Sl.No</th>
					<th align=left width="15%" scope="col" class="rounded" >  <%=bundle.getString("label.mydiary.subject")%></th>
					<th align=center width="15%" scope="col" class="rounded" ><%=bundle.getString("label.tracks.IssuedDate")%></th>
					<th align=center width="15%"  scope="col" class="rounded" ><%=bundle.getString("label.tracks.IValidityFrom")%></th>
					<th align=center width="15%"  scope="col" class="rounded" ><%=bundle.getString("label.tracks.ValidityTo")%></th>
					<th align=center width="15%"  scope="col" class="rounded" >Attachment</th>
					<th align=center width="10%"  scope="col" class="rounded" >Mode</th>
					<th align=center width="25%"  scope="col" class="rounded-q4" >Action</th>
				</tr>
				</thead>
				<tbody>
				<%
					if(list.size()>0 && list!=null)
					{
						for(int i=0;i<list.size();i++)
						{
							HashMap map=(HashMap)list.get(i);
							String circularId=(String)map.get("circularid");
							String detailId=(String)map.get("cdetailid");
							String subject=(String)map.get("subject");
							String details=(String)map.get("details");
							String dateOfCreation=(String)map.get("dateofcreation");
							String validityFrom=(String)map.get("validityfrom");
							String validiTo=(String)map.get("validityto");
							String sendTo=(String)map.get("sendto");
							String mode=(String)map.get("mode");
							String Attachment=(String)map.get("attachments")+"";
							out.println("<tr height='30' >");
							out.println("<td class=tablelight align=center><a>"+(i+1)+"</a></td>");
							out.println("<td class=tablelight  align=left><a href='#view' name='view' circularid='"+circularId+"' onclick='ViewCircular(this)'>"+subject+"</a></td>");
							out.println("<td class=tablelight><a>"+dateOfCreation+"</a></td>");
							out.println("<td class=tablelight><a>"+validityFrom+"</a></td>");
							out.println("<td class=tablelight><a>"+validiTo+"</a></td>");
							if(Attachment.equals("null"))
								out.println("<td class=tablelight>-</td>");
							else
							out.println("<td class=tablelight><a href='#' atta='"+Attachment+"' onclick=win(this)>Attachment</a></td>");
							out.println("<td class=tablelight  align=left><a>"+mode+"</a></td>");
							out.println("<td class=tablelight  align=left><a href='#edit' name='edit' circularid='"+circularId+"' onclick='EditCircular(this)'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_edit.png' alt='EDIT' title='EDIT' border=0 /></a>&nbsp;|&nbsp;<a href='#Trash' name='Trash' circularid='"+circularId+"' onclick='TrashCircular(this)'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/trash.png' alt='Trash' title='Trash' border=0 /></a></td>");
							out.println("</tr>");
						}
					}
					else
					{
						out.println("<td colspan='8' align=center><font color='red'><b>Data Not Found</b></font></td>");
						//out.println("<td class=mandatory colspan=8 align=center>Data Not Found</td>");
					}
				%>
				</tbody>
				<tfoot>
				<tr>
					<td colspan=7 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			</table>
		</td>
	</tr>
</table>
<br>
<a href="#na2" name="na2" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
<a href="#na2" name="na2" class="bt_red" onclick="Trashlish()"><span class="bt_red_lft"></span><strong>Trash List</strong><span class="bt_red_r"></span></a>

				</td>
			</tr>
		</table>
	</form>
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>