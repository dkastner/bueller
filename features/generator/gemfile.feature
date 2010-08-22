Feature: generated Gemfile
  In order to start a new gem
  A user should be able to
  generate a Gemfile

  Background:
    Given a working directory
    And I have configured git sanely

  Scenario: default
    When I generate a project named 'the-perfect-gem' that is 'zomg, so good'
    Then a file named 'the-perfect-gem/Gemfile' is created
    And 'Gemfile' depends on the gemspec
    And 'Gemfile' uses the rubygems source
