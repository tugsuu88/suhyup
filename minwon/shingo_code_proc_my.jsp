<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>


<%@ page contentType="text/html;charset=euc-kr" %>


<%@ page import="board.board2.DataFileInfo" %>


<%@ page import="com.oreilly.servlet.*" %>


<%@ page import="com.oreilly.servlet.multipart.*" %>


<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>


<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>


<%@ include file="../inc/requestSecurity.jsp" %>


<%





	String mid = request.getParameter("sh_mid");


	if(mid == null) mid="0";


	int sh_mid = Integer.parseInt(mid);

		


	String name = request.getParameter("name");


	if(name == null) name="";


	

	String passwd = request.getParameter("passwd");


	if(passwd == null) passwd="";


	

	String tel = request.getParameter("tel");

	if(tel == null) tel="";

	

	String telephone = Converter.nullchk(request.getParameter("telephone"));



	try {	





		DataSource ds = null;


		Connection conn = null;


		ResultSet rs = null;


		PreparedStatement pstmt=null;





		Context ic = new InitialContext();


		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");


		conn = ds.getConnection();


		


		String sql = "";	


		


		sql  = " update sh_financetrouble ";


		sql += " set code = ? "; 


		sql += " where thid = '"+sh_mid+"'";





		pstmt=conn.prepareStatement(sql);





		pstmt.setString(1,"철회완료");


		


		pstmt.executeUpdate();


		


		pstmt.close();


		conn.close();		


		


	}catch (Exception e){


		//out.println(e.toString());

		


	}


%>	     


		<form method="post" action="../minwon/shingo_list_my.jsp" name="d">

			<input type="hidden" name="name" value="<%=name%>" />


		    <input type="hidden" name="passwd" value="<%=passwd%>" />


		    <input type="hidden" name="tel" value="<%=tel%>">

			<INPUT TYPE="hidden" NAME="telephone" value="<%=telephone%>" />


  		</form>


		<script type="text/javascript">


	        <!--


	           	alert("철회되었습니다.");


				document.d.submit();


		     //-->


        </script>


