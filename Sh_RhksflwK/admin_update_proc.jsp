<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*, java.util.regex.*"%>

<%@ page contentType="text/html;charset=euc-kr"%>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<%@ page import="board.board2.DataFileInfo" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />
<%

	String no = request.getParameter("sh_no");
	if(no == null) no="0";
	int sh_no = Integer.parseInt(no);

	String sh_buseo = Converter.nullchk(request.getParameter("sh_buseo"));
	if(sh_buseo == null) sh_buseo = "";

	String sh_name = Converter.nullchk(request.getParameter("sh_name"));
	if(sh_name == null) sh_name = "";

	String sh_gicwe = Converter.nullchk(request.getParameter("sh_gicwe"));
	if(sh_gicwe == null) sh_gicwe = "";

	String sh_gicgub = Converter.nullchk(request.getParameter("sh_gicgub"));
	if(sh_gicgub == null) sh_gicgub = "";

	String sh_id = Converter.nullchk(request.getParameter("sh_id"));
	if(sh_id == null) sh_id = "";

	String sh_pwd = Converter.nullchk(request.getParameter("sh_pwd"));
	if(sh_pwd == null) {
		sh_pwd = "";
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
	if(sh_admin_manager == null) sh_admin_manager = "";

	String sh_admin_faq = Converter.nullchk(request.getParameter("sh_admin_faq"));
	if(sh_admin_faq == null) sh_admin_faq = "";

	String sh_admin_minwonall = Converter.nullchk(request.getParameter("sh_admin_minwonall"));
	if(sh_admin_minwonall == null) sh_admin_minwonall = "";

	String sh_admin_buseo = Converter.nullchk(request.getParameter("sh_admin_buseo"));
	if(sh_admin_buseo == null) sh_admin_buseo = "";

	String sh_admin_result = Converter.nullchk(request.getParameter("sh_admin_result"));
	if(sh_admin_result == null) sh_admin_result = "";

	String sh_admin_jebo = Converter.nullchk(request.getParameter("sh_admin_jebo"));
	if(sh_admin_jebo == null) sh_admin_jebo = "";

	String sh_admin_bujori = Converter.nullchk(request.getParameter("sh_admin_bujori"));
	if(sh_admin_bujori == null) sh_admin_bujori = "";

	String sh_admin_myunsei = Converter.nullchk(request.getParameter("sh_admin_myunsei"));
	if(sh_admin_myunsei == null) sh_admin_myunsei = "";

	String sh_admin_corruption = Converter.nullchk(request.getParameter("sh_admin_corruption"));
	if(sh_admin_corruption == null) sh_admin_corruption = "";

	String sh_admin_favors = Converter.nullchk(request.getParameter("sh_admin_favors"));
	if(sh_admin_favors == null) sh_admin_favors = "";

	String sh_admin_upright = Converter.nullchk(request.getParameter("sh_admin_upright"));
	if(sh_admin_upright == null) sh_admin_upright = "";

	String sh_johap = Converter.nullchk(request.getParameter("sh_johap"));
	if(sh_johap == null) sh_johap = "";

	String sh_admin_sms = Converter.nullchk(request.getParameter("sh_admin_sms"));
	if(sh_admin_sms == null) sh_admin_sms = "";


	Pattern numP = Pattern.compile("([a-zA-Z].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z])");


	Matcher mat = numP.matcher(sh_pwd);

	if (!mat.find()|| sh_pwd.length() < 9){
		%>
		<script language="javascript">
		  	alert("비밀번호는 영문 대/소문자, 특수문자 포함 9자리 이상 설정해 주시기 바랍니다.");
			history.back(-1);
		</script>
	<%
	}else{

		sh_pwd = aes.aesEncode(sh_pwd);
	try {

		DataSource ds = null;
		Connection conn = null;
		ResultSet rs = null;
		ResultSetMetaData meta = null;
		PreparedStatement pstmt=null;

		if(!(
				sh_buseo.equals("감사실") ||
				sh_buseo.equals("감사부") ||
				sh_buseo.equals("금융소비자보호부") ||
				sh_buseo.equals("준법감시실(중앙회)") ||
				sh_buseo.equals("준법감시실(조합)")
				) &&
				sh_admin_minwonall.equals("Y") ){

%>
			<script language='javascript'>

				alert('민원현황은 감사실과 금융소비자보호부, 준법감시실(중앙회), 준법감시실(조합) 부서만 사용하실수 있습니다.\n\n다시 작업하시기 바랍니다.');
		self.location = "administrator_modify.jsp?sh_no=<%=no%>";

			</script>

<%
		if(true) return;
	}

		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();

		String sql = "";

		sql  = " update sh_minwon_admin ";
		sql += " set sh_buseo = ?, sh_name = ?, sh_mobile = ?,sh_gicwe = ?, sh_gicgub = ?, sh_pwd = ?, sh_admin_manager = ?, ";
		sql += " sh_admin_faq = ?, sh_admin_minwonall = ?, sh_admin_buseo = ?, sh_admin_result = ?, sh_admin_jebo = ?, ";
		sql += " sh_admin_bujori = ?, sh_admin_myunsei = ?, sh_admin_corruption = ?, sh_admin_favors = ? , sh_admin_upright = ?,sh_login_fail_cnt = 0, sh_johap = ?, sh_admin_sms=?";
		sql += " where sh_no = '"+sh_no+"'";


		pstmt=conn.prepareStatement(sql);

		pstmt.setString(1,sh_buseo);
		pstmt.setString(2,sh_name);
		pstmt.setString(3,mobile);
		pstmt.setString(4,sh_gicwe);
		pstmt.setString(5,sh_gicgub);
		pstmt.setString(6,sh_pwd);
		pstmt.setString(7,sh_admin_manager);
		pstmt.setString(8,sh_admin_faq);
		pstmt.setString(9,sh_admin_minwonall);
		pstmt.setString(10,sh_admin_buseo);
		pstmt.setString(11,sh_admin_result);
		pstmt.setString(12,sh_admin_jebo);
		pstmt.setString(13,sh_admin_bujori);
		pstmt.setString(14,sh_admin_myunsei);
		pstmt.setString(15,sh_admin_corruption);
		pstmt.setString(16,sh_admin_favors);
		pstmt.setString(17,sh_admin_upright);
		pstmt.setString(18,sh_johap);
		pstmt.setString(19,sh_admin_sms);
		pstmt.executeUpdate();

		pstmt.close();
		conn.close();

	}catch (Exception e){
		out.println(e.toString());
	}

%>
<%
	if(sh_buseo.equals("회원조합")) {
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
<%
	}
%>