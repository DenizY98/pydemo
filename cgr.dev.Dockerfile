FROM cgr.dev/chainguard/python:latest-dev as builder

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt --user

#Second Image Build that simply copies installed files
FROM cgr.dev/chainguard/python:latest

WORKDIR /app

COPY --from=builder /home/nonroot/.local/lib/python3.12/site-packages /home/nonroot/.local/lib/python3.12/site-packages

COPY app.py ./

EXPOSE 8080

ENTRYPOINT [ "python", "/app/app.py" ]