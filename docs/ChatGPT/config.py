# config.py
import os

# Read the API key from an environment variable
API_KEY = os.getenv("OPENAI_API_KEY")

if not API_KEY:
    raise ValueError("OPENAI_API_KEY environment variable not set.")
