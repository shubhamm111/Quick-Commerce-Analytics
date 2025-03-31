from flask import Flask, render_template, request, jsonify
import pandas as pd
import os

app = Flask(__name__)

# Define the folder where pre-saved query results are stored
RESULTS_FOLDER = "results"  # Changed from 'static/results' to just 'results'

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/get_results", methods=["POST"])
def get_results():
    data = request.get_json()
    query_name = data.get("query")

    if not query_name:
        return jsonify({"error": "No query selected"})

    file_path = os.path.join(RESULTS_FOLDER, f"{query_name}.csv")

    if not os.path.exists(file_path):
        return jsonify({"error": f"Query result '{query_name}' not found"})

    try:
        df = pd.read_csv(file_path)

        # Ensure all numerical columns are rounded to 2 decimal places
        for col in df.select_dtypes(include=['float64', 'int64']).columns:
            df[col] = df[col].round(2)

        return jsonify({"columns": df.columns.tolist(), "rows": df.values.tolist()})
    except Exception as e:
        return jsonify({"error": str(e)})


if __name__ == "__main__":
    app.run(debug=True)
