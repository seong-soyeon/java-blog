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
INSERT INTO cateItem 
SET regDate = NOW(), 
    `name` = 'IT/자바';
INSERT INTO cateItem SET regDate = NOW(), `name` = 'IT/HTML_CSS_JS';
INSERT INTO cateItem SET regDate = NOW(), `name` = 'IT/상식';
INSERT INTO cateItem SET regDate = NOW(), `name` = 'IT/그외';
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
    `body` LONGTEXT NOT NULL
);

# 조회수,memberId 칼럼 추가
ALTER TABLE `article` ADD COLUMN `hit` INT(10) UNSIGNED NOT NULL AFTER `body`; 
ALTER TABLE `article` ADD COLUMN `memberId` INT(10) UNSIGNED NOT NULL AFTER `cateItemId`; 

# 기존 게시물의 작성자 번호를 1번으로 정리(통일)
UPDATE article
SET memberId = 1
WHERE memberId = 0;

SELECT COLUMN_TYPE FROM information_schema.COLUMNS WHERE TABLE_NAME=`article` AND COLUMN_NAME=`body`;
SHOW TABLES;
DESC `article`;

SELECT *
FROM article

# 댓글 테이블 생성
DROP TABLE IF EXISTS articleReply;
CREATE TABLE articleReply (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    articleId INT(10) UNSIGNED NOT NULL,
    `body` TEXT NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL
);

INSERT INTO `articleReply` SET regDate = NOW(), updateDate = NOW(), `body` = 'qq';
SELECT *
FROM articleReply

#원하는 조건의 아티클 출력
SELECT *
FROM article
WHERE displayStatus = 1 AND cateItemId = 2
ORDER BY id DESC LIMIT 0,5

# where 조건에 맞는 총 개수 출력
SELECT COUNT(*)
FROM article
WHERE displayStatus = 1 AND cateItemId = 2
ORDER BY id DESC LIMIT 0,5

# 글생성
INSERT INTO article SET 
regDate = NOW(), 
updateDate = NOW(),
cateItemId = 2,
displayStatus = 1,
`title` = CONCAT('제목_', RAND()),
`body` = CONCAT('내용_', RAND());

# 멤버 테이블 생성/암호화된 긴 pw를 저장해야 하므로 loginPw 공간 크게 만들어 놓기
DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `loginId` CHAR(100) NOT NULL UNIQUE,
    `loginPw` CHAR(255) NOT NULL,
    `name` CHAR(100) NOT NULL,
    `nickname` CHAR(100) NOT NULL UNIQUE,
    `email` CHAR(200) NOT NULL,
    `level` INT(1) UNSIGNED DEFAULT 0 NOT NULL
);
# 회원가입시 인증메일 발송을 위한 칼럼 추가
ALTER TABLE `member` ADD COLUMN mailAuthCode CHAR(100) NOT NULL AFTER `level`;
# 회원가입 인증 여부 칼럼 추가
ALTER TABLE `member` ADD COLUMN mailAuthStatus TINYINT(1) UNSIGNED NOT NULL AFTER mailAuthCode;

# 마스터 회원 생성
INSERT INTO `member` SET
regDate = NOW(),
updateDate = NOW(),
`loginId` = 'admin',
`loginPw` = SHA2('admin', 256),
`name` = 'admin',
`nickname` = 'admin',
`email` = 'admin@admin.com',
`level` = 10;

SELECT * FROM `member`;
SELECT * FROM article;
SELECT * FROM articleReply;