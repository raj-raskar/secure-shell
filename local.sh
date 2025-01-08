#!/bin/bash
ngrok http https://localhost:9000 --app-protocol=http2 > /dev/null 2>&1 &
NGROK_PID=$!
echo "Ngrok Started."
./wstunnel server wss://127.0.0.1:9000 > /dev/null 2>&1 &
WST_PID=$!
echo "Wstunnel Started."
echo "Please Wait."
sleep 5
WEBHOOK_URL=$(curl -s http://localhost:4040/api/tunnels | jq ".tunnels[0].public_url")
echo "Webhook URL: $WEBHOOK_URL"
trap "kill -s SIGKILL $NGROK_PID; echo 'Ngrok Stopped.';kill -s SIGKILL $WST_PID; echo 'Wstunnel Stopped.';exit" SIGINT
while true; do sleep 5; done
