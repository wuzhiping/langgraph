from deepagents import create_deep_agent
from langchain.agents import create_agent

from langgraph.graph import StateGraph,END

from langchain_core.runnables import RunnableConfig

from langchain.chat_models import init_chat_model

from langchain.tools import tool
@tool
def getWeather(city: str) -> str:
    """
    查询某地今日天气
    args:
        city:城市
    """
    return f"{city}今日天气晴朗，温度：10-20"

def make_agent(config: RunnableConfig):

    cfg = config.get("configurable", {})
    state = config.get("state", {})
    thinking_enabled = cfg.get("thinking_enabled", True)
    system_prompt = cfg.get("system_prompt", None)

    llm = init_chat_model(
        'openai:kimi-k2-0711-preview', #'openai:Qwen/Qwen2.5-VL-32B-Instruct' ,
        streaming=True,
        stream_usage=True
    )
    return create_deep_agent(model = llm,tools=[getWeather],system_prompt=system_prompt)
