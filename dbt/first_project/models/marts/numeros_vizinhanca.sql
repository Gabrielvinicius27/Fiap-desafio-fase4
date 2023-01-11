select 
    neighbourhood,
    count(*) as qtde_acomodacoes,
    avg(cast(price as int)) as media_preco
from
    {{ ref('staging_listings') }}
group by 1
order by 1