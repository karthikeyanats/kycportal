<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.progressreportparent.entrytitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">

function backfun()
{
document.f1.action = "./ProgressReport.jsp";
document.f1.submit(); 
}


</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../../include/userheader.jsp" %>
   
    </div>


    <div class="main_content">


<%@ include file="../../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

   <h2><%=bundle.getString("label.progressreportparent.entryheading1") %></h2>
   <table border=0 cellpadding=3 cellspacing=2 width=100%>
   
   </table>
	<%@ page import="java.util.*"%> 
	<%@ page import="com.iGrandee.Exam.ExamnameEntry"%>

<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Prinicipal.PrinicipalQuery"%>
        <%@ page import="java.util.Collections,java.util.Comparator"%>
    
     <%
 	ArrayList ranksort=new ArrayList();
 	ArrayList rank_array=new ArrayList();

HashMap rankhash=new HashMap();
		StringBuffer head=new StringBuffer();
		String examnameid=request.getParameter("examnameid");
		String examname=request.getParameter("examname");
		String standardscheduleid=session.getValue("standardscheduleid")+"";
		String sectionscheduleid=(String)session.getValue("sectionscheduleid")+"";
		int colspancount=0;
		String applicantName=null;
		String studentallocationid="";
		HashMap subname =new HashMap();
		ArrayList tempList	= new ArrayList();

		String rollNo="";
		String marktaken="";
		
 	
		
		ArrayList registeredList= null;
	    String instituteid = null;
	    
	    try
	    {
	    	instituteid = (String)session.getValue("instituteid");
	    }catch(Exception e){}

		
       %>
      	<%
	ArrayList totalmark_array=new ArrayList();

	
    ArrayList temp_array=new ArrayList();

		ExamnameEntry Examquery = new ExamnameEntry(); 
		HashMap stdmap = null;
		HashMap secmap = null;
 		

 		String studentid=session.getValue("studentid")+"";
		String sectionid="";
		String standardid="";
		String sectionname="";
		String standardname="";
		String name="";
		String sessionid="";
		String groupname="";
       	int count=0;
       	
		String sessionname="";
		String rollnumber = "";
		sectionname = session.getValue("sectionname")+"";
		name=session.getValue("studentname")+"";
		
		
		
		
		
		String[] sessionvalus=session.getValueNames();
		for(int h=0;h<sessionvalus.length;h++)
		{
			//out.println(sessionvalus[h]+"  ");
		}
		registeredList	=	(ArrayList)Examquery.LoadexammarkforStudentList(examnameid,standardscheduleid,sectionscheduleid);
      %>
      
      	<%

	String examallocationid="0";
	String markpublishstatus="P";

	try
	{
	if(registeredList.size()!=0)
	{
		for(int i=0,s=1;i<registeredList.size();i++)
		{
			HashMap map=(HashMap)registeredList.get(i);
			String subjectname=map.get("subjectname")+"";
			examallocationid=map.get("examallotmentid")+"";
			 String markpublishsta=map.get("markpublishstatus")+"";
				if(markpublishsta.equalsIgnoreCase("P"))   
				{
					markpublishstatus="yes";
				}
				
			if(!tempList.contains(subjectname))
			{
				subjectname=subjectname.trim();
				head.append("<th>S"+s+"</th>");
				colspancount++;
				subname.put("S"+s,subjectname);
				tempList.add(subjectname);
				s++;
			}
		}
		for(int i=0,s=1;i<registeredList.size();i++)
		{
			HashMap map=(HashMap)registeredList.get(i);
			String subjectname=map.get("subjectname")+"";
			if(!tempList.contains(subjectname))
			{
				subjectname=subjectname.trim();
				head.append("<th>S"+s+"</th>");
				colspancount++;
				subname.put("S"+s,subjectname);
				tempList.add(subjectname);
				s++;
			}
		}
	}
	
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}

	%>
	<form name="f1" method="post" action="">

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
					    <thead>
					    	<tr>
					        	
					            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.progressreportparent.StudentDetails") %></th>
					            <th scope="col" class="rounded-q4" width="2%"></th>
					        </tr>
					    </thead>
					    <tr>		
					    	<td colspan='2'>					
				
								<%
									out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
									out.print("<tr><td width='17%' class='tablebold'>"+bundle.getString("label.progressreportparent.StudentName")+"</td><td width='1%' class='tablebold'>:</td><td>"+session.getValue("studentname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.progressreportparent.AcademicYear")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
									if(session.getValue("groupname") == null)
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.progressreportparent.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"</td></tr>");
									else
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.progressreportparent.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.progressreportparent.SectionName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sectionname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.progressreportparent.BoardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("boardname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.progressreportparent.MediumName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("mediumname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.progressreportparent.RollNo.")+"</td><td class='tablebold'>:</td><td>"+session.getValue("rollno") + "</td></tr>");

									out.print("</table>");
								%>	
							</td>
						</tr>
					</table>	
					<br>
					

		<br>
		
		<table id="rounded-corner1" border=0 cellpadding=5  width="100%">
    <thead>
    	<tr class=tableheading  >
            <th scope="col" class="rounded" width="30%"  rowspan=2 ><%=bundle.getString("label.progressreportparent.StudentName")%></th>
            <th scope="col" class="rounded" width="20%"  rowspan=2><%=bundle.getString("label.progressreportparent.RollNo.")%></th>
            <th scope="col" class="rounded" width="20%" colspan=<%=colspancount %>><%=bundle.getString("label.progressreportparent.SubjectWiseRank")%></th>
            <th scope="col" class="rounded-q4" width="20%" rowspan=2 colspan=3><%=bundle.getString("label.progressreportparent.ClassRank") %></th>
            <tr  class=tableheading><%=head %>
		     </tr>
		    </thead>
      		<tfoot>
		    	<tr>
		        	<td colspan="<%=(colspancount+3) %>" class="rounded-foot-left"><em></em></td>
		        	<td class="rounded-foot-right" colspan='2'>&nbsp;</td>
		       </tr>
		    </tfoot>
		    <tbody>
			<%
	boolean flag 	= false;
	int count_temp=0;

	%>
	   <tbody>
		    <%
		    ArrayList totalrank=new ArrayList(); 
		    String totalran="";
		    int classrank=0;
			int totalStud=0;
			int theoryexternalmin=0;
		    try{
		    	ArrayList subjectrank=new ArrayList();
		    	HashMap subjectrankhash=new HashMap();
		    	String studentallocationid1="";
		    	HashMap totalrankhash=new HashMap();
			    if(registeredList.size()!=0)
					{
			    	String canid="";
						for(int i=0,s=1;i<registeredList.size();i++)
							{
					    	int total=0;

								HashMap map=(HashMap)registeredList.get(i);
								String candidateid=map.get("candidateregisterid")+"";
								if(!candidateid.equals(canid))
								{  
									
									String innermark="";

									out.print("<tr align='center'>");
									if((map.get("studentallocationid")+"").equals(studentid))
								    {							
										
									out.print("<td align='left'>"+map.get("uname")+"</td>");
									out.print("<td align='left'>"+map.get("rollno")+"</td>");
									for(int i1=0;i1<registeredList.size();i1++)
									{								
								    	
										HashMap map1=(HashMap)registeredList.get(i1);
										String candidateid1=map1.get("candidateregisterid")+"";
										if(candidateid1.equals(candidateid))
										{
											innermark=map1.get("marktaken")+""; 
											int marks=0;
											
											if(!innermark.equals("null") &&  !innermark.equals("A"))       
											{   
												if(map1.get("theoryexternalmin")!=null)
													theoryexternalmin=Integer.parseInt(map1.get("theoryexternalmin")+"");
												
												marks=Integer.parseInt(innermark);
												  
														int rank=1;
														int preMark = 0;
														 subjectrank	=	Examquery.SubjectWiseRank(examnameid,map1.get("subjectscheduleid")+"",standardscheduleid,sectionscheduleid);   
														 for(int k=0;k<subjectrank.size();k++)
															{  
																subjectrankhash=(HashMap)subjectrank.get(k);
																studentallocationid1=subjectrankhash.get("studentallocationid")+"";
																if(k>0)
																{ 
																	if(studentallocationid1.equals(studentid))
																	{  int premark_temp_new=0;
																		String premark_temp=subjectrankhash.get("marktaken")+"";
																		if(!premark_temp.equals("null") &&  !premark_temp.equals("A"))       
																		{ 
																			premark_temp_new=Integer.parseInt(premark_temp);
																		}
																		if(preMark != premark_temp_new)
																		{
																			rank++;
																			out.print("<td align='center'>"+rank+"</font>");
																		}
																		else
																		{
																			out.print("<td align='center'>"+rank+"</font>");
																		}
																	}
																	else
																	{
																		rank++;
																	} 
																}
																else
																{
																	if(studentallocationid1.equals(studentid))
																	{																	
																		out.print("<td align='center'>"+rank+"</font>"); 
																	}
																}
																int mark_temp_new=0;
																String mark_temp=subjectrankhash.get("marktaken")+"";
																if(!mark_temp.equals("null") &&  !mark_temp.equals("A"))
																{
																	mark_temp_new=Integer.parseInt(mark_temp);
																}   
																preMark = mark_temp_new;

															}    

														if(i==0)
														out.print("<input type='hidden' name='examscheduleid' value='"+map1.get("examscheduleid")+"'>");
														out.print("</td>");
												
											}
											else if(innermark.equals("A")) 
											{  
												out.print("<td><font >A</font></td>");

											}    
											else
											{
												out.print("<td><font >"+ bundle.getString("label.progressreportparent.NE")+"</font></td>");
	
											}
											total +=marks;
										}   
									} 
									totalrank	=	Examquery.clasRank(examnameid,standardscheduleid,sectionscheduleid);  
									if(totalrank!=null && totalrank.size()>0)
									{	
										classrank=1;
									int pretotalMark = 0;

										for(int g=0;g<totalrank.size();g++)
										{	
											totalrankhash=(HashMap)totalrank.get(g);
											 totalran=(String)totalrankhash.get("total");
											 if(g>0)
											{
													if((totalrankhash.get("studentallocationid")+"").equals(studentid))
													{
														String total_temp=totalrankhash.get("total")+"";
														int total_temp_new=0;
														if(!total_temp.equals("null") &&  !total_temp.equals("A"))
														{
															total_temp_new=Integer.parseInt(total_temp);
														}
														if(pretotalMark != total_temp_new)
														{		classrank++;
																out.print("<td>"+classrank+"</td>");
														}
														else
														{
																out.print("<td>"+classrank+"</td>");
														} 
													}
													else
													{
														classrank++;
												    }
											}
											 else
											 {
													if((totalrankhash.get("studentallocationid")+"").equals(studentid))
													{  																	
														out.print("<td align='center'>"+classrank+"</font>");
													}
											}
											 String totaltemp=totalrankhash.get("total")+"";
											 int totaltemp_new=0;
											 if(!totaltemp.equals("null") &&  !totaltemp.equals("A"))
											 { 
												 totaltemp_new=Integer.parseInt(totaltemp);
											 } 
											 pretotalMark = totaltemp_new;

										}


									}
									
									out.print("</tr>");
									s++;
								  }
								canid=candidateid;

							}
						
					}
					}
				else
				 {
						  out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");
					  } 
			    }
			    catch(Exception e)
			    {
			    	e.printStackTrace();
			    	System.out.println(e);   
			    }
			    

		  %>
		  
		  
		  </tbody>
      </table>   
      
      <br><br>
 		<a class="tablebold">Note :</a><br>
	<a class=tablebold>	<%
		
		if(subname.size()>0)
		{ 
		for(int sub=1;sub<=subname.size();sub++)
		{
			out.println("S"+sub+" : "+subname.get("S"+sub)+"<br>");
		}
		}
		//out.println("A :<a> Absent </a>");

		%>
		
		</a> 
		      
      <br>  
      <!-- <h2>Comparison With other Students  </h2> -->
	<table id="rounded-corner1"  style="visibility:hidden"  border=0 summary="Department List" width="100%">
    <thead>
    	<tr class=tableheading  >
            <th scope="col" class="rounded" width="30%"  rowspan=2 ><%=bundle.getString("label.progressreportparent.StudentName") %></th>
            <th scope="col" class="rounded" width="20%"  rowspan=2><%=bundle.getString("label.progressreportparent.RollNo.") %></th>
            <th scope="col" class="rounded" width="20%" colspan=<%=colspancount %>><%=bundle.getString("label.progressreportparent.MarkObtained") %></th>
            <th scope="col" class="rounded" width="10%" rowspan=2><%=bundle.getString("label.progressreportparent.Total") %></th>
            <th scope="col" class="rounded-q4" width="20%" rowspan=2><%=bundle.getString("label.progressreportparent.ClassRank") %></th>
            <tr  class=tableheading><%=head %>
		     </tr>
		    </thead>
      		<tfoot>
		    	<tr>
		        	<td colspan="<%=(colspancount+3) %>" class="rounded-foot-left"><em></em></td>
		        	<td class="rounded-foot-right" colspan='2'>&nbsp;</td>
		       </tr>
		    </tfoot>
		    <tbody>
		    <%
		    try{
		    	Comparator comparator = Collections.reverseOrder();
		    	String canidT="";
		    	for(int i=0;i<registeredList.size();i++)
				{
		    		int totalMark=0;

					HashMap map=(HashMap)registeredList.get(i);
					String candidateidT=map.get("candidateregisterid")+"";
					if(!candidateidT.equals(canidT))
					{   					

						String innermark="";

						for(int i1=0;i1<registeredList.size();i1++)
						{
							HashMap map1=(HashMap)registeredList.get(i1);
							String candidateid1T=map1.get("candidateregisterid")+"";
							if(candidateid1T.equals(candidateidT))
							{  

								innermark=map1.get("marktaken")+"";
								int marks=0;
								if(!innermark.equals("null") && !innermark.equals("A"))
								{
									marks=Integer.parseInt(innermark);	
								}
								else
								{  
									//out.print("<td><font >NE</font></td>");
								}   

								totalMark +=marks;
							}   
						}  
						totalmark_array.add(new Integer(totalMark));
						rank_array.add(new Integer(totalMark)+"@"+map.get("studentallocationid")+"");
						
						
						canidT=candidateidT;						
					}


				}    
		    	Collections.sort(totalmark_array,comparator);
		    	Collections.sort(rank_array,comparator);

		    	
		    	HashMap totalrankhash=new HashMap ();
		  

		    }
		    catch(Exception e)
		    {
		    	e.printStackTrace();
		    }
	    	//out.println("**"+rank_array);     

		    ArrayList registeredList_new=new ArrayList();
		    
		    String[] split_sall=null;
		    String split_string="";
		    if(rank_array!=null && rank_array.size()>0)
		    {
		    		for(int g=0;g<rank_array.size();g++)
		    		{
		    			 split_string=rank_array.get(g)+"";
		    			 split_sall=split_string.split("@");
		    			registeredList_new	=	(ArrayList)Examquery.LoadexammarkforStudentListRankWise(examnameid,standardscheduleid,sectionscheduleid,split_sall[1]+"");
		    			if(registeredList_new.size()!=0)  
						{
				    	String canid="";
				    	

							for(int i=0,s=1;i<registeredList_new.size();i++)
								{int total=0;

									HashMap map=(HashMap)registeredList_new.get(i);
									String candidateid=map.get("candidateregisterid")+"";
									if(!candidateid.equals(canid))
									{   temp_array.add(candidateid);
										String innermark="";
										if((map.get("studentallocationid")+"").equals(studentid))
										{
										out.print("<tr bgcolor='lightgreen' align='center'>");
										}
										else
										{ 
											out.print("<tr align='center'>");

										}   
										if((map.get("studentallocationid")+"").equals(studentid))
										{  
										out.print("<td align='left' class='tablelight' >"+map.get("uname")+"</td>");
										out.print("<td align='center' class='tablelight' >"+map.get("rollno")+"</td>");

										}
										else
										{
											out.print("<td align='left' class='tablelight'>"+map.get("uname")+"</td>");
											out.print("<td align='center' class='tablelight'>"+map.get("rollno")+"</td>");


										}
										ranksort.add(map.get("uname"));
										ranksort.add(map.get("rollno"));
										for(int i1=0;i1<registeredList_new.size();i1++)
										{

											HashMap map1=(HashMap)registeredList_new.get(i1);
											String candidateid1=map1.get("candidateregisterid")+"";
											if(candidateid1.equals(candidateid))
											{
												innermark=map1.get("marktaken")+"";
												int marks=0;
												if((map1.get("theoryexternalmin")!=null))
												 	theoryexternalmin=Integer.parseInt(map1.get("theoryexternalmin")+"");
												if(!innermark.equals("null") && !innermark.equals("A"))
												{
													marks=Integer.parseInt(innermark);
													if(marks<theoryexternalmin)
														{
															if((map.get("studentallocationid")+"").equals(studentid))
															{
															out.print("<td class='tablelight'>"+marks+"</font>");
															}
															else
															{
																out.print("<td class='tablelight'>"+marks+"</font>");

															}
															
															out.print("</td>");
														}
													else
														{
														if((map.get("studentallocationid")+"").equals(studentid))
														{
															out.print("<td class='tablelight'>"+marks);
														}
														else  
														{
															out.print("<td>"+marks);

														}
															
															out.print("</td>");

														}
													ranksort.add(new Integer(marks));

												}
												else if(innermark.equals("A"))
												{
													out.print("<td class='tablelight'>A</font></td>");

												}
												else
												{
													out.print("<td class='tablelight'>"+ bundle.getString("label.progressreportparent.NE")+"</font></td>");

												}  
												total +=marks;
												ranksort.add(new Integer(total));
											}
										}
										
										if((map.get("studentallocationid")+"").equals(studentid))
										{
											if(!innermark.equals("null") && !innermark.equals("A"))
											{
												out.print("<td class='tablelight' >"+total+"</td>");
											}
											else if(innermark.equals("A"))
											{
												out.print("<td ><font >A</td>");

											}
											else
											{
												out.print("<td ><font >-</td>");

											}
											
										}
										else
										{
											if(!innermark.equals("null") && !innermark.equals("A"))
											{ 
												out.print("<td class='tablelight' >"+total+"</td>");
											}
											else if(innermark.equals("A"))
											{
												out.print("<td ><font>A</td>");

											}
											else
											{
												out.print("<td ><font>-</td>");

											}

										}
										if((map.get("studentallocationid")+"").equals(studentid))
										{
											if(!innermark.equals("null") )   
											{
										         out.print("<td class='tablelight'>"+(totalmark_array.indexOf(new Integer(total))+1)+"</td>");
											}
											
											else
											{  
										         out.print("<td class='tablelight'>"+(totalmark_array.indexOf(new Integer(total))+1)+"</td>");


											}   
											
										}
										else
										{
											if(!innermark.equals("null") )
											{
											 out.print("<td class='tablelight'>"+(totalmark_array.indexOf(new Integer(total))+1)+"</td>");
											}
											
											else
											{
												 out.print("<td class='tablelight'>"+(totalmark_array.indexOf(new Integer(total))+1)+"</td>");

											}

										}
										ranksort.add(new Integer((totalmark_array.indexOf(new Integer(total))+1)));
										rankhash.put((totalmark_array.indexOf(new Integer(total))+1)+"",ranksort); 
										out.print("</tr>");
										canid=candidateid;
										s++;
									}
								}
							
							
							
						}
					else
						  {
							  out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");
						  } 
		    			
		    		} 
		    }
		    
		  
		 //out.println("<script>document.getElementById('divid').innerHTML='"+temp_array.size()+"';</script>");
		  %>
		  </tbody>
      </table>
      
   
  		<tr><td class=tablebold ><a href="#na2" name="na2" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a></td></tr>
  		
     <!--  <br><br>
 		<a class="tablebold">Note :</a><br>
 		<a>NE- Not Entered</a>  <br>
	<a class=tablebold>	<%
		
		/*if(subname.size()>0)
		{ 
		for(int sub=1;sub<=subname.size();sub++)
		{
			out.println("S"+sub+" :"+subname.get("S"+sub)+"<br>");
		}
		}
		out.println("A :<a> Absent </a>");
		*/
		%>
		
		</a> -->

		
 
</form>

	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->



 
    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>