# Desafio Técnico - Cientista de Dados Júnior

## Descrição
Projeto desenvolvido para um desafio técnico de cientista de dados para Escritório de Dados da Prefeitura da Cidade do Rio de Janeiro.

## Requerimentos
- Para a execução e a avaliação completa do desafio, é fundamental ter acesso ao Google Cloud Platform (GCP) para a utilização do BigQuery nos dados disponibilizados.
- Recomenda-se a instalação do [Jupyter Notebook](https://jupyter.org/install) ou [Anaconda](https://www.anaconda.com/download) (para usuários Windows).

## 1- SQL - Google Cloud Platform (GCP)

1. Crie uma conta Google e acesse o [GCP Console](https://console.cloud.google.com/);
2. Crie um novo projeto com a opção `"Local"` preenchido como: `Sem organização`;
3. No menu lateral, a opção *`BigQuery`* contém um submenu para acessar o *`BigQuery Studio`*;
4. No *`BigQuery Studio`*, o campo *"Explorer"* contém os conjuntos de dados adicionados ao projeto, que podem ser utilizados para realizarmos as consultas. Para a execução deste projeto, clique em `Adicionar` e selecione a opção `Marcar um projeto com estrela por nome`;
5. No pop-up de "Marcar um projeto com estrela",  adicione ao nome do projeto o valor: `datario`;
6. Por fim, clique em `"Criar consulta SQL"`, na página inicial do *`BigQuery Studio`*, e adicione as consultas deste projeto, contidas no arquivo: [analise_sql](https://github.com/BrendowPaolillo-dev/emd-desafio-junior-data-scientist/blob/main/analise_sql.sql).

**Observação**: Não execute todas as consulta SQL ao mesmo tempo, pois devido à quantidade de dados existentes no `datario`, o tempo de resposta dos comandos podem demorar muito e também podem ocasionar em travamentos da aba do navegador. Para evitar este comportamento, **execute uma consulta por vez**.

## 2- Python - Jupyter Notebook
1. Realize a instalação do [Jupyter Notebook](https://jupyter.org/install) ou [Anaconda](https://www.anaconda.com/download), conforme o sistema operacional utilizado;
2. Instale a biblioteca com o comando `pip install basedosdados`;
3. Abra o arquivo `analise_python.ipynb`;
4. Execute todas as células, obedecendo a ordem delas;
5. Verifique os resultados.

## 3- Visualização dos Dados - Looker Studio
- Para verificar a visualização dos dados com elementos gráficos, acesse o arquivo: [Desafio_Data.Rio_-_Brendow.pdf](https://github.com/BrendowPaolillo-dev/emd-desafio-junior-data-scientist/blob/main/Desafio_Data.Rio_-_Brendow.pdf)
- Para verificar a visualização interativa dos dados, acesse: [Desafio Data.Rio - Brendow (LookerStudio)](https://lookerstudio.google.com/reporting/d553f610-a0d9-4c51-94d3-6db48ba96464)

---
Desenvolvido por [Brendow Paolillo Castro Isidoro](https://github.com/BrendowPaolillo-dev).