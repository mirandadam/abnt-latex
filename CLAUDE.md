# CLAUDE.md

## Python

- Sempre usar virtualenv na pasta do projeto antes de instalar pacotes com pip.
- Nome do virtualenv: `.venv`
- Gerenciamento de pacotes: apenas `pip` + `venv` (sem poetry, uv, etc.)
- Usar a versão do Python que estiver instalada no sistema.
- Ativar o venv com `source .venv/Scripts/activate` (Windows/Git Bash).

## Perguntas

Quando o usuário solicitar que você faça perguntas:

- Faça perguntas para obter decisões chave sobre o assunto e esclarecer detalhes.
- Faça até 3 perguntas por rodada. O questionamento pode durar várias rodadas.
- Escolha perguntas que produzam o máximo de decisão/esclarecimento sobre o assunto minimizando o trabalho do usuário ("maximize steering per user input").
