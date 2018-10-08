  <div class="menu">
 <%
 
	 String loginusercategory 		= null;
	 String headerinstituteid 		= null;
	 java.util.ArrayList hflahList 	= null;
 
 try{
	 
 	if(session.getValue("userid") == null)
 	{
 		out.println("<script>location.replace("+request.getContextPath()+"/kycsessionexpire.jsp)</script>");
 	}
 	else
 	{
 		com.iGrandee.FlashNews.FlashNewsEntry flashquery = new com.iGrandee.FlashNews.FlashNewsEntry();
 		loginusercategory 	= (String)session.getValue("usercategory");
 		headerinstituteid 	= (String)session.getValue("instituteid");
 		hflahList 			= flashquery.loadActiveFlashNews(headerinstituteid);
 	}
 %>
 <%
 if(loginusercategory != null && loginusercategory.equals("SA"))
 {
 %>
     <ul>
          <li><a class="current" href="<%=request.getContextPath()%>/jsp/kycpanel/Homepage.jsp">Admin Home</a></li>
          <li><a href="<%=request.getContextPath() %>/jsp/ExamManagement/ExamHome.jsp" title="">Question Entry</a></li>
          <li><a href="<%=request.getContextPath() %>/jsp/ExamManagement/QuestionEntryExcel.jsp" title="">Bulk Question Entry</a></li>
          <li><a href="<%=request.getContextPath() %>/jsp/ExamManagement/QuestionPreparation.jsp" title="">Template Preparation</a></li>
          <li><a href="<%=request.getContextPath() %>/jsp/ExamManagement/QuestionApprove.jsp" title="">Template Approval</a></li>
          <li><a href="<%=request.getContextPath() %>/jsp/ExamManagement/QuestionGeneration.jsp" title="">Question Generation</a></li>
          <li><a href="<%=request.getContextPath() %>/jsp/ExamManagement/AssignOnlineExam.jsp" title="">Online Exam</a></li>
     </ul>
	<%}
 }catch(Exception e){} 
	
  %></div>
  <div>
  
  <MARQUEE width=100% BEHAVIOR=SCROLL BGColor="gray" scrollamount=2 scrolldelay='2' class=tablelight onmouseover="this.stop();" onmouseout="this.start();"><font color=white>
  
  <%
  
  StringBuffer strbuf=new StringBuffer();
  	if(hflahList!=null && hflahList.size()>0)
	 	for (int i = 0; i < hflahList.size(); i++) {
 		
			java.util.HashMap hflahListMap=(java.util.HashMap)hflahList.get(i);
			strbuf.append(hflahListMap.get("flashmessage"));
		
	 	}
  out.print(strbuf.toString());
  %>
 </font></MARQUEE>
  </div>
  