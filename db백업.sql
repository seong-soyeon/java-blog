/*
SQLyog Community v13.1.5  (64 bit)
MySQL - 10.1.45-MariaDB : Database - site25
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`site25` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `site25`;

/*Table structure for table `article` */

DROP TABLE IF EXISTS `article`;

CREATE TABLE `article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `cateItemId` int(10) unsigned NOT NULL,
  `displayStatus` tinyint(1) unsigned NOT NULL,
  `title` char(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `hit` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `article` */

insert  into `article`(`id`,`regDate`,`updateDate`,`cateItemId`,`displayStatus`,`title`,`body`,`hit`) values 
(1,'2020-07-01 12:45:42','2020-07-01 12:45:42',6,1,'블로그시작??','# 블로그 시작합니다.??\r\n\r\n## 반갑습니다.\r\n\r\n![화성](https://cdn.pixabay.com/photo/2019/01/13/07/17/mars-3929876_960_720.jpg)',0),
(2,'2020-07-01 12:45:43','2020-07-01 12:45:43',1,1,'GIT사용법','### 사용자 등록\r\n> git config --global user.name \"유저 아이디\"\r\n> git config --global user.email \"유저 이메일\"\r\n\r\n+ 로그인 정보 없애기\r\n> git config --global credential.helper manager\r\n> git credential-manager delete https://github.com  \r\n\r\n---\r\n---\r\n### 작업후 Git에 올리기\r\n> git status\r\n> git add .\r\n> git commit -m \"커밋\"\r\n> git push origin master',0),
(3,'2020-07-01 12:45:43','2020-07-01 12:45:43',1,1,'algorithm','### algorithm\r\n\r\n<br><br>\r\n\r\n복잡하고 어렵게 느껴졌던 알고리즘이라는 단어가,\r\n\r\n최근들어 \'유튜브 알고리즘\'이라는 말로, 이곳저곳에서 유행처럼 사용되며 친숙해졌다.\r\n\r\nIT나 프로그래밍에 국한되지않고 자유롭게 사용되는 것이 재미있기는 하지만, 본질을 잘 모르고 사용하고 있다는 생각이 들어 정리해 보았다.\r\n\r\n<br><br>\r\n\r\n우선 네이버 사전에 검색한 결과이다.\r\n![algorithm](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fk.kakaocdn.net%2Fdn%2Fcvj4sr%2FbtqFgxSaF84%2F1ZyFsSefYTlUiwDvx2VYDk%2Fimg.png)쉽게 \'문제해결을 위한 단계들의 모임\'이라고 설명하는 컴퓨터 과학자도 있다.\r\n\r\n<br><br>\r\n\r\n하나의 목표에 도달하기 위해서는 수많은 경로가 있다. 이 경로들을 모~두 모아 알고리즘이라고 표현할 수 있다.\r\n\r\n그 경로중에는 단순하고 생각해 내기 쉬우나, 효율적이지 않은 무식한 경로가 있을 것이다. 효율적이진 않지만 정확하게 목표에 도달하는 이러한 알고리즘을 <b>brute force algorithm</b> (->짐승 무력 알고리즘) 라고 한다. 가장 효율적인 방법은 아니지만 이 알고리즘으로부터 더 좋은 알고리즘으로 발전할 가능성이 있기 때문에 컴퓨터 공학에서 brute force algorithm은 중요하게 여겨진다.\r\n\r\n<b>그렇다면 좋은 알고리즘이란 무엇일까??</b>\r\n\r\n<span style=\"background-color: #c1bef9;\"><u><b>정확성</b></u>과 <u><b>효율성</b></u>을 모두 갖춘 알고리즘</span>을 좋은 알고리즘이라 말할 수 있을 것이다.\r\n\r\n여러 실험을 통해서 그 정확성과 효율성이 검증되었다면 00알고리즘 이라는 독자적인 이름이 붙은 네임드 알고리즘이 된다.\r\n\r\n아래는 대표적인 7가지 <b>네임드 알고리즘</b> 이다.\r\n<ol><ol>\r\n<li>Recursive algorithms</li>\r\n<li>Dynamic programming algorithm</li>\r\n<li>Backtracking algorithm</li>\r\n<li>Divide and conquer algorithm</li>\r\n<li>Greedy algorithm</li>\r\n<li>Brute Force algorithm</li>\r\n<li>Randomized algorithm</li>\r\n</ol></ol>\r\n<br><br>\r\n좋은 알고리즘을 판별하는 직관적인 방법으로는 같은 문제를 각각의 알고리즘으로 돌려본 후, 그 속도와 코드 길이를 비교해 보는 방법 등이 있다. 물론 문제에 따라 좋은 알고리즘은 매번 다를 것이다. \r\n<br><br>\r\n예) 문제 :  1000p에 달하는 책의 890p를 펴라.\r\n\r\nbrute force algorithm는 1p 부터 한장씩 넘긴다면, divide and conquer algorithm(-> 나누어서 정복하는 알고리즘)의 경우 절반을 가르고 500~1000p의 책을 또 절반을 가르는 등의 방식으로 목표인 890p에 도달하는 것이다. 이 문제에서는 divide and conquer algorithm이 더욱 빠르고 효율적일 것이다.\r\n\r\n<br><br> \r\n\r\n상황에 따라서 위처럼 검증된 네임드 알고리즘이라 하여도 효율적이지 못한 알고리즘이 될 수 있다.\r\n\r\n가장 중요한 것은 <b>나 스스로가 문제해결을 하기위해 어떤 방법을 생각해 내느냐</b> 일 것 이다.',0),
(4,'2020-07-01 12:48:08','2020-07-01 12:48:08',1,1,'페이징, 카테고리별 분류','# 페이징, 카테고리별 분류\r\n\r\n## 힌트 코드(http://localhost:8081/blog/s/article/list?cateItemId=2&page=2)\r\n\r\n### 코드1\r\nSELECT COUNT(*) FROM article WHERE cateItemid = 2\r\n\r\n### 코드2\r\nint itemsInAPage = 5;   //한 페이지에 나오는 게시물 수\r\nint limitFrom = (page - 1) * itemsInAPage;\r\n\r\n### 코드3\r\nint totalPage = Math.ceil((double)totalCount / itemsInAPage);\r\n```html\r\n<a href=\"${pageContext.request.contextPath}/s/article?cateItemId= {$param.cateItemId}&page=<%=i%>\"></a>\r\n```',0),
(5,'2020-07-02 12:31:23','2020-07-02 12:31:23',5,1,'20.07.02 공부계획','list랑 detail 표 없애기\r\n\r\n메인에 사진넣어보기\r\n\r\n동양상 11:33 부터\r\n\r\n\r\n',0),
(6,'2020-07-05 00:52:54','2020-07-05 00:52:54',1,1,'HTTP/URL/HTML/WWW','인터넷의 아버지 라고도 불리우는 \'Tim Berners-Lee\'가 전세게를 잊는 네트워크 망을 만듬\r\n\r\n규칙 : <b>HTTP(HyperText Transfer Protocol)</b> - 네트워트 망에서 대화할 때 따라야 하는하이퍼텍스트 전송 규칙\r\n\r\n참조 : <b>URL(Uniform Resource Locator)</b> - 각 페이지의 위치와 이름 구분을 위한 주소(균일화 된 자원 위치)\r\n\r\n언어 : <b>HTML(HyperText Mark-up Language)</b> - 하이퍼텍스트를 꾸미는 언어(네트워크 망에서 쓰는 언어)\r\n\r\n<b>WWW(World Wide Web)</b> : HTTP규칙 안에서 URL이라는 주소를 갖는, 전세게에서 이용하는 큰 네트워크망 \r\n',0),
(7,'2020-07-06 00:08:45','2020-07-06 00:08:45',1,1,'URL vs URI','# URL vs URI\r\n\r\n### URL(Uniform Resource Locator)\r\n- 직역 : 균일화 된 <b>자원 위치</b>\r\n- 각 페이지의 위치와 이름 구분을 위한 주소\r\n- 네트워크 상에서 해당 <b>자원(파일)</b>이 어디 있는지를 알려주는 문자열\r\n- 형식 : 프로토콜://호스트이름:포트/디렉토리명/파일명\r\n\r\n##\r\n\r\n### URL(Uniform Resource Identifier)\r\n- 직역 : 균일화 된 <b>자원 식별자</b>\r\n- 특정 <b>사이트</b>를 접속하기 위해 인터넷 주소창에 적는 문자열\r\n- URL 은 URI의 하위 개념이라 볼 수 있다.',0),
(8,'2020-07-07 11:40:51','2020-07-07 11:40:51',2,1,'유튜브삽입확인','```youtube\r\n3b7FLwej3V4\r\n```',0),
(9,'2020-07-07 12:23:59','2020-07-07 12:23:59',2,1,'??HTML 기초 1강??','# HTML 기초 1강\r\n\r\nHTML을 이용하여 작업을 할 때 어떤 태그를 사용 해야 할지, 또 각 태그의 default 값은 무엇인지에 대해 아직 명확히 알지 못한다.\r\n그래서 태그를 중심으로 HTML관련글을 5\\~6강 정도로 나누어 정리글을 써보려 한다.\r\n<br>\r\n## 목차\r\n- 1강 : 엘리먼트 & 태그 종류\r\n- 2강 : 태그 별 특성&사용법\r\n- 3강 : 태그 별 특성&사용법2:특이한태그\r\n- 4강 : 목록태그(UL,OL,LI,DL,DT,DD)\r\n- 5강 : 폰트태그\r\n- 6강 : 테이블 & 디자인\r\n\r\n<br>\r\n<hr><hr>\r\n이번 1강은 <b>\'태그의 종류와 아주 간략한 설명\'</b>으로,뒤에 작성할 게시물의 프리뷰나 목차 정도로 보면 된다.\r\n<br>\r\n\r\n### 1. 엘리먼트 & 태그\r\n- **태그(tag)** : \"<\"와 \">\"로 묶인 일련의 명령어   \r\n                : 태그 안에 태그가 들어갈 수 있으며, 가장 마직막에 연 태그부터 닫아야 한다.\r\n            - 시작태그 : <~>\r\n            - 종료태그 : </~>\r\n            - 빈태그 : <~> or <~/>  ex) br, hr, img 등 (닫지 않아도 되는 태그)\r\n\r\n- **엘리먼트(element)** : <시작태그> + 내용 + </종료태그>\r\n\r\n<br><br>\r\n### 2. 태그종류\r\n\r\n| 태그종류 |설명  |\r\n| --- | --- |\r\n| h1~6 | 제목 |\r\n| div | division / 박스 (무난템)|\r\n| nav | 박스(메뉴바로 많이 쓰임 |\r\n| span | 박스(inline) |\r\n| section | 박스 |\r\n| article | 박스 |\r\n| svg | Scalable Vector Graphic / 백터이미지를 만드는 영역 |\r\n| circle | 원을 생성(svg의 요소) |\r\n| title | 문서제목 |\r\n| p | Paragraph / 본문내용|\r\n| pre | 입력한 그대로 출력(공백포함) |\r\n| hr | 구분선 |\r\n| br | break / 줄바꿈 |\r\n| a | 링크연결 |\r\n| i | italic / 글자 기울임 |\r\n| b | bold / 글자 굵게 |\r\n| stron | 글자 굵게 |\r\n| img | 이미지 |\r\n| link | 외부 문서를 연결(ex-폰트, css파일) |\r\n| form | 설문지,로그인 창 등 웹에서의 입력 양식 |\r\n| input | 입력상자 |\r\n| button | 버튼생성 |\r\n| script | HTML 안에 JS삽입 |\r\n| meta | 웹에 보이지 않는 정보|\r\n| <!--| 주석 |\r\n| 목록 | --- |\r\n| ol | 순서 중요한 리스트 |\r\n| ul | 순서 중요치 않은 리스트 |\r\n| li | 실제 리스트 내용(ol과 ul의 자식) |\r\n| 테이블 | --- |\r\n| table | 표 |\r\n| thead | 표헤드 |\r\n| tbody | 표바디 |\r\n| th | 셀 저목 |\r\n| tr | 행 |\r\n| td | 각 행의 열(tr의 자식 처럼 사용) |\r\n| colgroup | 열의 그룹화 |\r\n| col | 열의 속성값 지정 |\r\n\r\n<br><br>\r\n+ 태그와는 무관하지만 &emsp; <<공백코드>>\r\n&nbsp :공백 한칸 (뒤에 ; 붙이기)\r\n&ensp :공백 두칸 (뒤에 ; 붙이기)\r\n&emsp :공백 네칸 (뒤에 ; 붙이기)',6),
(10,'2020-07-07 19:21:52','2020-07-07 19:21:52',4,1,'참고 사이트 모음','# 참고 사이트 모음\r\n\r\n## [토스트 에디터](https://cdpn.io/jangka44/debug/eYJREry)\r\n## [벨로그](https://velog.io/)\r\n## [우아한형제들 기술블로그](https://woowabros.github.io/)\r\n## [이모지](https://www.emojiengine.com/ko/)\r\n## [픽사베이-무료사진](https://pixabay.com/ko/)\r\n## [코딩팩토리](https://coding-factory.tistory.com/)',0),
(11,'2020-07-08 09:33:33','2020-07-08 09:33:33',3,1,'MYSQL쿼리 모음','# MYSQL 쿼리 모음(ing)\r\n\r\n* `는 생략해도 되지만 생략안하는걸 추천\r\n* COLUMN은 생략해도 되는 듯 하다.\r\n\r\n<br>\r\n\r\n## 테이블에 컬럼 추가\r\n* 맨 뒤 추가\r\n<pre>\r\nALTER TABLE `테이블명`\r\nADD COLUMN `추가할컬럼명` 컬럼자료형;\r\n</pre>\r\n* 맨 앞 추가\r\n<pre>\r\nALTER TABLE `테이블명`\r\nADD COLUMN `추가할컬럼명` 컬럼자료형\r\nFIRST;\r\n</pre>\r\n- 원하는 위치 추가\r\n<pre>\r\nALTER TABLE `테이블명`\r\nADD COLUMN `추가할컬럼명` 컬럼자료형\r\nAFTER `넣고싶은위치이전컬럼명`; \r\n</pre>\r\n## 컬럼명 변경\r\n<pre>\r\nALTER TABLE `테이블명`\r\nCHANGE `기존컬럼명` `변경할컬럼명` 기존컬럼자료형;\r\n</pre>\r\n\r\n## 컬럼 자료형 변경\r\n<pre>\r\nALTER TABLE `테이블명` \r\nMODIFY `컬럼명` 변경할컬럼자료형;\r\n</pre>\r\n<pre>\r\nALTER TABLE `테이블명` \r\nCHANGE `컬럼명` `컬럼명` 변경할컬럼자료형;\r\n</pre>\r\n- 덧, 자료형 변경 확인\r\n<pre>\r\n    DESC `테이블명`;\r\n</pre>\r\n\r\n## 컬럼 순서 변경\r\n<pre>\r\nALTER TABLE `테이블명`\r\nMODIFY `순서변경할컬럼명` 컬럼자료형\r\nAFTER `넣고싶은위치이전컬럼명`; \r\n</pre>\r\n\r\n## 컬럼 삭제\r\n<pre>\r\nALTER TABLE `테이블명` \r\nDROP COLUMN `삭제할컬럼명`;\r\n</pre>\r\n\r\n\r\n<hr><hr><hr><hr><hr>\r\n\r\n##  카테고리 아이템 추가\r\n<pre>\r\nINSERT INTO cateItem \r\nSET regDate = NOW(), \r\n    `name` = \'IT/그외상식\';\r\n</pre>\r\n\r\n\r\n## 카테고리 이름 변경(그외상식 > 그외)\r\n<pre>\r\nUPDATE cateItem\r\nSET `name` = \'IT/그외\'\r\nWHERE `name` = \'IT/그외상식\';\r\n</pre>\r\n\r\n\r\n\r\n<br><br><br><br>\r\n~~+ 옆 목차(??)에서 변경 원하는 테이블 클릭하고 F6해도됨~~',1),
(12,'2020-07-08 10:52:10','2020-07-08 10:52:10',5,1,'20.07.08 공부계획','# 20.07.08 공부계획\r\n- sql 자료형 변경!!!  (완료-MYSQL쿼리도 정리해놓음)\r\n<br>\r\n- 내용 안나옴  (완료-캐쉬쌓인거였음....ㅜ)\r\n<br>\r\n- 카테고리명 다시 정하기\r\n    - 정하고 바뀐거 블로그에 수정까지\r\n<br>\r\n- 집컴 연결오류 수정\r\n<br>\r\n- 모든 버튼 정렬&연결하기 (시작)\r\n<br>\r\n- 디테일?뒤에 cateitem도 나와와하나??\r\n<br>\r\n- 디테일 카테아이템 칸에 번호랑 같이 한글로도 나오게 하기\r\n<br>\r\n- 앵귤러(구글이 만듬) 살펴보기\r\n        -타임스크립트기초 https://typescript-kr.github.io/pages/tutorials/typescript-in-5-minutes.html\r\n        -앵귤러기초 https://angular.kr/start',0),
(13,'2020-07-10 13:18:19','2020-07-10 13:18:12',5,1,'20.07.10 공부계획','- 모든 sql에 secsql적용 (완료)\r\n- 글 등록 폼에, 토스트 에디터 적용 (게시물 수정 삭제 후에 하기)\r\n- 회원가입 (secsql 했더니 오류남 실수있는듯)\r\n- 조회수 기능 추가 (완료)\r\n- 게시물 삭제 기능 추가\r\n- 게시물 수정 기능 추가',3),
(14,'2020-07-10 11:00:26','2020-07-10 11:00:26',5,1,'20.07.xx 주말 공부계획','# 2020 07 10 금토일 목표\r\n## 0. 영상 올리기(완료)\r\n## ***1. <서블릿/JSP로 게시판 만들기> 첨부터 조금씩 다시(완료)\r\n\r\n## ***2. 회원가입 오류수정(완료)\r\n\r\n## ***3. SQL 인젝션방어 - 게시물(완료)\r\n\r\n## ***4. SQL 인젝션방어 - 회원가입(완료)\r\n\r\n## ***5. 게시물 수정 기능 추가\r\n\r\n## ***6. 게시물 삭제 기능 추가(완료)\r\n\r\n## 7. 글 등록 폼에 토스트 에디터 적용\r\n\r\n## 8. 노트북 개발 환경세팅\r\n\r\n## 9. 블로그 글쓰기',2),
(15,'2020-07-10 00:26:07','2020-07-10 00:26:07',2,1,'????????HTML 기초 2강????????','# HTML 기초 2강\r\n\r\n## 태그의 속성\r\n```html\r\n- HTML에는 <head>,<h1>,<div>,<img>,<table> 등과 같이 약속된 기능을 갖는 태그가 미리 정의되어 있다.\r\n- 우리는 용도에 맞게 태그를 사용할 수 있다.\r\n- 태그들은 각각 속성을 부여할 수 있다.\r\n- <태그 속성=\"원하는 속성값\"> 과 같이 사용 할 수 있다.\r\n```\r\n\r\n\r\n### id, class 속성\r\n',3),
(16,'2020-07-11 00:26:44','2020-07-11 00:26:44',2,1,'????????HTML 기초 3강????????','',0),
(17,'2020-07-11 00:33:52','2020-07-11 00:33:52',2,1,'????????HTML 기초 4강????????','',0),
(18,'2020-07-12 09:10:01','2020-07-12 09:10:01',2,1,'????????HTML 기초 5강????????','',0),
(19,'2020-07-13 10:28:03','2020-07-13 10:28:03',2,1,'????????HTML 기초 6강????????','',1),
(20,'2020-07-13 10:46:34','2020-07-13 10:46:39',5,1,'20.07.13 공부계획','# 2020 07 13 월요일 목표\r\n## ***1. <서블릿/JSP로 게시판 만들기> 첨부터 조금씩 다시\r\n\r\n## ***2. 게시물 본문에 `</+script>`가 들어가면 뷰어가 작동하지 않는다. 해당 버그 수정\r\n\r\n## ***3. 댓글기능구현\r\n\r\n## ***4. 게시물 수정 기능 추가구현\r\n\r\n## ***5. 회원가입 중복된 정보 막기\r\n\r\n## 6. 글 등록 폼에 토스트 에디터 적용\r\n\r\n## 7. 노트북 개발 환경세팅\r\n\r\n## 8. 블로그 글쓰기\r\n\r\n\r\n\r\n\r\n### +참고. https://jhnyang.tistory.com/248',14),
(21,'2020-07-14 09:00:15','2020-07-14 13:25:21',1,1,'20.07.14 공부계획','# 2020 07 14 화요일 목표\r\n## 1. <서블릿/JSP로 게시판 만들기> 첨부터 조금씩 다시 & 노트북 개발 환경세팅\r\n\r\n## 2. 게시물 본문에 `</+script>`가 들어가면 뷰어가 작동하지 않는다. 해당 버그 수정\r\n\r\n## 3. 게시물 수정 기능 추가구현 (완료!!!!)\r\n\r\n## 4. 회원가입 중복된 정보 막기\r\n\r\n## 5. 블로그 글쓰기\r\n\r\n## 6. 댓글작성\r\n\r\n## 7. 댓글리스팅\r\n\r\n## 8. 댓글삭제\r\n\r\n## 9. 댓글수정\r\n\r\n## 10. 로그인 한 사람만 글/댓글 작성\r\n\r\n## 11. 글/댓글 수정/삭제 시 작성자만 가능\r\n\r\n\r\n\r\n<br><br><br>\r\n### +로그인 힌트\r\n// 세션은 서버에 저장되는 각 사용자(브라우저) 별 개인 저장소 이다.\r\nHttpSession session = request.getSession();\r\n\r\n// 로그인  처리, MemberController의 doLogin에서 처리해야함\r\nsession.setAttribute(\"loginedMemberId\", 1);\r\n\r\n// 로그아웃\r\nsession.removeAttribute(\"loginedMemberId\");\r\n\r\n// 로그인 여부 체크\r\nint loginedMemberId = 0;\r\nif ( session.getAttribute(\"loginedMemberId\") != null ) {\r\n    loginedMemberId = (int)session.getAttribute(\"loginedMemberId\")\r\n}',119),
(57,'2020-07-10 09:45:10','2020-07-13 13:42:45',1,1,'7','7',5),
(59,'2020-07-10 10:58:58','2020-07-14 12:55:04',1,1,'ddd','',66),
(60,'2020-07-10 11:27:36','2020-07-14 13:08:10',1,1,'60번글333','???we\r\nf/efwefwef@@@',21),
(61,'2020-07-10 11:30:59','2020-07-10 11:30:59',1,1,'dd','dd',77),
(62,'2020-07-13 03:33:28','2020-07-14 13:02:53',1,1,'refff','',28),
(65,'2020-07-13 09:52:51','2020-07-13 13:41:44',1,1,'55','55',20),
(66,'2020-07-13 09:56:12','2020-07-13 09:56:12',1,1,'aa','aa',0),
(67,'2020-07-13 11:39:33','2020-07-13 11:39:33',1,1,'제목','내용',3),
(68,'2020-07-14 13:45:08','2020-07-14 13:45:08',1,1,'ㅇㅇ','# 내용을 입력해 주세요.ㅇㅇ',0);

/*Table structure for table `cateItem` */

DROP TABLE IF EXISTS `cateItem`;

CREATE TABLE `cateItem` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `name` char(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `cateItem` */

insert  into `cateItem`(`id`,`regDate`,`name`) values 
(1,'2020-06-30 11:55:38','IT/자바'),
(2,'2020-06-30 11:55:38','IT/HTML_CSS_JS'),
(3,'2020-06-30 11:55:38','IT/상식'),
(4,'2020-06-30 11:55:38','IT/그외'),
(5,'2020-06-30 11:55:38','공부계획'),
(6,'2020-06-30 11:55:38','일상');

/*Table structure for table `member` */

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `loginId` char(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` char(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nickname` char(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `loginPw` char(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `loginId` (`loginId`),
  UNIQUE KEY `nickname` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `member` */

insert  into `member`(`id`,`regDate`,`loginId`,`name`,`nickname`,`loginPw`) values 
(1,'2020-07-10 10:12:35','a','a','a','a'),
(3,'2020-07-10 10:12:59','d','d','d','d'),
(4,'2020-07-13 10:44:58','c','c','c','c');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
