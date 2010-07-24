Feature: Manage posts
  In order to share my opinion
  As a blogger
  I want to post an article

  Background:
    Given I choose English language
    And I am a registered user with email "peter@example.com"
    And I have logged in as "peter@example.com"

  Scenario: Register new post
    Given I am on the new post page
    When I fill in "Title" with "Hello world"
    And I fill in "Body" with "Have a nice day"
    And I fill in "Published on" with "2010-07-01"
    And I press "Create Post"
    Then I should see "Hello world"
    And I should see "Have a nice day"
    And I should see "2010-07-01"

  Scenario: View a list of posts
    Given the following posts:
      |title|body|published_on|
      |title 1|body 1|2010-07-01|
      |title 2|body 2|2010-07-02|
      |title 3|body 3|2010-07-03|
      |title 4|body 4|2010-07-04|
    When I go to path "/posts"
    Then I should see posts table
      |title 1|body 1|2010-07-01|
      |title 2|body 2|2010-07-02|
      |title 3|body 3|2010-07-03|
      |title 4|body 4|2010-07-04|
    Then show me the page

  # Rails generates Delete links that use Javascript to pop up a confirmation
  # dialog and then do a HTTP POST request (emulated DELETE request).
  #
  # Capybara must use Culerity/Celerity or Selenium2 (webdriver) when pages rely
  # on Javascript events. Only Culerity/Celerity supports clicking on confirmation
  # dialogs.
  #
  # Since Culerity/Celerity and Selenium2 has some overhead, Cucumber-Rails will
  # detect the presence of Javascript behind Delete links and issue a DELETE request
  # instead of a GET request.
  #
  # You can turn this emulation off by tagging your scenario with @no-js-emulation.
  # Turning on browser testing with @selenium, @culerity, @celerity or @javascript
  # will also turn off the emulation. (See the Capybara documentation for
  # details about those tags). If any of the browser tags are present, Cucumber-Rails
  # will also turn off transactions and clean the database with DatabaseCleaner
  # after the scenario has finished. This is to prevent data from leaking into
  # the next scenario.
  #
  # Another way to avoid Cucumber-Rails'' javascript emulation without using any
  # of the tags above is to modify your views to use <button> instead. You can
  # see how in http://github.com/jnicklas/capybara/issues#issue/12
  #

  Scenario: Delete post
    Given the following posts:
      |title|body|published_on|
      |title 1|body 1|2010-07-01|
      |title 2|body 2|2010-07-02|
      |title 3|body 3|2010-07-03|
      |title 4|body 4|2010-07-04|
    When I delete the 3rd post
    Then I should see posts table
      |title 1|body 1|2010-07-01|
      |title 2|body 2|2010-07-02|
      |title 4|body 4|2010-07-04|

