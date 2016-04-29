TODO
====

In this document I will try to list some long-term tasks for WSBF's codebase.

### Server-side web application framework

The old website `new.wsbf.net` had embedded PHP in every page, which was a mess. While developing the current web application, I was able to compartmentalize this PHP functionality into JSON API's located in `/api`, but there is still room for improvement. AngularJS provides many web-app services on the front-end, but a framework for the back-end might provide better functionality for database interactions, authentication, routing, and so on. Adopting a PHP framework such as Laravel would likely require the least amount of code changes, but there is also an opportunity here to move to a better language, such as Python or Ruby.

### Remote broadcasting

...

### RDS sender for Linux

...

### Automated charting email for CMJ, promoters

...

### Listener Count Monitoring

...

### Infrastructure automation with Ansible

...
