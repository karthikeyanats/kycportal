package com.iGrandee.Common;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ResourceBundle;

public abstract class ConnectionInfo
{
      

    public void makeConnection()
    {
        try
        {
            virtual_dbCon = ConnectionManager.getKycConnection();
        }
        catch(Exception es)
        {
			es.printStackTrace();
        }
    }

    public void makeVirtualConnection()
    {
        try
        {
            vd_db_connection = ConnectionManager.getVirtualDConnection();
        }
        catch(Exception se)
        {
        }
    }
    
    public void takeDown()throws SQLException
    {
        try
        {
            if(virtual_dbCon != null)
                ConnectionManager.closeConnection(virtual_dbCon);
        }
        catch(Exception se)
        {
        }
    }
    public void takeVirtualDown()
    throws SQLException
{
    try
    {
        if(vd_db_connection != null)
            vd_db_connection.close();
    }
    catch(SQLException se)
    {
    }
}
    public Connection checkVirtualDConnection()
    {
		try
		{
			vd_db_connection = ConnectionManager.getVirtualDConnection();
		}
		catch(Exception se)
		{
		}
		return vd_db_connection;
    }

  public Connection checkConnection()
  {
	try
	{
		virtual_dbCon = ConnectionManager.getKycConnection();
	}
	catch(Exception es)
	{

	}return virtual_dbCon;
  }
    public abstract void cleanup()
        throws SQLException;

  
  
    ResourceBundle resourcebundle;
    protected Connection virtual_dbCon;
    protected Connection vd_db_connection;
    

}