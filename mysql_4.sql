/*常見函數
概念:將一組邏輯語句封裝在方法中，對外暴露方法名
優點:1. 隱藏了實現的細節 2. 提高代碼重用性
分類:
1. 單行函數:給一個值，返回一個值
2. 分組函數:給一組值，返回一個值，又稱組函數、統計函數、聚合函數
*/

/*單行函數*/
/*字串函數*/
-- LENGTH:獲取字串長度，中文一個字佔3個單位，英文則佔1個單位
-- CONCAT:文字串聯用，用於連接多個字串
-- UPPER、LOWER:轉成大寫或小寫
SELECT UPPER('john');
/*練習:將姓變大寫，名變小寫，並串成一個字*/
SELECT CONCAT(UPPER(first_name),LOWER(last_name))
FROM employees;

-- SUBSTR、SUBSTRING:擷取字串，字的位置從1開始
/*擷取6之後的文字*/
SELECT SUBSTR('壽司郎鮭魚免費',6);
/*擷取第1~3字元*/
SELECT SUBSTR('壽司郎鮭魚免費',1,3);
/*練習:姓名中首字母大寫，其餘字母小寫，用_連接*/
SELECT CONCAT(UPPER(SUBSTR(first_name,1,1)),'_',LOWER(SUBSTR(first_name,2)),LOWER(last_name))
FROM employees;

-- INSTR:返回字串第一次出現的位置，如果找不到則返回0
SELECT INSTR('壽司郎鮭魚免費','鮭魚');

-- TRIM:去除前後空白格或指定字
SELECT TRIM('   鮭魚   ');
SELECT TRIM('a' FROM 'aaa鮭魚a');

-- LPAD:用指定字，左填充到指定長度
SELECT LPAD('壽司郎',8,'*');

-- RPAD:用指定字，右填充到指定長度
-- REPLACE:替換，第2個填要被取代的字，第3個填取代字
SELECT REPLACE('abcd','b','d');

/*數學函數*/
-- ROUND:四捨五入
SELECT ROUND(1.65);
/*保留到小數後2位*/
SELECT ROUND(1.567,2);

-- RAND:取0~1的隨機小數
-- CEIL:向上取整，無條件進位取整數，返回大於等於該數值的最小整數
SELECT CEIL(1.52);

-- FLOOR:向下取整，返回小於等於該數值的最大整數
SELECT FLOOR(8.7);

-- TRUNCATE:截斷
/*保留到小數點後1位，後面的就截掉*/
SELECT TRUNCATE(1.65,1);

-- MOD:取餘數
/*被除數為+，結果為+；被除數為-，結果為-*/
/*等於SELECT 10%3;*/
SELECT MOD(10,3);
SELECT MOD(-10,-3);

/*日期函數*/
-- NOW:返回當前系統日期、時間
SELECT NOW();

-- CURDATE:返回當前系統日期
SELECT CURDATE();

-- CURTIME:返回當前系統時間
SELECT CURTIME();

-- 獲取指定的部分，年YEAR、月MONTH、月份名MONTHNAME、日DAY、小時HOUR、分鐘MINUTE、秒SECOND

-- STR_TO_DATE:將日期格式轉換成指定格式
SELECT STR_TO_DATE('9-13-1999','%m-%d-%Y');

/*
1. %Y:四位數的年份 ex:1999
2. %y:二位數的年份 ex:99
3. %m:月份(01,02,03,04....,12)
4. %c:月份(1,2,3,4,...,12)
5. %d:日(01,02,03,...,31)
6. %H:小時(24小時制)
7. %h:小時(12小時制)
8. %i:分鐘(00,01,02,...,59)
9. %s:秒(00,01,02,...,59)
*/

/*練習:查詢入職日為1992/4/3的人*/
SELECT *
FROM employees
WHERE hiredate=STR_TO_DATE('4-3-1992','%m-%d-%Y');

-- DATE_FORMAT:將日期轉換成字串
SELECT DATE_FORMAT('2018/6/6','%Y年%m月%d日');
/*練習:查詢有獎金的員工名和入職日期(xx月/xx日 xx年)*/
SELECT last_name,DATE_FORMAT(hiredate,'%m月/%d日 %y年')
FROM employees
WHERE commission_pct IS NOT NULL;


/*其他函數*/
-- 看版本
SELECT VERSION();
-- 看當前數據庫
SELECT DATABASE();
-- 看當前用戶
SELECT USER();
-- 把字串加密
SELECT PASSWORD('鮭魚');
SELECT MD5('鮭魚');

/*流程控制函數*/
-- if:if else 的效果
SELECT IF(10>5,'大','小');

-- CASE
/*使用一:類似於switch case 的效果。常用於等值判斷，如case後面的東西等於某值時，則做甚麼動作

CASE 要判斷的字段或表達式
WHEN 常量1 THEN 要顯示的值1或語句1
WHEN 常量2 THEN 要顯示的值2或語句2
ELSE 要顯示的值n或語句n
END;

*/

/*練習:查詢員工的薪水，要求
部門ID=30，顯示的工資為1.1倍
部門ID=40，顯示的工資為1.2倍
部門ID=50，顯示的工資為1.3倍
其他則為原薪水
*/
SELECT salary,department_id,
CASE department_id
WHEN 30 THEN salary*1.1
WHEN 40 THEN salary*1.2
WHEN 50 THEN salary*1.3
ELSE salary
END AS 新薪水
FROM employees;

/*使用二:類似多重if，if，else if，else

CASE　
WHEN 常量1 THEN 要顯示的值1或語句1
WHEN 常量2 THEN 要顯示的值2或語句2
ELSE 要顯示的值n或語句n
END;

*/

/*練習:查詢員工的薪水
如果薪水>20000，顯示為A組別
如果薪水>15000，顯示為B組別
如果薪水>10000，顯示為C組別
否則顯示D組別
*/
SELECT salary,
CASE 
WHEN salary>20000 THEN 'A'
WHEN salary>15000 THEN 'B'
WHEN salary>10000 THEN 'C'
ELSE 'D'
END AS 薪水級別
FROM employees;

/*分組函數
功能:用作統計使用，又稱為組函數、統計函數、聚合函數
分類:
SUM求和、AVG平均值、MAX最大值、MIN最小值、COUNT計算非NULL值的個數

特點:
1. 參數支持那些類型
SUM、AVG 一般用於處理數值型
MAX、MIN、COUNT 可以處理任何類型
2. 分組函數都忽略NULL
3. 可以和DISTINCT搭配來去除重複值
4. COUNT 函數的單獨介紹
5. 和分組函數一同查詢的字段要求是GROUP BY 後的字段
*/

SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT COUNT(salary) FROM employees;

-- 4. COUNT 函數的單獨介紹
SELECT COUNT(salary) FROM employees;
/*統計行數*/
SELECT COUNT(*) FROM employees;
SELECT COUNT(1) FROM employees;
/*比較效率*/
-- 在MYISAM存儲引擎下，COUNT(*)的效率高
-- 在INNODB存儲引擎下，COUNT(*)和COUNT(1)的效率差不多

/*練習:查詢員工表中最大入職時間和最小入職時間相差的天數*/
SELECT DATEDIFF(MAX(hiredate),MIN(hiredate)) 
FROM employees;
