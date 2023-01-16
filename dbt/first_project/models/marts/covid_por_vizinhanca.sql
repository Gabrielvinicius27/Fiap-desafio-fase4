-- vw_covid_por_vizinhanca
-- create or replace view `onyx-course-371018`.`dataset`.`covid_por_vizinhanca` AS
SELECT
  bairro_resid_estadia                   AS bairro,
  DATE_TRUNC(dt_notific, YEAR)           AS ano,
  DATE_TRUNC(dt_notific, MONTH)          AS mes,
  COUNT(*)                               AS qtde_casos,
  SUM(IF(evolucao = "ÓBITO"     , 1, 0)) AS qtde_obitos,
  SUM(IF(evolucao = "RECUPERADO", 1, 0)) AS qtde_recuperados,
  SUM(IF(evolucao = "ATIVO"     , 1, 0)) AS qtde_ativos,
  SUM(IF(sistema  = "SIVEP"     , 1, 0)) AS qtde_casos_graves
FROM  {{ ref('staging_covid') }}
WHERE dt_notific >= "2020-01-01"
AND   bairro_resid_estadia is not null 
AND   bairro_resid_estadia <> "IGNORADO"
GROUP BY bairro, ano, mes
ORDER BY ano, mes;