use my_shopping;
select sum(op.quantity) from orders_has_products op inner join orders o where o.create_date>= '2020-09-01' and o.create_date< '2020-10-01' and op.order_id = o.order_id;
select * from orders_has_products;
select * from orders;
select sum(op.quantity * p.price) as 'total income' from orders_has_products op inner join products p on op.product_id = p.product_id;
select op.product_id, p.product_name, op.quantity, p.price from orders_has_products op inner join products p on op.product_id = p.product_id;