Project MyDatabase {
database_type: "PostgreSQL"
}

// TABLES

Table public.users {
user_id Int [primary key, increment]
username String [unique, note: "VarChar(50)"]
email String [unique, note: "VarChar(100)"]
bio String [note: "Text"]
encrypted_password String [note: "VarChar(255)"]
profile_picture_url String [note: "VarChar(255)"]
phone_number String [note: "VarChar(20)"]
email_verification_token String [note: "VarChar(255)"]
points Int [default: 2000]
level Int [default: 1]
is_email_verified Boolean [default: false]
role role [default: "USER"]
account_status accountStatus [default: "ACTIVE"]
sign_up_ip String [note: "VarChar(45)"]
login_count Int [default: 0]
created_at timestamptz [default: `now()`, not null]
last_login_at timestamptz
updated_at timestamptz
deleted_at timestamptz
}

Table public.levelthreshold {
level Int [primary key]
min_posts Int
min_comments Int
min_likes Int
min_logins Int [default: 0]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.ad_banner {
id Int [primary key, increment]
position String
company_name String
contract_period Int
contract_date timestamptz
start_date timestamptz
end_date timestamptz
image_url String
status ad_banner_status [default: "INACTIVE"]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.social_login {
social_login_id Int [primary key, increment]
user_id Int
provider provider
provider_user_id String [note: "VarChar(255)"]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.follow {
follow_id Int [primary key, increment]
follower_id Int
following_id Int
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.auth_code {
id Int [primary key, increment]
user_id Int [unique]
code String [unique, default: `uuid_generate_v4()`, note: "Uuid"]
koreaant_code String [unique, default: `uuid_generate_v4()`, note: "Uuid"]
expired_at timestamptz
createdAt timestamptz [default: `now()`, not null]
}

Table public.point {
point_id Int [primary key, increment]
user_id Int
points_change Int
change_reason String [note: "VarChar(255)"]
is_bet Boolean [default: false]
related_bet_id Int  
 change_date timestamptz [default: `now()`, not null]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.topic {
topic_id Int [primary key, increment]
title String [note: "VarChar(255)"]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.category {
category_id Int [primary key, increment]
topic_id Int
category_name String [note: "VarChar(100)"]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.media {
media_id Int [primary key, increment]
post_id Int  
 comment_id Int  
 media_type media_type
media_url String [note: "VarChar(255)"]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.comment {
comment_id Int [primary key, increment]
post_id Int
user_id Int
content String [note: "Text"]
parent_comment_id Int  
 status comment_status [default: "PUBLIC"]
likes Int [default: 0]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
isSelected Boolean [default: false]
}

Table public.comment_like {
comment_like_id Int [primary key, increment]
comment_id Int
user_id Int
liked_at timestamptz [default: `now()`, not null]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.post {
post_id Int [primary key, increment]
user_id Int
category_id Int
type post_type
status post_status [default: "PUBLIC"]
views Int [default: 0]
likes Int [default: 0]
comments Int [default: 0]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.post_general {
general_id Int [primary key, increment]
post_id Int [unique]
title String [note: "VarChar(255)"]
content String [note: "Text"]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.post_column {
column_id Int [primary key, increment]
post_id Int [unique]
title String [note: "VarChar(255)"]
content String [note: "Text"]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.post_question {
question_id Int [primary key, increment]
post_id Int [unique]
title String [note: "VarChar(255)"]
content String [note: "Text"]
points Int [default: 0]
isAnswered Boolean [default: false]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.like {
like_id Int [primary key, increment]
post_id Int
user_id Int
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.tag {
tag_id Int [primary key, increment]
tag_name String [unique, note: "VarChar(100)"]
is_admin_tag Boolean [default: false]
usage_count Int [default: 0]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.post_tag {
post_tag_id Int [primary key, increment]
post_id Int
tag_id Int
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.post_view {
post_view_id Int [primary key, increment]
post_id Int
ip_address String [note: "VarChar(45)"]
viewed_at timestamptz [default: `now()`, not null]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.admin_action {
action_id Int [primary key, increment]
admin_user_id Int
target_type target_type
target_id Int
action_type action_type
reason String [note: "Text"]
action_timestamp timestamptz [default: `now()`, not null]
}

Table public.report {
report_id Int [primary key, increment]
target_type report_target_type
target_id Int
reported_user_id Int
reporter_user_id Int
reason String [note: "Text"]
status report_status [default: "PENDING"]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
resolved_at timestamptz
resolved_by_user_id Int  
}

Table public.user_block {
block_id Int [primary key, increment]
blocker_id Int
blocked_id Int
created_at timestamptz [default: `now()`, not null]
deleted_at timestamptz
}

Table public.admin_block {
admin_block_id Int [primary key, increment]
admin_id Int
blocked_user_id Int
reason String [note: "Text"]
created_at timestamptz [default: `now()`, not null]
unblocked_at timestamptz
block_count Int [default: 1]
updated_at timestamptz [default: `now()`, not null]
}

Table public.stock {
stock_id Int [primary key, increment]
name String [note: "VarChar(100)"]
symbol String [unique, note: "VarChar(10)"]
description String  
 created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.bet_post {
bet_post_id Int [primary key, increment]
user_id Int  
 title String [note: "VarChar(255)"]
content String [note: "Text"]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.bet {
bet_id Int [primary key, increment]
user_id Int
stock_id Int
bet_post_id Int  
 bet_amount Int  
 direction bet_direction
fixed_odds Float  
 status bet_status [default: "OPEN"]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
resolved_at timestamptz
}

Table public.bet_comment {
bet_comment_id Int [primary key, increment]
bet_post_id Int
user_id Int
content String [note: "Text"]
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.bet_like {
bet_like_id Int [primary key, increment]
bet_post_id Int  
 bet_comment_id Int  
 user_id Int
created_at timestamptz [default: `now()`, not null]
updated_at timestamptz
deleted_at timestamptz
}

Table public.market_event {
event_id Int [primary key, increment]
stock_id Int
closing_price Float
event_date timestamptz [default: `now()`, not null]
resolved_at timestamptz
}

// RELATIONSHIPS

Ref: public.auth_code.user_id > public.users.user_id [delete: 'SET NULL']

Ref: public.follow.follower_id > public.users.user_id [delete: 'SET NULL']
Ref: public.follow.following_id > public.users.user_id [delete: 'SET NULL']

Ref: public.social_login.user_id > public.users.user_id [delete: 'SET NULL']

Ref: public.point.user_id > public.users.user_id [delete: 'SET NULL']

Ref: public.category.topic_id > public.topic.topic_id [delete: 'SET NULL']

Ref: public.media.post_id > public.post.post_id [delete: 'SET NULL']
Ref: public.media.comment_id > public.comment.comment_id [delete: 'SET NULL']

Ref: public.comment.user_id > public.users.user_id [delete: 'SET NULL']
Ref: public.comment.post_id > public.post.post_id [delete: 'SET NULL']

Ref: public.comment_like.comment_id > public.comment.comment_id [delete: 'SET NULL']
Ref: public.comment_like.user_id > public.users.user_id [delete: 'SET NULL']

Ref: public.post.user_id > public.users.user_id [delete: 'SET NULL']
Ref: public.post.category_id > public.category.category_id [delete: 'SET NULL']

Ref: public.post_general.post_id > public.post.post_id [delete: 'SET NULL']

Ref: public.post_column.post_id > public.post.post_id [delete: 'SET NULL']

Ref: public.post_question.post_id > public.post.post_id [delete: 'SET NULL']

Ref: public.like.post_id > public.post.post_id [delete: 'SET NULL']
Ref: public.like.user_id > public.users.user_id [delete: 'SET NULL']

Ref: public.post_tag.post_id > public.post.post_id [delete: 'SET NULL']
Ref: public.post_tag.tag_id > public.tag.tag_id [delete: 'SET NULL']

Ref: public.post_view.post_id > public.post.post_id [delete: 'SET NULL']

Ref: public.admin_action.admin_user_id > public.users.user_id [delete: 'SET NULL']

Ref: public.report.reported_user_id > public.users.user_id [delete: 'SET NULL']
Ref: public.report.reporter_user_id > public.users.user_id [delete: 'SET NULL']

Ref: public.user_block.blocker_id > public.users.user_id [delete: 'SET NULL']
Ref: public.user_block.blocked_id > public.users.user_id [delete: 'SET NULL']

Ref: public.admin_block.admin_id > public.users.user_id [delete: 'SET NULL']
Ref: public.admin_block.blocked_user_id > public.users.user_id [delete: 'SET NULL']

Ref: public.bet_post.user_id > public.users.user_id [delete: 'SET NULL']

Ref: public.bet.user_id > public.users.user_id [delete: 'SET NULL']
Ref: public.bet.stock_id > public.stock.stock_id [delete: 'SET NULL']
Ref: public.bet.bet_post_id > public.bet_post.bet_post_id [delete: 'SET NULL']

Ref: public.bet_comment.bet_post_id > public.bet_post.bet_post_id [delete: 'SET NULL']
Ref: public.bet_comment.user_id > public.users.user_id [delete: 'SET NULL']

Ref: public.bet_like.bet_post_id > public.bet_post.bet_post_id [delete: 'SET NULL']
Ref: public.bet_like.bet_comment_id > public.bet_comment.bet_comment_id [delete: 'SET NULL']
Ref: public.bet_like.user_id > public.users.user_id [delete: 'SET NULL']

Ref: public.market_event.stock_id > public.stock.stock_id [delete: 'SET NULL']
