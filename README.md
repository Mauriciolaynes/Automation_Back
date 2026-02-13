# 🚀 Reto de Automatización: API ServeRest (Back-End)

Este proyecto contiene una suite de pruebas automatizadas para la API de Usuarios de ServeRest utilizando Karate DSL. Valida la gestión integral de usuarios y asegura la integridad de los datos mediante un enfoque dinámico y atómico.

## 🎯 Objetivo del Proyecto
Garantizar el correcto funcionamiento de los endpoints de la API de Usuarios, cumpliendo con los criterios de aceptación del administrador y asegurando la estabilidad del sistema ante pruebas de regresión.



## 🛠️ Tecnologías y Herramientas
- ⚙️ Framework: Karate DSL
- 💻 Lenguaje: Java / JavaScript
- 📦 Gestor de Dependencias: Maven
- 🏗️ IDE: IntelliJ IDEA

## 📂 Estructura del Proyecto
- 📂 src/test/java/helpers/: Utilidades para la generación de datos aleatorios con DataGenerator.js
- 📂 src/test/java/requests/: Plantillas JSON externas para peticiones dinámicas parametrizadas
- 📂 src/test/java/schemas/: Archivos JSON para la validación de esquemas y contratos de API
- 📂 src/test/java/users/: Archivos .feature con escenarios organizados por tags y el Runner de JUnit
- 📄 karate-config.js: Configuración global de la URL base y gestión de entornos



## 📝 Escenarios Implementados
- ✅ CRUD Atómico (@Flujo): Escenarios independientes para Crear, Leer, Actualizar y Eliminar
- ✅ Registro Dinámico (@smoke): Uso de Scenario Outlines para validar múltiples perfiles de usuario
- ❌ Casos Negativos (@negative): Validación de email duplicado, ID inexistente y campos obligatorios
- ✅ Regresion de todos los test (@regression)

## 🚀 Ejecución
1. Abrir terminal en la raíz del proyecto.
2. Ejecutar el comando: mvn test (puedes usar -Dkarate.options="--tags @smoke" para filtros).
3. Ver el reporte detallado en: target/karate-reports/karate-summary.html.
