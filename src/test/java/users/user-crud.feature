@regression
Feature: Gestión Dinámica de Usuarios en ServeRest

  Background:
    Given url baseUrl
    And def dataGen = read('classpath:helpers/DataGenerator.js')
    And def userSchema = read('classpath:schemas/user-schema.json')
    And def userRequestPath = 'classpath:requests/user-request.json'

  @registro @smoke
  Scenario Outline: Registrar y validar usuario perfil <perfil>
    Given path 'usuarios'
    And def payload = read(userRequestPath)
    And request payload
    When method post
    Then status 201
    And def userId = response._id

    Given path 'usuarios', userId
    When method get
    Then status 200
    And match response == userSchema
    And match response.nome == "<nome>"

    Given path 'usuarios', userId
    When method delete
    Then status 200

    Examples:
      | perfil   | nome                | email                  | password | administrador |
      | Admin    | Pedro Administrador | p_admin_2026@test.com  | pass123  | true          |
      | Regular  | Lucia Usuario       | l_user_2026@test.com   | pass456  | false         |
      | Soporte  | Tech Support        | support_2026@test.com  | pass000  | true          |

  @Flujo
  Scenario: Ciclo de vida completo (CRUD) con datos aleatorios
    #Crear
    Given path 'usuarios'
    And def payload = dataGen()
    And request payload
    When method post
    Then status 201
    And def userId = response._id
    #Buscar id
    Given path 'usuarios', userId
    When method get
    Then status 200
    And match response == userSchema
    #Actualizar
    Given path 'usuarios', userId
    And request { nome: "Editado", email: "#(payload.email)", password: "123", administrador: "true" }
    When method put
    Then status 200
    #Eliminar
    Given path 'usuarios', userId
    When method delete
    Then status 200


  @buscar
  Scenario: Buscar usuario por ID y validar contrato

    # llamamos al escenario reutilizable
    * def result = call read('classpath:helpers/user-logic.feature') { userPayload: '#(dataGen())' }

    # Extraemos el ID del resultado de la llamada
    * def userId = result.response._id

    # Ejecutamos la validación del escenario (Buscar por ID)
    Given path 'usuarios', userId
    When method get
    Then status 200
    And match response == userSchema

  @listar
  Scenario: Listar todos los usuarios registrados
    Given path 'usuarios'
    When method get
    Then status 200
    And match response.usuarios == '#[]'
    And match response.quantidade == '#number'

  @actualizar
  Scenario: Actualizar información de un usuario
    #Crear
    Given path 'usuarios'
    And def payload = dataGen()
    And request payload
    When method post
    Then status 201
    And def userId = response._id
    #Actualizar
    Given path 'usuarios', userId
    And request { nome: "Nombre Editado", email: "#(payload.email)", password: "new", administrador: "true" }
    When method put
    Then status 200
    And match response.message == "Registro alterado com sucesso"

  @eliminar
  Scenario: Eliminar un usuario del sistema
    #Crear
    Given path 'usuarios'
    And def payload = dataGen()
    And request payload
    When method post
    Then status 201
    And def userId = response._id
    #Eliminar
    Given path 'usuarios', userId
    When method delete
    Then status 200
    And match response.message == "Registro excluído com sucesso"