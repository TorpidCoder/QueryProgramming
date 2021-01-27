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

    

