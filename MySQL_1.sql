/*基礎查詢
SELECT 查詢列表(表中的字串、常數、數學表達式、函數)
FROM表名
*/

/*查詢表中單個字串*/
SELECT last_name FROM employees;

/*查詢表中多個字串*/
SELECT last_name,salary,email FROM employees; 

/*查詢表中所有字串*/
SELECT * FROM employees;

/*查詢常數*/
SELECT 100;
SELECT 'john';

/*查詢表達式*/
SELECT 100*98;

/*查詢函數*/
/*取該函數的返回值，並顯示*/
SELECT version();

/*取名
1. 便於理解 2. 如果要查詢的字段有重名的情況，使用別名可以區分開來*/
/*方法一、用AS*/
SELECT 100*98 AS 薪資;
SELECT last_name AS 姓, first_name AS 名 FROM employees;
/*方法二、用空格*/
SELECT last_name 姓, first_name 名 FROM employees;

/*練習:查詢salary,顯示結果為output*/
SELECT salary AS 'output' FROM employees;

/*輸入欄位名，查詢欄位值，如果為null，則返回1，否則返回0*/
SELECT isnull(salary) FROM employees;

/*去除重複值*/
SELECT DISTINCT department_id FROM employees;

/*mysql +號功能: 如果其中一方為字串，則試圖把字串值轉成數值，成功的話，做加法運算；失敗的話，則把字串轉成0*/
SELECT 100+90;
SELECT '123'+90;
SELECT 'john'+90;
/*只要其中一方為NULL，則結果必為NULL*/
SELECT NULL+10;

/*練習:查詢員工名和姓，連接成一個字串，並顯示為姓名*/
SELECT CONCAT(last_name, first_name) AS 姓名 FROM employees;

/*練習:顯示表department的結構，並查詢其中的全部數據*/
DESC departments;
SELECT * FROM departments;

/*練習:顯示表employees中的全部不重複的job_id*/
SELECT DISTINCT job_id FROM employees;

/*練習:顯示employees的全部列，各個列之間用"，"連接，列名顯示為output*/
SELECT CONCAT(first_name,',',last_name) AS 'output'
FROM employees;

/*if commission_pct 為NULL，則獎金率為0，否則commission_pct=獎金率*/
SELECT IFNULL(commission_pct,0) AS 獎金率 FROM employees;

