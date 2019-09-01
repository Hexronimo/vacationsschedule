# Vacation Schedule
Web-application that allow to set, view and edit list of vacations for employees

## About project
This is training project which was created during the part of Spring+Hibernate course at Udemy. I learned basic CRUD methods and queries and how it all works with Hibernate annotations, also I learned idea of MVC and something about web-application configuration, but Heroku ruined it a little bit (it didn't want to see hibernate.cfg.xml in src/ or in rosourses/ at deploying until I moved DB properties to .java file).

## How to use
Live version can be found at https://morning-oasis-75907.herokuapp.com/

You may add new employee or edit existing, then go to "List Employees" and press button with the calendar icon (Add vacations), check vacation days per year (default is 28 days) and chenge it if you need, add vacations. Now all upcoming vacations will be shown at homepage and people who are currently on vacation will have that label at emloyees list. As little bonus all birthdays which occurs during two weeks will be shown at homepage too. For more information look at https://morning-oasis-75907.herokuapp.com/about

## Build
Most likely you will not do it, but you may build it from sources. To do so, you need to:
* restore dbexport.pgsql file from the root of this repository (DB name: vacationsschedule, user and password: hex)
![My image](https://github.com/Hexronimo/vacationsschedule/raw/master/vshchdbsc.png)
* change database settings at file ru.hexronimo.vacationsschedule.config.VacationCrud.java, there is small instruction in comments inside this file
* Set up Tomcat server 
* Now you can run it on your own server

If you need any help feel free to ask.

## Built With
* [Java 8](https://www.java.com/en/)
* [Spring](https://spring.io/)
* [Hibernate](http://hibernate.org/)
* [Maven](https://maven.apache.org/)
* [Bootstrap 4](https://getbootstrap.com/)
* [PostgreSQL](https://www.postgresql.org/download/)
