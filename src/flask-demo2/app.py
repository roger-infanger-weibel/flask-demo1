from flask import Flask, render_template, jsonify

app = Flask(__name__)

# Hardcoded table data
data_table = [
    {"id": 1, "name": "John Doe", "age": 28, "score": 85, "status": "Active"},
    {"id": 2, "name": "Jane Smith", "age": 34, "score": 92, "status": "Inactive"},
    {"id": 3, "name": "Sam Brown", "age": 22, "score": 74, "status": "Active"},
    {"id": 4, "name": "Emily White", "age": 29, "score": 88, "status": "Active"},
]

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/data')
def data():
    return jsonify(data_table)

if __name__ == "__main__":
    app.run(debug=True)