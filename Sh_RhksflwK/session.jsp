<%@ page contentType="text/html;charset=euc-kr"%>
<%
	//슈퍼 관리자인 경우
	session.setAttribute("id","super");
	

	session.setAttribute("name","관리자");
	session.setAttribute("buseo","all");
	
	//감사실일 경우
	//session.setAttribute("id","slimes1");
	//session.setAttribute("name","조용선");
	//session.setAttribute("buseo","감사실");
	
	//타부서일 경우
	//session.setAttribute("id","super");
	//session.setAttribute("name","관리자");
	//session.setAttribute("buseo","all");
%>
<table width="100%" height="100%">
	<tr>
		<td align="center" valign="absmiddle"><a href="finance.jsp">세션로그인</a></td>
	</tr>
</table>
