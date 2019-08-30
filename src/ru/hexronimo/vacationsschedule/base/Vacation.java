package ru.hexronimo.vacationsschedule.base;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Locale;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.beans.factory.annotation.Autowired;

import ru.hexronimo.vacationsschedule.config.VacationCrud;

@Entity
@Table(name = "vacation")
public class Vacation {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "vacation_id_seq")
	@Column(name = "id", updatable = false, nullable = false)
	private int id;
	@Column(name = "start_date")
	private LocalDate startDate;
	@Column(name = "end_date")
	private LocalDate endDate;	
	// in some organizations, not used vacation go to the next year. So this is a year from where vacation was taken
	@Column(name = "year")
	private LocalDate year;
	@ManyToOne
	@JoinColumn(name = "employee_id")
	private Employee employee;
	
	@Transient
	@Autowired
	private VacationCrud vacationCRUD;

	public Vacation() {}

	public Vacation(LocalDate startDate, LocalDate endDate) {
		this.startDate = startDate;
		this.endDate = endDate;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LocalDate getStartDate() {
		return startDate;
	}
	
	public LocalDate getEndDate() {
		return endDate;
	}
	
	public String getStartDateAsString() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");
		String start = this.startDate.format(formatter);
		return start;
	}

	public String getEndDateAsString() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");
		String end = this.endDate.format(formatter);
		return end;
	}
	
	// return vacation period as: 3 August — 17 August 2019
	public String getDatePeriodAsText() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMMM", Locale.ENGLISH);
		DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("dd MMMM yyyy", Locale.ENGLISH);
		return startDate.format(formatter) + " — " + endDate.format(formatter1);
	}

	public void setStartDate(LocalDate startDate) {
		this.startDate = startDate;
	}

	public void setEndDate(LocalDate endDate) {
		this.endDate = endDate;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	// return amount of vacation days in the period of current Vacation (bean)
	public Long getPeriod() {
		long daysBetween = ChronoUnit.DAYS.between(startDate, endDate) + 1;
		return daysBetween;
	}

	public LocalDate getYear() {
		return year;
	}
	
	public void setYear(LocalDate year) {
		this.year = year;
	}

	public String getYearAsString() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy");
		return formatter.format(year);
	}
}
