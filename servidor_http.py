import http.server 
import socketserver 
porta = 8080 
Handler = http.server.SimpleHTTPRequestHandler 
with socketserver.TCPServer(("", porta), Handler) as httpd: 
    print(f"Servidor HTTP rodando na porta {porta}") 
    httpd.serve_forever() 
