package ru.hexronimo.vacationsschedule.mvc;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ru.hexronimo.vacationsschedule.base.Employee;
import ru.hexronimo.vacationsschedule.base.Position;
import ru.hexronimo.vacationsschedule.base.Vacation;
import ru.hexronimo.vacationsschedule.base.VacationsPerYear;
import ru.hexronimo.vacationsschedule.config.VacationCrud;

@Controller
public class MyController {
	
	@Autowired
	private VacationCrud vacationCRUD;
	
	@RequestMapping("/about")
	public String aboutPage(HttpServletRequest request, Model model) {
		return "about";
	}
	@RequestMapping("/")
	public String homePage(HttpServletRequest request, Model model) {
		String ifError = "";
		try {
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMMM yyyy", Locale.ENGLISH);
			model.addAttribute("today", formatter.format(LocalDate.now()));
			List<Vacation> date = vacationCRUD.getAllVacationsInThreeWeeks();
			Map<String, String> vacationEmployee = new HashMap<>();
			for (Vacation v : date) {
				vacationEmployee.put(v.getDatePeriodAsText(),
						vacationCRUD.getEmloyeeByIdFromDB(v.getEmployee().getId() + "").getPosition().getPosition()
								+ " " + vacationCRUD.getEmloyeeByIdFromDB(v.getEmployee().getId() + "").getShortName());
			}
			model.addAttribute("vacations", vacationEmployee);
			List<Employee> employees = vacationCRUD.getAllClosestBirthdays();
			model.addAttribute("birthdays", employees);
		} catch (Exception e) {
			System.out.println("ERROR: " + e.getMessage());
			e.printStackTrace();
			ifError = "ERROR: " + e.getMessage();
		}
		model.addAttribute("ifError", ifError);
		return "home";
	}

	@RequestMapping("/addEmployee")
	public String addEmployeeForm(HttpServletRequest request, Model model) {
		try {
			List<Position> positions = vacationCRUD.listPositionsFromDB();
			model.addAttribute("positions", positions);

			String id = request.getParameter("id");

			if (id != null && !id.equals("")) {
				Employee employee = vacationCRUD.getEmloyeeByIdFromDB(id);

				String position = employee.getPosition() == null ? "" : employee.getPosition().getPosition();

				model.addAttribute("id", id);
				model.addAttribute("firstName", employee.getFirstName());
				model.addAttribute("secondName", employee.getSecondName());
				model.addAttribute("parentName", employee.getParentName());
				model.addAttribute("birthday", employee.getBirthdayAsString());
				model.addAttribute("position", position);
			}
		} catch (Exception e) {
			System.out.println("ERROR: " + e.getMessage());
			e.printStackTrace();
		}
		return "add-worker";
	}

	@RequestMapping("/submitEmployee")
	public String submitEmployee(HttpServletRequest request, Model model) {

		String ifError = "";
		String annatationColor = "bg-success";

		String firstName = request.getParameter("firstName");
		String secondName = request.getParameter("secondName");
		String parentName = request.getParameter("parentName");
		String birthday = request.getParameter("birthday");
		String position = request.getParameter("position");
		String id = request.getParameter("id");

		boolean submitted = true;

		if (firstName != null && secondName != null) {

			try {

				if (parentName.equals(""))
					parentName = null;
				if (birthday.equals(""))
					birthday = null;
				if (position.equals(""))
					position = null;

				Employee employee = new Employee();
				employee.setName(firstName, secondName, parentName);
				if (birthday != null) {
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");
					LocalDate birthdayDate = LocalDate.parse(birthday, formatter);
					employee.setBirthday(birthdayDate);
				}
				if (position != null) {
					position = position.toLowerCase();
					Position employeePosition = new Position(position);
					employee.setPosition(vacationCRUD.createPositionAtDB(employeePosition));
				}

				// in case of update (submit updated data about employee)
				if (id != null && !id.equals("")) {
					employee.setId(Integer.parseInt(id));
					vacationCRUD.updateEmloyeeAtDB(employee);
					model.addAttribute("id", id);
					ifError = "Data on " + employee.getFullName() + " successfully updated";

					// in case of creation (submit new worker)
				} else {
					vacationCRUD.createEmployeeAtDB(employee);
					ifError = employee.getFullName() + " successfully added to database";
				}
				model.addAttribute("employeeName", employee.getFullName());
			} catch (Exception e) {
				System.out.println("ERROR: " + e.getMessage());
				e.printStackTrace();
				ifError = "ERROR: " + e.getMessage();
				annatationColor = "bg-danger";
			}
			model.addAttribute("annatationColor", annatationColor);

			// in case someone get to this page by direct access (without any posted
			// parameters)
		} else {
			submitted = false;
		}
		model.addAttribute("submitted", submitted);
		model.addAttribute("ifError", ifError);
		return "submit-worker";
	}

	@RequestMapping("/deleteEmployee")
	public String deleteEmployee(HttpServletRequest request, Model model) {

		String ifError = "";
		String annatationColor = "bg-success";
		String id = request.getParameter("id");
		boolean submitted = true;

		if (id != null) {
			try {
				Employee employee = vacationCRUD.getEmloyeeByIdFromDB(id);
				vacationCRUD.deleteEmloyeeFromDB(id);
				ifError = "Employee " + employee.getFullName() + "successfully deleted from database";
				model.addAttribute("ifError", ifError);
				model.addAttribute("annatationColor", annatationColor);
			} catch (Exception e) {
				System.out.println("ERROR: " + e.getMessage());
				e.printStackTrace();
				ifError = "ERROR: " + e.getMessage();
				annatationColor = "br-danger";
			}
		} else {
			submitted = false;
		}
		model.addAttribute("submitted", submitted);
		return "delete-worker";
	}

	@RequestMapping("/listEmployees")
	public String listEmployees(HttpServletRequest request, Model model) {
		String ifError = "";
		try {
			List<Employee> listEmployees = vacationCRUD.listEmployeesFromDB();
			for (Employee e : listEmployees) {
				e.setClosestVacation(vacationCRUD.getClosestVacationDateOfEmployee(e));
				List<Vacation> vacationList = vacationCRUD.getCurrentVacationsOfEmployee(e);
				if (vacationList == null || vacationList.size() == 0) {
					e.setCurrentlyOnVacation(false);
				} else {
					e.setCurrentlyOnVacation(true);
				}
			}
			model.addAttribute("employees", listEmployees);
		} catch (Exception e) {
			System.out.println("ERROR: " + e.getMessage());
			e.printStackTrace();
			ifError = "ERROR: " + e.getMessage();
		}
		model.addAttribute("ifError", ifError);
		return "list-workers";
	}

	@RequestMapping("/editVacations")
	public String editVacations(HttpServletRequest request, Model model) {
		String ifError = "";
		boolean submitted = true;
		String id = request.getParameter("id");
		try {
			if (id != null && !id.equals("")) {
				Employee employee = vacationCRUD.getEmloyeeByIdFromDB(id);
				String position = employee.getPosition() == null ? "" : employee.getPosition().getPosition();
				VacationsPerYear[] vpr = vacationCRUD.getVacationsPerYearOfEmployee(employee);

				model.addAttribute("idEmployee", id);
				model.addAttribute("shortName", employee.getShortName());
				model.addAttribute("birthday", employee.getBirthdayAsString());
				model.addAttribute("position", position);

				model.addAttribute("vacationsPerYear", vpr);

				List<Vacation> upcomingVacations = (List<Vacation>) vacationCRUD
						.getUpcomingVacationsOfEmployee(employee);
				model.addAttribute("upcomingVacations", upcomingVacations);
				List<Vacation> passedVacations = (List<Vacation>) vacationCRUD.getPassedVacationsOfEmployee(employee);
				model.addAttribute("passedVacations", passedVacations);
				List<Vacation> currentVacations = (List<Vacation>) vacationCRUD.getCurrentVacationsOfEmployee(employee);
				model.addAttribute("currentVacations", currentVacations);

				Map<Integer, Integer> vprDaysLeft = new HashMap<>();
				vprDaysLeft.put(VacationsPerYear.getCheckingYears()[0], vpr[0].getDays());
				vprDaysLeft.put(VacationsPerYear.getCheckingYears()[1], vpr[1].getDays());
				vprDaysLeft.put(VacationsPerYear.getCheckingYears()[2], vpr[2].getDays());
				vprDaysLeft.put(VacationsPerYear.getCheckingYears()[3], vpr[3].getDays());

				List<Vacation> allVacations = (List<Vacation>) vacationCRUD.getVacationsOfEmployee(employee);
				if (allVacations != null) {
					for (Vacation v : allVacations) {
						if (vprDaysLeft.containsKey(Integer.parseInt(v.getYearAsString()))) {
							vprDaysLeft.put(Integer.parseInt(v.getYearAsString()),
									(vprDaysLeft.get(Integer.parseInt(v.getYearAsString()))
											- v.getPeriod().intValue()));

						}
					}
				}
				model.addAttribute("daysLeftPerYear", vprDaysLeft);

			} else {
				submitted = false;
			}
		} catch (Exception e) {
			System.out.println("ERROR: " + e.getMessage());
			e.printStackTrace();
			ifError = "ERROR: " + e.getMessage();
		}
		model.addAttribute("submitted", submitted);
		model.addAttribute("ifError", ifError);
		return "edit-vacations";
	}

	@RequestMapping("/submitVacations")
	public String submitVacations(HttpServletRequest request, Model model) {
		String ifError = "";
		String ifUpdateVPY = request.getParameter("ifUpdateVPY");
		boolean submitted = true;
		String annatationColor = "bg-success";
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String idVacation = request.getParameter("idVacation");
		String idEmployee = request.getParameter("idEmployee");

		try {
			Employee employee = vacationCRUD.getEmloyeeByIdFromDB(idEmployee);
			String shortName = employee.getShortName();
			if (idVacation != null && !idVacation.equals("")) {
				model.addAttribute("shortName", shortName);
				model.addAttribute("id", idEmployee);

				vacationCRUD.deleteVacationAtDB(idVacation);
				ifError = "Vacations successfully deleted";
			} else if (startDate != null && !startDate.equals("") && endDate != null && !endDate.equals("")) {
				model.addAttribute("shortName", shortName);
				model.addAttribute("id", idEmployee);
				String year = request.getParameter("year");

				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");
				Vacation vacation = new Vacation(LocalDate.parse(startDate, formatter),
						LocalDate.parse(endDate, formatter));
				vacation.setEmployee(vacationCRUD.getEmloyeeByIdFromDB(idEmployee));
				formatter = DateTimeFormatter.ofPattern("yyyy");
				if (year == null || "".equals(year))
					year = formatter.format(LocalDate.now());
				formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
				vacation.setYear(LocalDate.parse(year + "0101", formatter));
				vacationCRUD.createVacationAtDB(vacation);
				ifError = "Vacations successfully added to " + shortName;
			} else if ("true".equals(ifUpdateVPY)) {
				model.addAttribute("shortName", shortName);
				model.addAttribute("id", idEmployee);
				String[] vpy = new String[4];
				vpy[0] = request.getParameter("vpy_0");
				vpy[1] = request.getParameter("vpy_1");
				vpy[2] = request.getParameter("vpy_2");
				vpy[3] = request.getParameter("vpy_3");

				VacationsPerYear[] vacationsPerYear = new VacationsPerYear[4];

				for (int i = 0; i < 4; i++) {
					vacationsPerYear[i] = new VacationsPerYear();
					vacationsPerYear[i].setEmployee(employee);
					vacationsPerYear[i].setDays(Integer.parseInt(vpy[i]));
				}

				vacationCRUD.updateVacationsPerYearOfEmployee(employee, vacationsPerYear);
				ifError = "Quantity of vacation days per year for " + shortName + " successfully changed";
			} else {
				submitted = false;
			}
		} catch (Exception e) {
			System.out.println("ERROR: " + e.getMessage());
			e.printStackTrace();
			ifError = "ERROR: " + e.getMessage();
			annatationColor = "bg-danger";
		}
		model.addAttribute("annatationColor", annatationColor);
		model.addAttribute("submitted", submitted);
		model.addAttribute("ifError", ifError);
		return "submit-vacations";
	}
}
