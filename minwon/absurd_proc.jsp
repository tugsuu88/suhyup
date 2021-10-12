<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<%@ page contentType="text/html;charset=euc-kr" %>

<%@ page import="board.board2.DataFileInfo" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>

<%@ page import="oracle.jdbc.driver.OracleResultSet" %>
<%@ page import="oracle.sql.CLOB" %>

<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>
<jsp:useBean id="DataMgr" scope="request" class="board.board2.DataMgr"/>
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />
<%@ include file="../inc/requestSecurity.jsp" %>
<%
	try {
		DataSource ds = null;
		Connection conn = null;
		ResultSet rs = null;
		ResultSetMetaData meta = null;
		PreparedStatement pstmt=null;
		
		String savePath = application.getRealPath("/upload/financetrouble"); //폴더 얻기
	 	int sizeLimit = 100 * 1024 * 1024 ; // 5메가까지 제한 넘어서면 예외발생
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());

		String vDiscrNo = multi.getParameter("vDiscrNo");		
		if (vDiscrNo == null || "".equals(vDiscrNo)){
%>
			
			<script type="text/javascript">
       		alert("아이핀 인증을 다시 하여 주십시오.");
       		history.go(-1);
			</script>			
<%
			return;
		}		

	    String name = multi.getParameter("name");
		if(name == null || name.equals("")){			

%>			
			<script type="text/javascript">
       		alert("이름을 입력해 주십시오.");
       		history.go(-1);
			</script>			
<%
			return;
		}

		String admintel="02-2240-3383";

		String sh_post_1 = multi.getParameter("sh_post_1");
 		if(sh_post_1 == null) sh_post_1 = "";
		
 		String sh_post_2 = multi.getParameter("sh_post_2");
		if(sh_post_2 == null) sh_post_2 = "";
		
		String zipcode = sh_post_1 + "-" + sh_post_2;
		if(zipcode == null) zipcode ="";

		String addr = multi.getParameter("sh_address_1");
		if(addr == null) addr = "";

		String addr2 = multi.getParameter("sh_address_2");
		if(addr2 == null) addr2 = "";

		String sh_email_1 = multi.getParameter("sh_email_1");
		if(sh_email_1 == null) sh_email_1 = "";

		String sh_email_2 = multi.getParameter("sh_email_2");
		if(sh_email_2 == null) sh_email_2 = "";

		String email = "";

		if(sh_email_1.equals("") || sh_email_2.equals("")){
			email = "";
		}else{
			email = sh_email_1 + "@" + sh_email_2;
		}

		if(email == null) email ="";

		String sh_tel_1 = multi.getParameter("sh_tel_1");
		if(sh_tel_1 == null) sh_tel_1 = "";

		String sh_tel_2 = multi.getParameter("sh_tel_2");
		if(sh_tel_2 == null) sh_tel_2 = "";

		String sh_tel_3 = multi.getParameter("sh_tel_3");
		if(sh_tel_3 == null) sh_tel_3 = "";

		String tel = sh_tel_1 + "-" + sh_tel_2 + "-" + sh_tel_3;
		if(tel == null) tel ="";

		String sh_tele_1 = multi.getParameter("sh_tele_1");
		if(sh_tele_1 == null) sh_tele_1 = "";

		String sh_tele_2 = multi.getParameter("sh_tele_2");
		if(sh_tele_2 == null) sh_tele_2 = "";

		String sh_tele_3 = multi.getParameter("sh_tele_3");
		if(sh_tele_3 == null) sh_tele_3 = "";


		String tel1 = sh_tele_1 + "-" + sh_tele_2 + "-" + sh_tele_3;
		if(tel1 == null) tel1 ="";

		String title = multi.getParameter("title");
		if(title == null || title.equals("")){
			
			//title = "";
%>			
			<script type="text/javascript">
       		alert("제목을 입력해 주십시오.");
       		history.go(-1);
			</script>			
<%
			return;
				
		}

		String text = multi.getParameter("contents");
		if(text == null || text.equals("")) {
			
			//text = "";
%>
			
			<script type="text/javascript">
       		alert("내용을 입력해 주십시오.");
       		history.go(-1);
			</script>			
<%
			return;
		}

		text = text.replaceAll("'", "\'");
		text = text.replaceAll("&", "&amp;");
		text = text.replaceAll("\'", "&quot;");
		text = text.replaceAll("<", "&lt;");
		text = text.replaceAll(">", "&gt;");
		text = text.replaceAll("-", "");
		
		String password = multi.getParameter("psword");
		if(password == null) {
			password = "";
		} else {
			password = aes.aesEncode(password);
		}

		String file_no1 = "";
		file_no1 = multi.getParameter("file1");
		String file1 = multi.getFilesystemName("file1");
  		String ofile1 = multi.getOriginalFileName("file1");
  		
		
		String midstr=FrontBoard.OnlyOne("Select Max(thid) from sh_financetrouble");
		if(midstr == null || midstr.equals("")){
			midstr = "0";
		}
		int thid = Integer.parseInt(midstr) + 1;
		
		String midstr1=FrontBoard.OnlyOne("Select Max(sh_fileno) from sh_financetrouble");
		if(midstr1 == null || midstr1.equals("")){
			midstr1 = "0";
		}
		int fileno = Integer.parseInt(midstr1) + 1;
		
		SmsMgr sm=new SmsMgr();		
		boolean issms=sm.exqute(admintel,tel,"귀하께서 제기하신 민원이 접수되어 처리중입니다.");
		
		String damdangmobile = "010-2745-5006"; //실서버 이하람
		boolean damdangsms = sm.exqute(admintel, damdangmobile, "금융사고/금융부조리 신고 접수되었습니다. 확인바랍니다.");
		
		String[] no_ext = { "asp", "php", "cgi", "sh", "php3", "php4", "html", "htm", "inc", "jsp", "exe", "com", "bat", "htc", "hta" };
 		if(file1 != null && !file1.equals("")){
	 		String ext_1 = file1.substring(file1.lastIndexOf('.') + 1);
	 		ext_1 = ext_1.toLowerCase();
	 		for(int i=0; i<no_ext.length; i++){
	 			if( ext_1.equals(no_ext[i]) ){
	 				out.println("<script language='javascript'>");
					out.print("alert('업로드 금지 파일입니다.\\n\\n확인하여 주시기 바랍니다.');");
					out.println("history.go(-1);");
					out.println("</script>");
					if ( true ) return;
	 			}
	 		}
 		}
		Enumeration  e = multi.getFileNames();
		e.hasMoreElements() ;
		String strName = (String) e.nextElement();
		String fileName = multi.getFilesystemName(strName);
	 	if(fileName == null) fileName ="";

		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();

		String sql = "";
		sql  = " insert into sh_financetrouble( ";
		sql += " parcode,thid,name,replyname,title,publication,branch,tel,tel1,zipcode,addr,";
		sql += " addr2,text,text1,hit,time,time1,time2,password,deeps,status,";
		sql += " status1,code,result,buseo,junbuseo,sh_fileno,sh_file_name,fname";
		sql += " ) values ( ";
		sql += " ?,?,?,?,?,?,?,?,?,?,?,";
		sql += " ?,?,?,?,?,sysdate,?,?,?,?,";
		sql += " ?,?,?,?,?,?,?,?";
		sql += " )";

		pstmt=conn.prepareStatement(sql);

		pstmt.setInt(1,2);
		pstmt.setInt(2,thid);
		pstmt.setString(3,name);
		pstmt.setString(4,"");
		pstmt.setString(5,title);
		pstmt.setString(6,vDiscrNo);
		pstmt.setString(7,email);
		pstmt.setString(8,tel);
		pstmt.setString(9,tel1);
		pstmt.setString(10,zipcode);
		pstmt.setString(11,addr);
		pstmt.setString(12,addr2);
		pstmt.setString(13,text);
		pstmt.setString(14,"");
		pstmt.setInt(15,0);
		pstmt.setString(16,"");
		pstmt.setString(17,"");
		pstmt.setString(18,password);
		pstmt.setInt(19,0);
		pstmt.setInt(20,0);
		pstmt.setString(21,"");
		pstmt.setString(22,"신청");
		pstmt.setString(23,"");
		pstmt.setString(24,"조합감사실");
		pstmt.setString(25,"");
		pstmt.setInt(26,fileno);
		pstmt.setString(27,fileName);
		pstmt.setString(28,fileName);
		
		pstmt.executeUpdate();

		sql = " update sh_financetrouble set text=empty_clob() where thid = " + thid;
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();

		sql = " select text from sh_financetrouble where thid = " + thid +" for update ";
		pstmt = conn.prepareStatement(sql);
				
		//	pstmt.executeUpdate();

		rs = pstmt.executeQuery();

		while (rs.next())
		{
			CLOB clob = ((OracleResultSet)rs).getCLOB(1);
		    Board.writeClob( clob ,text);
		}

		pstmt.close();
		conn.close();

	}catch (IOException e){
%>
		<script type="text/javascript">
	      	alert("파일제한용량 100MB를 초과하였습니다.");
			history.back();
	    </script>
<%
		if(true) return;
	}catch (Exception e){
		out.println(e.toString());
	}
%>

	        <script type="text/javascript">
	        <!--
	        	//document.location.href = "cal.jsp";
	        	alert("등록 되었습니다.");
				self.location = "shingo_001.jsp";
	        //-->
	        </script>
	        