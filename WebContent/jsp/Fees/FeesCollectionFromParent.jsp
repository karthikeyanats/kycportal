<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.feescollectionparent.entrytitle")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">

function addFeesAllocation()
{
//if(check_ForParticularElements(document.feescollectionform.rollnumbertext,"text"))
	//{
		document.feescollectionform.action="./Feescollectionsubmit.jsp";
		document.feescollectionform.submit();
	//}
}

function asdcdas(obj)
{
	alert("ASDF");
	alert(obj.getAttribute("termname"));
}

function showterm(obj)
{
	var spanvalue		= document.getElementById("termselected");
	spanvalue.innerHTML = " for "+obj.getAttribute("termname");
	document.feescollectionform.termcheckid.value = obj.value;
//termselected.innerHTML = obj.value;
}
function paymentgateway(obj)
{
	var termfeesid		= obj.getAttribute("termfeesid");
	var termpendingfeesamount=obj.getAttribute("termpendingamount");
	document.feescollectionform.amount1.value=termpendingfeesamount;
	document.feescollectionform.termfeesid.value=termfeesid;
	document.feescollectionform.action="../../payment/MainPaymentGatewayPage.jsp";
	document.feescollectionform.submit();
}
function PaymentRecepit(obj)
{
	var termfeesid		= obj.getAttribute("termfeesid");
	window.open("PrintPreviewFeesCollectionPreviousReport.jsp?termfeesid="+termfeesid,'Msg','top=250,left=350,help:no,center:no,status:no,width=650,height=600,scrollbars=1;');
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

    <h2><%=bundle.getString("label.feescollectionparent.onlinepaidentryheading")%></h2>

<form name="feescollectionform" action="" method="post">
  <%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,java.text.NumberFormat,java.util.Locale"%>

     <%

     com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();

     String instituteid = null;
     ArrayList studentfeescollectionList = null;
     ArrayList feesScheduleList = null;

     String reqrollnumbertext = null;
     String studentstandard = null;
     String studentname = null;
     String studentsection = null;
     ArrayList loadscholarshipList  =null;
     String today		= null;
     String formattedCurrency = null;
     String paidformattedCurrency = null;
     //Locale localcurrency = new Locale("en", "IN");
     ResourceBundle bundle1 	= 	ResourceBundle.getBundle("resources.serversetup");
		Locale localcurrency = new Locale(bundle1.getString("language"), bundle1.getString("code"));
     String formattedCurrency1 = null;
     String paidformattedCurrency1 = null;
     String remformattedCurrency = null;
     String remformattedCurrency1 = null;
     String colformattedCurrency = null;
     String standardscheduleid =  null;



     int totalamount =0;
     int totalPaidamount =0;
     int totalRemamount =0;

     int temptotalamount =0;
     int temptotalPaidamount =0;

     int count = 0;
     String studentapprovalid = null;
     String studentallocationid	= null;
     try
     {
    	  studentallocationid	= (String)session.getValue("studentid");
    	  //System.out.println("studentallocationid-->"+studentallocationid);

    	  reqrollnumbertext			= feesscheduleQuery.getRollNo(studentallocationid);
    	  instituteid = (String)session.getValue("instituteid");
    	  //reqrollnumbertext=request.getParameter("rollnumbertext");
    	  feesScheduleList = feesscheduleQuery.checkandLoadStudent(reqrollnumbertext,instituteid);
    	  loadscholarshipList =  feesscheduleQuery.loadscholarship(instituteid);
    	  today				= DateTime.showTime("calendar");

    	  standardscheduleid  =(String)session.getValue("standardscheduleid");
    }catch(Exception e){}

    if(feesScheduleList!=null && feesScheduleList.size()>0)
	{
    %>


    <tr><td><td>
     <%
	if(session.getValue("usercategory").equals("P")){%>

	    <table id="rounded-corner" border=0 summary="Department List" width="100%">
					    <thead>
					    	<tr>

					            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.feescollectionparent.StudentDetails")%></th>
					            <th scope="col" class="rounded-q4" width="2%"></th>
					        </tr>
					    </thead>
					    <tr>
					    	<td colspan='2'>

								<%
									out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
									out.print("<tr><td width='17%' class='tablebold'>"+bundle.getString("label.feescollectionparent.StudentName")+"</td><td width='1%' class='tablebold'>:</td><td>"+session.getValue("studentname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.feescollectionparent.AcademicYear")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
									if(session.getValue("groupname") == null)
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.feescollectionparent.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"</td></tr>");
									else
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.feescollectionparent.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.feescollectionparent.SectionName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sectionname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.feescollectionparent.BoardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("boardname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.feescollectionparent.MediumName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("mediumname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.feescollectionparent.RollNo.")+"</td><td class='tablebold'>:</td><td>"+session.getValue("rollno") + "</td></tr>");

									out.print("</table>");
								%>
							</td>
						</tr>
					</table>
					<br>

   <%}%>

<br>

<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company"><%=bundle.getString("label.feescollectionparent.SL.No") %></th>
        	<th scope="col" class="rounded" ><%=bundle.getString("label.feescollectionparent.TermName") %></th>
        	<th scope="col" class="rounded"><%=bundle.getString("label.feescollectionparent.DueDate") %></th>
        	<th scope="col" class="rounded"><%=bundle.getString("label.feescollectionparent.FeesAmount") %></th>
        	<th scope="col" class="rounded"><%=bundle.getString("label.feescollectionparent.PaidAmount") %></th>
        	<th scope="col" class="rounded"><%=bundle.getString("label.feescollectionparent.PendingAmount") %></th>
        	<th scope="col" class="rounded-q4"><%=bundle.getString("label.feescollectionparent.PaymentType1") %></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=6 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
	     <%
	     //System.out.println("standardscheduleid-->"+standardscheduleid);
	     String paidTermFee="0";
			ArrayList termList =  feesscheduleQuery.loadTermFeesDetails(standardscheduleid);
			HashMap termhashmap =null;
			if(termList != null && termList.size()>0){
				for(int y=0;y<termList.size();y++){
				termhashmap		= (HashMap)termList.get(y);
				String termfeesid  = (String)termhashmap.get("termfeesid");
				String termname  = (String)termhashmap.get("termname");
				String termfeesamount  = (String)termhashmap.get("termfeesamount");
				String duedate  = (String)termhashmap.get("duedate");

				 if(termfeesamount == null)
		    	  {
					 termfeesamount = "0";
		    	  }

		    	    Long lObj2 = Long.valueOf(termfeesamount);
		    	    NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
		    	    formattedCurrency = format.format(lObj2);


		    	  //  totalamounts= Integer.parseInt(termfeesamount);
		    	   // out.println("initial ->"+totalamounts);
		    	   temptotalamount = Integer.parseInt(termfeesamount);
		    	   totalamount +=Integer.parseInt(termfeesamount);


				//out.println("<option value='"+termhashmap.get("termfeesid")+"'>"+termhashmap.get("termname")+"</option>");

				paidTermFee =  feesscheduleQuery.paidTermFeesDetails(termfeesid,(String)session.getValue("studentapprovalid"));
				//System.out.println("termfeesid-->"+termfeesid+"paidTermFee-->"+paidTermFee);
				 if(paidTermFee == null)
		    	  {
					 paidTermFee = "0";
		    	  }

		    	    Long lObj3 = Long.valueOf(paidTermFee);
		    	    NumberFormat paidFormat = NumberFormat.getCurrencyInstance(localcurrency);
		    	    paidformattedCurrency = paidFormat.format(lObj3);


		    	   temptotalPaidamount = Integer.parseInt(paidTermFee);
		    	   totalPaidamount +=Integer.parseInt(paidTermFee);

		    	   totalRemamount = temptotalamount-temptotalPaidamount;

					Long lObjR1 = Long.valueOf(temptotalamount-temptotalPaidamount);
					NumberFormat remFormat = NumberFormat.getCurrencyInstance(localcurrency);
					remformattedCurrency = remFormat.format(lObjR1);

		%>
     <tr>
     <!--  <td><input type=radio name=termcheck value="<%=termfeesid %>" termname="<%=termname %>" onclick="showterm(this)"/></td>-->
      <td><%= (y+1)%></td>
     <td><%= termname%></td>
     <td><%=duedate %></td>
     <td><%= formattedCurrency%></td>
     <td><%= paidformattedCurrency%></td>
     <td><%= remformattedCurrency%></td>
     <%if(totalRemamount>0)
    	 {%>
     <td><a href='#' termfeesid='<%=termfeesid %>' termpendingamount='<%=totalRemamount%>' onclick="paymentgateway(this)">Online Payment</a></td>
		<%}else
			{%>
			<td><a href='#' termfeesid='<%=termfeesid %>'  onclick="PaymentRecepit(this)">Paid</a></td>
			<%} %>
     </tr>
     <%


				}
			}
			 	Long lObj21 = Long.valueOf(totalamount);
	    	    NumberFormat format1 = NumberFormat.getCurrencyInstance(localcurrency);
	    	    formattedCurrency1 = format1.format(lObj21);

				Long lObj31 = Long.valueOf(totalPaidamount);
				NumberFormat paidFormat1 = NumberFormat.getCurrencyInstance(localcurrency);
				paidformattedCurrency1 = paidFormat1.format(lObj31);

				Long lObjR2 = Long.valueOf(totalamount-totalPaidamount);
				NumberFormat remFormat1 = NumberFormat.getCurrencyInstance(localcurrency);
				remformattedCurrency1 = remFormat1.format(lObjR2);
	}
     %>
     <tr><td></td><td class=tablebold>Total</td><td>&nbsp;</td><td><%= formattedCurrency1 %></td><td><%= paidformattedCurrency1 %></td><td colspan=2><%= remformattedCurrency1 %></td>
     </tbody>
     </table>
	<input type='hidden' name='todaydate' value='<%=today %>'/>
	<input type=hidden name="studentapprovalid" value="<%=session.getValue("studentapprovalid")%>"/>
	<input type=hidden name="reqrollnumbertext" value="<%=reqrollnumbertext%>"/>
	<input type=hidden name="amount1" value=""/>
	<input type=hidden name="termfeesid" value=""/>
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>



</div>
</body>
</html>