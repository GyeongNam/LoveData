<%@ page import="org.springframework.security.core.annotation.AuthenticationPrincipal" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page session="false" %>

<html>
<head>
	<meta name="_csrf" content="${_csrf.token}">
	<meta name="_csrf_header" content="${_csrf.headerName}">
    <link href="/css/mypage.css" rel="stylesheet">
    <title>Home</title>
</head>
<%@ include file="../layout/header.jsp"%>
<body>
	<sec:authorize access="isAnonymous()">
		잘못된 방식으로 접근하였습니다. 로그인 후 다시 시도하여주세요!
		<button id="hd-btn" onclick="location.href='/login'">로그인</button>
		<button id="hd-btn" class="dropbtn" onclick="gohome()">홈으로 돌아가기</button>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
<div id="jb-container">
	<div id="jb-header">
		<h1>마이페이지</h1>
	</div>
	<div id="jb-sidebar">
		<div class="tab">
			<div>
				<p>
					<a href="/mypage" >내 정보</a>
				</p>
			</div>
			<div>
				<button class="accordion">나의댓글/리뷰</button>
				<div class="panel">
					<p>
						<a href="/mypage_mycomment/1" >나의 댓글</a>
					</p>
					<p>
						<a href="/mypage_myreview/1" >나의 리뷰</a>
					</p>
				</div>
			</div>
			<div>
				<div>
					<button class="accordion">나의코스/장소</button>
					<div class="panel">
						<p>
							<a href="/mypage_mycorse/1" >나의 코스</a>
						</p>
						<p>
							<a href="/mypage_myplace/1" >나의 장소</a>
						</p>
					</div>
				</div>
			</div>
			<div>
				<div>
					<button class="accordion">나의 찜 목록</button>
					<div class="panel">
						<p>
							<a href="/mypage_mylike/1" >내가 찜한 장소</a>
						</p>
						<p>
							<a href="/mypage_myCorlike/1" >내가 찜한 코스</a>
						</p>
					</div>
				</div>
			</div>
			<div>
				<button class="accordion">최근 본 장소/코스</button>
				<div class="panel">
					<p>
						<a href="/mypage_recent_view_location" >최근 본 장소</a>
					</p>
					<p>
						<a href="/mypage_recent_view_corse" >최근 본 코스</a>
					</p>
				</div>
			</div>
			<div>
				<p>
					<a href="/biz_reg" >사업자 등록</a>
				</p>
			</div>
		</div>
	</div>
	<div id="jb-content">
		<form action="/biz_reg/update" method="post" enctype="multipart/form-data">
			<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
			<div id="Myinfo" class="tabcontent">
				<h3>사업자 등록 정보</h3>
				<table>
					<tr>
						<th>사업자 등록 정보 수정</th>
					</tr>
					<tr>
						<td>이름</td>
						<td id="sec_line">
							<span>${UserDTO.user_name}</span>
						</td>
					</tr>
					<tr>
						<td>사업체 이름</td>
						<td id="sec_line">
							<input type="text" id="biz_name" name="biz_name" value="${bizRegDTO.bizName}">
						</td>
					</tr>
					<tr>
						<td>대표자 이름</td>
						<td id="sec_line">
							<input type="text" id="biz_ceo_name" name="biz_ceo_name" value="${bizRegDTO.bizCeoName}">
						</td>
					</tr>
					<tr>
						<td>연락처</td>
						<td id="sec_line">
							<input type="hidden" id="numnum" value="${bizRegDTO.bizCall}">
							<select name="first-phone-number" id="firnum" >
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="017">017</option>
								<option value="018">018</option>
							</select>
							-
							<input type="text" id="twonum" name="second_num"
								   oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
								   maxlength="4"/>
							-
							<input type="text" id="lastnum" name="third_num"
								   oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
								   maxlength="4"/>
						</td>
					</tr>
					<tr>
						<td>사업자 등록증 사진</td>
						<td id="sec_line">
							<div class="file-wrapper flie-wrapper-area">
								<div class="float-left">
								<span class="label-plus"><i class="fas fa-plus"></i>
								</span>
									<div id="preview">
										<img id="propic" src="${bizRegDTO.url}">
									</div>
									<div class="file-edit-icon">
										<input type="file" name="file" id="file" class="upload-box upload-plus" accept="image/*" onchange="setmyimg(event);"/>
										<button id="img-del" type="button" class="preview-de" onclick="picdel()">삭제</button>
									</div>
								</div>
							</div>
						</td>
					</tr>
				</table>
				<button type="submit">저장</button>
			</div>
		</form>
	</div>
	</sec:authorize>
	</div>
</body>
<!--   부트스트랩 js 사용  -->
<script defer src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script defer type="text/javascript" src="/resource/js/bootstrap.js"></script>
<script defer src="/js/mypage.js"></script>
<script>
	function setmyimg(event) {
		for (var image of event.target.files) {
			var reader = new FileReader();
			reader.onload = function(event) {
				var img = $("#propic");
				img.setAttribute("src", event.target.result);
			};
			reader.readAsDataURL(image);
		}
	}
</script>
</html>