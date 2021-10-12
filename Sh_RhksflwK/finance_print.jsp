<%@ page import="java.util.*, util.*,java.text.SimpleDateFormat" contentType="text/html;charset=euc-kr"%>

<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>

<%
	String mid = request.getParameter("thididx");
	if(mid == null) mid="0";
	int sh_mid = Integer.parseInt(mid);
	String PAGE = request.getParameter("PAGE");
	//out.println(sh_mid);
	
	String TableName = " sh_financetrouble ";
	String SelectCondition = " name, addr, tel, title, branch, code, buseo, result, text,publication, ";
		   SelectCondition += " to_char(time1, 'YYYY-MM-DD') AS time1, addr2,text1" ;
	String WhereCondition = " where thid=" + sh_mid;
	String OrderCondition = "";
	
	Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, 0, 0, 0);	
	
	String name = "";
	String addr = "";
	String tel = "";
	String title = "";
	String branch = "";
	String code = "";
	String buseo = "";
	String result = "";
	String text = "";
	String time1 = "";
	String publication = "";
	String addr2 = "";
	String address = "";
	String text1 = "";

	//out.println(ResultVector.size());

	if( ResultVector.size() > 0){
		for (int i=0; i < ResultVector.size();i++){
			Hashtable h = (Hashtable)ResultVector.elementAt(i);
			

			name=(String)h.get("NAME");
			addr=(String)h.get("ADDR");
			if(addr == null) addr="";
			tel=(String)h.get("TEL");
			if(tel == null) tel="";
			title=(String)h.get("TITLE");
			branch=(String)h.get("BRANCH");
			if(branch == null) branch="";
			buseo=(String)h.get("BUSEO");
			code=(String)h.get("CODE");
			result=(String)h.get("RESULT");
			if(result == null) result="";
			text=(String)h.get("TEXT");
			time1=(String)h.get("TIME1");
			publication = (String)h.get("PUBLICATION");
			addr2=(String)h.get("ADDR2");
			if(addr2 == null) addr2="";
			address = addr + addr2;
			text1=(String)h.get("TEXT1");

			StringTokenizer stk = new StringTokenizer(text, "\r\n");
			text="";
			while(stk.hasMoreElements()){
				text += stk.nextToken();
				text += "<br>";
			}

			StringTokenizer stk1 = new StringTokenizer(text1, "\r\n");
			text1="";
			while(stk1.hasMoreElements()){
				text1 += stk1.nextToken();
				text1 += "<br>";
			}

		}
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
          <td class="white" ><%=title%></td>
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
                      <td height="30" class="bluesky" width="90">민원인</td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td width="90" class="bluesky">신청일</td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td width="90" class="bluesky">특수코드</td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td width="90" class="bluesky">담당부서</td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td width="90" class="bluesky">처리상태</td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td width="100" class="bluesky">처리결과</td>
                     </tr>
                    <tr> 
                      <td colspan="15" height="1" bgcolor="#d9e8f3"></td>
                    </tr>
                    <tr align="center"> 
                      <td height="30"><%=name%></td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td><%=time1%></td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td><%=publication%></td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td><%=buseo%></td>
                      <td width="1" bgcolor="d9e8f3"></td>
                      <td><%=code%></td>
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
                      <td height="30" style="padding-left:10;" class="bluesky">휴대폰</td>
                      <td><%=tel%></td>
                    </tr>
                    <tr> 
                      <td colspan="2" height="1" bgcolor="#d9e8f3"></td>
                    </tr>
                    <tr> 
                      <td height="30" style="padding-left:10;" class="bluesky">이메일</td>
                      <td><%=branch%></td>
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
                <td style="padding:20 20 20 20;"><%=text%></td>
              </tr>
            </table>
            <!-- 민원내역 끝 -->
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
                <td height="30" style="padding-left:10;" class="table_bg_title">답변내역</td>
              </tr>
              <tr> 
                <td style="padding:20 20 20 20;"><%=text1%></td>
              </tr>
            </table>
            <!-- 민원내역 끝 -->
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
