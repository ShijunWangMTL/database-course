------------round()----------------
/*
ROUND ( numeric_e-xpression , length [ , function ] )

function: optional. default: 0. 要执行的操作类型。function 必须是 tinyint、smallint 或 int。如果省略 function 或 function 的值为 0（默认），numeric_e-xpression 将四舍五入。当指定 0 以外的值时，numeric_e-xpression 将截断 。
*/

SELECT ROUND(925.678, 2)
-->925.680  结果并非只保留两位小数，而是保留两位有效的小数
SELECT ROUND(925.678, 0)
-->926.000  当精度为0，取整数
SELECT ROUND(925.678, -2)
-->900.000  当精度为负数时，根据小数点左边位数进行四舍五入
SELECT ROUND(925.678, -4)
-->0.000  当精度是负数且大于小数点前的数字个数，ROUND 将返回 0。
SELECT ROUND(925.678, -3)
-->当精度是负数且等于小数点前的数字个数时，报错：将 expression 转换为数据类型 numeric 时出现算术溢出错误！
-->原因是925.678这个常量的数据类型是decimal(6,3)，而结果是1000.000，这便报错了。
-->解决方法也简单，转换数据类型即可。如下:
SELECT ROUND(CAST(925.678 AS decimal(7,3)), -3)
 
 
------当第三个参数设置为非0的数，直接截断-------
SELECT ROUND(925.678,1,0)
-->925.700  
SELECT ROUND(925.678,1,2)
-->925.600
 
SELECT ROUND(925.678,-1,0)
-->930.000
SELECT ROUND(925.678,-1,2)
-->920.000