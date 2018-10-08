package com.iGrandee.MasterEntries.Board;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.iGrandee.MasterEntries.Board.BoardBean;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.sql.Date;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionInfo;
import org.apache.log4j.Logger;

public class BoardEntry
{
	static Logger log = Logger.getLogger(BoardEntry.class);

    public BoardEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        boardbean = new BoardBean();
        boardcon      = null;


        select_query = null;
    }
    /**
	   * This method is accessed from kycportal/jsp/masterentries/Board/BoardSubmit.jsp
	   * insert board details      - prasanth
	   @param  boardid that can be inserted to board table
	   * 
	   @param boardname that can be inserted to board table
	   *
	   @param description that can be inserted to board table
	   *
	   @param dateofcreation that can be inserted to board table
	   *
	   @param createdby that can be inserted to board table
	   *
	   @param instituteid that can be inserted to board table
	   *
	   @param ipaddress that can be inserted to board table
	   *
	   @param boardstatus that can be inserted to board table
	   *
	   @param mediumid that can be inserted to board table
	   *
	    @return   int for    printed the result on the screen 
	 */
    public int insertBoards()throws SQLException
    {
		int result=0;

    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		ResultSet rs1						= null;


        try
    	{
        	log.info("invoking insertBoards from com.iGrandee.MasterEntries.Board.BoardEntry");
        boardcon = ConnectionManager.getKycConnection();
		
        String str			= "select a.boardname from board a,standardmedium b  where a.boardname=? and b.instituteid=? and b.mediumid=? and b.mediumstatus='A' and a.mediumid=b.mediumid and a.instituteid=b.instituteid and a.boardstatus <> ? ";
        instituteprepared	= boardcon.prepareStatement(str);
        instituteprepared.setString(1, boardbean.getboardname().toLowerCase());
        instituteprepared.setString(2, boardbean.getinstituteid());
        instituteprepared.setString(3, boardbean.getmediumid());
        instituteprepared.setString(4, "X");
        rs1	= instituteprepared.executeQuery(); 
        if(!rs1.next())
        {
        
        
        long l = common_data_object.fmaxId("select max(boardid)from board");
		String query="insert into board (boardid,boardname,description,dateofcreation,createdby,instituteid,ipaddress,boardstatus,mediumid) values(?,?,?,?,?,?,?,?,?)";
		settingsprepared = boardcon.prepareStatement(query);
		
		
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,boardbean.getboardname());
		settingsprepared.setString(3,boardbean.getDescription());
		settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(5, boardbean.getCreatedBy());
		settingsprepared.setString(6, boardbean.getinstituteid());
		settingsprepared.setString(7, boardbean.getIpaddess());
		settingsprepared.setString(8, "A");
		settingsprepared.setString(9, boardbean.getmediumid());



		result = settingsprepared.executeUpdate();
        }
        else
        {
        	result=1000;
        }
    	}catch(Exception exception) { 
			
    		log.error(exception);				
		}
		
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(boardcon != null)
				boardcon.close();
			
			if(instituteprepared != null)
				instituteprepared.close();
			
			if(rs1 != null)
				rs1.close();
			
		}
return result;
}
   
  
   
    /**
	   * This method is accessed from kycportal/jsp/masterentries/Board/BoardList.jsp
	   * list all active board      - prasanth
	   @param  mediumid that can be used to get all details from board
	   *
	   @param instituteid that can be used to get all details from board
	   *
	   @return   ArrayList for    printed the result on the screen 
	 */
    public ArrayList get_All_boards(String mediumid,String instituteid)
    {
		ArrayList list=null;
	
		
		try
		{
			log.info("invoking get_All_boards from com.iGrandee.MasterEntries.Board.BoardEntry");
			select_query="select boardid,instituteid,boardname,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,boardstatus from board where boardstatus='A' and mediumid='"+mediumid+"' and instituteid='"+instituteid+"' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
			
			
				
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);					
			}
	    	finally
			{
				
			}
	    	return list;
	    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/Board/BoardTrash.jsp
	    * change board status as T(Trash)      - prasanth
	    * @param  boardstatus that can be used to update all details to board by boardid wise
	    * 
	    @param dateofcreation that can be used to update all details to board by boardid wise
	    *
	    @param ipaddress that can be used to update all details to board by boardid wise
	    *
	    @param createdby that can be used to update all details to board by boardid wise
	    *
	    @param instituteid that can be used to update all details to board by boardid wise
	    *
	    @param boardid that can be used to update all details to board by boardid wise
	    *
	    @return   int for    printed the result on the screen 
	 */
    public int Updatetashboards() throws SQLException
    {
    	String boardstatus=boardbean.getboardstatus();
    	String boardid=boardbean.getboardid();
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

		
    	int rs=0;
    	try
    	{
    		log.info("invoking Updatetashboards from com.iGrandee.MasterEntries.Board.BoardEntry");
            boardcon = ConnectionManager.getKycConnection();

            
        	String query="update board set boardstatus=?,dateofcreation=?,ipaddress=?,createdby=?,instituteid=? where boardid=?";
			settingsprepared = boardcon.prepareStatement(query);
			settingsprepared.setString(1, boardstatus);
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, boardbean.getIpaddess());
			settingsprepared.setString(4, boardbean.getCreatedBy());
			settingsprepared.setString(5, boardbean.getinstituteid());
			settingsprepared.setString(6,boardid);
			rs = settingsprepared.executeUpdate();
    	}
    		
			catch(Exception exception)
			{ 
					
				log.error(exception);						
				}
		    	finally
				{
					if(settingsprepared != null)
						settingsprepared.close();
					
					if(boardcon != null)
						boardcon.close();
				}
		    	return rs;
		    }
    /**
	   * This method is accessed from kycportal/jsp/masterentries/Board/BoardTrashListview.jsp
	   * list all  board trash list      - prasanth
	   @param  mediumid that can be used to get all details to board
	   * 
	   @param instituteid that can be used to get all details to board
	   * 
	    @return   ArrayList for    printed the result on the screen 
	 */
    public ArrayList get_All_boardTrashList(String mediumid,String instituteid)
    {
		ArrayList list=null;
		try
		{
			log.info("invoking get_All_boardTrashList from com.iGrandee.MasterEntries.Board.BoardEntry");
			select_query="select boardid,instituteid,boardname,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,boardstatus from board where boardstatus='T' and mediumid='"+mediumid+"' and instituteid='"+instituteid+"' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{log.error(exception);	
		}
		return list;
	}
    /**
	   * This method is accessed from kycportal/jsp/masterentries/Board/BoardDeactive.jsp
	   * get all board deactive list      - prasanth
	    @param  mediumid that can be used to get all details to board
	    * 
	    @param instituteid that can be used to get all details to board
	    * 
	    @return   ArrayList for  printed the result on the screen 
	 */
    public ArrayList get_All_boardDeactivateList(String mediumid,String instituteid)
    {
		ArrayList list=null;
		try
		{
			log.info("invoking get_All_boardDeactivateList from com.iGrandee.MasterEntries.Board.BoardEntry");
			select_query="select boardid,instituteid,boardname,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,boardstatus from board where boardstatus='D' and mediumid='"+mediumid+"' and instituteid='"+instituteid+"' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);	
		}
		return list;
	}
    /**
	   * This method is accessed from kycportal/jsp/masterentries/Board/BoardDelete.jsp
	   * change board status as X (Delete)      - prasanth
	   @param  boardstatus that can be used to update all details to board by boardid wise
	   * 
	   @param dateofcreation that can be used to update all details to board by boardid wise
	   *
	   @param ipaddress that can be used to update all details to board by boardid wise
	   *
	   @param createdby that can be used to update all details to board by boardid wise
	   *
	   @param instituteid that can be used to update all details to board by boardid wise
	   *
	   @param boardid that can be used to update all details to board by boardid wise
	   *
	   @return   int for    printed the result on the screen
	 */
    public int Deleteboards()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;

    	int rs=0;

    	
    	try
    	{
    		log.info("invoking Deleteboards from com.iGrandee.MasterEntries.Board.BoardEntry");
        	String boardid=boardbean.getboardid();

            boardcon = ConnectionManager.getKycConnection();

			String query="update board set boardstatus=?,dateofcreation=?,ipaddress=?,createdby=?,instituteid=?  where boardid=? ";
			settingsprepared = boardcon.prepareStatement(query);

			settingsprepared.setString(1, "X");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, boardbean.getIpaddess());
			settingsprepared.setString(4, boardbean.getCreatedBy());
			settingsprepared.setString(5, boardbean.getinstituteid());
			settingsprepared.setString(6,boardid);
			
			rs = settingsprepared.executeUpdate();



    		
    	}
    	catch(Exception exception) { 
			
    		log.error(exception);				
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(boardcon != null)
				boardcon.close();
		}
    	return rs;
    }
    /**
	   * This method is accessed from kycportal/jsp/masterentries/Board/BoardDeactiveFinal.jsp
	   * change board status as D (Deactive)      - prasanth
	   @param  boardstatus that can be used to update all details to board
	   *
	   @param dateofcreation that can be used to update all details to board
	   *
	   @param ipaddress that can be used to update all details to board
	   *
	   @param createdby that can be used to update all details to board
	   *
	   @param instituteid that can be used to update all details to board
	   *
	   @param boardid that can be used to update all details to board
	   *
	   @return   int for    printed the result on the screen
	 */
    public int boardsDeactivate()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
    	
    	
    	try
    	{
    		log.info("invoking boardsDeactivate from com.iGrandee.MasterEntries.Board.BoardEntry");

        	String boardid=boardbean.getboardid();

            boardcon = ConnectionManager.getKycConnection();

			String query="update board set boardstatus=? ,dateofcreation=?,ipaddress=?,createdby=?,instituteid=?  where boardid=? ";
			settingsprepared = boardcon.prepareStatement(query);

			settingsprepared.setString(1, "D");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, boardbean.getIpaddess());
			settingsprepared.setString(4, boardbean.getCreatedBy());
			settingsprepared.setString(5, boardbean.getinstituteid());
			settingsprepared.setString(6,boardid);
			rs = settingsprepared.executeUpdate();



    		
    	}
    	catch(Exception exception) { 
			
    		log.error(exception);				
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(boardcon != null)
				boardcon.close();
		}
    	return rs;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/Board/BoardEditUpdate.jsp
	    * updatee board details      - prasanth
	    @param  boardstatus that can be used to update all details to board by boardid wise
	    * 
	    @param dateofcreation that can be used to update all details to board by boardid wise
	    *
	    @param ipaddress that can be used to update all details to board by boardid wise
	    *
	    @param createdby that can be used to update all details to board by boardid wise
	    *
	    @param instituteid that can be used to update all details to board by boardid wise
	    *
	    @param boardid that can be used to update all details to board by boardid wise
	    *
	    @return   int for    printed the result on the screen
	 */
    public int UpdateEdittboards()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		ResultSet rs1						= null;

    	int rs=0;
    	
    	
    	try
    	{
    		log.info("invoking UpdateEdittboards from com.iGrandee.MasterEntries.Board.BoardEntry");
        	String boardname=boardbean.getboardname();
        	String boardid=boardbean.getboardid();
        	String boarddeci=boardbean.getDescription();
    		String mediumid=boardbean.getmediumid();
    		
            boardcon = ConnectionManager.getKycConnection();


            
            String str			= "select a.boardname from board a,standardmedium b where a.boardname=?  and a.instituteid=? and a.instituteid=b.instituteid  and b.mediumid =? and a.mediumid=b.mediumid and b.mediumstatus= ? and   a.boardstatus <> ? and a.boardid <> ?";
            instituteprepared	= boardcon.prepareStatement(str);
            instituteprepared.setString(1, boardname.toLowerCase());
            instituteprepared.setString(2, boardbean.getinstituteid());
            instituteprepared.setString(3,mediumid);
            instituteprepared.setString(4, "A");
            instituteprepared.setString(5, "X");
            instituteprepared.setString(6, boardid);
            rs1	= instituteprepared.executeQuery();
            
            if(!rs1.next())
            {
            	
            
			String query="update board set boardname=?, dateofcreation=?,description=?,ipaddress=?,createdby=?,instituteid=?  where boardid=? ";
			settingsprepared = boardcon.prepareStatement(query);
			
			settingsprepared.setString(1, boardname);
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3,boarddeci);
			settingsprepared.setString(4, boardbean.getIpaddess());
			settingsprepared.setString(5, boardbean.getCreatedBy());
			settingsprepared.setString(6, boardbean.getinstituteid());
			settingsprepared.setString(7,boardid);

			rs = settingsprepared.executeUpdate();

            }
            else
            {
            	rs=1000;
            }

    		
    	}
    	catch(Exception exception) { 
			
    		log.error(exception);
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(boardcon != null)
				boardcon.close();
			
			if(instituteprepared != null)
				instituteprepared.close();
			
			if(rs1 != null)
				rs1.close();
			
		}
    	return rs;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/Board/BoardActive.jsp
	    * change board status as A (Active)      - prasanth
	    @param  boardstatus that can be used to update all details to board by boardid wise
	    *
	    @param dateofcreation that can be used to update all details to board by boardid wise
	    *
	    @param ipaddress that can be used to update all details to board by boardid wise
	    *
	    @param createdby that can be used to update all details to board by boardid wise
	    *
	    @param instituteid that can be used to update all details to board by boardid wise
	    *
	    @param boardid that can be used to update all details to board by boardid wise
	    *
	    @return   int for    printed the result on the screen
	 */
    public int Restoreboards() throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	
    	
		
    	try
    	{
    		log.info("invoking Restoreboards from com.iGrandee.MasterEntries.Board.BoardEntry");
        	String boardid=boardbean.getboardid();
            boardcon = ConnectionManager.getKycConnection();

    			String query="update board set boardstatus=?, dateofcreation=?,ipaddress=?,createdby=?,instituteid=?  where boardid=? ";
    			settingsprepared = boardcon.prepareStatement(query);
    			settingsprepared.setString(1, "A");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, boardbean.getIpaddess());
    			settingsprepared.setString(4, boardbean.getCreatedBy());
    			settingsprepared.setString(5, boardbean.getinstituteid());
    			settingsprepared.setString(6,boardid);

    		
    			rs = settingsprepared.executeUpdate();

		}catch(Exception exception) { 
			
			log.error(exception);				
		}
		finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(boardcon != null)
				boardcon.close();
		}
    	return rs;
    }
    /**
	  * This method is accessed from kycportal/jsp/masterentries/Board/BoardRestore.jsp
	  * change board status as A(Restore)      - prasanth
	    @param  boardstatus that can be used to update all details to board by boardid wise
	    *
	    @param dateofcreation that can be used to update all details to board by boardid wise
	    *
	    @param ipaddress that can be used to update all details to board by boardid wise
	    *
	    @param createdby that can be used to update all details to board by boardid wise
	    *
	    @param instituteid that can be used to update all details to board by boardid wise
	    *
	    @param boardid that can be used to update all details to board by boardid wise
	    *
	    @return   int for    printed the result on the screen
	 */
    public int Activeboards() throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	
    	
		
    	try
    	{
    		log.info("invoking Activeboards from com.iGrandee.MasterEntries.Board.BoardEntry");
        	String boardid=boardbean.getboardid();
            boardcon = ConnectionManager.getKycConnection();

    			String query="update board set boardstatus=?, dateofcreation=?,ipaddress=?,createdby=?,instituteid=?  where boardid=? ";
    			settingsprepared = boardcon.prepareStatement(query);
    			settingsprepared.setString(1, "A");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, boardbean.getIpaddess());
    			settingsprepared.setString(4, boardbean.getCreatedBy());
    			settingsprepared.setString(5, boardbean.getinstituteid());
    			settingsprepared.setString(6,boardid);

    		
    			rs = settingsprepared.executeUpdate();

		}catch(Exception exception) { 
			
			log.error(exception);				
		}
		finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(boardcon != null)
				boardcon.close();
		}
    	return rs;
    }
    /**
	   * This method is accessed from kycportal/jsp/masterentries/Board/BoardTrashPriview.jsp
	   * check No of  Standards  in this Board      - prasanth
	   @param  instituteid that can be used to count no of board allocated count
	   *
	   @param boardid that can be used to count no of board allocated count
	   *
	   @return   int for    printed the result on the screen
	 */
    public String checkTrashBoards(String instituteid)
    {
    	String list=null;
		try
		{log.info("invoking check No of  Standards  in this Board  from com.iGrandee.MasterEntries.Board.BoardEntry");
			String boardid=boardbean.getboardid();
			select_query="select count(b.boardid) as boardcount from board a,standard b where a.boardid=b.boardid and a.instituteid=b.instituteid and a.boardid='"+boardid+"' and a.instituteid='"+instituteid+"'";

			list=common_data_object.getString(select_query);
		}
		catch(Exception exception)
		{log.error(exception);	
		}
		return list;
	}
    /**
	   * This method is accessed from kycportal/jsp/masterentries/Board/checkDuplicate.jsp
	   * check duplicate boards(update)      - prasanth
	   @param  boardname  that can be used to check duplicate names in board
	   *
	   @param boardid that can be used to check duplicate names in board
	   *
	   @param instituteid that can be used to check duplicate names in board
	   *
	   @param mediumid that can be used to check duplicate names in board
	   *
	   @return   boolean for    printed the result on the screen
	 */
    public boolean checkDuplicateupdate(String boardname,String boardid,String instituteid,String mediumid)
    {
    	boolean return_flag = false;
    	String return_string = null;
    	try
    	{
    		log.info("invoking checkDuplicateupdate from com.iGrandee.MasterEntries.Board.BoardEntry");
    		String select_query = "SELECT boardname FROM board a,standardmedium b  where a.boardname='"+boardname+"' and a.instituteid='"+instituteid+"' and a.instituteid=b.instituteid and b.mediumid='"+mediumid+"' and a.mediumid=b.mediumid and b.mediumstatus='A' and a.boardstatus='A' and  a.boardid <> '"+boardid+"' " ;
    		return_string = common_data_object.getString(select_query);
    		if(return_string ==null || return_string.equalsIgnoreCase("null") || return_string.equals("")) {
    			return_flag = false;
    		}
    		else
    		{
    			return_flag = true;
    		}
    	}
    	catch(Exception e)
    	{
    		e.printStackTrace();
    	}
    	return return_flag;
    }
    /**
	   * This method is accessed from kycportal/jsp/masterentries/Board/checkDuplicate.jsp
	   * check duplicate boards  (entry)    - prasanth
	   @param  tablename that can be used to check duplicate names in board
	   *
	   @param columnname that can be used to check duplicate names in board
	   *
	   @param fieldname that can be used to check duplicate names in board
	   *
	   @param status that can be used to check duplicate names in board
	   *
	   @param instituteid that can be used to check duplicate names in board
	   *
	   @param mediumid that can be used to check duplicate names in board
	   *
	   @return   boolean for    printed the result on the screen
	 */
    public boolean checkDuplicatewithstatus(String tablename,String columnname,String fieldname,String status,String instituteid,String mediumid)
	{
		boolean return_flag = false;
		String return_string = null;
		try
		{
			log.info("invoking checkDuplicateupdate from com.iGrandee.MasterEntries.Board.BoardEntry");
			String select_query = "select a."+columnname+" from "+tablename+" a,standardmedium b  where a."+columnname+"='"+fieldname+"' and b.instituteid='"+instituteid+"' and b.mediumid='"+mediumid+"' and b.mediumstatus='A' and a.mediumid=b.mediumid and a.instituteid=b.instituteid and a."+status+" <> 'X' ";
    		return_string = common_data_object.getString(select_query);
			if(return_string ==null || return_string.equalsIgnoreCase("null") || return_string.equals(""))
			{
				return_flag = false;
			}
			else {
				return_flag = true;
			}

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return return_flag;
	}
    /**
	   * This method is accessed from kycportal/jsp/masterentries/Board/BoardUpdateByClick.jsp
	   * To display all board lists  - prasanth
	 
	   @param  boardid   that can be get all boardname  ,description details from  board table by boardid wise
	   *               
	   @return  the ArrayList for    printed the details on the screen 
	 */
 public ArrayList getDetailsForuadate(String boardid)
 {
		ArrayList list=null;
		try
		{log.info("invoking get_All_BoardList from com.iGrandee.MasterEntries.Board.BoardEntry");
			select_query="select boardid,boardname,description from board where boardid='"+boardid+"' and  boardstatus='A'";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);
		}
		return list;
	}
    DateTime date_object;
    Connection boardcon;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    BoardBean boardbean;
    String select_query;
    Statement stmt;
    ResultSet rs;
}