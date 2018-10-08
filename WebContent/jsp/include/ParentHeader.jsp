  <div class="menu">
 <%
 String loginusercategory = null;
 String headerinstituteid = null;
 java.util.ArrayList hflahList = null;
 try
 {
 	if(session.getValue("userid") == null)
 	{
 		//System.out.println("ASDFWERWERWERWERW");
 		out.println("<script>location.replace("+request.getContextPath()+"/kycsessionexpire.jsp)</script>");
 		//response.sendRedirect(request.getContextPath()+"/kycsessionexpire.jsp");
 		//System.out.println("ASDFWERWERWERWERWa fter");
 	}
 	else
 	{
 		com.iGrandee.FlashNews.FlashNewsEntry flashquery = new com.iGrandee.FlashNews.FlashNewsEntry();
 		loginusercategory = (String)session.getValue("usercategory");
 		headerinstituteid = (String)session.getValue("instituteid");
 		hflahList = flashquery.loadActiveFlashNews(headerinstituteid);
 	}
 //}catch(Exception e){response.sendRedirect(request.getContextPath()+"/kycsessionexpire.jsp");}
 %>
 
	 <ul>
                  <li><a class="current" href="../Parent/ParentHome.jsp">Parent Home</a></li>
                  <!--[if lte IE 6]><table><tr><td><![endif]-->
                   <li><a href="../Parent/changepasswd.jsp">Change Password</a></li>
                        
                      <!--[if lte IE 6]></td></tr></table></a><![endif]-->
	</ul>	
	
		<%
 }catch(Exception e){} %>
	
  </div>
  <div>
  <%
StringBuffer strBuf  = new StringBuffer();
  if(hflahList!=null && hflahList.size()>0)
	{
	 	for (int i = 0; i < hflahList.size(); i++) {
	
		java.util.HashMap hflahListMap=(java.util.HashMap)hflahList.get(i);
	
		strBuf.append(hflahListMap.get("flashmessage")+"  * ");
	 	}
	}
  %>
 <MARQUEE width=100% BEHAVIOR=SCROLL BGColor="gray" scrollamount=2 scrolldelay='2' class=tablelight onmouseover="this.stop();" onmouseout="this.start();"><font color=white>* <%=strBuf.toString() %>  *</font></MARQUEE> 
  </div>
  