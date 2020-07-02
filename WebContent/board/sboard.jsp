<%@page import="org.eclipse.jdt.internal.compiler.ast.IfStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--
   Editorial by HTML5 UP
   html5up.net | @ajlkn
   Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
<meta charset="utf-8" />
<title>자유게시판</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />


<link rel="stylesheet" href="/Project/assets/css/main.css" />
<link rel="stylesheet" href="/Project/css/w3.css" />
<link rel="stylesheet" href="/Project/css/board.css" />
<script type="text/javascript" src="/Project/js/jquery-3.5.0.min.js"></script>
<script type="text/javascript" src="/Project/js/board.js"></script>
<script type="text/javascript" src="/Project/js/login.js"></script>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		$('.spgbt').click(function() {
			var str = $(this).html();
			if (str == 'PRE') {
				$('#nowPage').val('${PAGE.startPage - 1}');
			} else if (str == 'NEXT') {
				$('#nowPage').val('${PAGE.endPage +1}');
			} else {
				return;
			}
			$('#frm').attr('action', '/Project/board/search.cls');
			$('#frm').submit();
		});
		$('.content').hover(function() {
			$(this).css("color", "brown")
			$(this).css("font-weight", "bold")

		}, function() {
			$(this).css("color", "gray");
			$(this).css("font-weight", "")
		});
	});
</script>

<body class="is-preload">


	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Main -->
		<div id="main">
			<div class="inner">


				<!-- Header -->
				<header id="header">
					<a href="/Project/main.cls" class="logo"><strong>Main
							page</strong></a>
					<ul class="icons">
						<c:if test="${empty SID}">
							<li class="btn w3-button" id="login"><b><span>SIGN
										IN</span></b></li>
						</c:if>
						<c:if test="${not empty SID}">

							<li class="btn" id="logout"><b><span>SIGN OUT</span></b></li>
						</c:if>

					</ul>
				</header>
				<form method="post" action="" id="frm">
					<input type="hidden" name="nowPage" id="nowPage"
						value="${param.nowPage}"> <input type="hidden" name="bno"
						id="bno"> <input type="hidden" name="condition"
						id="condition" value="${COND}"> <input type="hidden"
						name="input" id="input" value="${INPU}">
				</form>
				<form method="post" action="" id="frm">
					<input type="hidden" name="bno" id="bno">
				</form>
				<form method="post" action="" id="tfrm">
					<input type="hidden" name="tab" id="tab">
				</form>

				<div>
					<br>
					<div id="topForm">
						<div class="w3-center w3-text-green ftt">자유게시판</div>
						<c:if test="${sessionScope.sessionID!=null}">
						</c:if>

					</div>
					<br> <input class="bdh" type="button" id="전체" value="전체">
					<div id="board">
						<table id="bList">
							<thred>
							<tr heigh="30">
								<td>글번호</td>
								<td>종류</td>
								<td>제목</td>
								<td>작성자</td>
								<td>작성일</td>
								<td>조회수</td>
							</tr>
							</thred>
							<c:forEach var="data" items="${LIST}">
								<tr class="content" id="${data.bdno}">
									<td>${data.bdno}</td>
									<td>${data.bdct}</td>
									<td>${data.bdtt}</td>
									<td>${data.name}</td>
									<td>${data.sdate}</td>
									<td>${data.vcnt}</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<div class="w3-center">
						<div class="w3-bar w3-border">
							<c:if test="${PAGE.startPage lt (PAGE.pageGroup + 1) }">
								<span class="w3-bar-item w3-light-gray">PRE</span>
							</c:if>
							<c:if test="${PAGE.startPage ge (PAGE.pageGroup + 1) }">
								<span class="w3-bar-item spgbt w3-button w3-hover-blue spbtn">PRE</span>
							</c:if>
							<c:forEach var="pageNo" begin="${PAGE.startPage}"
								end="${PAGE.endPage}">
								<span
									class="w3-bar-item spgbt w3-border-left w3-button w3-hover-blue spbtn">${pageNo}</span>
							</c:forEach>
							<c:if test="${PAGE.endPage ne PAGE.totalPage}">
								<span
									class="w3-bar-item spgbt w3-border-left w3-button w3-hover-blue spbtn">NEXT</span>
							</c:if>
							<c:if test="${PAGE.endPage eq PAGE.totalPage}">
								<span class="w3-bar-item  w3-border-left w3-light-gray ">NEXT</span>
							</c:if>
						</div>
					</div>
					<div class="w3-center" id="searchForm">

						<form method="post" action="" id="search">
							<select name="condition" style="margin: 10px;">
								<option value="bdtt">제목</option>
								<option value="bdbd">내용</option>
								<option value="name">글쓴이</option>
							</select> <input type="text" size="20" name="input" style="margin: 10px;" /><input
								id="serbtn" type="submit" value="search" style="margin: 10px;" />
						</form>
						<c:if test="${sessionScope.sessionID!=null}">
						</c:if>

					</div>
				</div>
			</div>
		</div>

		<!-- Sidebar -->
		<div id="sidebar">
			<div class="inner">
				<!-- 
							<!-- Main link -->

				<!-- Menu -->
				<nav id="menu">
					<header class="major">
						<a href="/Project/main.cls" width="0px;" height="0px;"> <img
							class="ima_1" src="/Project/images/main.png" border="0" />
							<h2>Menu</h2>
					</header>
					<ul>
						<li><a class="opener" href="/Project/info/infoCT.cls">오세용</a>

						</li>
						<li><a href="/Project/sales/sales.cls">팝니당</a></li>
						<li><a href="/Project/review/review.cls">리뷰당?</a></li>
						<li><a href="/Project/board/board.cls">놀러왕!</a></li>
						<li><a href="/Project/qna/qnaList.cls">물어봥?</a></li>
						<!--
										<li>
											 <span class="opener">Another Submenu</span>
											<ul>
												<li><a href="#">Lorem Dolor</a></li>
												<li><a href="#">Ipsum Adipiscing</a></li>
												<li><a href="#">Tempus Magna</a></li>
												<li><a href="#">Feugiat Veroeros</a></li>
											</ul>
										</li>
										<li><a href="#">Maximus Erat</a></li>
										<li><a href="#">Sapien Mauris</a></li>
										<li><a href="#">Amet Lacinia</a></li>
									</ul> -->
					</ul>
				</nav>


			</div>
		</div>

	</div>
</body>
</html>