from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify(message="Application is running successfully!"), 200

@app.route('/healthz')
def health():
    # Health check endpoint for Kubernetes liveness/readiness probes
    return jsonify(status="healthy"), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)