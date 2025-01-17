<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="false" %>
<html><jsp:useBean id="defaultDateTimeFormatter" class="com.project.love_data.util.DefaultLocalDateTimeFormatter"></jsp:useBean>
<jsp:useBean id="simpleDateTimeFormatter" class="com.project.love_data.util.SimpleLocalDateTimeFormatter"></jsp:useBean>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="_csrf" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/service/loc.css">
    <link rel="stylesheet" href="/css/ServiceCenter.css" >
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Jua&display=swap');

        body {
            font-family: 'Jua', sans-serif;
        }
    </style>
    <title>Admin QnA</title>
</head>
<%@ include file="../layout/header.jsp" %>
<body class="bg-light">
<div class="container-fluid d-flex" style="padding-top: 100px">
    <div class="col-2" id="sidebar">
        <ul class="nav nav-pills flex-column col-2 position-fixed" style="top: 40%">
            <div class="accordion text-center" id="loc">
                <hr>
                <div class="card">
                    <div class="card-header" id="headingLoc">
                        <h2 class="mb-0">
                            <button class="btn btn-link btn-block loc_highlight-selected-nav-menu" type="button"
                                    data-toggle="collapse"
                                    data-target="#loc_collapse" aria-expanded="true" aria-controls="collapseOne">
                                어드민
                            </button>
                        </h2>
                    </div>
                    <div id="loc_collapse" class="collapse show" aria-labelledby="headingLoc" data-parent="#loc">
                        <div class="card-body center-pill">
                            <p><a href="/admin/dash" class="highlight-not-selected-text-menu">대시보드</a></p>
                            <p><a href="/admin/user/1" class="highlight-not-selected-text-menu">유저 관리</a></p>
                            <p><a href="/admin/buisnessman" class="highlight-not-selected-text-menu">사업자 관리</a></p>
                            <p><a href="/admin/event" class="highlight-not-selected-text-menu">이벤트 관리</a></p>
                            <p><a href="/admin/SendMessage" class="highlight-not-selected-text-menu">메시지 발송</a></p>
                            <p><a type="button" class="accordion highlight-selected-text-menu" data-toggle="collapse" data-target="#service_collapse" aria-expanded="false">공지사항과 문의사항</a></p>
                            <div id="service_collapse" class="collapse show" >
                                <p>
                                    <a href="/admin/notice/1" class="highlight-not-selected-text-menu">- 공지사항</a>
                                </p>
                                <p>
                                    <a href="/admin/qna/1" class="highlight-selected-text-menu">- 문의사항</a>
                                </p>
                            </div>
                            <p><a href="/admin/upload_cache" class="highlight-not-selected-text-menu">upload 파일 캐시 삭제</a></p>
                            <p class="mb-0"><a href="/admin/report_center" class="highlight-not-selected-text-menu">신고 센터</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </ul>
    </div>
    <div class="container-xl p-5 ms-3">
        <div class="row justify-content-md-start">
            <div class="tab-content" id="pills-tabContent">
                <div class="tab-pane fade show active" id="recent-post" role="tabpanel" aria-labelledby="recent-post-tab">
                    <c:choose>
                    <c:when test="${qu_size>0}">
                    <table id="tbody">
                        <thead>
                        <tr>
                            <th>번호</th><th>제목</th><th>작성자</th><th>작성일</th><th>상태</th>
                        </tr>
                        </thead>
                        <tbody id="Qtbody" >

                        <c:forEach var="qu" items="${qu}">
                            <tr>
                                <td>${qu.qu_no}</td>
                                <c:choose>
                                    <c:when test="${qu.qu_secret eq true}">
                                        <sec:authorize access="isAuthenticated()">
                                            <sec:authorize access="hasAnyRole('ADMIN')">
                                                <td onclick=location.href='/admin/Questions_Post_mana/${qu.qu_no}';>${qu.qu_title} <img src="/image/icon/user/secret.png" class="img_s" id="imgDisplay" name="imgDisplay" ></td>
                                            </sec:authorize>
                                            <sec:authorize access="!hasRole('ADMIN')">
                                                <td onclick=location.href='/admin/Questions_Post/${qu.qu_no}';>${qu.qu_title} <img src="/image/icon/user/secret.png" class="img_s"  id="imgDisplay" name="imgDisplay" ></td>
                                            </sec:authorize>
                                        </sec:authorize>
                                        <sec:authorize access="isAnonymous()">
                                            <td onclick=location.href='/admin/Questions_Post/${qu.qu_no}';>${qu.qu_title} <img src="/image/icon/user/secret.png" class="img_s"  id="imgDisplay" name="imgDisplay" ></td>
                                        </sec:authorize>
                                    </c:when>
                                    <c:when test="${qu.qu_secret eq false}">
                                        <td onclick=location.href='/admin/Questions_Post/${qu.qu_no}';>${qu.qu_title}</td>
                                    </c:when>
                                </c:choose>
                                <td>${qu.qu_user}</td>
                                <c:set var="tel" value="${fn:split(qu.qu_date,' ')}" />
                                <c:choose>
                                    <c:when test="${tel[0] == qu_time}">
                                        <td>${tel[1]}</td>
                                    </c:when>
                                    <c:when test="${tel[0] != qu_time}">
                                        <td>${tel[0]}</td>
                                    </c:when>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${qu.qu_answer eq true}">
                                        <td>답변완료</td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>답변중</td>
                                    </c:otherwise>
                                </c:choose>
                            </tr>
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
                                        <c:choose>
                                            <c:when test="${search eq false}">
                                                <c:forEach var="qu_pages" begin="1" end="${qu_page}" step="1">
                                                    <div class="page-item" id="${qu_pages}">
                                                        <li class="page-item ${qu_pages}">
                                                            <a href="/admin/qna/${qu_pages}">${qu_pages}</a>
                                                        </li>
                                                    </div>
                                                </c:forEach>
                                            </c:when>
                                            <c:when test="${search eq true}">
                                                <c:forEach var="qu_pages" begin="1" end="${qu_page}" step="1">
                                                    <div class="page-item" id="${qu_pages}">
                                                        <li class="page-item ${qu_pages}">
                                                            <a href="/ServiceCenter/Questions/search/${menu}/${text}/${qu_pages}">${qu_pages}</a>
                                                        </li>
                                                    </div>
                                                </c:forEach>
                                            </c:when>
                                        </c:choose>
                                        <p onclick="plupage()"> > </p>
                                    </div>
                                </nav>
                            </div>
                        </div>
                        </c:when>
                        <c:when test="${qu_size==0}">

                            글이 존재하지 않습니다.

                        </c:when>
                        </c:choose>

                    </div>
                </div>
                <div class="tab-pane fade" id="hot-post" role="tabpanel" aria-labelledby="hot-post-tab">
                    <span>test hot-post-tab</span>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<!--  부트스트랩 js 사용 -->

<script defer src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script defer type="text/javascript" src="/resource/js/bootstrap.js"></script>
<script defer src="/js/ServiceCenter.js"></script>
<script defer src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns"
        crossorigin="anonymous"></script>

</html>
