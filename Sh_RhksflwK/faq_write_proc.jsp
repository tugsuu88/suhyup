<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="board.board2.DataFileInfo" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<%
	try {	

		DataSource ds = null;
		Connection conn = null;
		ResultSet rs = null;
		ResultSetMetaData meta = null;
		PreparedStatement pstmt=null;

		String sa_id = Converter.nullchk(request.getParameter("sa_id"));

		String sa_name = Converter.nullchk(request.getParameter("sa_name"));

		String category = Converter.nullchk(request.getParameter("category"));
		if(category == null || category.equals("")){
			category = "";
		}

		String question = Converter.nullchk(request.getParameter("question"));
		if(question == null || question.equals("")){
			question = "";
		}

		String answer = Converter.nullchk(request.getParameter("answer"));
		if(answer == null || answer.equals("")){
			answer = "";
		}

		String midstr=FrontBoard.OnlyOne("Select Max(sh_no) from sh_minwon_faq");
		if(midstr == null || midstr.equals("")){
			midstr = "0";
		}
		int mid = Integer.parseInt(midstr) + 1;
		
		int hit = 0;

		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();

		String sql = "";	
		
		sql  = " insert into sh_minwon_faq( ";
		sql += " sh_no, sh_id, sh_code, sh_subject, sh_hit, sh_content, sh_name, sh_indate";
		sql += " ) values ( ";
		sql += " ?,?,?,?,?,?,?,sysdate";					
		sql += " )";

		pstmt=conn.prepareStatement(sql);

		pstmt.setInt(1,mid);
		pstmt.setString(2,sa_id);
		pstmt.setString(3,category);
		pstmt.setString(4,question);
		pstmt.setInt(5,hit);
		pstmt.setString(6,answer);
		pstmt.setString(7,sa_name);

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
	self.location = "faq.jsp";
//-->
</script>
