`has_secure_attribute`
======================

Why have `has_secure_password` and not any attribute that you want. I believe that, quite often, we want to one-way encrypt one attribute and authenticate against its value, and this is not only the `password` case.

Requires
--------

`ActiveRecord` and `BCrypt`

Install
-------

`gem install 'has_secure_attribute'`

or in your `Gemfile`

`gem 'has_secure_attribute'` and then `bundle`

Use it
------

    class User < ActiveRecord::Base
      has_secure_security_answer
    end

In the above example:

* Your should have a `users` table that has one column: `security_answer_digest`.
* It creates a reader: `security_answer`.
* It creates a writer: `security_answer=(value)` which basically saves the security answer given into the database on column `security_answer_digest` but is saves it encrypted.
* It adds some validations (if you want to avoid having these validations: `has_secure_security_answer :validations => false`).
  * It creates a confirmation validation on `security_answer` but only if `security_answer` is given (for confirmation validations see [this](http://http://guides.rubyonrails.org/active_record_validations.html#confirmation)).
  * It creates a presence validation on `security_answer` but only on create.
  * It creates a presence validation on `security_answer_confirmation` but only if `security_answer` has been given.
  * It raises an exception if `security_answer_digest` is empty on create.
* It defines the method `authenticate_security_answer(answer_to_authenticate)` which returns `false` if the answer given does not correspond to the saved digest, or returns the object instance itself if it does.

Do you want to test it?
------------------------

`bundle exec rake`

__Note:__ Testing works with a MySQL database. So, you need to have MySQL installed. Other than that, everything else needed to run the tests is done automatically. (db create, db migrate e.t.c.)


