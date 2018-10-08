<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script src="<%=request.getContextPath()%>/jsp/Exam/ChartCSS/jquery.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/jsp/Exam/ChartCSS/highcharts.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/Exam/ChartCSS/gray.js"></script>
<script type="text/javascript" src="../js/modules/exporting.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Prinicipal.PrinicipalQuery"%>

       		
      <%
      PrinicipalQuery  examAllotmentQuery = new PrinicipalQuery();
		StringBuffer head=new StringBuffer();
		
		String sessionid=session.getValue("sessionid")+"";
		String courseid=request.getParameter("course");
		String secSchedId=request.getParameter("sectionpubid");
		String reg_examid=request.getParameter("examid");
		ArrayList registeredList= null;
	   
String subjectname="";
String data="";

HashMap markvalue=new HashMap();
int count =0;

		    try{
		    	HashMap hashmap=new HashMap();
							String  totalmark="";
							 int rangetotal []=null;
							    int rangecount []=null;
							    		registeredList	=	(ArrayList)examAllotmentQuery.LoadexammarkforStudentList(reg_examid,courseid,secSchedId);
							    		ArrayList temp=new ArrayList();
									   	if(registeredList.size()!=0)
										{
											for(int i=0;i<registeredList.size();i++)
												{			
													HashMap map=(HashMap)registeredList.get(i);
													if(!temp.contains(map.get("subjectscheduleid")+""))
													{
														subjectname +=map.get("subjectname")+"','";
														temp.add(map.get("subjectscheduleid")+""); 
														totalmark=map.get("theoryexternalmax")+"";
													}
												}
											subjectname=subjectname.substring(0,subjectname.lastIndexOf("','"));
		    						    }
										 if(registeredList.size()!=0 && temp.size()>0)
											{
											 for(int sub=0;sub<temp.size();sub++)
												{
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
												 String subjectid=temp.get(sub)+"";
												  for(int c=0;c<registeredList.size();c++)  
													{
														HashMap mapnew=(HashMap)registeredList.get(c);
														String 	marktaken =mapnew.get("marktaken")+"";
														int intmarktaken=0;
														if(!marktaken.equals("null") && !marktaken.equals("A"))
														 intmarktaken=Integer.parseInt(marktaken);
														
														
														String 	subjectscheduleid =mapnew.get("subjectscheduleid")+"";
														if(subjectid.equals(subjectscheduleid))
											  				{
																for(int j=0;j<rangetotal.length;j++)  
																{
																	if(((rangetotal[j]-20)<=intmarktaken) && (intmarktaken<rangetotal[j]))
																	{
																		rangecount[j]++;  
																	}
																}
															}
				    						    	}
												  hashmap.put("subjectid"+subjectid,rangecount);												}
											}
									int range=0;

										for(int con=0;con<count;con++)
										{
											data +="{name: '"+range+"-"+(range+20)+"',data: [";
											for(int i=0;i<temp.size();i++)
											{
												int [] innerarray=(int[])hashmap.get("subjectid"+(temp.get(i)));
												data+=innerarray[con];
												if(i!=temp.size()-1)
													data+=",";
											}
											data+="]}";
											if(con!=count-1)
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
						defaultSeriesType: 'column'
					},
					title: {
						text: 'Subject Wise Stacked Bar Chart'
					},
					xAxis: {
						categories: ['<%=subjectname%>']
					},
					yAxis: {
						min: 0,
						title: {
							text: 'Total No of Student'
						},
						stackLabels: {
							enabled: true,
							style: {
								fontWeight: 'bold',
								color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
							}
						}
					},
					legend: {
						align: 'right',
						x: -100,
						verticalAlign: 'top',
						y: 20,
						floating: true,
						backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || 'white',
						borderColor: '#CCC',
						borderWidth: 1,
						shadow: false
					},
					tooltip: {
						formatter: function() {
							return '<b>'+ this.x +'</b><br/>'+
								 this.series.name +': '+ this.y +'<br/>'+
								 'Total: '+ this.point.stackTotal;
						}
					},
					plotOptions: {
						column: {
							stacking: 'normal',
							dataLabels: {
								enabled: true,
								color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
							}
						}
					},
				    series: [<%=data%>

					]
				});


			});

		</script>
		</head>
		<body topmargin="0" bottommargin="0">
		<%if(registeredList.size()!=0)
		{ %>
		<div id="container" style="width: 675px; height: 380px; margin: 0 auto"></div>
		<%}
		else
		{
			out.println("<center  class=tablebold><font color=red>Data Not Found</font></center>");
		}%>
</body>
</html>
       	