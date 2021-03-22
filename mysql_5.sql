/*分組查詢
語法: 
SELECT 分組函數,列(要求出現在GROUP BY 後面)
FROM 表名
[WHERE 篩選條件]
GROUP BY 分組的列表
[HAVING 分組後篩選]
[ORDER BY 子句]

*/
SHOW CREATE TABLE employees;

/*練習: 查詢每個職位的最高薪水*/
SELECT MAX(salary), job_id
FROM employees
GROUP BY job_id;

/*練習:查詢每個地點的部門個數*/
SELECT COUNT(department_id),location_id
FROM departments
GROUP BY location_id;

-- 添加篩選條件
/*練習: 查詢信箱中包含a字母的人，該部門的平均薪水*/
SELECT AVG(salary),department_id
FROM employees
WHERE email LIKE '%a%'
GROUP BY department_id;

/*練習:查詢有獎金的每個主管手下員工的最高薪水為何*/
SELECT MAX(salary),manager_id,commission_pct
FROM employees
WHERE commission_pct is not NULL
GROUP BY manager_id;

-- 添加複雜的篩選條件(分組後篩選)
/*練習:查詢哪些部門的員工個數>2*/
SELECT COUNT(employee_id),department_id
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id)>2;

/*練習:查詢每個職位有獎金的員工的最高薪水>12000的職位ID&最高薪資為何*/
SELECT MAX(salary),job_id
FROM employees
WHERE commission_pct is not null
GROUP BY job_id
HAVING MAX(salary)>12000;

/*練習:查詢主管ID>102的主管手下員工的最低薪資>5000的主管編號是哪個，以及其最低工資*/
SELECT MIN(salary),manager_id
FROM employees
WHERE manager_id>102
GROUP BY manager_id
HAVING MIN(salary)>5000;

/*分組查詢中的特點:
(1) 篩選條件分為兩種
             DATA來源          位置
分組前篩選   原始表            GROUP BY 子句前 [WHERE] 
分組後篩選   分組後的結果集    GROUP BY 子句後 [HAVING]

-- 分組函數如果為篩選條件，肯定放在HAVING 子句中
-- 能用分組前篩選的條件就優先使用WHERE子句(效率較好)

(2) GROUP BY子句支持單個字段、多個字段(用逗號隔開)、表達式、函數分組
(3) 也可以添加ORDER BY 子句(放最後)
*/

-- 按表達式或函數分組
/*練習:按員工姓名的長度分組，查詢每一組員工個數，篩選員工個數>5的有那些*/
SELECT COUNT(*),LENGTH(CONCAT(first_name,last_name))
FROM employees
GROUP BY LENGTH(CONCAT(first_name,last_name))
HAVING COUNT(*)>5;

-- 按多個字段分組
/*練習:查詢每個部門每個職位的員工平均工資*/
SELECT AVG(salary),department_id,job_id
FROM employees
GROUP BY department_id,job_id;

-- 添加排序
/*練習:查詢每個部門每個職位的員工平均工資，再按平均工資的高低顯示*/
SELECT AVG(salary),department_id,job_id
FROM employees
GROUP BY department_id,job_id
ORDER BY AVG(salary) DESC;
