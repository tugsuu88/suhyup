<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>

<%@ page contentType="text/html;charset=euc-kr" %>

<%@ page import="board.board2.DataFileInfo" %>

<%@ page import="com.oreilly.servlet.*" %>

<%@ page import="com.oreilly.servlet.multipart.*" %>

<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<%@ include file="../inc/requestSecurity.jsp" %>

<%



	String mid = request.getParameter("mid");

	if(mid == null) mid="0";

	int sh_mid = Integer.parseInt(mid);

		

	String name = request.getParameter("name");

	if(name == null) name="";



	String sh_email_1 = request.getParameter("sh_email_1");

	if(sh_email_1 == null) sh_email_1="";



	String sh_email_2 = request.getParameter("sh_email_2");

	if(sh_email_2 == null) sh_email_2="";

	

	String email = "";

		

	if(sh_email_1.equals("") || sh_email_2.equals("")){

		email = "";

	}else{

		email = sh_email_1 + "@" + sh_email_2;

	}



	if(email == null) email ="";



	String sh_post_1 = request.getParameter("sh_post_1");

	if(sh_post_1 == null) sh_post_1="";



	String sh_post_2 = request.getParameter("sh_post_2");

	if(sh_post_2 == null) sh_post_2="";



	String zipcode = sh_post_1 + "-" + sh_post_2;

	if(zipcode == null) zipcode ="";



	String addr = request.getParameter("sh_address_1");

	if(addr == null) addr="";



	String addr2 = request.getParameter("sh_address_2");

	if(addr2 == null) addr2="";



	String subject = request.getParameter("subject");

	if(subject == null) subject="";



	String content = request.getParameter("content");

	if(content == null) content="";



	String tel = "";

	String sh_tel_1 = request.getParameter("sh_tel_1");

	if(sh_tel_1 == null) sh_tel_1="";



	String sh_tel_2 = request.getParameter("sh_tel_2");

	if(sh_tel_2 == null) sh_tel_2="";



	String sh_tel_3 = request.getParameter("sh_tel_3");

	if(sh_tel_3 == null) sh_tel_3="";

	

	if(sh_tel_1.equals("")){

		tel =  request.getParameter("tel");

	}

	else{

		tel = sh_tel_1 + "-" + sh_tel_2 + "-" + sh_tel_3;

	}

		

	if(tel == null) tel ="";



	String passwd = request.getParameter("passwd");

	if(passwd == null) passwd="";



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

		

		sql  = " update sh_financetrouble ";

		sql += " set name = ?, branch=?, tel=?, addr=?, title=?, text=?, addr2=? "; 

		sql += " where thid = '"+sh_mid+"'";



		pstmt=conn.prepareStatement(sql);



		pstmt.setString(1,name);

		pstmt.setString(2,email);

		pstmt.setString(3,tel);

		pstmt.setString(4,addr);

		pstmt.setString(5,subject);

		pstmt.setString(6,content);

		pstmt.setString(7,addr2);





		pstmt.executeUpdate();

		

		pstmt.close();

		conn.close();



	}catch (Exception e){

		out.println(e.toString());

	}

%>	     

		<form method="post" action="shingo_list_my.jsp" name="d">                                  

		    <input type="hidden" name="name" value="<%=name%>" />

		    <input type="hidden" name="passwd" value="<%=passwd%>" />

		    <input type="hidden" name="tel" value="<%=tel%>">

  		</form>

		<script type="text/javascript">

	        <!--

	           	alert("수정 되었습니다.");

				document.d.submit();

		     //-->

        </script>

