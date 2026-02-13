@ignore
Feature: Lógica reusable para Usuarios

  Scenario: Crear Usuario
    Given url baseUrl + '/usuarios'
    And request userPayload
    When method post
    Then status 201