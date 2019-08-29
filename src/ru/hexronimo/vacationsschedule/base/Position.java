package ru.hexronimo.vacationsschedule.base;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="position")
public class Position {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO, generator = "position_id_seq")
	@Column(name = "id", updatable = false, nullable = false)
	private int id;

	@Column(name = "position_name")
	private String position = null;

	public Position() {
	}

	public Position(String position) {
		this.position = position;
	}

	public String getPosition() {
		if (position != null) {
			return position;
		}
		return "";
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

}
