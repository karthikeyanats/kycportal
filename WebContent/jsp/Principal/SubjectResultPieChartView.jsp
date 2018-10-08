<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script src="<%=request.getContextPath()%>/jsp/Exam/ChartCSS/jquery.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/jsp/Exam/ChartCSS/highcharts.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/Exam/ChartCSS/gray.js"></script>
<script type="text/javascript" src="../js/modules/exporting.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Prinicipal.PrinicipalQuery,java.math.*"%>
      <%
        PrinicipalQuery  examAllotmentQuery = new PrinicipalQuery();
		StringBuffer head=new StringBuffer();
		String sessionid=session.getValue("sessionid")+"";
		String courseid=request.getParameter("course");
		String secSchedId=request.getParameter("sectionpubid");
		String reg_examid=request.getParameter("examid");
		String subjectid=request.getParameter("subjectid");
		String subjectnamedis=request.getParameter("subjectname");

		ArrayList registeredList= null;
		String subjectname="";
		String data="";
		HashMap markvalue=new HashMap();
		int count =0;
		int studentcount =0;

		    try{
		    	HashMap hashmap=new HashMap();
				ArrayList ExamList = null;
							String  totalmark="";
							 int rangetotal []=null;
							    int rangecount []=null;
							    		registeredList	=	(ArrayList)examAllotmentQuery.LoadexammarkforStudentListforsubjectwise(reg_examid,courseid,secSchedId,subjectid);
							    		ArrayList temp=new ArrayList();
									    if(registeredList.size()!=0)
											{
													HashMap map=(HashMap)registeredList.get(0);
													totalmark=map.get("theoryexternalmax")+"";
												    rangecount=new int [(Integer.parseInt(totalmark)/20)];
													rangetotal=new int [(Integer.parseInt(totalmark)/20)];
													count=(Integer.parseInt(totalmark)/20);

													for(int i=0;i<rangecount.length;i++)
													{
														rangecount[i]=0;
													}
													for(int i=0;i<rangetotal.length;i++)
													{
														if(i==0)
														rangetotal[i]=0+20;
														else
														rangetotal[i]=rangetotal[i-1]+20;
													}
												  for(int c=0;c<registeredList.size();c++)  
													{
														HashMap mapnew=(HashMap)registeredList.get(c);
														String 	marktaken =mapnew.get("marktaken")+"";
														int intmarktaken=0;
														if(!marktaken.equals("null") && !marktaken.equals("A"))
														 intmarktaken=Integer.parseInt(marktaken);
														String 	subjectscheduleid =mapnew.get("subjectscheduleid")+"";
														
																for(int j=0;j<rangetotal.length;j++)
																{
																	if(((rangetotal[j]-20)<=intmarktaken) && (intmarktaken<rangetotal[j]))
																	{
																		rangecount[j]++;  
																	}
																}
																studentcount++;
															
														}
											}
											int range=0;
											float newrange=(1f/studentcount)*100;
											for(int x=0;x<rangecount.length;x++)
												{
													if(x==(rangecount.length/2))
													{
														BigDecimal bd=new BigDecimal(rangecount[x]*newrange);
														bd=bd.setScale(2,BigDecimal.ROUND_HALF_EVEN);
														data+="{name: '"+range+"-"+(range+20)+"',y: "+bd+",sliced: true,selected: true}";
													}
													else
													{
													data +="['"+range+"-"+(range+20)+"',";
													BigDecimal bd=new BigDecimal(rangecount[x]*newrange);
													bd=bd.setScale(2,BigDecimal.ROUND_HALF_EVEN);
													data +=bd;
													data +="]";
													}
													if(x!=rangecount.length-1)
														data+=",";
													range=range+20;
												}
								}
		    catch(Exception e)
		    {
		    	e.printStackTrace();
		    }
		  %>
		 		<script type="text/javascript">

			var chart;
			$(document).ready(function() {
				chart = new Highcharts.Chart({
					chart: {
						renderTo: 'container',
						plotBackgroundColor: null,
						plotBorderWidth: null,
						plotShadow: false
					},
					title: {
						text: 'Pie Chart :<%=subjectnamedis%>'
					},
					tooltip: {
						formatter: function() {
							return '<b>'+ this.point.name +'</b>: '+ this.y +' %';
						}
					},
					plotOptions: {
						pie: {
							allowPointSelect: true,
							cursor: 'pointer',
							dataLabels: {
								enabled: true,
								color: '#000000',
								connectorColor: '#000000',
								formatter: function() {
									return '<b>'+ this.point.name +'</b>: '+ this.y +' %';
								}
							},
							showInLegend: true
						}
					}
					,
				    series: [{
						type: 'pie',
						name: 'Browser share',
						data: [
							<%=data%>
						]
					}]
				});
			});

		</script>
		</head>
		<body topmargin="0" bottommargin="0">
			<%if(registeredList.size()!=0)
		{ %>
		<div id="container" style="width: 600px; height: 300px; margin: 0 auto"></div>
		<%}
		else
		{
			out.println("<center  class=tablebold><font color=red>Data Not Found</font></center>");
		}%>
</body>
</html>
       	