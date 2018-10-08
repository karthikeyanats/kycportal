package com.iGrandee.Password;

import java.util.ArrayList;
import java.util.HashMap;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.SQLException;
import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.DateTime;

import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.MasterEntries.Standard.StandardQuery;

// Referenced classes of package com.iGrandee.Common:
//            CommonDataAccess

public class PasswordQuery {
	static Logger log = Logger.getLogger(PasswordQuery.class);

	public PasswordQuery() {
		common_data_object = new CommonDataAccess();
	}

			public int ResultPublishUpdate(String examallotmentid) throws SQLException {
		int result = 0;
		PreparedStatement pstmt = null;
	 	log.info("invoking ResultPublishUpdate for Result Publish update Status");
		String Query = "";
		Connection connection = null;
		try {
			connection = ConnectionManager.getKycConnection(); 
			connection.setAutoCommit(false);
			Query = "update  examschedule set  markpublishstatus=? ,examschedulestatus=? where examallotmentid=? ";
			pstmt = connection.prepareStatement(Query);
			pstmt.setString(1,"A");
			pstmt.setString(2,"R");
			pstmt.setString(3, examallotmentid);
			log.info(pstmt);
		    result += pstmt.executeUpdate();
			connection.commit();
			
		} catch (Exception exception) {
			connection.rollback();
				log.error(exception);
			return 0;
		} finally {
			if (pstmt != null)
				pstmt.close();
			
			if (connection != null)
				connection.close();
			
		}
		return result;
	}
			

		public int updateChangePassword(String username,String password) throws SQLException {
			int result = 0;
			
			PreparedStatement pstmt7 = null;

			
		 	log.info("invoking Studentpersonalcontactupdate for Student contact update");

			String Query = "";
			Connection connection = null;

			try {
				connection = ConnectionManager.getKycConnection(); 
				connection.setAutoCommit(false);
				Query = "update  login set  password=?,loginstatus=? where username=?";
				pstmt7 = connection.prepareStatement(Query);

				//Password encryption is done here
				password 	= com.iGrandee.Common.PasswordService.getInstance().encrypt(password);

				pstmt7.setString(1, password);
				pstmt7.setString(2, "A");
				pstmt7.setString(3, username);

				result += pstmt7.executeUpdate();
				log.info("personaddressupdate================>>");
			
				connection.commit();
				
			} catch (Exception exception) {
				connection.rollback();
					log.error(exception);
				return 0;
			} finally {
			
				if (pstmt7 != null)
					pstmt7.close();
				
				if (connection != null)
					connection.close();
				
			}
			return result;
		}
		public int updateChangePasswordforparent(String username,String password) throws SQLException {
			int result = 0;
			
			PreparedStatement pstmt7 = null;

			
		 	log.info("invoking updateChangePasswordforparent for Student Parent Password update");

			String Query = "";
			Connection connection = null;

			try {
				connection = ConnectionManager.getKycConnection(); 
				connection.setAutoCommit(false);
				Query = "update  parentlogin set  parentpassword=?,parentstatus=? where parentusername=?";
				pstmt7 = connection.prepareStatement(Query);
				//Password encryption is done here
				password 	= com.iGrandee.Common.PasswordService.getInstance().encrypt(password);
				pstmt7.setString(1, password);
				pstmt7.setString(2, "A");
				pstmt7.setString(3, username);

				result += pstmt7.executeUpdate();
				log.info("personaddressupdate================>>");
			
				connection.commit();
				
			} catch (Exception exception) {
				connection.rollback();
					log.error(exception);
				return 0;
			} finally {
			
				if (pstmt7 != null)
					pstmt7.close();
				
				if (connection != null)
					connection.close();
				
			}
			return result;
		}

	CommonDataAccess common_data_object;
	DateTime datetime;
	 
	
}