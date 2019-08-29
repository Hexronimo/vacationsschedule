package ru.hexronimo.vacationsschedule.mvc;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ru.hexronimo.vacationsschedule.base.Employee;
import ru.hexronimo.vacationsschedule.base.Position;
import ru.hexronimo.vacationsschedule.base.Vacation;
import ru.hexronimo.vacationsschedule.base.VacationsPerYear;
import ru.hexronimo.vacationsschedule.config.VacationCRUD;

@Controller
public class MyController {
	@RequestMapping("/about")
	public String aboutPage(HttpServletRequest request, Model model) {
		return "about";
	}


}
