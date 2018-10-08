<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Payment Gateway</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script>
function submitfees()
{
if(confirm("Do you want to proceed...?"))
{
	document.formName.action="https://test.authorize.net/gateway/transact.dll";
	document.formName.submit();
}
}
function backfun()
{
	document.formName.target="_top"
	document.formName.action="../jsp/Fees/FeesCollectionFromParent.jsp";
	document.formName.submit();
}
</script>
</head>
<body style="background-image:none;background-color:white;">
    <h2>Fees / Online Payment /Selected Information</h2>
<%@ page import="net.authorize.sim.*" %>
<%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,java.text.NumberFormat,java.util.Locale"%>

<%

System.out.println("approval id "+(String)session.getValue("studentapprovalid"));
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
        String apiLoginId = "59LM95ap7e";
        String transactionKey = "7J77P3C7Rt4bPyeu";

        //String amount = "1.99";
        String amount=request.getParameter("amount1");
        String termfeesid=request.getParameter("termfeesid");
String studapprovalid= (String)session.getValue("studentapprovalid");

        //out.println(amount);
        //String returnurl = "http://182.72.101.50:8092"+"request.getContextPath()+"/jsp/Fees/Feescollectionsubmit1.jsp?amount2="+amount+"&termfeesid="+termfeesid;
        String returnurl = "http://"+bundle1.getString("label.paymentgateway.ipaddress")+":"+bundle1.getString("label.paymentgateway.port")+request.getContextPath()+"/jsp/Fees/Feescollectionsubmit1.jsp?amount2="+amount+"&termfeesid="+termfeesid+"&studentappid"+studapprovalid;
       // System.out.print("returnurl>>>>>"+returnurl);
        Fingerprint fingerprint = Fingerprint.createFingerprint(
            apiLoginId,
            transactionKey,
            1234567890, // random sequence used for creating the finger print

            amount);
        long x_fp_sequence = fingerprint.getSequence();
        long x_fp_timestamp = fingerprint.getTimeStamp();
        String x_fp_hash = fingerprint.getFingerprintHash();
%>

  <FORM NAME='formName' ID='formID' ACTION=''
    METHOD='POST'>
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
									out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'  class='tablelight'>");
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
   <table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company"><%=bundle.getString("label.feescollectionparent.SL.No") %></th>
        	<th scope="col" class="rounded" ><%=bundle.getString("label.feescollectionparent.TermName") %></th>
        	<th scope="col" class="rounded"><%=bundle.getString("label.feescollectionparent.DueDate") %></th>
        	<th scope="col" class="rounded"><%=bundle.getString("label.feescollectionparent.FeesAmount") %></th>
        	<th scope="col" class="rounded"><%=bundle.getString("label.feescollectionparent.PaidAmount") %></th>
        	<th scope="col" class="rounded"><%=bundle.getString("label.feescollectionparent.PendingAmount") %></th>
        	<th scope="col" class="rounded-q4"><%=bundle.getString("label.feescollectionparent.PayNow") %></th>
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
			ArrayList termList =  feesscheduleQuery.loadTermFeesDetailsForSelectedTermfeesid(session.getValue("standardscheduleid")+"",termfeesid,session.getValue("studentapprovalid")+"");
			HashMap termhashmap =null;
			if(termList != null && termList.size()>0){
				for(int y=0;y<termList.size();y++){
				termhashmap		= (HashMap)termList.get(y);
				String innertermfeesid  = (String)termhashmap.get("termfeesid");
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
     <!--  <td><input type=radio name=termcheck value="<%=studapprovalid%>$$<%=termfeesid %>" termname="<%=termname %>" onclick="showterm(this)"/></td>-->
      <td><%= (y+1)%></td>
     <td><%= termname%></td>
     <td><%=duedate %></td>
     <td><%= formattedCurrency%></td>
     <td><%= paidformattedCurrency%></td>
     <td><%= remformattedCurrency%></td>
     <td><a href='#' onclick="submitfees()">Pay Now</a></td>
	 </tr>
     <%
				}
			}
			 	
     %>
     </tbody>
     </table>
    <INPUT TYPE='HIDDEN' NAME='x_login'VALUE='<%=apiLoginId%>'>
    <INPUT TYPE='HIDDEN' NAME='x_fp_sequence' VALUE='<%=x_fp_sequence%>'>
    <INPUT TYPE='HIDDEN' NAME='x_fp_timestamp' VALUE='<%=x_fp_timestamp%>'>
    <INPUT TYPE='HIDDEN' NAME='x_fp_hash' VALUE='<%=x_fp_hash%>'>
    <INPUT TYPE='HIDDEN' NAME='x_version' VALUE='3.1'>
    <INPUT TYPE='HIDDEN' NAME='x_method' VALUE='CC'>
    <INPUT TYPE='HIDDEN' NAME='x_type' VALUE='AUTH_CAPTURE'>
    <INPUT TYPE='HIDDEN'   NAME='x_amount' VALUE='<%=amount%>'>
    <INPUT TYPE='HIDDEN' NAME='x_show_form' VALUE='payment_form'>
    <INPUT TYPE='HIDDEN' NAME='x_test_request' VALUE='FALSE'>
    <INPUT TYPE=HIDDEN NAME="x_receipt_link_method" VALUE="LINK">
	<INPUT TYPE=HIDDEN NAME="x_receipt_link_text" VALUE="Click here to return to
	our home page">
	<INPUT TYPE=HIDDEN NAME="x_receipt_link_URL" VALUE='<%=returnurl%>'>

<INPUT TYPE=HIDDEN NAME="x_header_html_payment_form"
VALUE="<style type='text/css' media='all'>

TD{font-family: arial, verdana,trebuchet,helvetica,geneva,sans-serif;fontsize:
11px; color:#000000;margin-left:1px;}
INPUT{font-family:Arial,Verdana, Trebuchet,Helvetica,Geneva,sans-serif;fontsize:
11px;color: #000000;margin-left:1px;}</style>
<h3>Virtual KYC Portal Payment Gateway</h3>">

  </FORM>

</body>
</html>