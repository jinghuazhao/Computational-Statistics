# ChatGPT under Flask

As ususal, this is furnished with [`app.py`](app.py) and [`config.py`](config.py) with [`templates`](templates) in its simplest form.

```
Flask/
├── app.py
├── config.py
├── README.md (this file)
└── templates
    └── index.html
```

which uses environment variable from `export OPENAI_API_KEY=$(grep sk ~/doc/OpenAI)`.

By default, `python app.py` will enable `http://127.0.0.1:5000`:

```
$ python app.py
 * Serving Flask app 'app'
 * Debug mode: on
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on http://127.0.0.1:5000
Press CTRL+C to quit
 * Restarting with watchdog (inotify)
 * Debugger is active!
 * Debugger PIN: 711-120-470
127.0.0.1 - - [05/Dec/2024 21:48:34] "GET / HTTP/1.1" 200 -
127.0.0.1 - - [05/Dec/2024 21:48:34] "GET / HTTP/1.1" 200 -
```

Considerable coverage has been given on Flask, e.g., <https://cambridge-ceu.github.io/GitHub-matters/Flask/>, and WSGI is touched upon here, <https://cambridge-ceu.github.io/CEU-scientific-meetings/Flask/>.
