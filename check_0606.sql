--20190612修正→push

--検証確認用


:select
  SUBSTRING(pk_order_id, 3, 6)
  ,COUNT(*)
  ,COUNT(distinct pk_order_id)
  ,min(item_pk_date)
  ,max(item_pk_date)
from
 --gu_free.c_ordershipping_item_ec_new_060601
 --gu_free.c_ordershipping_item_store_new_060601
 --gu_free.c_ordershipping_item_return_new_060601
 gu_free.c_ordershipping_item_ec_new_060602
 --gu_free.c_ordershipping_item_store_new_060602
 --gu_free.c_ordershipping_item_return_new_060602
 --gu_free.f_shipping_ec_new_060601
 --gu_free.f_shipping_store_new_060601
 --gu_free.f_shipping_return_new_060601
group by
  SUBSTRING(pk_order_id, 3, 6)
;





select
  SUBSTRING(pk_order_id, 3, 6)
  --SUBSTRING(purchase_order_datetime, 3, 8)
  ,COUNT(*) as cnt_all
  ,COUNT(distinct pk_order_id) as cnt_dist_order_id
  ,count(DISTINCT pk_transaction_id) as cnt_dist_transaction_id
  ,SUM(juchu_quantity) as juchu_quantity
  ,SUM(juchu_detail_total_amount) as juchu_detail_total_amount
  --,min(item_pk_date)
  --,max(item_pk_date)
from
 --gu_free.f_shipping_ec_new_060601
 --gu_free.f_shipping_store_new_060601
 --gu_free.f_shipping_return_new_060601

 --gu_free.c_ordershipping_item_ec_new_060601
 --gu_free.c_ordershipping_item_store_new_060601
 --gu_free.c_ordershipping_item_return_new_060601

 --gu_free.c_ordershipping_item_ec_new_060602
 --gu_free.c_ordershipping_item_store_new_060602
 --gu_free.c_ordershipping_item_return_new_060602

 gu_free.c_ordershipping_item_ec
 --gu_free.c_ordershipping_item_all_new_060602
WHERE
  --SUBSTRING(pk_order_id, 3, 6) between '190404' and '190406'
  purchase_order_datetime between '19-04-04' and '19-04-06'
  --SUBSTRING(order_id, 3, 6) between '190404' and '190406'
--  and
--  (
--  purchase_type <> 'NMITEM'
--  and
--  purchase_type <> 'ITEM'
--  and
--  purchase_type is not null
--  )
group by
  --SUBSTRING(purchase_order_datetime, 3, 8)
  SUBSTRING(pk_order_id, 3, 6)
  --SUBSTRING(order_id, 3, 6)
;















