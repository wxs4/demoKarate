Feature: plan de pruebas orientado a graphQL

  @scenario
  Scenario: servicio GraphQL
    Given url 'https://rickandmortyapi.com/graphql'
    When text query =
    """
    query {
    character(id:5)
    {name,
    status,
    species,
    gender}
    }
    """
    And request {query:'#(query)'}
    And method POST
    And match response.data.character.gender == 'Male'
    And status 200
    And print response

  @casoScenarioOutline
  Scenario Outline: :servicio GraphQL<testCase>
    Given url 'https://rickandmortyapi.com/graphql'
    When text query =
    """
    query {
    character(id:<id>)
    {name,
    status,
    species,
    gender}
    }
    """
    And request {query:'#(query)'}
    And method POST  #And match response.data.character.gender == 'Male'
    And status 200
    And print response
    Examples:
      | testCase | id |
      | id 1     | 1  |
      | id 5     | 5  |
      | id 6     | 6  |
      | id 10    | 10 |
      | id 50    | 50 |
      | id 45    | 45 |

  @callFileTxt
  Scenario Outline: servicio GraphQL<testCase>
    Given url 'https://rickandmortyapi.com/graphql'
    When def query = read('classpath:req/fileGraphQL.txt')
    And replace query.id = <id>
    And request {query:'#(query)'}
    And method POST
    #And match response.data.character.gender == 'Male'
    And status 200
    And print response
    Examples:
      | testCase | id |
      | id 1     | 1  |
      | id 5     | 5  |
      | id 6     | 6  |