DROP DATABASE IF EXISTS blog;
CREATE DATABASE blog;
USE blog;

CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    title CHAR(200) NOT NULL,
    `body` LONGTEXT NOT NULL
);
SELECT *
FROM article;

TRUNCATE article;

INSERT INTO article SET regDate = NOW(), updateDate = NOW(), title = '제목', BODY = '내용내용'