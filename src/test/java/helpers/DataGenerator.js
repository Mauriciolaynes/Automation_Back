function fn() {
    var randomId = Math.floor(Math.random() * 10000);
    return {
        nome: "Usuario " + randomId,
        email: "test_" + randomId + "@gmail.com",
        password: "password123",
        administrador: "true"
    };
}