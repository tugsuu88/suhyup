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

	

	String mid = request.getParameter("mid");

	if(mid == null) mid="0";

	int sh_mid = Integer.parseInt(mid);

	

	String telephone = Converter.nullchk(request.getParameter("telephone"));



	String name = "";

	String subject = "";

	String content = "";

	String creation_date = "";

	String status = "";

	String phone = "";

	String passwd = "";

	String answer = "";

	String mobile = "";

	String fname ="";



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

		



		sql = " select mid, name, subject, status, phone, passwd,mobile, content,answer,fname, to_char(creation_date, 'YYYY-MM-DD') AS creation_date from sh_minwon " ;

		sql += " where mid = '"+mid+"'";



		stmt=conn.createStatement();

		rs = stmt.executeQuery(sql);

	

		if(rs.next()){

			name = rs.getString("name");

			if(name == null) name="";

			subject = rs.getString("subject");

			if(subject == null) subject="";

			content = rs.getString("content");

			if(content == null) content="";

			creation_date = rs.getString("creation_date");

			if(creation_date == null) creation_date="";

			status = rs.getString("status");

			if(status == null) status="";

			phone = rs.getString("phone");

			if(phone == null) phone="";

			passwd = rs.getString("passwd");

			if(passwd == null) passwd="";

			answer = rs.getString("answer");

			if(answer == null) answer="";

			mobile = rs.getString("mobile");

			if(mobile == null) mobile="";

			fname = rs.getString("fname");

			if(fname == null) fname="";

		

			

			StringTokenizer stk = new StringTokenizer(content, "\r\n");

			content="";

			while(stk.hasMoreElements()){

				content += stk.nextToken();

				content += "<br/>";

			}

			

			StringTokenizer stk1 = new StringTokenizer(answer, "\r\n");

			answer="";

			while(stk1.hasMoreElements()){

				answer += stk1.nextToken();

				answer += "<br/>";

			}

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

<link rel='stylesheet' type='text/css' media='all' href='../css/minwon.css' />

<link rel='stylesheet' type='text/css' media='all' href='../css/board.css' />

<script type="text/javascript" src="../js/quickMenu.js"></script>

<script type="text/javascript" src="../js/public.js"></script>

<script type="text/javascript">

<!--

	function goReg(){

		//alert(f.phone.value);

		f.action = "../minwon/minwon_apply06_my.jsp";	

		f.submit();

	}

	function goEdit(){

		//alert(f.phone.value);

		if (confirm("철회하시겠습니까?")) {

		document.f.encoding = "multipart/form-data"; 

		f.action = "../minwon/minwon_apply04_proc_my.jsp";	

		f.submit();

		}

		else {

		alert("취소되었습니다!");		

		}

	}

	function DownloadPopup(mid){

		f.mid.value=mid;

		var wint = (screen.height - 245) / 2;

		var winl = (screen.width - 300) / 2;

		winprops = 'height=245,width=300,top='+wint+',left='+winl+',status=no,scrollbars=no,resize=no'

		winurl = '../minwon/file_popup.jsp?mid='+mid;

		win = window.open(winurl, "file_popup1", winprops)

	}

//-->

</SCRIPT>

</head>

<body id="minwon02">

<%@ include file="/include/shHeader.jsp" %>

<!-- start content table-->

<form method=get name="f" enctype="" action="">

<input type="hidden" name="name" value="<%=name%>" />

<input type="hidden" name="mobile" value="<%=mobile%>" />

<input type="hidden" name="passwd" value="<%=passwd%>" />

<input type="hidden" name="sh_mid" value="<%=sh_mid%>" />

<INPUT TYPE="hidden" NAME="telephone" value="<%=telephone%>" />

<INPUT TYPE="hidden" NAME="mid" />

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

		<td><a href="../minwon/minwon_apply03_my.jsp"><img src="../member/images/sc_bt_on_13_01.gif" width="190" height="18" /></a></td>

	</tr>

	<tr>

		<td><a href="../minwon/shingo_001_my.jsp"><img src="../member/images/sc_bt_off_13_02.gif" width="190" height="18" /></a></td>

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

                <td id="navigator"><a href="/">Home</a> &gt; 마이페이지 > <a href="../minwon/minwon_apply03_my.jsp">나의민원/신고</a> 

                  > 민원처리결과조회</td>

              </tr>

              <tr> 

                <td id="title"><img src="../images/pcTitle050102.gif" /></td>

              </tr>

              <tr> 

                <td id="content"> 

                  <!-- 본문영역 시작 -->

                  <table cellpadding="0" cellspacing="0" border="0" class="list">

                    <thead> 

                    <tr> 

                      <td class="number" width="50" align="center">번호</td>

                      <td class="subject" width="300" align="center">제목</td>

                      <td class="file" width="80" align="center">처리상태</td>

                      <td  class="writer" width="80" align="center">작성자</td>

					  <td class="file" width="50" align="center">파일</td>

                      <td class="date" width="70" align="center">작성일</td>

                    </tr>

			</thead> <tbody> 

                    <tr> 

                      <td  class="number"><%=mid%></td>

                      <td class="subject"><%=subject%></td>

					   <%if(status.equals("반송") || status.equals("이첩")){%>

                      <td class="file" width="80" align="center">처리중</td>

					  <% } else{ %>

						<td class="file" width="80" align="center"><%=status%></td>

					  <% } %>

	                  <td  class="writer"><%=name%></td>

					  <%if(fname==null || fname.equals("")){%>

					  <td align="center">&nbsp;</td>

					  <%}else{%>

					  <td class="file" width="50" align="center"><a href="javascript:DownloadPopup('<%=mid%>');"><img src="images/file_icon.gif" border="0" align="absmiddle" /></a></td>

					  <%} %>

                      <td class="date"><%=creation_date%></td>

                    </tr>

                    </tbody> 

                  </table>

                  <!-- 내용 영역-->

				  <table width="370" border="0" cellspacing="0" cellpadding="0">

                    <tr>

                        <td height="30"><img src="images/min_question.gif" /></td>

                     </tr>

				   <table width="370" border="0" cellspacing="0" cellpadding="0">

                    <tr> 

                      <td style="padding:5px 0 5px 0"> 

                        <table cellspacing="0" style="width:745px; border:2px solid #E9E9E9; background-color:#F8F8F7;" width="100%">

                          <tr> 

                            <td style="padding:10px;"> 

                              <table width="100%" border="0" cellspacing="0" style="border:1px solid #E9E9E9; background-color:#FFFFFF;">

                                <tr> 

                                  <td style="padding:10px;"><%=content%>

                                    

                                  </td>

                                </tr>

                              </table>

                            </td>

                          </tr>

                        </table>

                      </td>

                    </tr>

                    <tr> 

                      <td height="1" bgcolor="ebebeb"></td>

                    </tr>

                  </table>

				  <table width="370" border="0" cellspacing="0" cellpadding="0">

                    <tr>

                        <td height="30"><img src="images/min_answer.gif" /></td>

                     </tr>

				  <table width="370" border="0" cellspacing="0" cellpadding="0">

                    <tr> 

                      <td style="padding:5px 0 5px 0"> 

                        <table cellspacing="0" style="width:745px; border:2px solid #E9E9E9; background-color:#F8F8F7;" width="100%">

                          <tr> 

                            <td style="padding:10px;"> 

                              <table width="100%" border="0" cellspacing="0" style="border:1px solid #E9E9E9; background-color:#FFFFFF;">

                                <tr> 

                                  <td style="padding:10px;">

								  <%if(answer==null || answer.equals("")){%>처리중입니다.

								  <%}else{%>

								    <%=answer%>

								  <%} %>

		                         </td>

                                </tr>

                              </table>

                            </td>

                          </tr>

                        </table>

                      </td>

                    </tr>

                    <tr> 

                      <td height="1" bgcolor="ebebeb"></td>

                    </tr>

                  </table>

                  <table cellspacing="0" class="button">

                    <tr> 

                      <td> <a href="javascript:goReg();"><img src="../pub_img/btT01Confirm.gif" title="확인버튼" width="67" height="18" /></a><a href="javascript:goEdit();"><img src="../pub_img/btminwon_repeal.gif" title="민원철회버튼" width="68" height="18" /></a></td>

                    </tr>

                  </table>

                </td>

              </tr>

            </table>

            <!-- 본문영역 끝-->

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