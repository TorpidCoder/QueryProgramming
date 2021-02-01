# Assignment -1

use mavenfuzzyfactory;

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
    
# Assignment -3

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
    
# Assignment - 4

select 
	MIN(DATE(created_at)),
    week(created_at),
    COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN website_session_id ELSE NULL END) as dtop_sessions,
    COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN website_session_id ELSE NULL END) as mob_sessions
 from 
	website_sessions
where
	website_sessions.created_at < '2012-05-11' AND
    website_sessions.utm_source = 'gsearch' AND
    website_sessions.utm_campaign = 'nonbrand'
group by
	week(created_at)
order by
	2,3;
    
    
# Assignment - 5

select * from website_pageviews limit 100;

select
	pageview_url,
    count(distinct(website_pageview_id)) as sessions
from 
	website_pageviews
where
	created_at < '2012-06-09'
group by
	pageview_url
order by
	2 desc;


# Assignment - 6

create temporary table first_pv_per_session
select 
	website_session_id,
	min(website_pageview_id) as min_pv
from 
	website_pageviews
where
	created_at < '2012-06-12'
group by
	website_session_id;

select 
	website_pageviews.pageview_url,
    count(distinct(first_pv_per_session.website_session_id)) as sessions_hitting_page
from 
	website_pageviews
left join
	first_pv_per_session
ON
	website_pageviews.website_pageview_id = first_pv_per_session.min_pv
where 
	created_at < '2012-06-12'
group by
	website_pageviews.pageview_url
order by
	2 desc
limit
	1 ;


# Assignment -7
#step-1 Finding the first website page view for each relevant session.

create temporary table first_page_views
select 
	website_session_id,
    min(website_pageview_id) as pg_view
from 
	website_pageviews
where
	created_at < '2012-06-14'
group by
	1;
    
# step -2 identifying the landing page of each session

create temporary table session_wise_home_page
select 
	first_page_views.website_session_id,
	website_pageviews.pageview_url as landing_page
from
	website_pageviews
INNER JOIN
	first_page_views
ON
	website_pageviews.website_pageview_id = first_page_views.pg_view
where
	website_pageviews.pageview_url = '/home';
    
# step-3 count pageviews for each session to identify bounces

create temporary table bounce_sessions
select 
	session_wise_home_page.website_session_id,
	session_wise_home_page.landing_page,
    count(distinct(website_pageviews.website_pageview_id)) as count_pages_viewed
from 
	session_wise_home_page
INNER JOIN
	website_pageviews
ON
	session_wise_home_page.website_session_id = website_pageviews.website_session_id
group by
	1,2
having count(count_pages_viewed) =1;
    




show warnings;





