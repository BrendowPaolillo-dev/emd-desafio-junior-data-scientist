-- Localização de chamados do 1746

--------------------------------------------------------------------------
--          Questão 1
SELECT
  id_chamado,
  nome_unidade_organizacional,
  categoria,
  tipo,
  subtipo,
  data_inicio
FROM
  datario.administracao_servicos_publicos.chamado_1746
WHERE
  DATE(data_inicio)= DATE('2023-04-01');

--------------------------------------------------------------------------
--          Questão 2
/* Caso deseje saber apenas qual é o tipo de chamado que teve mais reclamações */
SELECT
    tipo
FROM
  datario.administracao_servicos_publicos.chamado_1746
WHERE
  DATE(data_inicio)= DATE('2023-04-01')
GROUP BY
    tipo
ORDER BY COUNT(*) DESC
LIMIT 1;

/* Caso deseje saber qual é o tipo de chamado que teve mais reclamações
e a sua quantidade */
SELECT
  tipo,
  COUNT(tipo) AS `valor` 
FROM
  datario.administracao_servicos_publicos.chamado_1746
WHERE
  DATE(data_inicio)= DATE('2023-04-01')
GROUP BY 
  tipo
ORDER BY 
  `valor` DESC
LIMIT 1;

/* Caso deseje saber quais são os tipos de chamados que tiveram mais reclamações
e as suas quantidades em ordenação decrescente */
SELECT
  tipo,
  COUNT(tipo) AS `valor` 
FROM
  datario.administracao_servicos_publicos.chamado_1746
WHERE
  DATE(data_inicio)= DATE('2023-04-01')
GROUP BY 
  tipo
ORDER BY 
  `valor` DESC;

--------------------------------------------------------------------------
--          Questão 3
/* Este problema é possível de ser resolvido de várias formas,
 irei demonstrar duas distintas, uma com aninhamento de consultas e outra com JOIN */

/* Aninhamento */
SELECT 
    (SELECT nome FROM datario.dados_mestres.bairro WHERE id_bairro = ch.id_bairro) AS Nome,
    COUNT(*) AS Quantidade
FROM 
    datario.administracao_servicos_publicos.chamado_1746 AS ch
WHERE 
    ch.id_bairro IS NOT NULL 
    AND DATE(ch.data_inicio)= DATE('2023-04-01')
GROUP BY 
    ch.id_bairro
ORDER BY 
    COUNT(*) DESC
LIMIT 3;

/* JOIN */
SELECT b.nome, COUNT(*) AS Quantidade
FROM datario.dados_mestres.bairro AS b 
    INNER JOIN datario.administracao_servicos_publicos.chamado_1746 AS ch ON b.id_bairro = ch.id_bairro 
    AND DATE(data_inicio)= DATE('2023-04-01')
GROUP BY b.nome
ORDER BY COUNT(*) DESC
LIMIT 3;


--------------------------------------------------------------------------
--          Questão 4
SELECT 
    (SELECT subprefeitura FROM datario.dados_mestres.bairro WHERE id_bairro = ch.id_bairro) AS Subprefeitura,
    COUNT(*) AS Quantidade
FROM 
    datario.administracao_servicos_publicos.chamado_1746 AS ch
WHERE 
    DATE(ch.data_inicio)= DATE('2023-04-01')
GROUP BY 
    Subprefeitura
ORDER BY 
    COUNT(*) DESC
LIMIT 1;

--------------------------------------------------------------------------
--          Questão 5
SELECT *
FROM datario.administracao_servicos_publicos.chamado_1746 AS ch
LEFT JOIN datario.dados_mestres.bairro AS b ON ch.id_bairro = b.id_bairro
WHERE DATE(ch.data_inicio) = DATE('2023-04-01')
AND (b.nome IS NULL OR b.subprefeitura IS NULL)

/* 
Após executar a consulta, foi encontrado o seguinte dado:

    [{
        "id_chamado": "18516246",
        "data_inicio": "2023-04-01T00:55:38",
        "data_fim": "2023-04-01T00:55:38",
        "id_bairro": null,
        "id_territorialidade": null,
        "id_logradouro": null,
        "numero_logradouro": null,
        "id_unidade_organizacional": "1706",
        "nome_unidade_organizacional": "TR/SUBOP/CFT - Coordenadoria de Fiscalização em Transportes",
        "id_unidade_organizacional_mae": "SMTR - Secretaria Municipal de Transportes",
        "unidade_organizacional_ouvidoria": "False",
        "categoria": "Serviço",
        "id_tipo": "93",
        "tipo": "Ônibus",
        "id_subtipo": "1242",
        "subtipo": "Verificação de ar condicionado inoperante no ônibus",
        "status": "Fechado com informação",
        "longitude": null,
        "latitude": null,
        "data_alvo_finalizacao": "2023-04-11T00:55:00",
        "data_alvo_diagnostico": null,
        "data_real_diagnostico": null,
        "tempo_prazo": null,
        "prazo_unidade": "D",
        "prazo_tipo": "F",
        "dentro_prazo": "No prazo",
        "situacao": "Encerrado",
        "tipo_situacao": "Atendido parcialmente",
        "justificativa_status": null,
        "reclamacoes": "0",
        "data_particao": "2023-04-01",
        "geometry": null,
        "id_bairro_1": null,
        "nome": null,
        "id_area_planejamento": null,
        "id_regiao_planejamento": null,
        "nome_regiao_planejamento": null,
        "id_regiao_administrativa": null,
        "nome_regiao_administrativa": null,
        "subprefeitura": null,
        "area": null,
        "perimetro": null,
        "geometry_wkt": null,
        "geometry_1": null
    }]

Avaliando o resultado, pode-se inferir que o chamado não se encontra vinculado a um bairro
ou subprefeitura, pois trata-se de um registro de um veículo (Ônibus) da frota Municipal, na qual tem como valor
de subtipo: "Verificação de ar condicionado inoperante no ônibus".
*/