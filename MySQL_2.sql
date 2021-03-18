/*條件查詢
SELECT 查詢列表
FROM 表名
WHERE 篩選條件;
*/

#1. 按條件表達式篩選
/*練習: 查詢薪水>12000的員工資訊*/
SELECT * 
FROM employees 
WHERE salary >12000;

/*練習: 查詢部門編號不等於90的員工名&部門ID*/
SELECT  first_name,department_id
FROM employees
WHERE department_id != 90;

#2. 按邏輯表達式篩選
/* 
&&、and: 兩個條件都為true，結果為true，反之為false
||、or:只要有一個條件為true，結果為true，反之為false
!、not:如果連接的條件本身為false，結果為true，反之為false
*/

/*練習:查詢薪水在10000~20000之間的員工名、薪水及獎金*/
SELECT first_name,salary,commission_pct
FROM employees
WHERE salary>=10000 and salary<=20000;

/*練習:查詢部門編號不是在90~110之間，或者薪水高於15000的員工資訊*/
SELECT * 
FROM employees
WHERE NOT(department_id>=90 and department_id<=110) or salary>=15000;

#3. 模糊查詢
/* 
1. like: 一般和通配符搭配使用
ex: 
%:任意多個字符，包含0個字符
_:任意單個字符
*/

/*練習:查詢員工名中包含字母a的員工資訊*/
SELECT * 
FROM employees
WHERE last_name LIKE '%a%';

/*練習:查詢員工名中第3個字為e，第5個字為a的員工名、薪水*/
SELECT last_name,salary
FROM employees
WHERE last_name LIKE '__e_a%';

/*練習:查詢員工名中第2個字為_的人*/
/*加\為轉譯字符，不加的話程式會判斷為字母搜索，而不是_線符號*/
/*方法一:用內建轉譯字符\*/
SELECT last_name
FROM employees
WHERE last_name LIKE '_/_%';
/*方法二:自訂轉譯字符*/
SELECT last_name
FROM employees
WHERE last_name LIKE '_$_%' ESCAPE '$';

/*
2. between and
可提高語句簡潔度，包含上下界，但上下界不可對調
*/

/*練習:查詢員工ID在100~120之間的員工資訊*/
SELECT *
FROM employees
WHERE employee_id BETWEEN 100 AND 120;

/*
3. in
含義:判斷某字串的值是否為in列表中的一項
特點:
(1) 使用in提高語句簡潔度
(2) in列表的值類型要一致或兼容 (都是數值或是字串)
(3) 不支援通配符 (%、_)
*/

/*練習:查詢員工的工作ID為IT_PROG、AD_VP、AD_PRES中的員工名與工作ID*/
SELECT last_name,job_id
FROM employees
WHERE job_id IN ('IT_PROG','AD_VP','AD_PRES');

/*
4. is null/is not null
= 或<> 不能用於判斷NULL值，只能用is null 或is not null
*/

/*練習:查詢沒有獎金的員工名和獎金率*/
SELECT last_name,commission_pct
FROM employees
WHERE commission_pct IS NULL;

/*安全等於<=>
也可判斷NULL值和普通數值，但可讀性低
*/

/*練習:查詢沒有獎金的員工名和獎金率*/
SELECT last_name,commission_pct
FROM employees
WHERE commission_pct <=> NULL;

/*練習:查詢薪水=12000的人*/
SELECT *
FROM employees
WHERE salary <=> 12000;

/*經典面試題:
試問:
SELECT * FROM employees; 和
SELECT * FROM employees where commission_pct LIKE '%%'
AND last_name LIKE '%%';
結果是否一致?原因?

ANS:
不一樣，if判斷字段中有NULL存在，但如果沒有NULL值的話，則兩者結果相同 
*/
