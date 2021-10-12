<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page language="java" import="java.lang.*, java.util.*, java.sql.*, util.*" %><%@page import="java.net.InetAddress" %>
<%
	String serverIp = (String)InetAddress.getLocalHost().getHostAddress();		if(serverIp.indexOf("138.240") != -1 || serverIp.indexOf("138.251") != -1 || serverIp.indexOf("138.250") != -1 || serverIp.indexOf("138.252") != -1 || serverIp.indexOf("203.228") != -1){			} else if(serverIp.indexOf("192.168.1") != -1 || serverIp.indexOf("112.175.44.67") != -1 ){		} else {		%>		      <script type=text/javascript>		         alert("잘못된 접근입니다.");		         top.location.href = "/index.jsp";		      </script>		<%			}	try{
		//RETURL = request("RETURL")	' 되돌아갈 주소
		String SH_ID = (String)session.getValue("sh_id");
		
		String SH_NAME = (String)session.getValue("sh_name");
		
%>
<html>
<head>
<title>수협</title>
<meta http-equiv="Expires" content="0">
<meta http-equiv="Cache-Control" content="no-cache"> 
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<LINK href="img/style.css" type=text/css rel=stylesheet>
<script type="text/javascript">
<!--
	//로그인
	function post(){
		//if(!chkID(pbform.sh_id,"ID를 입력해 주세요"))  return;
	
		
		if(pbform.sh_id.value == 0 ){	
			alert("아이디를 입력해 주세요.");
			pbform.sh_id.focus(); 
			return;
		}	
		if(pbform.sh_pwd.value == 0){
			alert("비밀번호를 입력해 주세요.");
			pbform.sh_pwd.focus(); 
			return;
		}
		
			
		pbform.submit();
	}
	
	function EnterCheck(i) {
		if(event.keyCode == 13)		//익스플로러에서.
		{
			if(i == 1) {
				pbform.sh_pwd.focus();
			} else if(i == 2) {
				//pbform.submit();
				post();
			}
		}	
	}

//-->
</script>
</head>
<% if(SH_ID == null || SH_ID.equals("")){ %>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" onLoad="javascript:pbform.sh_id.focus();">
<% } else { %>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
<% } %>	
<% if(SH_ID == null || SH_ID.equals("")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td> 
      <table cellspacing=0 cellpadding=0 width=970 border=0>
        <tr> 
          <td align=middle width=255 height=71 style="padding-left:25;"><img src="img/suhyup_logo.gif" border=0 alt="수협전자민원관리"></td>
          <td valign=center align=right height=71>관리자의 아이디와 비밀번호를 입력해주세요. </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td bgcolor="#284e8f"> <img src="img/timg_01.gif"></td>
  </tr>
  <tr> 
    <td bgcolor="e2e8ef" height="35">&nbsp;</td>
  </tr>
  <tr> 
    <td bgcolor="c9dde7" height="1"></td>
  </tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td align="center"> 
      <table cellspacing=3 cellpadding=3 width=200 align=center bgcolor=#dedede 
border=0>
        <tbody> 
        <tr> 
          <td valign=center align=middle bgcolor=#f7f7f7 height=30><font 
      color=#1f516f><b>관리자 로그인</b></font> </td>
        </tr>
        </tbody> 
      </table>
      <br>
      <br>
	  <form method="post" action="login_proc.jsp" name="pbform">
	  <input type="hidden" name="RETURL" value="<%//=RETURL%>">
      <table cellspacing=0 cellpadding=0 width=250 border=0>
        <tbody> 
        <tr> 
          <td> 
            <table height=47 cellspacing=0 cellpadding=0 width="100%" border=0>
              <tbody> 
              <tr> 
                <td width=57><img height=5 src="img/login_id.gif"></td>
                <td> 
                  <input type="text" name="sh_id" class="input01"  tabindex="1" onKeyDown="EnterCheck(1);" autocomplete=Off>
                </td>
              </tr>
              <tr> 
                <td width=57><img height=5 src="img/login_pass.gif"></td>
                <td> 
                  <input type="password" name="sh_pwd" class="input01"  tabindex="2" onKeyDown="EnterCheck(2);" maxlength="20" autocomplete=Off>
                </td>
              </tr>
              </tbody> 
            </table>
          </td>
          <td> <a href="javascript:post();"><img src="img/btn_login.jpg" align=absMiddle border=0></a> 
          </td>
        </tr>
        </tbody> 
      </table>
	  </form>
<% }else{ %>
	<table width="100%" height="100%" align="center">
		<tr align="center">
			<td align="center">사용하실 관리자 메뉴를 선택하세요.</td>
		</tr>
	</table>
<% } %>
    </td>
  </tr>
</table>
</body>
</html>
<% 
	} catch(Exception e) {
		out.println("index.jsp : " + e.getMessage());
	} finally {

	}
%> 