Feature: Merge Articles
  As an admin
  In order to make my blog cleaner
  I want to be able to merge two articles with the same topic

  Background:
    Given the blog is set up
    And the following articles exist:
    | title         | author        | body                                         | published |
    | A first post  | First Author  | The text in the first blog post.             | true      |
    | A second post | Second Author | Followed by the text in a similar blog post. | true      |
    And the following users exist:
    | login         | password      | email                    | name             | profile_id |
    | publisher     | publisher_pw  | publisher@domain.org     | Blog Publisher   | 2          |
    

  Scenario: An admin can see the merge articles button
    Given I am logged into the admin panel
    And I visit the edit page for "A first post"
    Then I should see "Merge Articles"

  Scenario: A non-admin cannot see the merge articles button
    And I visit the edit page for "A first post"
    Then I should not see "Merge Articles"

  Scenario: An article cannot be merged with itself
    Given I am logged into the admin panel
    And I visit the edit page for "A first post"
    And I attempt to merge with "A first post"
    Then I should see "Cannot merge with same or nonexistent article"
    And I should see "A first post"
    And I should see "A second post"
    When I follow "A first post"
    Then I should not see "Followed by the text in a similar blog post"

  Scenario: Cannot merge with nonexistent article
    Given I am logged into the admin panel
    And I visit the edit page for "A first post"
    And I attempt to merge with "Nonexistent post"
    Then I should see "Cannot merge with same or nonexistent article"

  Scenario: Merged article should contain text of both articles
    Given I am logged into the admin panel
    And I visit the edit page for "A first post"
    And I attempt to merge with "A second post"
    Then I should see "A first post"
    And I should not see "A second post"
    When I follow "A first post"
    Then I should see "The text in the first blog post."
    And I should see "Followed by the text in a similar blog post."