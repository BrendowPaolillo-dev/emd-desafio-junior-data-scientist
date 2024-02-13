-- Localização de chamados do 1746

--------------------------------------------------------------------------
--          Questão 1
-- Quantos chamados foram abertos no dia 01/04/2023?

SELECT
  COUNT(*) AS Quantidade_de_chamados
FROM
  datario.administracao_servicos_publicos.chamado_1746
WHERE
  DATE(data_inicio)= DATE('2023-04-01');

-- RESPOSTA: No dia 01/04/2023 foram registrados 73 chamados

--------------------------------------------------------------------------
--          Questão 2
-- Qual o tipo de chamado que teve mais reclamações no dia 01/04/2023?

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
  COUNT(tipo) AS Quantidade_de_chamados 
FROM
  datario.administracao_servicos_publicos.chamado_1746
WHERE
  DATE(data_inicio)= DATE('2023-04-01')
GROUP BY 
  tipo
ORDER BY 
  Quantidade_de_chamados DESC
LIMIT 1;

/* Caso deseje saber quais são os tipos de chamados que tiveram mais reclamações
e as suas quantidades em ordenação decrescente */
SELECT
  tipo,
  COUNT(tipo) AS Quantidade_de_chamados 
FROM
  datario.administracao_servicos_publicos.chamado_1746
WHERE
  DATE(data_inicio)= DATE('2023-04-01')
GROUP BY 
  tipo
ORDER BY 
  Quantidade_de_chamados DESC;

-- RESPOSTA: O tipo de chamado com mais reclamações no dia 01/04/2023 é "Poluição sonora", com 24 chamados

--------------------------------------------------------------------------
--          Questão 3
-- Quais os nomes dos 3 bairros que mais tiveram chamados abertos nesse dia?

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

-- RESPOSTA: os 3 bairros que mais tiveram chamados abertos no dia 01/04/2023 foram Engenho de Dentro, Campo Grande e Leblon

--------------------------------------------------------------------------
--          Questão 4
-- Qual o nome da subprefeitura com mais chamados abertos nesse dia?

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

-- RESPOSTA: A subprefeitura com mais chamados abertos no dia 01/04/2023 foi Zona Norte

--------------------------------------------------------------------------
--          Questão 5
-- Existe algum chamado aberto nesse dia que não foi associado a um bairro ou subprefeitura na tabela de bairros? Se sim, por que isso acontece?

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

RESPOSTA: Avaliando o resultado, pode-se inferir que o chamado não se encontra vinculado a um bairro
ou subprefeitura, pois trata-se de um registro de um veículo (Ônibus) da frota Municipal, na qual tem como valor
de subtipo: "Verificação de ar condicionado inoperante no ônibus".
*/

--------------------------------------------------------------------------
--          Questão 6
-- Quantos chamados com o subtipo "Perturbação do sossego" foram abertos desde 01/01/2022 até 31/12/2023 (incluindo extremidades)?

SELECT COUNT(*) AS Perturbacao_do_sossego_contagem
FROM 
  datario.administracao_servicos_publicos.chamado_1746 AS ch
WHERE
  ch.subtipo = 'Perturbação do sossego' AND
  DATE(ch.data_inicio) BETWEEN DATE('2022-01-01') AND DATE('2023-12-31 23:59:59.999')

-- RESPOSTA: O resultado da consulta contém 42408 chamados com o subtipo "Perturbação do sossego"

--------------------------------------------------------------------------
--          Questão 7
-- Selecione os chamados com esse subtipo que foram abertos durante os eventos contidos na tabela de eventos (Reveillon, Carnaval e Rock in Rio).

SELECT ch.*, rh.evento
FROM datario.administracao_servicos_publicos.chamado_1746 AS ch
INNER JOIN datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos AS rh ON DATE (ch.data_inicio) >= DATE (rh.data_inicial)
  AND DATE (ch.data_inicio) <= DATE (rh.data_final)
WHERE ch.subtipo = 'Perturbação do sossego'

-- RESPOSTA: Foram encontrados 1212 registros com o subtipo "Perturbação do sossego" durante os eventos

--------------------------------------------------------------------------
--          Questão 8
-- Quantos chamados desse subtipo foram abertos em cada evento?

SELECT rh.evento, COUNT(ch.id_chamado)
FROM datario.administracao_servicos_publicos.chamado_1746 AS ch
INNER JOIN datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos AS rh ON DATE (ch.data_inicio) >= DATE (rh.data_inicial)
  AND DATE (ch.data_inicio) <= DATE (rh.data_final)
WHERE ch.subtipo = 'Perturbação do sossego'
GROUP BY rh.evento

/* RESPOSTA: Foram encontrados 1212 registros com o subtipo "Perturbação do sossego" durante os eventos,
sendo 241 no Carnaval, 137 no Reveillon, 834 no Rock in Rio */

--------------------------------------------------------------------------
--          Questão 9
-- Qual evento teve a maior média diária de chamados abertos desse subtipo?

SELECT evento, AVG(contagem_chamados) AS media_diaria_chamados
FROM (
    SELECT rh.evento, 
           COUNT(ch.id_chamado) / (DATE_DIFF(DATE(rh.data_final), DATE(rh.data_inicial), DAY) + 1) AS contagem_chamados
    FROM datario.administracao_servicos_publicos.chamado_1746 AS ch
    INNER JOIN datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos AS rh 
        ON DATE(ch.data_inicio) >= DATE(rh.data_inicial)
        AND DATE(ch.data_inicio) <= DATE(rh.data_final)
    WHERE ch.subtipo = 'Perturbação do sossego'
    GROUP BY rh.evento, rh.data_inicial, rh.data_final
) AS eventos_chamados
GROUP BY evento
LIMIT 1;

/* RESPOSTA: A maior média diária é de 119.5 chamados com o subtipo "Perturbação do sossego" durante o Rock in Rio */

--------------------------------------------------------------------------
--          Questão 10
-- Compare as médias diárias de chamados abertos desse subtipo durante os eventos específicos (Reveillon, Carnaval e Rock in Rio) e a média diária de chamados abertos desse subtipo considerando todo o período de 01/01/2022 até 31/12/2023.

WITH eventos AS (
    SELECT evento, data_inicial, data_final
    FROM datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos
    WHERE evento IN ('Reveillon', 'Carnaval', 'Rock in Rio')
),
media_eventos AS (
    SELECT evento, AVG(contagem_chamados) AS media_diaria_evento
    FROM (
        SELECT rh.evento, 
               COUNT(ch.id_chamado) / (DATE_DIFF(DATE(rh.data_final), DATE(rh.data_inicial), DAY) + 1) AS contagem_chamados
        FROM datario.administracao_servicos_publicos.chamado_1746 AS ch
        INNER JOIN eventos AS rh 
            ON DATE(ch.data_inicio) >= DATE(rh.data_inicial)
            AND DATE(ch.data_inicio) <= DATE(rh.data_final)
        WHERE ch.subtipo = 'Perturbação do sossego'
        GROUP BY rh.evento, rh.data_inicial, rh.data_final
    ) AS eventos_chamados
    GROUP BY evento
),
media_total AS (
    SELECT AVG(contagem_chamados) AS media_diaria_total
    FROM (
        SELECT COUNT(id_chamado) / (DATE_DIFF('2023-12-31', '2022-01-01', DAY) + 1) AS contagem_chamados
        FROM datario.administracao_servicos_publicos.chamado_1746
        WHERE subtipo = 'Perturbação do sossego'
          AND data_inicio BETWEEN '2022-01-01' AND '2023-12-31 23:59:59.999'
    )
)
SELECT 'Reveillon' AS evento, media_diaria_evento, NULL AS media_diaria_total FROM media_eventos WHERE evento = 'Reveillon'
UNION ALL
SELECT 'Carnaval' AS evento, media_diaria_evento, NULL FROM media_eventos WHERE evento = 'Carnaval'
UNION ALL
SELECT 'Rock in Rio' AS evento, media_diaria_evento, NULL FROM media_eventos WHERE evento = 'Rock in Rio'
UNION ALL
SELECT 'Total' AS evento, NULL, media_diaria_total FROM media_total;

/* RESPOSTA: Os eventos possuem uma média diária de chamados de:
        Evento    | Média 
    ------------------------
      Rock in Rio | 119.5
      Carnaval    | 60.25
      Reveillon   | 45.6
  
  Já a média diária de chamados durante todo o período de 01/01/2022 até 31/12/2023 é de: 58.093150684931508
*/