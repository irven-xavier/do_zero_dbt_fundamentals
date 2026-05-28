-- created_at: 2026-05-28T18:46:45.418633900+00:00
-- finished_at: 2026-05-28T18:46:45.540586200+00:00
-- elapsed: 121ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c4ad06-0001-679b-0001-3d2600017466
-- desc: execute adapter call
show terse schemas in database analytics
    limit 10000
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2026-05-28T18:46:45.560087400+00:00
-- finished_at: 2026-05-28T18:46:45.691568800+00:00
-- elapsed: 131ms
-- outcome: success
-- dialect: snowflake
-- node_id: not available
-- query_id: 01c4ad06-0001-677f-0001-3d260001139e
-- desc: execute adapter call
create schema if not exists analytics.dbt_irven
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "default", "target_name": "dev"} */;
-- created_at: 2026-05-28T18:46:45.862737200+00:00
-- finished_at: 2026-05-28T18:46:45.986209400+00:00
-- elapsed: 123ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.customers
-- query_id: 01c4ad06-0001-679b-0001-3d260001746a
-- desc: get_relation > list_relations call
SHOW OBJECTS IN SCHEMA "ANALYTICS"."DBT_IRVEN" LIMIT 10000;
-- created_at: 2026-05-28T18:46:46.018542400+00:00
-- finished_at: 2026-05-28T18:46:46.354678100+00:00
-- elapsed: 336ms
-- outcome: success
-- dialect: snowflake
-- node_id: model.jaffle_shop.customers
-- query_id: 01c4ad06-0001-677f-0001-3d26000113a2
-- desc: execute adapter call
create or replace   view analytics.dbt_irven.customers
  
  
  
  
  as (
    with customers as (

    select
        id as customer_id,
        first_name,
        last_name

    from raw.jaffle_shop.customers

),

orders as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from raw.jaffle_shop.orders

),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders using (customer_id)

)

select * from final
  )
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.jaffle_shop.customers", "profile_name": "default", "target_name": "dev"} */;
