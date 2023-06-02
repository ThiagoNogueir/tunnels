@echo off

REM Instalar o Python
msiexec /i https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe /qn

REM Instalar o ngrok
powershell -Command "Invoke-WebRequest -Uri https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-windows-amd64.zip -OutFile ngrok.zip"
powershell -Command "Expand-Archive -Path ngrok.zip -DestinationPath ."
del ngrok.zip

REM Solicitar autenticação no ngrok
set /p authtoken=Entre com sua autenticação no ngrok (se não tiver uma, acesse https://ngrok.com para criar uma): 
ngrok authtoken %authtoken%

REM Definir a porta do servidor HTTP
set /p porta=Porta do servidor local: 

REM Criar um arquivo Python para iniciar o servidor HTTP
echo import http.server >> servidor_http.py
echo import socketserver >> servidor_http.py
echo porta = %porta% >> servidor_http.py
echo Handler = http.server.SimpleHTTPRequestHandler >> servidor_http.py
echo with socketserver.TCPServer(("", porta), Handler) as httpd: >> servidor_http.py
echo     print(f"Servidor HTTP rodando na porta {porta}") >> servidor_http.py
echo     httpd.serve_forever() >> servidor_http.py

REM Executar o servidor HTTP
python servidor_http.py
