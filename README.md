# Visão Geral

Este é um projeto completo de API REST em Java construído com o framework Javalin, implementando uma arquitetura limpa e modular. A aplicação fornece quatro endpoints principais com testes abrangentes e segue as melhores práticas para APIs REST prontas para produção. O projeto demonstra separação adequada de responsabilidades com classes handler, testes extensivos com JUnit e estrutura de projeto Maven apropriada.

# Preferências do Usuário

Estilo de comunicação preferido: Linguagem simples e cotidiana.

# Arquitetura do Sistema

## Endpoints da API

### Endpoints Básicos
- **GET /hello**: Retorna resposta de texto simples "Hello, Javalin!"
- **GET /status**: Retorna JSON com status "ok" e timestamp ISO-8601 atual
- **POST /echo**: Aceita JSON com chave "mensagem" e ecoa de volta
- **GET /saudacao/{nome}**: Retorna saudação personalizada em português usando parâmetro de caminho

### Endpoints CRUD de Mensalista (Rubrica 4)
- **GET /mensalistas**: Retorna array de todos os objetos Mensalista (200 OK)
- **GET /mensalista/{matricula}**: Retorna Mensalista específico por matrícula (200 OK ou 404 Not Found)
- **POST /mensalista**: Cria novo Mensalista com validação
  - **Validações**:
    - Nome deve ter pelo menos 3 caracteres → 400 Bad Request
    - Matrícula deve ser alfanumérica → 400 Bad Request  
    - Matrícula deve ser única → 409 Conflict
  - **Sucesso**: Retorna 201 Created com JSON do Mensalista

## Arquitetura Baseada em Handlers
Cada endpoint é tratado por classes handler dedicadas:

- **StatusHandler**: Gerencia endpoint de status com geração de timestamp
- **EchoHandler**: Processa requisições de eco com validação de JSON e tratamento de erros  
- **GreetingHandler**: Cria saudações personalizadas usando parâmetros de caminho
- **MensalistaHandler**: Gerencia operações CRUD para entidade Mensalista

## Estratégia de Testes
O projeto implementa testes unitários abrangentes para todos os handlers usando o framework JUnit. Cada handler possui classes de teste dedicadas que verificam funcionalidade isoladamente, garantindo comportamento confiável e tornando a refatoração mais segura.

## Sistema de Build
Usa Maven como ferramenta de build, indicado pela estrutura de diretórios target e relatórios de teste Surefire. Isso fornece gerenciamento padronizado de dependências, compilação e fluxos de trabalho de teste.

## Benefícios Arquiteturais
- **Modularidade**: Cada handler é responsável por um domínio específico de funcionalidade
- **Testabilidade**: Separação clara permite testes unitários focados
- **Manutenibilidade**: Estrutura simples torna a base de código fácil de entender e modificar
- **Escalabilidade**: Novos handlers podem ser adicionados sem afetar os existentes

# Dependências Externas

## Framework Web
- **Javalin 5.6.3**: Framework web leve para construção de APIs REST
- **Jackson**: Biblioteca de processamento JSON para serialização de requisições/respostas
- **SLF4J**: Framework de logging com implementação de logger simples

## Framework de Testes  
- **JUnit 5**: Framework moderno de testes unitários com asserções abrangentes
- **Mockito**: Framework de mock para testes unitários isolados
- **Javalin TestTools**: Utilitários de teste de integração para endpoints HTTP
- **OkHttp**: Biblioteca cliente HTTP para teste de endpoints

## Ferramentas de Build
- **Maven**: Ciclo de vida de build do projeto, gerenciamento de dependências e execução de testes
- **Maven Surefire**: Execução e relatórios de testes
- **Exec Plugin**: Execução de aplicação durante desenvolvimento

## Status Atual
- Servidor rodando na porta 5000 (compatível com webview)
- ✅ **Rubrica 1**: API Javalin completa com endpoints básicos
- ✅ **Rubrica 2**: Suite de testes JUnit abrangente (10 casos de teste aprovados)
- ✅ **Rubrica 3**: Projeto cliente REST com HttpURLConnection
- ✅ **Rubrica 4**: Operações CRUD completas com validação
  - Nome mínimo 3 caracteres (retorna 400)
  - Validação de matrícula alfanumérica (retorna 400)
  - Detecção de matrícula duplicada (retorna 409)
  - Códigos de status HTTP apropriados (200, 201, 404, 409, 400)
- Documentação completa da API com exemplos curl
- Tratamento de erros e validação JSON prontos para produção
- Projeto cliente REST no diretório `client/`
  - 4 clientes HTTP usando HttpURLConnection
  - Menu interativo para testar todos os endpoints
  - Scripts de teste automatizados disponíveis

## Projeto Cliente REST (Rubrica 3)
Localizado no diretório `client/` - projeto Maven separado para consumir a API:

### Classes Cliente
- **PostMensalistaClient**: Cria novo Mensalista via POST /mensalista
- **GetMensalistasClient**: Lista todos os Mensalistas via GET /mensalistas  
- **GetMensalistaPorMatriculaClient**: Obtém Mensalista por matrícula via GET /mensalista/{matricula}
- **GetStatusClient**: Verifica status da API via GET /status
- **Main**: Menu interativo para testar todos os clientes

### Como Executar os Clientes
- Executar todos os testes: `./client/test-all.sh`
- Executar cliente individual: `java -cp client/target/classes:$HOME/.m2/repository/com/google/code/gson/gson/2.10.1/gson-2.10.1.jar client.GetStatusClient`
- Menu interativo: Usar exec-maven-plugin ou executar classe Main diretamente
