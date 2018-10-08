<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Circular Details | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>
	
function backfun()
{
	document.Circular_Form.action="./CircularView.jsp";
	document.Circular_Form.submit();
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
<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">

<h2>General / Circular / Circular View / Circular Details</h2>
<%@ page
	import="java.io.*,java.util.*,java.net.*,com.iGrandee.Circular.CircularEntryQuery"%>

<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
<form name='Circular_Form' method='post'>
<table class="bodyinnercolor" border='0' align="center" width="100%"
	height='100%' cellspacing=0 cellpadding=0>
	<tr>
		<td width='100%' align='center'>
		<table border=0 bordercolor='blue' align="center" width="80%"
			cellspacing=0 cellpadding=0>
			<tr>
				<td align='left' width='100%' height='100%'>
				<table border='0' align="center" width="100%" cellspacing=5
					cellpadding=0>
					<tr>
						<td valign='top'>
						<%
																						    	String circularId = null;
																						    	String subject = null;
																						    	String details = null;
																						    	String dateOfCreation = null;
																						    	String validityFrom = null;
																						    	String validiTo = null;
																						    	String sendTo = null;
																						    	String mode = null;
																						    	String Attachment = null;

																						    	String strArr[] = null;

																						    	String temp = "";
																						    	String code = "";
																						    	String circularid = request.getParameter("circularid");
																						    	ArrayList list = new ArrayList();
																						    	CircularEntryQuery circularQuery = new CircularEntryQuery();
																						    	list = circularQuery.loadCircularForCircularid(circularid);
																						    	if (list.size() > 0) {
																						    		HashMap map = (HashMap) list.get(0);
																						    		circularId = (String) map.get("circularid");
																						    		subject = (String) map.get("subject");
																						    		details = (String) map.get("details");
																						    		dateOfCreation = (String) map.get("dateofcreation");
																						    		validityFrom = (String) map.get("validityfrom");
																						    		validiTo = (String) map.get("validityto");
																						    		sendTo = (String) map.get("sendto");
																						    		mode = (String) map.get("mode");
																						    		Attachment = (String) map.get("attachments");

																						    		if (mode.equals("Standard")) {
																						    			ArrayList list_1 = new ArrayList();
																						    			ArrayList r_list = circularQuery.getReceiverInfo(mode,
																						    					sendTo);
																						    			for (int i = 0; i < r_list.size(); i++) {
																						    				map = (HashMap) r_list.get(i);
																						    				String year = (String) map.get("sessionname");
																						    				String course = (String) map.get("standardname");
																						    				String coursePublishId = (String) map
																						    						.get("standardscheduleid");

																						    				if (!list_1.contains(year)) {
																						    					list_1.add(year);
																						    					code += "<tr>";
																						    					code += "<td class='tablebold' colspan='2' width='100%'><font color='red'>";
																						    					code += year;
																						    					code += "</td>";
																						    					code += "</tr>";
																						    				}
																						    				code += "<tr>";
																						    				code += "<td align='center'>"+(i+1)+"</td>";
																						    				code += "<td class='tablelight'>";
																						    				code += course;
																						    				code += "</td>";
																						    				code += "</tr>";
																						    			}
																						    		}
																						    			else if(mode.equals("student"))
																						    			{
																						    				String tttt="";
																						    				ArrayList r_list=circularQuery.getReceiverInfo(mode,sendTo);
																						    				strArr= new String[r_list.size()];
																						    				ArrayList list_4=new ArrayList();
																						    				//System.out.println("=======>>>>>>>>>"+r_list.size());
																						    				for(int i=0;i<r_list.size();i++)
																						    				{
																						    					map=(HashMap)r_list.get(i);
																						    					String year=(String)map.get("sessionname");
																						    					String standardname=(String)map.get("standardname");
																						    					String sectionname=(String)map.get("sectionname");
																						    					String student=(String)map.get("uname");
																						    					String groupname=(String)map.get("groupname")+"";
																						    					if(!groupname.equals("null"))
																						    						standardname=standardname+groupname;
																						    					temp=year+" / "+standardname+" / "+sectionname;
																						    					if(!tttt.equals(temp))
																						    					{
																						    						code+="<tr>";
																						    						code+="<td class='tablebold' colspan='2' width='100%'><font color='red'>";											  		code+=temp;
																						    						code+="</td>";
																						    						code+="</tr>";
																						    						tttt=temp;
																						    					}
																						    					code+="<tr>";
																						    					code+="<td align='center'>"+(i+1)+"</td>";
																						    					code+="<td class='tablelight'>";
																						    					code+=student;
																						    					code+="</td>";
																						    					code+="</tr>";
																						    				}
																						    			}
																						    			else if(mode.equals("Role"))
																						    			{
																						    				ArrayList departList =new ArrayList();
																						    				String sendto2="";
																						    				String codeee="";
																					    					//System.out.println("sendTo.replace()==========>>>>>"+sendTo.replace(",","&"));

																						    				String temparray []=sendTo.replace(",","&").split("&");
																						    				for(int x=0;x<temparray.length;x++)
																						    				{
																						    					if(x%2==0)
																						    					{
																						    						sendto2 +=temparray [x]+",";
																							    					//System.out.println("==========>>>>>"+temparray[x]);
																						    					}
																						    					else
																						    					{
																						    						departList.add(temparray [x]);
																							    					//System.out.println("======**************====>>>>>"+temparray[x]);

																						    					}
																						    				}
																						    				ArrayList r_list=circularQuery.getReceiverInfo(mode,sendto2);
																						    				strArr= new String[r_list.size()];
																						    				ArrayList list_4=new ArrayList();
																						    				for(int i=0,sno=1;i<r_list.size();i++)
																						    				{
																						    					map=(HashMap)r_list.get(i);
																						    					String name=(String)map.get("institutename");
																						    					String d_name=(String)map.get("departmentname");
																						    					String d_id=(String)map.get("departmentid");
																						    					String r_name=(String)map.get("rolename");
																						    					String r_id=(String)map.get("roleid");
																						    					//System.out.println("==========>>>>>"+d_id);

																						    					for(int z=0;z<departList.size();z++)
																						    					{
																							    					String depid=departList.get(z)+"";

																							    					//System.out.println(depid+"==========>>>>>"+d_id);

																						    					if(depid.equals(d_id))
																						    					{
																						    					temp=depid;
																						    					if(!list_4.contains(temp))
																						    					{
																						    						list_4.add(temp);
																						    						code+="<tr>";
																						    						code+="<td class='tablebold' colspan='2' width='100%'><font color='red'>";	
																						    						code+=name+" / "+d_name;
																						    						code+="</td>";
																						    						code+="</tr>";
																						    					}
																						    					if(!list_4.contains(r_name+"/"+d_name))
																						    					{
																							    					code+="<tr>";
																							    					code+="<td align='center'>"+sno+"</td>";
																							    					code+="<td class='tablelight'>";
																							    					list_4.add(r_name+"/"+d_name);
																							    					code+=r_name;
																							    					code+="</td>";
																							    					code+="</tr>";
																							    					sno++;
																						    					}
																						    					}
																						    					}
																						    				}
																						    			}
																						    		else if(mode.equals("staff"))
																						    			{
																						    				ArrayList r_list=circularQuery.getReceiverInfo(mode,sendTo); 
																						    				strArr= new String[r_list.size()];
																						    				ArrayList list_4=new ArrayList();

																						    				for(int i=0;i<r_list.size();i++)
																						    				{
																						    					map=(HashMap)r_list.get(i);
																						    					String name=(String)map.get("institutename");
																						    					String d_name=(String)map.get("departmentname");
																						    					String staff=(String)map.get("uname");
																						    					String p_id=(String)map.get("personid");
																						    					temp=name+" / "+d_name;

																						    					if(!list_4.contains(temp))
																						    					{
																						    						list_4.add(temp);
																						    						code+="<tr>";
																						    						code+="<td class='tablebold' colspan='2' width='100%'><font color='red'>";
																						    						code+=temp;
																						    						code+="</font></td>";
																						    						code+="</tr>";
																						    					}
																						    					code+="<tr>";
																						    					code+="<td align='center'>"+(i+1)+"</td>";
																						    					code+="<td class='tablelight'>";
																						    					code+=staff;
																						    					code+="</td>";
																						    					code+="</tr>";
																						    				}
																						    			}
																						    	}
																						    %>
						<table id="rounded-corner" border=0 summary="Department List" width="100%">
							<thead>
								<tr>
									<th scope="col" class="rounded-company" width="90%">Circular Details</th>
									<th scope="col" class="rounded-q4" width="10%"></th>
								</tr>
							</thead>
							</table>
							<tbody>
								<tr>
									<td colspan=2>
									<table width="100%" id="rounded-corner" border=0>
										<tr>
											<td class=tablebold>Circular Date </td>
											<td class=tablebold >:</td>
											<td class=tablelight ><%=dateOfCreation%></td>
										</tr>
										<tr>
										<td class=tablebold >Duration From</td>
											<td class=tablebold>:</td>
											<td> <i><font color="red"><%=validityFrom%></font> To <font color="red"><%=validiTo%></font></i></td>
										</tr>
										<tr>
											<td class=tablebold width="20%" align="left">Subject</td>
											<td class=tablebold>:</td>
											<td class=tablelight align="left"><%=subject%></td>
										</tr>
										<tr>
											<td class=tablebold width="20%" align="left">Mode</td>
											<td class=tablebold>:</td>
											<td class=tablelight align="left"><%=mode%></td>
										</tr>
										<tr>
											<td class=tablebold width="20%" align="left" valign=top>Description</td>
											<td class=tablebold>:</td>
											<td class=tablelight align="justify"><%=details%></td>
												</tr>
												<tr height=30>
													<td class=tablebold width="20%" align="left">Attachment</td>
													<td class=tablebold>:</td>
													<td class=tablelight  align="justify">
													<%
																if(!Attachment.equals("null"))
																		out.println("<a href='#' atta='"+Attachment+"' onclick=win(this)>Attachment</a>");																
																	else
																	out.println("-");
													%></td>
												</tr></table></td></tr>
									</tbody>
						
						<br>
						<table id="rounded-corner" border=0 summary="Department List" width="100%">
							<thead>
								<tr>
									<th scope="col" class="rounded-company" width="90%">Receiver Details</th>
									<th scope="col" class="rounded-q4" width="10%"></th>
								</tr>
							</thead>
							
							<tbody>
								<tr height=30>
									<td colspan="3">
									<table width="99%">
											<tr height=30>
											<td class=tablelight width="100%" bgcolor="#f8f8f0">
											<table width="100%" border="0" bgcolor="#f8f8f0"
												bordercolor="#ffffff" cellpadding=3 cellspacing=0>
												<tr height=30>
													<td class="tablebold" width="10%">Sl.No</td>
													<td class="tablebold"><%=mode%></td>
												</tr>
												<%=code%>
											</table>
											</td>
										</tr>
									</table>
									</td>
								</tr>
							</tbody>
						</table>
						</td>
					</tr>
				</table>
				<br>
				<a href="#na2" name="na2" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
				
				</td>
			</tr>
		</table>
</td>
</tr>
</table>
		</form>
		</div>
		<!-- end of right content-->


		</div>
		<!--end of center content -->




		<div class="clear"></div>
		</div>
		<!--end of main content--> <%@ include file="../include/footer.jsp"%>


		</div>
</body>
</html>