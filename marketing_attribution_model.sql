DROP TABLE campaign_activity.user_activity;


--Create basic table. Typically, campaign attributes will be located in multiple tables.
--For this exercise all campaign attribute data has been included in this table.
CREATE TABLE campaign_activity.user_activity (
	 event_id INT PRIMARY KEY,
	 recipient_id INT,
	 campaign_id INT,
	 utm_link varchar(518),
	 action varchar,
	 revenue DECIMAL(10, 2),
	 spend DECIMAL(10, 2),
	 event_timestamp timestamptz
);

--Inserting data into the table.
--For this exercise there are 11 customers and 2 campaigns. 
--Following the instructions from the first assignment, the activity is logged for Sept 2023.
--utm_medium is email (method in which the campaign is communicated) for the purpose of showcasing, open rates, ctr, ect.
INSERT INTO campaign_activity.user_activity(event_id, recipient_id, campaign_id, utm_link, action, revenue, spend, event_timestamp)
VALUES
(1, 1, 1001, 'https://www.example.com/new-landing-page?utm_campaign=last_chance&utm_medium=email&utm_source=blog&utm_content=footer_cta&utm_term=cashback&utm_lid=12351', 'delivered', 0, 0.50, '2023-09-05 09:00:00'),
(2, 1, 1001, 'https://www.example.com/new-landing-page?utm_campaign=last_chance&utm_medium=email&utm_source=blog&utm_content=footer_cta&utm_term=cashback&utm_lid=12351', 'opened', 0, 0.50, '2023-09-05 10:05:00'),
(3, 1, 1001, 'https://www.example.com/new-landing-page?utm_campaign=last_chance&utm_medium=email&utm_source=blog&utm_content=footer_cta&utm_term=cashback&utm_lid=12351', 'clicked', 0, 0.50, '2023-09-05 10:10:00'),
(5, 2, 1001, 'https://www.example.com/new-landing-page?utm_campaign=last_chance&utm_medium=email&utm_source=blog&utm_content=footer_cta&utm_term=cashback&utm_lid=12352', 'delivered', 0, 0.50, '2023-09-05 09:00:00'),
(6, 2, 1001, 'https://www.example.com/new-landing-page?utm_campaign=last_chance&utm_medium=email&utm_source=blog&utm_content=footer_cta&utm_term=cashback&utm_lid=12352', 'opened', 0, 0.50, '2023-09-06 09:10:00'),
(7, 2, 1001, 'https://www.example.com/new-landing-page?utm_campaign=last_chance&utm_medium=email&utm_source=blog&utm_content=footer_cta&utm_term=cashback&utm_lid=12352', 'clicked', 0, 0.50, '2023-09-06 09:20:00'),
(8, 2, 1001, 'https://www.example.com/new-landing-page?utm_campaign=last_chance&utm_medium=email&utm_source=blog&utm_content=footer_cta&utm_term=cashback&utm_lid=12352', 'purchase', 75.50, 0.50, '2023-09-09 10:30:00'),
(27, 2, 1001, 'https://www.example.com/new-landing-page?utm_campaign=last_chance&utm_medium=email&utm_source=blog&utm_content=footer_cta&utm_term=cashback&utm_lid=12352', 'opened', 0, 0.50, '2023-09-10 09:15:00'),
(28, 2, 1001, 'https://www.example.com/new-landing-page?utm_campaign=last_chance&utm_medium=email&utm_source=blog&utm_content=footer_cta&utm_term=cashback&utm_lid=12352', 'clicked', 0, 0.50, '2023-09-10 09:25:00'),
(29, 2, 1001, 'https://www.example.com/new-landing-page?utm_campaign=last_chance&utm_medium=email&utm_source=blog&utm_content=footer_cta&utm_term=cashback&utm_lid=12352', 'purchase', 90.00, 0.50, '2023-09-10 9:30:00'),
(9, 3, 1001, 'https://www.example.com/new-landing-page?utm_campaign=last_chance&utm_medium=email&utm_source=blog&utm_content=footer_cta&utm_term=cashback&utm_lid=12353', 'delivered', 0, 0.50, '2023-09-05 09:00:00'),
(10, 3, 1001, 'https://www.example.com/new-landing-page?utm_campaign=last_chance&utm_medium=email&utm_source=blog&utm_content=footer_cta&utm_term=cashback&utm_lid=12353', 'opened', 0, 0.50, '2023-09-07 08:40:00'),
(26, 3, 1001, 'https://www.example.com/new-landing-page?utm_campaign=last_chance&utm_medium=email&utm_source=blog&utm_content=footer_cta&utm_term=cashback&utm_lid=12353', 'opened', 0, 0.50, '2023-09-21 08:40:00'),
(21, 7, 1001, 'https://www.example.com/new-landing-page?utm_campaign=last_chance&utm_medium=email&utm_source=blog&utm_content=footer_cta&utm_term=cashback&utm_lid=12354', 'bounced', 0, 0.50, '2023-09-05 09:00:00'),
(22, 8, 1001, 'https://www.example.com/new-landing-page?utm_campaign=last_chance&utm_medium=email&utm_source=blog&utm_content=footer_cta&utm_term=cashback&utm_lid=12355', 'bounced', 0, 0.50, '2023-09-05 09:00:00'),
(11, 4, 1002, 'https://www.example.com/product-page?utm_campaign=fall_promo&utm_medium=email&utm_source=newsletter&utm_content=header_banner&utm_term=discount_code&utm_lid=12345', 'delivered', 0, 0.10, '2023-09-15 14:00:00'),
(12, 4, 1002, 'https://www.example.com/product-page?utm_campaign=fall_promo&utm_medium=email&utm_source=newsletter&utm_content=header_banner&utm_term=discount_code&utm_lid=12345', 'opened', 0, 0.10, '2023-09-15 14:10:00'),
(13, 4, 1002, 'https://www.example.com/product-page?utm_campaign=fall_promo&utm_medium=email&utm_source=newsletter&utm_content=header_banner&utm_term=discount_code&utm_lid=12345', 'clicked', 0, 0.10, '2023-09-15 14:20:00'),
(14, 4, 1002, 'https://www.example.com/product-page?utm_campaign=fall_promo&utm_medium=email&utm_source=newsletter&utm_content=header_banner&utm_term=discount_code&utm_lid=12345', 'purchase', 200.00, 0.10, '2023-09-17 10:55:00'),
(15, 5, 1002, 'https://www.example.com/product-page?utm_campaign=fall_promo&utm_medium=email&utm_source=newsletter&utm_content=header_banner&utm_term=discount_code&utm_lid=12346', 'delivered', 0, 0.10, '2023-09-15 14:00:00'),
(16, 5, 1002, 'https://www.example.com/product-page?utm_campaign=fall_promo&utm_medium=email&utm_source=newsletter&utm_content=header_banner&utm_term=discount_code&utm_lid=12346', 'opened', 0, 0.10, '2023-09-16 12:10:00'),
(17, 6, 1002, 'https://www.example.com/product-page?utm_campaign=fall_promo&utm_medium=email&utm_source=newsletter&utm_content=header_banner&utm_term=discount_code&utm_lid=12347', 'delivered', 0, 0.10, '2023-09-15 14:00:00'),
(18, 6, 1002, 'https://www.example.com/product-page?utm_campaign=fall_promo&utm_medium=email&utm_source=newsletter&utm_content=header_banner&utm_term=discount_code&utm_lid=12347', 'opened', 0, 0.10, '2023-09-17 11:05:00'),
(19, 6, 1002, 'https://www.example.com/product-page?utm_campaign=fall_promo&utm_medium=email&utm_source=newsletter&utm_content=header_banner&utm_term=discount_code&utm_lid=12347', 'clicked', 0, 0.10, '2023-09-17 11:15:00'),
(20, 6, 1002, 'https://www.example.com/product-page?utm_campaign=fall_promo&utm_medium=email&utm_source=newsletter&utm_content=header_banner&utm_term=discount_code&utm_lid=12347', 'purchase', 150.00, 0.10, '2023-09-20 11:20:00'),
(23, 9, 1002, 'https://www.example.com/product-page?utm_campaign=fall_promo&utm_medium=email&utm_source=newsletter&utm_content=header_banner&utm_term=discount_code&utm_lid=12348', 'bounced', 0, 0.10, '2023-09-15 14:00:00'),
(24, 10, 1002, 'https://www.example.com/product-page?utm_campaign=fall_promo&utm_medium=email&utm_source=newsletter&utm_content=header_banner&utm_term=discount_code&utm_lid=12349', 'bounced', 0, 0.10, '2023-09-15 14:00:00'),
(25, 11, 1002, 'https://www.example.com/product-page?utm_campaign=fall_promo&utm_medium=email&utm_source=newsletter&utm_content=header_banner&utm_term=discount_code&utm_lid=12350', 'bounced', 0, 0.10, '2023-09-15 14:00:00');

--utm_lid could also be used similarly to a recipient_id as the lid # is a unique id of the link specifically sent to that recipient.
WITH event_data AS (
	SELECT
		event_id,
		recipient_id,
		campaign_id,
		utm_link,
		split_part(split_part(utm_link, 'utm_lid=', 2), '&', 1) AS utm_lid,
		action,
		revenue,
		spend,
		event_timestamp
	FROM
		campaign_activity.user_activity
),
--The split part is used to pull out the attribute between the indicated symbols.
--The regex is used to remove the symbols in the text remaining.
campaign_data AS (
	SELECT
		REGEXP_REPLACE(split_part(split_part(utm_link, '.com/', 2), '?', 1), '[^A-Za-z\s]', ' ', 'g') AS page_type,
		REGEXP_REPLACE(split_part(split_part(utm_link, 'utm_campaign=', 2), '&', 1), '[^A-Za-z\s]', ' ', 'g') AS utm_campaign,
		REGEXP_REPLACE(split_part(split_part(utm_link, 'utm_medium=', 2), '&', 1), '[^A-Za-z\s]', ' ', 'g') AS utm_medium,
		REGEXP_REPLACE(split_part(split_part(utm_link, 'utm_source=', 2), '&', 1), '[^A-Za-z\s]', ' ', 'g') AS utm_source,
		REGEXP_REPLACE(split_part(split_part(utm_link, 'utm_content=', 2), '&', 1), '[^A-Za-z\s]', ' ', 'g') AS utm_content,
		REGEXP_REPLACE(split_part(split_part(utm_link, 'utm_term=', 2), '&', 1), '[^A-Za-z\s]', ' ', 'g') AS utm_term,
		split_part(split_part(utm_link, 'utm_lid=', 2), '&', 1) AS utm_lid
	FROM 
		campaign_activity.user_activity
),
event_logs AS (
	SELECT
		events.event_id,
		events.recipient_id,
		events.campaign_id,
		events.utm_link,
		campaign_data.page_type,
		campaign_data.utm_campaign,
		campaign_data.utm_medium,
		campaign_data.utm_source,
		campaign_data.utm_content,
		campaign_data.utm_term,
		events.utm_lid,
		events.action AS actions,
		events.revenue,
		events.spend,
		events.event_timestamp,
		ROW_NUMBER() OVER (PARTITION BY events.event_id, events.event_timestamp ORDER BY events.event_timestamp) AS row_num
	FROM
		event_data events
	LEFT JOIN campaign_data
		ON events.utm_lid = campaign_data.utm_lid
),
events_table AS (
	SELECT *
	FROM event_logs
	WHERE row_num = 1
),
-- campaigns sent
	sent AS(
	SELECT
	    campaign_id,
	    COUNT(DISTINCT recipient_id) AS sent
	FROM events_table
	GROUP BY campaign_id
),
-- campaigns delivered
delivered AS(
	SELECT
	    campaign_id,
	    COUNT(DISTINCT recipient_id) AS delivered
	FROM events_table
	WHERE actions = 'delivered'
	GROUP BY campaign_id
),
-- total campaigns bounced
total_bounced AS(
	SELECT
	    campaign_id,
	    COUNT(*) AS bounced
	FROM events_table
	WHERE actions = 'bounced'
	GROUP BY campaign_id
),
-- total campaigns opened
total_opens AS(
	SELECT
		campaign_id,
		COUNT(*) AS total_opens
	FROM events_table
	WHERE actions = 'opened'
	GROUP BY campaign_id
),
-- distinct campaigns opened
unique_opens AS(
	SELECT
	    campaign_id,
	    COUNT(DISTINCT recipient_id) AS unique_opens
	FROM events_table
	WHERE actions = 'opened'
	GROUP BY campaign_id
),
-- total count of clicks 
total_clicks AS(
	SELECT
		campaign_id,
		COUNT(*) AS total_clicks
	FROM events_table
	WHERE actions = 'clicked'
	GROUP BY campaign_id
),
-- distinct count of clicks
unique_clicks AS(
	SELECT
	    campaign_id,
	    COUNT(DISTINCT recipient_id) AS unique_clicks
	FROM events_table
	WHERE actions = 'clicked'
	GROUP BY campaign_id
),
-- total count of conversions
total_conversions AS(
	SELECT
		campaign_id,
		COUNT(*) AS total_conversions
	FROM events_table
	WHERE actions = 'purchase'
	GROUP BY campaign_id
),
-- distinct converted
unique_converted AS(
	SELECT
	    campaign_id,
	    COUNT(DISTINCT recipient_id) AS unique_converted
	FROM events_table
	WHERE actions = 'purchase'
	GROUP BY campaign_id
),
-- total impressions
total_impressions AS(
	SELECT
	    campaign_id,
	    COUNT(event_id) AS impressions
	FROM events_table
	WHERE actions = 'purchase' OR actions = 'opened' OR actions = 'clicked'
	GROUP BY campaign_id
)
--The final model which includes all calculations providing added detail on campaign performance
SELECT
	events2.campaign_id,
	events2.utm_campaign,
	events2.utm_medium,
	events2.page_type,
	events2.utm_source,
	events2.utm_term,
	COUNT(DISTINCT recipient_id) AS total_recipients,
	sent.sent,
	delivered.delivered,
	total_bounced.bounced,
	total_opens.total_opens,
	unique_opens.unique_opens,
	total_clicks.total_clicks,
	unique_clicks.unique_clicks,
	total_conversions.total_conversions,
	unique_converted.unique_converted,
	total_impressions.impressions,
	ROUND(CAST(SUM(events2.spend) AS DECIMAL) / CAST(total_clicks.total_clicks AS DECIMAL), 2) AS cost_per_click,
	SUM(events2.revenue) AS total_revenue,
	SUM(events2.spend) AS total_spend,
	ROUND(CAST(delivered.delivered AS DECIMAL) / CAST(sent.sent AS DECIMAL) * 100, 2) AS delivery_rate,
	ROUND(CAST(total_bounced.bounced AS DECIMAL) / CAST(sent.sent AS DECIMAL) * 100, 2) AS bounce_rate,
	ROUND(CAST(total_opens.total_opens AS DECIMAL) / CAST(delivered.delivered AS DECIMAL) * 100, 2) AS open_rate,
	ROUND(CAST(total_clicks.total_clicks AS DECIMAL) / CAST(total_impressions.impressions AS DECIMAL) * 100, 2) AS ctr,
	ROUND(CAST(total_conversions AS DECIMAL) / CAST(delivered.delivered AS DECIMAL) * 100, 2) AS conversion_rate,
	ROUND((CAST(SUM(events2.revenue) AS DECIMAL) - CAST(SUM(events2.spend) AS DECIMAL)) / CAST(SUM(events2.spend) AS DECIMAL) * 100, 2) AS roi
FROM events_table events2
LEFT JOIN sent
	ON events2.campaign_id = sent.campaign_id
LEFT JOIN delivered
	ON events2.campaign_id = delivered.campaign_id
LEFT JOIN total_bounced
	ON events2.campaign_id = total_bounced.campaign_id
LEFT JOIN total_opens
	ON events2.campaign_id = total_opens.campaign_id
LEFT JOIN unique_opens
	ON events2.campaign_id = unique_opens.campaign_id
LEFT JOIN total_clicks
	ON events2.campaign_id = total_clicks.campaign_id
LEFT JOIN unique_clicks
	ON events2.campaign_id = unique_clicks.campaign_id
LEFT JOIN total_conversions
	ON events2.campaign_id = total_conversions.campaign_id
LEFT JOIN unique_converted
	ON events2.campaign_id = unique_converted.campaign_id
LEFT JOIN total_impressions
	ON events2.campaign_id = total_impressions.campaign_id
GROUP BY
	events2.campaign_id,
	events2.utm_campaign,
	events2.utm_medium,
	events2.page_type,
	events2.utm_source,
	events2.utm_term,
	sent.sent,
	delivered.delivered,
	total_bounced.bounced,
	total_opens.total_opens,
	unique_opens.unique_opens,
	total_clicks.total_clicks,
	unique_clicks.unique_clicks,
	total_conversions.total_conversions,
	unique_converted.unique_converted,
	total_impressions.impressions;

