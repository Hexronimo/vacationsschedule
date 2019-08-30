package ru.hexronimo.vacationsschedule.config;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

import javax.persistence.NoResultException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.springframework.stereotype.Repository;

import ru.hexronimo.vacationsschedule.base.Position;
import ru.hexronimo.vacationsschedule.base.Vacation;
import ru.hexronimo.vacationsschedule.base.VacationsPerYear;
import ru.hexronimo.vacationsschedule.base.Employee;

@Repository
public class VacationCrud {
	
	private static SessionFactory factory = new Configuration().configure("hibernate.cfg.xml")
			.addAnnotatedClass(Employee.class)
			.addAnnotatedClass(Position.class)
			.addAnnotatedClass(Vacation.class)
			.addAnnotatedClass(VacationsPerYear.class)
			.buildSessionFactory();

	public void createEmployeeAtDB(Employee employee) throws Exception {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			session.save(employee);
			session.getTransaction().commit();
		}
	}

	public List<Position> listPositionsFromDB() throws Exception {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			@SuppressWarnings("unchecked")
			List<Position> listPositions = (List<Position>) session.createQuery("FROM Position").getResultList();
			session.getTransaction().commit();
			return listPositions;
		}
	}

	@SuppressWarnings("unchecked")
	public Position createPositionAtDB(Position position) throws Exception {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			List<Position> listPositions = (List<Position>) session
					.createQuery("FROM Position p WHERE p.position='" + position.getPosition() + "'").getResultList();
			if (listPositions.size() == 0) {
				session.save(position);
				listPositions = (List<Position>) session
						.createQuery("FROM Position p WHERE p.position='" + position.getPosition() + "'")
						.getResultList();
			}
			session.getTransaction().commit();
			return listPositions.get(0);
		}
	}

	public void deleteEmloyeeFromDB(String id) throws Exception {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			session.createQuery("DELETE FROM Employee e WHERE e.id=" + id).executeUpdate();
			session.getTransaction().commit();
		}
	}

	public Employee getEmloyeeByIdFromDB(String id) throws Exception {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			@SuppressWarnings("unchecked")
			List<Employee> listEmployees = (List<Employee>) session.createQuery("FROM Employee WHERE id = " + id)
					.getResultList();
			session.getTransaction().commit();
			return listEmployees.get(0);
		}
	}

	public void updateEmloyeeAtDB(Employee employee) throws Exception {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			session.update(employee);
			session.getTransaction().commit();
		}
	}

	public List<Employee> listEmployeesFromDB() throws Exception {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			@SuppressWarnings("unchecked")
			List<Employee> listEmployees = (List<Employee>) session.createQuery("FROM Employee").getResultList();
			session.getTransaction().commit();
			return listEmployees;
		}
	}

	public String getClosestVacationDateOfEmployee(Employee employee) throws Exception {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			@SuppressWarnings("unchecked")
			List<Vacation> date = (List<Vacation>) session.createQuery("FROM Vacation WHERE employee = "
					+ employee.getId() + " AND startDate > CURRENT_DATE ORDER BY startDate ASC").getResultList();
			if (date.size() == 0)
				return "not set yet";

			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMMM yyyy", Locale.ENGLISH);
			String formatedStartDate = date.get(0).getStartDate().format(formatter);
			session.getTransaction().commit();
			return formatedStartDate;
		}
	}

	public List<Vacation> getAllVacationsInThreeWeeks() throws Exception {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			@SuppressWarnings("unchecked")
			List<Vacation> date = (List<Vacation>) session.createQuery(
					"FROM Vacation WHERE startDate > CURRENT_DATE AND startDate < CURRENT_DATE + 21 ORDER BY startDate ASC")
					.getResultList();
			if (date.size() == 0)
				return null;
			session.getTransaction().commit();
			return date;
		}
	}

	public List<Employee> getAllClosestBirthdays() throws Exception {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String fakeDate = formatter.format(LocalDate.now());
			String fakeDate2 = formatter.format(LocalDate.now().plusDays(14));
			int fakeYear = Integer.parseInt(fakeDate.substring(0, 4));

			@SuppressWarnings("unchecked")
			List<Employee> employees = (List<Employee>) session.createQuery("FROM Employee WHERE TO_CHAR(birthday, '"
					+ fakeYear + "-MM-DD') BETWEEN '" + fakeDate + "' AND '" + fakeDate2 + "' ORDER BY birthday ASC")
					.getResultList();

			// just for case of December to January overlap
			@SuppressWarnings("unchecked")
			List<Employee> employees2 = (List<Employee>) session
					.createQuery("FROM Employee WHERE TO_CHAR(birthday, '" + (fakeYear + 1) + "-MM-DD') BETWEEN '"
							+ fakeDate + "' AND '" + fakeDate2 + "' ORDER BY birthday ASC")
					.getResultList();

			employees.addAll(employees2);

			if (employees.size() == 0)
				return null;
			session.getTransaction().commit();
			return employees;
		}
	}

	public List<Vacation> getUpcomingVacationsOfEmployee(Employee employee) throws Exception {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			@SuppressWarnings("unchecked")
			List<Vacation> date = (List<Vacation>) session.createQuery("FROM Vacation WHERE employee = "
					+ employee.getId() + " AND startDate > CURRENT_DATE ORDER BY startDate ASC").getResultList();
			if (date.size() == 0)
				return null;
			session.getTransaction().commit();
			return date;
		}
	}

	public List<Vacation> getPassedVacationsOfEmployee(Employee employee) throws Exception {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			@SuppressWarnings("unchecked")
			List<Vacation> date = (List<Vacation>) session.createQuery("FROM Vacation WHERE employee = "
					+ employee.getId() + " AND endDate < CURRENT_DATE ORDER BY startDate DESC").getResultList();
			if (date.size() == 0)
				return null;
			session.getTransaction().commit();
			return date;
		}
	}

	public List<Vacation> getCurrentVacationsOfEmployee(Employee employee) throws Exception {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			@SuppressWarnings("unchecked")
			List<Vacation> date = (List<Vacation>) session
					.createQuery("FROM Vacation WHERE employee = " + employee.getId()
							+ " AND startDate < CURRENT_DATE AND endDate > CURRENT_DATE ORDER BY startDate DESC")
					.getResultList();
			if (date.size() == 0)
				return null;
			session.getTransaction().commit();
			return date;
		}
	}

	public List<Vacation> getVacationsOfEmployee(Employee employee) throws Exception {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			@SuppressWarnings("unchecked")
			List<Vacation> date = (List<Vacation>) session
					.createQuery("FROM Vacation WHERE employee = " + employee.getId()).getResultList();
			if (date.size() == 0)
				return null;
			session.getTransaction().commit();
			return date;
		}
	}

	public void createVacationAtDB(Vacation vacation) throws Exception {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			session.save(vacation);
			session.getTransaction().commit();
		}
	}

	public void deleteVacationAtDB(String id) throws Exception {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			session.createQuery("DELETE FROM Vacation WHERE id=" + id).executeUpdate();
			session.getTransaction().commit();
		}
	}

	public void deleteTooOldVacations() {
		// delete too old data about vacations (more then 3 years old)
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			session.createQuery(
					"DELETE FROM Vacation WHERE date_part('year', CURRENT_DATE) - date_part('year', endDate) > 3")
					.executeUpdate();
			session.createQuery(
					"DELETE FROM VacationsPerYear WHERE date_part('year', CURRENT_DATE) - date_part('year', year) > 3")
					.executeUpdate();
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("ERROR: " + e.getMessage());
			e.printStackTrace();
		}
	}

	public void updateVacationsPerYearOfEmployee(Employee employee, VacationsPerYear[] vacationsPerYear) {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			session.createQuery("UPDATE VacationsPerYear SET days=" + vacationsPerYear[0].getDays()
					+ " WHERE employee = " + employee.getId() + " AND date_part('year', year) = "
					+ VacationsPerYear.getCheckingYears()[0]).executeUpdate();
			session.createQuery("UPDATE VacationsPerYear SET days=" + vacationsPerYear[1].getDays()
					+ " WHERE employee = " + employee.getId() + " AND date_part('year', year) = "
					+ VacationsPerYear.getCheckingYears()[1]).executeUpdate();
			session.createQuery("UPDATE VacationsPerYear SET days=" + vacationsPerYear[2].getDays()
					+ " WHERE employee = " + employee.getId() + " AND date_part('year', year) = "
					+ VacationsPerYear.getCheckingYears()[2]).executeUpdate();
			session.createQuery("UPDATE VacationsPerYear SET days=" + vacationsPerYear[3].getDays()
					+ " WHERE employee = " + employee.getId() + " AND date_part('year', year) = "
					+ VacationsPerYear.getCheckingYears()[3]).executeUpdate();
			session.getTransaction().commit();
		} catch (Exception e) {
			System.out.println("ERROR: " + e.getMessage());
			e.printStackTrace();
		}
	}

	public VacationsPerYear[] getVacationsPerYearOfEmployee(Employee employee) {
		try (Session session = factory.getCurrentSession()) {
			session.beginTransaction();
			VacationsPerYear[] days = new VacationsPerYear[4];
			try {
				days[0] = (VacationsPerYear) session
						.createQuery("FROM VacationsPerYear WHERE employee = " + employee.getId()
								+ " AND date_part('year', year) = " + VacationsPerYear.getCheckingYears()[0])
						.getSingleResult();
				days[1] = (VacationsPerYear) session
						.createQuery("FROM VacationsPerYear WHERE employee = " + employee.getId()
								+ " AND date_part('year', year) = " + VacationsPerYear.getCheckingYears()[1])
						.getSingleResult();
				days[2] = (VacationsPerYear) session
						.createQuery("FROM VacationsPerYear WHERE employee = " + employee.getId()
								+ " AND date_part('year', year) = " + VacationsPerYear.getCheckingYears()[2])
						.getSingleResult();
				days[3] = (VacationsPerYear) session
						.createQuery("FROM VacationsPerYear WHERE employee = " + employee.getId()
								+ " AND date_part('year', year) = " + VacationsPerYear.getCheckingYears()[3])
						.getSingleResult();
			} catch (NoResultException nre) {
				// Ignore
			}
			boolean someAreNull = false;

			for (int i = 0; i < 4; i++) {
				if (days[i] == null) {
					VacationsPerYear newVpy = new VacationsPerYear();
					newVpy.setEmployee(employee);
					newVpy.setYear(LocalDate.of(VacationsPerYear.getCheckingYears()[i], 1, 1));

					if (i > 0) {
						// set days as they where in previous year
						newVpy.setDays(days[i - 1].getDays());
					} else {
						// and 28 days is default
						newVpy.setDays(28);
					}
					days[i] = newVpy;
					session.save(newVpy);
					if (someAreNull == false)
						someAreNull = true;
				}
			}

			session.getTransaction().commit();
			if (someAreNull)
				return getVacationsPerYearOfEmployee(employee);
			return days;
		}
	}

}
