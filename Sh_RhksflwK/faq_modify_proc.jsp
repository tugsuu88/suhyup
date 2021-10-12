<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="board.board2.DataFileInfo" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%

	String no = request.getParameter("sh_no");
	if(no == null) no="0";
	int sh_no = Integer.parseInt(no);

	String sh_code = Converter.nullchk(request.getParameter("sh_code"));
	if(sh_code == null) sh_code = ""; 
	
	String sh_subject = Converter.nullchk(request.getParameter("sh_subject"));
	if(sh_subject == null) sh_subject = ""; 
	
	String sh_content = Converter.nullchk(request.getParameter("sh_content"));
	if(sh_content == null) sh_content = ""; 
/*
	String sh_name = Converter.nullchk(request.getParameter("sh_name"));
	if(sh_name == null) sh_name = ""; 
*/
	try {	

		DataSource ds = null;
		Connection conn = null;
		ResultSet rs = null;
		ResultSetMetaData meta = null;
		PreparedStatement pstmt=null;
		


		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();
		
		String sql = "";	
		
		sql  = " update sh_minwon_faq ";
		sql += " set sh_code = ?, sh_subject = ?, sh_content = ?, sh_indate = sysdate "; 
		sql += " where sh_no = '"+sh_no+"'";


		pstmt=conn.prepareStatement(sql);

		pstmt.setString(1,sh_code);
		pstmt.setString(2,sh_subject);
		pstmt.setString(3,sh_content);

		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();

	}catch (Exception e){
		out.println(e.toString());
	}

%>	     
<script language="javascript">
<!--
  	alert("수정 되었습니다.");
	self.location = "faq.jsp";
//-->
</script>