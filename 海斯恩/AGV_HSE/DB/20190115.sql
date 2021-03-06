USE [master]
GO
/****** Object:  Database [db_AGV_HSE]    Script Date: 2019/1/15 10:12:20 ******/
CREATE DATABASE [db_AGV_HSE] ON  PRIMARY 
( NAME = N'db_AGV_HSE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQL2012\MSSQL\DATA\db_AGV_HSE.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'db_AGV_HSE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQL2012\MSSQL\DATA\db_AGV_HSE_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [db_AGV_HSE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [db_AGV_HSE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET ARITHABORT OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [db_AGV_HSE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [db_AGV_HSE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [db_AGV_HSE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [db_AGV_HSE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [db_AGV_HSE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [db_AGV_HSE] SET RECOVERY FULL 
GO
ALTER DATABASE [db_AGV_HSE] SET  MULTI_USER 
GO
ALTER DATABASE [db_AGV_HSE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [db_AGV_HSE] SET DB_CHAINING OFF 
GO
EXEC sys.sp_db_vardecimal_storage_format N'db_AGV_HSE', N'ON'
GO
USE [db_AGV_HSE]
GO
/****** Object:  StoredProcedure [dbo].[PR_DELETE_AGV_INFO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_DELETE_AGV_INFO]
@AGV_ID INT
AS
BEGIN
DELETE tb_AGV_INFO WHERE AGV_ID=@AGV_ID
END

GO
/****** Object:  StoredProcedure [dbo].[PR_DELETE_AGV_LINE]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_DELETE_AGV_LINE]
AS
BEGIN
DELETE tb_AGV_LINE 
END

GO
/****** Object:  StoredProcedure [dbo].[PR_DELETE_AGV_LINE_LLINENO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_DELETE_AGV_LINE_LLINENO]
@LLINENO VARCHAR(50)
AS
BEGIN
DELETE tb_AGV_LINE WHERE LLINENO=@LLINENO
END

GO
/****** Object:  StoredProcedure [dbo].[PR_DELETE_Area_AreaNo]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[PR_DELETE_Area_AreaNo]
@areaNo VARCHAR(50)
AS
BEGIN
	DELETE tb_Area WHERE AreaNo=@areaNo 
END

GO
/****** Object:  StoredProcedure [dbo].[PR_DELETE_CallBox_Map]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_DELETE_CallBox_Map]
@SCallBoxNo VARCHAR(50)
AS
BEGIN
	DELETE tb_CallBox WHERE SCallBoxNo=@SCallBoxNo 
	DELETE tb_CallBoxLogic WHERE LCallBoxNo=@SCallBoxNo
END

GO
/****** Object:  StoredProcedure [dbo].[PR_DELETE_CROSS_INFO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[PR_DELETE_CROSS_INFO]
@cid INT
AS
BEGIN
DELETE tb_CROSS_INFO WHERE Cid=@cid
END

GO
/****** Object:  StoredProcedure [dbo].[PR_DELETE_ELC]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_DELETE_ELC]
@SIP VARCHAR(50)
AS
BEGIN
DELETE tb_ELC WHERE Sip=@SIP
DELETE tb_Elec_ WHERE Lip=@SIP
END

GO
/****** Object:  StoredProcedure [dbo].[PR_DELETE_ELEVATOR_MAP]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[PR_DELETE_ELEVATOR_MAP]
@sip VARCHAR(50),--RFID 值
@TX VARCHAR(50),--RFID 坐标 X
@TY VARCHAR(50)--RFID 坐标 Y
AS
BEGIN
	DELETE tb_ELC WHERE Sip=@sip AND ABS((CONVERT(INT,Sx)-CONVERT(INT,@TX)))<10 AND ABS((CONVERT(INT,Sy)-CONVERT(INT,@TY)))<10
	DELETE tb_Elec_ WHERE Lip=@sip
END

GO
/****** Object:  StoredProcedure [dbo].[PR_DELETE_ORDEF_INFO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_DELETE_ORDEF_INFO]
@oid int
as
delete tb_AGV_ORDER where Oid=@oid

GO
/****** Object:  StoredProcedure [dbo].[PR_DELETE_POWER_MAP]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[PR_DELETE_POWER_MAP]
@sip VARCHAR(50),--RFID 值
@TX VARCHAR(50),--RFID 坐标 X
@TY VARCHAR(50)--RFID 坐标 Y
AS
BEGIN
	DELETE tb_Power_INFO WHERE P_IP=@sip AND ABS((CONVERT(INT,P_x)-CONVERT(INT,@TX)))<10 AND ABS((CONVERT(INT,p_y)-CONVERT(INT,@TY)))<10
END

GO
/****** Object:  StoredProcedure [dbo].[PR_DELETE_RFID_MAP]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_DELETE_RFID_MAP]
@TAGVAULE VARCHAR(50),--RFID 值
@TX VARCHAR(50),--RFID 坐标 X
@TY VARCHAR(50)--RFID 坐标 Y
AS
BEGIN
	DELETE tb_RFID_MAP WHERE TAGVAULE=@TAGVAULE AND ABS((CONVERT(INT,TX)-CONVERT(INT,@TX)))<10 AND ABS((CONVERT(INT,TY)-CONVERT(INT,@TY)))<10
END

GO
/****** Object:  StoredProcedure [dbo].[PR_DELETE_TaskReset]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[PR_DELETE_TaskReset]
@resetRFID	 varchar(50),
@resetFW	 varchar(50),
@resetAGV	 varchar(50)
AS
BEGIN
	DELETE tb_TaskReset WHERE resetRFID=@resetRFID and resetFW=@resetFW and resetAGV=@resetAGV
END

GO
/****** Object:  StoredProcedure [dbo].[PR_INSERET_AGV_INFO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_INSERET_AGV_INFO]
@AGV_IP VARCHAR(50),--AGV IP
@AGV_AC INT,--AGV 状态
@AGV_RFID_Now VARCHAR(50),
@AGV_FROM VARCHAR(50),
@AGV_TO VARCHAR(50),
@AGV_LINE VARCHAR(50),
@AGV_REMARK VARCHAR(50),
@AGV_ErrorCord VARCHAR(50),
@AGV_Power VARCHAR(50),
@AGV_Speed VARCHAR(50),
@AGV_FW VARCHAR(50),
@AGV_ISEMPTY INT,
@AGV_ISPUSH INT,
@LINETYPE INT
--@AGV_Finish int,
--@AGV_GOUp int
AS
BEGIN
	IF EXISTS(SELECT AGV_IP FROM tb_AGV_INFO WHERE AGV_IP=@AGV_IP)
	BEGIN
	UPDATE tb_AGV_INFO SET AGV_AC=(CASE WHEN @AGV_AC<>-1 AND AGV_AC<>@AGV_AC THEN @AGV_AC ELSE AGV_AC END),
	AGV_RFID_Now=(CASE WHEN RTRIM(@AGV_RFID_Now)!='' AND @AGV_RFID_Now<>AGV_RFID_Now THEN @AGV_RFID_Now ELSE AGV_RFID_Now END),
	AGV_LINENO=(CASE WHEN RTRIM(@AGV_LINE)!='' AND AGV_LINENO<>@AGV_LINE THEN @AGV_LINE ELSE AGV_LineNO END),
	--AGV_Remark=(CASE WHEN RTRIM(@AGV_REMARK)!='' AND AGV_Remark<>@AGV_REMARK THEN @AGV_REMARK ELSE AGV_Remark END),
	AGV_ErrorCord=(CASE WHEN RTRIM(@AGV_ErrorCord)!='' AND AGV_ErrorCord<>@AGV_ErrorCord THEN @AGV_ErrorCord ELSE AGV_ErrorCord END),
	AGV_Power=(CASE WHEN RTRIM(@AGV_Power)!='' AND AGV_Power<>@AGV_Power THEN @AGV_Power ELSE AGV_Power END),
	AGV_Speed=CASE WHEN RTRIM(@AGV_Speed)!='' AND @AGV_Speed<>AGV_Speed THEN @AGV_Speed ELSE AGV_Speed END,
	AGV_FW=CASE WHEN RTRIM(@AGV_FW)!='' AND @AGV_FW<>AGV_FW THEN @AGV_FW ELSE AGV_FW END,
	AGV_ISEMPTY=@AGV_ISEMPTY,
	AGV_ISPUSH=@AGV_ISPUSH
	--AGV_BoxState=@AGV_Finish,
    --AGV_Task=@AGV_GOUp
	WHERE AGV_IP=@AGV_IP
	END
	ELSE
	BEGIN
	INSERT INTO tb_AGV_INFO (AGV_IP,AGV_AC,AGV_RFID_Now,AGV_FROM,AGV_TO,AGV_LINENO,AGV_Remark,AGV_ErrorCord,AGV_Power,AGV_Speed,AGV_FW,AGV_ISEMPTY,AGV_ISPUSH,LINETYPE)--,AGV_BoxState,AGV_Task) 
			VALUES(@AGV_IP,@AGV_AC,@AGV_RFID_Now,@AGV_FROM,@AGV_TO,@AGV_LINE,@AGV_REMARK,@AGV_ErrorCord,@AGV_Power,@AGV_Speed,@AGV_FW,@AGV_ISEMPTY,@AGV_ISPUSH,@LINETYPE)--,@AGV_Finish,@AGV_GOUp)
	END
END

GO
/****** Object:  StoredProcedure [dbo].[PR_INSERET_RFID_MAP]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_INSERET_RFID_MAP]
@TAGVAULE VARCHAR(50),--RFID 值
@TX VARCHAR(50),--RFID 坐标 X
@TY VARCHAR(50),--RFID 坐标 Y
@TTYPE INT,--1,功能性标签，2,路径标签
@TFROM VARCHAR(50),--上一个标签
@TSF INT,--1，直行经过，2，左转经过，3右转经过
@TCROSS VARCHAR(50),
@TLINENO VARCHAR(50)
AS
BEGIN
	IF @TTYPE=2
		BEGIN
		IF EXISTS(SELECT TID FROM tb_RFID_MAP WHERE TTYPE=2 AND TAGVAULE=@TAGVAULE)
			BEGIN
			RETURN -1
			END
		ELSE
			BEGIN
			INSERT INTO tb_RFID_MAP (TAGVAULE,TX,TY,TTYPE,TFROM,TSF,TCROSS,TLINENO) VALUES(@TAGVAULE,@TX,@TY,@TTYPE,@TFROM,@TSF,@TCROSS,@TLINENO)
			END
		END
	ELSE
		BEGIN
		INSERT INTO tb_RFID_MAP (TAGVAULE,TX,TY,TTYPE,TFROM,TSF,TCROSS,TLINENO) VALUES(@TAGVAULE,@TX,@TY,@TTYPE,@TFROM,@TSF,@TCROSS,@TLINENO)
		END
END

GO
/****** Object:  StoredProcedure [dbo].[PR_INSERT_AGV_LINE]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_INSERT_AGV_LINE]
@LLINENO VARCHAR(50),
@LSTRING VARCHAR(1000),
@LTAG INT -- 路线种类
AS
BEGIN
INSERT INTO tb_AGV_LINE (LLINENO,LSTRING,LTAG) VALUES (@LLINENO,@LSTRING,@LTAG)
END

GO
/****** Object:  StoredProcedure [dbo].[PR_Insert_Area_All]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_Insert_Area_All]
@areaNo varchar(50),
@areaname varchar(50),
@RFIDs varchar(50),
@note varchar(50)

as
BEGIN
IF EXISTS(SELECT AreaName FROM tb_Area WHERE AreaNo=@areaNo)
	BEGIN
	UPDATE tb_Area SET AreaNo=@areaNo,AreaName=@areaname,RFIDs=@RFIDs,Note=@note WHERE AreaNo=@areaNo
	END
ELSE
	BEGIN
	INSERT INTO tb_Area (AreaNo,AreaName,RFIDs,Note) VALUES(@areaNo,@areaname,@RFIDs,@note)
	END
END

GO
/****** Object:  StoredProcedure [dbo].[PR_INSERT_AutoDoor_INFO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_INSERT_AutoDoor_INFO]
@D_NO VARCHAR(50),
@D_IP VARCHAR(50),
@D_LINENO VARCHAR(50),
@D_IN_RFID VARCHAR(50),
@D_OUT_RFID VARCHAR(50),
@D_FW INT,
@D_X INT,
@D_Y INT
AS
BEGIN
IF EXISTS(SELECT D_ip FROM tb_AutoDoor_INFO WHERE D_ip=@D_IP)
	BEGIN
	UPDATE tb_AutoDoor_INFO SET D_no=@D_NO,
								D_LineNo=@D_LINENO,
								D_In_RFID=@D_IN_RFID,
								D_Out_RFID=@D_OUT_RFID,
								D_FW=@D_FW,
								D_X=@D_X,
								D_Y=@D_Y,
								D_AC=1
								WHERE D_ip=@D_IP
	END
ELSE 
	BEGIN
	INSERT INTO tb_AutoDoor_INFO (D_no,D_ip,D_LineNo,D_In_RFID,D_Out_RFID,D_FW,D_X,D_Y,D_AC) VALUES (@D_NO,@D_IP,@D_LINENO,@D_IN_RFID,@D_OUT_RFID,@D_FW,@D_X,@D_Y,0)
	END
END

GO
/****** Object:  StoredProcedure [dbo].[PR_INSERT_AutoDoor_INFO_New]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[PR_INSERT_AutoDoor_INFO_New]
@D_NO VARCHAR(50),
@D_IP VARCHAR(50),
@D_LINENO VARCHAR(50),
@D_IN_RFID VARCHAR(50),
@D_OUT_RFID VARCHAR(50),
@D_FW INT,
@D_X INT,
@D_Y INT

AS
INSERT INTO tb_AutoDoor_INFO (D_no,D_ip,D_LineNo,D_In_RFID,D_Out_RFID,D_FW,D_X,D_Y,D_AC) 
	VALUES (@D_NO,@D_IP,@D_LINENO,@D_IN_RFID,@D_OUT_RFID,@D_FW,@D_X,@D_Y,0)

GO
/****** Object:  StoredProcedure [dbo].[PR_INSERT_Buffer_temp]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_INSERT_Buffer_temp]
@AGVIP varchar(50),
@Reserve1 varchar(50)

as
BEGIN
IF EXISTS(SELECT Reserve1 FROM tb_Buffer_temp WHERE AGV_IP=@AGVIP)
	BEGIN
	UPDATE tb_Buffer_temp SET Reserve1=@Reserve1 WHERE AGV_IP=@AGVIP
	END
ELSE
	BEGIN
	INSERT INTO tb_Buffer_temp (AGV_IP,Reserve1) VALUES(@AGVIP,@Reserve1)
	END
END

GO
/****** Object:  StoredProcedure [dbo].[PR_INSERT_BufferInfo]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_INSERT_BufferInfo]
@RFID varchar(50),
@AGVIP varchar(50),
@Count int,
@Date varchar(50)

as
BEGIN
IF EXISTS(SELECT RFID FROM tb_BufferInfo WHERE RFID=@RFID)
	BEGIN
	UPDATE tb_BufferInfo SET [Count]=@Count,[Date]=@Date,AGVIP=@AGVIP WHERE RFID=@RFID
	END
ELSE
	BEGIN
	INSERT INTO tb_BufferInfo (RFID,[Count],[Date],AGVIP) VALUES(@RFID,@Count,@Date,@AGVIP)
	END
END

GO
/****** Object:  StoredProcedure [dbo].[PR_INSERT_CallBox]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PR_INSERT_CallBox]
	@SCallBoxNo varchar(50),
	@Sip varchar(50),	
	@SCount int,
	@Sx int,
	@Sy int,
	@SRFID varchar(50)
	
	
AS
BEGIN
IF EXISTS(SELECT Sip FROM tb_CallBox WHERE SCallBoxNo=@SCallBoxNo)
	BEGIN
	UPDATE tb_CallBox SET Sip=@Sip,SCount=@SCount,Sx=@Sx,Sy=@Sy ,SRFID=@SRFID WHERE SCallBoxNo=@SCallBoxNo
	DELETE tb_CallBoxLogic WHERE LCallBoxNo=@SCallBoxNo
	END
ELSE
	BEGIN
	INSERT INTO tb_CallBox (SCallBoxNo,Sip,SCount,Sx,Sy,SRFID) VALUES(@SCallBoxNo,@Sip,@SCount,@Sx,@Sy,@SRFID)
	DELETE tb_CallBoxLogic WHERE LCallBoxNo=@SCallBoxNo
	END
END

GO
/****** Object:  StoredProcedure [dbo].[PR_INSERT_CallBoxLogic]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_INSERT_CallBoxLogic]
	@LCallBoxNo varchar(50),
	@LAnJianNo varchar(50) ,
	@LToAGV_IP varchar(50) ,
	@LIsDown varchar(50) ,
	@LTask varchar(50) 

AS
BEGIN
INSERT INTO tb_CallBoxLogic (LCallBoxNo,LAnJianNo,LToAGV_IP,LIsDown,LTask) 
VALUES (@LCallBoxNo,@LAnJianNo,@LToAGV_IP,@LIsDown,@LTask)
END

GO
/****** Object:  StoredProcedure [dbo].[PR_INSERT_Crossing_hand]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[PR_INSERT_Crossing_hand]
	@areaNo varchar(50),	
	@inRFID  varchar(50),
	@inDir int,
	@outRFID  varchar(50),
	@outDir int
AS
	INSERT INTO tb_CROSS_INFO(Cno,Cinrfid,Cinfw,Coutrfid,Coutfw,Cac) 
	VALUES(@areaNo,@inRFID,@inDir,@outRFID,@outDir,0)

GO
/****** Object:  StoredProcedure [dbo].[PR_INSERT_CrossingANDOrder_hand]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[PR_INSERT_CrossingANDOrder_hand]
	@agvNo varchar(50),
	@areaNo varchar(50),	
	@inRFID  varchar(50),
	@inDir int,
	@outRFID  varchar(50),
	@outDir int
AS
BEGIN
	INSERT INTO tb_CROSS_INFO(Cno,Cinrfid,Cinfw,Coutrfid,Coutfw,Cac) 
	VALUES(@areaNo,@inRFID,@inDir,@outRFID,@outDir,0)
	
	INSERT INTO tb_AGV_ORDER(OAGV,OType,Ostirng) 
	VALUES(@agvNo,1,@areaNo)
END

GO
/****** Object:  StoredProcedure [dbo].[PR_INSERT_ELC]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_INSERT_ELC]
@Snumber varchar(50),
@Sip varchar(50),
@Sx int,
@Sy int,
@Srfid varchar(50),
@Sout int
AS
BEGIN
IF EXISTS(SELECT Sip FROM tb_ELC WHERE Sip=@Sip)
	BEGIN
	UPDATE tb_ELC SET Snumber=@Snumber,Sx=@Sx,Sy=@Sy,Sout=@Sout,Srfid=@Srfid WHERE Sip=@Sip
	DELETE tb_Elec_ WHERE Lip=@Sip
	END
ELSE
	BEGIN
	INSERT INTO tb_ELC (Snumber,Sip,Sx,Sy,Sout,Srfid,SagvNo) VALUES(@Snumber,@Sip,@Sx,@Sy,@Sout,@Srfid,0)
	DELETE tb_Elec_ WHERE Lip=@Sip
	END
END

GO
/****** Object:  StoredProcedure [dbo].[PR_INSERT_Elec]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_INSERT_Elec]
@Sip VARCHAR(50),
@Lname varchar(50),
@LmainLineno varchar(50),
@Linrfid varchar(50),
@Linlouceng int,
@Linfow int,
@Loutlouceng int,
@Loutrfid varchar(50)
AS
BEGIN
INSERT INTO tb_Elec_ (Lip,Lname,LmainLineno,Linrfid,Linlouceng,Linfow,Loutlouceng,Loutrfid) VALUES (@Sip,@Lname,@LmainLineno,@Linrfid,@Linlouceng,@Linfow,@Loutlouceng,@Loutrfid)
END

GO
/****** Object:  StoredProcedure [dbo].[PR_INSERT_ORDER_Info_FROM_AGV]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_INSERT_ORDER_Info_FROM_AGV]
@oagv varchar(50),
@otype int,
@ostring varchar(50)

as
	INSERT INTO tb_AGV_ORDER(OAGV,OType,Ostirng) VALUES(@oagv,@otype,@ostring)

GO
/****** Object:  StoredProcedure [dbo].[PR_INSERT_Power_INFO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_INSERT_Power_INFO]
@P_NO VARCHAR(50),
@P_IP VARCHAR(50),
@P_LINENO VARCHAR(50),
@P_ST_RFID VARCHAR(50),
@P_X INT,
@P_Y INT,
@P_IN_RFID VARCHAR(50),
@P_IN_FW INT,
@P_IN_LINENO VARCHAR(50),
@P_POWER_H INT,
@P_POWER_L INT,
@P_OUT_LINENO VARCHAR(50),
@P_OUT_RFID VARCHAR(50),
@P_OUT_FW INT
AS
BEGIN
IF EXISTS(SELECT P_IP FROM tb_Power_INFO WHERE P_IP=@P_IP)
	BEGIN
	UPDATE tb_Power_INFO SET PNo=@P_NO,P_IP=@P_IP,
							 p_LineNo=@P_LINENO,
							 P_St_RFID=@P_ST_RFID,
							 P_x=@P_X,p_y=@P_Y,
							 P_In_RFID=@P_IN_RFID,
							 P_In_FW=@P_IN_FW,
							 p_IN_LineNo=@P_IN_LINENO,
							 P_Power_H=@P_POWER_H,
							 P_power_L=@P_POWER_L,
							 P_Out_LineNo=@P_OUT_LINENO,
							 P_Out_RFID=@P_OUT_RFID,
							 P_Out_FW=@P_OUT_FW
							 WHERE P_IP=@P_IP
	END
ELSE 
	BEGIN
	INSERT INTO tb_Power_INFO (PNo,P_IP,P_LineNo,P_St_RFID,P_x,p_y,P_In_RFID,P_In_FW,p_IN_LineNo,P_Power_H,P_power_L,P_Out_LineNo,P_Out_RFID,P_Out_FW) VALUES 
	                          (@P_NO,@P_IP,@P_LINENO,@P_ST_RFID,@P_X,@P_Y,@P_IN_RFID,@P_IN_FW,@P_IN_LINENO,@P_POWER_H,@P_POWER_L,@P_OUT_LINENO,@P_OUT_RFID,@P_OUT_FW)
	END
END

GO
/****** Object:  StoredProcedure [dbo].[PR_INSERT_TaskReset_All]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_INSERT_TaskReset_All]
@resetRFID	 varchar(50),
@resetFW	 varchar(50),
@resetAGV	 varchar(50)

as
BEGIN
IF EXISTS(SELECT * FROM tb_TaskReset WHERE resetRFID=@resetRFID)
	BEGIN
	UPDATE tb_TaskReset SET resetFW=@resetFW,resetAGV=@resetAGV WHERE resetRFID=@resetRFID
	END
ELSE
	BEGIN
	INSERT INTO tb_TaskReset (resetRFID,resetFW,resetAGV) VALUES(@resetRFID,@resetFW,@resetAGV)
	END
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_AGV_AC]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[PR_SELECT_AGV_AC]
as
select * from tb_AGV_INFO  where  AGV_AC=1

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_AGV_BYCNCIP]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[PR_SELECT_AGV_BYCNCIP]--查找该CNC所在产线的可用的AGV
@cnc_ip varchar(50)
AS
SELECT * from tb_AGV_INFO 
where AGV_AC=1 AND AGV_ErrorCord=0 AND AGV_LineNO=0 AND AGV_Heart=0 AND AGV_ElecString=0 --无任务，无异常，不在上料中，不在去上料中
AND  AGV_IP IN
(SELECT  agv_ip FROM  tb_CNCIP_Line a,tb_CNCLine_AGV b 
WHERE a.cnc_ip=@cnc_ip and a.cnc_line=b.cnc_line)

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_AGV_BYIP]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PR_SELECT_AGV_BYIP]
@ip varchar(50)
as
select * from tb_AGV_INFO where AGV_IP=@ip and AGV_AC=1

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_AGV_BYRFID]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_SELECT_AGV_BYRFID]
@RFID varchar(50)
as
select * from tb_AGV_INFO where AGV_RFID_Now=@RFID and AGV_AC=1

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_AGV_INFO_MAXREMARK]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PR_SELECT_AGV_INFO_MAXREMARK]
as
select MAX(CONVERT(int,AGV_Remark))from tb_AGV_INFO

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_AGV_IP_BYRemark]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[PR_SELECT_AGV_IP_BYRemark]
@AGV_Remark varchar(50)
AS
SELECT AGV_IP FROM  tb_AGV_INFO WHERE AGV_Remark=@AGV_Remark

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_AGV_ORDER]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_AGV_ORDER]
@OAGV VARCHAR(50)
AS
SELECT * FROM TB_AGV_ORDER WHERE OAGV=@OAGV

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_AGV_Remark_BYIP]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[PR_SELECT_AGV_Remark_BYIP]
@AGV_IP varchar(50)
AS
SELECT AGV_Remark FROM  tb_AGV_INFO WHERE AGV_IP=@AGV_IP

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_Area_All]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_Area_All]
AS
BEGIN
SELECT * FROM tb_Area ORDER BY CONVERT(int, AreaNo) ASC
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_AREA_CODE]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[PR_SELECT_AREA_CODE]
@areaNo varchar(50)
as
select AreaName from tb_Area  where  AreaNo=@areaNo

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_AuotDoor_INFO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_AuotDoor_INFO]
AS
BEGIN
SELECT * FROM tb_AutoDoor_INFO
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_AutoDoor_INFO_ORDER]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_AutoDoor_INFO_ORDER]
@RFID VARCHAR(50),
@FW INT,
@P_IP VARCHAR(50),
@AGV_IP VARCHAR(50)
AS
BEGIN
	UPDATE tb_AutoDoor_INFO SET D_AGV=@AGV_IP WHERE D_In_RFID=@RFID AND D_FW=@FW AND D_ip=@P_IP AND D_AGV=''
	UPDATE tb_AutoDoor_INFO SET D_AGV='' WHERE D_Out_RFID NOT LIKE '%,'+@RFID+',%' AND D_FW=@FW AND D_ip=@P_IP AND D_AGV=@AGV_IP
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_Bin]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_Bin]
AS
BEGIN
	SELECT * FROM tb_BIN WHERE B_CP<>0 ORDER BY B_CP ASC
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_Bin_BYNum]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_Bin_BYNum]
@No varchar(50)
AS
BEGIN
	SELECT * FROM tb_BIN WHERE Bin_No =@No AND B_CP<>0
 END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_BIN_Queue]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_BIN_Queue]
AS
BEGIN 
	SELECT * FROM tb_BIN WHERE B_CP<>0 ORDER BY B_CP desc
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_BINInfo]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_BINInfo]
AS
BEGIN 
	SELECT * FROM tb_BIN
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_Buffer_temp_ALL]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_SELECT_Buffer_temp_ALL]
as
select * FROM tb_Buffer_temp

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_Buffer_temp_order]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_SELECT_Buffer_temp_order]
@AGVIP varchar(50)

as
select Reserve1 FROM tb_Buffer_temp WHERE AGV_IP=@AGVIP

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_BufferInfo]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_SELECT_BufferInfo]
as
	select * from tb_BufferInfo order by RFID asc

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_BufferInfo_Count]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_SELECT_BufferInfo_Count]
as
	select * from tb_BufferInfo
	where [Count]=1
	order by RFID asc

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_BufferInfo_RFID]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_SELECT_BufferInfo_RFID]
@RFID varchar(50)
as
	select * from tb_BufferInfo where RFID=@RFID

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_CallBox]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_CallBox]
AS
BEGIN
SELECT * FROM tb_CallBox ORDER BY Sid ASC
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_CallBox_ByCallBoxNo]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_CallBox_ByCallBoxNo]
@SCallBoxNo varchar(50),
@LINETYPE INT
AS
BEGIN
SELECT * FROM tb_CallBox 
where SCallBoxNo=@SCallBoxNo
AND LINETYPE=@LINETYPE
ORDER BY Sid ASC
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_CALLBOX_FIRST_ISDOWN]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PR_SELECT_CALLBOX_FIRST_ISDOWN]
	@LCallBoxNo VARCHAR(50),
	@LAnJianNo VARCHAR(50)
AS
BEGIN
	SELECT COUNT(1)
	FROM   tb_CallBoxLogic AS tcbl
	WHERE  tcbl.LCallBoxNo = @LCallBoxNo
	       AND tcbl.LAnJianNo = @LAnJianNo
	       AND tcbl.LIsDown = '1'
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_CallBox_IP]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_CallBox_IP]
@SCallBoxNo VARCHAR(50)
AS
BEGIN
SELECT * FROM tb_CallBox WHERE SCallBoxNo=@SCallBoxNo
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_CallBoxLogic]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_CallBoxLogic]
@LINETYPE INT 
AS
BEGIN
	SELECT *
	FROM   tb_CallBoxLogic
	WHERE  LIsDown != '0'
	AND LINETYPE=@LINETYPE
	ORDER BY
	       LIsDown ASC
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_CallBoxLogic_ALL]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[PR_SELECT_CallBoxLogic_ALL]
AS
BEGIN
SELECT * FROM tb_CallBoxLogic
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_CallBoxLogic_byTask]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[PR_SELECT_CallBoxLogic_byTask]
@callBoxNo varchar(50),
@AnJianNo varchar(50)
AS
BEGIN
SELECT LIsDown FROM tb_CallBoxLogic where LCallBoxNo=@callBoxNo and LAnJianNo=@AnJianNo 
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_CallBoxLogic_IP]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_CallBoxLogic_IP]
@LCallBoxNo VARCHAR(50)
AS
BEGIN
SELECT * FROM tb_CallBoxLogic WHERE LCallBoxNo=@LCallBoxNo
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_CNC]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_SELECT_CNC]
as
select * from tb_cnc

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_CNC_BYCNC_No]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_CNC_BYCNC_No]
@CNC_No varchar(50)
AS
BEGIN
	SELECT * FROM tb_CNC WHERE cnc_no = @CNC_No AND cnc_thing<>0
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_CNC_ByOrder]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_SELECT_CNC_ByOrder]
as
select * from tb_cnc order by cnc_thing

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_CNC_ByOrder2]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_SELECT_CNC_ByOrder2]
as
select * from tb_cnc where cnc_thing!='' order by cnc_thing

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_CNC_CODE3_BYCNCMNO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PR_SELECT_CNC_CODE3_BYCNCMNO]
@cnc_Mno int
as

select cnc_reserve3 from tb_cnc where cnc_reserve1=@cnc_Mno

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_CNC_MNo_BYCNCNO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PR_SELECT_CNC_MNo_BYCNCNO]
@cnc_no int
as

select cnc_reserve1 from tb_cnc where cnc_no=@cnc_no

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_CNC_Queue]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PR_SELECT_CNC_Queue]
as
select * from tb_cnc where cnc_thing  =1 OR cnc_thing =2 OR cnc_thing = 16 OR cnc_thing =32

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_CNCAGVIP_BYAGVIP]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_SELECT_CNCAGVIP_BYAGVIP]
@agv_ip varchar(50)
as

select * from tb_cnc where cnc_agv_ip=@agv_ip

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_Cross_ALL]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PR_SELECT_Cross_ALL]
as
	select * from tb_CROSS_INFO order by Cac desc

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_CROSS_INFO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_CROSS_INFO]
@AGV_NO INT,
@RFID VARCHAR(50),
@FW INT,
@Cno VARCHAR(50),
@AGV_IP VARCHAR(50)
AS
BEGIN
IF EXISTS(SELECT Cid FROM tb_CROSS_INFO WHERE Coutrfid=@RFID AND Coutfw=@FW AND Cno=@Cno AND Cac=@AGV_NO)
	BEGIN
	UPDATE tb_CROSS_INFO SET Cac=0 WHERE Cno=@Cno AND Cac=@AGV_NO
	UPDATE tb_AGV_INFO SET AGV_TO='' WHERE AGV_IP=@AGV_IP
	END
ELSE IF NOT EXISTS(SELECT Cid FROM tb_CROSS_INFO WHERE Cno=@Cno AND Cac>0 AND Cac!=@AGV_NO)
	BEGIN
	IF EXISTS(SELECT Cid FROM tb_CROSS_INFO WHERE Cno=@Cno AND (Cac=0 OR Cac=@AGV_NO) AND @RFID=Cinrfid AND Cinfw=@FW)
		BEGIN		
		SELECT * FROM tb_CROSS_INFO WHERE Cinfw=@FW AND Cinrfid=@RFID AND Cno=@Cno
		END
	END
IF EXISTS(SELECT Cid FROM tb_CROSS_INFO WHERE Cno=@Cno AND Cinfw=@FW AND Cinrfid=@RFID AND Cac>0 AND Cac!=@AGV_NO)
	BEGIN		
		SELECT -1
	END
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_ELC]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_ELC]
AS
BEGIN
SELECT * FROM tb_ELC ORDER BY Sid ASC
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_ELC_IP]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_ELC_IP]
@Sip VARCHAR(50)
AS
BEGIN
SELECT * FROM tb_ELC WHERE Sip=@Sip
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_ELC_MAINLINENO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_ELC_MAINLINENO]
@MAINLINENO VARCHAR(50),
@AGV_IP VARCHAR(50)
AS
--IF NOT EXISTS(SELECT AGV_IP FROM tb_AGV_INFO WHERE AGV_IP=@AGV_IP AND RTRIM(AGV_TO)!='')
--BEGIN
SELECT * FROM tb_Elec_ WHERE LmainLineno=@MAINLINENO
--END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_Elec_IP]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_Elec_IP]
@Sip VARCHAR(50)
AS
BEGIN
SELECT * FROM tb_Elec_ WHERE Lip=@Sip
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_ORDER_INFO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_SELECT_ORDER_INFO]
as
	select * from tb_AGV_ORDER Order by OAGV

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_ORDER_TYPE]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[PR_SELECT_ORDER_TYPE]
@otype int
as
select * from tb_AGV_ORDER  where  OType=@otype order by OAGV

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_Power_INFO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_Power_INFO]
@LINETYPE INT 
AS
SELECT * FROM tb_Power_INFO WHERE LINETYPE=@LINETYPE

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_Power_INFO_IP]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_Power_INFO_IP]
@P_IP VARCHAR(50)
AS
SELECT * FROM tb_Power_INFO WHERE P_IP=@P_IP

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_Power_INFO_MAXREMARK]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_SELECT_Power_INFO_MAXREMARK]
as
select MAX(CONVERT(int,PNo))from tb_Power_INFO

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_Power_INFO_ORDER]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_Power_INFO_ORDER]
@RFID VARCHAR(50),
@FW INT,
@P_IP VARCHAR(50),
@AGV_IP VARCHAR(50)
AS
BEGIN
--IF EXISTS(SELECT P_IP FROM tb_Power_INFO WHERE P_Out_RFID=@RFID AND P_Out_FW=@FW AND P_IP=@P_IP AND P_AGV_IP=@AGV_IP)
	IF EXISTS(SELECT P_IP FROM tb_Power_INFO WHERE (P_Out_RFID NOT LIKE '%,'+@RFID+',%') AND P_IP=@P_IP AND P_AGV_IP=@AGV_IP)
	BEGIN
	UPDATE tb_Power_INFO SET P_AGV_IP='' WHERE (P_Out_RFID NOT LIKE '%,'+@RFID+',%') AND P_IP=@P_IP AND P_AGV_IP=@AGV_IP
	END
ELSE IF EXISTS(SELECT * FROM tb_Power_INFO WHERE P_IP=@P_IP AND ((P_In_RFID=@RFID) OR P_St_RFID=@RFID) AND (P_AGV_IP='' OR P_AGV_IP IS NULL OR P_AGV_IP=@AGV_IP))
	BEGIN
	UPDATE tb_Power_INFO SET P_AGV_IP=@AGV_IP WHERE P_IP=@P_IP AND ((P_In_RFID=@RFID) OR P_St_RFID=@RFID) AND (P_AGV_IP='' OR P_AGV_IP IS NULL)
	SELECT * FROM tb_Power_INFO WHERE P_IP=@P_IP AND ((P_In_RFID=@RFID) OR P_St_RFID=@RFID) AND (P_AGV_IP='' OR P_AGV_IP IS NULL OR P_AGV_IP=@AGV_IP)
	END
ELSE 
	BEGIN
	SELECT * FROM tb_Power_INFO WHERE P_IP=@P_IP AND ((P_In_RFID=@RFID) OR P_St_RFID=@RFID)
	END
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_Proj]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_SELECT_Proj]
as
	select * from tb_Proj_Info

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_RESETTASK]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[PR_SELECT_RESETTASK]
@resetRFID	 varchar(50),
@resetFW	 varchar(50),
@resetAGV	 varchar(50)
as
select * from tb_TaskReset 
where resetRFID=@resetRFID and resetFW=@resetFW and resetAGV=@resetAGV

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_RESETTASK_ALL]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_SELECT_RESETTASK_ALL]
as
select * from tb_TaskReset

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_RFID_MAP]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELECT_RFID_MAP]
AS
SELECT * FROM tb_RFID_MAP

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_RFID_ResetAll]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc  [dbo].[PR_SELECT_RFID_ResetAll]
@RFID varchar(50)
as
SELECT * FROM tb_RFID_ResetAll WHERE (RFID  LIKE '%,'+@RFID+',%')

GO
/****** Object:  StoredProcedure [dbo].[PR_SELECT_USED_CNO_INCROSSING]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_SELECT_USED_CNO_INCROSSING]
as
	select distinct Cno from tb_CROSS_INFO

GO
/****** Object:  StoredProcedure [dbo].[PR_SELETE_AGV_INFO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELETE_AGV_INFO]
@LINETYPE INT
AS
BEGIN
SELECT * FROM tb_AGV_INFO WHERE LINETYPE=@LINETYPE
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELETE_AGV_INFO_ACTIVE]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PR_SELETE_AGV_INFO_ACTIVE]
@LINETYPE INT
AS
BEGIN
	SELECT * FROM tb_AGV_INFO AS tai WHERE tai.AGV_ISACTIVE=1 AND LINETYPE=@LINETYPE
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELETE_AGV_INFO_AGV_LINENO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELETE_AGV_INFO_AGV_LINENO]
@AGV_LINENO VARCHAR(50)
AS
BEGIN
SELECT * FROM tb_AGV_INFO WHERE AGV_LINENO=@AGV_LINENO
END

GO
/****** Object:  StoredProcedure [dbo].[PR_SELETE_AGV_LINE]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_SELETE_AGV_LINE]
AS
BEGIN
SELECT * FROM tb_AGV_LINE
END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_AGV_INFO_FROM]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_AGV_INFO_FROM]
@AGVIP VARCHAR(50),
@AGVFROM VARCHAR(50)
AS
UPDATE tb_AGV_INFO SET AGV_FROM=@AGVFROM WHERE AGV_IP=@AGVIP

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_AGV_INFO_ISACTIVE]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PR_UPDATE_AGV_INFO_ISACTIVE]
	@AGVIP VARCHAR(50),
	@AGVTO VARCHAR(50)
AS
BEGIN
	UPDATE tb_AGV_INFO
	SET    AGV_ISACTIVE = 0,
	       AGV_TO = @AGVTO
	WHERE  AGV_IP = @AGVIP
	
	UPDATE tb_AGV_INFO
	SET    AGV_ISACTIVE = 1
	WHERE  AGV_IP != @AGVIP
END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_AGV_INFO_TO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_AGV_INFO_TO]
@AGVIP VARCHAR(50),
@AGVTO VARCHAR(50)
AS
UPDATE tb_AGV_INFO SET AGV_TO=@AGVTO WHERE AGV_IP=@AGVIP
--UPDATE tb_CROSS_INFO SET Cac=CONVERT(INT,(SELECT AGV_Remark FROM  tb_AGV_INFO WHERE AGV_IP=@AGVIP)) WHERE Cno=@AGVTO

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_AGV_LineString_last]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[PR_UPDATE_AGV_LineString_last]--上一个任务
@AGVIP VARCHAR(50),
@LineString_last VARCHAR(50)
AS
UPDATE tb_AGV_INFO SET AGV_LineString=@LineString_last WHERE AGV_IP=@AGVIP

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_AGV_reset]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[PR_UPDATE_AGV_reset]
@AGVIP VARCHAR(50),
@AGV_LineNO VARCHAR(50),--当前任务
@AGV_LineString VARCHAR(200),--上一任务
@AGV_ElecString VARCHAR(200)--上料状态
AS
UPDATE tb_AGV_INFO 
SET AGV_LineNO=@AGV_LineNO ,AGV_LineString=@AGV_LineString,AGV_ElecString=@AGV_ElecString
WHERE AGV_IP=@AGVIP

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_AGV_TO_CALLBOX]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PR_UPDATE_AGV_TO_CALLBOX]
	@AGVIP VARCHAR(50),
	@AGVTO VARCHAR(50),
	@AGV_ISCALLBOX INT
AS
BEGIN
	UPDATE tb_AGV_INFO
	SET    AGV_TO            = @AGVTO,
	       AGV_ISCALLBOX     = @AGV_ISCALLBOX
	WHERE  AGV_IP            = @AGVIP
END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_AutoDoor]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_AutoDoor]
@D_ip VARCHAR(50),
@OutIn INT
AS
BEGIN
	UPDATE tb_AutoDoor_INFO SET D_AC=1,D_OutIn=@OutIn WHERE D_ip=@D_ip
END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_BIN]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_BIN]
@No int,
@ap int,
@cp  int ,
@leave int,
@a1d int,
@a2d int,
@a3d int,
@a4d int,
@a1o int,
@a2o int,
@a3o int,
@a4o int
AS
BEGIN
	UPDATE tb_BIN SET B_AP = @ap,B_CP = @cp,B_Leave = @leave,
					  B_A1D=@a1d,B_A2D = @a2d,B_A3D= @a3d,B_A4D = @a4d,B_A1O=@a1o,B_A2O = @a2o,B_A3O= @a3o,B_A4O = @a4o
					  WHERE BIN_No = @No
END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_BufferInfo_Count]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_BufferInfo_Count]
	@RFID varchar(50) ,
		@count int

AS
IF EXISTS(SELECT * FROM tb_BufferInfo WHERE RFID=@RFID)
BEGIN
UPDATE tb_BufferInfo
SET  [Count]=@count
where RFID=@RFID
END
ELSE
	BEGIN
	INSERT INTO tb_BufferInfo (RFID,[Count]) VALUES(@RFID,@Count)
	END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_CallBoc_SAC]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[PR_UPDATE_CallBoc_SAC]
AS
BEGIN
UPDATE tb_CallBox SET SAc=-1
END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_CallBox]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_CallBox]
	@SCallBoxNo varchar(50),
	@SAc varchar(50) 
	

AS
IF EXISTS(SELECT SCallBoxNo FROM tb_CallBox WHERE SCallBoxNo=@SCallBoxNo)
BEGIN
UPDATE tb_CallBox
SET  SAc=@SAc
where SCallBoxNo=@SCallBoxNo
END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_CallBoxLogic]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_CallBoxLogic]
@LCallBoxNo VARCHAR(50),
@LAnJianNo VARCHAR(50),
@LIsDown VARCHAR(50)

AS
IF EXISTS(SELECT LCallBoxNo FROM tb_CallBoxLogic WHERE LCallBoxNo=@LCallBoxNo)
BEGIN
UPDATE tb_CallBoxLogic 
SET LIsDown=@LIsDown
where LCallBoxNo=@LCallBoxNo and LAnJianNo=@LAnJianNo
END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_CNC]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_CNC]
--@cnc_id INT,
--@cnc_no INT,
@cnc_ip VARCHAR(50),
--@cnc_line VARCHAR(50),
--@cnc_acc VARCHAR(50),
--@cnc_state VARCHAR(50),
@cnc_thing  VARCHAR(50),
--@cnc_thing1  VARCHAR(50),
--@cnc_thing2  VARCHAR(50),
--@cnc_door VARCHAR(50),
@cnc_agv_ip VARCHAR(50)
--@cnc_reserve1 VARCHAR(50),
--@cnc_reserve2 VARCHAR(50),
--@cnc_reserve3 VARCHAR(50)

AS
IF EXISTS(SELECT cnc_ip FROM tb_CNC WHERE cnc_ip=@cnc_ip)
	BEGIN
	UPDATE tb_CNC SET 
	cnc_thing=@cnc_thing,
	cnc_agv_ip=@cnc_agv_ip
	WHERE cnc_ip=@cnc_ip
	END
	ELSE
	BEGIN
	INSERT INTO tb_CNC (cnc_ip,cnc_thing,cnc_agv_ip) VALUES (@cnc_ip,@cnc_thing,@cnc_agv_ip)
	END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_CNC_call]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_CNC_call]
@cnc_M_NO VARCHAR(50),
@call VARCHAR(50)
AS
	IF EXISTS(SELECT cnc_thing FROM tb_CNC WHERE cnc_no = @cnc_M_No)
	BEGIN
	UPDATE tb_CNC SET 
	cnc_thing=@call --(CASE WHEN RTRIM(cnc_thing)='' THEN @call ELSE cnc_thing END)
	WHERE cnc_no=@cnc_M_NO
	END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_CNC_end_BY_MNO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_CNC_end_BY_MNO]
@cnc_M_NO VARCHAR(50),
@reciveCode INT,
@end_timr VARCHAR(50)
AS
IF EXISTS(SELECT cnc_reserve1 FROM tb_CNC WHERE cnc_reserve1=@cnc_M_NO)
	BEGIN
	UPDATE tb_CNC SET 
	cnc_reserve2=@end_timr , cnc_reserve3=@reciveCode
	WHERE cnc_reserve1=@cnc_M_NO
	END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_CNC_end3_BY_MNO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[PR_UPDATE_CNC_end3_BY_MNO]
@cnc_M_NO VARCHAR(50),
@reciveCode INT
AS
IF EXISTS(SELECT cnc_reserve1 FROM tb_CNC WHERE cnc_reserve1=@cnc_M_NO)
	BEGIN
	UPDATE tb_CNC SET 
	cnc_reserve3=@reciveCode
	WHERE cnc_reserve1=@cnc_M_NO
	END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_CNC_reset]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[PR_UPDATE_CNC_reset]
@cnc_no INT,
@cnc_thing  VARCHAR(50),
@cnc_door VARCHAR(50),
@cnc_agv_ip VARCHAR(50),
@cnc_reserve2 VARCHAR(50),
@cnc_reserve3 VARCHAR(50)

AS
	UPDATE tb_CNC SET 
	cnc_thing=@cnc_thing,
	cnc_door=@cnc_door,
	cnc_agv_ip=@cnc_agv_ip,
	cnc_reserve2=@cnc_reserve2,
	cnc_reserve3=@cnc_reserve3
	WHERE cnc_no=@cnc_no

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_CNC_STATE]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_CNC_STATE]
@cnc_M_NO VARCHAR(50),
@state  VARCHAR(50)
AS
IF EXISTS(SELECT cnc_state FROM tb_CNC WHERE cnc_reserve1=@cnc_M_NO)
	BEGIN
	UPDATE tb_CNC SET 
	cnc_state=@state
	WHERE cnc_reserve1=@cnc_M_NO
	END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_CNC_up]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_CNC_up]
@cnc_M_NO VARCHAR(50),
@up INT
AS
IF EXISTS(SELECT cnc_door FROM tb_CNC WHERE cnc_reserve1=@cnc_M_NO)
	BEGIN
	UPDATE tb_CNC SET 
	cnc_door=@up
	WHERE cnc_reserve1=@cnc_M_NO
	END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_CNCAGVIP]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_CNCAGVIP]
@cnc_ip VARCHAR(50),
@cnc_agv_ip VARCHAR(50)
AS
IF EXISTS(SELECT cnc_ip FROM tb_CNC WHERE cnc_reserve1=@cnc_ip)
	BEGIN
	UPDATE tb_CNC SET 
	cnc_agv_ip=@cnc_agv_ip
	WHERE cnc_reserve1=@cnc_ip
	END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_Cross_cac]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_UPDATE_Cross_cac]
@cid int
as
update tb_CROSS_INFO 
set Cac=0
where Cid=@cid

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_Cross_cac_agv]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_UPDATE_Cross_cac_agv]
@cac int
as
update tb_CROSS_INFO 
set Cac=0
where Cac=@cac

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_ELC]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_ELC]
@SIP VARCHAR(50),
@LINKAC INT,
@LOUCENG INT,
@CANIN INT,
@AC INT
AS
IF EXISTS(SELECT Sip FROM tb_ELC WHERE Sip=@SIP)
BEGIN
UPDATE tb_ELC SET Slinkac=@LINKAC,Slouceng=@LOUCENG,ScanIn=@CANIN,Sac=@AC where Sip=@SIP
END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_ELC_AGVNO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_ELC_AGVNO]
@SIP VARCHAR(50),
@SAGVNO INT
AS
UPDATE tb_ELC SET SagvNo=@SAGVNO where Sip=@SIP

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_ELC_InAGVNo]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[PR_UPDATE_ELC_InAGVNo]
@SagvNo int
as
update tb_ELC 
set SagvNo=0
where SagvNo=@SagvNo

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_ELC_obsturction]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[PR_UPDATE_ELC_obsturction]
@SIP VARCHAR(50),
@obsturction INT

AS
IF EXISTS(SELECT Sip FROM tb_ELC WHERE Sip=@SIP)
BEGIN
UPDATE tb_ELC SET obsturction=@obsturction where Sip=@SIP
END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_POWER]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_POWER]
@P_IP VARCHAR(50),
@P_INOUT INT
AS
IF EXISTS(SELECT P_IP FROM tb_Power_INFO WHERE P_IP=@P_IP)
BEGIN
UPDATE tb_Power_INFO SET P_AC=1,P_InOut=@P_INOUT where P_IP=@P_IP
END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_POWER_AGVIP]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PR_UPDATE_POWER_AGVIP]
	@AGVIP VARCHAR(50),
	@POWERIP VARCHAR(50)
AS
BEGIN
	UPDATE tb_Power_INFO
	SET    P_AGV_IP     = @AGVIP
	WHERE  P_IP         = @POWERIP
END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_tb_AGV_INFO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_tb_AGV_INFO]
AS
BEGIN
UPDATE tb_AGV_INFO SET AGV_AC=-1
--UPDATE tb_ELC SET Sac=-1
UPDATE tb_Power_INFO SET P_AC=-1
UPDATE tb_CallBox SET SAc=-1
--UPDATE tb_AutoDoor_INFO SET D_AC=-1
END

GO
/****** Object:  StoredProcedure [dbo].[PR_UPDATE_tb_AGV_INFO_NEW]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[PR_UPDATE_tb_AGV_INFO_NEW]
@MSC_IP VARCHAR(50)
AS
BEGIN
UPDATE tb_AGV_INFO SET AGV_AC=-1 WHERE AGV_IP=@MSC_IP
--UPDATE tb_ELC SET Sac=-1 WHERE Sip=@MSC_IP
UPDATE tb_Power_INFO SET P_AC=-1 WHERE P_IP=@MSC_IP
--UPDATE tb_AutoDoor_INFO SET D_AC=-1 WHERE D_ip=@MSC_IP
END

GO
/****** Object:  Table [dbo].[RGB_CARMESSAGE]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RGB_CARMESSAGE](
	[RGB_ID] [int] IDENTITY(1,1) NOT NULL,
	[RGB_NUMBER] [varchar](10) NOT NULL,
	[RGB_AC] [int] NOT NULL,
	[RGB_STA_NOW] [nchar](10) NOT NULL,
	[RGB_FROM] [nchar](10) NULL,
	[RGB_TO] [nchar](10) NULL,
 CONSTRAINT [PK_RGB_CARMESSAGE] PRIMARY KEY CLUSTERED 
(
	[RGB_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RGB_ORDMESSAGE]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RGB_ORDMESSAGE](
	[RGB_CAR_ID] [int] IDENTITY(1,1) NOT NULL,
	[RGB_ORD_TYPE] [nchar](10) NOT NULL,
	[RGB_CAR_NUMBER] [varchar](10) NULL,
	[RGB_FROM] [nchar](10) NULL,
	[RGB_TO] [nchar](10) NULL,
	[RGB_REV_TIME] [datetime] NOT NULL,
	[RGB_ORD_TIME] [datetime] NULL,
	[RGB_FINISH_TIME] [datetime] NULL,
	[RGB_AC] [int] NOT NULL,
 CONSTRAINT [PK_RGB_ORDMESSAGE] PRIMARY KEY CLUSTERED 
(
	[RGB_CAR_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RGB_STA_MESSAGE]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RGB_STA_MESSAGE](
	[RGB_STA_ID] [int] IDENTITY(1,1) NOT NULL,
	[RGB_STA_NUMBER] [varchar](10) NOT NULL,
	[RGB_STA_NAME] [nvarchar](20) NOT NULL,
	[RGB_STA_AC] [int] NOT NULL,
	[RGB_STA_TYPE] [int] NOT NULL,
	[RGB_STA_BUFFER_NUMBER] [int] NOT NULL,
	[RGB_STA_BUFFER1] [nchar](10) NULL,
	[RGB_STA_BUFFER2] [nchar](10) NULL,
	[RGB_STA_BUFFER3] [nchar](10) NULL,
	[RGB_STA_BUFFER4] [nchar](10) NULL,
	[RGB_STA_BUFFER5] [nchar](10) NULL,
	[RGB_STA_BUFFER6] [nchar](10) NULL,
	[RGB_STA_BUFFER7] [nchar](10) NULL,
	[RGB_STA_BUFFER8] [nchar](10) NULL,
	[RGB_STA_BUFFER9] [nchar](10) NULL,
	[RGB_STA_BUFFER10] [nchar](10) NULL,
	[RGB_STA_BUFFER11] [nchar](10) NULL,
	[RGB_STA_BUFFER12] [nchar](10) NULL,
	[RGB_STA_BUFFER13] [nchar](10) NULL,
	[RGB_STA_BUFFER14] [nchar](10) NULL,
	[RGB_STA_BUFFER15] [nchar](10) NULL,
	[RGB_STA_BUFFER16] [nchar](10) NULL,
	[RGB_STA_BUFFER17] [nchar](10) NULL,
	[RGB_STA_BUFFER18] [nchar](10) NULL,
	[RGB_STA_BUFFER19] [nchar](10) NULL,
	[RGB_STA_BUFFER20] [nchar](10) NULL,
	[RGB_STA_BUFFER21] [nchar](10) NULL,
	[RGB_STA_BUFFER22] [nchar](10) NULL,
	[RGB_STA_BUFFER23] [nchar](10) NULL,
	[RGB_STA_BUFFER24] [nchar](10) NULL,
	[RGB_STA_BUFFER25] [nchar](10) NULL,
	[RGB_STA_BUFFER26] [nchar](10) NULL,
	[RGB_STA_BUFFER27] [nchar](10) NULL,
	[RGB_STA_BUFFER28] [nchar](10) NULL,
	[RGB_STA_BUFFER29] [nchar](10) NULL,
	[RGB_STA_BUFFER30] [nchar](10) NULL,
 CONSTRAINT [PK_RGB_STA_MESSAGE] PRIMARY KEY CLUSTERED 
(
	[RGB_STA_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_AGV_INFO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_AGV_INFO](
	[AGV_ID] [int] IDENTITY(1,1) NOT NULL,
	[AGV_IP] [varchar](50) NOT NULL,
	[AGV_AC] [int] NULL,
	[AGV_RFID_Now] [varchar](50) NULL,
	[AGV_FROM] [varchar](50) NULL,
	[AGV_TO] [varchar](50) NULL,
	[AGV_LineNO] [varchar](50) NULL,
	[AGV_Remark] [varchar](50) NULL,
	[AGV_ErrorCord] [varchar](50) NULL,
	[AGV_Power] [varchar](50) NULL,
	[AGV_Speed] [varchar](50) NULL,
	[AGV_FW] [int] NULL,
	[AGV_LineString] [varchar](50) NULL,
	[AGV_BoxState] [varchar](50) NULL,
	[AGV_Task] [int] NULL,
	[AGV_ElecString] [varchar](50) NULL,
	[AGV_Heart] [int] NULL,
	[AGV_ISACTIVE] [int] NULL,
	[AGV_ISEMPTY] [int] NULL,
	[AGV_ISPUSH] [int] NULL,
	[AGV_ISCALLBOX] [int] NULL,
	[LINETYPE] [int] NULL,
 CONSTRAINT [PK_tb_AGV_INFO] PRIMARY KEY CLUSTERED 
(
	[AGV_IP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_AGV_LINE]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_AGV_LINE](
	[LID] [int] IDENTITY(1,1) NOT NULL,
	[LLINENO] [varchar](50) NOT NULL,
	[LSTRING] [varchar](1000) NULL,
	[LTAG] [int] NULL,
 CONSTRAINT [PK_tb_AGV_LINE_1] PRIMARY KEY CLUSTERED 
(
	[LLINENO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_AGV_ORDER]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_AGV_ORDER](
	[Oid] [int] IDENTITY(1,1) NOT NULL,
	[OAGV] [varchar](50) NULL,
	[OType] [int] NULL,
	[Ostirng] [varchar](50) NULL,
 CONSTRAINT [PK_tb_AGV_ORDER] PRIMARY KEY CLUSTERED 
(
	[Oid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_Area]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Area](
	[Aid] [int] IDENTITY(1,1) NOT NULL,
	[AreaNo] [varchar](50) NOT NULL,
	[AreaName] [varchar](50) NULL,
	[RFIDs] [varchar](50) NULL,
	[Note] [varchar](50) NULL,
	[Reserve1] [varchar](50) NULL,
	[Reserve2] [varchar](50) NULL,
	[Reserve3] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[AreaNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_AutoDoor_INFO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_AutoDoor_INFO](
	[D_id] [int] IDENTITY(1,1) NOT NULL,
	[D_no] [varchar](50) NULL,
	[D_ip] [varchar](50) NOT NULL,
	[D_LineNo] [varchar](50) NULL,
	[D_In_RFID] [varchar](50) NULL,
	[D_Out_RFID] [varchar](50) NULL,
	[D_FW] [int] NULL,
	[D_X] [int] NULL,
	[D_Y] [int] NULL,
	[D_AC] [int] NULL,
	[D_AGV] [varchar](50) NULL,
	[D_OutIn] [int] NULL,
 CONSTRAINT [PK_tb_AutoDoor_INFO_1] PRIMARY KEY CLUSTERED 
(
	[D_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_BIN]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_BIN](
	[Bin_ID] [int] IDENTITY(1,1) NOT NULL,
	[Bin_No] [int] NULL,
	[Bin_IP] [varchar](50) NULL,
	[B_AP] [int] NULL,
	[B_CP] [int] NULL,
	[B_Leave] [int] NULL,
	[B_A1D] [int] NULL,
	[B_A2D] [int] NULL,
	[B_A3D] [int] NULL,
	[B_A4D] [int] NULL,
	[B_A1O] [int] NULL,
	[B_A2O] [int] NULL,
	[B_A3O] [int] NULL,
	[B_A4O] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_Buffer_temp]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Buffer_temp](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RFID] [varchar](50) NULL,
	[AGV_IP] [varchar](50) NULL,
	[Date] [varchar](50) NULL,
	[Reserve1] [varchar](50) NULL,
	[Reserve2] [varchar](50) NULL,
	[Reserve3] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_BufferInfo]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_BufferInfo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RFID] [varchar](50) NOT NULL,
	[Direction] [varchar](50) NULL,
	[Count] [int] NULL,
	[Date] [varchar](50) NULL,
	[Operation] [varchar](50) NULL,
	[AGVIP] [varchar](50) NULL,
	[Reserve2] [varchar](50) NULL,
	[Reserve3] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RFID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_CallBox]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_CallBox](
	[Sid] [int] IDENTITY(1,1) NOT NULL,
	[SCallBoxNo] [varchar](50) NOT NULL,
	[Sip] [varchar](50) NOT NULL,
	[SCount] [varchar](50) NULL,
	[Sx] [varchar](50) NULL,
	[Sy] [varchar](50) NULL,
	[SAc] [varchar](50) NULL,
	[SRFID] [varchar](50) NULL,
	[LINETYPE] [int] NULL,
 CONSTRAINT [PK_tb_CallBox] PRIMARY KEY CLUSTERED 
(
	[SCallBoxNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_CallBoxLogic]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_CallBoxLogic](
	[Lid] [int] IDENTITY(1,1) NOT NULL,
	[LCallBoxNo] [varchar](50) NOT NULL,
	[LAnJianNo] [varchar](50) NOT NULL,
	[LToAGV_IP] [varchar](50) NULL,
	[LIsDown] [varchar](50) NULL,
	[LTask] [varchar](50) NULL,
	[LINETYPE] [int] NULL,
 CONSTRAINT [PK_tb_CallBoxLogic] PRIMARY KEY CLUSTERED 
(
	[LCallBoxNo] ASC,
	[LAnJianNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_CNCIP_Line]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_CNCIP_Line](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cnc_ip] [varchar](50) NULL,
	[cnc_line] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_CNCLine_AGV]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_CNCLine_AGV](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cnc_line] [varchar](50) NULL,
	[agv_ip] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_CROSS_INFO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_CROSS_INFO](
	[Cid] [int] IDENTITY(1,1) NOT NULL,
	[Cno] [varchar](50) NULL,
	[Cinrfid] [varchar](50) NULL,
	[Cinfw] [int] NULL,
	[Coutrfid] [varchar](50) NULL,
	[Coutfw] [int] NULL,
	[Cac] [int] NULL,
 CONSTRAINT [PK_tb_CROSS_INFO] PRIMARY KEY CLUSTERED 
(
	[Cid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_ELC]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_ELC](
	[Sid] [int] IDENTITY(1,1) NOT NULL,
	[Snumber] [varchar](50) NULL,
	[Sip] [varchar](50) NOT NULL,
	[Sx] [int] NULL,
	[Sy] [int] NULL,
	[Sout] [int] NULL,
	[Srfid] [varchar](50) NULL,
	[Slinkac] [int] NULL,
	[Slouceng] [int] NULL,
	[ScanIn] [int] NULL,
	[Sac] [int] NULL,
	[SagvNo] [int] NULL,
	[obsturction] [int] NULL,
 CONSTRAINT [PK_tb_ELC] PRIMARY KEY CLUSTERED 
(
	[Sip] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_Elec_]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Elec_](
	[Lid] [int] IDENTITY(1,1) NOT NULL,
	[Lip] [varchar](50) NOT NULL,
	[Lname] [varchar](50) NULL,
	[LmainLineno] [varchar](50) NOT NULL,
	[Linrfid] [varchar](50) NULL,
	[Linlouceng] [int] NULL,
	[Linfow] [int] NULL,
	[Loutlouceng] [int] NULL,
	[Loutrfid] [varchar](50) NULL,
 CONSTRAINT [PK_tb_Elec_] PRIMARY KEY CLUSTERED 
(
	[LmainLineno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_Power_INFO]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Power_INFO](
	[Pid] [int] IDENTITY(1,1) NOT NULL,
	[PNo] [varchar](50) NULL,
	[P_IP] [varchar](50) NOT NULL,
	[P_LineNo] [varchar](50) NULL,
	[P_St_RFID] [varchar](50) NULL,
	[P_x] [int] NULL,
	[p_y] [int] NULL,
	[P_In_RFID] [varchar](50) NULL,
	[P_In_FW] [int] NULL,
	[P_Out_RFID] [varchar](50) NULL,
	[P_Out_FW] [int] NULL,
	[p_IN_LineNo] [varchar](50) NULL,
	[P_Power_H] [int] NULL,
	[P_power_L] [int] NULL,
	[P_Out_LineNo] [varchar](50) NULL,
	[P_AC] [int] NULL,
	[P_InOut] [int] NULL,
	[P_AGV_IP] [varchar](50) NULL,
	[LINETYPE] [int] NULL,
 CONSTRAINT [PK_tb_Power_INFO] PRIMARY KEY CLUSTERED 
(
	[P_IP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_Proj_Info]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Proj_Info](
	[Proj_name] [varchar](50) NULL,
	[Proj_no] [varchar](50) NULL,
	[Note] [varchar](50) NULL,
	[Reserve1] [varchar](50) NULL,
	[Reserve2] [varchar](50) NULL,
	[Reserve3] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_RFID_MAP]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_RFID_MAP](
	[TID] [int] IDENTITY(1,1) NOT NULL,
	[TAGVAULE] [varchar](50) NULL,
	[TX] [varchar](50) NULL,
	[TY] [varchar](50) NULL,
	[TTYPE] [int] NULL,
	[TFROM] [varchar](50) NULL,
	[TSF] [int] NULL,
	[TCROSS] [varchar](50) NULL,
	[TLINENO] [varchar](50) NULL,
	[LINETYPE] [int] NULL,
 CONSTRAINT [PK_tb_RFID_MAP] PRIMARY KEY CLUSTERED 
(
	[TID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_RFID_ResetAll]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_RFID_ResetAll](
	[RFID] [varchar](50) NULL,
	[Reserve1] [varchar](50) NULL,
	[Reserve2] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_Station_Info]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_Station_Info](
	[Sid] [int] IDENTITY(1,1) NOT NULL,
	[Sname] [varchar](50) NULL,
	[Swaitrfid] [varchar](50) NULL,
	[Srfid] [varchar](50) NULL,
	[Sac] [int] NULL,
	[Sinfw] [int] NULL,
	[SinLineNo] [varchar](50) NULL,
	[Srtime] [datetime] NULL,
	[Sftime] [datetime] NULL,
 CONSTRAINT [PK_tb_Station_Info] PRIMARY KEY CLUSTERED 
(
	[Sid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tb_TaskReset]    Script Date: 2019/1/15 10:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tb_TaskReset](
	[resetRFID] [varchar](50) NULL,
	[resetFW] [varchar](50) NULL,
	[resetAGV] [varchar](50) NULL,
	[resetIP] [varchar](50) NULL,
	[reserve1] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tb_AGV_INFO] ON 

INSERT [dbo].[tb_AGV_INFO] ([AGV_ID], [AGV_IP], [AGV_AC], [AGV_RFID_Now], [AGV_FROM], [AGV_TO], [AGV_LineNO], [AGV_Remark], [AGV_ErrorCord], [AGV_Power], [AGV_Speed], [AGV_FW], [AGV_LineString], [AGV_BoxState], [AGV_Task], [AGV_ElecString], [AGV_Heart], [AGV_ISACTIVE], [AGV_ISEMPTY], [AGV_ISPUSH], [AGV_ISCALLBOX], [LINETYPE]) VALUES (2, N'192.168.1.193', 1, N'20', N'', N'98', N'0', N'1', N'0', N'482', N'2', 1, N'1', N'0', 1, NULL, NULL, 1, 0, 0, 0, 1)
INSERT [dbo].[tb_AGV_INFO] ([AGV_ID], [AGV_IP], [AGV_AC], [AGV_RFID_Now], [AGV_FROM], [AGV_TO], [AGV_LineNO], [AGV_Remark], [AGV_ErrorCord], [AGV_Power], [AGV_Speed], [AGV_FW], [AGV_LineString], [AGV_BoxState], [AGV_Task], [AGV_ElecString], [AGV_Heart], [AGV_ISACTIVE], [AGV_ISEMPTY], [AGV_ISPUSH], [AGV_ISCALLBOX], [LINETYPE]) VALUES (1, N'192.168.1.194', -1, N'0', N'', N'', N'0', N'2', N'0', N'496', N'2', 1, N'18', N'0', 0, NULL, NULL, 0, 0, 0, 0, 1)
SET IDENTITY_INSERT [dbo].[tb_AGV_INFO] OFF
SET IDENTITY_INSERT [dbo].[tb_CallBox] ON 

INSERT [dbo].[tb_CallBox] ([Sid], [SCallBoxNo], [Sip], [SCount], [Sx], [Sy], [SAc], [SRFID], [LINETYPE]) VALUES (2, N'1', N'192.168.1.196', N'2', N'125', N'230', N'-1', N'22', 1)
INSERT [dbo].[tb_CallBox] ([Sid], [SCallBoxNo], [Sip], [SCount], [Sx], [Sy], [SAc], [SRFID], [LINETYPE]) VALUES (3, N'2', N'192.168.1.197', N'2', N'563', N'226', N'-1', N'21', 1)
INSERT [dbo].[tb_CallBox] ([Sid], [SCallBoxNo], [Sip], [SCount], [Sx], [Sy], [SAc], [SRFID], [LINETYPE]) VALUES (4, N'3', N'192.168.1.198', N'2', N'983', N'228', N'-1', N'20', 1)
SET IDENTITY_INSERT [dbo].[tb_CallBox] OFF
SET IDENTITY_INSERT [dbo].[tb_CallBoxLogic] ON 

INSERT [dbo].[tb_CallBoxLogic] ([Lid], [LCallBoxNo], [LAnJianNo], [LToAGV_IP], [LIsDown], [LTask], [LINETYPE]) VALUES (8, N'1', N'1', N'', N'0', N'', 1)
INSERT [dbo].[tb_CallBoxLogic] ([Lid], [LCallBoxNo], [LAnJianNo], [LToAGV_IP], [LIsDown], [LTask], [LINETYPE]) VALUES (9, N'1', N'2', N'', N'0', N'', 1)
INSERT [dbo].[tb_CallBoxLogic] ([Lid], [LCallBoxNo], [LAnJianNo], [LToAGV_IP], [LIsDown], [LTask], [LINETYPE]) VALUES (10, N'2', N'1', N'', N'0', N'', 1)
INSERT [dbo].[tb_CallBoxLogic] ([Lid], [LCallBoxNo], [LAnJianNo], [LToAGV_IP], [LIsDown], [LTask], [LINETYPE]) VALUES (11, N'2', N'2', N'', N'0', N'', 1)
INSERT [dbo].[tb_CallBoxLogic] ([Lid], [LCallBoxNo], [LAnJianNo], [LToAGV_IP], [LIsDown], [LTask], [LINETYPE]) VALUES (12, N'3', N'1', N'', N'0', N'', 1)
INSERT [dbo].[tb_CallBoxLogic] ([Lid], [LCallBoxNo], [LAnJianNo], [LToAGV_IP], [LIsDown], [LTask], [LINETYPE]) VALUES (13, N'3', N'2', N'', N'0', N'', 1)
SET IDENTITY_INSERT [dbo].[tb_CallBoxLogic] OFF
SET IDENTITY_INSERT [dbo].[tb_CNCIP_Line] ON 

INSERT [dbo].[tb_CNCIP_Line] ([id], [cnc_ip], [cnc_line]) VALUES (1, N'1', N'A1')
INSERT [dbo].[tb_CNCIP_Line] ([id], [cnc_ip], [cnc_line]) VALUES (2, N'2', N'A1')
INSERT [dbo].[tb_CNCIP_Line] ([id], [cnc_ip], [cnc_line]) VALUES (3, N'3', N'A1')
SET IDENTITY_INSERT [dbo].[tb_CNCIP_Line] OFF
SET IDENTITY_INSERT [dbo].[tb_CNCLine_AGV] ON 

INSERT [dbo].[tb_CNCLine_AGV] ([id], [cnc_line], [agv_ip]) VALUES (1, N'A1', N'10.0.42.32')
SET IDENTITY_INSERT [dbo].[tb_CNCLine_AGV] OFF
SET IDENTITY_INSERT [dbo].[tb_CROSS_INFO] ON 

INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (2, N'8', N'108', 1, N'33', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (3, N'8', N'109', 1, N'33', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (4, N'8', N'110', 1, N'33', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (5, N'2', N'39', 1, N'102', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (6, N'3', N'16', 1, N'111', 1, 5)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (7, N'3', N'16', 1, N'112', 1, 5)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (8, N'3', N'16', 1, N'113', 1, 5)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (9, N'3', N'16', 1, N'114', 1, 5)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (10, N'3', N'16', 1, N'115', 1, 5)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (11, N'4', N'103', 1, N'51', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (12, N'4', N'104', 1, N'51', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (13, N'4', N'118', 1, N'51', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (17, N'4', N'106', 1, N'51', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (20, N'4', N'107', 2, N'106', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (21, N'5', N'58', 1, N'59', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (22, N'5', N'63', 1, N'59', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (23, N'6', N'60', 1, N'105', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (24, N'6', N'60', 1, N'65', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (25, N'7', N'56', 1, N'107', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (26, N'7', N'122', 2, N'107', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (27, N'4', N'107', 2, N'103', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (28, N'4', N'107', 2, N'104', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (29, N'4', N'107', 2, N'118', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (30, N'4', N'107', 2, N'112', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (31, N'4', N'107', 2, N'113', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (32, N'4', N'107', 2, N'114', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (33, N'3', N'111', 2, N'15', 2, 5)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (34, N'3', N'112', 2, N'15', 2, 5)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (35, N'3', N'113', 2, N'15', 2, 5)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (36, N'3', N'114', 2, N'15', 2, 5)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (37, N'3', N'115', 2, N'15', 2, 5)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (38, N'2', N'101', 2, N'37', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (39, N'1', N'36', 2, N'85', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (40, N'1', N'86', 1, N'38', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (41, N'8', N'84', 2, N'110', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (42, N'8', N'84', 2, N'109', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (43, N'8', N'84', 2, N'108', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (44, N'9', N'121', 1, N'216', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (45, N'9', N'121', 1, N'216', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (46, N'9', N'121', 1, N'55', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (47, N'9', N'121', 1, N'57', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (48, N'10', N'116', 2, N'217', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (49, N'10', N'117', 2, N'217', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (50, N'7', N'56', 2, N'107', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (51, N'10', N'216', 1, N'116', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (52, N'10', N'216', 1, N'117', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (53, N'9', N'217', 2, N'55', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (54, N'9', N'121', 1, N'220', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (55, N'9', N'220', 2, N'70', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (56, N'9', N'70', 1, N'55', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (57, N'5', N'58', 1, N'71', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (58, N'5', N'71', 2, N'72', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (59, N'5', N'72', 1, N'59', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (60, N'3', N'16', 1, N'240', 1, 5)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (61, N'3', N'241', 2, N'111', 1, 5)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (62, N'11', N'234', 2, N'246', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (63, N'8', N'246', 1, N'33', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (64, N'11', N'237', 2, N'246', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (65, N'8', N'84', 2, N'247', 2, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (66, N'11', N'247', 2, N'234', 1, 0)
INSERT [dbo].[tb_CROSS_INFO] ([Cid], [Cno], [Cinrfid], [Cinfw], [Coutrfid], [Coutfw], [Cac]) VALUES (67, N'11', N'247', 2, N'237', 1, 0)
SET IDENTITY_INSERT [dbo].[tb_CROSS_INFO] OFF
SET IDENTITY_INSERT [dbo].[tb_ELC] ON 

INSERT [dbo].[tb_ELC] ([Sid], [Snumber], [Sip], [Sx], [Sy], [Sout], [Srfid], [Slinkac], [Slouceng], [ScanIn], [Sac], [SagvNo], [obsturction]) VALUES (1, N'8', N'192.168.1.41', 410, 373, 1, N'214', 1, 1, 0, -1, 0, 0)
INSERT [dbo].[tb_ELC] ([Sid], [Snumber], [Sip], [Sx], [Sy], [Sout], [Srfid], [Slinkac], [Slouceng], [ScanIn], [Sac], [SagvNo], [obsturction]) VALUES (3, N'5', N'192.168.1.42', 440, 398, 1, N'182', 1, 1, 0, -1, 0, 0)
INSERT [dbo].[tb_ELC] ([Sid], [Snumber], [Sip], [Sx], [Sy], [Sout], [Srfid], [Slinkac], [Slouceng], [ScanIn], [Sac], [SagvNo], [obsturction]) VALUES (4, N'6', N'192.168.1.43', 867, 5, 1, N'183', 1, 2, 0, -1, 0, 0)
INSERT [dbo].[tb_ELC] ([Sid], [Snumber], [Sip], [Sx], [Sy], [Sout], [Srfid], [Slinkac], [Slouceng], [ScanIn], [Sac], [SagvNo], [obsturction]) VALUES (5, N'7', N'192.168.1.44', 228, 761, 1, N'244', 1, 2, 0, -1, 0, 0)
SET IDENTITY_INSERT [dbo].[tb_ELC] OFF
SET IDENTITY_INSERT [dbo].[tb_Elec_] ON 

INSERT [dbo].[tb_Elec_] ([Lid], [Lip], [Lname], [LmainLineno], [Linrfid], [Linlouceng], [Linfow], [Loutlouceng], [Loutrfid]) VALUES (11, N'192.168.1.41', N'1->2', N'1', N'213', 1, 2, 2, N'215')
INSERT [dbo].[tb_Elec_] ([Lid], [Lip], [Lname], [LmainLineno], [Linrfid], [Linlouceng], [Linfow], [Loutlouceng], [Loutrfid]) VALUES (12, N'192.168.1.41', N'2->1', N'2', N'215', 2, 2, 1, N'213')
INSERT [dbo].[tb_Elec_] ([Lid], [Lip], [Lname], [LmainLineno], [Linrfid], [Linlouceng], [Linfow], [Loutlouceng], [Loutrfid]) VALUES (28, N'192.168.1.42', N'1->2', N'3', N'180', 1, 2, 2, N'184')
INSERT [dbo].[tb_Elec_] ([Lid], [Lip], [Lname], [LmainLineno], [Linrfid], [Linlouceng], [Linfow], [Loutlouceng], [Loutrfid]) VALUES (29, N'192.168.1.42', N'2->1', N'4', N'184', 2, 2, 1, N'180')
INSERT [dbo].[tb_Elec_] ([Lid], [Lip], [Lname], [LmainLineno], [Linrfid], [Linlouceng], [Linfow], [Loutlouceng], [Loutrfid]) VALUES (24, N'192.168.1.43', N'1->2', N'5', N'181', 1, 2, 2, N'185')
INSERT [dbo].[tb_Elec_] ([Lid], [Lip], [Lname], [LmainLineno], [Linrfid], [Linlouceng], [Linfow], [Loutlouceng], [Loutrfid]) VALUES (25, N'192.168.1.43', N'2->1', N'6', N'185', 2, 2, 1, N'181')
INSERT [dbo].[tb_Elec_] ([Lid], [Lip], [Lname], [LmainLineno], [Linrfid], [Linlouceng], [Linfow], [Loutlouceng], [Loutrfid]) VALUES (30, N'192.168.1.44', N'1->2', N'7', N'243', 1, 2, 2, N'245')
INSERT [dbo].[tb_Elec_] ([Lid], [Lip], [Lname], [LmainLineno], [Linrfid], [Linlouceng], [Linfow], [Loutlouceng], [Loutrfid]) VALUES (31, N'192.168.1.44', N'2->1', N'8', N'245', 2, 2, 1, N'243')
SET IDENTITY_INSERT [dbo].[tb_Elec_] OFF
SET IDENTITY_INSERT [dbo].[tb_Power_INFO] ON 

INSERT [dbo].[tb_Power_INFO] ([Pid], [PNo], [P_IP], [P_LineNo], [P_St_RFID], [P_x], [p_y], [P_In_RFID], [P_In_FW], [P_Out_RFID], [P_Out_FW], [p_IN_LineNo], [P_Power_H], [P_power_L], [P_Out_LineNo], [P_AC], [P_InOut], [P_AGV_IP], [LINETYPE]) VALUES (2, N'1', N'192.168.1.195', N'1', N'11', 294, 38, N'1', 1, N'1', 1, N'1', 580, 490, N'1', -1, 2, NULL, 1)
SET IDENTITY_INSERT [dbo].[tb_Power_INFO] OFF
INSERT [dbo].[tb_Proj_Info] ([Proj_name], [Proj_no], [Note], [Reserve1], [Reserve2], [Reserve3]) VALUES (N'', N'', N'', N'', N'', N'')
SET IDENTITY_INSERT [dbo].[tb_RFID_MAP] ON 

INSERT [dbo].[tb_RFID_MAP] ([TID], [TAGVAULE], [TX], [TY], [TTYPE], [TFROM], [TSF], [TCROSS], [TLINENO], [LINETYPE]) VALUES (1278, N'37', N'293', N'56', 2, N'', 0, N'', N'1', 1)
INSERT [dbo].[tb_RFID_MAP] ([TID], [TAGVAULE], [TX], [TY], [TTYPE], [TFROM], [TSF], [TCROSS], [TLINENO], [LINETYPE]) VALUES (1279, N'32', N'171', N'53', 2, N'', 0, N'', N'1', 1)
INSERT [dbo].[tb_RFID_MAP] ([TID], [TAGVAULE], [TX], [TY], [TTYPE], [TFROM], [TSF], [TCROSS], [TLINENO], [LINETYPE]) VALUES (1280, N'20', N'114', N'251', 2, N'', 0, N'', N'1', 1)
INSERT [dbo].[tb_RFID_MAP] ([TID], [TAGVAULE], [TX], [TY], [TTYPE], [TFROM], [TSF], [TCROSS], [TLINENO], [LINETYPE]) VALUES (1281, N'21', N'552', N'250', 2, N'', 0, N'', N'1', 1)
INSERT [dbo].[tb_RFID_MAP] ([TID], [TAGVAULE], [TX], [TY], [TTYPE], [TFROM], [TSF], [TCROSS], [TLINENO], [LINETYPE]) VALUES (1282, N'22', N'972', N'252', 2, N'', 0, N'', N'1', 1)
SET IDENTITY_INSERT [dbo].[tb_RFID_MAP] OFF
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'路线' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_AGV_INFO', @level2type=N'COLUMN',@level2name=N'AGV_LineNO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否正在使用0-未使用  1-使用中' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_AGV_INFO', @level2type=N'COLUMN',@level2name=N'AGV_ISACTIVE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'货架状态  0-无料 1-有料' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_AGV_INFO', @level2type=N'COLUMN',@level2name=N'AGV_ISEMPTY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'托盘推动督导员 0-未推出  1-推出' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_AGV_INFO', @level2type=N'COLUMN',@level2name=N'AGV_ISPUSH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否是呼叫盒调度   0-不是 1-是' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_AGV_INFO', @level2type=N'COLUMN',@level2name=N'AGV_ISCALLBOX'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产线编号(线别)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_AGV_INFO', @level2type=N'COLUMN',@level2name=N'LINETYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'线别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_CallBox', @level2type=N'COLUMN',@level2name=N'LINETYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'线别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_CallBoxLogic', @level2type=N'COLUMN',@level2name=N'LINETYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'线别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_Power_INFO', @level2type=N'COLUMN',@level2name=N'LINETYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'线别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tb_RFID_MAP', @level2type=N'COLUMN',@level2name=N'LINETYPE'
GO
USE [master]
GO
ALTER DATABASE [db_AGV_HSE] SET  READ_WRITE 
GO
