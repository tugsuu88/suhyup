<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>

<%@ page contentType="text/html;charset=euc-kr" %>



<%@ page import="oracle.jdbc.driver.OracleResultSet" %>

<%@ page import="oracle.sql.CLOB" %>

<%@ page import="board.board2.DataFileInfo" %>



<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>

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



	

	    String name = request.getParameter("name");

		if(name == null || name.equals("")){

			name = "";

		}

		String admintel="02-2240-3383";

		String vDiscrNo = request.getParameter("vDiscrNo");



		String sh_post_1 = request.getParameter("sh_post_1");	

 		if(sh_post_1 == null) sh_post_1 = ""; 

		String sh_post_2 = request.getParameter("sh_post_2");	

		if(sh_post_2 == null) sh_post_2 = ""; 

		String zipcode = sh_post_1 + "-" + sh_post_2;

		if(zipcode == null) zipcode ="";



		String addr = request.getParameter("sh_address_1");	

		if(addr == null) addr = ""; 

		String addr2 = request.getParameter("sh_address_2");

		if(addr2 == null) addr2 = ""; 



		String sh_email_1 = request.getParameter("sh_email_1");	

		if(sh_email_1 == null) sh_email_1 = ""; 

		String sh_email_2 = request.getParameter("sh_email_2");	

		if(sh_email_2 == null) sh_email_2 = "";

		

		String email = "";

		if(sh_email_1.equals("") || sh_email_2.equals("")){

			email = "";

		}else{

			email = sh_email_1 + "@" + sh_email_2;

		}

		

		if(email == null) email ="";



		String sh_tel_1 = request.getParameter("sh_tel_1");	

		if(sh_tel_1 == null) sh_tel_1 = ""; 

		String sh_tel_2 = request.getParameter("sh_tel_2");	

		if(sh_tel_2 == null) sh_tel_2 = ""; 

		String sh_tel_3 = request.getParameter("sh_tel_3");	

		if(sh_tel_3 == null) sh_tel_3 = ""; 



		String tel = sh_tel_1 + "-" + sh_tel_2 + "-" + sh_tel_3;

		if(tel == null) tel ="";

		

		String sh_tele_1 = request.getParameter("sh_tele_1");	

		if(sh_tele_1 == null) sh_tele_1 = ""; 

		String sh_tele_2 = request.getParameter("sh_tele_2");	

		if(sh_tele_2 == null) sh_tele_2 = ""; 

		String sh_tele_3 = request.getParameter("sh_tele_3");	

		if(sh_tele_3 == null) sh_tele_3 = ""; 



		String tel1 = sh_tele_1 + "-" + sh_tele_2 + "-" + sh_tele_3;

		if(tel1 == null) tel1 ="";



		String title = request.getParameter("title");	

		if(title == null) title = ""; 



		String text = request.getParameter("contents");	

		if(text == null) text = ""; 

		text = text.replaceAll("'", "\'");

		text = text.replaceAll("&", "&amp;");

		text = text.replaceAll("\'", "&quot;");

		text = text.replaceAll("<", "&lt;");

		text = text.replaceAll(">", "&gt;");

		text = text.replaceAll("-", "");



		String password = request.getParameter("psword");	

		if(password == null) {
			password = "";
		} else {
			password = aes.aesEncode(password);
		}

		String midstr=FrontBoard.OnlyOne("Select Max(thid) from sh_financetrouble");

		int thid = Integer.parseInt(midstr) + 1;

		

		SmsMgr sm=new SmsMgr();

		boolean issms=sm.exqute(admintel,tel,"귀하께서 제기하신 민원이 접수되어 처리중입니다.");



		Context ic = new InitialContext();

		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");

		conn = ds.getConnection();

		String sql = "";	



		sql  = " insert into sh_financetrouble( ";

		sql += " parcode,thid,name,replyname,title,publication,branch,tel,tel1,zipcode,addr,";   

		sql += " addr2,text,text1,hit,time,time1,time2,password,deeps,status,";

		sql += " status1,code,result,buseo,junbuseo";

		sql += " ) values ( ";

		sql += " ?,?,?,?,?,?,?,?,?,?,?,";

		sql += " ?,?,?,?,?,sysdate,?,?,?,?,";

		sql += " ?,?,?,?,?";

		sql += " )";



		pstmt=conn.prepareStatement(sql);



		pstmt.setInt(1,4);

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

		pstmt.setString(24,"감사실");

		pstmt.setString(25,"");

	

		pstmt.executeUpdate();



		sql = " update sh_financetrouble set text=empty_clob() where thid = " + thid;

		pstmt = conn.prepareStatement(sql);

		pstmt.executeUpdate();

		

		sql = " select text from sh_financetrouble where thid = " + thid +" for update ";

		pstmt = conn.prepareStatement(sql);

		

//		pstmt.executeUpdate();

		

		rs = pstmt.executeQuery();



		while (rs.next())

		{

			CLOB clob = ((OracleResultSet)rs).getCLOB(1); 



		    Board.writeClob( clob ,text);

		}

				

		pstmt.close();

		conn.close();



	}catch (Exception e){

		out.println(e.toString());

	}

	

%>

	        <script type="text/javascript">

	        <!--

	        	//document.location.href = "cal.jsp";

	        	alert("등록 되었습니다.");

				self.location = "../minwon/corruption_my.jsp";



	        //-->

	        </script>