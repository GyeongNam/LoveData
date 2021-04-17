<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<html>
<head>
<link href="/css/CSSTEST.css" rel="stylesheet">
<title>회원정보 찾기 | LOVE DATA</title>
</head>

<body>
<div>
<%@ include file="../layout/header.jsp"%>
	<div class="container">
		<div class="guardrail">
			<div class="container pd-v-1u">
				<div class="container find-id-pw">
					<!-- 아이디 찾기 -->
					<div class="container pd-v-1u find-id">
						<h2 class="pd-v-5 txt-navy">아이디/비밀번호 찾기</h2>
						<h6 class=" pd-v-5 txt-888">회원 정보를 찾기 위해 다음 사항을 입력하세요.</h6>

						<div class="card no-padding no-top-corner mg-t-20">
							<div class="tab-item">
								<!-- 아이디 찾기 -->
								<input id="tab1_1" type="radio" name="temp1" checked> <label
									for="tab1_1" class="tab-btn"><div class="bg bg-yellow"></div>
									<span class="caption txt-16">아이디</span>
									<div class="ripple dark"></div></label>

								<!-- 비밀번호 찾기 -->
								<input id="tab1_2" type="radio" name="temp1"> <label
									for="tab1_2" class="tab-btn"><div class="bg bg-yellow"></div>
									<span class="caption txt-16">비밀번호</span>
									<div class="ripple dark"></div></label>

								<!-- 아이디 찾기 -->
								<div class="card no-shadow tab-cont">
									<ul class="full-list">
										<li class="pd-v-5">
										<select class="selectbox" name="select-box" onChange="selectEmail(this)">
												<option value="empty" selected>선택하세요</option>
												<option value="naver.com">010</option>
												<option value="gmail.com">011</option>
												<option value="hanmail.com">018</option>
										</select>
										<input name="email1" type="text">
										<input name="email2" type="text">
											<button type="button" id=""
												class="btn btn-grass" onclick="sendFindId()">
												<span class="caption">인증번호전송</span>
												<div class="ripple"></div>
											</button></li>
											<li class="pd-v-5">
										<input type="number" id="authnumber" name="authnumber"
													placeholder="인증번호">
											<button type="button" id=""
													class="btn btn-grass" >
													<span class="caption">인증번호 확인</span>
													<div class="ripple"></div>
												</button>
											</li>
										<li class="pd-v-5"><hr class="solid"></li>
										<li class="pd-v-10 txt-center">
											<button type="button"
												class="btn btn-l hidden-icon right btn-yellow" onclick="">
												<div class="bg"></div>
												<span class="caption">아이디 찾기</span><i class="material-icons">search</i>
												<div class="ripple"></div>
											</button>
										</li>
									</ul>
								</div>

								<!-- 비밀번호 찾기 콘텐츠 -->

								<div class="card no-shadow tab-cont">
									<ul class="full-list">
										<li class="pd-v-5">
											<form action="/mail" method="post">
												<sec:csrfInput />
											<input type="text" name="address" id="email1" required="required"> @
											<input type="text" name="domain" id="email2" placeholder="">
											<select name="select_email" class="selectbox"
											required>
												<option value="" selected>선택하세요</option>
												<option value="naver.com">naver.com</option>
												<option value="hanmail.net">hanmail.net</option>
												<option value="hotmail.com">hotmail.com</option>
												<option value="nate.com">nate.com</option>
												<option value="yahoo.co.kr">yahoo.co.kr</option>
												<option value="empas.com">empas.com</option>
												<option value="dreamwiz.com">dreamwiz.com</option>
												<option value="freechal.com">freechal.com</option>
												<option value="lycos.co.kr">lycos.co.kr</option>
												<option value="korea.com">korea.com</option>
												<option value="gmail.com">gmail.com</option>
												<option value="hanmir.com">hanmir.com</option>
												<option value="paran.com">paran.com</option>
												<option value="1">직접입력</option>
											</select>
											<button type="submit" id="sendMail" class="btn btn-grass">
												<span class="caption">인증번호전송</span>
												<div class="ripple"></div>
											</button>
											</form>
										</li>
										<li class="pd-v-5">
										<input type="number" id="authnumber" name="authnumber"
													placeholder="인증번호">
											<button type="button" id="mobilenumberauthbutton" class="btn btn-grass" >
													<span class="caption">인증번호 확인</span>
													<div class="ripple"></div>
												</button>
											</li>
										<li class="pd-v-5"><hr class="solid"></li>
										<li class="pd-v-10 txt-center">
											<button type="button"
												class="btn btn-l hidden-icon right btn-yellow" onclick="">
												<div class="bg"></div>
												<span class="caption">비밀번호 찾기</span><i
													class="material-icons">search</i>
												<div class="ripple"></div>
											</button>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../layout/footer.jsp"%>
</div>
</body>
</html>
<script src="/js/find-info.js"></script>
