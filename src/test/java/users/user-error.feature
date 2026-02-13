@regression @negative
Feature: Escenarios de Error - API Usuarios
  Como administrador, quiero validar que la API gestione correctamente las excepciones y retorne los mensajes de error adecuados.

  Background:
    Given url baseUrl
    And def dataGen = read('classpath:helpers/DataGenerator.js')

  @error_email
  Scenario: Error al registrar usuario con email ya existente
    # Registrar un usuario inicial exitosamente
    Given def payload = dataGen()
    And path 'usuarios'
    And request payload
    When method post
    Then status 201

    # Intento de registro con el mismo email para forzar error 400
    Given path 'usuarios'
    And request payload
    When method post
    Then status 400
    And match response.message == "Este email já está sendo usado"

  @error_id
  Scenario: Error al buscar un usuario con ID inexistente
    # Búsqueda con un ID de formato válido (16 caracteres) que no existe en la BD
    Given path 'usuarios', '0123456789abcdef'
    When method get
    Then status 400
    And match response.message == "Usuário não encontrado"

  @error_validation
  Scenario Outline: Validar campos obligatorios al registrar usuario - Faltante: <campo>
    Given path 'usuarios'
    And request <payload>
    When method post
    Then status 400
    And match response.<campo> == "<mensaje>"

    Examples:
      | campo         | mensaje                    | payload                                                                        |
      | email         | email é obrigatório        | { "nome": "Test", "password": "123", "administrador": "true" }                 |
      | password      | password é obrigatório     | { "nome": "Test", "email": "test@test.com", "administrador": "true" }          |
      | administrador | administrador é obrigatório | { "nome": "Test", "email": "test@test.com", "password": "123" }                |