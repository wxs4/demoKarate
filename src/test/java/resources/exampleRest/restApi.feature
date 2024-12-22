@consultasRest
Feature: consulta con metodo get

  @consultaGet
  Scenario: consulta get
    Given url 'https://reqres.in/api/users/2'
    When method GET
    And match response.data.first_name == "#string"
    Then status 200

  @consultaPost1
  Scenario: caso de tipo post #1
    Given url 'https://reqres.in/api/users'
    When request {"name": "William","job": "Sanchez"}
    And method POST
    And print response
    Then status 201

  @consultaPost2
  Scenario: caso de tipo post #2
    Given url 'https://reqres.in/api/users'
    When request
    """
    {
    "name": "Marina",
    "job": "Gold"
    }
    """
    And method POST
    And print response
    Then status 201

  @consultaDelete
  Scenario: caso de tipo delete
    Given url 'https://reqres.in/api/users/2'
    When method DELETE
    Then status 204

  @getSO
  Scenario Outline: get scenario outline <nombre>
    Given url 'https://reqres.in/api/users/<id>'
    And configure connectTimeout = 12000
    And configure readTimeout = 12000
    When method GET
  #And match response.data.first_name == "#string"
    Then status <status>
    And print response

    Examples:
      | nombre | id | status |
      | Exito  | 1  | 200    |
      | Exito  | 2  | 200    |
      | Exito  | 3  | 200    |
      | fail   | 50 | 404    |

  @postSO
  Scenario Outline: post scenario outline <casoName>
    Given url 'https://reqres.in/api/users'
    When request {"name": "<name>","job": "<job>"}
    And method POST
    And print response
    Then status 201

    Examples:
      | casoName | name    | job     |
      | Ok 200   | William | Sanchez |
      | ok 200   | Marina  | Gold    |
      | ok 200   | Nacho   | Vidal   |
      | ok 200   | Jhony   | Sims    |

  @readCSV
  Scenario Outline: caso para post <casoName>
    Given url 'https://reqres.in/api/users'
    When request {"name": "<name>","job": "<job>"}
    And method POST
    And print response
    Then status 201

    Examples:
      | karate.read('classpath:req/fileRest.csv') |

  @readJSON
  Scenario Outline: caso para post <casoName>
    Given url 'https://reqres.in/api/users'
    When def body = read('classpath:req/fileJson.json')
    And request body
    And method POST
    And print response
    Then status 201

    Examples:
      | casoName | name    | job     |
      | Ok 200   | William | Sanchez |
      | ok 200   | Marina  | Gold    |
      | ok 200   | Nacho   |         |
      | ok 200   |         | Sims    |

  @bearerToken
  Scenario: Bearer Token
    Given url 'https://api.github.com/user/repos'
    When header Authorization = 'bearer token'
    And method GET
    Then status 200

  @basicToken
  Scenario: Basic Token
    Given url 'https://postman-echo.com/basic-auth'
    When header Authorization = call read('classpath:util/token.js') {username : 'postman', password : 'password'}
    And method GET
    Then status 200