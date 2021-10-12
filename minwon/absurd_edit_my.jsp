<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>

<%@ page contentType="text/html;charset=euc-kr" %>



<%@ page import="board.board2.DataFileInfo" %>

<%@ page import="com.oreilly.servlet.*" %>

<%@ page import="com.oreilly.servlet.multipart.*" %>



<jsp:useBean id="Board" scope="request" class="Bean.admin.BoardType1"/>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>



<%@ include file="../inc/requestSecurity.jsp" %>

<% String pageNum = "5"; %>

<%



	String mid = request.getParameter("sh_mid");

	if(mid == null) mid="0";

	int sh_mid = Integer.parseInt(mid);



	String name = "";

	String ephone = "";

	String tel1 = "";

	String tel3 = "";

	String tel2 = "";

	String subject = "";

	String content = "";

	String branch = "";

	String phone = "";

	String passwd = "";

	String addr = "";

	String addr2 = "";

	String sh_tel_1 = "";

	String sh_tel_2 = "";

	String sh_tel_3 = "";

	String sh_email_1 = "";

	String sh_email_2 = "";

	String zipcode = ""; 

	String sh_post_2 ="";

	String sh_post_1 = "";



	try {	

	

		DataSource ds = null;

		Connection conn = null;

		Statement stmt = null;

		ResultSet rs = null;

		ResultSetMetaData meta = null;

		PreparedStatement pstmt=null;



	



		Context ic = new InitialContext();

		ds = (DataSource) ic.lookup("java:comp/env/jdbc/ora816");

		conn = ds.getConnection();

		String sql = "";	

		



		sql = " select thid, name, title, branch, tel, password, text, addr, addr2, zipcode from sh_financetrouble " ;

		sql += " where thid = '"+mid+"'";



		stmt=conn.createStatement();

		rs = stmt.executeQuery(sql);

		

		StringTokenizer token = new StringTokenizer(phone," ");

		StringTokenizer token1 = new StringTokenizer(branch," ");

		StringTokenizer token2 = new StringTokenizer(zipcode," ");



		if(rs.next()){

			name = rs.getString("name");

			if(name == null) name="";

			subject = rs.getString("title");

			if(subject == null) subject="";

			content = rs.getString("text");

			if(content == null) content="";

			phone = rs.getString("tel");

			if(phone == null) phone="";

			if (phone.indexOf("--",0) == -1 ){

			token = new StringTokenizer(phone,"-");

				while(token.hasMoreTokens()){

					sh_tel_1 = token.nextToken();

					sh_tel_2 = token.nextToken();

			   		sh_tel_3 = token.nextToken();

	    		}

			}

			branch = rs.getString("branch");

			if(branch == null) branch="";

			if (branch.indexOf("@@",0) == -1 ){

			token1 = new StringTokenizer(branch,"@");

				while(token1.hasMoreTokens()){

					sh_email_1 = token1.nextToken();

					sh_email_2 = token1.nextToken();

			   	

	    		}

			}

			zipcode = rs.getString("zipcode");

			if(zipcode == null) zipcode="";

			if (zipcode.indexOf("--",0) == -1 ){

			token2 = new StringTokenizer(zipcode,"-");

				while(token2.hasMoreTokens()){

					sh_post_1 = token2.nextToken();

					sh_post_2 = token2.nextToken();

			   	

	    		}

			}



			addr = rs.getString("addr");

			if(addr == null) addr="";

			addr2 = rs.getString("addr2");

			if(addr2 == null) addr2="";

			passwd = rs.getString("password");

			if(passwd == null) passwd="";

		}



		rs.close();

		conn.close();

		

	}

	catch(Exception e){

		out.println(e.toString());

	}

 %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<head>

<title>수협 - 바다사랑 고객사랑</title>

<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

<link rel='stylesheet' type='text/css' media='all' href='../css/screen.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/board.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/minwon.css' />

<script type="text/javascript" src="../js/quickMenu.js"></script>

<script type="text/javascript" src="../js/public.js"></script>

<script type="text/javascript">

<!--

	

	function GoReg(mid){

		f.mid.value=mid;

		f.action = "../minwon/absurd_edit_proc_my.jsp";	

		f.submit();

	}

	

	function GoCan(){

		f.action = "../minwon/absurd_list_my.jsp";	

		f.submit();

	}

	//우편번호 검색

	function ZipSearch(){

		var wint = (screen.height - 350) / 2;

		var winl = (screen.width - 400) / 2;

		winprops = 'height=402,width=383,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'

		winurl = '../minwon/find_addr_my.jsp?return1=pbform.sh_post_1&amp;return2=pbform.sh_post_2&amp;return3=pbform.sh_address_1';

		win = window.open(winurl, "zipsearch", winprops)

	}

	

	//검색 우편번호 세팅

	function input_zipcode(zip1,zip2,address){

		var frm = document.f;

		//alert(zip1)

		frm.sh_post_1.value = zip1;

		frm.sh_post_2.value = zip2;

		frm.sh_address_1.value = address;

		frm.sh_address_2.focus();

	}

	

	function mail_change() {

		var A = document.f;

		

		// 밑에 직접 입력란을 활성화 시켜준다.

		if(A.sh_email_3.value == 'etc') {

			A.sh_email_2.value = '';			

		} else {

			A.sh_email_2.value = A.sh_email_3.value;			

		}

	}	

//-->

</SCRIPT>

</head>

<body id="shingo01">

<%@ include file="/include/shHeader.jsp" %>

<!-- start content table-->

<form method=post name="f" action="">

<input type="hidden" name="mid" value="" />

<input type="hidden" name="passwd" value="<%=passwd%>" />

<table id="contentTable" cellpadding="0" cellspacing="0">

  <tr> 

    <td id="sideContent" valign="top"> 

     <table cellpadding="0" cellspacing="0">

        <tr> 

          <td><img src="../member/images/sc_title_bn_mypage.gif" width="180" height="60" /></td>

        </tr>

        <tr> 

          <td height="10"></td>

        </tr>

        <tr> 

          <td><a href="../member/modify.jsp"><img src="../member/images/sc_bt_off_09.gif" width="190" height="21" border="0" /></a></td>

        </tr>

        <tr> 

          <td><a href="../member/change_pw.jsp"><img src="../member/images/sc_bt_off_10.gif" width="190" height="21" border="0" /></a></td>

        </tr> <tr> 

          <td><a href="../member/delete_main.jsp"><img src="../member/images/sc_bt_off_12.gif" width="190" height="21" border="0" /></a></td>

        </tr>

        <tr> 

          <td height="3"></td>

        </tr>

        <tr> 

          <td><a href="../member/join_list.jsp"><img src="../member/images/sc_bt_off_11.gif" width="190" height="21" border="0" /></a></td>

        </tr>

       

	<tr>

		<td><a href="../minwon/minwon_apply03_my.jsp"><img src="../member/images/sc_bt_on_13.gif" width="190" height="21" /></a></td>

	</tr>

	<tr>

		<td height="3"></td>

	</tr>

	<tr>

		<td><a href="../minwon/minwon_apply03_my.jsp"><img src="../member/images/sc_bt_off_13_01.gif" width="190" height="18" /></a></td>

	</tr>

	<tr>

		<td><a href="../minwon/shingo_001_my.jsp"><img src="../member/images/sc_bt_on_13_02.gif" width="190" height="18" /></a></td>

	</tr>

	<tr>

		<td><a href="../minwon/taxfree_my.jsp"><img src="../member/images/sc_bt_off_13_03.gif" width="190" height="18" /></a></td>

	</tr>

	<tr>

		<td height="3"></td>

	</tr>

   

        

        <tr> 

          <td height="15"></td>

        </tr>

      </table>

    </td>

    <td id="primaryContent" valign="top"> 

      <table cellpadding="0" cellspacing="0">

        <tr> 

          <td><IMG SRC="../images/pc_bg_topline.gif" WIDTH="795" HEIGHT="5" BORDER="0" alt="" /></td>

        </tr>

        <tr> 

          <td style="background:url(../images/pc_middle_line.gif); padding-left:30px;" valign="top"> 

            <table cellpadding="0" cellspacing="0" border="0">

              <tr> 

                <td id="navigator"><a href="/">Home</a> &gt; 마이페이지 > <a href="../minwon/shingo_001_my.jsp">나의민원/신고</a> 

			> 금융사고/금융부조리신고</td>

              </tr>

              <tr> 

                <td id="title"><img src="images/pcTitle050204.gif" /></td>

              </tr>

              <tr> 

                <td id="content"> 

                   <!-- 민원신청 입력 창 시작 -->

				  <table cellspacing="0" class="writeTable">

                    <tr> 

                      <th class="essential"><span>&nbsp;&nbsp;&nbsp;이름</span></th>

                      <td> 

                        <input type="text" class="typeText" name="name" value="<%=name%>">

                      </td>

                    </tr>

                    <tr> 

                     <th>&nbsp;&nbsp;&nbsp;이메일</th>

					   <td> 

						  <input type="text"  name="sh_email_1" onBlur="checkInput(this)" value="<%=sh_email_1%>" class="typeText input_txt"/>

						  <span class="sp_txt">@</span> 

						  <input type="text" name="sh_email_2" value="<%=sh_email_2%>" class="typeText input_txt" />

						  

                        <select name="sh_email_3" onChange="mail_change()">

                          <option value="">선택하세요 </option>

                          <option value='empas.com'<%if(sh_email_2.equals("empas.com")) { %>selected<% } %>>엠파스</option>

                          <option value='hanmail.net'<%if(sh_email_2.equals("hanmail.net")) { %>selected<% } %>>한메일</option>

                          <option value='korea.com'<%if(sh_email_2.equals("korea.com")) { %>selected<% } %>>코리아</option>

                          <option value='nate.com'<%if(sh_email_2.equals("nate.com")) { %>selected<% } %>>네이트</option>

                          <option value='naver.com'<%if(sh_email_2.equals("naver.com")) { %>selected<% } %>>네이버</option>

                          <option value='yahoo.co.kr'<%if(sh_email_2.equals("yahoo.co.kr")) { %>selected<% } %>>야후</option>

                          <option value='paran.com'<%if(sh_email_2.equals("paran.com")) { %>selected<% } %>>파란</option>

						  <option value='paran.com'<%if(sh_email_2.equals("suhyup.co.kr")) { %>selected<% } %>>수협</option>

                        </select>

                        <span class="smallfont">(빠른 회신을 위하여 가급적 기재해 주십시요.)</span></td>

                    </tr>

                    <tr> 

                      <th class="essential"><span>&nbsp;&nbsp;&nbsp;휴대폰</span></th>

                      <td> 

                        <input type="text" maxlength="3" name="sh_tel_1"  value="<%=sh_tel_1%>" class="typeText input_mini" />

                        <span class="sp_txt">-</span> 

                        <input type="text" maxlength="4" name="sh_tel_2"  value="<%=sh_tel_2%>" class="typeText input_mini" />

                        <span class="sp_txt">-</span> 

                        <input type="text" maxlength="4" name="sh_tel_3"  value="<%=sh_tel_3%>" class="typeText input_mini" />

                      </td>

                    </tr>

                    <tr> 

                       <th>&nbsp;&nbsp;&nbsp;주소</th>

                            <td> 

                              <input type="text" size="4" name="sh_post_1" value="<%=sh_post_1%>" readonly class="typeText input_mini" />

                              <span class="sp_txt">-</span> 

                              <input type="text" size="4" name="sh_post_2" value="<%=sh_post_2%>" readonly class="typeText input_mini" />

                              <a href="javascript:ZipSearch();"><img src="../pub_img/mb_bt_addr.gif" title="주소찾기" /></a> 

                              <br />

                              <input type="text" name="sh_address_1" value="<%=addr%>" class="typeText input_addr_01"/><br />

                              <input type="text" name="sh_address_2" value="<%=addr2%>" class="typeText input_addr_02">

                            </td>

                          </tr>

                    <th class="essential"><span>&nbsp;&nbsp;&nbsp;제목</span></th>

                    <td>

                        <input type="text" name="subject" value="<%=subject%>" class="typeText input_addr_01" />

                    </td>

                    </tr>

                    <tr> 

                      <th class="essential"><span>&nbsp;&nbsp;&nbsp;내용</span></th>

                      <td> 

                        <textarea name="content" value="" cols="25" rows="14" class="typeText content" wrap="virtual"><%=content%></textarea>

                      </td>

                    </tr>

                   </table>

                  <p class="essential">필수 입력사항</p>

				<!-- 민원신청 입력 창 끝 -->

                </td>

              </tr>

            </table>

            <table cellspacing="0" style="width:745px; margin-top:20px;">

              <tr> 

                <td align="center" height="25"> 

                  <!-- a href="join_step03.jsp" -->

                  <a href="javascript:GoReg('<%=sh_mid%>');"> <img src="../pub_img/btT01Confirm.gif" title="확인" /></a> 

                  <a href="javascript:GoCan('<%=sh_mid%>');"> <img src="../pub_img/btT01Cancle.gif" title="취소" /></a> 

                </td>

              </tr>

            </table>

          </td>

        </tr>

        <tr> 

          <td><IMG SRC="../images/pc_bg_bottomline.gif" WIDTH="795" HEIGHT="4" BORDER="0" alt="" /></td>

        </tr>

        <tr> 

          <td height="20"></td>

        </tr>

      </table>

    </td>

  </tr>

</table>

</FORM>

<!-- end content table-->

<%@ include file="/include/shFooter.jsp" %>

</body>

</html>