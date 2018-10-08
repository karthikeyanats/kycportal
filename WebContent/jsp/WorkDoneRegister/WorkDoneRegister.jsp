<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.workdoneregister.viewtitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language='javascript'>

	function changeSession()
	{
		
		if(check_ForParticularElements(document.wprkallotment.session,"select"))
		{
			document.wprkallotment.submit();
		}
	}
	
	function changeStandard(){
		
			document.wprkallotment.standardscheduleid.value	= document.wprkallotment.standard.options[document.wprkallotment.standard.options.selectedIndex].value;
			document.wprkallotment.submit();  
	}	
	
	function changeSubject(obj){
		var subjectscheduleid=obj.getAttribute("subjectscheduleid");
				var sunjnam=obj.getAttribute("sunjnam");
				document.wprkallotment.subjectsss.value=subjectscheduleid;
				document.wprkallotment.subjectname.value=sunjnam;
					document.wprkallotment.submit();
		
	
	}	

function clicklession(obj)
{				
			document.wprkallotment.standardname.value	= document.wprkallotment.standard.options[document.wprkallotment.standard.options.selectedIndex].text;
			document.wprkallotment.lessonname.value		= obj.getAttribute("lesnam");
			document.wprkallotment.lessonscheduleid.value=obj.getAttribute("lessonscheduleid");
			document.wprkallotment.subjectcode.value=obj.getAttribute("subcode");
			  
document.wprkallotment.action = "WorkDoneReply.jsp";
document.wprkallotment.submit();
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

    <h2><%=bundle.getString("label.workdoneregister.viewrootpath") %></h2>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry"%>
	
<%
String newsessionid =(String)session.getValue("sessionid");
String sessionname=(String)session.getValue("sessionname");
WorkDoneRegisterEntry wallot 		= new WorkDoneRegisterEntry();
	String instituteid 		= (String)session.getValue("instituteid");
	String userid 			= (String)session.getValue("userid");
	
	HashMap	hashmap			= null;
	String sessionid		= request.getParameter("session");
	String sectionid		= request.getParameter("section");
	String standardid		= request.getParameter("standard");
	String lessonid			= request.getParameter("lesson");
	String subjectid		= request.getParameter("subjectsss");
	String subjectname		= request.getParameter("subjectname");
String standardscheduleid=request.getParameter("standardscheduleid");

	ArrayList standardList	= null;
	ArrayList sectionList	= null;
	ArrayList subjectList	= null;
	ArrayList lessonList	= null;
	

	if(newsessionid != null && !newsessionid.equals("") && !newsessionid.equalsIgnoreCase("null"))
	{
		standardList	= wallot.loadStandardForStaff(userid,newsessionid,instituteid); 
		
	}   
	
	//if(standardscheduleid != null && !subjectid.equals("") && standardid != null && !standardid.equals("") && !standardid.equalsIgnoreCase("null")){
		subjectList		= wallot.loadSubjectForStaff(userid,standardscheduleid,subjectid);
	//}          
	
	
%>
	<form name='wprkallotment' method='post'>
							
	<table id="rounded-corner" border=0  width="100%">
	    <thead>
	    	<tr>
	        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.workdoneregister.workdonedetails") %></th>
	            <th scope="col" class="rounded" width="10%"></th>
	            <th scope="col" class="rounded-q4" width="10%%"></th>
	        </tr>
	    </thead>

	    <tr>		
	    	<td colspan='3'>							


				<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=5 cellpadding=0>
					<tr >
						<td  class='tablebold' width='20%'><%=bundle.getString("label.workdoneregister.academicyear") %></td>
						<td  class='tablebold' width='1'>:</td>
						<td  class='tablelight' ><%=sessionname %>
							
				
						</td>   
						
					
					
						<td  class='tablebold' width='20%'><%=bundle.getString("label.workdoneregister.standard") %></td>
						<td  class='tablebold' width='1'>:</td>
						<td  class='tablelight' >
							<select name='standard' validate='Standard' onchange='changeStandard()'>
							<option value='0'>-Select Standard-</option>
							<%
							if(standardList != null && standardList.size()>0){
								for(int y=0;y<standardList.size();y++){
									hashmap		= (HashMap)standardList.get(y);
									String groupname=(String)hashmap.get("groupname");
									String standardname_temp="";
									if(!groupname.equals("NoGroup"))
									{												
										standardname_temp = hashmap.get("standardname")+" - "+groupname; 
									}
									else
									{
										standardname_temp=hashmap.get("standardname")+"";
									}
									if(standardid != null && standardid.equals(""+hashmap.get("standardscheduleid")))
										out.print("<option selected value='"+hashmap.get("standardscheduleid")+"'>"+standardname_temp+"</option>");
									else
										out.print("<option value='"+hashmap.get("standardscheduleid")+"'>"+standardname_temp+"</option>");
								}
							}
							%>											
							</select>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>				
	        <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>												
	<table id="rounded-corner" border=0  width="80%" cellspacing=0 cellpadding=0>
		    
													      <%     
													      String subjectname1		= "";
													      String subjectscheduleid	= "";
													      String subjectscheduleid1	= "";
													      String subjectname2="";
													      String subjectcode1="";
													      if(subjectList != null && subjectList.size()>0)
													      {
			        	
	            
	            
	        	
	    
	    																	out.print("<thead><tr>");	
	    																	out.print("<th scope='col' class='rounded-company' width='10%'>"+bundle.getString("label.workdoneregister.slno")+"</th>");
	    																	out.print("<th scope='col' class='rounded' width='20%'>"+bundle.getString("label.workdoneregister.subject")+"</th>");
	    																	out.print("<th scope='col' class='rounded' width='20%'>"+bundle.getString("label.workdoneregister.subjectcode")+"</th>");

	    																	out.print("<th scope='col' class='rounded' width='20%'>"+bundle.getString("label.workdoneregister.unitname")+"</th>");
	    																	out.print("<th scope='col' class='rounded-q4' width='30%'>"+bundle.getString("label.workdoneregister.description")+"</th>");
	    																	out.print("</tr></thead>");
																			
																			int count = 0;
																for(int y=0,l=1;y<subjectList.size();y++,l++)
																{
																	hashmap				= (HashMap)subjectList.get(y);
																	subjectscheduleid	= (String)hashmap.get("subjectscheduleid");
																
																		
																		if(subjectscheduleid1.equals("") || !subjectscheduleid.equals(subjectscheduleid1))
																    	  {		
																			if(y>0){
																				l=1;
																			}
																			
																		
																			
																			subjectscheduleid1		= subjectscheduleid;
																    	  }
															    	   		out.print("<tr>");
															    	   		
															    	   			 subjectname1=(String)hashmap.get("subjectname");
															    	   			subjectcode1=(String)hashmap.get("subjectcode");
															    	   			 if(!subjectname1.equals(subjectname2))
															    	   			 {
															    	   				count++;
																				out.print("<td class='tablelight'>"+count+"</td><td class='tablelight'>"+hashmap.get("subjectname")+"</td><td class='tablelight'>"+hashmap.get("subjectcode")+"</td>" );
																				subjectname2=(String)hashmap.get("subjectname");
															    	   			 }  
															    	   			 else
															    	   			 {
															    	   				out.print("<td class='tablelight'></td><td class='tablelight'></td><td class='tablelight'></td>" );
															    	   			 }
																		 	out.print("<td class='tablelight' colspan=1><a href='#subject' name='subject' lesnam='"+hashmap.get("lessonname")+"' subcode="+hashmap.get("subjectcode")+" lessonscheduleid='"+hashmap.get("lessonscheduleid")+"' onclick=clicklession(this)>"+hashmap.get("lessonname")+"</a></td>" );
																		 	out.print("<td class='tablelight' colspan=1>"+hashmap.get("lessondescription")+"</td>" );
																		 	out.print("</tr>");
																		 	
																				
																}
																out.print("</table>");
																
															}
													    	
													     else
													     {}  
													 
															%>	
													</td>
													</tr>
															</table>
															</td>
															</tr>  
															
															
													
													
													
													
													
													
													
													
													
													
														
													</table>
													
			     						</td>
			     					</tr>
			     				</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
				<input type='hidden' name='subjectsss' 	value=''>
		
		<input type='hidden' name='standardname' 	value=''>
		<input type='hidden' name='sectionname'		value=''>
		<input type='hidden' name='sessionname' 	value='<%=sessionname %>'>
		<input type='hidden' name='lessonname' 		value=''>
		<input type='hidden' name='subjectname' 	value='<%=subjectname1 %>'>
				<input type='hidden' name='subjectcode' 	value=''>
		
				<input type='hidden' name='lessonscheduleid' 		value=''>
		
		
						<input type='hidden' name='standardscheduleid' 	value=''>
		
	</form>


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>