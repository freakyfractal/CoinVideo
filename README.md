CoinVideo
=========

... *Ready-to-deploy!* *


AppEngine website where users can earn Bitcoins for watching videos (served with Virool API).

Main Features
-------------
* Simple User System to keep track of activity.
* Validate Bitcoin Addresses.
* No-captcha. Users are authenticated.
* Users: Ability to change wallet address keeping their balance.
* Auto-update user's balance.

Installation
------------
*Before installing you will want to have both:*

* Google Account

* Virool Publisher's Account

*Though they are not strictly necessary you'll need the Google account to deploy your project on App Engine, and you'll want your Virool account to be able to claim your earnings with them.*

**(Easy)**

* Set up Eclipse and Google App Engine SDK ([follow guide](https://developers.google.com/appengine/docs/java/tools/eclipse))

* Create a new Web Application ( **File** > **New** > **Web Application Project** )

* Import Files ( **File** > **Import...** )

* Choose 'General > File System' and browse to the directory with the CoinVideo files ...

* Import the folders: `src/` and `war/`. If prompted, choose Yes to overwrite `war/WEB-INF/web.xml`.

* You're ready! Now just press **F12** to start up the development server ([localhost:8888](http://localhost:8888))

**Note:** to deploy on App Engine you will first need a Google account and set up a new application via the console. Then you will need to update `war/WEB-INF/appengine-web.xml` with your application's configuration.



More Info
---------

This project was written to run on Google's App Engine platform.

**(Frontend)**

* Clean, simple interface.


* Auto-update user's balance using AJAX.

**(Backend)**

* [Datastore API](https://developers.google.com/appengine/docs/java/datastore/http://google.com) (Google) for database

* [Users API](http://google.com) (Google) for authentication

* [Virool API](http://virool.com) for videos / offerwall


**NOTE:** This project is a complete and working website. That said, it's development has most likely
been discontinued. (I stopped using Virool, so have little interest in continuing development).

