WITH dados AS (
  SELECT *
  FROM `onyx-course-371018.dataset.covid_por_vizinhanca`
  INNER JOIN `onyx-course-371018.dataset.reviews_por_vizinhanca`
  USING (BAIRRO, ANO, MES)
)
SELECT
  CORR(qtde_reviews, qtde_casos),
  CORR(qtde_reviews, qtde_obitos),
  CORR(qtde_reviews, qtde_recuperados),
  CORR(qtde_reviews, qtde_ativos),
  CORR(qtde_reviews, qtde_casos_graves)
FROM
  dados
