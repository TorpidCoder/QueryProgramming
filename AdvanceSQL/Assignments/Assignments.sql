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