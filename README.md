### TeachTool
`TeachTool` is an online tuition centre application for OurCompany. It will allow users to be able to
* Add accounts - parent/student
* View performance of students
* Be notified on changes

### Setup 

* Install all required gems: ```bundle install```

* Update the database configuration file 'database.yml'.

* Create database: ```rake db:create```

* Run all migrations: ```rake db:migrate```

* Seed the database: ```rake db:seed```

* Update the cron jobs: ```whenever --update-crontab```

* Run application server: ```rails s```

### Database

TeachTool uses a PostgreSQL database to build the application. Ensure you have it running on your machine (please refer to: http://www.gotealeaf.com/blog/how-to-install-postgresql-on-a-mac)

### Background Processes

There is one background process (cron job) running in the application:  
* Reminding admins to nullify rewards every 2 weeks

### Author

* Tania Jacob (https://github.com/jacobtani)