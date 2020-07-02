# 캐릭터SET 설정
SET NAMES utf8mb4;

# DB 생성
DROP DATABASE IF EXISTS site25;
CREATE DATABASE site25;
USE site25;

# 카테고리 테이블 생성
DROP TABLE IF EXISTS cateItem;
CREATE TABLE cateItem (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    `name` CHAR(100) NOT NULL UNIQUE
);

# 카테고리 아이템 추가
INSERT INTO cateItem SET regDate = NOW(), `name` = 'IT/자바';
INSERT INTO cateItem SET regDate = NOW(), `name` = 'IT/HTML_CSS_JS';
INSERT INTO cateItem SET regDate = NOW(), `name` = 'IT/상식';
INSERT INTO cateItem SET regDate = NOW(), `name` = 'IT/그외상식';
INSERT INTO cateItem SET regDate = NOW(), `name` = '공부계획';
INSERT INTO cateItem SET regDate = NOW(), `name` = '일상';

SELECT *
FROM cateItem;

# 아티클 테이블 생성
DROP TABLE IF EXISTS article;

CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    cateItemId INT(10) UNSIGNED NOT NULL,
    displayStatus TINYINT(1) UNSIGNED NOT NULL,
    `title` CHAR(200) NOT NULL,
    `body` TEXT NOT NULL
);

SELECT *
FROM article;

# 글생성
INSERT INTO article SET 
regDate = NOW(), 
updateDate = NOW(),
cateItemId = 1,
displayStatus = 1,
`title` = '제목',
`body` = '내용';

SELECT *
FROM article
WHERE displayStatus = 1 AND cateItemId = 1
ORDER BY id DESC LIMIT 0,5

# where 조건에 맞는 총 개수 출력
SELECT COUNT(*)
FROM article
WHERE displayStatus = 1 AND cateItemId = 1
ORDER BY id DESC LIMIT 0,5

# 글생성
INSERT INTO article SET 
regDate = NOW(), 
updateDate = NOW(),
cateItemId = 6,
displayStatus = 1,
`title` = CONCAT('제목_', RAND()),
`body` = CONCAT('내용_', RAND());