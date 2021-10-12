<%@ page import="java.util.*, util.*, java.util.Calendar;" contentType="text/html;charset=euc-kr"%>
<% String pageNum = "4"; %>
<jsp:useBean id="FrontBoard" scope="session" class="Bean.Front.Common.FrontBoradType1"/>
<jsp:useBean id="FrontDbUtil" scope="session" class="Bean.Front.Common.FrontDbUtil"/>
<%

	String myPage = request.getRequestURI();
	
	Calendar cal = Calendar.getInstance();
	int strYear = cal.get(Calendar.YEAR);

	String gubun ="";
	if (Converter.nullchk(request.getParameter("gubun")) == null || Converter.nullchk(request.getParameter("gubun")).equals("")){
		//gubun = "1";
		gubun = Integer.toString(strYear);
	}else{
		gubun = Converter.nullchk(request.getParameter("gubun"));
	}

	int PAGE = 0;

	String TableName = " sh_poster ";
    String SelectCondition = null;
    String WhereCondition = null;
    String OrderCondition = null;

	if (request.getParameter("PAGE") == null || ((String)request.getParameter("PAGE")).equals("")){
		PAGE = 1;
	}else{
		PAGE = Integer.parseInt(request.getParameter("PAGE"));
	}

	SelectCondition = " sh_no, sh_filename, sh_title, sh_alt_title ";
	OrderCondition  = " ORDER BY sh_no DESC ";

	WhereCondition = "where sh_sel = '3' and sh_div = '" + gubun + "' ";

	int StartRecord = 0;
	int EndRecord   = 0;
	int DefaultListRecord = 6;
	int DefaultPageBlock = 10;

	int TotalRecordCount = FrontBoard.TotalCount(TableName, WhereCondition);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<title>나눔사진전 &gt; 사회공헌 &gt; 열린수협 &gt; 수협</title><!-- 20150216 -->
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" /><link rel="stylesheet" type="text/css" href="/css/screen.css" />
	<script type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="/js/public.js"></script>
	<script type="text/javascript" src="/js/common.js"></script>
	
<script type="text/javascript">
function showPic(whichpic) {
	var source = whichpic.getAttribute("href");
	var placeholder = document.getElementById("placeholder");
	var text = whichpic.getAttribute("title");
	var description = document.getElementById("description");
	placeholder.setAttribute("src",source);
	placeholder.setAttribute("alt",text);
	description.firstChild.nodeValue = text;
}
function popupImages(){
	var width = 520;
	var height =650;
	var x, y;
	var screen_width  = screen.width;
	var screen_height = screen.height;
	x = (screen_width  / 2) - (width  / 2);
	y = (screen_height / 2) - (height / 2);
	var pop = window.open ( "showimage_1.jsp","print","width=" + width + ", height=" + height + ", left=" + x + ", top=" + y + ", toolbar=no, status=no, menubar=no, scrollbars=yes, resizable=no");
}

function gubunChange() {
	pbform.submit();
}

function layerPopup(source, alt) {
	
	if(navigator.userAgent.indexOf("MSIE 7.0") > -1) {
		
	} else {
		$box = "<div id='dim' style='position:fixed;left:0;z-index:2000;width:100%;height:100%;background-color:#000000;display:none'>&nbsp;</div>";
		$("body").prepend($box);
	}
	$("#dim").css("opacity","0.7");
	$("#dim").fadeIn();
	
	$(".poster_img").attr("src", source);
	$(".poster_img").attr("alt", alt);
	
	$left_width = $(window).width();
	$pop_width = $(".popup").width();
	$left_sum = $(window).scrollLeft() + ($left_width - $pop_width) /2;

	$top_height = $(window).height();
	$pop_height = $(".popup").height();
	$top_sum = $(window).scrollTop() + ($top_height - $pop_height) /2;
		
	$(".popup").css('left', $left_sum + "px");
	$(".popup").css('top', $top_sum + "px");
	
	$(".popup").fadeIn();
	
}

function layerClose() {
	$(".popup").fadeOut();
	$("#dim").fadeOut();
	$("#dim").remove();
}

</script>
</head>
<body>
	<!-- header -->
	<%@ include file="/include/shHeader.jsp" %>
	<!-- //header -->
	<!-- container -->
	<div id="ContentLayer">
		<!-- LNB -->
		<%@ include file="/include/lnbPublic.jsp" %>
		<!-- //LNB -->
		<!-- contents -->
		<div id="primaryContent">
			<p class="indicate"><span class="shHome">수협</span><span>열린수협</span><span>사회공헌</span>나눔사진전</p>
			<h3>나눔사진전</h3>	
			<div class="open_nanum">
				<div class="nanum_top">
					<dl class="nm_dl">
						<dt class="nm_dt">나누고 더하면 곱해지는 행복 전시회</dt>
						<dd class="nm_dd">수협은 2005년도부터 한해 동안 수협 임직원들이 직접 참여한 사회봉사활동 등에 대한
						사진 전시를 통하여 나눔경영의 공감대 확산 및 참여동기를 부여하고 있습니다.
						2007년 12월에는 윤리경영 사진작품 28점을 수협중앙회 본사1층 현관입구와 2층 강당
						입구에서 나눔경영 활동사진전시회를 개최하였으며, 온라인상의 자유게시판에도 게시하
						여 원거리 영업점에 근무하는 직원들도 열람할 수 있도록 하였습니다.</dd>
					</dl>
				</div>
			</div>					

<form name="pbform" method="post" action="nanum.jsp">
			<label for="FIELD" class="tts">나눔사진전 년도별 선택</label>
			<select name="gubun" id="FIELD" title="조건선택" class="w128 mgb25">
				 <%
				  for(int yyyy=strYear; yyyy>=2005; yyyy--){
				   
				 %>
				   <option value="<%=yyyy%>" <% if (Integer.toString(yyyy).equals(gubun)) { %>selected<% } %>><%=yyyy%>년</option>
				 <%
				  }
				 %>
				<%-- <option value="2015" <% if ("2015".equals(gubun)) { %>selected<% } %>>2015</option>
				<option value="2014" <% if ("2014".equals(gubun)) { %>selected<% } %>>2014</option>
				<option value="2013" <% if ("2013".equals(gubun)) { %>selected<% } %>>2013</option>
				<option value="2012" <% if ("2012".equals(gubun)) { %>selected<% } %>>2012</option>
				<option value="2011" <% if ("2011".equals(gubun)) { %>selected<% } %>>2011</option>
				<option value="2010" <% if ("2010".equals(gubun)) { %>selected<% } %>>2010</option>
				<option value="2009" <% if ("2009".equals(gubun)) { %>selected<% } %>>2009</option>
				<option value="2008" <% if ("2008".equals(gubun)) { %>selected<% } %>>2008</option>
				<option value="2007" <% if ("2007".equals(gubun)) { %>selected<% } %>>2007</option>
				<option value="2006" <% if ("2006".equals(gubun)) { %>selected<% } %>>2006</option>
				<option value="2005" <% if ("2005".equals(gubun)) { %>selected<% } %>>2005</option> --%>
			</select>
			<a href="javascript:gubunChange();" class="submitBtn">확인</a>
			<ul id="poster" class="listPic event">
<%
				Vector ResultVector = FrontBoard.list(TableName, SelectCondition, WhereCondition, OrderCondition, PAGE, 0, DefaultListRecord);

				Hashtable h = null;
				String[] sh_filename = new String[12];
				String[] source = new String[12];
				String[] sh_title = new String[12];
				String[] sh_alt_title = new String[12];
				
				int size = ResultVector.size();

				if( size > 0){
					for (int i=0; i < size; i++){


						try{
							h = (Hashtable)ResultVector.elementAt(i);

							sh_filename[i] = (String)h.get("SH_FILENAME");
							source[i] = "/upload/poster/" + sh_filename[i];
							sh_title[i] = (String)h.get("SH_TITLE");
							sh_alt_title[i] = (String)h.get("SH_ALT_TITLE");	//sh_alt_title 알트값
							System.out.println("sh_alt_title -- >>" + sh_alt_title[i]);
			
%>
				<li class="h415">
					<a href="javascript:layerPopup('<%=source[i]%>','<%=sh_alt_title[i]%>');">
						<span class="boxNail h340"><img src="<%=source[i]%>" alt="<%=sh_alt_title[i]%>" /></span>
						<span class="sTitle">
							<%=sh_title[i]%>
						</span>
					</a>
				</li>

<%
						}catch(Exception e){

						}
					}
				}
				else {
%>
				<li>등록 자료가 없습니다.</li>
<% 
				}
%>
			</ul>
			<div class="paging mgt">
			<% if(TotalRecordCount > 0) { %>
				<%=FrontDbUtil.PrintPage(Integer.toString(PAGE), TotalRecordCount, DefaultListRecord, DefaultPageBlock, myPage+"?gubun="+gubun+"&PAGE=","<img src=\"/pub_img/btn_pre02.gif\" alt=\"처음 페이지로\" />","<img src=\"/pub_img/btn_pre.gif\" alt=\"이전 페이지로\" />","<img src=\"/pub_img/btn_next.gif\" alt=\"다음 페이지로\" />","<img src=\"/pub_img/btn_next02.gif\" alt=\"끝 페이지로\" />")%>
			<% } %>
			</div>
</form>

		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<!-- footer -->
	<%@ include file="/include/shFooter.jsp" %>
	<!-- //footer -->
	<div class="popup">
		<img class="poster_img" src="" alt="선택된 이미지가 없습니다." />
		<a class="x_btn" href="javascript:layerClose();"><img src="/images/button/x_btn.png" alt="닫기버튼" /></a>
	</div>
</body>
</html>