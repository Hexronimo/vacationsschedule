<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Add Employee</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width" />
<base href="/" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap/css/bootstrap.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap/css/bootstrap-datepicker.min.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/bootstrap-combobox.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/all.min.css" />" />
<script type="text/javascript" src="<c:url value="/resources/jquery-3.4.1.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap/js/bootstrap.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap/js/bootstrap-datepicker.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/bootstrap/locales/bootstrap-datepicker.en-GB.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/bootstrap-combobox.js" />"></script>

<style>
.datepicker-dropdown {
	margin-top: 49px;
}
</style>
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

		<h5 class="font-weight-bold">
			<c:choose>
				<c:when test="${not empty id}">Edit employee</c:when>
				<c:otherwise>Add new employee</c:otherwise>
			</c:choose>
		</h5>
		<form action="<c:url value="/submitEmployee"/>" method="POST">
			<input type="hidden" name="id" value="${id}" class="form-control">
			<div class="card p-3">
				<div class="row">
					<div class="col-md-4">
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">Surname<span
									class="text-danger">*</span></span>
							</div>
							<input type="text" name="secondName" value="${secondName}"
								class="form-control">
						</div>
					</div>
					<div class="col-md-4">
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">First name <span
									class="text-danger">*</span></span>
							</div>
							<input type="text" name="firstName" value="${firstName}"
								class="form-control">
						</div>
					</div>

					<div class="col-md-4">
						<div class="input-group mb-0">
							<div class="input-group-prepend">
								<span class="input-group-text">Middle name</span>
							</div>
							<input type="text" name="parentName" value="${parentName}"
								class="form-control">
						</div>
						<div class="text-right">
							<span class="small font-italic text-muted">if presented</span>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="input-group mt-2">
							<select class="combobox form-control">
								<option
									value="<c:if test="${not empty position}"><c:out value="${position}" /></c:if>"
									selected="selected"><c:choose>
										<c:when test="${not empty position}">${position}</c:when>
										<c:otherwise> Select or enter new </c:otherwise>
									</c:choose></option>
								<c:forEach items="${positions}" var="p">
									<c:if test="${position ne p.position}">
										<option value="<c:out value="${p.position}" />"><c:out
												value="${p.position}" /></option>
									</c:if>
								</c:forEach>
							</select> <input type="hidden" id="theinput_hidden" value="">
						</div>
					</div>
					<div class="col-md-4">
						<div class="input-group date mt-2 mb-0">
							<div class="input-group-prepend">
								<span class="input-group-text">Birthday</span>
							</div>
							<input type="text" name="birthday" value="${birthday}"
								class="form-control rounded-right" data-provide="datepicker"
								data-date-format="dd.mm.yyyy">
							<div class="input-group-addon">
								<span class="glyphicon glyphicon-th"></span>
							</div>
						</div>
						<div class="text-right">
							<span class="small font-italic text-muted">e.g. 19.03.1968</span>
						</div>
					</div>
				</div>
			</div>
			<input class="btn btn-primary mt-2 float-right" type="submit"
				value="<c:choose><c:when test="${not empty id}">Save</c:when><c:otherwise>Add</c:otherwise></c:choose>">

			<div class="mt-3">
				<span class="text-danger">*</span><span class="small font-italic">
					— required</span>
			</div>
		</form>

	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			$('.combobox').combobox({
				clearIfNoMatch : 'false'
			});
		});
	</script>

</body>
</html>