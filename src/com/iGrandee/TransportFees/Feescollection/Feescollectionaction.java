/**
 * 
 */
package com.iGrandee.TransportFees.Feescollection;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.apache.log4j.Logger;
import com.iGrandee.Common.ConnectionManager;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.DateTime;

/**
 * @author ramasubramaniam_r
 *
 */
public class Feescollectionaction {
	
	static Logger log = Logger.getLogger(Feescollectionaction.class);

	public Feescollectionaction() {

		common_data_object = new CommonDataAccess();
		insert_query = null;
		select_query = null;
		return_value = 0;
		connection = null;
		datetime = new DateTime();
	}
	
	public ArrayList<?> loadStudentTransportcategory(String studentapprovalid,String sessionid,String instituteid) {
		ArrayList<?> arraylist = null;

		
			try {

	
				select_query ="select sum(allocatedamount) as allocatedamount,c.transportcategoryname,a.transportcategoryid	 from transportstageamountallocation a,studentstageallocation b,transportcategory c,	institutetransporttype d,transportfeeshead e	where b.studentapprovalid='"+studentapprovalid+"' and  a.transportstageid=b.transportstageid and transportstageamountallocationstatus='A' and c.transportcategoryid=a.transportcategoryid and transportcategorystatus='A' and c.institutetransporttypeid=d.institutetransporttypeid and institutetransporttypestatus='A' and d.sessionid='"+sessionid+"' and e.transportfeesheadid=a.transportfeesheadid and transportfeesheadstatus='A' and e.instituteid='"+instituteid+"'  group by a.transportcategoryid";
						//System.out.println("select_query------------>"+select_query);
				arraylist = common_data_object.getListMap(select_query);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		return arraylist;
	}
	
	/**
	 * 
	 * 
	 * @param rollno
	 * @return
	 */
	public ArrayList<?> loadTransportCategoryDetails(String rollno,String instituteid) {
		ArrayList<?> arraylist = null;

		
			try {
				/*select_query = "  select i.transportcategoryname,g.transportstagename,studentstageallocationstatus," +
						"allocatedamount,j.transportfeesheadid,j.transportfeesheadname " +
						"from  studentallocation a,candidateregister b,standardschedule c,personmaster d," +
						"studentapproval e,studentstageallocation f,transportstage g,transportstageamountallocation h,transportcategory i," +
						"transportfeeshead j  where a.rollno='"+rollno+"' and a.studentallocationstatus='A' and" +
						"  b.candidateregisterid=a.candidateregisterid and b.candidateregisterstatus='A'  and " +
						"c.standardscheduleid=b.standardscheduleid and stdschedulestatus='A' and d.personid=b.personid and d.status='A'" +
						"  and e.studentapprovalid=b.studentapprovalid and e.approvalstatus='A'" +
						"  and d.instituteid='"+instituteid+"' and f.studentapprovalid=e.studentapprovalid" +
						"  and g.transportstageid=f.transportstageid and studentstageallocationstatus<>'T'" +
						"			and h.transportstageid=g.transportstageid and i.transportcategoryid=h.transportcategoryid" +
						" and j.transportfeesheadid=h.transportfeesheadid";*/
				
				//select_query ="select k.transportstageamountallocationid,f.studentstageallocationid,i.transportcategoryname,g.transportstagename,studentstageallocationstatus,sum(allocatedamount) as totamount,group_concat(j.transportfeesheadname)  as transportfeesheadname from  studentallocation a,candidateregister b,standardschedule c,personmaster d,studentapproval e,studentstageallocation f,transportstage g,transportcategory i,transportfeeshead j,transportstageamountallocation h left outer join transportfeescollectiondetails k on h.transportstageamountallocationid=k.transportstageamountallocationid  where a.rollno='"+rollno+"' and a.studentallocationstatus='A'   and b.candidateregisterid=a.candidateregisterid and b.candidateregisterstatus='A'   and c.standardscheduleid=b.standardscheduleid and stdschedulestatus='A'  and d.personid=b.personid and d.status='A'  and e.studentapprovalid=b.studentapprovalid  and e.approvalstatus='A'  and d.instituteid='"+instituteid+"' and f.studentapprovalid=e.studentapprovalid   and g.transportstageid=f.transportstageid and studentstageallocationstatus<>'T' and h.transportstageid=g.transportstageid and i.transportcategoryid=h.transportcategoryid and j.transportfeesheadid=h.transportfeesheadid";
				
				//select_query ="select sum(allocatedamount) as totamount,k.transportstageamountallocationid,f.studentstageallocationid,i.transportcategoryname,g.transportstagename,studentstageallocationstatus,group_concat(j.transportfeesheadname)  as transportfeesheadname from  studentallocation a,candidateregister b,standardschedule c,personmaster d,studentapproval e,studentstageallocation f,transportstage g,transportcategory i,transportfeeshead j,transportstageamountallocation h left outer join transportfeescollectiondetails k on h.transportstageamountallocationid=k.transportstageamountallocationid  where a.rollno='"+rollno+"' and a.studentallocationstatus='A'  and b.candidateregisterid=a.candidateregisterid and b.candidateregisterstatus='A'  and c.standardscheduleid=b.standardscheduleid and stdschedulestatus='A'  and d.personid=b.personid and d.status='A'  and e.studentapprovalid=b.studentapprovalid  and e.approvalstatus='A'  and d.instituteid='"+instituteid+"' and f.studentapprovalid=e.studentapprovalid   and g.transportstageid=f.transportstageid and studentstageallocationstatus<>'T' and h.transportstageid=g.transportstageid and i.transportcategoryid=h.transportcategoryid and j.transportfeesheadid=h.transportfeesheadid group by h.transportcategoryid,h.transportstageid order by i.transportcategoryid,g.transportstageid";
				//select_query ="select sum(allocatedamount) as allocatedamount,sum(paidamount) as paidamount,i.transportcategoryname,h.transportcategoryid from  studentallocation a,candidateregister b,standardschedule c,personmaster d,studentapproval e,studentstageallocation f,transportstage g,transportcategory i,transportfeeshead j,transportstageamountallocation h left outer join transportfeescollection k on h.transportcategoryid=k.transportcategoryid  where a.rollno='"+rollno+"' and a.studentallocationstatus='A'  and b.candidateregisterid=a.candidateregisterid and b.candidateregisterstatus='A'  and c.standardscheduleid=b.standardscheduleid and stdschedulestatus='A'  and d.personid=b.personid and d.status='A'  and e.studentapprovalid=b.studentapprovalid  and e.approvalstatus='A'  and d.instituteid='"+instituteid+"' and f.studentapprovalid=e.studentapprovalid and g.transportstageid=f.transportstageid and studentstageallocationstatus<>'T' and h.transportstageid=g.transportstageid and i.transportcategoryid=h.transportcategoryid  and j.transportfeesheadid=h.transportfeesheadid and transportcategorystatus='A' group by i.transportcategoryid order by i.transportcategoryid,g.transportstageid";
				
				select_query ="select sum(allocatedamount) as allocatedamount,sum(paidamount) as paidamount,i.transportcategoryname,h.transportcategoryid from  studentallocation a,candidateregister b,standardschedule c,personmaster d,studentapproval e,studentstageallocation f,transportstage g,transportcategory i,transportfeeshead j,transportstageamountallocation h left outer join transportfeescollection k on h.transportcategoryid=k.transportcategoryid and transportstageamountallocationstatus='A'  where a.rollno='"+rollno+"' and a.studentallocationstatus='A'  and b.candidateregisterid=a.candidateregisterid and  b.candidateregisterstatus='A'  and c.standardscheduleid=b.standardscheduleid and stdschedulestatus='A'  and d.personid=b.personid  and j.transportfeesheadstatus='A' and d.status='A'  and e.studentapprovalid=b.studentapprovalid  and e.approvalstatus='A'  and d.instituteid='"+instituteid+"' and f.studentapprovalid=e.studentapprovalid	 and g.transportstageid=f.transportstageid and studentstageallocationstatus='A'  and h.transportstageid=g.transportstageid and i.transportcategoryid=h.transportcategoryid  and j.transportfeesheadid=h.transportfeesheadid and transportcategorystatus='A' group by i.transportcategoryid order by i.transportcategoryid,g.transportstageid";
				//System.out.println("select_query"+select_query);
				arraylist = common_data_object.getListMap(select_query);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		return arraylist;
	}
	
	
	
	public String loadalreadypaidamount(String transportcategoryid,String studentapprovalid){
		String sofarpaid=null;
				try{
					
					select_query="select sum(paidamount) as sofarpaid from transportfeescollection a,studentstageallocation b where a.transportcategoryid='"+transportcategoryid+"' and a.studentstageallocationid=b.studentstageallocationid and b.studentapprovalid='"+studentapprovalid+"'";
				//	System.out.println("select_query"+select_query);
					sofarpaid = common_data_object.getString(select_query);
					
				
					
				}catch(Exception e){log.error("",e);}
				return sofarpaid;
			}

	
	public String loadiscountpayment(String transportfeescollectionid){
String percent=null;
		try{
			
			select_query="select discountpercentage from transportfeescollectiondiscount a,discountamount b	where transportfeescollectionid='"+transportfeescollectionid+"' and a.discountamountid=b.discountamountid";
			//System.out.println("select_query"+select_query);
			percent = common_data_object.getString(select_query);
		
			
		}catch(Exception e){}
		return percent;
	}

	
	public ArrayList<?> loadPaidDetails(String transportfeescollectionid,String qrystate){
		ArrayList<?> arraylist = null;

		try{
			if(qrystate.equals("headdetails"))
			{
			select_query="select paidamount,date_format(dateofpaid,'%d-%b-%Y %r') as paiddate,receiptno,transportfeesheadname,f.allocatedamount from  transportfeescollection a,studentstageallocation b,transportstage c, transportcategory d,transportfeescollectiondetails e,transportstageamountallocation f,transportfeeshead g where a.studentstageallocationid=b.studentstageallocationid and a.transportfeescollectionid='"+transportfeescollectionid+"'  and c.transportstageid=b.transportstageid and studentstageallocationstatus<>'T'  and d.transportcategoryid=a.transportcategoryid and transportcategorystatus<>'T' and e.transportfeescollectionid=a.transportfeescollectionid  and transportfeescollectiondetailsstatus='A' and e.transportstageamountallocationid=f.transportstageamountallocationid and transportstageamountallocationstatus='A' and g.transportfeesheadid=f.transportfeesheadid";
			//System.out.println("select_query"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			}
			else if(qrystate.equals("paymentdetails"))
			{
				select_query="select d.transportstagename,b.transportcategoryname,a.receiptno,date_format(dateofpaid,'%d-%b-%Y') as dateofpaid,receiptno,paidamount  from transportfeescollection a,transportcategory b,studentstageallocation c,transportstage d  where a.transportfeescollectionid='"+transportfeescollectionid+"' and a.transportcategoryid=b.transportcategoryid and b.transportcategorystatus='A' and c.studentstageallocationid=a.studentstageallocationid and d.transportstagestatus='A' and c.studentstageallocationstatus not in  ('T','X') and d.transportstageid=c.transportstageid";
				//System.out.println("select_query"+select_query);
				arraylist = common_data_object.getListMap(select_query);
			}
			
			
		}catch(Exception e){}
		return arraylist;
	}
	
	
	
	public ArrayList<?> loadacademicPaidDetails(String receiptid,String instituteid) {
		ArrayList<?> arraylist = null;

		
			try {
				////select_query ="select transportstagename,routename,b.transportrouteid,b.transportstageid from studentstageallocation a,transportstage b,transportroute c,candidateregister d,studentallocation e, personmaster f where a.studentstageallocationstatus='A' and a.transportstageid=b.transportstageid and b.transportrouteid=c.transportrouteid and d.studentapprovalid=a.studentapprovalid and e.candidateregisterid=d.candidateregisterid and e.rollno='"+rollno+"' and e.studentallocationstatus='A' and f.personid=d.personid and f.instituteid='"+instituteid+"'";
				select_query ="select a. academicfeesreceiptno,c.termname,a.paidamount,date_format(a.dateofcreation,'%d-%M-%Y %r') as dateofpaid from academicfeesreceipt a,termfees b,feestermname c where a.academicfeesreceiptid='"+receiptid+"'  and academicfeesreceiptstatus='A' and a.termfeesid=b.termfeesid and b.termfeesstatus='A' and c.termid=b.termid and c.termstatus='A';" ;
			//	select_query ="select transportstagename,routename,b.transportrouteid,b.transportstageid,a.studentstageallocationstatus from studentstageallocation a,transportstage b,transportroute c,candidateregister d,studentallocation e, personmaster f where a.studentstageallocationstatus not in ('T','X') and a.transportstageid=b.transportstageid and b.transportrouteid=c.transportrouteid and d.studentapprovalid=a.studentapprovalid and e.candidateregisterid=d.candidateregisterid and e.rollno='"+rollno+"' and e.studentallocationstatus='A' and f.personid=d.personid and f.instituteid='"+instituteid+"'";
	//System.out.println("select_query"+select_query);
	arraylist = common_data_object.getListMap(select_query);
} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
			return arraylist;
	}	
	
	public ArrayList<?> loadStudentTransport(String rollno,String instituteid) {
		ArrayList<?> arraylist = null;

		
			try {
				//select_query ="select transportstagename,routename,b.transportrouteid,b.transportstageid from studentstageallocation a,transportstage b,transportroute c,candidateregister d,studentallocation e, personmaster f where a.studentstageallocationstatus='A' and a.transportstageid=b.transportstageid and b.transportrouteid=c.transportrouteid and d.studentapprovalid=a.studentapprovalid and e.candidateregisterid=d.candidateregisterid and e.rollno='"+rollno+"' and e.studentallocationstatus='A' and f.personid=d.personid and f.instituteid='"+instituteid+"'";
				select_query ="select studentstageallocationid,studentstageallocationstatus,transportstagename,routename,b.transportrouteid,b.transportstageid from studentstageallocation a,transportstage b,transportroute c,candidateregister d,studentallocation e,personmaster f where a.transportstageid=b.transportstageid and b.transportrouteid=c.transportrouteid  and d.studentapprovalid=a.studentapprovalid and e.candidateregisterid=d.candidateregisterid and e.rollno='"+rollno+"'  and e.studentallocationstatus='A' and f.personid=d.personid and f.instituteid='"+instituteid+"' order by studentstageallocationid desc LIMIT 1" ;
			//	select_query ="select transportstagename,routename,b.transportrouteid,b.transportstageid,a.studentstageallocationstatus from studentstageallocation a,transportstage b,transportroute c,candidateregister d,studentallocation e, personmaster f where a.studentstageallocationstatus not in ('T','X') and a.transportstageid=b.transportstageid and b.transportrouteid=c.transportrouteid and d.studentapprovalid=a.studentapprovalid and e.candidateregisterid=d.candidateregisterid and e.rollno='"+rollno+"' and e.studentallocationstatus='A' and f.personid=d.personid and f.instituteid='"+instituteid+"'";
	//System.out.println("select_query"+select_query);
	arraylist = common_data_object.getListMap(select_query);
} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}

return arraylist;
}
	
	public boolean verifyDiscountUseage(String transportcategoryid,String studentapprovalid) {
		boolean discount_usage= false;
		ArrayList<?> arraylist = null;
try {
	select_query="select a.transportfeescollectionid from transportfeescollectiondiscount a,discountusers b,transportfeescollection c  where b.studentapprovalid='"+studentapprovalid+"' and b.discountuserstatus in('A','D') and c.transportcategoryid='"+transportcategoryid+"'  and a.discountuserid=b.discountusersid and a.transportfeescollectionid=c.transportfeescollectionid and transportfeescollectionstatus='A' and transportfeescollectiondiscountstatus='A'";
	//hidden by rams, even the discount category is canceled, the amountshould calculate, select_query="select a.transportfeescollectionid from transportfeescollectiondiscount a,discountusers b,transportfeescollection c  where b.studentapprovalid='"+studentapprovalid+"' and b.discountuserstatus='A' and c.transportcategoryid='"+transportcategoryid+"'  and a.discountuserid=b.discountusersid and a.transportfeescollectionid=c.transportfeescollectionid and transportfeescollectionstatus='A' and transportfeescollectiondiscountstatus='A'";
	//	select_query="select transportfeescollectiondiscountid from transportfeescollectiondiscount a,transportfeescollection b where a.transportfeescollectionid=b.transportfeescollectionid and transportcategoryid='"+transportcategoryid+"' and transportfeescollectionstatus='A' and transportfeescollectiondiscountstatus='A'";
		//System.out.println("select_query"+select_query);
		arraylist = common_data_object.getListMap(select_query);
		if(arraylist.size()>0)
			discount_usage = true;
		else
			discount_usage= false;
} catch (SQLException e) {
// TODO Auto-generated catch block
e.printStackTrace();
}
	return discount_usage;
}
	//listed out the used discount name and % details.
	public ArrayList<?> showDiscountDetails(String transportcategoryid,String studentapprovalid) {
		ArrayList<?> arraylist = null;
try {
	select_query="select a.transportfeescollectionid,b.discountusersid,a.discountamountid,discountpercentage,e.discountcategoryname,discountuserstatus  from transportfeescollectiondiscount a,discountusers b,transportfeescollection c,discountamount d,discountcategory e  where b.studentapprovalid='"+studentapprovalid+"' and b.discountuserstatus in('A','D')  and c.transportcategoryid='"+transportcategoryid+"'  and  a.discountuserid=b.discountusersid  and a.transportfeescollectionid=c.transportfeescollectionid and transportfeescollectionstatus='A' and transportfeescollectiondiscountstatus='A' and d.discountamountid=a.discountamountid and d.discountamountstatus='A' and d.discountcategoryid=e.discountcategoryid and e.discountcategorystatus='A'";
	//hidden by rams, even the discount category is canceled, the amountshould calculate, select_query="select a.transportfeescollectionid from transportfeescollectiondiscount a,discountusers b,transportfeescollection c  where b.studentapprovalid='"+studentapprovalid+"' and b.discountuserstatus='A' and c.transportcategoryid='"+transportcategoryid+"'  and a.discountuserid=b.discountusersid and a.transportfeescollectionid=c.transportfeescollectionid and transportfeescollectionstatus='A' and transportfeescollectiondiscountstatus='A'";
	//	select_query="select transportfeescollectiondiscountid from transportfeescollectiondiscount a,transportfeescollection b where a.transportfeescollectionid=b.transportfeescollectionid and transportcategoryid='"+transportcategoryid+"' and transportfeescollectionstatus='A' and transportfeescollectiondiscountstatus='A'";
		System.out.println("select_query"+select_query);
		arraylist = common_data_object.getListMap(select_query);
		
} catch (SQLException e) {
// TODO Auto-generated catch block
e.printStackTrace();
}
	return arraylist;
}

	//listed out the used discount details based on the transportfeescollectionid for receipt details
		public ArrayList<?> showDiscountDetails_receipt(String transportfeescollectionid) {
			ArrayList<?> arraylist = null;
	try {
		select_query="select a.transportfeescollectionid,b.discountusersid,a.discountamountid,discountpercentage,e.discountcategoryname,b.discountuserstatus from transportfeescollectiondiscount a,discountusers b,transportfeescollection c,discountamount d,discountcategory e where b.discountuserstatus in('A','D') and a.transportfeescollectionid='"+transportfeescollectionid+"'  and a.discountuserid=b.discountusersid  and a.transportfeescollectionid=c.transportfeescollectionid and transportfeescollectionstatus='A'  and transportfeescollectiondiscountstatus='A' and d.discountamountid=a.discountamountid and d.discountamountstatus='A' and d.discountcategoryid=e.discountcategoryid and e.discountcategorystatus='A'";
		//hidden by rams, even the discount category is canceled, the amountshould calculate, select_query="select a.transportfeescollectionid from transportfeescollectiondiscount a,discountusers b,transportfeescollection c  where b.studentapprovalid='"+studentapprovalid+"' and b.discountuserstatus='A' and c.transportcategoryid='"+transportcategoryid+"'  and a.discountuserid=b.discountusersid and a.transportfeescollectionid=c.transportfeescollectionid and transportfeescollectionstatus='A' and transportfeescollectiondiscountstatus='A'";
		//	select_query="select transportfeescollectiondiscountid from transportfeescollectiondiscount a,transportfeescollection b where a.transportfeescollectionid=b.transportfeescollectionid and transportcategoryid='"+transportcategoryid+"' and transportfeescollectionstatus='A' and transportfeescollectiondiscountstatus='A'";
			//System.out.println("select_query"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			
	} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
	}
		return arraylist;
	}

	
//verifydiscount userd
	
			public boolean verifyDiscountUseage(String transportcategoryid) {
				boolean discount_usage= false;
				ArrayList<?> arraylist = null;
		try {
				select_query="select transportfeescollectiondiscountid from transportfeescollectiondiscount a,transportfeescollection b where a.transportfeescollectionid=b.transportfeescollectionid and transportcategoryid='"+transportcategoryid+"' and transportfeescollectionstatus='A' and transportfeescollectiondiscountstatus='A'";
				//System.out.println("select_query"+select_query);
				arraylist = common_data_object.getListMap(select_query);
				if(arraylist.size()>0)
					discount_usage = true;
				else
					discount_usage= false;
		} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
			return discount_usage;
	}
	
	//load discount 
	
	public ArrayList<?> loadusersDiscount(String studentapprovalid,String sessionid) {
		ArrayList<?> arraylist = null;
		try {
				select_query="select a.discountusersid,discountamountid,discountpercentage,b.discountcategoryname from	 discountusers a,discountcategory b,discountamount c where a.studentapprovalid='"+studentapprovalid+"' and 	a.discountcategoryid=b.discountcategoryid and 	c.discountcategoryid=b.discountcategoryid and b.discountcategorystatus<>'T' and discountuserstatus='A'	and c.sessionid='"+sessionid+"'";
				//System.out.println("select_query"+select_query);
				arraylist = common_data_object.getListMap(select_query);
		} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
			return arraylist;
	}
	
	//public ArrayList<?> loadTransportFeesDetails(String rollno,String instituteid,String studentapprovalid,String transportcategoryid) {
	public ArrayList<?> loadTransportFeesDetails(String transportcategoryid,String transportstageid,String studentapprovalid) {
		ArrayList<?> arraylist = null;

		
			try {
			
				//select_query ="select b.transportstageid,c.transportstageamountallocationid,d.transportfeesheadname,c.transportfeesheadid,c.allocatedamount,b.transportstagename,a.dateofcreation,a.studentstageallocationstatus,  a.studentstageallocationid from studentstageallocation a,transportstage b,transportstageamountallocation c,transportfeeshead d  where a.transportstageid=b.transportstageid and a.studentapprovalid='"+studentapprovalid+"' and c.transportcategoryid='"+transporcategoryid+"' and a.transportstageid=c.transportstageid and d.transportfeesheadid=c.transportfeesheadid  and a.studentstageallocationstatus<>'T' and b.transportstagestatus<>'T'";
				//latest - hidden by rams  
				//select_query ="select a.transportfeesheadid,d.transportfeesheadname,allocatedamount,a.transportstageamountallocationid,b.studentstageallocationid from transportstageamountallocation a,studentstageallocation b,transportstage c,transportfeeshead d,candidateregister e,studentallocation f,personmaster g where e.studentapprovalid=b.studentapprovalid  and g.personid=e.personid  and g.instituteid='"+instituteid+"' and f.rollno='"+rollno+"' and f.studentallocationstatus='A' and transportstageamountallocationstatus='A' and a.transportcategoryid='"+transportcategoryid+"' and b.studentapprovalid='"+studentapprovalid+"' and d.transportfeesheadid=a.transportfeesheadid and c.transportstageid=b.transportstageid and c.transportstageid=a.transportstageid and a.transportstageid=b.transportstageid and studentstageallocationstatus='A'";
				select_query ="select a.transportfeesheadid,c.transportfeesheadname,allocatedamount,a.transportstageamountallocationid, b.studentstageallocationid from transportstageamountallocation a,studentstageallocation b,transportfeeshead c where a.transportcategoryid='"+transportcategoryid+"' and b.transportstageid='"+transportstageid+"'  and a.transportstageid=b.transportstageid and transportstageamountallocationstatus='A' and c.transportfeesheadid=a.transportfeesheadid  and studentapprovalid='"+studentapprovalid+"' and studentstageallocationstatus='A'";
				//select_query ="select a.transportfeesheadid,d.transportfeesheadname,allocatedamount,a.transportstageamountallocationid,b.studentstageallocationid 	from transportstageamountallocation a,studentstageallocation b,transportstage c,transportfeeshead d where a.transportcategoryid='"+transporcategoryid+"' and studentapprovalid='"+studentapprovalid+"' and d.transportfeesheadid=a.transportfeesheadid and c.transportstageid=b.transportstageid and c.transportstageid=a.transportstageid and a.transportstageid=b.transportstageid and studentstageallocationstatus='A'";
				//last hiddenselect_query ="select  b.transportstageid,c.transportstageamountallocationid,d.transportfeesheadname,c.transportfeesheadid,c.allocatedamount,b.transportstagename,a.dateofcreation,a.studentstageallocationstatus, a.studentstageallocationid from studentstageallocation a,transportstage b,transportstageamountallocation c,transportfeeshead d  where a.transportstageid=b.transportstageid and a.studentapprovalid='"+studentapprovalid+"' and  c.transportcategoryid='"+transporcategoryid+"' and a.transportstageid=c.transportstageid and d.transportfeesheadid=c.transportfeesheadid  and a.studentstageallocationstatus<>'T' and b.transportstagestatus<>'T'";
			//	select_query ="select c.allocatedamount,b.transportstagename,a.dateofcreation,a.studentstageallocationstatus,a.studentstageallocationid from studentstageallocation a,transportstage b,transportstageamountallocation c where a.transportstageid=b.transportstageid and a.studentapprovalid='"+studentapprovalid+"' and c.transportcategoryid='"+transporcategoryid+"' and a.transportstageid=c.transportstageid and a.studentstageallocationstatus<>'T' 	and b.transportstagestatus<>'T'";
				
				//System.out.println("select_query"+select_query);
				arraylist = common_data_object.getListMap(select_query);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		return arraylist;
	}
	
	
	
	public ArrayList<?> loadDiscount(String rollno,String instituteid) {
		ArrayList<?> arraylist = null;

		
			try {
	
	select_query ="select k.transportstageamountallocationid,f.studentstageallocationid,i.transportcategoryname,g.transportstagename,studentstageallocationstatus,sum(allocatedamount) as totamount,group_concat(j.transportfeesheadname)  as transportfeesheadname from  studentallocation a,candidateregister b,standardschedule c,personmaster d,studentapproval e,studentstageallocation f,transportstage g,transportcategory i,transportfeeshead j,transportstageamountallocation h left outer join transportfeescollectiondetails k on h.transportstageamountallocationid=k.transportstageamountallocationid  where a.rollno='"+rollno+"' and a.studentallocationstatus='A'   and b.candidateregisterid=a.candidateregisterid and b.candidateregisterstatus='A'   and c.standardscheduleid=b.standardscheduleid and stdschedulestatus='A'  and d.personid=b.personid and d.status='A'  and e.studentapprovalid=b.studentapprovalid  and e.approvalstatus='A'  and d.instituteid='"+instituteid+"' and f.studentapprovalid=e.studentapprovalid   and g.transportstageid=f.transportstageid and studentstageallocationstatus<>'T' and h.transportstageid=g.transportstageid and i.transportcategoryid=h.transportcategoryid and j.transportfeesheadid=h.transportfeesheadid";
	//System.out.println("select_query"+select_query);
	arraylist = common_data_object.getListMap(select_query);
} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}

return arraylist;
}
	
	public ArrayList<?> loadfeesreceiptdetails(String studentapprovalid,String sessionid) {
		ArrayList<?> arraylist = null;
			try {
				select_query="select d.transportcategoryid,transportfeescollectionid,c.transportstagename,a.receiptno,date_format(a.dateofpaid,'%d-%b-%Y') as dateofpaids, 	paidamount,transportcategoryname,d.transportcategoryid  from transportfeescollection a,studentstageallocation b,transportstage c,transportcategory d,institutetransporttype e where a.studentstageallocationid=b.studentstageallocationid and d.transportcategoryid=a.transportcategoryid and b.studentapprovalid='"+studentapprovalid+"' and c.transportstageid=b.transportstageid and d.institutetransporttypeid=e.institutetransporttypeid and e.institutetransporttypestatus='A' and d.transportcategorystatus='A' and transportfeescollectionstatus='A' and e.sessionid='"+sessionid+"' and  studentstageallocationstatus in ('A','D') and  transportstagestatus='A' order by d.transportcategoryid,transportfeescollectionid desc";
	
				//select_query ="select transportfeescollectionid,c.transportstagename,a.receiptno,date_format(a.dateofpaid,'%d-%b-%Y') as dateofpaid,	paidamount,transportcategoryname,d.transportcategoryid from transportfeescollection a,studentstageallocation b,transportstage c,transportcategory d where a.studentstageallocationid=b.studentstageallocationid and d.transportcategoryid=a.transportcategoryid and b.studentapprovalid='"+studentapprovalid+"' and c.transportstageid=b.transportstageid";
						System.out.println("select_query"+select_query);
				arraylist = common_data_object.getListMap(select_query);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
						return arraylist;
				}
	public ArrayList<?> loadfeesreceipt(String rollno,String instituteid) {
		ArrayList<?> arraylist = null;

		
			try {
				//select_query ="select transportstagename,routename,b.transportrouteid,b.transportstageid from studentstageallocation a,transportstage b,transportroute c,candidateregister d,studentallocation e, personmaster f where a.studentstageallocationstatus='A' and a.transportstageid=b.transportstageid and b.transportrouteid=c.transportrouteid and d.studentapprovalid=a.studentapprovalid and e.candidateregisterid=d.candidateregisterid and e.rollno='"+rollno+"' and e.studentallocationstatus='A' and f.personid=d.personid and f.instituteid='"+instituteid+"'";
select_query ="select d.transportstagename,b.transportcategoryid,b.transportcategoryname,a.transportfeescollectionid,a.receiptno,a.paidamount,d.transportstageid," +
"date_format(a.dateofpaid,'%d-%b-%Y') dateofpaid from transportfeescollection a,transportcategory b,transportstageamountallocation c,transportstage d " +
"where a.rollnumber='"+rollno+"' and a.transportfeescollectionstatus='A' and a.transportcategoryid=b.transportcategoryid and b.transportcategorystatus='A' " +
"and a.transportcategoryid=c.transportcategoryid and c.transportstageid=d.transportstageid and c.transportstageamountallocationstatus='A' and d.transportstagestatus='A' " +
"group by b.transportcategoryname,d.transportstagename";
			//	select_query ="select transportstagename,routename,b.transportrouteid,b.transportstageid,a.studentstageallocationstatus from studentstageallocation a,transportstage b,transportroute c,candidateregister d,studentallocation e, personmaster f where a.studentstageallocationstatus not in ('T','X') and a.transportstageid=b.transportstageid and b.transportrouteid=c.transportrouteid and d.studentapprovalid=a.studentapprovalid and e.candidateregisterid=d.candidateregisterid and e.rollno='"+rollno+"' and e.studentallocationstatus='A' and f.personid=d.personid and f.instituteid='"+instituteid+"'";
	//System.out.println("select_query"+select_query);
	arraylist = common_data_object.getListMap(select_query);
} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
			return arraylist;
	}
	
	public String saveFees(com.iGrandee.TransportFees.Feescollection.TransportFeesCollection feescollectionobj) throws SQLException
	{
		int result 					= 0;
		PreparedStatement pstmt 	= null;
		PreparedStatement pstmt1 	= null;
		PreparedStatement pstmt2 	= null;
		PreparedStatement pstmt3 	= null;
		PreparedStatement pstmt4 	= null;
		String ret_transportfeescollectionid = null;
		
		ResultSet appidrs = null;
		ResultSet recptidrs = null;
		Connection connection = null;

		long transfeescollectionid = 0l;
		long recptId = 0l;
		String query1 = null;
		String query2 = null;
		String query3 = null;
		int temp[]					= null;
		String select_query = null;
		try{
			connection 	= ConnectionManager.getKycConnection(); 
			connection.setAutoCommit(false);
			
			datetime						= new DateTime();
			
			select_query = "select max(transportfeescollectionid) from transportfeescollection";
			pstmt = connection.prepareStatement(select_query);
			appidrs = pstmt.executeQuery();
			
			if (appidrs.next())
				transfeescollectionid = appidrs.getLong(1);

			transfeescollectionid++;
			
			//select_query = "select max(receiptno) from transportfeescollection where instituteid='" + (String)feescollectionobj.getInstituteid()+ "'";
			select_query = "select max(receiptno) from transportfeescollection";
			pstmt1 = connection.prepareStatement(select_query);
			recptidrs = pstmt1.executeQuery();

			if (recptidrs.next())
				recptId = recptidrs.getLong(1);

			recptId++;
			
			
			
			query1 	= "insert into transportfeescollection(transportfeescollectionid,receiptno,studentstageallocationid,paidamount,dateofpaid,rollnumber,transportfeescollectionstatus,transportcategoryid) values(?,?,?,?,?,?,?,?)";
			pstmt2 	= connection.prepareStatement(query1);
			
			pstmt2.setLong(1, transfeescollectionid);
			pstmt2.setLong(2, transfeescollectionid);
			pstmt2.setString(3,feescollectionobj.getUserstageallocationid());
			pstmt2.setString(4, feescollectionobj.getPaidamount()) ;
			pstmt2.setString(5, datetime.showTime("databaseinsert"));
			pstmt2.setString(6, feescollectionobj.getRollnumber());
			pstmt2.setString(7, "A");
			pstmt2.setString(8, feescollectionobj.getTransportcategoryid());
			//System.out.println("transportfeescollection"+pstmt2);
			result = pstmt2.executeUpdate();
			
			//System.out.println("-->"+feescollectionobj.getDiscountamountid());
			if(feescollectionobj.getDiscountusedstatus().equals("no")){
			if(!feescollectionobj.getDiscountamountid().equals("-"))
			{
				query3 	= "insert into transportfeescollectiondiscount(transportfeescollectionid,discountuserid,discountamountid,dateofcreation,transportfeescollectiondiscountstatus) values(?,?,?,?,?)";
				pstmt4 	= connection.prepareStatement(query3);
				
				
				
				pstmt4.setLong(1, transfeescollectionid);
				pstmt4.setString(2, feescollectionobj.getDiscountuserid());
				pstmt4.setString(3,feescollectionobj.getDiscountamountid());
				//pstmt4.setString(4, feescollectionobj.getPaidamount()) ;
				pstmt4.setString(4, datetime.showTime("databaseinsert"));
				pstmt4.setString(5, "A");
				result = pstmt4.executeUpdate();
			}}
			
			query2 	= "insert into transportfeescollectiondetails(transportfeescollectionid,transportstageamountallocationid,discountamountid,dateofcreation,transportfeescollectiondetailsstatus) values(?,?,?,?,?)";
			pstmt3 	= connection.prepareStatement(query2);
			
			
			
			for(int y=0;y<feescollectionobj.getTransportstageamountallocationid().length;y++){
				
					if(!feescollectionobj.getTransportstageamountallocationid()[y].equals(""))
					{
						pstmt3.setLong(1, transfeescollectionid);
						pstmt3.setString(2, feescollectionobj.getTransportstageamountallocationid()[y]);
						if(feescollectionobj.getDiscountamountid().equals("-"))
							pstmt3.setString(3, null);
						else
							pstmt3.setString(3, feescollectionobj.getDiscountamountid());
						pstmt3.setString(4, datetime.showTime("databaseinsert"));
						pstmt3.setString(5, "A");
						//System.out.println("transportfeescollectiondetails"+pstmt3);
						pstmt3.addBatch();
					}
				
				}
			
			
			
			temp		= pstmt3.executeBatch();	
			
			if(temp != null && temp.length>0)
				for(int y=0;y<temp.length;y++)
					result += temp[y];
			
			ret_transportfeescollectionid = String.valueOf(transfeescollectionid);
						
			connection.commit();
		}catch(Exception e){e.printStackTrace();
		
		   if(connection != null)
				connection.rollback();
		} finally {
			
			
			if (pstmt3  != null)
				pstmt3.close();
			
			if (pstmt4 != null)
				pstmt4.close();
			

			if (pstmt2 != null)
				pstmt2.close();
			
			if (pstmt1 != null)
				pstmt1.close();
			
			if(recptidrs != null)
				recptidrs.close();
			
			if(appidrs != null)
				appidrs.close();


			if (connection != null)
				connection.close();

		}
		
		if(result >0)
		{
			return ret_transportfeescollectionid;
		}
		else
		{
			return "empty";
		}
		
	}
	
	

	
	
	
	CommonDataAccess common_data_object;
	String insert_query;
	String select_query;
	int return_value;
	Connection connection;
	DateTime datetime;
}