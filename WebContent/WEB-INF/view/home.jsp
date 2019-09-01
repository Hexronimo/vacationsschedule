<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>Vacations Schedule - Main page</title>
    <meta name="description" content=""/>
    <meta name="viewport" content="width=device-width"/>
    <base href="/"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap/css/bootstrap.min.css" />" /> 
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/all.min.css" />" /> 
    <script type="text/javascript" src="<c:url value="/resources/jquery-3.4.1.min.js" />" ></script>  
    <script type="text/javascript" src="<c:url value="/resources/bootstrap/js/bootstrap.min.js" />" ></script>
</head>
<style>
body {
	background: url("<c:url value="/resources/img/toimetaja-tolkeburoo-v0Gnw01m8Zw-unsplash.jpg" />") no-repeat bottom center;
	background-size: cover;
}
</style>
<body>
	<div class="container-fluid p-0 pb-5 w-100"
		style="background-color: rgba(255, 253, 240, 0.78); min-height: 100vh;">

		<div class="container-fluid bg-primary text-white p-4"
			style="min-height: 75px;">
			<div class="container">
				<div class="d-inline-block h5 font-weight-bold pt-1 pb-1 pr-5">
					<a href="<c:url value="/" />" class="text-white"><i
						class="fas fa-home"></i></a>
				</div>
				<div class="d-inline-block h5 font-weight-bold pt-1 pb-1 pr-5">
					<a href="<c:url value="/listEmployees" />" class="text-white"><i
						class="fas fa-list-ul"></i> List Of Employees</a>
				</div>
				<div class="d-inline-block h5 font-weight-bold pt-1 pb-1 pr-5">
					<a href="<c:url value="/addEmployee" />" class="text-white"><i
						class="fas fa-user-plus"></i> Add New Employee</a>
				</div>
				<div class="d-inline-block h5 font-weight-bold pt-1 pb-1 pr-5">
					<a href="<c:url value="/about" />" class="text-white">About</a>
				</div>
			</div>
		</div>

		<div class="container mt-5">
			<c:if test="${not empty ifError}">
				<div class="p-3 mb-2 bg-danger">${ifError}</div>
			</c:if>
			<h1 class="display-4 font-weight-bold">Vacation Schedule</h1>


			<h4 class="font-weight-bold mt-5">
				<i class="fas fa-list-ul"></i> <a
					href="<c:url value="/listEmployees" />">Go to the list of
					employees</a>
			</h4>
			<h4 class="font-weight-bold mt-5">Today is ${today}</h4>
			<h4 class="font-weight-bold mt-4">Don't forget about Birthdays</h4>
			<c:if test="${not empty birthdays}">
				<c:forEach items="${birthdays}" var="b">
					<div class="media">
						<i class="far fa-circle h4 mt-3 text-primary mr-3"></i>
						<div class="media-body">
							<h5 class="mt-0">
								<c:out value="${b.position.position}" />
								<c:out value="${b.shortName}" />
							</h5>
							<c:out value="${b.birthdayAsStringWord}" />
						</div>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${empty birthdays}">none</c:if>
			<h4 class="font-weight-bold mt-4">Soon on vacation</h4>
			<c:if test="${empty vacations}">none</c:if>
			<c:if test="${not empty vacations}">
				<c:forEach items="${vacations}" var="v">


					<div class="media">
						<i class="far fa-circle h4 mt-3 text-primary mr-3"></i>
						<div class="media-body">
							<h5 class="mt-0">
								<c:out value="${v.value}" />
							</h5>
							<c:out value="${v.key}" />

						</div>
					</div>
				</c:forEach>
			</c:if>

		</div>
	</div>
	<div class="fixed-bottom container-fluid text-right">
	<!-- Unsplash photo stock link with credits-->
		<a
			style="background-color: black; color: white; text-decoration: none; padding: 4px 6px; font-family: -apple-system, BlinkMacSystemFont,&amp; amp; quot; San Francisco&amp;amp; quot; , &amp; amp; quot; Helvetica Neue&amp;amp; quot; , Helvetica , Ubuntu, Roboto, Noto, &amp;amp; quot; Segoe UI&amp;amp; quot; , Arial , sans-serif; font-size: 12px; font-weight: bold; line-height: 1.2; display: inline-block; border-radius: 3px"
			href="https://unsplash.com/@toimetaja?utm_medium=referral&amp;utm_campaign=photographer-credit&amp;utm_content=creditBadge"
			target="_blank" rel="noopener noreferrer"
			title="Download free do whatever you want high-resolution photos from Toimetaja tõlkebüroo">Photo
			by <span style="display: inline-block; padding: 2px 3px"><svg
					xmlns="http://www.w3.org/2000/svg"
					style="height: 12px; width: auto; position: relative; vertical-align: middle; top: -2px; fill: white"
					viewBox="0 0 32 32">
					<title>unsplash-logo</title><path
						d="M10 9V0h12v9H10zm12 5h10v18H0V14h10v9h12v-9z"></path></svg></span><span
			style="display: inline-block; padding: 2px 3px">Toimetaja
				tõlkebüroo</span>
		</a>
	</div>
</body>
</html>