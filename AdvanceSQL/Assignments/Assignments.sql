# Assignment -1

select 
	utm_source,
    utm_campaign,
    http_referer,
	COUNT(distinct(website_session_id)) as sessions
from 
	mavenfuzzyfactory.website_sessions
where 
	created_at < '2012-04-12' 
group by
	1,
    2,
    3
order by
	4 desc;
    
# Assignment-2

select
	count(distinct(website_sessions.website_session_id)) as Sessions,
    count(distinct(orders.order_id)) as Orders,
    count(distinct(orders.order_id))/count(distinct(website_sessions.website_session_id)) as sessions_to_order_conv_rate
from
	website_sessions
    LEFT JOIN
    orders
    ON
    website_sessions.website_session_id = orders.website_session_id
where
	website_sessions.created_at < '2012-04-14' AND
    website_sessions.utm_source = 'gsearch' AND
    website_sessions.utm_campaign = 'nonbrand';

# Assignment-3
select * from mavenfuzzyfactory.website_sessions limit 10;



select 
	MIN(DATE(created_at)) as week_start_date,
    count(distinct(website_session_id)) as sessions
from 
	mavenfuzzyfactory.website_sessions
where
	website_sessions.created_at < '2012-05-12' AND
    website_sessions.utm_source = 'gsearch' AND
    website_sessions.utm_campaign = 'nonbrand'
group by
	week(created_at),
    year(created_at);
    
# Assignment -4

select 
	device_type,
    count(distinct(website_sessions.website_session_id)) as sessions,
    count(distinct(order_id)) as orders,
    count(distinct(order_id))/count(distinct(website_sessions.website_session_id)) as session_to_order_conv_rate
from 
	mavenfuzzyfactory.website_sessions
left join
	mavenfuzzyfactory.orders
ON
	website_sessions.website_session_id = orders.website_session_id
where
	website_sessions.created_at < '2012-05-11' AND
    website_sessions.utm_source = 'gsearch' AND
    website_sessions.utm_campaign = 'nonbrand'
group by
	device_type;
	

show warnings;





