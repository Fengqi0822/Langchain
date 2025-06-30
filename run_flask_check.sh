#!/bin/bash

# 1. 先杀掉所有占用8001端口的进程
echo "🔍 查找占用 8001 端口的进程..."
PID=$(lsof -ti tcp:8001)
if [ -n "$PID" ]; then
  echo "⚠️ 发现进程 $PID 占用 8001，正在杀掉..."
  kill -9 $PID
else
  echo "✅ 8001 端口空闲"
fi

# 2. 启动 Flask 服务（你可以改成你的api.py路径）
echo "🚀 启动 Flask 服务..."
/Users/yufengqi/Downloads/PythonProject2/.venv/bin/python /Users/yufengqi/Downloads/PythonProject2/api.py &

# 3. 等待1秒让服务起来
sleep 1

# 4. 检查8001端口监听情况
echo "🔍 检查 8001 监听状态..."
lsof -iTCP:8001 -sTCP:LISTEN

echo "✅ Flask 服务已启动，监听 8001 端口！"
echo "🎉 现在可以从 Windows curl http://10.89.207.134:8001/api/token_event 试试看！"
