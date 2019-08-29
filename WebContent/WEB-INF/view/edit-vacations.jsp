<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>Edit Vacations</title>
    <meta name="description" content=""/>
    <meta name="viewport" content="width=device-width"/>
    <base href="/"/>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap/css/bootstrap.min.css" />" /> 
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/bootstrap/css/bootstrap-datepicker.min.css" />" />
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/all.min.css" />" /> 
    <script type="text/javascript" src="<c:url value="/resources/jquery-3.4.1.min.js" />" ></script>  
    <script type="text/javascript" src="<c:url value="/resources/js/popper.min.js" />" ></script>
    <script type="text/javascript" src="<c:url value="/resources/bootstrap/js/bootstrap.min.js" />" ></script>
    <script type="text/javascript" src="<c:url value="/resources/bootstrap/js/bootstrap-datepicker.min.js" />" ></script>
    <script type="text/javascript" src="<c:url value="/resources/bootstrap/locales/bootstrap-datepicker.en-GB.min.js" />" ></script>
    
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
		<c:choose>
			<c:when test="${submitted eq true}">
				<h5 class="font-weight-bold">Edit the vacations of an employee</h5>

				<div class="card bg-light">
					<div class="card-header">
						<span class="font-weight-bold">Employee: </span>${shortName}
						<h6 class="card-subtitle mt-1 mb-2 text-muted">${position}</h6>
					</div>

					<div class="card-body">
						<span class="font-weight-bold mt-1">Days of the vacations
							per year</span><br>

						<form action="<c:url value="/submitVacations"/>" method="GET">
							<input type="hidden" name="idEmployee" value="${idEmployee}"
								class="form-control"> <input type="hidden"
								name="ifUpdateVPY" value="true" class="form-control">
							<div class="row">

								<c:forEach items="${vacationsPerYear}" varStatus="loop"
									var="vpy" begin="0" end="3">
									<div class="col-lg-2 col-sm-6 mb-1">
										<div class="input-group">
											<div class="input-group-prepend">
												<span class="input-group-text"><c:out
														value="${vpy.yearAsString}"></c:out></span>
											</div>
											<input type="text" class="form-control vacationsperyear"
												name="vpy_<c:out value="${loop.index}"></c:out>"
												value="<c:out value="${vpy.days}"></c:out>" disabled>
										</div>
									</div>
								</c:forEach>

								<div class="col-4">
									<input class="btn btn-primary d-none" id="btn-save"
										type="submit" value="Save"> <input
										class="btn btn-primary" id="btn-edit" type="button"
										value="Edit">
								</div>
							</div>
						</form>


						<span class="small font-italic text-muted">28 days by
							default, then the same as in the previous. Can be changed
							manually</span> <br>
						<div class="font-weight-bold mt-3">Unallocated days left</div>
						<div class="row">
							<c:forEach items="${daysLeftPerYear}" var="daysLeft">
								<div class="col-lg-2 col-sm-6 mb-1">
									<div class="input-group">
										<div class="input-group-prepend">
											<span class="input-group-text"><c:out
													value="${daysLeft.key}" /></span>
										</div>
										<input type="text" class="form-control"
											value="<c:out value="${daysLeft.value}" />" disabled>
									</div>
								</div>
							</c:forEach>
						</div>

					</div>
				</div>

				<h5 class="font-weight-bold mt-5">Add new vacation dates</h5>
				<form action="<c:url value="/submitVacations"/>" method="POST">
					<input type="hidden" name="idEmployee" value="${idEmployee}"
						class="form-control">
					<div class="row">
						<div class="col-auto">
							<div class="input-group date mb-0">
								<div class="input-group-prepend">
									<span class="input-group-text">Start date</span>
								</div>
								<input type="text" name="startDate" value=""
									class="form-control rounded-right d-inline"
									data-provide="datepicker" data-date-format="dd.mm.yyyy">
							</div>
							<div class="text-right">
								<span class="small font-italic text-muted">e.g.
									19.03.1968</span>
							</div>
						</div>
						<div class="col-auto">
							<div class="input-group date mb-0">
								<div class="input-group-prepend">
									<span class="input-group-text">End date</span>
								</div>
								<input type="text" name="endDate" value=""
									class="form-control rounded-right d-inline"
									data-provide="datepicker" data-date-format="dd.mm.yyyy">
							</div>
							<div class="text-right">
								<span class="small font-italic text-muted">e.g.
									19.03.1968</span>
							</div>
						</div>
						<div class="col-auto">
							<div class="input-group date mb-0">
								<div class="input-group-prepend">
									<span class="input-group-text">for</span>
								</div>
								<input type="text" name="year" value=""
									class="form-control rounded-right d-inline">
								<div class="input-group-append">
									<span class="input-group-text">year</span>
								</div>
							</div>
							<div class="text-right">
								<span class="small font-italic text-muted">can be left
									blank for the current year</span>
							</div>
						</div>
						<div class="col-auto">
							<input class="btn btn-primary" type="submit" value="Add">
						</div>
					</div>
				</form>
				<div class="row mt-5">
					<div class="col-sm-4">
						<h5 class="font-weight-bold mb-4">Upcoming vacation dates</h5>
						<c:if test="${empty upcomingVacations}">none</c:if>
						<c:forEach items="${upcomingVacations}" var="v">
							<div class="row">
								<div class="col-auto">
									<form action="<c:url value="/submitVacations"/>" method="POST">
										<input type="hidden" name="idEmployee" value="${idEmployee}"
											class="form-control"> <input type="hidden"
											name="idVacation" value="${v.id}" />
										<button type="submit"
											class="btn btn-outline-secondary btn-sm float-right"
											data-toggle="tooltip" data-placement="top" title="Delete">
											<i class="fas fa-times"></i>
										</button>
									</form>
								</div>
								<div class="col-auto">
									<c:out value="${v.datePeriodAsText}" />
									<p class="small font-italic text-muted">
										<c:out value="${v.startDateAsString}" />
										—
										<c:out value="${v.endDateAsString}" />
										<br> <span class="font-weight-bold"><c:out
												value="${v.period}" /> day(s) for <c:out
												value="${v.yearAsString}" /> year</span>
									</p>
								</div>
							</div>
						</c:forEach>
					</div>
					<div class="col-sm-4">
						<h5 class="font-weight-bold mb-4">Passed vacation dates</h5>
						<c:if test="${empty passedVacations}">none</c:if>
						<c:forEach items="${passedVacations}" var="v">
							<div class="row">
								<div class="col-auto">
									<form action="<c:url value="/submitVacations"/>" method="POST">
										<input type="hidden" name="idEmployee" value="${idEmployee}"
											class="form-control"> <input type="hidden"
											name="idVacation" value="${v.id}" />
										<button type="submit"
											class="btn btn-outline-secondary btn-sm float-right"
											data-toggle="tooltip" data-placement="top" title="Delete">
											<i class="fas fa-times"></i>
										</button>
									</form>
								</div>
								<div class="col-auto">
									<c:out value="${v.datePeriodAsText}" />
									<p class="small font-italic text-muted">
										<c:out value="${v.startDateAsString}" />
										—
										<c:out value="${v.endDateAsString}" />
										<br> <span class="font-weight-bold"><c:out
												value="${v.period}" /> day(s) for <c:out
												value="${v.yearAsString}" /> year</span>
									</p>
								</div>
							</div>
						</c:forEach>
					</div>

					<div class="col-sm-4">
						<h5 class="font-weight-bold mb-4">Current vacation</h5>
						<c:if test="${empty currentVacations}">not on vacation</c:if>
						<c:forEach items="${currentVacations}" var="v">
							<c:out value="${v.datePeriodAsText}" />
							<p class="small font-italic text-muted">
								<c:out value="${v.startDateAsString}" />
								—
								<c:out value="${v.endDateAsString}" />
								<br> <span class="font-weight-bold"><c:out
										value="${v.period}" /> day(s) for <c:out
										value="${v.yearAsString}" /> year</span>
							</p>
						</c:forEach>
					</div>
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

	<script type="text/javascript">
	$(document).ready(function(){
	  $('[data-toggle="tooltip"]').tooltip();
	});

	$('#btn-edit').click(function() {
		  $('.vacationsperyear').attr('disabled', !$('.vacationsperyear').attr('disabled'));
		  $('#btn-save').removeClass('d-none');
		  $(this).addClass('d-none');
	});
	</script>


</body>
</html>