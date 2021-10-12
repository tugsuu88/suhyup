<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="Bean.Common.Log" %>
<jsp:useBean id="Board" scope="session" class="Bean.admin.BoardType1"/>
<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>

<%! public String name_replace(String line, String oldString, String newString) { 
        int index = 0; 
        while ((index = line.indexOf(oldString, index)) >= 0) { 
            line = line.substring(0, index) + newString + line.substring(index + oldString.length()); 
            index += newString.length(); 
        } 
        return line; 
    }
%>  

<%
	InputStream in	= null;
	OutputStream os	= null;
	File file = null;
	boolean skip = false;
	String client = "";
	
	try {

		//String fname = "";
		
		String path = application.getRealPath("/upload/financetrouble"); //폴더 얻기
		
		String thid = request.getParameter("thid");
		String file_no = request.getParameter("file_no");
		
		String file_name = "";
		
		String TableName = " sh_financetrouble ";
	   	String SelectCondition = " sh_fileno, thid, sh_file_name";
		String WhereCondition  = " where thid =  " + Integer.parseInt(thid); 
		if(!file_no.equals("")){
			WhereCondition +=  " and sh_fileno = " + Integer.parseInt(file_no);
		}
		String OrderCondition  = " ORDER BY sh_fileno ";
		//Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 1, 0, 0);
		Vector ResultVector = Board.EditQuery(TableName, SelectCondition, WhereCondition);
		
		if( ResultVector.size() > 0){
			for (int i=0; i < ResultVector.size();i++){
				Hashtable h = (Hashtable)ResultVector.elementAt(i);
				
				file_name = (String)h.get("SH_FILE_NAME");
				file_name= file_name.replaceAll("/","");
			//	file_name= file_name.replaceAll("\\","");
			//	file_name= file_name.replaceAll(".","");
			//	file_name= file_name.replaceAll("&","");
				//out.println("file_name : " +file_name + "<br><br>");
			}
		}

		//if(null != fname1)	fname = fname1;
	
		try {
			if (file_name != null) {
				file = new File(path, file_name);
			}
			if (file != null) {
				in = new FileInputStream(file);
			}
		} catch(FileNotFoundException fe) {
			skip = true;
		}

		/*
		String i_fname = "";	//index+
		i_fname = name_replace(file_name,"+","");
		i_fname = java.net.URLEncoder.encode(i_fname,"MS949");//CP949
		//i_fname = java.net.URLEncoder.encode(i_fname,"euc-kr");
		out.println("i_fname : " +i_fname + "<br><br>");
		*/
		
		//한글 파일명이 깨질경우 - 200711.14
		try { 
  			file_name = java.net.URLEncoder.encode(file_name, "UTF-8"); 
		} catch (UnsupportedEncodingException e) { 
			Log.message("File Download UnsupportedEncodingException : " + e.getMessage());
		}
		
		response.reset() ;
		client = request.getHeader("User-Agent");
		response.setContentType("application/x-msdownload;");
		response.setHeader("Content-Description", "JSP Generated Data");

		if(!skip){
			if(client.indexOf("MSIE 5.5") != -1){
				response.setHeader("Content-Type", "doesn/matter; charset=euc-kr");
				response.setHeader("Content-Disposition", "filename="+file_name+";");
			} else {
				response.setHeader("Content-Type", "application/octet-stream; charset=euc-kr");
				response.setHeader ("Content-Disposition", "attachment; filename="+file_name+";");
			}
			response.setHeader("Content-Transfer-Encoding", "binary;");
			response.setHeader("Content-Length", ""+file.length());
			response.setHeader("Pragma", "no-cache;");
			response.setHeader("Expires", "-1;");
			
			out.clear(); 
			os = response.getOutputStream();
			byte b[] = new byte[4096]; 
			int leng = 0;
			while( (leng = in.read(b)) > 0 ){
				os.write(b,0,leng);
			}
		} else {
			out.println("<script language='javascript'>");
			out.println("alert('File Downloading Fail !!');");
			out.println("history.back();");
			out.println("</script>");
		}
	} catch(Exception e) {
		Log.message(e.getMessage());
	}
	finally {
		if(in != null) in.close();
		if(os != null) os.close();
	}
%>