package ru.hexronimo.vacationsschedule.base;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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

import org.hibernate.annotations.UpdateTimestamp;

@Entity
@Table(name="employee")
public class Employee {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "employee_id_seq")
	@Column(name = "id", updatable = false, nullable = false)
	private int id;
	
	@Column(name="first_name")
	private String firstName;
	@Column(name="surname")
	private String secondName;
	@Column(name="middle_name")
	private String parentName;
	@Column(name="birthday")
	private LocalDate birthday;
	@ManyToOne
	@JoinColumn(name="id_position")
	private Position position;
	@UpdateTimestamp
	@Column(name = "update_time")
	private LocalDateTime timestamp;

	@Transient
	private String closestVacation;
	@Transient
	private boolean currentlyOnVacation = false;

	public boolean getCurrentlyOnVacation() {
		return currentlyOnVacation;
	}

	public void setCurrentlyOnVacation(boolean currentlyOnVacation) {
		this.currentlyOnVacation = currentlyOnVacation;
	}

	public String getClosestVacation() {
		return closestVacation;
	}

	public void setClosestVacation(String closestVacation) {
		this.closestVacation = closestVacation;
	}

	public String getFullName() {
		return secondName + " " + firstName + (parentName != null? " " + parentName:"");
	}

	public String getShortName() {
		return secondName + " " + (firstName.charAt(0)+"").toUpperCase()+"."+(parentName != null? (parentName.charAt(0)+"").toUpperCase()+".":"");
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}

	public LocalDate getBirthday() {
		return birthday;
	}
	
	public String getBirthdayAsString() {
		if (this.birthday == null) return "";
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d MMMM yyyy", Locale.ENGLISH);
		String birthday = this.birthday.format(formatter);
		return birthday;
	}

	public void setName(String firstName, String secondName, String parentName) {
		this.firstName = firstName;
		this.secondName = secondName;
		this.parentName = parentName;
	}

	public void setBirthday(LocalDate birthday) {
		this.birthday = birthday;	
	}
	
	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getSecondName() {
		return secondName;
	}

	public void setSecondName(String secondName) {
		this.secondName = secondName;
	}

	public String getParentName() {
		if (parentName == null) return "";
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}

	public Position getPosition() {
		return position;
	}

	public void setPosition(Position position) {
		this.position = position;
	}
	
	public LocalDateTime getTimestamp() {
		return timestamp;
	}
	
	public String getTimestampAsString() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm:ss");
		String formatedDateTime = timestamp.format(formatter);
		return formatedDateTime;
	}

	public void setTimestamp(LocalDateTime timestamp) {
		this.timestamp = timestamp;
	}
	
}
