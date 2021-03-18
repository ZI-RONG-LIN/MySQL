/*排序查詢
SELECT 查詢列表
FROM 表名
[WHERE 篩選條件]
ORDER BY 排序列表[ASC升冪(預設)|DESC降冪]

1. ORDER BY 子句中可支持單個字串，多個字串，表達式，函式，別名
2. ORDER BY 子句一般放在查詢語句的最後面，limit子句除外
*/

/*練習:查詢員工資訊，薪水由高到低排列*/
SELECT *
FROM employees
ORDER BY salary DESC;

/*練習:查詢部門ID>=90的員工資訊，按入職先後排序*/
SELECT *
FROM employees
WHERE department_id >=90
ORDER BY hiredate ASC;

/*練習:按年薪高低顯示員工資訊及年薪*/
SELECT *, salary*12*(1+IFNULL(commission_pct,0)) AS 年薪
FROM employees
ORDER BY 年薪 DESC;

/*練習:按姓名長度顯示員工姓名數據*/
SELECT LENGTH(CONCAT(first_name,last_name)) AS 字串長度,
concat(first_name,last_name) AS 姓名, salary
FROM employees
ORDER BY 字串長度; 

/*練習:查詢員工資訊，先按工資升冪排序，再按員工ID 降冪排序*/
SELECT *
FROM employees
ORDER BY salary ,employee_id DESC;
