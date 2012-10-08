# Feature : Creating Category

Feature: Creating categories
In order to have categories to assign sub_categories to
As a user
I want to create them easily

Scenario: Creating a category
Given I am on the homepage
When I follow "New Category"
And I fill in "Name" with "Link"
And I press "Create Category"
Then I should see "A category has been created."

