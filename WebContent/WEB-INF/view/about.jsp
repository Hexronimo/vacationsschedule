<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>About</title>
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
		<h5 class="font-weight-bold mt-5">About</h5>
		<div class="row">
			<div class="col-md-8 text-justify">
				<h5 class="font-weight-bold mt-5 text-left">In traditional
					way...</h5>
				<p>The vacation schedule is compiled every year, all employee
					vacations are added there so the manager is always aware when
					someone is going to go on vacation, and the accounting department
					pay accrued leave allowances on time. It’s also convenient for the
					employees to plan their vacation in advance, for example, to buy
					cheaper flights. So, setting holiday schedules is a pretty common
					practice in many organizations.</p>
				<p>All employees submit their wishes for vacations at the end of
					each year, and the HR or director creates a consolidated schedule
					for them.</p>
				<h5 class="font-weight-bold mt-5 text-left">With this program</h5>
				<p>It is much handy to add a vacation schedule to this program.
					It keeps the list of employees and shows all the upcoming vacations
					and, as a bonus, birthdays, it also shows which employees are
					currently on vacation. A user may add and remove vacations as
					she/he wants and the program will recalculate the rest of
					unallocated days.</p>
				<p>The interface of the program is minimalistic and responsive
					so it can be accessed from the smartphone.</p>
				<h5 class="font-weight-bold mt-5 text-left">The goal and the
					author</h5>
				<p>
					Program was created as first Spring + Hibernate training project by
					<a href="https://github.com/Hexronimo">Hexronimo</a>, who learning
					Java and want to be a programmer.
				</p>
				Source code may be found at <a href="https://github.com/Hexronimo">Github</a><br>
			</div>
			<div class="col-md-4">
				<h5 class="font-weight-bold mt-5">What was used</h5>
				<i class="far fa-circle h4 mt-3 text-primary mr-3"></i> Java<br>
				<i class="far fa-circle h4 mt-3 text-primary mr-3"></i> Spring and
				Hibernate<br> <a href="https://getbootstrap.com/"><i
					class="far fa-circle h4 mt-3 text-primary mr-3"></i> Bootstrap 4</a><br>
				<a href="https://bootstrap-datepicker.readthedocs.io/en/latest/"
					target="_blank"><i
					class="far fa-circle h4 mt-3 text-primary mr-3"></i>
					Bootstrap-datapicker</a><br> <a
					href="https://github.com/danielfarrell/bootstrap-combobox"
					target="_blank"><i
					class="far fa-circle h4 mt-3 text-primary mr-3"></i>
					Bootstrap-combobox</a><br> <i
					class="far fa-circle h4 mt-3 text-primary mr-3"></i> PostgreSQL<br>
				<h5 class="font-weight-bold mt-5">What may be improved</h5>
				<i class="far fa-circle h4 mt-3 text-primary mr-3"></i> Adding Ajax
				and validation to forms<br> <i
					class="far fa-circle h4 mt-3 text-primary mr-3"></i> Adding basic
				triggers to DB and with annotations<br> <i
					class="far fa-circle h4 mt-3 text-primary mr-3"></i> Ability to
				sort the list of employees<br> <i
					class="far fa-circle h4 mt-3 text-primary mr-3"></i> Event Calendar
				like FullCalendar<br> <i
					class="far fa-circle h4 mt-3 text-primary mr-3"></i> Saving PDF to
				print vacation-related docs
			</div>

		</div>
	</div>
</body>
</html>