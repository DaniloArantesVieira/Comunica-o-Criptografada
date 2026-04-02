# SecureLink

Projeto de laboratório voltado para **comunicação segura entre cliente e servidor**, utilizando componentes de **criptografia**, **certificados digitais** e **orquestração com Docker Compose**.

Pela estrutura do projeto, o fluxo parece combinar:
- uma **CA (Certificate Authority)** para inicialização e emissão de certificados;
- um **servidor** e um ou mais **clientes** com arquivos de configuração próprios;
- uma aplicação em Python responsável pela troca de mensagens;
- módulos criptográficos separados para **ECDH**, **ChaCha20** e **KDF**.

## Estrutura do projeto

```text
securelink/
├─ README.md
├─ docker-compose.yml
├─ app/
│  ├─ Dockerfile
│  ├─ requirements.txt
│  ├─ message_client.py
│  ├─ message_server.py
│  └─ crypto/
│     ├─ chacha20.py
│     ├─ ecdh.py
│     └─ kdf.py
├─ ca/
│  ├─ Dockerfile
│  ├─ openssl.cnf
│  └─ scripts/
│     ├─ init_ca.sh
│     └─ issue_cert.sh
├─ client/
│  ├─ Dockerfile
│  ├─ client.conf
│  └─ scripts/
│     └─ entrypoint.sh
└─ server/
   ├─ Dockerfile
   ├─ server.conf
   └─ scripts/
      └─ entrypoint.sh
```

## Objetivo

Este projeto tem como foco o estudo de conceitos importantes de segurança, como:
- estabelecimento de segredo compartilhado;
- derivação de chaves criptográficas;
- cifragem de mensagens;
- uso de certificados para autenticação;
- separação entre infraestrutura, aplicação e scripts de inicialização.

É uma boa base para laboratórios acadêmicos de:
- criptografia aplicada;
- segurança de redes;
- autenticação mútua;
- comunicação segura em ambientes distribuídos.

## Componentes principais

### `app/`
Contém a aplicação principal escrita em Python.

Arquivos esperados:
- `message_client.py`: lógica do lado cliente para envio/recebimento de mensagens.
- `message_server.py`: lógica do lado servidor.
- `requirements.txt`: dependências Python da aplicação.
- `crypto/`: módulos criptográficos separados por responsabilidade.

### `app/crypto/`
Separa os algoritmos e utilitários criptográficos.

- `ecdh.py`: provavelmente responsável pela troca de chaves usando ECDH.
- `kdf.py`: provável derivação de chaves a partir de material compartilhado.
- `chacha20.py`: provável cifragem/decifragem simétrica das mensagens.

Essa divisão é muito boa para manutenção e deixa o projeto mais modular.

### `ca/`
Responsável pela autoridade certificadora.

- `openssl.cnf`: configuração do OpenSSL.
- `scripts/init_ca.sh`: inicialização da CA.
- `scripts/issue_cert.sh`: emissão de certificados para os componentes.

### `client/` e `server/`
Contêm os arquivos específicos de execução de cada ponta da comunicação.

- `Dockerfile`: imagem de cada serviço.
- `*.conf`: configurações específicas.
- `scripts/entrypoint.sh`: scripts de entrada para inicialização automatizada.

### `docker-compose.yml`
Arquivo de orquestração dos containers do ambiente. Deve ser o ponto principal para subir toda a solução.

## Requisitos

Para executar o projeto, normalmente você precisará de:
- Docker
- Docker Compose
- Python 3.10+ (caso queira executar a aplicação manualmente fora dos containers)
- OpenSSL (dependendo do ambiente e da forma de execução)

## Execução

Como o projeto possui `docker-compose.yml`, a forma mais provável de execução é:

```bash
docker compose up --build
```

Ou, em ambientes mais antigos:

```bash
docker-compose up --build
```

## Fluxo esperado do laboratório

De forma geral, o projeto parece seguir este fluxo:
1. a CA é inicializada;
2. certificados são gerados/assinados;
3. cliente e servidor sobem com suas configurações;
4. a aplicação estabelece o acordo de chaves;
5. a chave derivada é utilizada para proteger as mensagens trocadas.

## Pontos fortes da estrutura

- Boa separação entre **aplicação**, **infraestrutura** e **certificação**.
- Módulos criptográficos isolados em pasta própria.
- Uso de scripts de entrada para automatizar o ambiente.
- Estrutura consistente para laboratório e apresentação acadêmica.
- Facilidade para evoluir o projeto futuramente.

## Melhorias sugeridas

Algumas melhorias que deixariam o repositório ainda mais profissional:

- adicionar um `.gitignore` na raiz;
- incluir uma seção com **arquitetura do sistema**;
- documentar as portas e serviços expostos;
- adicionar instruções detalhadas de geração e armazenamento de certificados;
- incluir exemplos de execução esperada e logs de sucesso;
- criar uma pasta `docs/` para diagramas e imagens;
- explicar no README como cada módulo criptográfico participa do fluxo.

## Exemplo de expansão futura

Uma estrutura futura poderia ficar assim:

```text
securelink/
├─ README.md
├─ docker-compose.yml
├─ .gitignore
├─ docs/
│  └─ arquitetura.png
├─ app/
├─ ca/
├─ client/
└─ server/
```

## Observação

Este README foi montado com base na **estrutura real de arquivos do projeto**. Como o conteúdo interno dos arquivos não foi inspecionado aqui, algumas descrições foram inferidas a partir dos nomes e organização das pastas.
