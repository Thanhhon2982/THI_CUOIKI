-- Đăng nhập Đăng nhập với tài khoản của nhân viên nv2
USE AdventureWorks2008R2;
EXECUTE AS USER = 'NV2';

--Nhân viên NV2 xóa số điện thoại của người có BusinessEntityID=(3 ký tự đầu của Mã SV của chính SV dự thi).
UPDATE Person.PersonPhone
SET PhoneNumber= ''
WHERE BusinessEntityID = 095
--Kết thúc
REVERT;