<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>

<%@ page contentType="text/html;charset=euc-kr"%>

<%
	request.setCharacterEncoding("euc-kr");
%>
<%
	response.setContentType("text/html; charset=euc-kr");
%>

<%@ page import="board.board2.DataFileInfo"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1" />
<jsp:useBean id="DataMgr" scope="request" class="board.board2.DataMgr" />
<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1" />
<jsp:useBean id="aes" scope="request" class="Bean.Front.Common.AES256Util" />
<%@ include file="../inc/requestSecurity.jsp"%>
<%	

	DataSource ds = null;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	//PreparedStatement pstmt = null;
	int returnUpdate = 1;
	String mobile = "";
	String admintel = "02-2240-5934";
	String damdangbuseNm = "";
	int sizeLimit = 5 * 1024 * 1024; // 5메가까지 제한 넘어서면 예외발생
	String savePath = application.getRealPath("/upload/minwon"); //폴더 얻기
	MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
	
	try {


		String vDiscrNo = multi.getParameter("vDiscrNo");
		if (vDiscrNo == null) {
			vDiscrNo = "";
		}

		String name = multi.getParameter("name");
		if (name == null) {
			name = "";
		}

		String Month = multi.getParameter("Month");
		if (Month == null) {
			Month = "";
		}

		String Year = multi.getParameter("Year");
		if (Year == null) {
			Year = "";
		}

		String Day = multi.getParameter("Day");
		if (Day == null) {
			Day = "";
		}

		String buseNm = "";
		String sh_center = multi.getParameter("sh_center");
		if (sh_center == null) {
			sh_center = "";
		} else {
			/* buseNm = (("1".equals(sh_center)) ? "감사실" : "감사부"); */
			//System.out.println("sh_center="+sh_center);
			if("1".equals(sh_center)){
				buseNm = "준법감시실(중앙회)";
			}else if("2".equals(sh_center)){
				buseNm = "금융소비자보호부";
			}else if("3".equals(sh_center)){
				buseNm = "준법감시실(조합)";
			}
		}
		// System.out.println("buseNm="+buseNm);

		damdangbuseNm = buseNm;

		String self_text = multi.getParameter("self_text");
		if (self_text == null) {
			self_text = "";
		}

		String sh_reply_type = multi.getParameter("sh_reply_type");
		if (sh_reply_type == null) {
			sh_reply_type = "";
		}

		String sh_post_1 = multi.getParameter("sh_post_1");
		if (sh_post_1 == null) {
			sh_post_1 = "";
			
		}

		String addr = multi.getParameter("sh_address_1");
		if (addr == null) {
			addr = "";
		}

		String addr2 = multi.getParameter("sh_address_2");
		if (addr2 == null) {
			addr2 = "";
		}

		String sh_tel_1 = multi.getParameter("sh_tel_1");
		if (sh_tel_1 == null) {
			sh_tel_1 = "";
		}

		String sh_tel_2 = multi.getParameter("sh_tel_2");
		if (sh_tel_2 == null) {
			sh_tel_2 = "";
		}

		String sh_tel_3 = multi.getParameter("sh_tel_3");
		if (sh_tel_3 == null) {
			sh_tel_3 = "";
		}

		String sh_han_1 = multi.getParameter("sh_han_1");
		if (sh_han_1 == null) {
			sh_han_1 = "";
		}

		String sh_han_2 = multi.getParameter("sh_han_2");
		if (sh_han_2 == null) {
			sh_han_2 = "";
		}

		String sh_han_3 = multi.getParameter("sh_han_3");
		if (sh_han_3 == null) {
			sh_han_3 = "";
		}

		String sh_email_1 = multi.getParameter("sh_email_1");
		if (sh_email_1 == null) {
			sh_email_1 = "";
		}

		String sh_email_2 = multi.getParameter("sh_email_2");
		if (sh_email_2 == null) {
			sh_email_2 = "";
		}

		String category = multi.getParameter("sh_cata");
		if (category == null) {
			category = "";
		}

		String passwd = multi.getParameter("psword");
		if (passwd == null) {
			passwd = "";
		} else {
			passwd = aes.aesEncode(passwd);
		}
		
		String subject = multi.getParameter("sh_title");
		if (subject == null) {
			subject = "";
		}

		String content = multi.getParameter("contents");
		if (content == null) {
			content = "";
		}

		content = content.replaceAll("'", "\'");
		content = content.replaceAll("&", "&amp;");
		content = content.replaceAll("\'", "&quot;");
		content = content.replaceAll("<", "&lt;");
		content = content.replaceAll(">", "&gt;");
		content = content.replaceAll("-", "");

		String file_no1 = multi.getParameter("file1");
		if (file_no1 == null) {
			file_no1 = "";
		}

		String file1 = multi.getFilesystemName("file1");
		if (file1 == null) {
			file1 = "";
		}

		String ofile1 = multi.getOriginalFileName("file1");
		if (ofile1 == null) {
			ofile1 = "";
		}

		String midstr = FrontBoard.OnlyOne("Select Max(mid) from SH_MINWON");
		if (midstr == null || midstr.equals("")) {
			midstr = "0";
		}

		int mid = Integer.parseInt(midstr) + 1;

		String midstr1 = FrontBoard.OnlyOne("Select Max(sh_fileno) from SH_MINWON");
		if (midstr1 == null || midstr1.equals("")) {
			midstr1 = "0";
		}

		int fileno = Integer.parseInt(midstr1) + 1;

		String zipcode = sh_post_1;
		if (zipcode == null) {
			zipcode = "";
		}

		String phone = sh_tel_1 + "-" + sh_tel_2 + "-" + sh_tel_3;
		if (phone == null) {
			phone = "";
		}

		String email = sh_email_1 + "@" + sh_email_2;
		if (email == null) {
			email = "";
		}

		String birthdate = Year + Month + Day;
		if (birthdate == null) {
			birthdate = "";
		}

		mobile = sh_han_1 + "-" + sh_han_2 + "-" + sh_han_3;
		if (mobile == null) {
			mobile = "";
		}

		String[] no_ext = {"asp", "php", "cgi", "sh", "php3", "php4", "html", "htm", "inc", "jsp", "exe", "com",
				"bat", "htc", "hta"};
		if (file1 != null && !file1.equals("")) {
			String ext_1 = file1.substring(file1.lastIndexOf('.') + 1);
			ext_1 = ext_1.toLowerCase();
			for (int i = 0; i < no_ext.length; i++) {
				if (ext_1.equals(no_ext[i])) {
					out.println("<script type='text/javascript'>");
					out.print("alert('업로드 금지 파일입니다.\\n\\n확인하여 주시기 바랍니다.');");
					out.println("history.go(-1);");
					out.println("</script>");
					if (true) {
						return;
					}
				}
			}
		}

		Enumeration e = multi.getFileNames();
		e.hasMoreElements();

		String strName = (String) e.nextElement();
		if (strName == null) {
			strName = "";
		}

		String fileName = multi.getFilesystemName(strName);
		if (fileName == null) {
			fileName = "";
		}

		
		Context ic = new InitialContext();
		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");
		conn = ds.getConnection();
		stmt = conn.createStatement();

		String sql = "";
		sql = "insert into sh_minwon(";
		sql += " mid, name, zipcode, addr, addr2, phone, email, ";
		sql += " passwd, category, mailing, subject, content, ";
		sql += " answer, rejection, status, fname, sh_file_name, faq, buse, minwon_gubun, creation_date, answer_date, hit, ";
		sql += " buse_name, mobile, juminnum, answer_fname, result03, result02, result04, result01, result, sh_fileno, junbuseo, reply_type, abandon_date, ";
		sql += " birthdate, bupin, yongup, input_code, input_type_code ";
		sql += " ) values ( " + mid + ", '" + name + "', '" + zipcode + "', '" + addr + "', '" + addr2 + "', '"	+ phone + "', '" + email + "', ";
		sql += "'" + passwd + "', '" + category + "', '', '" + subject + "', '" + content + "', '', '', '신청', '"+ fileName + "','"+ fileName + "',  'N', '', '', SYSDATE, '', 0, '" + buseNm + "', '" + mobile + "', ";
		sql += "'', '', '', '', '', '', '', " + fileno + ", '', '" + sh_reply_type + "', '', '" + birthdate
				+ "', '" + sh_center + "', '" + self_text + "', '1', '2' )";

		rs = stmt.executeQuery(sql);
		session.setAttribute("sessname",null);	
		/* 
				sql += " ?,?,?,?,?,?,?,?,?,?,";
				sql += " ?,?,?,?,?,?,?,?,?,sysdate,";
				sql += " ?,?,?,?,?,?,?,?,?,?,?,?,?";
				sql += " ,?,?,?"; 
				sql += " )";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,mid);
				pstmt.setString(2,name);
				pstmt.setString(3,zipcode);
				pstmt.setString(4,addr);
				pstmt.setString(5,addr2);
				pstmt.setString(6,phone);
				pstmt.setString(7,email);
				pstmt.setString(8,passwd);
				pstmt.setString(9,category);
				pstmt.setString(10,"");
				pstmt.setString(11,subject);
				pstmt.setString(12,content);
				pstmt.setString(13,"");
				pstmt.setString(14,"");
				pstmt.setString(15,"신청");
				pstmt.setString(16,fileName);
				pstmt.setString(17,"N");
				pstmt.setString(18,"");
				pstmt.setString(19,"");
				pstmt.setInt(20,0);
				pstmt.setString(21,"감사실");
				pstmt.setString(22,mobile);
				pstmt.setString(23,"");
				pstmt.setString(24,"");
				pstmt.setString(25,"");
				pstmt.setString(26,"");
				pstmt.setString(27,"");
				pstmt.setString(28,"");
				pstmt.setString(29,"");
				pstmt.setInt(30,fileno);
				pstmt.setString(31,"");
				pstmt.setString(32,sh_reply_type);
				pstmt.setString(33,birthdate);
				pstmt.setString(34,sh_center);
				pstmt.setString(35,self_text);
				pstmt.setString(36,"1"); 
				pstmt.setString(37,"02"); 
				returnUpdate = pstmt.executeUpdate();
		*/

	} catch (IOException e) {
		if (conn != null) {
			conn.rollback();
		}
		returnUpdate = 2;
		Log.message("# IOE toString : " + e.toString());
		Log.message("# IOE message : " + e.getMessage());
	} catch (Exception e) {
		if (conn != null) {
			conn.rollback();
		}
		returnUpdate = 0;
		Log.message("# E toString : " + e.toString());
		Log.message("# E message : " + e.getMessage());
	} finally {
		try {
			/* if(pstmt != null){
				pstmt.close();
			} */
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			Log.message("# close Error : SQLException" + e.getMessage());
		} catch (Exception e) {
			Log.message("# close Error : Exception" + e.getMessage());
		}
	}
	// System.out.println("returnUpdate="+returnUpdate);
	if (returnUpdate == 1) {
	    
	    String complaint_type="";
	    String sh_center = multi.getParameter("sh_center");
	    
	    if("1".equals(sh_center)){
			complaint_type = "complaint1";
			admintel = "02-2240-5936";
		}else if("2".equals(sh_center)){
			complaint_type = "complaint2";
			admintel = "02-2240-5763";
		}else if("3".equals(sh_center)){
			complaint_type = "complaint3";
			admintel = "02-2240-5936";
		}
	    	    
		SmsMgr sm = new SmsMgr();
		boolean issms = sm.exqute(admintel, mobile, "귀하께서 제기하신 민원이 접수되어 처리중입니다.");
				
		//System.out.println("issms="+issms);
		//MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "euc-kr", new DefaultFileRenamePolicy());
		//System.out.println("multi="+multi);

		// System.out.println("query="+"Select sh_no  from center_minwon_admin where  center='" + complaint_type + "'");
		String admin_no =FrontBoard.OnlyOne("Select sh_no  from center_minwon_admin where  center='" + complaint_type + "'");
		// System.out.println("admin_no="+admin_no);
		if (admin_no!=null) {
			String damdangmobile=FrontBoard.OnlyOne("Select sh_mobile from sh_minwon_admin where sh_no = " + admin_no+ "");
			boolean damdangsms = sm.exqute(admintel, damdangmobile, "전자민원이 접수되었습니다. 확인바랍니다.");
			// System.out.println("damdangmobile="+damdangmobile);
			// System.out.println("damdangsms="+damdangsms);
		}
%>
<script type="text/javascript">
	alert("등록 되었습니다.");
	self.location = "minwon_apply03.jsp";
</script>
<%
	} else if (returnUpdate == 0) {
%>
<script type="text/javascript">
	alert("등록에 실패하였습니다. 다시 등록하여 주세요.");
	self.location = "minwon_apply02.jsp";
</script>
<%
	} else if (returnUpdate == 2) {
%>
<script type="text/javascript">
	alert("파일제한용량 100MB를 초과하였습니다.");
	history.back();
</script>
<%
	}
%>