<%
/*****************************************************************************
*Title			: download.jsp
*@author		: K.H.S
*@date			: 2007-12
*@Description	: 첨부파일 다운로드
*@Copyright		:
******************************************************************************
*수정일		*수정자		*수정사유
*2007-11	K.H.S		한글 파일명이 깨지는 현상
******************************************************************************/
%>

<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="util.*" %>

<%
	InputStream in	= null;
	OutputStream os	= null;
	File file = null;
	boolean skip = false;
	String client = "";

	
	try {
	
		String path = application.getRealPath("/minwon/files/");
		String file_name="";
		file_name = request.getParameter("file_name");
		System.out.println(file_name);
		
		String fileExt="";
		fileExt = file_name.substring(file_name.lastIndexOf(".") + 1);
		
		if("html".equals(fileExt.toLowerCase()) || "jsp".equals(fileExt.toLowerCase()) || "class".equals(fileExt.toLowerCase())|| "xml".equals(fileExt.toLowerCase()) || "properties".equals(fileExt.toLowerCase()) ||file_name.indexOf("./") >= 0 || file_name.indexOf("../") >= 0  ){
			throw new  Exception();
		}
		

		try {
			file = new File(path, file_name);
			in = new FileInputStream(file);
		} catch(FileNotFoundException fe) {
			skip = true;
		}

		try {
  			file_name = java.net.URLEncoder.encode(file_name, "UTF-8");
		} catch (UnsupportedEncodingException e) {
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
		//System.out.println(e);
		out.println("download.jsp : " + e.getMessage());
	}
	finally {
		if(in != null) in.close();
		if(os != null) os.close();
	}
%>