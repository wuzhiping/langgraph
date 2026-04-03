FROM langchain/langgraph-api:3.11

RUN apt-get update && \
    apt-get install -y vim wget curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install langgraph-cli "langgraph-cli[inmem]"

RUN pip install deepagents langchain-openai

RUN pip install jupyterlab temporalio

RUN pip install nats-py

COPY ./agents/deep.py /app/agents/deep.py
COPY ./langgraph.json /app/

WORKDIR /app

ENV OPENAI_API_KEY=sk-k5UlvstW5kP4G0jd7rK1cZ
ENV OPENAI_BASE_URL=http://litellm.feg.cn/v1

ENTRYPOINT []

CMD langgraph dev --no-browser --allow-blocking --host 0.0.0.0 --port 2024 --n-jobs-per-worker 10  & jupyter lab --allow-root --ip=0.0.0.0 --NotebookApp.token=12345678
