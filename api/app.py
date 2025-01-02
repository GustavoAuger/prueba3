from flask import Flask, jsonify

app = Flask(__name__)

# Ruta para devolver "Hola Mundo"
@app.route("/saludar", methods=["GET"])
def saludar():
    return jsonify({"mensaje": "Hola Mundo"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)

