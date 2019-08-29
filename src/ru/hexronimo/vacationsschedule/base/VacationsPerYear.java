package ru.hexronimo.vacationsschedule.base;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

// how many days of vacation employee has for working a year. Usually 28
@Entity
@Table(name="vacations_per_year")
public class VacationsPerYear {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "vacations_per_year_id_seq")
	@Column(name = "id", updatable = false, nullable = false)
	private int id;
	@Column(name = "year")
	private LocalDate year;
	@Column(name = "days")
	private int days;
	@ManyToOne
	@JoinColumn(name="employee_id")
	private Employee employee;
	
	@Transient
	private static int[] checkingYears = new int[4];

	static {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy");
		int currentYear = Integer.parseInt(formatter.format(LocalDate.now()));
		checkingYears[0] = currentYear - 2;
		checkingYears[1] = currentYear - 1;
		checkingYears[2] = currentYear;
		checkingYears[3] = currentYear + 1;
	}

	public static int[] getCheckingYears() {
		return checkingYears;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LocalDate getYear() {
		return year;
	}

	public void setYear(LocalDate year) {
		this.year = year;
	}

	public int getDays() {
		return days;
	}

	public void setDays(int days) {
		this.days = days;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getYearAsString() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy");
		return formatter.format(year);
	}

}
