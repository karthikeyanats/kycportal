<html>
<head>
<script type="text/javascript">

	function loadResult()
	{
		 document.submitlessonform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp"; 
		document.submitlessonform.submit();
	}

</script>
</head>
<body onload=loadResult()>
	<form name="submitlessonform" action="" method="post">
		<%@ page language="java"%>
		<%@ page import="com.iGrandee.Fees.Scholarshipamountallocationbean"%>
		<%@ page import="com.iGrandee.MasterEntries.Standard.StandardQuery"%>
		<%@ page import="com.iGrandee.Common.DateTime"%>
		<%
		
		
		String message			= "";
		int result = 0;
		String return_file		=  "";
		String standardscheduleid = request.getParameter("standard");
		String resultword = "";
		
		
		String scholarshipid = request.getParameter("scholarship");
		String userid = (String)session.getAttribute("userid");
		String academicyear = request.getParameter("academicyear");
		Scholarshipamountallocationbean gen_qu = new Scholarshipamountallocationbean();
		StandardQuery gen_query = new StandardQuery();
		//out.println("-->"+request.getParameter("actionstate"));
	//	try
		//{  
			
			if (request.getParameter("actionstate") != null && request.getParameter("actionstate").equals("allocate")) 
			{
				String[] termfeesid = request.getParameterValues("termfeesid"); 
				String[] amount = request.getParameterValues("amount");
				String[] allocatechk = request.getParameterValues("allocatechk");
				
				
				 if(allocatechk!=null && allocatechk.length!=0)
				{
	
					//System.out.println("amount.length ===>"+amount.length);		
					
			 		for(int i=0;i<allocatechk.length;i++) 
					{
			 			if(!allocatechk[i].equals("") && !amount[i].equals(""))
			 			{
						//out.println(amount[i]+"__"+standardscheduleid+"__"+scholarshipid+"__"+allocatechk[i]); 
						gen_qu.setStandardscheduleid(standardscheduleid);
						gen_qu.setAmount(amount[i]);
						gen_qu.setScholarshipid(scholarshipid); 
						gen_qu.setTermfeesid(allocatechk[i]); 
						gen_qu.setSetAmountallocationstatus("A");
						gen_qu.setCreatedby(userid);
					//	out.println("gettermfees id -->"+gen_qu.getTermfeesid()); 
				
						result				= gen_query.insertscholarshipallotment(gen_qu);
						}
					}
				} 
				 if (result > 0) {
						resultword = "Scholarship Amount Allottment Successfully";
					} else {
						resultword = "Scholarship Amount Allottment Operation is Failed";
					}
			}
			else if (request.getParameter("actionstate") != null && request.getParameter("actionstate").equals("deallocate")) 
			{
				String[] determfeesid = request.getParameterValues("determfeesid");
				String[] deamount = request.getParameterValues("deamount");
				String[] deallocatechk = request.getParameterValues("deallocatechk");
				String[] scholarshipamountallocationid = request.getParameterValues("scholarshipamountallocationid");

				 if(deallocatechk!=null && deallocatechk.length!=0)
				{
	
					
			 		for(int i1=0;i1<deallocatechk.length;i1++) 
					{
			 			if(!deallocatechk[i1].equals("") && !deamount[i1].equals(""))
			 			{
							//out.println("ned"+deamount[i1]+"__"+standardscheduleid+"__"+scholarshipid+"__"+deallocatechk[i1]+"_"+determfeesid[i1]); 

						gen_qu.setAmount(deamount[i1]);
						gen_qu.setTermfeesid(deallocatechk[i1]); 
						gen_qu.setSetAmountallocationstatus("A");
						gen_qu.setScholarshipamountallocationid(deallocatechk[i1]);
						gen_qu.setTermfeesid(determfeesid[i1]);
						gen_qu.setCreatedby(userid);
						//System.out.println("gettermfees id -->"+gen_qu.getScholarshipamountallocationid()); 
				
						result				= gen_query.updatescholarshipamountallocation(gen_qu);
						}
					}
			 		if (result > 0) {
						resultword = "Scholarship Amount Updated Successfully";
					} else {			

						resultword = "Scholarship Amount Updation Operation is Failed";
					}
				} 
			}
			
		
		
			
	

		

			//return_file = "./Fees/newallottment1.jsp";
			return_file = request.getContextPath()+"/jsp/Fees/newallottment1.jsp";
		//	}catch(Exception e){
			//	e.printStackTrace();
			//	}  
		%>

			<input type="hidden" name="academicyear" 	value="<%=request.getParameter("academicyear")%>">
   			<input type="hidden" name="standard_board" 	value="<%=request.getParameter("standard_board")%>">
   			<input type="hidden" name="scholarship" 	value="<%=request.getParameter("scholarship")%>">
   			<input type="hidden" name="standard" 	value="<%=standardscheduleid%>">
   			
			<input type="hidden" name="result" value="<%=result %>">
			<input type="hidden" name="message" value="<%=resultword%>">
	<input type="hidden" name="returnurl" value="<%=return_file%>">
			
	</form>
</body>
</html>

