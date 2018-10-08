package com.iGrandee.Common;


public class CharacterConvertor
{

    public CharacterConvertor()
    {
    }
    
    public static synchronized String setForXML(String inputstring)
    {
    	StringBuffer outputstring = new StringBuffer("");
    	if(inputstring != null)
    	{
    		for(int i = 0; i < inputstring.length(); i++)
    		{
    			char c = inputstring.charAt(i);
    			if(c == '\'')
    				outputstring.append("&#39;");
    			else if(c == '"')
    				outputstring.append("&quot;");
    			else if(c == '&')
    				outputstring.append("&amp;");
    			else if(c == '<')
    				outputstring.append("&lt;");
    			else if(c == '>')
    				outputstring.append("&gt;");
    			else if(c == '\u03B2')
    				outputstring.append("&beta;");
    			else if(c == '\u03BC')
    				outputstring.append("&mu;");
    			else if(c == '\u00B0')
    				outputstring.append("&deg;");
    			else if(c == '\u00B2')
    				outputstring.append("&sup2;");
    			else if(c == '\u00B3')
    				outputstring.append("&sup3;");
    			else if(c == '\u03B1')
    				outputstring.append("&alpha;");
    			else if(c == '\u03C3')
    				outputstring.append("&sigma;");
    			else if(c == '\u03C0')
    				outputstring.append("&pi;");
    			else if(c == '\u03B8')
    				outputstring.append("&theta;");
    			else if(c == '\u03B3')
    				outputstring.append("&gamma;");
    			else
    				outputstring.append(c);
    		}
    	}

    		return outputstring.toString();
    	}
    public static synchronized String setForString(String inputstring)
    {
    	if(inputstring != null)
    	{
    		
    		inputstring		= inputstring.replaceAll("&#39;", "'");
    		inputstring		= inputstring.replaceAll("&quot;", "\"");
    		inputstring		= inputstring.replaceAll("&amp;", "&");
    		inputstring		= inputstring.replaceAll("&lt;", "<");
    		inputstring		= inputstring.replaceAll("&gt;", ">");

    	}
		return inputstring;
    
    }
    
    }    





