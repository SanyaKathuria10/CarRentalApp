## GoMILES - Car rental application
###### - Please use master branch for lastest code -
#### Read me to know the what's and how's of this project!
This project is a car rental application that helps you goMiles! 

> __The admin credentials are:__
Email : skath@gmail.com
Password : qwerty 
__The superadmin credentials are:__
Email : kkumar4@ncsu.edu
Password : kshittiz

#### What all you can do with __goMiles__ -
* A user can sign up or login to reserve a car. Logged in user can __search a car based on time durations and other car attributes__ and book it accordingly. A user can reserve a car not more than 7 days in advance and only for 1-10 hours at a stretch. A user can book just one car at a time. He can also edit his profile.
* A reserved car will be available in 'My Reservations' section which can be used further to checkout,return or cancel a reservation. Your checkout history will show all your past reservation details including total bill in reverse order i.e. latest order first with most recent entry as green. User can use his/her checkout history to know bill generated for last ride. __User will not be able to see checkout history for those cars which no longer exist in the system__.

* An admin can create other admins and view them as well. He can view, create and delete a user provided the user doesn't have a current reservation. The admin can book a car for another user and edit (checkout, return or cancel) his/her reservations. An admin can add, edit and delete cars, provided the car is not reserved.

* A super admin can do everything an admin can do and also delete admins. He can create and view other super admins as well.

* **A user cannot checkout before the time of checkout set**. Once the car is checked out, you can just return it and not cancel your reservation.

* Initial bill is zero for any car checked out, User is charged on hourly basis after he/she returns car.

### Basic guidelines:
* As soon as you login your name will be visible, your privileges will be identified on the basis of options you have. It's lame to show admin/superadmin/customer for user who log in thus not included in UI!
* Home pages for super admin and admin are similar except super admin has one extra option of adding another super admin. Following are some of the useful options available to admins, rest are self explanatory:
    * __Book car__ helps you to  **search a car** and then **book** it. Searching is case insensitive for facilating the search process. 
    * __List all admins__ allows you to see all administrators. You can book a car, see checkout history, edit reservation, delete or edit any admin you see, based on your logged in privileges. **Deletion will fails if car has been reserved** by respective admin. __List all customers__ is specific for viewing details of customers.
    * __List all cars__ allows you to see, edit and delete cars. **Deletion will fails if car has been reserved** by someone.
    * __My reservation__ allows you to see and update your current reservation. Remember after returning a car, you need to check your bill in __view checkout history__ option.
    * __View checkout history__ shows your past reservations in reverse order with latest entry on top and highlighed for better readability.
* For normal customer, Home page is pretty simple and have only four options: __Book car__, __My reservation__, __view checkout history__ and __Update profile__. 
* Each page has __home__ button and __sign out__ button to control application flow. Remember to use __contact us__ button to register any complaints related to application.

###### Extreme care is taken to design UI for best experience to users!
 #### Hope this helps!! Go explore as an admin, superadmin and user!!
###### All feedbacks are welcome :)
