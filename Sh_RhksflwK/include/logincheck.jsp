<%
	String user_id = "";

	if ( session != null){
		//회원 로그인 정보
		user_id = Converter.nullchk((String)session.getAttribute("id"));		//아이디
		//out.println("USER_ID : " + USER_ID + "<br>");
				
		//세션에 정보가 없을 시 로그인 페이지로 이동
		if(user_id == null || user_id.equals("")){
			String RedirectURL = "../Sh_RhksflwK/index.jsp";
			response.sendRedirect(RedirectURL);
		}
	} 
%>