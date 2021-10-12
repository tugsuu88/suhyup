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
	<title>���������� &gt; ��ȸ���� &gt; �������� &gt; ����</title><!-- 20150216 -->
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
			<p class="indicate"><span class="shHome">����</span><span>��������</span><span>��ȸ����</span>����������</p>
			<h3>����������</h3>	
			<div class="open_nanum">
				<div class="nanum_top">
					<dl class="nm_dl">
						<dt class="nm_dt">������ ���ϸ� �������� �ູ ����ȸ</dt>
						<dd class="nm_dd">������ 2005�⵵���� ���� ���� ���� ���������� ���� ������ ��ȸ����Ȱ�� � ����
						���� ���ø� ���Ͽ� �����濵�� ������ Ȯ�� �� �������⸦ �ο��ϰ� �ֽ��ϴ�.
						2007�� 12������ �����濵 ������ǰ 28���� �����߾�ȸ ����1�� �����Ա��� 2�� ����
						�Ա����� �����濵 Ȱ����������ȸ�� �����Ͽ�����, �¶��λ��� �����Խ��ǿ��� �Խ���
						�� ���Ÿ� �������� �ٹ��ϴ� �����鵵 ������ �� �ֵ��� �Ͽ����ϴ�.</dd>
					</dl>
				</div>
			</div>					

<form name="pbform" method="post" action="nanum.jsp">
			<label for="FIELD" class="tts">���������� �⵵�� ����</label>
			<select name="gubun" id="FIELD" title="���Ǽ���" class="w128 mgb25">
				 <%
				  for(int yyyy=strYear; yyyy>=2005; yyyy--){
				   
				 %>
				   <option value="<%=yyyy%>" <% if (Integer.toString(yyyy).equals(gubun)) { %>selected<% } %>><%=yyyy%>��</option>
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
			<a href="javascript:gubunChange();" class="submitBtn">Ȯ��</a>
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
							sh_alt_title[i] = (String)h.get("SH_ALT_TITLE");	//sh_alt_title ��Ʈ��
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
				<li>��� �ڷᰡ �����ϴ�.</li>
<% 
				}
%>
			</ul>
			<div class="paging mgt">
			<% if(TotalRecordCount > 0) { %>
				<%=FrontDbUtil.PrintPage(Integer.toString(PAGE), TotalRecordCount, DefaultListRecord, DefaultPageBlock, myPage+"?gubun="+gubun+"&PAGE=","<img src=\"/pub_img/btn_pre02.gif\" alt=\"ó�� ��������\" />","<img src=\"/pub_img/btn_pre.gif\" alt=\"���� ��������\" />","<img src=\"/pub_img/btn_next.gif\" alt=\"���� ��������\" />","<img src=\"/pub_img/btn_next02.gif\" alt=\"�� ��������\" />")%>
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
		<img class="poster_img" src="" alt="���õ� �̹����� �����ϴ�." />
		<a class="x_btn" href="javascript:layerClose();"><img src="/images/button/x_btn.png" alt="�ݱ��ư" /></a>
	</div>
</body>
</html>