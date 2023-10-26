import math
import time
from flask import Flask, request

app = Flask(__name__)
@app.route("/")
def home():
    return "Hello, World!"
@app.route('/test')
def test():
    a = int(request.args.get('a',1))
    b = int(request.args.get('b',1))
    start_time = time.time()
    c = math.pow(a,b)
    execution_time = time.time() - start_time
    return f'Execution time : {execution_time/1000} ms\n'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
