<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>
<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="oracle.jdbc.driver.OracleResultSet" %>
<%@ page import="oracle.sql.CLOB" %>
<%@ page import="board.board2.DataFileInfo" %>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>


<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>

<jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />

<%@ include file="../inc/requestSecurity.jsp" %>

<%

	try {		

		DataSource ds 		= null;
		Connection conn 	= null;
		ResultSet rs 			= null;
		ResultSetMetaData meta 	= null;
		PreparedStatement pstmt	= null;
		String admintel				= "02-2240-3383";
		
		String vDiscrNo = request.getParameter("vDiscrNo");		
		if (vDiscrNo == null || "".equals(vDiscrNo)){
%>			
			<script type="text/javascript">
       		alert("아이핀 인증을 다시 하여 주십시오.");
       		history.go(-1);
			</script>			
<%
			return;
		}

	    String name = Converter.nullchk(request.getParameter("name"));	    
		if(name == null || name.equals("")){			
%>			
			<script type="text/javascript">
       		alert("이름을 입력해 주십시오.");			
       		history.go(-1);
			</script>			
<%
			return;

		}
		
		String sUserIp = request.getHeader("X-Forwarded-For");
		if(sUserIp == null || "127.0.0.1".equals(sUserIp) || "null".equals(sUserIp) || "0:0:0:0:0:0:0:1".equals(sUserIp)) {

			//	sUserIp = request.getRemoteAddr();
			sUserIp = "";
		}
		
		String sh_post_1 = request.getParameter("sh_post_1");	
 		if (sh_post_1 == null || sh_post_1.equals("")) sh_post_1 = "";

		String sh_post_2 = request.getParameter("sh_post_2");	
		if (sh_post_2 == null || sh_post_2.equals("")) sh_post_2 = "";

		String zipcode = sh_post_1 + "-" + sh_post_2;
		if (zipcode == null || zipcode.equals("")) zipcode = "";

		String addr = request.getParameter("sh_address_1");	
		if (addr == null || addr.equals("")) addr = "";

		String addr2 = request.getParameter("sh_address_2");
		if (addr2 == null || addr2.equals("")) addr2 = "";

		String sh_email_1 = request.getParameter("sh_email_1");	
		if (sh_email_1 == null || sh_email_1.equals("")) sh_email_1 = "";

		String sh_email_2 = request.getParameter("sh_email_2");	
		if (sh_email_2 == null || sh_email_2.equals("")) sh_email_2 = "";

		String email = "";

		if(sh_email_1.equals("") || sh_email_2.equals("")){
			email = "";
		}else{
			email = sh_email_1 + "@" + sh_email_2;
		}

		if(email == null) email ="";

		String sh_tel_1 = Converter.nullchk(request.getParameter("sh_tel_1"));
		if (sh_tel_1 == null || sh_tel_1.equals("")) sh_tel_1 = "";

		String sh_tel_2 = Converter.nullchk(request.getParameter("sh_tel_2"));
		if (sh_tel_2 == null || sh_tel_2.equals("")) sh_tel_2 = "";

		String sh_tel_3 = Converter.nullchk(request.getParameter("sh_tel_3"));
		if (sh_tel_3 == null || sh_tel_3.equals("")) sh_tel_3 = "";

		String tel = sh_tel_1 + "-" + sh_tel_2 + "-" + sh_tel_3;
		if (tel == null || tel.equals("")) tel = "";
		
		if(tel == null || tel.equals("")){			
			//	title = ""; 
%>				
			<script type="text/javascript">
	       	alert("휴대전화번호를 입력해 주십시오.");
	       	history.go(-1);
			</script>				
<%
				return;
		}		

		String sh_tele_1 = Converter.nullchk(request.getParameter("sh_tele_1"));
		if (sh_tele_1 == null || sh_tele_1.equals("")) sh_tele_1 = "";

		String sh_tele_2 = Converter.nullchk(request.getParameter("sh_tele_2"));
		if (sh_tele_2 == null || sh_tele_2.equals("")) sh_tele_2 = "";

		String sh_tele_3 = Converter.nullchk(request.getParameter("sh_tele_3"));
		if (sh_tele_3 == null || sh_tele_3.equals("")) sh_tele_3 = "";

		String tel1 = sh_tele_1 + "-" + sh_tele_2 + "-" + sh_tele_3;
		if (tel1 == null || tel1.equals("")) tel1 = "";
		
		if(tel == null || tel.equals("")){			
			//	title = ""; 
%>				
			<script type="text/javascript">
	       	alert("전화번호를 입력해 주십시오.");
	       	history.go(-1);
			</script>				
<%
			return;
		}

		String title = Converter.nullchk(request.getParameter("title"));
		if(title == null || title.equals("")){			
			//	title = ""; 
%>		
			<script type="text/javascript">
       		alert("제목을 입력해 주십시오.");
       		history.go(-1);
			</script>			
<%
			return;
		}

		String text = Converter.nullchk(request.getParameter("contents"));
		if(text == null || text.equals("")){			
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

		String password = Converter.nullchk(request.getParameter("psword"));

		if(password == null) {
			password = "";
		} else {
			password = aes.aesEncode(password); 
		}

		if(password == null || password.equals("")){				
			//text = "";
%>				
			<script type="text/javascript">
       		alert("패스워드를 입력해 주십시오.");
       		history.go(-1);
			</script>
<%
			return;
		}		
		
		
		String midstr=FrontBoard.OnlyOne("Select Max(thid) from sh_financetrouble");
		int thid = Integer.parseInt(midstr) + 1;		
		
		Context ic = new InitialContext();
		
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();
		
		String sql = "";
		sql  = " insert into sh_financetrouble( ";
		sql += " parcode, thid, name, replyname, title, publication, branch,";
		sql += " tel, tel1, zipcode, addr, addr2,";
		sql += " text, text1, hit, time, time1, time2,";
		sql += " password, deeps, status, status1,";
		sql += " code, result, buseo, junbuseo, userip";
		sql += " ) values ( ";
		sql += " ?, ?, ?, ?, ?, ?, ?,";
		sql += " ?, ?, ?, ?, ?,";
		sql += " ?, ?, ?, ?, sysdate, ?,";
		sql += " ?, ?, ?, ?,";
		sql += " ?, ?, ?, ?, ?";
		sql += " )";

		pstmt=conn.prepareStatement(sql);

		pstmt.setInt(1,1);
		pstmt.setInt(2,thid);
		pstmt.setString(3,name);
		pstmt.setString(4,"");
		pstmt.setString(5,title);
		pstmt.setString(6,vDiscrNo);
		pstmt.setString(7,email);

		pstmt.setString(8,tel);
		pstmt.setString(9,tel);
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
		pstmt.setString(26,sUserIp);
		
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

		// SMS 발송 	
		SmsMgr sm=new SmsMgr();

		boolean issms=sm.exqute(admintel,tel,"귀하께서 제기하신 민원이 접수되어 처리중입니다.");

		String damdangmobile = "010-2745-5006"; //실서버 이하람
		boolean damdangsms = sm.exqute(admintel, damdangmobile, "금융사고/금융부조리 신고 접수되었습니다. 확인바랍니다.");
		
		
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
			self.location = "shingo_001.jsp";
      //-->
      </script>
      
      
      
      
      