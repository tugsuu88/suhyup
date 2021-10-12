<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<%@ page import="oracle.jdbc.driver.OracleResultSet" %>
<%@ page import="oracle.sql.CLOB" %>

<%@ page contentType="text/html;charset=euc-kr" %>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<!-- 20180314 추가 import -->
<%@ page import="board.board2.DataFileInfo" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>

<jsp:useBean id="Board" scope="session" class="Bean.admin.BoardType1"/>
<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>
<%
	String PAGE=Converter.nullchk(request.getParameter("PAGE"));

	try{	
		
		/* 20180314 추가 - 파일 업로드 */
		String savePath = application.getRealPath("/upload/minwon"); //폴더 얻기	

		int sizeLimit = 5 * 1024 * 1024 ; // 5메가까지 제한 넘어서면 예외발생

 		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy()); 
		
 		String file_no1 = "";
 		file_no1 = multi.getParameter("file1");
 		
 		String file1 = multi.getFilesystemName("file1");
		
 		String[] no_ext = { "asp", "php", "cgi", "sh", "php3", "php4", "html", "htm", "inc", "jsp", "exe", "com", "bat", "htc", "hta" };
 		
 		if(file1 != null && !file1.equals("")){

	 		String ext_1 = file1.substring(file1.lastIndexOf('.') + 1);

	 		ext_1 = ext_1.toLowerCase();

	 		for(int i=0; i<no_ext.length; i++){

	 			if( ext_1.equals(no_ext[i]) ){

	 				out.println("<script language='javascript'>");

					out.print("alert('업로드 금지 파일입니다.\\n\\n확인 후 다시 작업하시기 바랍니다.');");

					out.println("history.go(-1);");

					out.println("</script>");

					if ( true ) return;	

	 			}

	 		}

 		}
 		
 		
		int mid=Integer.parseInt(Converter.nullchk(multi.getParameter("mid")));
		String answer=Converter.nullchk(multi.getParameter("answer"));
		answer = answer.replaceAll("'", "\'");
		answer = answer.replaceAll("&", "&amp;");
		answer = answer.replaceAll("\'", "&quot;");
		answer = answer.replaceAll("<", "&lt;");
		answer = answer.replaceAll(">", "&gt;");
		answer = answer.replaceAll("-", "");
	
		String min_gubun=Converter.nullchk(multi.getParameter("min_gubun"));
		String result=Converter.nullchk(multi.getParameter("result"));
		String replyname=(String)session.getAttribute("name");
		String mobile=Converter.nullchk(multi.getParameter("mobile"));
		String conresult="";
		String admintel="";
		String bupin=Converter.nullchk(multi.getParameter("bupin"));
				
		Enumeration  e = multi.getFileNames(); 

		e.hasMoreElements() ;

		String strName = (String) e.nextElement();

		String fileName = multi.getFilesystemName(strName);
		
		String midstr1=FrontBoard.OnlyOne("Select Max(sh_fileno) from sh_minwon");

		if(midstr1 == null || midstr1.equals("")){

			midstr1 = "0";

		}

		int fileno = Integer.parseInt(midstr1) + 1;
		
		DataSource ds = null;
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt=null;
	
		
		
		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();

		String sql = "";
		
		conn.setAutoCommit(false);
		
		if("1".equals(bupin)){
			admintel = "02-2240-5936";
		}else if("2".equals(bupin)){
			admintel = "02-2240-5763";
		}else if("3".equals(bupin)){
			admintel = "02-2240-5936";
		}
		
		SmsMgr sm=new SmsMgr();
		boolean issms=sm.exqute(admintel,mobile,"귀하께서 제기하신 민원에 대한 답변이 등록되었습니다.");

		sql="update sh_minwon set answer_fname=?,result=?,status=?,answer=?,minwon_gubun=?, sh_fileno=?, sh_file_name=?, answer_date=sysdate where mid=?";

		pstmt=conn.prepareStatement(sql);

		pstmt.setString(1,replyname);
		pstmt.setString(2,result);
		pstmt.setString(3,"답변완료");
		pstmt.setString(4,answer);
		pstmt.setString(5,min_gubun);
		pstmt.setInt(6, fileno);
		pstmt.setString(7, fileName);
		pstmt.setInt(8,mid);
		pstmt.executeUpdate();

		pstmt.close();
		conn.commit();
		conn.close();

	}catch (Exception e){
		Log.message(e.getMessage());
	}
	
	
%>
<script language="javascript">
<!--
  	alert("수정 되었습니다.");
	self.location = "madmin_01.jsp?PAGE=<%=PAGE%>";
//-->
</script>
