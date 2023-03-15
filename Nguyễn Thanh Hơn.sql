-- Câu 1.
-- a. Tạo các login và use cho các nhân viên
-- Tạo login cho NV1
CREATE LOGIN nv1 WITH PASSWORD = 'nth2982';
GO
-- Tạo user cho NV1
USE AdventureWorks2008R2;
CREATE USER NV1 FOR LOGIN NV1;
GO
-- Tạo Login cho NV2
CREATE LOGIN NV2 WITH PASSWORD = 'H0344517822';
GO
-- Tạo user cho NV2
USE AdventureWorks2008R2;
CREATE USER NV2 FOR LOGIN NV2;
GO
-- Tạo Login cho QL
CREATE LOGIN QL WITH PASSWORD = 'nth2982';
GO
-- Tạo user cho QL
USE AdventureWorks2008R2;
CREATE USER QL FOR LOGIN QL;
GO
-- Tạo login cho admin
CREATE LOGIN admin WITH PASSWORD = 'nth2982';
GO
-- Tạo user cho admin
USE AdventureWorks2008R2;
CREATE USER admin FOR LOGIN admin;
GO
--b. Tạo role, phân quyền	
--Tạo role NHANVIEN
CREATE ROLE NHANVIEN;
role CREATED.

--Tạo role db_datareader
CREATE ROLE db_datareader;
role db_datareader

---Phân quyền cho role NHANVIEN
USE AdventureWorks2008R2;
GRANT SELECT,UPDATE, DELETE ON Person.PersonPhone TO NHANVIEN;
GO
-- Phân quyền cho nhân viên QL
USE AdventureWorks2008R2;
GRANT SELECT ON Person.PersonPhone TO db_datareader;
GRANT SELECT ON Person.Person  TO db_datareader;
GO
--Gán role NHANVIEN cho NV1 và NV2
GRANT NHANVIEN TO NV1, NV2;
Grant succeeded.
--Gán role db_datareader cho QL
GRANT db_datareader TO QL;
Grant succeeded.

-- Admin phải có quyền CONTROL trên tất cả các đối tượng trong cơ sở dữ liệu
USE AdventureWorks2008R2;
GRANT CONTROL TO [admin];
GO

-- d. Ai có thể xem dữ liệu bảng Person.Person?
-- Chỉ có QL mới xem được bảng Person.Person, vì đã được phân quyền SELECT trên bảng này


-- e. Các nhân viên quản lý NV1, NV2, QL hoàn thành dự án, admin thu hồi quyền đã cấp. Xóa role NhanVien.
-- Thu hồi quyền
REVOKE Nhanvien FROM NV1,NV2,QL;
Revoke succeeded.
-- Xóa role NhanVien
DROP ROLE NhanVien 

--Câu 2: 
--a Tạo một giao tác tăng lương (Rate) thêm 20% cho các nhân viên làm việc ở phòng (Department.Name) ‘Production’ và ‘Production Control’. Tăng lương 15% cho các nhân viên các phòng ban khác. [Ghi nhận dữ liệu đang có và Viết lệnh Full Backup].



backup database AdventureWorks2008R2
to disk = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\adventure-works-2008r2-oltp.bak'

--b. Xóa mọi bản ghi trong bảng PurchaseOrderDetail. [Viết lệnh Differential Backup]
delete Purchasing.PurchaseOrderDetail
backup database AdventureWorks2008R2
to disk = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\adventure-works-2008r2-oltp.bak'
with differential 

--c Bổ sung thêm 1 số phone mới (Person.PersonPhone) tùy ý cho nhân viên có mã số nhân viên (BusinessEntityID) là 4 ký tự cuối của Mã SV của chính SV dự thi, ModifiedDate=getdate(). [Ghi nhận dữ liệu đang có và Viết lệnh Log Backup]
select * from Person.PersonPhone where BusinessEntityID = 0108
insert into Person.PersonPhone values(0108, '290802' , 2 ,getdate())

backup log AdventureWorks2008R2
to disk = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\adventure-works-2008r2-oltp.bak'

--d Xóa CSDL AdventureWorks2008R2. Phục hồi CSDL về trạng thái sau khi thực hiện bước c. Kiểm tra xem dữ liệu phục hồi có đạt yêu cầu không (lương có tăng, các bản ghi có bị xóa, có thêm số phone mới)?
use master
drop database AdventureWorks2008R2

restore database AdventureWorks2008R2
from disk = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\adventure-works-2008r2-oltp.bak'
with file = 1, replace , norecovery