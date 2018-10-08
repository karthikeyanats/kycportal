    <%
    
    String userfullname 	= null;  
    String usercategory 	= null;
    String institutename 	= null;
    String prefix 			= null;
    String institutelogo 	= null;
    String userrolename 	= null;
    
    try{
    //	session.setMaxInactiveInterval(20);
    	
    	//System.out.println("session"+session.getValue("userid"));
    	if(session.getValue("userid") == null){
    		response.sendRedirect(request.getContextPath()+"/kycsessionexpire.jsp");     
    	}
    	
	    userfullname 	= (String)session.getValue("userfullname");
	    usercategory 	= (String)session.getValue("usercategory");
	    institutename 	= (String)session.getValue("institutename");
	    institutelogo 	= (String)session.getValue("institutelogo");
	    userrolename 	= (String)session.getValue("userrolename");
	    prefix 			= (String)session.getValue("prefix");
	    
	    if(usercategory !=null && usercategory.equals("SA"))
	    	usercategory = "School Admin";
	    		
	    
    }catch(Exception e){

    	response.sendRedirect(request.getContextPath()+"/kycsessionexpire.jsp");
    	
    }
    %>
<%--         <div class="logo"><h2><font color="white"><img src="<%=request.getContextPath()%>/OpenDocument?r1=path&r2=<%=institutelogo %>" alt="" title="" border="0"  width="70" height="65"/> <%=institutename %></font></h2></div>
 --%>
   <div class="logo"><img src="<%=request.getContextPath()%>/OpenDocument?r1=path&r2=<%=institutelogo %>" alt="" title="" border="0"  width="70" height="65"/><a class=tableboldheader><font color="white"> <%=institutename %></font></a></div>
         <div class="kyc_logo"></div>
        <div class="right_header">Welcome <%=prefix%> <%=userfullname %>, | Role : <%=userrolename %> | <a href="<%=request.getContextPath() %>/Logout.jsp" class="logout">Logout</a></div>
<div id="clock_a"></div>