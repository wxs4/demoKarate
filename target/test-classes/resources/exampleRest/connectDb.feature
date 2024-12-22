@connectBd
Feature: Conexion a base de datos

  Background:
    And def config = {username: 'root', password: '', url: 'jdbc:mysql://localhost:3306/northwind', driverClassName: 'com.mysql.cj.jdbc.Driver'}
    And def DBUtils = Java.type('util.DbUtils')
    And def db = new DBUtils(config)

  Scenario: Consultar tabla usuarios
    And def usuarios = db.readRows('SELECT * FROM customers')
    Then print 'Usuarios:', usuarios