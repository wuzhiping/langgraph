FROM langchain/langgraph-api:3.11

RUN apt-get update && \
    apt-get install -y vim wget curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install langgraph-cli "langgraph-cli[inmem]"

COPY ./agent.py /app/
COPY ./langgraph.json /app/

WORKDIR /app

ENTRYPOINT []

CMD langgraph dev --host 0.0.0.0
