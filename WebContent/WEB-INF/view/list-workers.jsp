<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>List of employees</title>
    <meta name="description" content=""/>
    <meta name="viewport" content="width=device-width"/>
    <base href="/"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap/css/bootstrap.min.css" />" /> 
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/all.min.css" />" /> 
    <script type="text/javascript" src="<c:url value="/resources/jquery-3.4.1.min.js" />" ></script>  
    <script type="text/javascript" src="<c:url value="/resources/bootstrap/js/bootstrap.min.js" />" ></script>
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
	<div class="container mt-5 mb-5">
		<c:if test="${not empty ifError}">
			<div class="p-3 mb-2 text-white bg-danger">${ifError}</div>
		</c:if>
		<h5 class="font-weight-bold mt-5">Employees</h5>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th scope="col" class="align-middle text-center">Edit</th>
					<th scope="col" class="align-middle text-center">Delete</th>
					<th scope="col" class="align-middle text-center">Employee</th>
					<th scope="col" class="align-middle text-center">Position</th>
					<th scope="col" class="align-middle text-center">Edit
						vacations</th>
					<th scope="col" class="align-middle text-center">Closest
						vacation date</th>
					<th scope="col" class="align-middle text-center">Last data
						update</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${employees}" var="employee">
					<tr>
						<td class="text-center" style="width: 74px;">
							<form action="<c:url value="/addEmployee"/>" method="POST">
								<input type="hidden" name="id" value="${employee.id}" />
								<button type="submit" class="btn btn-outline-secondary btn-sm">
									<i class="fas fa-pencil-alt"></i>
								</button>
							</form>
						</td>
						<td class="text-center" style="width: 74px;">
							<form action="<c:url value="/deleteEmployee"/>" method="POST">
								<input type="hidden" name="id" value="${employee.id}" />
								<button type="submit" class="btn btn-outline-secondary btn-sm"
									style="width: 32px;">
									<i class="fas fa-times"></i>
								</button>
							</form>
						</td>
						<td class="text-nowrap"><c:out value="${employee.fullName}" /></td>
						<td><c:out value="${employee.position.position}" /></td>
						<td class="text-center"><form
								action="<c:url value="/editVacations"/>" method="POST">
								<input type="hidden" name="id" value="${employee.id}" />
								<button type="submit" class="btn btn-outline-secondary btn-sm">
									<i class="far fa-calendar-alt"></i>
								</button>
							</form></td>
						<td><c:out value="${employee.closestVacation}" /> <c:if
								test="${employee.currentlyOnVacation}">
								<p class="text-success">Currently on vacation!</p>
							</c:if></td>
						<td><c:out value="${employee.timestampAsString}" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>