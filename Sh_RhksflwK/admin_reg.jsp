<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>

<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<%@ page import="board.board2.DataFileInfo"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>

<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1" />
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1" />
<jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />
<%
	try {	

		DataSource ds = null;
		Connection conn = null;
		ResultSet rs = null;
		ResultSetMetaData meta = null;
		PreparedStatement pstmt=null;
	   
		String sh_id = Converter.nullchk(request.getParameter("sh_id"));
		if(sh_id == null || sh_id.equals("")){
			sh_id = "";
		}
		//회원 중복 검색
		
		String TableName = "  sh_minwon_admin  ";
		String WhereCondition = null;
		int TotalRecordCount = 0;
		
		//아이디 중복 검색
		WhereCondition  = " where sh_id = '" + sh_id + "'";
		TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);
		if(TotalRecordCount > 0){
		
%>
		<script language='javascript'>
			alert('이미 등록된 아이디 입니다. \n\n 아이디 중복검색 확인 후 다시 작업하시기 바랍니다.');
			history.go(-1);
       	</script>
<%
			if ( true ) return;
		}
		
		String sh_buseo = Converter.nullchk(request.getParameter("sh_buseo"));
		if(sh_buseo == null || sh_buseo.equals("")){
			sh_buseo = "";
		}

		String sh_admin_minwonall = Converter.nullchk(request.getParameter("sh_admin_minwonall"));
		if(sh_admin_minwonall == null || sh_admin_minwonall.equals("")){
			sh_admin_minwonall = "";
		}

		String sh_name = Converter.nullchk(request.getParameter("sh_name"));
		if(sh_name == null || sh_name.equals("")){
			sh_name = "";
		}

		String sh_gicwe = Converter.nullchk(request.getParameter("sh_gicwe"));
		if(sh_gicwe == null || sh_gicwe.equals("")){
			sh_gicwe = "";
		}
		
	    String sh_gicgub = Converter.nullchk(request.getParameter("sh_gicgub"));
		if(sh_gicgub == null || sh_gicgub.equals("")){
			sh_gicgub = "";
		}
	
	    String sh_pwd = Converter.nullchk(request.getParameter("sh_pwd"));
		if(sh_pwd == null || sh_pwd.equals("")){
			sh_pwd = "";
		} else {
			sh_pwd = aes.aesEncode(sh_pwd);
		}
		
		String sh_han1 = Converter.nullchk(request.getParameter("sh_han1"));
		if(sh_han1 == null || sh_han1.equals("")){
			sh_han1 = "";
		}
		String sh_han2 = Converter.nullchk(request.getParameter("sh_han2"));
		if(sh_han2 == null || sh_han2.equals("")){
			sh_han2 = "";
		}
		String sh_han3 = Converter.nullchk(request.getParameter("sh_han3"));
		if(sh_han3 == null || sh_han3.equals("")){
			sh_han3 = "";
		}
		String mobile = sh_han1 + "-" + sh_han2 + "-" + sh_han3;

		
		String sh_admin_manager = Converter.nullchk(request.getParameter("sh_admin_manager"));
		if(sh_admin_manager == null || sh_admin_manager.equals("")){
			sh_admin_manager = "";
		}
		
		String sh_admin_faq = Converter.nullchk(request.getParameter("sh_admin_faq"));
		if(sh_admin_faq == null || sh_admin_faq.equals("")){
			sh_admin_faq = "";
		}
		
		String sh_admin_buseo = Converter.nullchk(request.getParameter("sh_admin_buseo"));
		if(sh_admin_buseo == null || sh_admin_buseo.equals("")){
			sh_admin_buseo = "";
		}
		
		String sh_admin_result = Converter.nullchk(request.getParameter("sh_admin_result"));
		if(sh_admin_result == null || sh_admin_result.equals("")){
			sh_admin_result = "";
		}
		
		String sh_admin_jebo = Converter.nullchk(request.getParameter("sh_admin_jebo"));
		if(sh_admin_jebo == null || sh_admin_jebo.equals("")){
			sh_admin_jebo = "";
		}
		
		String sh_admin_bujori = Converter.nullchk(request.getParameter("sh_admin_bujori"));
		if(sh_admin_bujori == null || sh_admin_bujori.equals("")){
			sh_admin_bujori = "";
		}
		
		String sh_admin_myunsei = Converter.nullchk(request.getParameter("sh_admin_myunsei"));
		if(sh_admin_myunsei == null || sh_admin_myunsei.equals("")){
			sh_admin_myunsei = "";
		}

		String sh_admin_corruption = Converter.nullchk(request.getParameter("sh_admin_corruption"));
		if(sh_admin_corruption == null || sh_admin_corruption.equals("")){
			sh_admin_corruption = "";
		}
		
		String sh_admin_favors = Converter.nullchk(request.getParameter("sh_admin_favors"));
		if(sh_admin_favors == null || sh_admin_favors.equals("")){
			sh_admin_favors = "";
		}
		
		String sh_admin_upright = Converter.nullchk(request.getParameter("sh_admin_upright"));
		if(sh_admin_upright == null || sh_admin_upright.equals("")){
			sh_admin_upright = "";
		}
		
		String sh_johap = Converter.nullchk(request.getParameter("sh_johap"));
		if(sh_johap == null || sh_johap.equals("")){
			sh_johap = "";
		}
		
		String sh_admin_sms = Converter.nullchk(request.getParameter("sh_admin_sms"));
		if(sh_admin_sms == null || sh_admin_sms.equals("")){
			sh_admin_sms = "";
		}

		String midstr=FrontBoard.OnlyOne("Select Max(sh_no) from sh_minwon_admin");
		if(midstr == null || midstr.equals("")){
			midstr = "0";
		}
		int mid = Integer.parseInt(midstr) + 1;
	
		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();

		String sql = "";	
		
		sql  = " insert into sh_minwon_admin( ";
		sql += " sh_no,sh_id,sh_pwd,sh_buseo,sh_name,sh_mobile,sh_gicwe,sh_gicgub,sh_admin_manager,sh_admin_faq,";
		sql += " sh_admin_minwonall,sh_admin_buseo,sh_admin_result,sh_admin_jebo,sh_admin_bujori,sh_admin_myunsei,sh_admin_corruption,sh_admin_favors,sh_inuser,";
		sql += " sh_indate, sh_admin_upright, sh_johap, sh_admin_sms";		
		sql += " ) values ( ";
		sql += " ?,?,?,?,?,?,?,?,?,?,";
		sql += " ?,?,?,?,?,?,?,?,?,sysdate,?,?,?";
		sql += " )";

		pstmt=conn.prepareStatement(sql);

		pstmt.setInt(1,mid);
		pstmt.setString(2,sh_id);
		pstmt.setString(3,sh_pwd);
		pstmt.setString(4,sh_buseo);
		pstmt.setString(5,sh_name);
		pstmt.setString(6,mobile);
		pstmt.setString(7,sh_gicwe);
		pstmt.setString(8,sh_gicgub);
		pstmt.setString(9,sh_admin_manager);
		pstmt.setString(10,sh_admin_faq);
		pstmt.setString(11,sh_admin_minwonall);
		pstmt.setString(12,sh_admin_buseo);
		pstmt.setString(13,sh_admin_result);	
		pstmt.setString(14,sh_admin_jebo);
		pstmt.setString(15,sh_admin_bujori);
		pstmt.setString(16,sh_admin_myunsei);
		pstmt.setString(17,sh_admin_corruption);
		pstmt.setString(18,sh_admin_favors);
		pstmt.setString(19,"관리자");
		pstmt.setString(20,sh_admin_upright);
		pstmt.setString(21,sh_johap);
		pstmt.setString(22,sh_admin_sms);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();

	}catch (Exception e){
		out.println(e.toString());
	}
	
	if(request.getParameter("sh_buseo").equals("회원조합")) {
%>  
	<script language="javascript">
	<!--
	  	alert("수정 되었습니다.");
		self.location = "administrator_02.jsp";
	//-->
	
	</script>
<%
	} else {
%>
	<script language="javascript">
	<!--
	  	alert("수정 되었습니다.");
		self.location = "administrator.jsp";
	//-->
	
	</script>
<%
	}
%>
