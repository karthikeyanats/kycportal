<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.iGrandee.TransportFees.FeesSettingsAction"%>
<%@page language="java" import="java.util.ResourceBundle"%>
<%
	
	ResourceBundle bundle1  = ResourceBundle.getBundle("resources.ApplicationResources");

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>Know Your Child - <%=bundle1.getString("label.studentfeescollection.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">


	function addStagetostudent()
	{
		
		if(check_ForParticularElements(document.feescollectionform.routename,"select",document.feescollectionform.stagename,"select"))
		{
			document.feescollectionform.action="StudentstageSubmit.jsp";
			document.feescollectionform.submit();
		}	
	}
	
	function selectFun()
	{
		alert("Calling");
		var stageid = document.feescollectionform.chkname.value;
		//alert("stageid===>>"+stageid);
	}
		

	function SelectRouteStage()
	{
		
		document.feescollectionform.reqrollnumbertext.value = document.feescollectionform.reqrollnumbertext.value;
		//alert("reqrollnumbertext===>>>"+document.feescollectionform.reqrollnumbertext.value);
		
		document.feescollectionform.routeid.value  = document.feescollectionform.routename.options[document.feescollectionform.routename.options.selectedIndex].value
		//alert("routeid===>>>"+document.feescollectionform.routeid.value);
		document.feescollectionform.action="StageFeesStudentinfo.jsp?routeid="+document.feescollectionform.routeid.value+"&rollnumbertext="+document.feescollectionform.reqrollnumbertext.value;
		document.feescollectionform.submit();
	
	}

	function checkStatus()
	{
		//alert(document.feescollectionform.routenamename.options[document.ApplicantSearch.routename.options.selectedIndex].value);
		
		document.feescollectionform.reqrollnumbertext.value = document.feescollectionform.reqrollnumbertext.value;
		//alert("reqrollnumbertext===>>>"+document.feescollectionform.reqrollnumbertext.value);
		
		document.feescollectionform.routeid.value  = document.feescollectionform.routename.options[document.feescollectionform.routename.options.selectedIndex].value
		document.feescollectionform.transportstageid.value  = document.feescollectionform.stagename.options[document.feescollectionform.stagename.options.selectedIndex].value;
		
		document.ApplicantSearch.action="StageFeesStudentinfo.jsp?routeid="+document.feescollectionform.routeid.value+"&reqrollnumbertext="+document.feescollectionform.reqrollnumbertext.value;
		document.ApplicantSearch.submit();
	
	}
	
	function ChangeRoute()
	{
		document.feescollectionform.action="StudentStageView.jsp";
		document.feescollectionform.submit();
		
	}
	
	
	function CloseRoute(obj)
	{
		if(confirm("Do you want to closed the stage?"))
		{
			var stuid = obj.getAttribute("stuid");
			
			document.feescollectionform.action="StudentStageCloseView.jsp?stuid="+stuid;
			document.feescollectionform.submit();
		}
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

    <h2>Transport Fees/Student Stage Allocation</h2>
<form name="feescollectionform" action="" method="post">
  <%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,java.text.NumberFormat,java.util.Locale"%>

     <%
     
     com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();  
     
    String reqrollnumbertext 				= null;
    String routeids = null;
    if(request.getParameter("routeid")!=null){
    	 routeids=request.getParameter("routeid");
	}
   
    //out.println("routeids===>>>"+routeids);
    
    
	 
	 
    reqrollnumbertext = request.getParameter("reqrollnumbertext");
    //out.println("reqrollnumbertext===>>>"+reqrollnumbertext);
    String userid	 						= "";
    String instituteid 						= null;
    ArrayList studentfeescollectionList 	= null;
    ArrayList feesScheduleList 				= null;
   
    String studentstandard 					= null;
    String studentname 						= null;
    String studentsection 					= null;
    ArrayList loadscholarshipList  			= null; 
    String today							= null;
    String formattedCurrency 				= null;
    String paidformattedCurrency 			= null;
    ResourceBundle bundle 					= 	ResourceBundle.getBundle("resources.serversetup");
	Locale localcurrency 					= new Locale(bundle.getString("language"), bundle.getString("code"));
    String formattedCurrency1 				= null;
     String paidformattedCurrency1 			= null;
     String remformattedCurrency 			= null;
     String remformattedCurrency1 			= null;
     String colformattedCurrency 			= null;
     String studentstageallocationaction = null;
     String schformattedCurrency 			= null;
     String schformattedCurrency1 			= null;
     String transportrouteid  = null;
     String transportstageid = null; 
     String studentstageallocationid = null;
     String studentstageallocationlogid = null;
     String transportstagename = null;
     String routename = null;
     String studentstageallocationstatus = null;
    
     float totalamount 						= 0f;
     float totalPaidamount 					= 0f;
     float temptotalamount 					= 0f;
     float temptotalPaidamount 				= 0f;
     
     int count								= 0;

     String studentapprovalid 				= null;
     
     try
     {
    	  instituteid = (String)session.getAttribute("instituteid");
    	//  out.println("instituteid"+instituteid);
    	  reqrollnumbertext=request.getParameter("rollnumbertext");
    	  //out.println("reqrollnumbertext===>>>"+reqrollnumbertext);
    	  feesScheduleList = feesscheduleQuery.checkandLoadStudent(reqrollnumbertext,instituteid);
    	  loadscholarshipList =  feesscheduleQuery.loadscholarship(instituteid);
    	  today				= DateTime.showTime("calendar"); 
    	  
    	
    }catch(Exception e){
    	
    	e.printStackTrace();
    	
    }
    
    if(feesScheduleList!=null && feesScheduleList.size()>0)
	{
    %>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="90%"><%=bundle1.getString("label.studentfeescollection.StudentInformation")%></th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>
            
        </tr> 
    </thead>
   <!--  <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot> -->
     <tbody>
   
    <tr><td colspan=2><table id="rounded-corner1" width="100%">
    	<tr>
    	<td>
	    	<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center">
	    	<%
	    	String standardscheduleid     = null;
	    	String studsessionname =null;
	    	String studsessionid =null;
	    	if(feesScheduleList!=null && feesScheduleList.size()>0)
	    	{ int inc = 1;
	//standardscheduleid, sectionscheduleid, studentallocationid, sectionname, standardname, groupname, boardname,
	//mediumname, firstname, middlename, lastname, emailid, imagepath, prefix,studentapprovalid   		 		
	    		HashMap feesScheduleListMap=(HashMap)feesScheduleList.get(0);
	    		
	    		standardscheduleid     = (String)feesScheduleListMap.get("standardscheduleid");
	    		
   		
	    		String studentstandardname      = (String)feesScheduleListMap.get("standardname");
	    		String sectionscheduleid     = (String)feesScheduleListMap.get("sectionscheduleid");
	    		String studentsectionname      = (String)feesScheduleListMap.get("sectionname");
	    		String studentallocationid     = (String)feesScheduleListMap.get("studentallocationid");
	    		String studentgroupname      = (String)feesScheduleListMap.get("groupname");
	    		String studentboardname     = (String)feesScheduleListMap.get("boardname");
	    		String mediumname      = (String)feesScheduleListMap.get("mediumname");
	    		String firstname      = (String)feesScheduleListMap.get("firstname");
	    		String middlename      = (String)feesScheduleListMap.get("middlename");
	    		String lastname      = (String)feesScheduleListMap.get("lastname");
	    		String emailid      = (String)feesScheduleListMap.get("emailid");
	    		String imagepath      = (String)feesScheduleListMap.get("imagepath");
	    		String studprefix      = (String)feesScheduleListMap.get("prefix");
	    		studentapprovalid      = (String)feesScheduleListMap.get("studentapprovalid");
	    		studsessionname      = (String)feesScheduleListMap.get("sessionname");
	    		studsessionid      = (String)feesScheduleListMap.get("sessionid");
	    		
	    		if(middlename==null || middlename.equals("") ||  middlename.equals("-"))
	    		studentname = studprefix+""+firstname+"&nbsp;"+lastname;
	    		else
	    			studentname = studprefix+""+firstname+"&nbsp;"+middlename+"&nbsp;"+lastname;
	    		
	    		if(studentgroupname ==null || studentgroupname.equals("-"))
	    			studentstandardname = studentstandardname;
	    		else
	    			studentstandardname = studentstandardname+""+studentgroupname;
	    		
	    		userid					= (String)feesScheduleListMap.get("userid");
	    		
	    	%>
	    	
	    	<tr>
	    		<td class=tablebold><%=bundle1.getString("label.studentfeescollection.StudentRollNumber")%></td>
	    		<td class=tablebold>:</td><td><%=reqrollnumbertext %></td>
	    		<td class=tablebold><%=bundle1.getString("label.studentfeescollection.StudentName")%></td>
	    		<td class=tablebold>:</td><td><%=studentname %></td>
	    		<td  rowspan=2 valign=top><img src='<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=imagepath %>' width=60 height=47></td>
	    		</tr>
	    	<tr>
	    		<td class=tablebold><%=bundle1.getString("label.studentfeescollection.Standard")%></td>
	    		<td class=tablebold>:</td><td><%=studentstandardname%></td>
	    		<td class=tablebold><%=bundle1.getString("label.studentfeescollection.Section")%></td>
	    		<td class=tablebold>:</td><td><%=studentsectionname%></td>
	    		</tr>
	    	<tr> 
	    	<td class=tablebold>Session Name </td><td class=tablebold>:</td>
	    	<td colspan=3><%=studsessionname %></td>
	    	</tr>
	    	<%
		    }else
		    	{
			    	
		    		out.print("<tr align='center' class='tablebold'><td colspan='2'><font color='red'>Data Not Found</font></td></tr>");
			    	
		    	}%>	 
	       </tr>
	       
	       
	       </table>
	    </td>
	    </tr>
    </table>
    <br>
    </br>
    </td></tr>
    
 
    
    </tbody>
</table>

<br><br><br>
 
<%
	       		FeesSettingsAction  stageallot = new FeesSettingsAction(); 
	       		String getstudentapprovalid = stageallot.getid(studentapprovalid); 
	       		//System.out.println("getstudentapprovalid==>>"+getstudentapprovalid);
	       		//System.out.println("studentapprovalid==>>"+studentapprovalid);
	       		if(getstudentapprovalid != null)
	       		{
	       			
	       		}else
	       		{	
	       		%>
	       		
 <table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
  <thead>
    	
        <tr>
        	<th scope="col" class="rounded-company" colspan="3">Stage Allocation</th>
        	<th scope="col" class="rounded-q4"></th>
        	
        </tr>
    </thead>	<tr>
	       	<td class=tablebold>
	       		Route:
	       	</td>
	       	<td>
	       		<select name="routename" validate="Route Name" onChange="SelectRouteStage()"> 
	       		<option value='' selected> - Select Route Name - </option>
	       		 <%
			     FeesSettingsAction  stageforamounallotment = new FeesSettingsAction();
			     instituteid = null;
			     ArrayList Loadstageforamounallotment = null;
				     try
				     {
				    	  instituteid = (String)session.getValue("instituteid"); 
				    	//  out.println("instituteid===>>"+instituteid);
				    	  Loadstageforamounallotment = stageforamounallotment.getrouteforstu(instituteid);
				    	  //out.println("Loadstageforamounallotment==>>"+Loadstageforamounallotment);	
					    	  ArrayList archivalDetails = new ArrayList();
					    	  if(Loadstageforamounallotment!=null && Loadstageforamounallotment.size()>0)
								{
					    		 for (int i = 0, j = 1; i < Loadstageforamounallotment.size(); i++) {
								
									HashMap SessionListMap=(HashMap)Loadstageforamounallotment.get(i);
									
									transportrouteid        = (String)SessionListMap.get("transportrouteid");
									routename   	= (String)SessionListMap.get("routename");  
									//out.println("transportrouteid==>>"+transportrouteid);
		 
								%> 					
								
					       				
															       		
					       				<%-- <option value="<%=transportrouteid%>"><%=routename %></option> --%>
					       				
					       				<%
										if(routeids != null && routeids.equals(transportrouteid))
										{	
										%>
					       				<option value="<%=transportrouteid%>" selected><%=routename %></option>
					       				<%
										}else
										{	
										%>
											<option value="<%=transportrouteid%>"><%=routename %></option>
										<%	
										}
					       				%>
					       				
					       				
					       		
												 
								<%					  
								
						    		 }					    		 
					    		 		
									}else
									{
										%>
											<td>Data not found</td>
										<%
									}
			     }catch(Exception e){}
			          
			     %>
	       		
	       		
	       		</select>
	       		
	       		
	       	</td>
	       	
	       	<td class=tablebold>
	       		Stage:
	       	</td>
	       		<td>
	       		<select name="stagename" validate="Stage Name">
	       		<option value='' selected> - Select Stage Name - </option>
	       		 <%
			     FeesSettingsAction  stageallotment = new FeesSettingsAction();
			    instituteid = null;
			     ArrayList Loadstageallotment = null;
				     try
				     {
				    	  instituteid = (String)session.getValue("instituteid"); 
				    	  //out.println("instituteid===>>"+instituteid);
				    	 
				    	//  Loadstageallotment = stageallotment.getstageforamounallotment(routeids,instituteid); 
				    	  Loadstageallotment = stageallotment.loadStageforRoute(routeids);
 
					    	  ArrayList archivalDetails = new ArrayList();
					    	  if(Loadstageallotment!=null && Loadstageallotment.size()>0)
								{
					    		 for (int i = 0, j = 1; i < Loadstageallotment.size(); i++) { 
								
									HashMap SessionMap=(HashMap)Loadstageallotment.get(i);
									
									transportstageid        = (String)SessionMap.get("transportstageid");
									transportstagename   	= (String)SessionMap.get("transportstagename"); 
											 
				%>  
				
				
	       					<option value="<%=transportstageid%>"><%=transportstagename %></option>
	       		
								 
				<%					  
								
						    		 }					    		 
					    		 		
									}
			     }catch(Exception e){}
			          
			     %>
	       		
	       		
	       		</select>
	       		
	       		
	       	</td>	       	
	       </tr>  
	       
	       <tr>
	             
	       
	       	<td align="right" colspan="4">
	       			       		
	       		<a href="#" onClick="addStagetostudent()" class="bt_green"><span class="bt_green_lft"></span><strong>Allocate</strong><span class="bt_green_r"></span></a>
	       			       		
	       	</td>
	       
	       </tr>
	         
</table>

<%
	       		} 
	}
%>

<br><br><br>
<%
FeesSettingsAction  exroutestage = new FeesSettingsAction();
ArrayList Loadexroutestage = null;
Loadexroutestage = exroutestage.getexdtageroute(studentapprovalid);
//out.println("Loadexroutestage==>>>"+Loadexroutestage);
if(Loadexroutestage.size() > 0)
{	
%>
<h3>Allocated stages</h3>
<table id="rounded-corner" border=0 summary="selectd Information" align=center width="100%">
    <thead>
    	
        <tr>
        	<th scope="col" class="rounded-company">Sl.No</th>
        	<th scope="col" class="rounded">Route Name</th>
        	<th scope="col" class="rounded">Stage Name</th>
        	<th scope="col" class="rounded">Status</th>  
        	<th scope="col" class="rounded-q4">Action</th>          	
       </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=4 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
    
      <%
			    
			    instituteid = null;
			     
				     try
				     {
				    	  instituteid = (String)session.getValue("instituteid"); 
				    	  //out.println("instituteid===>>"+instituteid);
				    	  
				    	 // out.println("Loadexroutestage===>>"+Loadexroutestage);

					    	  ArrayList archivalDetails2 = new ArrayList();
					    	  if(Loadexroutestage!=null && Loadexroutestage.size()>0)
								{
					    		 for (int k = 0, l = 1; k < Loadexroutestage.size(); k++) {  
								
									HashMap StageMap=(HashMap)Loadexroutestage.get(k);
									
									transportstageid       = (String)StageMap.get("transportstageid"); 
									transportstagename     = (String)StageMap.get("transportstagename"); 
									transportrouteid       = (String)StageMap.get("transportrouteid");
									//out.println("transportrouteid===>>>"+transportrouteid);
									routename              = (String)StageMap.get("routename"); 
									studentstageallocationid = (String)StageMap.get("studentstageallocationid");
									studentstageallocationlogid = (String)StageMap.get("studentstageallocationlogid");
									studentstageallocationaction = (String)StageMap.get("studentstageallocationaction");
									studentstageallocationstatus = (String)StageMap.get("studentstageallocationstatus");
									//out.println("studentstageallocationstatus===>>"+studentstageallocationstatus);
									//out.println("studentstageallocationlogid===>>"+studentstageallocationlogid);
											 
				%>  
				
						
							 <tr>
							<td><%=l++ %>.</td>
						     <td><%=routename %></td>
						     <td><%=transportstagename %></td>
						     <td>
						     	<%=studentstageallocationaction %>
						     </td>
						     <td>
						     	<%
						     	if(studentstageallocationaction.equals("Created"))
						     	{
						     	%>
						     	<a href="#" stuid=<%=studentstageallocationid %> onClick="CloseRoute(this)" style="text-decoration:none;cursor:pointer;">Closed</a>
						     	<%
						     	}
						     	else
						     	{
						     	%>
						     	-
						     	<%	 
						     	}
						     	%>
						     </td>
	       					  </tr>
								 
				<%					  
						    		 }					    		 
					    		 		
									}else
									{
										%>
											<td colspan="8" align="center"><font color="red">Data not found</font></td>
										<%
									}
			     }catch(Exception e){}
			          
			     %>
    		
			
			<!-- Close route -->
     
 			<tr>
 				<td colspan="6" align="right">
 				<%if(studentstageallocationaction.equals("Closed")){ %>
 					<a href="#" onClick="ChangeRoute()" class="bt_green"><span class="bt_green_lft"></span><strong>Create Route</strong><span class="bt_green_r"></span></a>
 				<%}else{ %>
 					<a href="#" onClick="ChangeRoute()" class="bt_green"><span class="bt_green_lft"></span><strong>Change Route</strong><span class="bt_green_r"></span></a>
 				<%} %>		
 					
 				</td>
 			</tr>
 			
     </tbody>
     
   <%
}else
{
	//out.println("Sindhu");
}

   %> 
    
     
     
     </table>
<br><br><br>

	
	<a href="./Stagestusearch.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle1.getString("button.studentfeescollection.Back")%></strong><span class="bt_blue_r"></span></a>
      
 
    <input type='hidden' name='pendingamount' 		value=''/>
    <input type=hidden name='termamount' 			value=''/>
   	<input type='hidden' name='radioname' 			value=''/>
	<input type='hidden' name='todaydate' 			value='<%=today%>'/>
	<input type='hidden' name="studentapprovalid" 	value="<%=studentapprovalid %>"/>
	<input type='hidden' name="reqrollnumbertext" 	value="<%=reqrollnumbertext%>"/>
	<input type=hidden name="stageid" 	value="<%=transportstageid %>" />
	<input type=hidden name="existingstageid" 	value="<%=transportstageid %>" />
	<input type='hidden' name="routeid" 	value="<%=transportrouteid%>"/> 
	<input type='hidden' name="stageidname" 	value="<%=transportstagename %>"/>
	<input type='hidden' name="routeidname" 	value="<%=routename%>"/>
	<input type='hidden' name="studentstageallocationid" 	value="<%=studentstageallocationid%>"/>
	<input type='hidden' name="studentstageallocationlogid" 	value="<%=studentstageallocationlogid%>"/> 
	<input type='hidden' name="studentstageallocationstatus" 	value="<%=studentstageallocationstatus%>"/> 
	<input type='hidden' name="studentstageallocationaction" 	value="<%=studentstageallocationaction%>"/>
	
	
	<input type='hidden' name="termcheck" 			disabled />
	<input type='hidden' name="bankname" 			disabled />
	<input type='hidden' name="ddnumber" 			disabled />
	<input type='hidden' name="dddate" 				disabled />
	<input type='hidden' name="ddamount" 			disabled />
	<input type='hidden' name="paymenttype" 		disabled />
	<input type='hidden' name="scholarshiptype" 	disabled />
	<input type='hidden' name="feecollections" 		disabled />
	
	
	
	
	
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->
 



    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>