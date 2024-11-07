#!/bin/bash
fastapi run /application/application/src/create_service.py --port 8000
#streamlit run /application/application/src/create_app.py --server.port=8080 --server.enableWebsocketCompression=false --server.enableCORS=false --server.headless=true