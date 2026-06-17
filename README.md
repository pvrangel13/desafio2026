# Desafio DevOps 2026

## Sobre o projeto

Este projeto foi desenvolvido para atender aos requisitos do desafio DevOps 2026.

A proposta foi criar duas aplicações simples utilizando tecnologias diferentes, executando em Kubernetes e com uma forma fácil de provisionar todo o ambiente.

Optei por utilizar um cluster local com Kind para simplificar a execução e permitir que qualquer pessoa consiga reproduzir o ambiente rapidamente.

---

# Tecnologias utilizadas

* Bash
* YAML
* Kind
* Kubernetes
* NGINX
* PHP + Apache


---

# Aplicações

## Aplicação 1 - NGINX

Aplicação responsável por retornar um texto fixo.

Exemplo de retorno:

```html
Olá, Mundo!
```

---

## Aplicação 2 - PHP

Aplicação responsável por retornar a data e hora atual do servidor.

Exemplo de retorno:

```text
2026-06-17 17:00:00
```

O timezone foi configurado para:

```text
America/Sao_Paulo
```

---

# Arquitetura

```text
                 Usuário
                    |
        -------------------------
        |                       |
        |                       |
   Service                 Service
  NodePort                NodePort
        |                       |
        |                       |
 Deployment               Deployment
    NGINX                 PHP/Apache
(Texto Fixo)           (Hora Atual)

                Kind Cluster
                 Kubernetes
```

---

# Estrutura do projeto

```text
.
├── infra-cluster.sh
├── cluster.yaml
├── manifests
│   ├── deployment-nginx.yaml
│   ├── deployment-php.yaml
│   ├── service-nginx.yaml
│   └── service-php.yaml
└── README.md
```

---

# Como executar

Todo o ambiente pode ser criado com apenas um comando:

```bash
./infra-cluster.sh
```

O script realiza:

* Criação do cluster Kind.
* Aplicação dos manifestos Kubernetes.
* Criação das aplicações.
* Criação dos Services para acesso externo.

---

# Validando o ambiente

Verificar Deployments:

```bash
kubectl get deployments
```

Verificar Pods:

```bash
kubectl get pods
```

Verificar Services:

```bash
kubectl get svc
```

---

# Acessando as aplicações

Aplicação NGINX:

```text
http://IP_DO_NODE:30922
```

Aplicação PHP:

```text
http://IP_DO_NODE:31878/index.php
```

---

# Fluxo de atualização

Atualmente qualquer alteração nas aplicações ou manifestos segue o fluxo abaixo:

```text
Alteração do código ou manifesto
                |
                v
             Git
                |
                v
      Atualização dos manifestos
                |
                v
        kubectl apply
                |
                v
          Deployments
                |
                v
             Novos Pods
```

---

## Cache

O desafio solicita uma camada de cache com tempos diferentes para cada aplicação.

Durante o desenvolvimento optei por utilizar imagens Docker prontas (NGINX e PHP/Apache), realizando apenas as adaptações necessárias para atender aos requisitos propostos.

Como minha atuação profissional é voltada para Infraestrutura, SRE e DevOps, e não para desenvolvimento de aplicações, optei por não alterar o código das aplicações além do necessário para entrega do desafio.

Uma implementação completa de cache utilizando Redis exigiria que as aplicações fossem adaptadas para utilizar uma biblioteca cliente Redis, realizando leitura e escrita dos dados em cache e controlando os respectivos tempos de expiração (TTL).

Nesse cenário, a responsabilidade da camada DevOps seria disponibilizar a infraestrutura necessária (Redis, Kubernetes, rede e observabilidade), enquanto a integração da aplicação com o Redis dependeria de desenvolvimento da aplicação.

Por esse motivo, o Redis não foi provisionado nesta entrega, uma vez que não estaria sendo efetivamente utilizado pelas aplicações atuais.


---

# Observabilidade

Não foi implementada nesta versão.

Como evolução da solução, eu consideraria:

* Fluent Bit para coleta de logs.
* Loki para armazenamento.
* Grafana para visualização e monitoramento.

---

# Melhorias futuras

Caso este projeto evoluísse para um ambiente mais próximo de produção, eu consideraria:

* Redis para cache.
* ArgoCD para GitOps.
* Terraform para provisionamento de infraestrutura.
* AWS EKS para execução em cloud.
* Ingress Controller para exposição das aplicações.
* Pipeline CI/CD para automação de deploy.

---

# Considerações finais

O foco desta entrega foi manter a solução simples, funcional e fácil de reproduzir.

Apesar das aplicações serem simples, a estrutura demonstra conceitos importantes de Kubernetes, automação de infraestrutura, containers e organização de ambientes, permitindo futuras evoluções sem grandes mudanças na arquitetura.
