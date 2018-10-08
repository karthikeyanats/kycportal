<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Staff | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">
function loadStandard()
{
document.Staff_Form.submit();
}


function loadStandard2()
{
	document.Staff_Form.standard.options[0].selected=true;
	document.Staff_Form.section.options[0].selected=true;
	document.Staff_Form.day.options[0].selected=true;
	document.Staff_Form.submit();
}
function loadStandard3()
{
	document.Staff_Form.section.options[0].selected=true;
	document.Staff_Form.day.options[0].selected=true;
	document.Staff_Form.submit();
}
function loadStandard4()
{
	document.Staff_Form.day.options[0].selected=true;
	document.Staff_Form.submit();
}
function loadStandard1()
{
if(check_ForParticularElements(document.Staff_Form.section,"select",document.Staff_Form.day,"select"))
document.Staff_Form.submit();
}
function loadstaffdetail(obj)
{
document.Staff_Form.userid.value=obj.getAttribute("userid");
document.Staff_Form.action="./StaffTimeTableView.jsp";
document.Staff_Form.submit();
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

	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>
    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("hmlabel.freepool.rootpath")%></h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Common.DateTime"%>
<%
ArrayList PeriodList		= null;
String instituteid			=null;

		PrinicipalQuery prinicipal			= new PrinicipalQuery();
		HashMap	hashmap				= null;
		HashMap	hashmap1				= null;
		ArrayList sessionList		=null;
		ArrayList DepartList		=null;
		ArrayList RoleList			=null;
		String sessionid="";
		String sectionpublishid="";
		String standardid="";
		String roleid="";
		String dayid="";
		String periodid="";
		String boardid = null;
		ArrayList BoardList=new ArrayList();

		ArrayList StandardList		= null;
		ArrayList SectionList		= null;
		ArrayList dayList		= null;


		try{
		instituteid			= (String)session.getValue("instituteid");
		sessionList		= prinicipal.loadyearofsession(instituteid);
		sessionid=session.getValue("sessionid")+"";
		
		boardid=request.getParameter("board")+"";

		standardid=request.getParameter("standard")+"";

		sectionpublishid=request.getParameter("section")+"";
		dayid=request.getParameter("day")+"";
		periodid=request.getParameter("period")+"";
		if(!sessionid.equals("null") && !sessionid.equals("0"))
		{
			BoardList	= prinicipal.loadboard(instituteid);
		}
		if(!sessionid.equals("null") && !sessionid.equals("0") && !boardid.equals("null") && !boardid.equals("0"))
		{
		 			
			StandardList=prinicipal.loadstandardusingsessionid(sessionid,boardid);

		}
		if(!sessionid.equals("null") && !sessionid.equals("0")  && !boardid.equals("null") && !boardid.equals("0") && !standardid.equals("null") && !standardid.equals("0") && StandardList.size()>0)
		{
			SectionList=prinicipal.loadsection(standardid,instituteid);
			dayList=prinicipal.loadday(); 
		}
		if(!sessionid.equals("null") && !sessionid.equals("0") && !boardid.equals("null") && !boardid.equals("0") && !standardid.equals("null") && !standardid.equals("0") && StandardList.size()>0 &&  !sectionpublishid.equals("null") && !sectionpublishid.equals("0") && SectionList.size()>0 && !dayid.equals("null") && !dayid.equals("0") )
		{
			PeriodList=prinicipal.loadperiodforfreepoolstaff(instituteid);    
		}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		String today				= DateTime.showTime("calendar");
		//out.println(StandardList);
%>
<form name="Staff_Form" action="" method="post">
<input type="hidden" name="hiddenyear" value="<%=sessionid %>">
<input type="hidden" name="hiddenstandardid" value="<%=standardid %>">
<input type="hidden" name="hiddensection" value="<%=sectionpublishid %>">
<input type="hidden" name="hiddenday" value="<%=dayid %>">
<input type="hidden" name="hiddenperiod" value="<%=periodid %>">
<input type="hidden" name="userid" value="">


<table width='80%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
				<th scope="col" class="rounded-company" width="90%">Free Pool Staff </th>
				<th scope="col" class="rounded-q4" width="10%"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody ><tr>
		<td colspan=2>
		<table width="100%">
		<tr>
				<td width='20%' class='tablebold'><%=bundle.getString("hmlabel.freepool.academicyear")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
					<%= session.getValue("sessionname")%>
				</td>
				<td width='5%' class='tablebold'><%=bundle.getString("hmlabel.freepool.board")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
					<select name='board' id='board' validate='Board Name' style="width:150px"  onchange="loadStandard2()">
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
			<tr>
		
			<td width='5%' class='tablebold'><%=bundle.getString("hmlabel.freepool.standard")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
					<select name='standard' id='standard' validate='Standard Name' style="width:150px" onChange="loadStandard3()">
						<option value='0'>-Select Standard-</option>
						<%
							if(StandardList != null && StandardList.size()>0)
								for(int y=0;y<StandardList.size();y++){
									hashmap		= (HashMap)StandardList.get(y);
									String standardname=hashmap.get("standardname")+"";
									String groupname=hashmap.get("groupname")+"";
									if(!groupname.equals("null"))
									standardname=standardname+" -"+groupname;
									out.print("<option value='"+hashmap.get("standardscheduleid")+"'>"+standardname+"</option>");
								}
						%>
					</select>
					<script>
					if(document.Staff_Form.hiddenstandardid.value!="null" && document.Staff_Form.hiddenstandardid.value!="0" && document.Staff_Form.hiddenyear.value!="0")
					{
						for(var i=0;i<document.Staff_Form.standard.length;i++)
						{
						if(document.Staff_Form.standard.options[i].value==document.Staff_Form.hiddenstandardid.value)
						{
							document.Staff_Form.standard.options[i].selected=true;
						}
						}
					}
					</script>
				</td>
				<td width='5%' class='tablebold'><%=bundle.getString("hmlabel.freepool.section")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%' >
					<select name='section' id='section' validate='Section Name'style="width:150px" onchange='loadStandard4()'>
						<option value='0'>-Select Section-</option>
						<%
							if(SectionList != null && SectionList.size()>0)
								for(int y=0;y<SectionList.size();y++){
									hashmap		= (HashMap)SectionList.get(y);
									String sectionname=hashmap.get("sectionname")+"";
									out.print("<option value='"+hashmap.get("sectionscheduleid")+"'>"+sectionname+"</option>");
								}
						%>
					</select>
					<script>
					if(document.Staff_Form.hiddenstandardid.value!="null" && document.Staff_Form.hiddenstandardid.value!="0" && document.Staff_Form.hiddenyear.value!="0")
					{
						for(var i=0;i<document.Staff_Form.section.length;i++)
						{
						if(document.Staff_Form.section.options[i].value==document.Staff_Form.hiddensection.value)
						{
							document.Staff_Form.section.options[i].selected=true;
						}
						}
					}
					</script>
				</td>
				
			</tr>
			<tr>

			<td width='5%' class='tablebold'><%=bundle.getString("hmlabel.freepool.day")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%' colspan=4>
					<select name='day' id='day' validate='Day' onchange='loadStandard1()' style="width:150px">
						<option value='0'>-Select Day-</option>
						
						<%
							if(dayList != null && dayList.size()>0)
								for(int y=0;y<dayList.size();y++){
									hashmap		= (HashMap)dayList.get(y);
									out.print("<option value='"+hashmap.get("dayid")+"'>"+hashmap.get("dayname")+"</option>");
								}
						%>
					</select>
						<script>
					if(document.Staff_Form.hiddenstandardid.value!="null" && document.Staff_Form.hiddenstandardid.value!="0" && document.Staff_Form.hiddenyear.value!="0" && document.Staff_Form.hiddensection.value!="0")
					{
						for(var i=0;i<document.Staff_Form.day.length;i++)
						{
						if(document.Staff_Form.day.options[i].value==document.Staff_Form.hiddenday.value)
						{
							document.Staff_Form.day.options[i].selected=true;
						}
						}
					}
					</script>
				</td>
			</tr>
			</table>
			</td></tr>
		</tbody>
		</table>
		
		<br>
		<table   align='center' border='0' id=rounded-corner bordercolor=white width="100%" >
			<thead>
				<tr>
						<th scope='col' class='rounded-company' width='10%'><%=bundle.getString("hmlabel.freepool.slno")%></th>
						<th scope='col' class='rounded' width='40%'><%=bundle.getString("hmlabel.freepool.period")%></th>
						<th scope='col' class='rounded-q4' width='50%'><%=bundle.getString("hmlabel.freepool.freestaff")%></th>
				</tr>
			</thead>
		<tbody>
		<%
		try{
			
			if(PeriodList != null && PeriodList.size()>0)
			{
				for(int y=0,i=1;y<PeriodList.size();y++)
				{
					hashmap		= (HashMap)PeriodList.get(y);
					out.println("<tr>");
					out.println("<td>"+i+"</td><td>"+hashmap.get("periodname")+"<br>[ "+hashmap.get("periodtime")+" ]</td>");
					ArrayList StaffList		= null;

					StaffList=prinicipal.loadfreepoolstaffforperiod(sectionpublishid,dayid,hashmap.get("periodid")+"",sessionid);  
					
					out.println("<td>");
							if(StaffList != null && StaffList.size()>0)
								{
									for(int j=0;j<StaffList.size();j++){
									HashMap hashmap2= (HashMap)StaffList.get(j);
									out.print(hashmap2.get("uname") +" [ "+hashmap2.get("departmentname")+" ]<br>");
									}
								}
								else
								{
									out.println("-");
								}
					out.println("</td>");
					out.println("</tr>");
					i++;		
				}
			}
			else
			{
				out.print("<tr><td colspan='3' class=tablebold align=center><font color=red>Data Not Found</font></td></tr>");
			}
		}
		catch(Exception e)
		{}
						%>
		</tbody>
		<tfoot>
		<tr >
				<td colspan='3'>&nbsp;</td>
			</tr>
			
		</tfoot>
		</table>

		<!--  <a href="#" class="bt_blue" onClick='loadstudent()'><span class="bt_blue_lft"></span><strong>Load Student</strong><span class="bt_blue_r"></span></a>-->
		</form>		

    </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>