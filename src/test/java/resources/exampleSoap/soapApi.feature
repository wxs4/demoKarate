@consultaSoap
Feature: plan de prueba orientado a consultas soap

  @consultaSoap
  Scenario: consulta soap
    Given url 'https://www.dataaccess.com/webservicesserver/NumberConversion.wso'
    When header Content-Type = 'text/xml'
    And request
    """
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <NumberToWords xmlns="http://www.dataaccess.com/webservicesserver/">
      <ubiNum>800</ubiNum>
    </NumberToWords>
  </soap:Body>
</soap:Envelope>
     """
    And method POST
    And match response/Envelope/Body/NumberToWordsResponse/NumberToWordsResult == 'eight hundred '
    Then status 200
    And print response

  @soapSO
  Scenario Outline: consulta soap con scenario Outline<testCase>
    Given url 'https://www.dataaccess.com/webservicesserver/NumberConversion.wso'
    When header Content-Type = 'text/xml'
    And request
    """
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <NumberToWords xmlns="http://www.dataaccess.com/webservicesserver/">
      <ubiNum><num></ubiNum>
    </NumberToWords>
  </soap:Body>
</soap:Envelope>
     """
    And method POST
    And match response/Envelope/Body/NumberToWordsResponse/NumberToWordsResult == '<assertion> '
    Then status <status>
    And print response
    Examples:
      | testCase               | num | status | assertion   |
      | caso 200               | 200 | 200    | two hundred |
      | caso 50                | 50  | 200    | fifty       |
      | ecaso 11               | 11  | 200    | eleven      |
      | valida si es string    | 11  | 200    | #string     |
      | valida si es un numero | 40  | 200    | #number     |
      | valida si es un objeto | 10  | 200    | #object     |

  @callToFileXML
  Scenario Outline: consulta soap <testCase>
    Given url 'https://www.dataaccess.com/webservicesserver/NumberConversion.wso'
    When header Content-Type = 'text/xml'
    And def body = read('classpath:req/fileXML.xml')
    And request body
    And method POST
    And match response/Envelope/Body/NumberToWordsResponse/NumberToWordsResult == '<assertion> '
    Then status <status>
    And print response
    Examples:
      | testCase               | num | status | assertion   |
      | caso 200               | 200 | 200    | two hundred |
      | caso 50                | 50  | 200    | fifty       |
      | ecaso 11               | 11  | 200    | eleven      |
