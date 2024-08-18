-- topic 테이블에 더미 데이터 삽입
-- category 테이블에 더미 데이터 삽입
-- sql문 그냥 넣고 돌리면 됨

-- 토픽 삽입
INSERT INTO public."topic" (title, created_at, updated_at, deleted_at) VALUES
('주식 예측', NOW(), NULL, NULL),
('상품 예측', NOW(), NULL, NULL),
('경제 지표 예측', NOW(), NULL, NULL),
('인간지표 랭킹', NOW(), NULL, NULL),
('커뮤니티 토론', NOW(), NULL, NULL);

-- 카테고리 삽입
INSERT INTO public."category" (topic_id, category_name, created_at, updated_at, deleted_at) VALUES
((SELECT topic_id FROM public."topic" WHERE title = '주식 예측'), '한국 주식', NOW(), NULL, NULL),
((SELECT topic_id FROM public."topic" WHERE title = '주식 예측'), '미국 주식', NOW(), NULL, NULL),
((SELECT topic_id FROM public."topic" WHERE title = '주식 예측'), '신흥시장 주식', NOW(), NULL, NULL),
((SELECT topic_id FROM public."topic" WHERE title = '상품 예측'), '유가', NOW(), NULL, NULL),
((SELECT topic_id FROM public."topic" WHERE title = '상품 예측'), '금값', NOW(), NULL, NULL),
((SELECT topic_id FROM public."topic" WHERE title = '상품 예측'), '원자재', NOW(), NULL, NULL),
((SELECT topic_id FROM public."topic" WHERE title = '경제 지표 예측'), '환율', NOW(), NULL, NULL),
((SELECT topic_id FROM public."topic" WHERE title = '경제 지표 예측'), '금리', NOW(), NULL, NULL),
((SELECT topic_id FROM public."topic" WHERE title = '경제 지표 예측'), '인플레이션', NOW(), NULL, NULL),
((SELECT topic_id FROM public."topic" WHERE title = '인간지표 랭킹'), '상위 예측자', NOW(), NULL, NULL),
((SELECT topic_id FROM public."topic" WHERE title = '인간지표 랭킹'), '최근 랭킹 변화', NOW(), NULL, NULL),
((SELECT topic_id FROM public."topic" WHERE title = '커뮤니티 토론'), '자유 토론', NOW(), NULL, NULL),
((SELECT topic_id FROM public."topic" WHERE title = '커뮤니티 토론'), '피드백 및 제안', NOW(), NULL, NULL);

INSERT INTO levelthreshold (level, min_posts, min_comments, min_likes, min_logins, created_at)
VALUES
(1, 0, 0, 0, 1, '2024-08-12 02:48:27.472927'),
(2, 5, 10, 20, 5, '2024-08-12 02:48:27.472927'),
(3, 20, 40, 80, 10, '2024-08-12 02:48:27.472927'),
(4, 50, 100, 200, 20, '2024-08-12 02:48:27.472927'),
(5, 100, 200, 400, 30, '2024-08-12 02:48:27.472927'),
(6, 175, 350, 700, 40, '2024-08-12 02:48:27.472927'),
(7, 275, 550, 1100, 50, '2024-08-12 02:48:27.472927'),
(8, 400, 800, 1600, 60, '2024-08-12 02:48:27.472927'),
(9, 550, 1100, 2200, 70, '2024-08-12 02:48:27.472927'),
(10, 725, 1450, 2900, 80, '2024-08-12 02:48:27.472927'),
(11, 925, 1850, 3700, 90, '2024-08-12 02:48:27.472927'),
(12, 1150, 2300, 4600, 100, '2024-08-12 02:48:27.472927'),
(13, 1400, 2800, 5600, 110, '2024-08-12 02:48:27.472927'),
(14, 1700, 3400, 6800, 120, '2024-08-12 02:48:27.472927'),
(15, 2050, 4100, 8200, 130, '2024-08-12 02:48:27.472927'),
(16, 2450, 4900, 9800, 140, '2024-08-12 02:48:27.472927'),
(17, 2900, 5800, 11600, 150, '2024-08-12 02:48:27.472927'),
(18, 3400, 6800, 13600, 160, '2024-08-12 02:48:27.472927'),
(19, 3950, 7900, 15800, 170, '2024-08-12 02:48:27.472927'),
(20, 4550, 9100, 18200, 180, '2024-08-12 02:48:27.472927');
