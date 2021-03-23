/*連接查詢，又稱多表查詢
使用時機:當所要查詢的字段來自於多個表時使用

分類:
(1) 按年代分類: sql92(只支持內連接)、sql99(支持內、交叉、外的左外、右外連接)
(2) 按功能分類: 
-- 內連接: 等值連接、非等值連接、自連接
-- 外連接: 左外連接、右外連接、全外連接
-- 交叉連接
*/

/*一、sql92標準
(1) 多表等值連接的結果為多表的交集部分
(2) n表連接，至少需要n-1個連接條件
(3) 多表順序沒有要求
(4) 一般需為表取別名
(5) 可搭配之前介紹的子句使用
*/

-- 等值連接
/* 練習: 查詢員工名和對應的部門名*/
SELECT last_name,department_name
FROM employees e,departments d
WHERE e.`department_id` = d.`department_id`;

-- 2. 為表起別名
/*練習:查詢員工名、職位名*/
SELECT last_name,job_title
FROM employees e,jobs j
WHERE e.`job_id` = j.`job_id`;

-- 3. 加篩選
/*練習:查詢有獎金的員工名、部門名*/
SELECT last_name,commission_pct,department_name
FROM employees e,departments d
WHERE commission_pct is not null and e.`department_id` = d.`department_id`;

/*練習:查詢城市名中第二個字母為o的部門名和城市名*/
SELECT department_name,city
FROM locations l,departments d
WHERE l.`location_id` = d.`location_id` and city LIKE '_o%';

-- 4. 加分組
/*練習: 查詢每個城市的部門個數*/
SELECT COUNT(*), city
FROM locations l,departments d
WHERE l.`location_id` = d.`location_id`
GROUP BY city;

/*練習:查詢有獎金的每個部門的部門名和部門主管編號和該部門的最低薪資*/
SELECT department_name,d.manager_id,MIN(salary)
FROM employees e,departments d
WHERE e.`department_id` = d.`department_id` and commission_pct is not null
GROUP BY department_name,d.manager_id;

-- 5. 可以加排序
/*練習:查詢每個工作的工作名和員工個數，並按員工個數降序*/
SELECT e.job_id,job_title,count(employee_id)
FROM employees e,jobs j
WHERE e.`job_id` = j.`job_id`
GROUP BY job_id
ORDER BY count(employee_id) DESC;

-- 6. 3表連接
/*練習:查詢員工名、部門名和所在城市*/
SELECT last_name,department_name,city
FROM employees e,departments d, locations l
WHERE e.`department_id` = d.`department_id` and d.`location_id`= l.`location_id`;

/*練習:查詢員工的薪資和工資級別*/
SELECT last_name,salary,
CASE 
WHEN salary >20000 then 'A'
WHEN salary >15000 then 'B'
WHEN salary >10000 then 'C'
ELSE 'D'
END AS 工資級別
FROM employees e;
SELECT * FROM employees;

-- 自連接
/*練習:查詢員工名&上級的名稱*/
SELECT m.last_name AS employee_name,e.last_name AS manager_name
FROM employees e,employees m
WHERE e.`employee_id` = m.`manager_id`;

/*二、sql99語法
SELECT 查詢列表
FROM 表1,別名[連接類型]
JOIN 表2,別名 on 連接條件
WHERE 篩選條件
GROUP BY 分組
HAVING 篩選條件
ORDER BY 排序列表

[連接類型分類]
(1) 內連接: INNER
(2) 外連接:左外LEFT [OUTER]、右外RIGHT [OUTER]、全外FULL [OUTER]
(3) 交叉連接: CROSS
*/

/*一、內連接
語法:
SELECT 查詢列表
FROM 表1 別名
INNER JOIN 表2 別名
ON 連接條件;

分類:等值、非等值、自連接
特點:
(1) 可添加排序、分組、篩選
(2) INNER 可以省略
(3) 篩選條件放在WHERE後面，連接條件放在ON後面，提高分離性，便於閱讀
(4) INNER JOIN 連接和sql92語法中的等值連接效果是一樣的，都是查詢多表的交集
*/

-- 1. 等值連接
/*練習:查詢員工名、部門名*/
SELECT last_name,department_name
FROM employees e
INNER JOIN departments d
ON e.`department_id` = d.`department_id`;

/*練習:查詢名字中包含e的員工名和工作名*/
SELECT last_name,job_title
FROM employees e
INNER JOIN jobs j
ON e.`job_id` = j.`job_id`
WHERE last_name LIKE '%e%';

/*練習:查詢部門個數>3的城市名和部門個數*/
SELECT city,COUNT(*)
FROM departments d
INNER JOIN locations l
ON d.`location_id` = l.`location_id`
GROUP BY city
HAVING COUNT(*)>3;

/*練習:查詢哪個部門的部門員工個數>3的部門名和員工個數，並按個數降序*/
SELECT department_name,COUNT(*)
FROM employees e
INNER JOIN departments d
ON e.`department_id` = d.`department_id`
GROUP BY department_name
HAVING COUNT(*)>3
ORDER BY COUNT(*) DESC;

/*練習:查詢員工名、部門名、工作名，並按部門名降序*/
SELECT last_name,department_name,job_title
FROM employees e
INNER JOIN departments d
ON e.`department_id` = d.`department_id`
INNER JOIN jobs j
ON e.`job_id` = j.`job_id`
ORDER BY department_name DESC;

/*練習:建立一個工資級別的表，把資料放入欄位中*/
CREATE TABLE grade_level (
  grade_level varchar(20),
  lowest_salary INT,
  highest_salary INT
);

INSERT INTO grade_level (lowest_salary, highest_salary,grade_level)
SELECT  MIN(salary),MAX(salary),
CASE 
WHEN salary >20000 then 'A'
WHEN salary >15000 then 'B'
WHEN salary >10000 then 'C'
ELSE 'D'
END AS g_level
FROM employees 
GROUP BY g_level;

-- 2. 非等值連接
/*練習:查詢員工的薪資集別*/
SELECT last_name,salary,g.grade_level
FROM employees e
JOIN grade_level g
ON e.salary BETWEEN g.`lowest_salary` AND g.`highest_salary`;

/*練習:查詢每個工資級別的個數>20，並按工資級別降序*/
SELECT g.grade_level,COUNT(*)
FROM employees e
JOIN grade_level g
ON e.salary BETWEEN g.`lowest_salary` AND g.`highest_salary`
GROUP BY g.grade_level
HAVING COUNT(*)>20
ORDER BY g.grade_level DESC;

-- 3.自連接
/*練習:查詢員工的名字包含k的人，及其上級的名字*/
SELECT e.last_name AS manager_name, m.last_name AS employee_name
FROM employees e
INNER JOIN employees m
ON e.`employee_id` = m.`manager_id`
WHERE e.`last_name` LIKE '%k%';

/*二、外連接
使用時機:用於查詢一個表有，另一個表沒有時
-- 外連接查詢結果 = 內連接查詢結果 + 主表中有而從表沒有的紀錄
特點:
(1) 外連接的查詢結果為主表中的所有紀錄。如果從表中有和它匹配的，則顯示匹配的值；否則顯示NULL
(2) 
左外連接，LEFT JOIN 左邊為主表
右外連接，RIGHT JOIN 右邊為主表
(3) 左外和右外交換表的順序，依舊可以達到同樣效果
(4) 全外連接 = 兩表取全集
*/

/*練習:查詢哪個部門沒有員工*/
SELECT d.*,e.`employee_id`
FROM departments d
LEFT JOIN employees e
ON d.`department_id` = e.`department_id`
WHERE e.`employee_id` IS NULL;

/*練習:查詢哪個城市沒有部門*/
SELECT city,d.`department_id`
FROM locations l
LEFT JOIN departments d
ON l.`location_id` = d.`location_id`
WHERE d.`department_id` IS NULL;

/*練習:查詢部門名為SAL、IT的員工資訊*/
SELECT e.*,d.`department_name`
FROM departments d
RIGHT JOIN employees e
ON d.`department_id` = e.`department_id`
WHERE department_name IN ('SAL','IT');


/* sql92 V.S. sql99
功能: sql99支持的功能較多
可讀性: sql99實現的連接條件和篩選條件的分離，可讀性較高
*/
