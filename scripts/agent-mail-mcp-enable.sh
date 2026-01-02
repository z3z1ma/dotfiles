# set -Ux INTEGRATION_BEARER_TOKEN (openssl rand -hex 32)
if [ -z "$INTEGRATION_BEARER_TOKEN" ]; then
  echo "INTEGRATION_BEARER_TOKEN is not set. Please set it before running this script."
  exit 1
fi
SERVER_UP=$(curl -s -o /dev/null -w "%{http_code}" \
  -H "Authorization: Bearer $INTEGRATION_BEARER_TOKEN" \
  http://localhost:8765/health/readiness)
if [ "$SERVER_UP" -ne 200 ]; then
  echo "Server is down. Exiting. Please use 'am' alias in fish to start the server."
  exit 1
fi
claude mcp add --transport http -s user mcp-agent-mail 'http://127.0.0.1:8765/mcp/' -H "Authorization: $INTEGRATION_BEARER_TOKEN"
