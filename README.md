# huggingface-vpn
VPN powered by Hugging Face

[Ru]

Развертывание

1.1 Создайте Space на Hugging Face с типом SDK: Docker (Blank).

1.2 В настройках Space (Settings -> Variables and secrets) добавьте секрет:
   - Name: UUID
   - Value: ваш персональный ключ.
 
1.3 Загрузите Dockerfile в репозиторий Space.

1.4 Дождитесь завершения сборки.

Подключение

2.1 После завершения сборки и старта создайте ключ
    - Пример ключа:
vless://12345678-abcd-ef01-2345-6789abcdef01@your-space-name.hf.space:443?type=ws&encryption=none&security=tls&path=%2Fvless#HF_VPN
    - Где:
    - 12345678-abcd-ef01-2345-6789abcdef01, это ваш UUID
    - @your-space-name название Space в формате: @вашеимя-названиевашегоSpace
    
