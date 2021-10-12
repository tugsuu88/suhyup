<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<%@ page contentType="text/html;charset=euc-kr" %>

<%@ page import="board.board2.DataFileInfo" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="DataMgr" scope="request" class="board.board2.DataMgr"/>
<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>

<%

	try {	

		DataSource ds = null;
		Connection conn = null;
		ResultSet rs = null;
		ResultSetMetaData meta = null;
		PreparedStatement pstmt=null;

		String savePath = application.getRealPath("/upload/minwon"); //폴더 얻기	

		int sizeLimit = 5 * 1024 * 1024 ; // 5메가까지 제한 넘어서면 예외발생
 		Vector filenames = new Vector();


	 	MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy()); 

	 	String file_no1 = "";
		String sh_content = "";

		file_no1 = multi.getParameter("file1");
		sh_content = multi.getParameter("sh_content");

	 	String file1 = multi.getFilesystemName("file1");
  		String ofile1 = multi.getOriginalFileName("file1");
		String sa_name = multi.getParameter("sa_name");

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
 		
   		///////////////////////////////////////////////////
		Enumeration  e = multi.getFileNames(); 
		e.hasMoreElements() ;
		String strName = (String) e.nextElement();
		String fileName = multi.getFilesystemName(strName);					
        
		String midstr=FrontBoard.OnlyOne("Select Max(sh_no) from sh_minwon_result");
		if(midstr == null || midstr.equals("")){
			midstr = "0";
		}
		int mid = Integer.parseInt(midstr) + 1;


		String midstr1=FrontBoard.OnlyOne("Select Max(sh_fileno) from sh_minwon_result");
		if(midstr1 == null || midstr1.equals("")){
			midstr1 = "0";
		}
		int fileno = Integer.parseInt(midstr1) + 1;



		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();

		String sql = "";	
		
		sql  = " insert into sh_minwon_result( ";
		sql += " sh_no, sh_name, sh_content, sh_fileno, sh_file_name, sh_indate";
		sql += " ) values ( ";
		sql += " ?,?,?,?,?,sysdate";					
		sql += " )";

		pstmt=conn.prepareStatement(sql);

		pstmt.setInt(1,mid);
		pstmt.setString(2,sa_name);
		pstmt.setString(3,sh_content);
		pstmt.setInt(4,fileno);
		pstmt.setString(5,fileName);
					
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();

	}catch (Exception e){
		out.println(e.toString());
	}

%>
<script language="javascript">
<!--
  	alert("등록 되었습니다.");
	self.location = "result.jsp";
//-->
</script>