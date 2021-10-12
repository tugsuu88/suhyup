<%@ page language="java" import="java.util.*, java.sql.*, Bean.Front.Common.*, Bean.Common.*, util.*, javax.sql.*, javax.naming.*, java.io.*"%>

<%@ page contentType="text/html;charset=euc-kr" %>
<% request.setCharacterEncoding("euc-kr"); %>
<% response.setContentType("text/html; charset=euc-kr"); %>

<jsp:useBean id="FrontBoard" scope="request" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="request" class="Bean.Front.Common.FrontDbUtil"/>
<%
	String mid = request.getParameter("thididx");
	String bupin = request.getParameter("bupin");
	
	String yongup = request.getParameter("yongup");
	
	if(mid == null) mid="0";
	if(bupin == null) bupin="";
	if(yongup == null) yongup="";
	
	int sh_mid = Integer.parseInt(mid);
	
	String name = "";
	String addr = "";
	String phone = "";
	String mobile = "";
	String email = "";
	String addr2 = "";
	String zipcode = "";
	String address = "";
	String category = "";
	String minwon_gubun = "";
	String status = "";
	String buse_name = "";
	String result = "";
	String content = "";
	String creation_date = "";
	String subject = "";
	String answer = "";
	
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
		
		sql = " select name, addr, addr2, phone, mobile, email, zipcode, category, minwon_gubun, status, buse_name,";
		sql += "result, content, subject, to_char(creation_date, 'YYYY-MM-DD  AM HH24:MI:SS') AS creation_date,answer from sh_minwon " ;
		sql += " where mid = '"+sh_mid+"'";

		stmt=conn.createStatement();
		rs = stmt.executeQuery(sql);
		 
		if(rs.next()){
			name = rs.getString("name");
			if(name != null && !name.equals("")){
				name = name.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			}
			
			addr = rs.getString("addr");
			if(addr == null) addr = "";
			if(addr != null && !addr.equals("")){
				addr = addr.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			}
			
			addr2 = rs.getString("addr2");
			if(addr2 == null) addr2 = "";
			if(addr2 != null && !addr2.equals("")){
				addr2 = addr2.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			}
			
			phone = rs.getString("phone");
			if(phone == null) phone = "";
			if(phone != null && !phone.equals("")){
				phone = phone.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			}
			
			mobile = rs.getString("mobile");
			if(mobile == null) mobile = "";
			if(mobile != null && !mobile.equals("")){
				mobile = mobile.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			}
			
			email = rs.getString("email");
			if(email == null) email = "";
			if(email != null && !email.equals("")){
				email = email.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			}
			
			zipcode = rs.getString("zipcode");
			if(zipcode != null && !zipcode.equals("")){
				zipcode = zipcode.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			}
			
			address = "["+ zipcode + "]" + addr + addr2;
			
			category = rs.getString("category");
			if(category != null && !category.equals("")){
				category = category.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			}
			
			minwon_gubun = rs.getString("minwon_gubun");
			if(minwon_gubun == null) minwon_gubun = "";
			if(minwon_gubun != null && !minwon_gubun.equals("")){
				minwon_gubun = minwon_gubun.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			}
			
			status = rs.getString("status");
			if(status == null) status = "";
			if(status != null && !status.equals("")){
				status = status.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			}
			
			buse_name = rs.getString("buse_name");
			if(buse_name == null) buse_name = "";
			if(buse_name != null && !buse_name.equals("")){
				buse_name = buse_name.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			}
			
			result = rs.getString("result");
			if(result == null) result = "";
			if(result != null && !result.equals("")){
				result = result.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			}
			
			content = rs.getString("content");
			if(content != null && !content.equals("")){
				content = content.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			}
			
			subject = rs.getString("subject");
			if(subject != null && !subject.equals("")){
				subject = subject.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			}
			
			creation_date = rs.getString("creation_date");
			if(creation_date != null && !creation_date.equals("")){
				creation_date = creation_date.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			}
			
			answer = rs.getString("answer");
			if(answer == null) answer = "";
			if(answer != null && !answer.equals("")){
				answer = answer.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
			}
		}

		rs.close();
		conn.close();
		
	}
	catch(Exception e){
		out.println(e.toString());
	}
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<LINK href="img/style.css" type=text/css rel=stylesheet>
<script language="javascript">
<!--
		
	function GoPt(){	
		 window.print();
      
	}
	
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" scroll=yes>
<table width="620" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td background="img/popup_print_top.gif" height="80" style="padding:48 0 0 26" valign="top"> 
      <table width="576" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td class="white" ><%=subject%></td>
          <td align="right" width="55"><a href="javascript:GoPt();"><img src="img/btn_print.gif" align="absmiddle" alt="출력" border="0"></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td background="img/popup_print_bg.gif" align="center"> 
      <table width="592" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td> 
            <!-- 민원접수정보 테이블 시작-->
            <table width="592" border="0" cellspacing="0" cellpadding="0" class="read_outline" height="100%">
              <tr> 
                <td height="30" style="padding-left:10;" class="table_bg_title">민원접수정보</td>
              </tr>
              <tr> 
                <td valign="top"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr align="center"> 
                      <td height="30" class="bluesky" width="80">민원인</td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td width="80" class="bluesky">분야</td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td width="80" class="bluesky">신청일</td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td width="80" class="bluesky">민원분류</td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td width="65" class="bluesky">처리상태</td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td width="100" class="bluesky">담담부서</td>
                      <td  width="1" bgcolor="d9e8f3"></td>
                      <td width="65" class="bluesky">처리결과</td>
                    </tr>
                    <tr> 
                      <td colspan="15" height="1" bgcolor="#d9e8f3"></td>
                    </tr>
                    <tr align="center"> 
                      <td height="30"><%=name%></td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td><%=category%></td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td><%=creation_date%></td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td><%=minwon_gubun%></td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td><%=status%></td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td><%=buse_name%></td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td><%=result%></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            <!--  민원접수정보 테이블 끝-->
          </td>
        </tr>
        <tr> 
          <td height="8"></td>
        </tr>
        <tr> 
          <td> 
            <!-- 민원인 상세정보 시작 -->
            <table width="592" border="0" cellspacing="0" cellpadding="0" class="read_outline" height="100%">
              <tr> 
                <td height="30" style="padding-left:10;" class="table_bg_title">민원인 
                  상세정보</td>
              </tr>
              <tr> 
                <td valign="top"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="30" style="padding-left:10;" class="bluesky" width="90">성명</td>
                      <td><%=name%></td>
                    </tr>
                    <tr> 
                      <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                    </tr>
                    <tr> 
                      <td height="30" style="padding-left:10;" class="bluesky">주소</td>
                      <td><%=address%></td>
                    </tr>
                    <tr> 
                      <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                    </tr>
                    <tr> 
                      <td height="30" style="padding-left:10;" class="bluesky">전화번호</td>
                      <td><%=phone%></td>
                    </tr>
                    <tr> 
                      <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                    </tr>
                    <tr> 
                      <td height="30" style="padding-left:10;" class="bluesky">핸드폰</td>
                      <td><%=mobile%></td>
                    </tr>
                    <tr> 
                      <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                    </tr>
                    <tr> 
                      <td height="30" style="padding-left:10;" class="bluesky">이메일</td>
                      <td><%=email%></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            <!-- 민원인 상세정보 끝-->
          </td>
        </tr>
        <tr> 
          <td height="8"></td>
        </tr>
        <tr> 
          <td> 
            <!-- 민원내역 시작 -->
            <table width="592" border="0" cellspacing="0" cellpadding="0" class="read_outline">
              <tr> 
                <td height="30" style="padding-left:10;" class="table_bg_title">민원내역</td>
              </tr>
              <tr> 
                <td style="padding:20 20 20 20;">● 법인구분 : <%=(String) session.getAttribute("buseName") %><br />	● 대상영업점 : <%=yongup %><br /><br /><%=content%></td>
              </tr>
            </table>
            
          </td>
        </tr>
		
      </table>
    </td>
  </tr>
  <tr> 
    <td><img src="img/popup_print_bottom.gif" width="620" height="20"></td>
  </tr>
  <tr> 
    <td bgcolor="e5e5e5" align="center" height="40"><img src="img/popup_close.gif" width="67" height="18" onClick="javascript:window.close();" style="cursor:hand" alt="닫기"></td>
  </tr>
</table>
</body>
</html>
