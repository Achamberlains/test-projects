--Assignment 2

--Create 2 basic tables, 1 for activity and 1 for revenue.
--Timestamps are used to attribute purchases to specific campaigns based on the time of the transaction.
CREATE TABLE campaign_activity.user_campaign_activity (
	 event_id INT PRIMARY KEY,
	 recipient_id INT,
	 campaign_link VARCHAR(518),
	 actions VARCHAR,
	 spend DECIMAL(10, 2),
	 event_timestamp TIMESTAMPTZ
);

CREATE TABLE campaign_activity.user_revenue_activity (
	 user_transnsaction_id INT PRIMARY KEY,
	 recipient_id INT,
	 revenue DECIMAL(10, 2),
	 purchase_at_timestamp TIMESTAMPTZ
);

--Inserting data into tables.
INSERT INTO campaign_activity.user_campaign_activity(event_id, recipient_id, campaign_link, actions, spend, event_timestamp)
VALUES
(1, 101, 'http://www.example.com?utm_campaign=last_chance&utm_medium=paid_search&utm_source=google&utm_content=footer_cta&utm_term=cashback', 'page_view', 0.50, '2025-01-01 08:00:00'),
(2, 101, 'http://www.example.com?utm_campaign=last_chance&utm_medium=paid_search&utm_source=google&utm_content=footer_cta&utm_term=cashback', 'click', 0.50, '2025-01-01 08:15:00'),
(3, 101, 'http://www.example.com?utm_campaign=last_chance&utm_medium=paid_search&utm_source=google&utm_content=footer_cta&utm_term=cashback', 'purchase', 0.50, '2025-01-01 09:30:00'),
(4, 102, 'http://www.example.com?utm_campaign=holiday_promo&utm_medium=paid_social&utm_source=facebook&utm_content=cta_buy_now&utm_term=save', 'page_view', 0.90, '2025-01-02 10:00:00'),
(5, 102, 'http://www.example.com?utm_campaign=holiday_promo&utm_medium=paid_social&utm_source=facebook&utm_content=cta_buy_now&utm_term=save', 'click', 0.90, '2025-01-02 10:30:00'),
(6, 102, 'http://www.example.com?utm_campaign=holiday_promo&utm_medium=paid_social&utm_source=facebook&utm_content=cta_buy_now&utm_term=save', 'purchase', 0.90, '2025-01-02 11:45:00'),
(7, 103, 'http://www.example.com?utm_campaign=winter_update&utm_medium=newsletter&utm_source=email&utm_content=text_ad_1&utm_term=discount', 'click', 0.75, '2025-01-03 12:00:00'),
(8, 103, 'http://www.example.com?utm_campaign=winter_update&utm_medium=newsletter&utm_source=email&utm_content=text_ad_1&utm_term=discount', 'purchase', 0.75, '2025-01-03 13:30:00'),
(9, 104, 'http://www.example.com?utm_campaign=back_to_school&utm_medium=social&utm_source=instaguser_revenuem&utm_content=text_ad_2&utm_term=discount', 'click', 0.00, '2025-01-04 09:15:00'),
(10, 104, 'http://www.example.com?utm_campaign=back_to_school&utm_medium=social&utm_source=facebook&utm_content=cta_shop_now&utm_term=discount', 'click', 0.00, '2025-01-04 10:30:00'),
(11, 104, 'http://www.example.com?utm_campaign=back_to_school&utm_medium=social&utm_source=facebook&utm_content=cta_shop_now&utm_term=discount', 'purchase', 0.00, '2025-01-04 11:45:00')

--Inserting data into revenue table.
INSERT INTO campaign_activity.user_revenue_activity(user_transnsaction_id, recipient_id, revenue, purchase_at_timestamp)
VALUES
(343, 101, 100.00, '2025-01-01 09:30:00'),
(346, 102, 200.00, '2025-01-02 11:45:00'),
(348, 103, 150.00, '2025-01-03 13:30:00'),
(351, 104, 300.00, '2025-01-04 11:45:00')

-----------------------------------------------------------------------------------------------------------------

-- The CTEs below make up the final model
CREATE TABLE campaign_activity.user_campaign_attribution_summary AS
-- Calculate total spend per campaign by recipient and campaign link
WITH total_spend_per_campaign AS (
    SELECT
        recipient_id,
        campaign_link,
        SUM(spend) AS total_spend
    FROM
        campaign_activity.user_campaign_activity
    GROUP BY
        recipient_id, campaign_link
),
--Instead of a qualify statement (postgress does not support it) max date where the action is 'click'
last_clicks AS (
    SELECT 
        recipient_id,
        campaign_link AS last_clicked_campaign_link,
        MAX(event_timestamp) AS last_click_timestamp
    FROM 
        campaign_activity.user_campaign_activity
    WHERE 
        actions = 'click'
    GROUP BY 
        recipient_id, last_clicked_campaign_link
),
--All touchpoints per campaign recipient which include page_views, clicks, and purchases
touchpoints AS (
    SELECT 
        user_revenue.recipient_id,
        COUNT(*) AS total_touchpoints
    FROM 
        campaign_activity.user_campaign_activity user_activity
    INNER JOIN campaign_activity.user_revenue_activity user_revenue
    	ON user_activity.recipient_id = user_revenue.recipient_id
        AND user_activity.event_timestamp <= user_revenue.purchase_at_timestamp
    GROUP BY 
        user_revenue.recipient_id
),
-- Joining attributes. Including the coalesce allows a 0 value to be taken if touchpoints are null.
-- Row_number call allows 1 value to be selected in the final model.
attributed_purchases AS (
    SELECT 
        last_clicks.recipient_id,
        last_clicks.last_clicked_campaign_link,
        last_clicks.last_click_timestamp,
        user_revenue.revenue,
        user_revenue.purchase_at_timestamp,
        COALESCE(touchpoints.total_touchpoints, 0) AS total_touchpoints,
		ROW_NUMBER() OVER (PARTITION BY last_clicks.recipient_id ORDER BY user_revenue.purchase_at_timestamp DESC) AS row_num
    FROM 
        last_clicks
    LEFT JOIN touchpoints
    	ON last_clicks.recipient_id = touchpoints.recipient_id
    LEFT JOIN campaign_activity.user_revenue_activity user_revenue
    	ON last_clicks.recipient_id = user_revenue.recipient_id
        AND user_revenue.purchase_at_timestamp > last_clicks.last_click_timestamp
),
final_model AS (
	SELECT 
	    attributed_purchases.recipient_id,
	    attributed_purchases.last_clicked_campaign_link,
		REGEXP_REPLACE(split_part(split_part(attributed_purchases.last_clicked_campaign_link, 'utm_campaign=', 2), '&', 1), '[^A-Za-z\s]', ' ', 'g') AS utm_campaign,
		REGEXP_REPLACE(split_part(split_part(attributed_purchases.last_clicked_campaign_link, 'utm_medium=', 2), '&', 1), '[^A-Za-z\s]', ' ', 'g') AS utm_medium,
		REGEXP_REPLACE(split_part(split_part(attributed_purchases.last_clicked_campaign_link, 'utm_source=', 2), '&', 1), '[^A-Za-z\s]', ' ', 'g') AS utm_source,
		REGEXP_REPLACE(split_part(split_part(attributed_purchases.last_clicked_campaign_link, 'utm_content=', 2), '&', 1), '[^A-Za-z\s]', ' ', 'g') AS utm_content,
		REGEXP_REPLACE(split_part(split_part(attributed_purchases.last_clicked_campaign_link, 'utm_term=', 2), '&', 1), '[^A-Za-z\s]', ' ', 'g') AS utm_term,
	    attributed_purchases.last_click_timestamp,
	    attributed_purchases.total_touchpoints,
	    attributed_purchases.revenue,
		total_spend_per_campaign.total_spend,
	    attributed_purchases.purchase_at_timestamp
	FROM 
	    attributed_purchases
	 LEFT JOIN total_spend_per_campaign
        ON attributed_purchases.recipient_id = total_spend_per_campaign.recipient_id
        AND attributed_purchases.last_clicked_campaign_link = total_spend_per_campaign.campaign_link
	WHERE 
	    row_num = 1
)
SELECT * FROM final_model;

----------------------------------------------------------------------------------------------------------------


SELECT * FROM campaign_activity.user_campaign_attribution_summary;














