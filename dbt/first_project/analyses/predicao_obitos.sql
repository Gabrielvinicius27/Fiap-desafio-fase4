SELECT
  *
FROM
  ML.PREDICT(MODEL `dataset.previsao_obitos`,
    (
    SELECT
      qtde_obitos,
      bairro,
      mes,
      ano,
      qtde_casos,
      qtde_recuperados,
      qtde_casos_graves
    FROM
      `dataset.covid_por_vizinhanca` ) )
