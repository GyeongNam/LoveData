<%@ page import="org.springframework.security.core.annotation.AuthenticationPrincipal" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page session="false" %>
<jsp:useBean id="defaultDateTimeFormatter" class="com.project.love_data.util.DefaultLocalDateTimeFormatter"></jsp:useBean>
<jsp:useBean id="simpleDateTimeFormatter" class="com.project.love_data.util.SimpleLocalDateTimeFormatter"></jsp:useBean>
<html>
<head>
	<style>
		@import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');

		body {
			font-family: 'Jua', sans-serif;
		}
	</style>
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
<%--<form class="mypageform" action="/user/mypage" method="post">--%>
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
				<p>
					<a href="/mypage_myreview/1" >나의 리뷰</a>
				</p>
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
		</div>
	</div>
	<div id="jb-content">
		<div id="LikeList" class="tabcontent">
			<h3>찜 목록</h3>
			<table>
				<thead>
				<tr>
					<th>등록 날짜</th>
					<th>제목</th>
					<th>조회수</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="mCorlike" items="${my_Corlike}" >
				<c:choose>
				<c:when test="${mCorlike._deleted eq false}">
				<tbody>
				<tr>
					<td><span>${mCorlike.regDate.format(simpleDateTimeFormatter.dateTimeFormatter)}</span></td>
					<td><a href="/service/cor_detail?corNo=${mCorlike.cor_no}">${mCorlike.cor_name}</a></td>
					<td>${mCorlike.viewCount}</td>
				</tr>
				</c:when>
				</c:choose>
				</c:forEach>
				</tbody>
			</table>
			<div class="col" id="pu_navbar">
				<div class="container d-flex" id="">
					<div class="col" id="page_number">
						<nav aria-label="Page navigation example">
							<input id="qu_pages" value="${qu_page_size}" type="hidden">
							<input id="qu_pagess" value="${qu_page}" type="hidden">
							<div class="pagination justify-content-center" , id="pagination justify-content-center">
								<p onclick="subpage()"> < </p>
								<c:forEach var="qu_pages" begin="1" end="${qu_page}" step="1">
									<div class="page-item" id="${qu_pages}">
										<li class="page-item ${qu_pages}">
											<a href="/mypage_myCorlike/${qu_pages}">${qu_pages}</a>
										</li>
									</div>
								</c:forEach>
								<p onclick="plupage()"> > </p>
							</div>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</sec:authorize>
<%--</form>--%>
</body>
<!--   부트스트랩 js 사용  -->
<script defer src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script defer type="text/javascript" src="/resource/js/bootstrap.js"></script>
<script defer src="/js/ServiceCenter.js"></script>
<script defer src="/js/mypage.js"></script>
</html>