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


