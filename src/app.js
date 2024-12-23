const express = require('express');

const app = express();

app.get('/', (req, res) => {
    res.send('¡Hola, está funcionando el ejercicio número 2');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor ejecutándose en el puerto ${PORT}`);
});

module.exports = app;
