#!/bin/bash
exec streamlit run app/frontend.py --server.port $PORT --server.address 0.0.0.0 --server.headless true
