/*Статьи и комментарии:
статья может иметь несколько комментариев
комментарий может принадлежать только одной статье
статья - название, текст, дата публикации
комментарий - текст, количество лайков*/

DROP TABLE IF EXISTS article, note CASCADE;


CREATE TABLE IF NOT EXISTS article (
	id INTEGER PRIMARY KEY,
	name_ TEXT,
	text_ar TEXT,
	publication_data date
);

CREATE TABLE IF NOT EXISTS note (
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	text_note TEXT,
	likes INTEGER,
	article_id INTEGER REFERENCES article(id)
);

INSERT INTO article VALUES 
(1, 'article 1', 'comment 1', '2024.02.01'),
(2, 'article 2', 'comment 2', '2024.02.02'),
(3, 'article 3', 'comment 3', '2024.02.03');

INSERT INTO note(text_note, likes, article_id) VALUES
('text1', 10, 1),
('text2', 8, 1),
('text3', 3, 2);

SELECT a,
COALESCE(
json_agg(json_build_object(
	'note_id', n.id,
	'text', n.text_note,
	'likes', n.likes,
	'article_id', n.article_id
)) FILTER(WHERE n.id IS NOT null), '[]') AS note
FROM article a
LEFT JOIN note n ON a.id = n.article_id
GROUP BY a.id






/*Чаты и сообщения:
чат может иметь несколько сообщений
сообщение может принадлежать только одному чату

чат - название, дата создания
сообщение - текст, дата отправки*/

DROP TABLE IF EXISTS chat, message CASCADE;


CREATE TABLE IF NOT EXISTS chat (
	id INTEGER PRIMARY KEY,
	name_ TEXT,
	create_data date
);

CREATE TABLE IF NOT EXISTS message (
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	text_message TEXT,
	send_data date,
	chat_id INTEGER REFERENCES chat(id)
);

INSERT INTO chat VALUES 
(1, 'chat 1', '2024.02.01'),
(2, 'chat 2', '2024.02.02'),
(3, 'chat 3', '2024.02.03');

INSERT INTO message(text_message, send_data, chat_id) VALUES
('text1', '2024.02.05', 3),
('text2', '2024.02.06', 3),
('text3', '2024.02.07', 2);

SELECT c,
COALESCE(
json_agg(json_build_object(
	'message_id', m.id,
	'text', m.text_message,
	'send_data', m.send_data,
	'chat_id', m.chat_id
)) FILTER(WHERE m.id IS NOT null), '[]') AS message
FROM chat c
LEFT JOIN message m ON c.id = m.chat_id
GROUP BY c.id







/*Игры и отзывы:
игра может иметь несколько отзывов
отзыв может принадлежать только одной игре

игра - название, жанр, цена
отзыв - текст, оценка*/

DROP TABLE IF EXISTS game, review CASCADE;


CREATE TABLE IF NOT EXISTS game (
	id INTEGER PRIMARY KEY,
	name_ TEXT,
	genre text,
	price int
);

CREATE TABLE IF NOT EXISTS review (
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	text_review TEXT,
	rate int,
	game_id INTEGER REFERENCES game(id)
);

INSERT INTO game VALUES 
(1, 'game 1', 'horror', 51651),
(2, 'game 2', 'horror', 45668),
(3, 'game 3', 'horror', 3878);

INSERT INTO review(text_review, rate, game_id) VALUES
('text1', 3, 3),
('text2', 5, 1),
('text3', 4, 2);

SELECT g,
COALESCE(
json_agg(json_build_object(
	'review_id', r.id,
	'text', r.text_review,
	'rate', r.rate,
	'game_id', r.game_id
)) FILTER(WHERE r.id IS NOT null), '[]') AS review
FROM game g
LEFT JOIN review r ON g.id = r.game_id
GROUP BY g.id








