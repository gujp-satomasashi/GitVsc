

SELECT
*
from
gu_free.c_ordershipping_item_store



SELECT
*
from
gu_free.c_ordershipping_item_all_xxxx
where
purchase_order_id IS NULL


select
*
from
gu_free.bi_cube_order_wo_nmitem
where
SUBSTRING(order_id, 3, 6) between '190401' and '190407'
and (type <> 'ITEM' OR type is not null)
limit 10


select
SUBSTRING(order_id, 3, 6)
,count(distinct order_id)
from
gu_free.bi_cube_order_wo_nmitem
where
SUBSTRING(order_id, 3, 6) between '190401' and '190407'
and (type <> 'ITEM' OR type is not null)
group by
SUBSTRING(order_id, 3, 6)


--bi
select
SUBSTRING(order_id, 3, 6)
,count(distinct order_id)
from
gu_free.bi_fact_order_item
where
SUBSTRING(order_id, 3, 6) between '190401' and '190407'
and 
type <> 'NMITEM'
group by
SUBSTRING(order_id, 3, 6)

select
SUBSTRING(order_id, 3, 6)
,count(distinct order_id)
from
gu_free.bi_cube_order
where
SUBSTRING(order_id, 3, 6) between '190401' and '190407'
group by
SUBSTRING(order_id, 3, 6)





--new bi
select
SUBSTRING(order_id, 3, 6)
,count(distinct order_id)
from
gu_free.bi_fact_order_item
where
SUBSTRING(order_id, 3, 6) between '190401' and '190407'
group by
SUBSTRING(order_id, 3, 6)

select
SUBSTRING(order_id, 3, 6)
,count(distinct order_id)
from
gu_free.bi_cube_order
where
SUBSTRING(order_id, 3, 6) between '190401' and '190407'
group by
SUBSTRING(order_id, 3, 6)




with old_order as (
select
 order_id
 ,count(*) as cnt_order
from
 gu_free.bi_fact_order_item
where
 SUBSTRING(order_id, 3, 6) between '190401' and '190407'
group BY
  order_id
)
,new_order as (
select
 order_id
 ,count(*) as cnt_order
from
 gu_free.bi_fact_order_item_xxxx
where
 SUBSTRING(order_id, 3, 6) between '190401' and '190407'
group BY
  order_id
)
select 
*
from
old_order a
left join
new_order b
on a.order_id = b.order_id
and a.cnt_order <> b.cnt_order





with old_order as (
select
 order_id
 ,count(*) as cnt_order
from
 gu_free.bi_fact_order_item
where
 SUBSTRING(order_id, 3, 6) between '190401' and '190403'
 and
 (type = 'ITEM'
  or
  type is null)
group BY
  order_id
)
,new_order as (
select
 order_id
 ,count(*) as cnt_order
from
 gu_free.bi_fact_order_item_xxxx
where
 SUBSTRING(order_id, 3, 6) between '190401' and '190403'
group BY
  order_id
)
select 
 *
from
 old_order a
 left join
 new_order b
 on a.order_id = b.order_id
 and a.cnt_order <> b.cnt_order
where
b.cnt_order is not null


with order_info as (
SELECT
        pk_juchu_order_id
        ,juchu_payment_type
        ,juchu_channel_code
        ,juchu_channel_name
        ,juchu_gift_type
        ,juchu_home_address
        ,juchu_home_zipcode
        ,juchu_shipping_address
        ,juchu_shipping_zipcode
    FROM
        gu_free.f_order
    where
        /* 過去120日分の受注レコード */
        DATEADD('day', - 120, CAST(CONVERT_TIMEZONE('JST', GETDATE()) AS date)) <= TRUNC(juchu_order_datetime)
        --to_date(SUBSTRING(pk_juchu_order_id, 3, 6), 'YYMMDD') BETWEEN DATEADD('day', - 34, CAST(CONVERT_TIMEZONE('JST', GETDATE()) AS date))
        --AND DATEADD('day', - 33, CAST(CONVERT_TIMEZONE('JST', GETDATE()) AS date))
        --pk_juchu_order_id in ('011904121518-60111','011905171614-87466')

    GROUP BY 
        pk_juchu_order_id
        ,juchu_payment_type
        ,juchu_channel_code
        ,juchu_channel_name
        ,juchu_gift_type
        ,juchu_home_address
        ,juchu_home_zipcode
        ,juchu_shipping_address
        ,juchu_shipping_zipcode
)
select
order_id
count(*)
FROM
order_info
group BY
order_id
having COUNT(*) > 1







	select *
	from
    gu_free.bi_fact_order_item_xxxx
    where
	 SUBSTRING(order_id, 3, 6) between '190401' and '190403'
    and 
	 order_id in (
	  '011904032029-73087'
     --,'011904011714-77431'
     --,'011904022320-41715'
     --,'011904031717-65163'
	 )








--item
select
SUBSTRING(order_id, 3, 6)
,count(distinct order_id)
,sum(juchu_quantity)
,sum(juchu_total_amount)
,sum(unit_retail_price)
,sum(shipped_quantity)
,sum(shipped_sales_amount_before_discount)
,sum(discount_amount)
,sum(shipped_sales_amount_after_discount)
,sum(unit_cost)
,sum(sum_cost)
,sum(fee_to_store)
,sum(fee_to_EC)
from
gu_free.bi_fact_order_item_xxxx
where
SUBSTRING(order_id, 3, 6) between '190401' and '190403'
group by
SUBSTRING(order_id, 3, 6)

--order
select
SUBSTRING(order_id, 3, 6)
,COUNT(*)
,count(distinct order_id)
,sum(juchu_item_cnt)
,sum(sum_juchu_qty)
,sum(sum_juchu_amount)
,sum(sum_shipped_qty)
,sum(sum_shipped_sales_amount_before_discount)
,sum(sum_discount_amount)
,sum(sum_shipped_sales_amount_after_discount)
,sum(sum_fee_to_store)
,sum(sum_fee_to_ec)
from
gu_free.bi_cube_order

where
SUBSTRING(order_id, 3, 6) between '190401' and '190403'
group by
SUBSTRING(order_id, 3, 6)





with old_order as (
select
*
from
 gu_free.bi_cube_order
where
 SUBSTRING(order_id, 3, 6) between '190401' and '190407'
)
,new_order as (
select
*
from
 gu_free.bi_cube_order_xxx1
where
 SUBSTRING(order_id, 3, 6) between '190401' and '190407'
)
select 
*
from
old_order a
left join
new_order b
on a.order_id = b.order_id
and a.tran_type <> b.tran_type
and a.sum_shipped_sales_amount_before_discount <> b.sum_shipped_sales_amount_before_discount

--------------------------
select
SUBSTRING(order_id, 3, 6)
,COUNT(*)
,count(distinct order_id)
,sum(juchu_item_cnt)
,sum(sum_juchu_qty)
,sum(sum_juchu_amount)
,sum(sum_shipped_qty)
,sum(sum_shipped_sales_amount_before_discount)
,sum(sum_discount_amount)
,sum(sum_shipped_sales_amount_after_discount)
,sum(sum_fee_to_store)
,sum(sum_fee_to_ec)
from
gu_free.bi_cube_order_xxx1

where
SUBSTRING(order_id, 3, 6) between '190401' and '190403'
group by
SUBSTRING(order_id, 3, 6)

--------------------------


COUNT(order_id)
,COUNT(tran_type)
,COUNT(order_date)
,SUM(juchu_item_cnt)
,SUM(sum_juchu_qty)
,SUM(sum_juchu_amount)
,COUNT(shipped_member_id)
,COUNT(g1_ims_store_id_6)
,COUNT(shipped_date_jst)
,COUNT(type)
,SUM(shipped_item_cnt)
,SUM(sum_shipped_qty)
,SUM(sum_shipped_sales_amount_before_discount)
,SUM(sum_discount_amount)
,SUM(sum_shipped_sales_amount_after_discount)
,COUNT(payment_type)
,COUNT(channel_code)
,COUNT(channel_name)
,COUNT(gift_division)
,COUNT(orderers_address)
,COUNT(postal_code_of_orderers_address)
,COUNT(shipping_address_prefectures)
,COUNT(shipping_postal_code)
,COUNT(uid)
,COUNT(gender_cd)
,COUNT(gender)
,COUNT(dateofbirth)
,COUNT(addr_pref)
,COUNT(zipcode)
,SUM(sum_cost)
,COUNT(受取方法)
,COUNT(corporate_name)
,COUNT(pickup_store_name)
,COUNT(store_inventory_flag)
,COUNT(在庫引当先)
,COUNT(booking_store_code)
,COUNT(receiptplace_type_code)
,COUNT(corporate_name_inventory)
,COUNT(booking_store_name)
,COUNT(order_key)
,COUNT(accounting_channel)
,SUM(sum_fee_to_store)
,SUM(sum_fee_to_ec)
,COUNT(previous_order_date)
,COUNT(daycount_from_previous_order_date)
,COUNT(monthcount_from_previous_order_date)
,SUM(入荷コスト)
,SUM(加工コスト) /* 返品コストはすべてここに計上 */
,SUM(ピッキングコスト)
,SUM(出荷コスト)
,SUM(管理固定コスト)
,SUM(倉庫振替コスト)
,SUM(倉庫関連費用)
,SUM(配送コスト)
,SUM(物流関連コスト)
,COUNT(nmitem_tran_type)
,COUNT(nmitem_type)
,SUM(商品外売上)
,SUM(送料)
,SUM(前受金)
,SUM(前受金店舗在庫引当)
,SUM(その他商品外売上)
,COUNT(store_uid)
,COUNT(easy_purchase_flag)




select
SUBSTRING(order_id, 3, 6)
,COUNT(*)
,count(distinct order_id)
,COUNT(tran_type)
,COUNT(order_date)
,SUM(juchu_item_cnt)
,SUM(sum_juchu_qty)
,SUM(sum_juchu_amount)
,COUNT(shipped_member_id)
,COUNT(g1_ims_store_id_6)
,COUNT(shipped_date_jst)
,COUNT(type)
,SUM(shipped_item_cnt)
,SUM(sum_shipped_qty)
,SUM(sum_shipped_sales_amount_before_discount)
,SUM(sum_discount_amount)
,SUM(sum_shipped_sales_amount_after_discount)
,COUNT(payment_type)
,COUNT(channel_code)
,COUNT(channel_name)
,COUNT(gift_division)
,COUNT(orderers_address)
,COUNT(postal_code_of_orderers_address)
,COUNT(shipping_address_prefectures)
,COUNT(shipping_postal_code)
,COUNT(uid)
,COUNT(gender_cd)
,COUNT(gender)
,COUNT(dateofbirth)
,COUNT(addr_pref)
,COUNT(zipcode)
,SUM(sum_cost)
,COUNT(受取方法)
,COUNT(corporate_name)
,COUNT(pickup_store_name)
,COUNT(store_inventory_flag)
,COUNT(在庫引当先)
,COUNT(booking_store_code)
,COUNT(receiptplace_type_code)
,COUNT(corporate_name_inventory)
,COUNT(booking_store_name)
,COUNT(order_key)
,COUNT(accounting_channel)
,SUM(sum_fee_to_store)
,SUM(sum_fee_to_ec)
,COUNT(previous_order_date)
,COUNT(daycount_from_previous_order_date)
,COUNT(monthcount_from_previous_order_date)
,SUM(入荷コスト)
,SUM(加工コスト) /* 返品コストはすべてここに計上 */
,SUM(ピッキングコスト)
,SUM(出荷コスト)
,SUM(管理固定コスト)
,SUM(倉庫振替コスト)
,SUM(倉庫関連費用)
,SUM(配送コスト)
,SUM(物流関連コスト)
,COUNT(nmitem_tran_type)
,COUNT(nmitem_type)
,SUM(商品外売上)
,SUM(送料)
,SUM(前受金)
,SUM(前受金店舗在庫引当)
,SUM(その他商品外売上)
,COUNT(store_uid)
,COUNT(easy_purchase_flag)
from
gu_free.bi_cube_order_xxx1

where
SUBSTRING(order_id, 3, 6) between '190401' and '190403'
group by
SUBSTRING(order_id, 3, 6)


--------------------------------------------------------------

select *
from
  (
  select
    *
  FROM
  --    gu_free.c_ordershipping_item_return_new_060301
  --    gu_free.c_ordershipping_item_return_old_060301
    gu_free.bi_cube_order_old_060301
  WHERE
    order_key is not null
  ) a
  left join
    gu_free.bi_cube_order_new_060301 b
  on
    a.order_id = b.order_id
    and
	a.order_key = b.order_key
where
  b.order_id is null