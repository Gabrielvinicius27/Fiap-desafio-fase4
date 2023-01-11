WITH covid_flags AS (
    SELECT 
        *,
        CASE WHEN evolucao = "ÓBITO" THEN 1 ELSE 0 END AS FLG_OBITO,
        CASE WHEN evolucao = "RECUPERADO" THEN 1 ELSE 0 END AS FLG_RECUPERADO,
        CASE WHEN evolucao = "ATIVO" THEN 1 ELSE 0 END AS FLG_ATIVO,
        CASE WHEN sistema = "SIVEP" THEN 1 ELSE 0 END AS FLG_CASO_GRAVE,
    FROM
        {{ ref('staging_covid') }}
)
SELECT
    bairro_resid_estadia AS bairro,
    DATE_TRUNC(dt_notific, YEAR) AS ano,
    DATE_TRUNC(dt_notific, MONTH) AS mes,
    COUNT(*) as qtde_casos,
    SUM(FLG_OBITO) as qtde_obitos,
    SUM(FLG_RECUPERADO) as qtde_recuperados,
    SUM(FLG_ATIVO) as qtde_ativos,
    SUM(FLG_CASO_GRAVE) as qtde_casos_graves
FROM
    covid_flags
GROUP BY
    1,
    2,
    3
ORDER BY
    2,
    3