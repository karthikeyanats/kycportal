package com.iGrandee.Common;
/**
 * @author thangadurai_m
 * Copyright (c) 2010 iGrandee Software Technologies
 * Product      	: Virtual Medix v2.0
 * Module       	: eRegister
 * File         	: PasswordService.java
 * Author           : M. Thangadurai
 * Created Date 	: 19-07-2010
 * Modified By  	: M.Thangadurai
 * Modifed Date     : 09-08-2011
 *
 */
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.io.IOException;
import org.apache.log4j.Logger;
import sun.misc.BASE64Encoder;
public final class PasswordService {
	/**
     * Logger for this class
     */
    private static final Logger log = Logger.getLogger(PasswordService.class);

	private static PasswordService instance;
	
	/**
	 * 
	 */
	private PasswordService(){
	}
	
	/**
	 * @param plaintext
	 * @return
	 * @throws NoSuchAlgorithmException
	 * @throws IOException
	 */
	public synchronized String encrypt(String plaintext)throws NoSuchAlgorithmException,IOException {
		MessageDigest md = null;
		if (log.isDebugEnabled()) {
		    log.debug("encrypt(String)sdfsdf - start");
		}
		md = MessageDigest.getInstance("SHA");
		
		md.update(plaintext.getBytes("UTF-8"));
		byte raw[] = md.digest(); 
	    String hash = (new BASE64Encoder()).encode(raw); 
		return hash; 
	}
	
	/**
	 * @return
	 */
	public static synchronized PasswordService getInstance(){
		if(log.isDebugEnabled()){
			log.debug("getInstance()-- Start"); 
		}
		if(instance == null){
			PasswordService returnPasswordService = new PasswordService();
			log.info("New instance created");
			if(log.isDebugEnabled()){
				log.debug("getInstance() - end");
			}
			return returnPasswordService;
		}
		else{
			if(log.isDebugEnabled()){
				log.debug("getInstance() - end");
			}
		}
		return instance;
	}
}
