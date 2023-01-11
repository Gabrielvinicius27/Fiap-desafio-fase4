{{ config(materialized='table') }}

with source_data as (

    select distinct 
    UPPER(sexo) AS sexo,
    UPPER(sistema) AS sistema,
    UPPER(evolucao) AS evolucao,
    REGEXP_REPLACE(NORMALIZE(UPPER(raca_cor), NFD), r'\pM', '') AS raca_cor,
    SAFE.PARSE_DATE('%m/%d/%Y', dt_notific) AS dt_notific,
    SAFE.PARSE_DATE('%m/%d/%Y', dt_evolucao) AS dt_evolucao,
    UPPER(faixa_etaria) AS faixa_etaria,
    SAFE.PARSE_DATE('%m/%d/%Y', Data_atualizacao) AS dt_atualizacao,
    SAFE.PARSE_DATE('%m/%d/%Y', dt_inicio_sintomas) AS dt_inicio_sintomas,
    REGEXP_REPLACE(NORMALIZE(UPPER(bairro_resid_estadia), NFD), r'\pM', '') AS bairro_resid_estadia,
    ap_residencia_estadia,
    UPPER(classificacao_final) AS classificacao_final
    from {{ source('bigquery', 'covid_rj') }}
)

select *
from source_data
where upper(classificacao_final) = "CONFIRMADO"

