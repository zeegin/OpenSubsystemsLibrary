Scenario: First start

    Given none user in infobase
    And nor in catalog "User"
    When I start infobase
    Then System create a "<Not specified>" user in catalog "User"
    And set it attribute "Service" to "True"
    And set it attribute "_UUID" to "aa00559e-ad84-4494-88fd-f0826edc46f0"
    And assign it to session parameter "CurrentUser"

Scenario: Second start

    Given None user in infobase 
    And default user in catalog "User"
    When I start infobase
    Then System assign "<Not specified>" to session parameter "CurrentUser"

Scenario: Added user in Designer

    Given I add user with name "Peter" in infobase
    And none in catalog "User"
    When I start infobase
    Then System create a "Peter" user in catalog "User"
    And set it attribute "Service" to "False"
    And set it attribute "_UUID" to UUID from infobase user
    And assign it to session parameter "CurrentUser"
