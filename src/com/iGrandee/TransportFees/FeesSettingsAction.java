/**
 * 
 */
package com.iGrandee.TransportFees;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Fees.FeesHeadQuery;


/**
 * @author sindhuja_v
 *
 */

public class FeesSettingsAction {
	
	
	static Logger log = Logger.getLogger(FeesHeadQuery.class);
	public FeesSettingsAction()
	{
		 common_data_object = new CommonDataAccess();
		 connectionManager  = new ConnectionManager();
		 connection      = null;
		 rollbackvalue = 0;
		 select_query= "";
	}	
	
	
	// Viewing Yearofsession for particular instituteid modified when transportfeestypename is null - is showned by selvakumar_v
	
	public ArrayList getyearofsession(String instituteid){
		ArrayList yearofsession = null;
		
		try{
			
			String select_query = "select a.sessionid,a.sessionname,b.institutetransporttypeid,b.transportfeestypeid," +
					"case when  c.transportfeestypename is null then '-' else c.transportfeestypename end as transportfeestypename,a.sessionstatus from " +
					"yearofsession a left outer join institutetransporttype b on a.sessionid=b.sessionid and institutetransporttypestatus='A' " +
					"left outer join transportfeestype c on c.transportfeestypeid=b.transportfeestypeid where a.sessionstatus in ('A','R','N')" +
					" and instituteid='"+instituteid+"'";
			//String select_query = "select sessionid,sessionname from yearofsession where instituteid='"+instituteid+"'";
			//System.out.println("getyearofsession>>>>>"+select_query);
			yearofsession = common_data_object.getListMap(select_query);
			
		}
		
		catch (Exception e) {
			// TODO: handle exception 
			e.printStackTrace();
		}
		
		return yearofsession;
	}
	
	
	// Viewing All Fees types
	
	public ArrayList gettransportfeestype(){
		ArrayList transportfeestype = null;
		
		try{
			String select_query = "select transportfeestypeid,transportfeestypename from transportfeestype where transportfeestypestatus='A'";
			transportfeestype = common_data_object.getListMap(select_query);			
		}
		
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return transportfeestype;
	}
	
	
	// Viewing All Update Fees types
	
		public ArrayList gettransportfeestypeupdate(){
			ArrayList transportfeestype = null;
			
			try{
				String select_query = "select transportfeestypeid,transportfeestypename from transportfeestype where transportfeestypestatus='A'";
				transportfeestype = common_data_object.getListMap(select_query);			
			}
			
			catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			return transportfeestype;
		}	 
		
		
		// Viewing All Update Fees types - getidforupdatefeestype
		
		public String getidforupdatefeestype(String transportfeestypeid, String sessionid){
			String transportfeestype = null;   
			
			try{
				String select_query = "select itt.institutetransporttypeid from institutetransporttype itt, transportfeestype tft where tft.transportfeestypestatus='A' and itt.institutetransporttypestatus='A' and itt.sessionid='"+sessionid+"' and itt.transportfeestypeid='"+transportfeestypeid+"' and itt.transportfeestypeid=tft.transportfeestypeid"; 
				transportfeestype = common_data_object.getString(select_query);			
			}
			
			catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace(); 
			}
			
			return transportfeestype;
		}
	
	// Viewing Session Name
	
		public String getsessionname(String sessionid){
			String transportfeestype = null;
			
			try{
				String select_query = "select sessionname from yearofsession where sessionstatus in ('A','R','N') and sessionid="+sessionid+"";
				transportfeestype = common_data_object.getString(select_query);			
			}
			
			catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			return transportfeestype;	
		}
		
		
		
					// Viewing Route name stage amount allocation
		
					public String getRoute(String transportrouteid){
						String transportfeestype = null;
						
						try{
							String select_query = "select routename from transportroute where transportroutestatus='A' and transportrouteid='"+transportrouteid+"'";
							transportfeestype = common_data_object.getString(select_query);			
						}
						
						catch (Exception e) {
							// TODO: handle exception
							e.printStackTrace();
						}
						
						return transportfeestype;	
					}
		
		// Viewing Session Name plus Details
		
			public ArrayList getsessionnamedetails(String sessionid){
				ArrayList transportfeestype = null;
				
				try{
					String select_query = "select sessionid,sessionname,startmonth,endmonth,startyear,endyear from yearofsession where sessionstatus in ('A','R','N') and sessionid="+sessionid+"";
					transportfeestype = common_data_object.getListMap(select_query);			
				}
				
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return transportfeestype;	
			}
			
			
			
			// Viewing Transport Category Name for Travel Report Created by Sindhu.V 21-sep-2013
			
			public ArrayList Travelcategoryname(String sessionid){
				ArrayList transportfeestype = null;
				
				try{
					String select_query = "select tc.transportcategoryid,tc.transportcategoryname,itt.sessionid from transportcategory tc, institutetransporttype itt where itt.sessionid='"+sessionid+"' and tc.transportcategorystatus='A' and itt.institutetransporttypestatus='A' and itt.institutetransporttypeid=tc.institutetransporttypeid";
					transportfeestype = common_data_object.getListMap(select_query);			
				}
				
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return transportfeestype;	
			} 
			
			
			
			// Viewing Inserted Category name using sessionid plus transportfeestypeid
			
				public ArrayList getcategoryname(String sessionid,String transportfeestypeid){
					ArrayList transportfeestype = null;
					
					try{
						String select_query = "select tc.transportcategoryid,tc.transportcategoryname,itt.institutetransporttypeid,tft.transportfeestypeid,tft.transportfeestypename from transportcategory tc, institutetransporttype itt, transportfeestype tft where tc.transportcategorystatus='A' and itt.institutetransporttypeid=tc.institutetransporttypeid and itt.institutetransporttypestatus='A' and itt.transportfeestypeid=tft.transportfeestypeid and tft.transportfeestypestatus='A' and itt.sessionid='"+sessionid+"' and tft.transportfeestypeid='"+transportfeestypeid+"'";
						transportfeestype = common_data_object.getListMap(select_query);			
					}
					
					catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
					
					return transportfeestype;	
				} 
			
	
				
				// Viewing Routename in amount settings
				
				public ArrayList getroutenameamt(String instituteid){
					ArrayList transportfeestype = null;
					
					try{
						String select_query = "select transportrouteid,routename from transportroute where transportroutestatus='A' and instituteid='"+instituteid+"'";
						transportfeestype = common_data_object.getListMap(select_query);			
					}
					
					catch (Exception e) {
						// TODO: handle exception
						e.printStackTrace();
					}
					
					return transportfeestype;	
				}
				
	
	// Viewing All startmonth and endmonth for sessionid wise
	
	public ArrayList gettransportmonth(String sessionid){
		ArrayList transportmonth = null;
		
		try{
			String select_query = "select startmonth,endmonth,startyear,endyear from yearofsession where sessionid='"+sessionid+"'";
			transportmonth = common_data_object.getListMap(select_query);			
		}
		
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return transportmonth;
	}
	
	
	
	// Session id for duplication
	
		public String getsessionidforyear(String sessionid){
			String transportmonth = null;
			
			try{
				String select_query = "select transportfeestypeid from institutetransporttype where sessionid='"+sessionid+"'";
				transportmonth = common_data_object.getString(select_query);
				
			}
			
			catch (Exception e) {
				// TODO: handle exception 
				e.printStackTrace();
			}
			
			return transportmonth;
		}
	
	
	// View month
	
	public String getmonth(String month,String institutetransporttypeid){
		String transportmonth = null;
		
		try{
			String select_query = "select transportcategoryid,transportcategoryname from transportcategory where transportcategorystatus='A'" +
			" and transportcategoryname='"+month+"' and  institutetransporttypeid='"+institutetransporttypeid+"'";
			transportmonth = common_data_object.getString(select_query);
			
		}
		
		catch (Exception e) {
			// TODO: handle exception 
			e.printStackTrace();
		}
		
		return transportmonth;
	}
	
	
	
	// View Status
	
		public String getStatus(String transportfeestypeid,String sessionid){
			String transportmonth = null;
			
			try{
				String select_query = "select tc.transportcategorystatus,tc.institutetransporttypeid from transportcategory tc, institutetransporttype itt where tc.institutetransporttypeid=itt.institutetransporttypeid and itt.institutetransporttypestatus='A' and tc.transportcategorystatus='A' and itt.transportfeestypeid='"+transportfeestypeid+"' and itt.sessionid='"+sessionid+"'";
				
				//System.out.println("select_query>>>st"+select_query);
				transportmonth = common_data_object.getString(select_query);
				
			}
			
			catch (Exception e) {
				// TODO: handle exception 
				e.printStackTrace();
			}
			
			return transportmonth;
		}
	
	// View month Name
	
		public String getmonthname(String transportcategoryid){
			String transportmonth = null;
			
			try{
				String select_query = "select transportcategoryname from transportcategory where transportcategoryid='"+transportcategoryid+"'";
				transportmonth = common_data_object.getString(select_query);
				
			}
			
			catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			return transportmonth;
		}
		
		
		
		// View Term Name
		
			public String gettermname(String transportcategoryid){
				String transportmonth = null;
				
				try{
					String select_query = "select transportcategoryid from transportcategory where transportcategoryname='"+transportcategoryid+"'";
					transportmonth = common_data_object.getString(select_query);
					
				}
				
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return transportmonth;
			}
		
		
		
		// View Stage Name in particular stageid
		
			public String getstagename(String stageid){
				String transportmonth = null;
				
				try{
					String select_query = "select transportstagename from transportstage where transportstageid='"+stageid+"'";
					transportmonth = common_data_object.getString(select_query);
					
				}
				
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return transportmonth;
			}
	
	
	// Viewing All Stages amount
	
	public ArrayList getstageamount(String transportstageid, String transportcategoryid){
		ArrayList transportmonth = null;
		
		try{
			String select_query = "select transportstageamountallocationid, allocatedamount from transportstageamountallocation where transportstageamountallocationstatus='A' and transportstageid='"+transportstageid+"' and transportcategoryid='"+transportcategoryid+"'";
			transportmonth = common_data_object.getListMap(select_query);			
		}
		
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return transportmonth;
	}
	
	
	
	public ArrayList loadStageforRoute(String transportrouteid){
		ArrayList transportmonth = null;
		
		try{
		    String select_query = "select transportstageid,transportstagename from transportstage where transportrouteid='"+transportrouteid+"' and transportstagestatus='A'";
		//	String select_query = "select ts.transportstageid,ts.transportstagename,tr.transportrouteid,tr.routename from transportstage ts,transportroute tr where transportstagestatus='A' and tr.transportroutestatus='A' and tr.transportrouteid=ts.transportrouteid and tr.transportrouteid='"+transportrouteid+"' and instituteid='"+instituteid+"'";
		   // System.out.println("select_query"+select_query);
			transportmonth = common_data_object.getListMap(select_query);			 
		}
		
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		 
		return transportmonth;
	}
	
	// Viewing All Stages
	
		public ArrayList getstageforamounallotment(String transportrouteid, String transportcategoryid,String instituteid){
			ArrayList transportmonth = null;
			
			try{
			    String select_query = "select a.transportstageid,a.transportstagename,b.transportfeesheadid,b.transportfeesheadname,c.allocatedamount,c.transportstageamountallocationid from transportstage a cross join transportfeeshead b left outer join transportstageamountallocation c on a.transportstageid=c.transportstageid and b.transportfeesheadid=c.transportfeesheadid and c.transportcategoryid='"+transportcategoryid+"' and c.transportstageamountallocationstatus not in ('T','X') where a.transportrouteid='"+transportrouteid+"' and a.transportstagestatus='A' and transportfeesheadstatus not in ('T','X') and b.instituteid='"+instituteid+"' order by a.transportstageid,b.transportfeesheadid";
			//	String select_query = "select ts.transportstageid,ts.transportstagename,tr.transportrouteid,tr.routename from transportstage ts,transportroute tr where transportstagestatus='A' and tr.transportroutestatus='A' and tr.transportrouteid=ts.transportrouteid and tr.transportrouteid='"+transportrouteid+"' and instituteid='"+instituteid+"'";
			   // System.out.println("select_query"+select_query);
				transportmonth = common_data_object.getListMap(select_query);			 
			}
			
			catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			 
			return transportmonth;
		}
		
		
		
		// Viewing All Stages Amount Trash
		
			public ArrayList getTrashamounallotment(String transportrouteid, String transportcategoryid,String instituteid){
				ArrayList transportmonth = null;
				
				try{
				    String select_query = "select a.transportstageid,a.transportstagename,b.transportfeesheadid,b.transportfeesheadname,c.allocatedamount,c.transportstageamountallocationid from transportstage a cross join transportfeeshead b left outer join transportstageamountallocation c on a.transportstageid=c.transportstageid and b.transportfeesheadid=c.transportfeesheadid  and c.transportcategoryid='"+transportcategoryid+"' and c.transportstageamountallocationstatus='T' where a.transportrouteid='"+transportrouteid+"'  and b.instituteid='"+instituteid+"' and transportfeesheadstatus not in ('T','X') order by a.transportstageid";
				//	String select_query = "select ts.transportstageid,ts.transportstagename,tr.transportrouteid,tr.routename from transportstage ts,transportroute tr where transportstagestatus='A' and tr.transportroutestatus='A' and tr.transportrouteid=ts.transportrouteid and tr.transportrouteid='"+transportrouteid+"' and instituteid='"+instituteid+"'";
					transportmonth = common_data_object.getListMap(select_query);		
				//	System.out.println("select_query"+select_query);
				}
				
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				 
				return transportmonth;
			}
	 //load all stage during the change routes
			
			public ArrayList loadAllStagesforChangeRoute(String studentapprovalid,String transportrouteid){
				ArrayList transportmonth = null;
				
				try{
					
					// String select_query = "select a.transportstageid,a.transportstagename,studentstageallocationstatus from transportstage a left outer join studentstageallocation b on a.transportstageid=b.transportstageid and b.studentapprovalid='"+studentapprovalid+"' where b.studentstageallocationstatus in ('A','C') and a.transportrouteid='"+transportrouteid+"'";
					//last hidden
					//String select_query = "select a.transportstageid,a.transportstagename,b.studentstageallocationstatus from transportstage a left outer join  studentstageallocation b on a.transportstageid=b.transportstageid and a.transportstagestatus='A' and b.studentapprovalid='"+studentapprovalid+"' and b.studentstageallocationstatus in ('A','C') where a.transportrouteid='"+transportrouteid+"'";
					String select_query = "select a.transportstageid,a.transportstagename,b.studentstageallocationstatus from transportstage a left outer join  studentstageallocation b on a.transportstageid=b.transportstageid and b.studentapprovalid='"+studentapprovalid+"' and b.studentstageallocationstatus in ('A','C') where a.transportrouteid='"+transportrouteid+"'  and a.transportstagestatus='A'";
					
					//String select_query = "select a.transportstageid,a.transportstagename,a.transportrouteid,b.studentstageallocationstatus,a.transportstagestatus from transportstage a left outer join  studentstageallocation b on a.transportstageid=b.transportstageid and a.transportrouteid='"+transportrouteid+"' where b.studentapprovalid='"+studentapprovalid+"' and b.studentstageallocationstatus in ('A','C') and a.transportstagestatus='A';";
					
				//	System.out.println(select_query );
					 //String select_query = "select ts.transportstageid,ts.transportstagename,tr.transportrouteid,tr.routename from transportstage ts,transportroute tr where transportstagestatus='A' and tr.transportroutestatus='A' and ts.transportstageid<>'"+transportstageid+"' and tr.transportrouteid='"+transportrouteid+"' ";
					transportmonth = common_data_object.getListMap(select_query);			
				}
				
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return transportmonth;
			}
			
	
			
	// Viewing All Stages Change Stage
	public ArrayList getchangestageforamounallotment(String transportstageid,String transportrouteid){
		ArrayList transportmonth = null;
		
		try{
			
			 String select_query = "select ts.transportstageid,ts.transportstagename,tr.transportrouteid,tr.routename, sta.transportstageid, sta.studentstageallocationstatus from transportstage ts,transportroute tr, studentstageallocation sta where transportstagestatus='A' and tr.transportroutestatus='A' and tr.transportrouteid='"+transportrouteid+"' and sta.transportstageid=ts.transportstageid";
			//System.out.println(select_query );
			 //String select_query = "select ts.transportstageid,ts.transportstagename,tr.transportrouteid,tr.routename from transportstage ts,transportroute tr where transportstagestatus='A' and tr.transportroutestatus='A' and ts.transportstageid<>'"+transportstageid+"' and tr.transportrouteid='"+transportrouteid+"' ";
			transportmonth = common_data_object.getListMap(select_query);			
		}
		
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return transportmonth;
	}
	
	
	// Viewing All Stages & Route for exsiting with Category Changed by Sindhu.V 20-Sep-2013
	
		public ArrayList getexdtagerouteCategory(String studentapprovalid,String sessionid){
			ArrayList transportmonth = null;
			
			try{
				
				String select_query = "select st.studentstageallocationid, stl.studentstageallocationlogid, tr.transportrouteid,tc.transportcategoryid,tc.transportcategoryname,itt.sessionid, tr.routename,ts.transportstageid,ts.transportstagename, st.studentapprovalid, st.transportstageid, stl.studentstageallocationaction,st.studentstageallocationstatus from institutetransporttype itt, transportcategory tc,transportstage ts, transportroute tr,studentstageallocation st,studentstageallocationlog stl where ts.transportstagestatus='A'  and ts.transportstageid=st.transportstageid and st.studentstageallocationid=stl.studentstageallocationid and tr.transportroutestatus='A' and tr.transportrouteid=ts.transportrouteid and stl.studentstageallocationlogstatus in('A','D','C') and st.studentstageallocationstatus in('A','D','C') and st.studentapprovalid='"+studentapprovalid+"' and st.transportcategoryid=tc.transportcategoryid and tc.institutetransporttypeid=itt.institutetransporttypeid and itt.sessionid='"+sessionid+"' and tc.transportcategorystatus='A' and itt.institutetransporttypestatus='A' order by st.studentstageallocationid";
				//String select_query = "select st.studentstageallocationid, stl.studentstageallocationlogid, tr.transportrouteid,tr.routename,ts.transportstageid,ts.transportstagename, st.studentapprovalid, st.transportstageid, stl.studentstageallocationaction, st.studentstageallocationstatus from transportstage ts, transportroute tr,studentstageallocation st,studentstageallocationlog stl where ts.transportstagestatus='A'  and ts.transportstageid=st.transportstageid and st.studentstageallocationid=stl.studentstageallocationid and tr.transportroutestatus='A' and tr.transportrouteid=ts.transportrouteid and stl.studentstageallocationlogstatus in('A','D','C') and st.studentstageallocationstatus in('A','D','C') and st.studentapprovalid='"+studentapprovalid+"'";
				//String select_query = "select tr.transportrouteid,tr.routename,ts.transportstageid,ts.transportstagename,st.studentapprovalid,st.transportstageid,st.studentstageallocationid,stl.studentstageallocationlogid,stl.studentstageallocationaction from transportstage ts, transportroute tr, studentstageallocationlog stl, studentstageallocation st where ts.transportstagestatus='A' and tr.transportroutestatus='A' and ts.transportstageid=st.transportstageid and tr.transportrouteid=ts.transportrouteid and stl.studentstageallocationlogstatus in('A','D','C') and st.studentstageallocationstatus in('A','D','C') and st.studentapprovalid='"+studentapprovalid+"'";
				transportmonth = common_data_object.getListMap(select_query);			
			}
			
			catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			return transportmonth;
		} 
		
		
		// Viewing All Stages & Route for exsiting again Created by Sindhu.V 20-Sep-2013
		
			public ArrayList getexdtageroute(String studentapprovalid){
				ArrayList transportmonth = null;
				
				try{
					
					String select_query = "select st.studentstageallocationid, stl.studentstageallocationlogid, tr.transportrouteid,tr.routename,ts.transportstageid,ts.transportstagename, st.studentapprovalid, st.transportstageid, stl.studentstageallocationaction, st.studentstageallocationstatus from transportstage ts, transportroute tr,studentstageallocation st,studentstageallocationlog stl where ts.transportstagestatus='A'  and ts.transportstageid=st.transportstageid and st.studentstageallocationid=stl.studentstageallocationid and tr.transportroutestatus='A' and tr.transportrouteid=ts.transportrouteid and stl.studentstageallocationlogstatus in('A','D','C') and st.studentstageallocationstatus in('A','D','C') and st.studentapprovalid='"+studentapprovalid+"' group by st.studentstageallocationid";
					//String select_query = "select tr.transportrouteid,tr.routename,ts.transportstageid,ts.transportstagename,st.studentapprovalid,st.transportstageid,st.studentstageallocationid,stl.studentstageallocationlogid,stl.studentstageallocationaction from transportstage ts, transportroute tr, studentstageallocationlog stl, studentstageallocation st where ts.transportstagestatus='A' and tr.transportroutestatus='A' and ts.transportstageid=st.transportstageid and tr.transportrouteid=ts.transportrouteid and stl.studentstageallocationlogstatus in('A','D','C') and st.studentstageallocationstatus in('A','D','C') and st.studentapprovalid='"+studentapprovalid+"'";
					transportmonth = common_data_object.getListMap(select_query);			
				}
				
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return transportmonth;
			}
		
		
		// Viewing All Stages & Route for exsiting Change Route Status
		
			public ArrayList getchangeroutestatus(String studentapprovalid){
				ArrayList transportmonth = null;
				
				try{
					
					String select_query = "select st.studentstageallocationid, stl.studentstageallocationlogid, tr.transportrouteid,tr.routename,ts.transportstageid,ts.transportstagename, st.studentapprovalid, st.transportstageid, stl.studentstageallocationaction from transportstage ts, transportroute tr,studentstageallocation st,studentstageallocationlog stl where ts.transportstagestatus='A'  and ts.transportstageid=st.transportstageid and st.studentstageallocationid=stl.studentstageallocationid and tr.transportroutestatus='A' and tr.transportrouteid=ts.transportrouteid and stl.studentstageallocationlogstatus='A' and st.studentstageallocationstatus='A' and st.studentapprovalid='"+studentapprovalid+"'";
					//String select_query = "select tr.transportrouteid,tr.routename,ts.transportstageid,ts.transportstagename,st.studentapprovalid,st.transportstageid,st.studentstageallocationid,stl.studentstageallocationlogid,stl.studentstageallocationaction from transportstage ts, transportroute tr, studentstageallocationlog stl, studentstageallocation st where ts.transportstagestatus='A' and tr.transportroutestatus='A' and ts.transportstageid=st.transportstageid and tr.transportrouteid=ts.transportrouteid and stl.studentstageallocationlogstatus in('A','D','C') and st.studentstageallocationstatus in('A','D','C') and st.studentapprovalid='"+studentapprovalid+"'";
					transportmonth = common_data_object.getListMap(select_query);			
				}
				
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return transportmonth;
			} 
	
		
		// Get Route id 
		
			public String getroutid(String studentapprovalid){
				String transportmonth = null;
				
				try{
					String select_query = "select studentstageallocationid from studentstageallocation where studentstageallocationstatus in('A','D') and studentapprovalid='"+studentapprovalid+"'";
					transportmonth = common_data_object.getString(select_query);			
				}
				
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return transportmonth;
			}
		
		
	
	// get Studentapprovalid 
	
		public String getid(String studentapprovalid){
			String transportmonth = null;
			
			try{
				String select_query = "select st.studentapprovalid from studentstageallocation st, studentstageallocationlog stl where st.studentstageallocationid=stl.studentstageallocationid and st.studentstageallocationstatus in('A','D','C') and stl.studentstageallocationlogstatus in ('A','D','C') and st.studentapprovalid='"+studentapprovalid+"'";
				//System.out.println("select_query"+select_query);
				transportmonth = common_data_object.getString(select_query);			
			}
			
			catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			return transportmonth;
		}
	
	
	// Viewing All Route for student allotment
	
		public ArrayList getrouteforstu(String instituteid){
			ArrayList transportmonth = null;
			
			try{
				String select_query = "select transportrouteid, routename from transportroute where transportroutestatus='A' and instituteid='"+instituteid+"'";
				transportmonth = common_data_object.getListMap(select_query);			
			}
			
			catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			return transportmonth;
		}
		
		
		// Viewing All Route for student allotment Change Route
		
			public ArrayList getchangerouteforstu(String instituteid){
				ArrayList transportmonth = null;
				
				try{
					String select_query = "select transportrouteid, routename from transportroute where transportroutestatus='A' and instituteid='"+instituteid+"'";
					transportmonth = common_data_object.getListMap(select_query);			
				}
				
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return transportmonth;
			}
		
		
		// Route Wise Student Count Report
		
			public ArrayList getroutewisestureport(){
				ArrayList transportmonth = null;
				
				try{
					String select_query = "";
					transportmonth = common_data_object.getListMap(select_query);			
				}
				
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return transportmonth;
			}
	
	
	
	// Viewing All Stages getstageid
	
		public String getstageid(String transportstageid){
			String transportmonth = null;
			
			try{
				String select_query = "select transportstageid from transportfeessettings where transportstageid='"+transportstageid+"'";
				transportmonth = common_data_object.getString(select_query);			
			}
			
			catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			return transportmonth;
		}
	
	
// Yearofsession wise Fees type insertion process	
	
public int inserttransportfeestype(FeesSettings feesobj) throws Exception{
		
		int result=0;
		PreparedStatement transportfeestype = null;
		//ResultSet checkrs 					= null;
		//PreparedStatement checkprepared 	= null;

		try {
			connection= ConnectionManager.getKycConnection(); 
			connection.setAutoCommit(false);
			String currentdate			= DateTime.showTime("MySqlWithTime");
				
			
			String query="select max(institutetransporttypeid) from institutetransporttype";
			long institutetransporttypeid = common_data_object.maxId(query);
			institutetransporttypeid++;

			query="insert into  institutetransporttype (institutetransporttypeid, transportfeestypeid, sessionid, dateofcreation, createdby, institutetransporttypestatus) values (?, ?, ?, ?, ?, ?)";
			
			transportfeestype = connection.prepareStatement(query);
			transportfeestype.setLong(1, institutetransporttypeid);
			transportfeestype.setString(2,feesobj.getTransportfeestypeid());
			transportfeestype.setString(3,feesobj.getSessionid());
			transportfeestype.setString(4, currentdate);
			transportfeestype.setString(5,feesobj.getCreatedby());
			transportfeestype.setString(6,feesobj.getInstitutetransporttypestatus());
			//System.out.println("transportstageprepared>>>>>>>>>>>"+transportfeestype);

			result += transportfeestype.executeUpdate();
				
			//System.out.println("result>>>>>>>>>>>"+result);

		
			connection.commit();
		}	
			catch (SQLException e) {
			
			e.printStackTrace();
			result	= 0;
			if(connection!=null){
				
				connection.rollback();
			}
		}
		 finally
			{
		 
			 if(transportfeestype != null)
				 transportfeestype.close();
			 
			 if(connection != null)
				 connection.close();
			 }
		
		return result;
	}
	
// Update Fees type  removed the unused bean	modified by selvakumar_v 03-sep-2013

public int updatetransportfeestype(String institutetransporttypeid,String transportfeestypeid,String sessionid,String userid) throws Exception{
	
	int result=0;
	PreparedStatement uptransportfeestype = null;
	ResultSet checkrs 					= null;
	PreparedStatement checkprepared 	= null;
	//String institutetransporttypeid = null; 

	try {
		connection= ConnectionManager.getKycConnection(); 
		connection.setAutoCommit(false);
		String currentdate			= DateTime.showTime("MySqlWithTime");			
		
		
		String query="update institutetransporttype set transportfeestypeid=?, sessionid=?, dateofcreation=?, createdby=?, institutetransporttypestatus=? where institutetransporttypeid=?";
				
		uptransportfeestype = connection.prepareStatement(query);
		uptransportfeestype.setString(1,transportfeestypeid);
		uptransportfeestype.setString(2,sessionid);
		uptransportfeestype.setString(3, currentdate);
		uptransportfeestype.setString(4,userid);
		uptransportfeestype.setString(5, "A");
		uptransportfeestype.setString(6, institutetransporttypeid);

		//System.out.println("uptransportfeestype>>>>>>>>>>>"+uptransportfeestype);

		result += uptransportfeestype.executeUpdate();
			
		//System.out.println("result>>>>>>>>>>>"+result);

	
		connection.commit();
	}	
		catch (SQLException e) {
		
		e.printStackTrace();
		result	= 0;
		if(connection!=null){
			
			connection.rollback();
		}
	}
	 finally
		{
	 
		 if(uptransportfeestype != null)
			 uptransportfeestype.close();
		 
		 if(connection != null)
			 connection.close();
		 }
	
	return result;
}



// Stage wise Amount insertion process	

public int inserttransportamount(FeesSettings feesobj) throws Exception{
		
		int result=0;
		PreparedStatement transportamount = null;
		//ResultSet checkrs 					= null;
	//	PreparedStatement checkprepared 	= null;

		try {
			connection= ConnectionManager.getKycConnection(); 
			connection.setAutoCommit(false);
			String currentdate			= DateTime.showTime("MySqlWithTime");
				
			
			String query="select max(transportfeessettingsid) from transportfeessettings";
			long transportfeessettingsid = common_data_object.maxId(query);
			transportfeessettingsid++;

			query="insert into  transportfeessettings (transportfeessettingsid, transportstageid, transportcategoryid, transportfeesamount, createdby, dateofcreation, transportfeessettingstatus) values (?, ?, ?, ?, ?, ?, ?)";
			
			transportamount = connection.prepareStatement(query);
			transportamount.setLong(1, transportfeessettingsid);
			transportamount.setString(2,feesobj.getTransportstageid());
			transportamount.setString(3,feesobj.getTransportcategoryid());
			transportamount.setString(4,feesobj.getTransportfeesamount());
			transportamount.setString(5,feesobj.getCreatedby());
			transportamount.setString(6, currentdate);			
			transportamount.setString(7,feesobj.getTransportfeessettingstatus());
			//System.out.println("transportstageprepared>>>>>>>>>>>"+transportamount);

			result += transportamount.executeUpdate();
				
			//System.out.println("result>>>>>>>>>>>"+result);

		
			connection.commit();
		}	
			catch (SQLException e) {
			
			e.printStackTrace();
			result	= 0;
			if(connection!=null){
				
				connection.rollback();
			}
		}
		 finally
			{
		 
			 if(transportamount != null)
				 transportamount.close();
			 
			 if(connection != null)
				 connection.close();
			 }
		
		return result;
	}



//Stage wise Amount update process	

public int updatetransportamount(FeesSettings feesobj) throws Exception{
		
		int result=0;
		PreparedStatement uptransportamount = null;
		//ResultSet checkrs 					= null;
	//	PreparedStatement checkprepared 	= null;
		Long transportfeessettingsid     = null;

		try {
			connection= ConnectionManager.getKycConnection(); 
			connection.setAutoCommit(false);
			String currentdate			= DateTime.showTime("MySqlWithTime");
				
			
			/*String query="select max(transportfeessettingsid) from transportfeessettings";
			long transportfeessettingsid = common_data_object.maxId(query);
			transportfeessettingsid++;*/

			String query="update transportfeessettings set transportstageid=?, transportcategoryid=?, transportfeesamount=?, createdby=?, dateofcreation=?, transportfeessettingstatus=? where transportfeessettingsid=?";
			
			uptransportamount = connection.prepareStatement(query);
			uptransportamount.setString(1,feesobj.getTransportstageid());
			uptransportamount.setString(2,feesobj.getTransportcategoryid());
			uptransportamount.setString(3,feesobj.getTransportfeesamount());
			uptransportamount.setString(4,feesobj.getCreatedby());
			uptransportamount.setString(5, currentdate);			
			uptransportamount.setString(6,feesobj.getTransportfeessettingstatus());
			uptransportamount.setLong(7, transportfeessettingsid);
			//System.out.println("transportstageprepared>>>>>>>>>>>"+uptransportamount);

			result += uptransportamount.executeUpdate();
				
			//System.out.println("result>>>>>>>>>>>"+result);

		
			connection.commit();
		}	
			catch (SQLException e) {
			
			e.printStackTrace();
			result	= 0;
			if(connection!=null){
				
				connection.rollback();
			}
		}
		 finally
			{
		 
			 if(uptransportamount != null)
				 uptransportamount.close();
			 
			 if(connection != null)
				 connection.close();
			 }
		
		return result;
	}




//Category insertion process	

public int inserttransportcategory(FeesSettings feesobj) throws Exception{
		
		int result=0;
		PreparedStatement transportcategory = null;
		//ResultSet checkrs 					= null;
		//PreparedStatement checkprepared 	= null;

		try {
			connection= ConnectionManager.getKycConnection(); 
			connection.setAutoCommit(false);
			String currentdate			= DateTime.showTime("MySqlWithTime");
				
			
			String query="select max(transportcategoryid) from transportcategory";
			long transportcategoryid = common_data_object.maxId(query);
			transportcategoryid++;
 
			query="insert into  transportcategory (transportcategoryid, transportcategoryname, transportcategorydescription,institutetransporttypeid,transportcategorystatus,dateofcreation) values (?, ?, ?, ?, ?, ?)";
			
			transportcategory = connection.prepareStatement(query);
			transportcategory.setLong(1, transportcategoryid);
			transportcategory.setString(2,feesobj.getTransportcategoryname());
			transportcategory.setString(3,"-");
			transportcategory.setString(4,feesobj.getInstitutetransporttypeid());
			transportcategory.setString(5,feesobj.getTransportcategorystatus());
			transportcategory.setString(6,currentdate);
			//System.out.println("transportstageprepared>>>>>>>>>>>"+transportcategory);

			result += transportcategory.executeUpdate();
				
			//System.out.println("result>>>>>>>>>>>"+result);

		
			connection.commit();
		}	
			catch (SQLException e) {
			
			e.printStackTrace();
			result	= 0;
			if(connection!=null){
				
				connection.rollback();
			}
		}
		 finally
			{
		 
			 if(transportcategory != null)
				 transportcategory.close();
			 
			 if(connection != null)
				 connection.close();
			 }
		
		return result;
	}



public int updatetransportcategory(FeesSettings feesobj,String transportcategoryid) throws Exception{
	
	int result=0;
	PreparedStatement transportcategory = null;
	//ResultSet checkrs 					= null;
	//PreparedStatement checkprepared 	= null;

	try {
		connection= ConnectionManager.getKycConnection(); 
		connection.setAutoCommit(false);
		//String currentdate			= DateTime.showTime("MySqlWithTime");
		
		//String query="update transportcategory set transportcategoryname=?, transportcategorydescription=?,institutetransporttypeid=?, transportcategorystatus=?, dateofcreation=? where transportcategoryid=?";
		String query="delete from transportcategory where transportcategoryid=? and transportcategorystatus='A'";
		
		transportcategory = connection.prepareStatement(query);
		transportcategory.setString(1,transportcategoryid);
	//	transportcategory.setString(2,feesobj.getInstitutetransporttypeid());
		/*System.out.println("transportstageprepared>>>>ss>>>>>>>"+transportcategory);*/

		result += transportcategory.executeUpdate();
			
		//System.out.println("result>>>>>>>>>>>"+result);

	
		connection.commit();
	}	
		catch (SQLException e) {
		
		e.printStackTrace();
		result	= 0;
		if(connection!=null){
			
			connection.rollback();
		}
	}
	 finally
		{
	 
		 if(transportcategory != null)
			 transportcategory.close();
		 
		 if(connection != null)
			 connection.close();
		 }
	
	return result;
}



//check validation while deallocation category created by selvakumar_v


public String checkcategorydelete(String month,String institutetransporttypeid){
	
	 String return_value=null;
	try{
		select_query="select a.transportcategoryid   transportcategoryid from transportcategory a  join " +
	"transportstageamountallocation b on a.transportcategoryid=b.transportcategoryid and b.transportstageamountallocationstatus='A'" +
	" where a.transportcategoryname='"+month+"' and a.institutetransporttypeid='"+institutetransporttypeid+"' and a.transportcategorystatus='A' group by  a.transportcategoryid";
		//System.out.println("select_query..amt"+select_query);
		return_value=common_data_object.getString(select_query);
	}
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	return return_value;
}



//check validation while deallocation category created by selvakumar_v


public String checkfeestype(String transportfeestypeid, String sessionid){
	
	 String return_value=null;
	try{
		//select_query="select a.institutetransporttypeid from institutetransporttype a join  transportcategory b on a.institutetransporttypeid=b.institutetransporttypeid " +
	 //"and a.institutetransporttypestatus='A' and b.transportcategorystatus='A' where  a.transportfeestypeid='"+transportfeestypeid+"' group by a.institutetransporttypeid";
		select_query = "select a.institutetransporttypeid from institutetransporttype a, transportcategory tc where a.transportfeestypeid='"+transportfeestypeid+"' and a.sessionid='"+sessionid+"' and a.institutetransporttypeid=tc.institutetransporttypeid and tc.transportcategorystatus='A' and a.institutetransporttypestatus='A';";
		//System.out.println("select_query..amt"+select_query);
		return_value=common_data_object.getString(select_query);
	}
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	return return_value;
}

//get category created by selvakumar_v

	public String getmonths(String month){
		String transportmonth = null;
		
		try{
			String select_query = "select transportcategoryid,transportcategoryname from transportcategory where transportcategorystatus='A'" +
			" and transportcategoryname='"+month+"' ";
			transportmonth = common_data_object.getString(select_query);
			
		}
		
		catch (Exception e) {
			// TODO: handle exception 
			e.printStackTrace();
		}
		
		return transportmonth;
	}

	//get category created by selvakumar_v

	public ArrayList getcatname(String institutetransporttypeid,String sessionid){
			ArrayList transportmonth = null;
			
			try{
				String select_query = "select a.transportcategoryname,a.transportcategoryid,a.institutetransporttypeid from transportcategory a,institutetransporttype b  " +
			"where a.institutetransporttypeid='"+institutetransporttypeid+"' and b.sessionid='"+sessionid+"'  and  institutetransporttypestatus='A' and transportcategorystatus='A'";
				
			//	System.out.println("select_query>>>>>."+select_query);
				transportmonth = common_data_object.getListMap(select_query);
				
			}
			
			catch (Exception e) {
				// TODO: handle exception 
				e.printStackTrace();
			}
			
			return transportmonth;
		}


	//get paid count created by selvakumar_v

		public ArrayList getpayecount(String transportcategoryid){
				ArrayList transportmonth = null;
				
				try{
					String select_query = "select a.transportcategoryid,b.studentapprovalid,sum(a.allocatedamount) as acutalamount,transportfeescollectionid,paidamount," +
				"case when paidamount is null then 'Not Paid' when sum(a.allocatedamount)  >= paidamount then 'paid' else 'Not Paid' end as count from transportstageamountallocation a," +
				"studentstageallocation b left outer join transportfeescollection c on c.studentstageallocationid=b.studentstageallocationid where a.transportstageid=b.transportstageid" +
				" and a.transportcategoryid='"+transportcategoryid+"' group by b.studentapprovalid";
					
					//System.out.println("select_query>>>>>."+select_query);
					transportmonth = common_data_object.getListMap(select_query);
					
				}
				
				catch (Exception e) {
					// TODO: handle exception 
					e.printStackTrace();
				}
				
				return transportmonth;
			}

	


		//get  student profile view  created by selvakumar v
		public ArrayList getstudentprofileview(String stappid){
			ArrayList result=null;
			try{
			select_query="SELECT pm.imagepath,s.rollno,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid,pm.mobilenumber,pm.emailid,s.createdby FROM studentallocation s ,candidateregister cm,personmaster pm  where cm.studentapprovalid='"+stappid+"' and cm.candidateregisterid=s.candidateregisterid and  cm.personid=pm.personid and   cm.candidateregisterstatus='A' and s.studentallocationstatus='A'";
			//System.out.println("getdiscountpersession >>>>"+select_query);
				result=common_data_object.getListMap(select_query); 
				
			}
			catch (Exception e) {
				e.printStackTrace();
			}
			return result; 
		}

	// get count for no of paid transport created by selvakumar_v
		
		
		public int getpaidcount(String transportcategoryid){
			ArrayList result=null;
			int res=0;
			try{
			select_query="select a.transportcategoryid,b.studentapprovalid,sum(a.allocatedamount) as acutalamount,transportfeescollectionid,paidamount," +
			"case when paidamount is null then 'Not Paid' when sum(a.allocatedamount)  >= paidamount then 'paid' else 'Not Paid' end as count from transportstageamountallocation a," +
			"studentstageallocation b left outer join transportfeescollection c on c.studentstageallocationid=b.studentstageallocationid where a.transportstageid=b.transportstageid and" +
			" a.transportcategoryid='"+transportcategoryid+"' group by b.studentapprovalid having count like'paid'";
			//System.out.println("getpaidcount >>>>"+select_query);
				result=common_data_object.getListMap(select_query) ; 
				res=result.size();
			}
			catch (Exception e) {
				e.printStackTrace();
			}
			return res;  
		}
		
		public ArrayList categorywiseStudentList(String transportcategoryid,String sessionid){
			ArrayList result=null;
		
		
				try {
					//select_query = "select j.prefix,j.emailid,i.standardname,k.groupname,g.sectionname,j.firstname,j.middlename,j.lastname,e.rollno,c.transportstagename,a.studentstageallocationid,a.transportstageid,sum(allocatedamount)  as allocatedamount, (select sum(paidamount) from transportfeescollection x where x.transportcategoryid='"+transportcategoryid+"' and x.studentstageallocationid=a.studentstageallocationid) as paidamount, case  when  (select sum(paidamount) from transportfeescollection x where x.transportcategoryid='"+transportcategoryid+"' and x.studentstageallocationid=a.studentstageallocationid) is null then 'Pending'  when  sum(allocatedamount) <= (select sum(paidamount) from transportfeescollection x where x.transportcategoryid='"+transportcategoryid+"' and  x.studentstageallocationid=a.studentstageallocationid) then 'Paid' else 'Pending'   end as paidstatus from studentstageallocation a,transportstageamountallocation b,transportstage c,candidateregister d,studentallocation e,sectionschedule f,section g ,standardschedule h,standard i,personmaster j,standardgroup k where studentstageallocationstatus='A' and transportstageamountallocationstatus='A' and a.transportstageid=b.transportstageid and b.transportcategoryid='"+transportcategoryid+"' and c.transportstageid=a.transportstageid and d.studentapprovalid=a.studentapprovalid and d.candidateregisterid=e.candidateregisterid and f.sectionscheduleid=e.sectionscheduleid and f.sectionid=g.sectionid and h.standardscheduleid=f.standardscheduleid and h.standardid=i.standardid and j.personid=d.personid and k.groupid=h.groupid group by a.studentapprovalid order by i.standardid,g.sectionid,a.transportstageid";
				
					//hidden by rams, when we load the allocated amount, it is takeing previous amount. only checked the studentapprovalid, each student approvalid have multiple studentallocationid, so the allocated amount (1 studentapprovalid=2 allocationid, so if amount 100 showing 200) so, all status showed like pending. now checked the corresponding session's studentapprovalid 
					//	select_query = "select j.prefix,j.emailid,i.standardname,(select groupname from standardgroup k where k.groupid=h.groupid) as groupname,g.sectionname,j.firstname,j.middlename,j.lastname,e.rollno,c.transportstagename,a.studentstageallocationid,a.transportstageid,sum(allocatedamount)  as allocatedamount, (select sum(paidamount) from transportfeescollection x where x.transportcategoryid='"+transportcategoryid+"' and x.studentstageallocationid=a.studentstageallocationid) as paidamount, case  when  (select sum(paidamount) from transportfeescollection x where x.transportcategoryid='"+transportcategoryid+"' and x.studentstageallocationid=a.studentstageallocationid) is null then 'Pending'  when  sum(allocatedamount) <= (select sum(paidamount) from transportfeescollection x where x.transportcategoryid='"+transportcategoryid+"' and  x.studentstageallocationid=a.studentstageallocationid) then 'Paid' else 'Pending'   end as paidstatus from studentstageallocation a,transportstageamountallocation b,transportstage c,candidateregister d,studentallocation e,sectionschedule f,section g ,standardschedule h,standard i,personmaster j where studentstageallocationstatus='A' and transportstageamountallocationstatus='A' and a.transportstageid=b.transportstageid and b.transportcategoryid='"+transportcategoryid+"' and c.transportstageid=a.transportstageid and d.studentapprovalid=a.studentapprovalid and d.candidateregisterid=e.candidateregisterid and f.sectionscheduleid=e.sectionscheduleid and f.sectionid=g.sectionid and h.standardscheduleid=f.standardscheduleid and h.standardid=i.standardid and j.personid=d.personid group by a.studentapprovalid order by i.standardid,g.sectionid,a.transportstageid";
					select_query = "select i.sectionname,j.prefix,k.standardid,(select groupname from standardgroup kl where kl.groupid=g.groupid) as groupname,k.standardname,j.firstname,j.middlename,j.lastname,j.emailid,i.sectionname,j.mobilenumber,e.rollno,c.transportstagename,a.studentapprovalid,a.studentstageallocationid,a.transportstageid,sum(allocatedamount)  as allocatedamount, (select sum(paidamount) from transportfeescollection x where x.transportcategoryid='"+transportcategoryid+"' and x.studentstageallocationid=a.studentstageallocationid)  as paidamount, case when  (select sum(paidamount)  from transportfeescollection x where x.transportcategoryid='"+transportcategoryid+"' and  x.studentstageallocationid=a.studentstageallocationid) is null then 'Pending' when sum(allocatedamount) <= (select sum(paidamount) from transportfeescollection x where x.transportcategoryid='"+transportcategoryid+"'  and  x.studentstageallocationid=a.studentstageallocationid)  then  'Paid' else 'Pending'  end as paidstatus from studentstageallocation a, transportstageamountallocation b,transportstage c,candidateregister d,studentallocation e, sectionschedule f,standardschedule g,section i,personmaster j,standard k where studentstageallocationstatus='A'  and transportstageamountallocationstatus='A' and a.transportstageid=b.transportstageid and b.transportcategoryid='"+transportcategoryid+"' and c.transportstageid=a.transportstageid and d.studentapprovalid=a.studentapprovalid and candidateregisterstatus='A' and d.candidateregisterid=e.candidateregisterid and e.studentallocationstatus not in ('T','X') and e.sectionscheduleid=f.sectionscheduleid and f.sectionschedulestatus='A' and g.standardscheduleid=f.standardscheduleid and stdschedulestatus='A'  and i.sectionid=f.sectionid and i.status='A' and j.personid=d.personid and j.status='A' and k.standardid=g.standardid  and k.standardstatus='A' and sessionid='"+sessionid+"'  group by a.studentapprovalid order by k.standardid";//group by studentallocationid";
					//select_query = "select x1.studentapprovalid,x3.standardname,x7.sectionname,x5.rollno,x8.prefix,x8.firstname,x8.middlename,x8.lastname,x8.emailid,x8.mobilenumber,	a.studentstageallocationid,sum(allocatedamount),sum(paidamount),case when sum(allocatedamount)=sum(paidamount) then 'Paid' when sum(paidamount) is null then 'Pending' when sum(allocatedamount) > sum(paidamount) then 'Pending' else 'Paid' end as paidstatus	from studentapproval x1,standardschedule x2,standard x3,candidateregister x4,studentallocation x5,sectionschedule x6,section x7,personmaster x8,transportstageamountallocation b,studentstageallocation a	left outer join transportfeescollection c on c.studentstageallocationid=a.studentstageallocationid where a.transportstageid=b.transportstageid and a.studentstageallocationstatus in ('A','D') and 	transportstageamountallocationstatus='A' and b.transportstageid=a.transportstageid and b.transportcategoryid='"+transportcategoryid+"' and b.transportcategoryid=c.transportcategoryid and a.studentapprovalid=x1.studentapprovalid and x1.approvalstatus not in ('T','X') and x1.standardscheduleid=x2.standardscheduleid and x2.standardid=x3.standardid and x4.studentapprovalid=x1.studentapprovalid and x5.candidateregisterid=x4.candidateregisterid and x6.sectionscheduleid=x5.sectionscheduleid and x6.sectionid=x7.sectionid and x8.personid=x4.personid	group by a.studentstageallocationid,c.studentstageallocationid";
//System.out.println("select_query"+select_query);
					result = common_data_object.getListMap(select_query);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return result;
		}
		
		public ArrayList listpaymentdetails(String transportcategoryid,String sessionid){
			ArrayList result=null;
		//	String returnstr=null;
			//int res=0;
			Connection connection=null;
			Statement stmt1 = null;
			Statement stmt = null;
			try{
				
		    	connection 	    =   ConnectionManager.getKycConnection();
			//String select_query1="CREATE OR REPLACE view   trasportfeesreport as select a.studentstageallocationid,sum(allocatedamount),sum(paidamount), case when sum(allocatedamount)=sum(paidamount) then 'Paid' when sum(paidamount) is null then 'Pending' when sum(allocatedamount) > sum(paidamount) then 'Pending' else 'Paid' end as paidstatus from transportstageamountallocation b,studentstageallocation a left outer join transportfeescollection c on c.studentstageallocationid=a.studentstageallocationid where a.transportstageid=b.transportstageid and a.studentstageallocationstatus in ('A','D') and transportstageamountallocationstatus='A' and b.transportstageid=a.transportstageid and b.transportcategoryid='"+transportcategoryid+"' and b.transportcategoryid=c.transportcategoryid group by a.studentstageallocationid,c.studentstageallocationid";
			//String select_query1="CREATE OR REPLACE view   trasportfeesreport as select c.transportstagename,a.studentstageallocationid,a.transportstageid,sum(allocatedamount)  as allocatedamount, (select sum(paidamount) from transportfeescollection x where x.transportcategoryid='"+transportcategoryid+"' and  x.studentstageallocationid=a.studentstageallocationid)  as paidamount, case when  (select sum(paidamount) from transportfeescollection x where x.transportcategoryid='"+transportcategoryid+"' and  x.studentstageallocationid=a.studentstageallocationid) is null then 'Pending' when sum(allocatedamount) <= (select sum(paidamount) from transportfeescollection x where x.transportcategoryid='"+transportcategoryid+"' and  x.studentstageallocationid=a.studentstageallocationid)  then  'Paid' else 'Pending'   end as paidstatus from studentstageallocation a, transportstageamountallocation b,transportstage c where studentstageallocationstatus='A' and transportstageamountallocationstatus='A' and a.transportstageid=b.transportstageid and b.transportcategoryid='"+transportcategoryid+"' and c.transportstageid=a.transportstageid group by studentapprovalid";
		    	String select_query1="CREATE OR REPLACE view   trasportfeesreport as select c.transportstagename,a.studentstageallocationid,a.transportstageid,sum(allocatedamount)  as allocatedamount, (select sum(paidamount) from transportfeescollection x where x.transportcategoryid='"+transportcategoryid+"' and  x.studentstageallocationid=a.studentstageallocationid)  as paidamount, case when  (select sum(paidamount) from transportfeescollection x where x.transportcategoryid='"+transportcategoryid+"' and   x.studentstageallocationid=a.studentstageallocationid) is null then 'Pending'  when sum(allocatedamount) <= (select sum(paidamount) from transportfeescollection x  where x.transportcategoryid='"+transportcategoryid+"' and  x.studentstageallocationid=a.studentstageallocationid)   then  'Paid' else 'Pending'   end as paidstatus from studentstageallocation a, transportstageamountallocation b,transportstage c,candidateregister d,studentallocation e,sectionschedule f,standardschedule g  where studentstageallocationstatus='A' and transportstageamountallocationstatus='A' and a.transportstageid=b.transportstageid and b.transportcategoryid='"+transportcategoryid+"'  and c.transportstageid=a.transportstageid  and d.studentapprovalid=a.studentapprovalid and candidateregisterstatus='A'  and e.candidateregisterid=d.candidateregisterid and  studentallocationstatus not in ('T','X') and f.sectionscheduleid=e.sectionscheduleid and sectionschedulestatus='A' and g.standardscheduleid=f.standardscheduleid and stdschedulestatus='A' and g.sessionid='"+sessionid+"' group by a.studentapprovalid";
			
			stmt1 =   connection.createStatement(); 
	        stmt1.executeUpdate(select_query1);
			
	        select_query = "select distinct (select count(paidstatus) from trasportfeesreport where paidstatus='Paid') as paid," +
					"(select count(paidstatus) from trasportfeesreport where paidstatus='Pending') as  notpaid from trasportfeesreport";
	        result = common_data_object.getListMap(select_query);
			stmt = connection.createStatement();
			stmt.executeUpdate("DROP VIEW IF EXISTS trasportfeesreport");
			//DROP VIEW IF EXISTS trasportfeesreport;
					//"select * from trasportfeesreport;
			try {
				if(stmt1!=null)
					stmt1.close();
				if(stmt!=null)
					stmt.close();
				if(connection!=null)
					connection.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

 
				
			}
			catch (Exception e) {
				e.printStackTrace();
			}
			finally {
				
				
				try {
					if(stmt1!=null)
						stmt1.close();
					if(stmt!=null)
						stmt.close();
					if(connection!=null)
						connection.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return result; 
		}
		
		
	// get count for no of not paid transport created by selvakumar_v
		 
		
		public int getnotpaidcount(String transportcategoryid){
			ArrayList result=null;
			int res=0;
			try{
			select_query="select a.transportcategoryid,b.studentapprovalid,sum(a.allocatedamount) as acutalamount,transportfeescollectionid,paidamount," +
			"case when paidamount is null then 'Not Paid' when sum(a.allocatedamount)  >= paidamount then 'paid' else 'Not Paid' end as count from transportstageamountallocation a," +
			"studentstageallocation b left outer join transportfeescollection c on c.studentstageallocationid=b.studentstageallocationid where a.transportstageid=b.transportstageid and" +
			" a.transportcategoryid='"+transportcategoryid+"' group by b.studentapprovalid having count like'Not Paid'";
		//	System.out.println("getnotpaidcount >>>>"+select_query);
			result=(common_data_object.getListMap(select_query)) ; 
			res=result.size(); 
				
			}
			catch (Exception e) {
				e.printStackTrace();
			}
			return res; 
		}
		
		
	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection connection;
	 int rollbackvalue;

}
