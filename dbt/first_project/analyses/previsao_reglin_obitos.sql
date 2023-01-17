-- O tipo de modelo a ser aplicado é o LINEAR_REG porque ele se adapta bem a casos de previsão de número de vendas por período, por exemplo.
-- A coluna a ser prevista será qtde_obitos
-- O número máximo de iterações para concluir o treinamento é de 10.
-- Os dados foram separados entre dados para treinar o modelo e dados que vão servir para prever com o modelo. A separação foi feita de maneira aleatória com a opção DATA_SPLIT_METHOD.
-- A estratégia de aprendizado escolhida foi LINE_SEARCH // https://pt.wikipedia.org/wiki/Pesquisa_linear
-- Os dados foram separados em 60% para treinamento e 40% para previsão
CREATE OR REPLACE MODEL
  `onyx-course-371018.dataset.previsao_obitos`
OPTIONS
  ( MODEL_TYPE='LINEAR_REG',
    INPUT_LABEL_COLS=['qtde_obitos'],
    LEARN_RATE_STRATEGY = 'LINE_SEARCH',
    MAX_ITERATIONS=10,
    DATA_SPLIT_METHOD='RANDOM',
    DATA_SPLIT_EVAL_FRACTION = 0.4) AS
SELECT
  bairro,
  mes,
  ano,
  qtde_casos,
  qtde_recuperados,
  qtde_casos_graves,
  qtde_obitos
FROM
  `onyx-course-371018.dataset.covid_por_vizinhanca`
