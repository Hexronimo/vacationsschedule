package ru.hexronimo.vacationsschedule.config;

import java.util.Properties;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;


public class HibernateUtil {

	static {
		try {
			Properties prop= new Properties();
			prop.setProperty("hibernate.connection.url", "jdbc:postgresql:ec2-54-228-243-238.eu-west-1.compute.amazonaws.com:5432/d884nhdf64h0bh?sslmode=require");
			prop.setProperty("hibernate.connection.username", "rbexibfitzlebx");
			prop.setProperty("hibernate.connection.password", "dfb825f06612848b059c9570be497bc2364fbc4959b67a0ad8578407755aa1a0");
			prop.setProperty("dialect", "org.hibernate.dialect.PostgreSQLDialect");
			
		} catch (Throwable ex) {
			throw new ExceptionInInitializerError(ex);
		}
	}

	}