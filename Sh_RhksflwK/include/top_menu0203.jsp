<%@ page contentType="text/html;charset=euc-kr"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td>&nbsp; </td>
  </tr>
  <tr> 
    <td bgcolor="#284e8f"> 
      <table cellspacing=0 cellpadding=0 border=0 height="35">
        <tr> 
          <td width="25"></td>
		  <% if(sa_admin_manager.equals("Y")) { %>
          <td align="center" width="135"> <a href="administrator.jsp"   class="menu_off">관리자 
            관리</a></td>
          <td width="2" align="center"><img src="img/top_line.gif"></td>
		  <% } %>
          <% if(sa_admin_minwonall.equals("Y") || sa_admin_buseo.equals("Y")) { %>
          <td align="center" width="120">
		  <table width="96%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="5"><img src="img/top_m01.gif" width="5" height="40"></td>
                <td class="menu_on" background="img/top_m02.gif" align="center">민원관리</td>
                <td width="5"><img src="img/top_m03.gif" width="5" height="40"></td>
              </tr>
            </table>
		  </td>
		  <td width="2" align="center"><img src="img/top_line.gif"></td>
		  <% } %>
		  <% if(sa_admin_result.equals("Y")) { %>
          <td align="center" width="150"><a href="result.jsp"  class="menu_off">민원처리결과 
            공시</a></td>
          <td width="2" align="center"><img src="img/top_line.gif"></td>  
          <% } %>
		  <% if(sa_admin_jebo.equals("Y")) { %>
          <td align="center" width="135"><a href="finance.jsp"  class="menu_off">금융사고제보</a></td>
		  <td width="2" align="center"><img src="img/top_line.gif"></td>
		  <% } %>	
		  <% if(sa_admin_bujori.equals("Y")) { %>
          <td align="center" width="135"><a href="absurd.jsp"  class="menu_off">금융부조리신고</a></td>
		  <td width="2" align="center"><img src="img/top_line.gif"></td>
		  <% } %>	
		  <% if(sa_admin_myunsei.equals("Y")) { %>
          <td align="center" width="170" class="menu_off"><a href="oil.jsp"  class="menu_off">면세유류 부정유통 신고</a></td>
		  <td width="2" align="center"><img src="img/top_line.gif"></td>
		  <% } %>	
		  
		  <% if(sa_admin_corruption.equals("Y")) { %>

          <td align="center" width="170" class="menu_off"><a href="corruption.jsp"  class="menu_off">행동강령 신고·상담센터</a></td>
		<!-- 20141023 수정 -->
		<td align="center" width="170" class="menu_off"><a href="commodity.jsp" class="menu_off">신고물품 처리결과 공개</a></td>
		<td width="2" align="center"><img src="img/top_line.gif"></td>
		<!-- //20141023 수정 -->
		  <td width="2" align="center"><img src="img/top_line.gif"></td>
		  <td align="center" width="170" class="menu_off"><a href="budget.jsp"  class="menu_off">예산낭비신고</a></td>
		  <td width="2" align="center"><img src="img/top_line.gif"></td>
          <% } %> 	
          
         <!-- 20170206 메뉴 추가 (청탁신고제보) -->
		<% if(sa_admin_favors.equals("Y")) { %>
		<td align="center" width="100"><a href="favors.jsp"  class="menu_off">청탁신고제보</a></td>
		<td width="2" align="center"><img src="img/top_line.gif"></td>
		<% } %>
		
		  <% if(sa_admin_faq.equals("Y")) { %>
          <td align="center" width="100"><a href="faq.jsp"  class="menu_off">FAQ</a></td>
		  <td width="2" align="center"><img src="img/top_line.gif"></td>
		  <% } %>	
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
  <% if(sa_admin_manager.equals("Y")) { %>
    <td bgcolor="e2e8ef" height="35" style="padding-left:135;">
  <% } else { %>
	<td bgcolor="e2e8ef" height="35" style="padding-left:15;">
  <% } %>
      <table border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
			  <% if(sa_admin_minwonall.equals("Y") && sa_admin_buseo.equals("Y") && sa_admin_upright.equals("Y")) { %>
			  
			  	<a href="madmin_01.jsp">민원접수현황</a> ｜ <a href="madmin_02.jsp">부서별 민원관리</a> ｜  <b>청렴수협인상</b> <% if(sa_admin_sms.equals("Y") ) { %> | <a href="center_minwon_admin_list.jsp">민원담당 SMS관리</a> <% } %>
			  
			  <% } else if(sa_admin_minwonall.equals("Y") && sa_admin_buseo.equals("") && sa_admin_upright.equals("") ) { %>
			  
			  	<a href="madmin_01.jsp"><b>민원접수현황</b></a> <% if(sa_admin_sms.equals("Y") ) { %> | <a href="center_minwon_admin_list.jsp">민원담당 SMS관리</a> <% } %>
			  
			  <% } else if(sa_admin_minwonall.equals("") && sa_admin_buseo.equals("Y") && sa_admin_upright.equals("")) { %>
			 
			  	<a href="madmin_02.jsp"><b>부서별 민원관리</b></a> <% if(sa_admin_sms.equals("Y") ) { %> | <a href="center_minwon_admin_list.jsp">민원담당 SMS관리</a> <% } %>
			 
			  <% } else if(sa_admin_minwonall.equals("") && sa_admin_buseo.equals("") && sa_admin_upright.equals("Y")) { %>
			 
			 	<a href="admin_upright_list.jsp"><b>청렴수협인상</b></a> <% if(sa_admin_sms.equals("Y") ) { %> | <a href="center_minwon_admin_list.jsp">민원담당 SMS관리</a> <% } %>
			 
			  <% } else if(sa_admin_minwonall.equals("Y") && sa_admin_buseo.equals("Y") && sa_admin_upright.equals("")) {%>
			
				<a href="madmin_01.jsp">민원접수현황</a> | <a href="madmin_02.jsp">부서별 민원관리</a> <% if(sa_admin_sms.equals("Y") ) { %> | <a href="center_minwon_admin_list.jsp">민원담당 SMS관리</a> <% } %>				  		
			 
			  <% } else if(sa_admin_minwonall.equals("Y") && sa_admin_buseo.equals("") && sa_admin_upright.equals("Y")) {%>
			
				<a href="madmin_01.jsp">민원접수현황</a> | <a href="admin_upright_list.jsp"><b>청렴수협인상</b></a> <% if(sa_admin_sms.equals("Y") ) { %> | <a href="center_minwon_admin_list.jsp">민원담당 SMS관리</a> <% } %>					  		
			  
			  <% } else if(sa_admin_minwonall.equals("") && sa_admin_buseo.equals("Y") && sa_admin_upright.equals("Y")) {%>
			
				<a href="madmin_02.jsp">부서별 민원관리</a> | <a href="admin_upright_list.jsp"><b>청렴수협인상</b></a> <% if(sa_admin_sms.equals("Y") ) { %> | <a href="center_minwon_admin_list.jsp">민원담당 SMS관리</a> <% } %>					  		
			  
			  <% } else { %>
			  		<% if(sa_admin_sms.equals("Y") ) { %> | <a href="center_minwon_admin_list.jsp">민원담당 SMS관리</a> <% } %>
			  <% } %>
		  </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td bgcolor="c9dde7" height="1"></td>
  </tr>
</table>
