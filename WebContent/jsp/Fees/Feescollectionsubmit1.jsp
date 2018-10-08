
 <%

 com.iGrandee.Fees.FeesCollectionQuery  feesCollectionQuery = new com.iGrandee.Fees.FeesCollectionQuery();
 com.iGrandee.Fees.FeesCollectionBean feesCollectionBean = new com.iGrandee.Fees.FeesCollectionBean();

 String instituteid = null;
 String reqrollnumbertext = null;
 String[] bankname;
 String[] ddnumber;
 String[] dddate;
 String[] feesamount;
 String[] paymenttype;
 String termfeesid = null;
 String userid = null;
 String studentapprovalid = null;
 int rows = 0;
 String return_file = "";
 String op="";
 String message = "";
 String termname = "";
 String termamount = "";
 String paymenttype1 = "";


 try
     {
    	  termamount=request.getParameter("amount2");
		 // System.out.println("termamount>>>>"+termamount);

    	  termfeesid=request.getParameter("termfeesid");
    	//  System.out.println("termfeesid>>>>"+termfeesid);
    		if(termamount!=null && !termamount.equals(""))
    		{
    			feesCollectionBean.setTermfeesid(termfeesid);
        	  	feesCollectionBean.setStudentapprovalid(session.getValue("studentapprovalid")+"");
	    	  	feesCollectionBean.setCollectionamount(termamount);
	    	  	feesCollectionBean.setBankname("");
	    	  	feesCollectionBean.setDdno("");
	    	  	feesCollectionBean.setDddate(null);
	    	  	feesCollectionBean.setScholarshipid(null); 
	    	  	feesCollectionBean.setCreatedby(session.getValue("parentid")+"");
	    	  	feesCollectionBean.setPaymenttype("Online");
	    	  	rows=feesCollectionQuery.insertFeesCollection(feesCollectionBean);
    		}
    	  if(rows >0)
			{
				message = "Fees Collection successfully Inserted";
				out.println("<script>window.open('PrintPreviewFeesCollectionFromParent.jsp?studentapprovalid="+studentapprovalid+"&rows="+rows+"&termfeesid="+termfeesid+"&termamount="+termamount+"','Msg','top=250,left=350,help:no,center:no,status:no,width=650,height=600,scrollbars=1;')</script>");
			}else{
				message = "Fees Collection Insertion failure";
			}

    	  return_file =  request.getContextPath()+"/jsp/Fees/FeesCollectionFromParent.jsp";

    }catch(Exception e){}

%>
<html>
<head>
<script language="javascript">
function loadResult()
{
	document.feescollectionsubmitform.target="_top"
	document.feescollectionsubmitform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.feescollectionsubmitform.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="feescollectionsubmitform" action="" method="post">
<input type="hidden" name="result" value="<%=rows %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="rollnumbertext" value="<%=reqrollnumbertext%>">
<input type="hidden" name="message" value="<%=message%>">

</form>
</body>
</html>
