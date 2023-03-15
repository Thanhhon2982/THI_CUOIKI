-- Đăng nhập với tài khoản của nhân viên QL
USE AdventureWorks2008R2;
EXECUTE AS USER = 'QL';

-- Nhân viên QL xem lại kết quả NV1 và NV2 đã làm
SELECT * FROM Person.PersonPhone

-- Kết thúc quyền của nhân viên QL
REVERT;