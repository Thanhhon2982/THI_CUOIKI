-- Đăng nhập Đăng nhập với tài khoản của nhân viên NV1
USE AdventureWorks2008R2;
EXECUTE AS USER = 'NV1';
-- Sửa số điện thoại của người có BusinessEntityID=(3 kí tự cuối mã sv) thánh 123-456-789
UPDATE Person.PersonPhone
SET PhoneNumber= '123-456-7890'
WHERE BusinessEntityID = 108
--Kết thúc
REVERT;

