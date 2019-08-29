<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Employee submitted</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width" />
<base href="/" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/bootstrap/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/all.min.css" />" />
<script type="text/javascript"
	src="<c:url value="/resources/jquery-3.4.1.min.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/bootstrap/js/bootstrap.min.js" />"></script>
</head>
<body>
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

	<div class="container mb-5 mt-5">
		<c:choose>
			<c:when test="${submitted eq true}">
				<div class="p-3 mb-2 text-white ${annatationColor}">${ifError}</div>
				<h5 class="font-weight-bold mt-5">What to do next?</h5>
				<div class="list-group mt-1">
					<a href="<c:url value="/addEmployee" />"
						class="list-group-item list-group-item-action">Add another
						employee</a> <a href="#"
						class="list-group-item list-group-item-action">Edit data on
						${employeeName}</a> <a href="<c:url value="/listEmployees" />"
						class="list-group-item list-group-item-action">Go to the list
						of employees</a>
				</div>
			</c:when>
			<c:otherwise>
				<h5 class="font-weight-bold mt-5">It seems like you get here
					from the wrong page</h5>
				<div class="list-group mt-1">
					<a href="<c:url value="/listEmployees" />"
						class="list-group-item list-group-item-action">Go to the list
						of employees</a>
				</div>
			</c:otherwise>
		</c:choose>

	</div>
</body>
</html>