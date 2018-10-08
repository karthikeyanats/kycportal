<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language="javascript">
function ViewCircular(obj)
{
	var cirid=obj.getAttribute("circularid")
	document.Circular_Form.circularid.value=cirid;
	document.Circular_Form.action="./CircularWindow.jsp";
	document.Circular_Form.submit();
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

    <h2>Circular / Circular View</h2>
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
String standardscheduleid ="";
String studentid  ="";

	try
	{
			String resources_ln=   "";
			String userid=   session.getValue("userid")+"";
			
			 standardscheduleid =   session.getValue("standardscheduleid")+"";
			 studentid  =   session.getValue("studentid")+"";

			String sessionparameter []=   session.getValueNames();
			//out.println("======>>>>>"+standardscheduleid);
			//out.println("======>>>>>"+studentid);

			bundle = ResourceBundle.getBundle("resources.ApplicationResources");
			session.putValue("resources_ln","English");
			list=circular.loadCircular();
		/*	for(int g=0;g<sessionparameter.length;g++)
			{
				out.println("======>>>>>"+sessionparameter[g]);
			}*/
	}
	catch(NullPointerException e)
	{
		//System.out.println("Message ==\t\t"+e.getMessage());
	}
%>
<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
	<form name='Circular_Form' method='post'>
	<input type='hidden' name='circularid' value=''>
		<table class="bodyinnercolor" border='0' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
	<table border=0  align=center class=tablehead cellpadding=0 cellspacing=0 width="80%">
		<tr>
		<td>
			<table id="rounded-corner" border=0  align=center  cellpadding=3 cellspacing=2 width="100%" >
			<thead>
				<tr  height=35>
					<th align=left width="5%" scope="col" class="rounded-company" >	Sl.No</th>
					<th align=left width="20%" scope="col" class="rounded" >  <%=bundle.getString("label.mydiary.subject")%></th>
					<th align=center width="20%" scope="col" class="rounded" ><%=bundle.getString("label.tracks.IssuedDate")%></th>
					<th align=center width="20%"  scope="col" class="rounded" ><%=bundle.getString("label.tracks.IValidityFrom")%></th>
					<th align=center width="20%"  scope="col" class="rounded" ><%=bundle.getString("label.tracks.ValidityTo")%></th>
					<th align=center width="20%"  scope="col" class="rounded-q4" >Attachment</th>
				</tr>
				</thead>
				<tbody>
				<%
					if(list.size()>0 && list!=null)
					{
						for(int i=0,sno=1;i<list.size();i++)
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
							String sendToarray []=sendTo.split(",");
							String mode=(String)map.get("mode");
							String Attachment=(String)map.get("attachments");
							if(mode.equals("Standard"))
							{
								for(int g=0;g<sendToarray.length;g++)
								{
									if(sendToarray[g].equals(standardscheduleid))
									{
									out.println("<tr height='30' >");
									out.println("<td class=tablelight align=center><a>"+sno+"</a></td>");
									out.println("<td class=tablelight  align=left><a href='#view' name='view' circularid='"+circularId+"' onclick='ViewCircular(this)'>"+subject+"</a></td>");
									out.println("<td class=tablelight><a>"+dateOfCreation+"</a></td>");
									out.println("<td class=tablelight><a>"+validityFrom+"</a></td>");
									out.println("<td class=tablelight><a>"+validiTo+"</a></td>");
									out.println("<td class=tablelight><a href='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+Attachment+"'>Attachment</a></td>");
									out.println("</tr>");
									sno++;
									}
								}
							}
							if(mode.equals("student"))
							{
								for(int g=0;g<sendToarray.length;g++)
								{
									if(sendToarray[g].equals(studentid))
									{
									out.println("<tr height='30' >");
									out.println("<td class=tablelight align=center><a>"+sno+"</a></td>");
									out.println("<td class=tablelight  align=left><a href='#view' name='view' circularid='"+circularId+"' onclick='ViewCircular(this)'>"+subject+"</a></td>");
									out.println("<td class=tablelight><a>"+dateOfCreation+"</a></td>");
									out.println("<td class=tablelight><a>"+validityFrom+"</a></td>");
									out.println("<td class=tablelight><a>"+validiTo+"</a></td>");
									out.println("<td class=tablelight><a href='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+Attachment+"'>Attachment</a></td>");
									out.println("</tr>");
									sno++;
									}
								}
							}
							
						}
					}
					else
					{
						out.println("<td colspan='6' align=center><font color='red'><b>Data Not Found</b></font></td>");
						//out.println("<td class=mandatory colspan=6 align=center>Data Not Found</td>");
					}
				%>
				</tbody>
				<tfoot>
				<tr>
					<td colspan=5 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			</table>
		</td>
	</tr>
</table>
<br>
<a href="#na2" name="na2" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>

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