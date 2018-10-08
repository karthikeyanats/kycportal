package com.iGrandee.core.filtter;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SendRedirectOverloadedResponse extends HttpServletResponseWrapper {
	private HttpServletRequest m_request;
	private String prefix = null;

	final static Logger Log = LoggerFactory
			.getLogger(SendRedirectOverloadedResponse.class);

	public SendRedirectOverloadedResponse(HttpServletRequest inRequest,
			HttpServletResponse response) {
		super(response);
		setRequest(inRequest);
		prefix = getPrefix(inRequest);
	}

	public void sendRedirect(String location) throws IOException {
		//Log.info("Going originally to:" + location);
		//Log.trace("Going originally to:" + location);
		String finalurl = null;

		if (isUrlAbsolute(location)) {
			//Log.trace("This url is absolute. No scheme changes will be attempted");
			//Log.info("This url is absolute. No scheme changes will be attempted");
			finalurl = location;
		} else {
			finalurl = fixForScheme(prefix + location);
			//Log.trace("Going to absolute url:" + finalurl);
			//Log.info("Going to absolute url:" + finalurl);
		}
		super.sendRedirect(finalurl);
	}

	public boolean isUrlAbsolute(String url) {
		String lowercaseurl = url.toLowerCase();
		if (lowercaseurl.startsWith("http") == true) {
			return true;
		} else {
			return false;
		}
	}

	public String fixForScheme(String url) {
		// alter the url here if you were to change the scheme
		//Map<String, List<String>> params = getQueryParams(url);
		//Log.debug("Params",params);
		StringBuffer returnUrl = new StringBuffer(url);
		if(StringUtils.contains(url, "returnurl="))
		{
			returnUrl = new StringBuffer(StringUtils.substring(url,0, 
					StringUtils.indexOf(url, "returnurl=")));
			
			returnUrl.append("returnurl=");
			String returnurl = StringUtils.substring(url, 
					StringUtils.indexOf(url, "returnurl=")+10);
			
			try {
				returnUrl.append(URLEncoder.encode(new String(Base64.encodeBase64(returnurl.getBytes())),"UTF-8"));
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return returnUrl.toString();
	}
	
	public Map<String, List<String>> getQueryParams(String url) {
	    try {
	        Map<String, List<String>> params = new HashMap<String, List<String>>();
	        String[] urlParts = url.split("\\?");
	        if (urlParts.length > 1) {
	            String query = urlParts[1];
	            for (String param : query.split("&")) {
	                String[] pair = param.split("=");
	                String key = URLDecoder.decode(pair[0], "UTF-8");
	                String value = "";
	                if (pair.length > 1) {
	                    value = URLDecoder.decode(pair[1], "UTF-8");
	                }

	                List<String> values = params.get(key);
	                if (values == null) {
	                    values = new ArrayList<String>();
	                    params.put(key, values);
	                }
	                values.add(value);
	            }
	        }

	        return params;
	    } catch (UnsupportedEncodingException ex) {
	        throw new AssertionError(ex);
	    }
	}	

	public String getPrefix(HttpServletRequest request) {
		StringBuffer str = request.getRequestURL();
		String url = str.toString();
		String uri = request.getRequestURI();
		//Log.info("requesturl:" + url);
		//Log.info("uri:" + uri);
		//Log.trace("requesturl:" + url);
		//Log.trace("uri:" + uri);
		int offset = url.indexOf(uri);
		String prefix = url.substring(0, offset);
	//	Log.trace("prefix:" + prefix);
		//Log.info("prefix:" + prefix);
		return prefix;
	}

	/**
	 * @return the m_request
	 */
	public HttpServletRequest getRequest() {
		return m_request;
	}

	/**
	 * @param m_request
	 *            the m_request to set
	 */
	private void setRequest(HttpServletRequest m_request) {
		this.m_request = m_request;
	}
}
