"""
file name: app.py
Description: Building a ChatGPT Clone with Flask framework
__copyright__ = "Copyright 2024, MartinYTech, Jing Hua Zhao"
__author__=  Jing Hua Zhao
__modified__= 05/12/2024
"""

from flask import Flask, request, render_template
import openai
import config

# Set the OpenAI API key
openai.api_key = config.API_KEY

app = Flask(__name__)

# Store conversation history for context
conversation_history = []

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/get")
def get_bot_response():
    # Get the user message from the request
    userText = request.args.get('msg')

    # Define the model to use
    model_engine = "gpt-3.5-turbo"

    # Append user message to conversation history
    conversation_history.append({"role": "user", "content": userText})

    # Get the response from OpenAI's model
    response = openai.ChatCompletion.create(
        model=model_engine,
        messages=conversation_history
    )

    # Extract the assistant's response from the response object
    ai_response = response['choices'][0]['message']['content']

    # Append AI response to conversation history
    conversation_history.append({"role": "assistant", "content": ai_response})

    return ai_response

if __name__ == "__main__":
    app.run(debug=True)
