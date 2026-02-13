function fn() {
    var env = karate.env;

    if (!env) {
        env = 'dev';
    }

    var config = {
        env: env,
        baseUrl: 'https://serverest.dev'
    };

    // 4. Configuración global de tiempos de respuesta (timeouts)
    karate.configure('connectTimeout', 5000);
    karate.configure('readTimeout', 5000);

    return config;
}