# R�� Oacle ����
install.packages("DBI");
library(DBI)
install.packages("RJDBC");
library(RJDBC)

drv <- JDBC("oracle.jdbc.driver.OracleDriver","C:/Users/ChanWoo/Documents/R/2019_02_02 [ bike ]/ojdbc6.jar")
conn <- dbConnect(drv,"jdbc:oracle:thin:@localhost:1521:xe","javatest","javatest")
conn
result1<-dbReadTable(conn,"VISITOR") 
# DB���� table���� dataframe���� �������� - ���̺��� �빮��!

# ���̺��� ������ �����ϱ�
# ��� 1
dbWriteTable(conn,"book1",data.frame(bookname=c("�ڹ��� ����","�ϵ� �Ϻ� �Թ�","�̰��� ��������"),
                                     price=c(30000,25000,32000)))
dbWriteTable(conn,"cars",head(cars,3))
# ��� 2
dbSendUpdate(conn, "INSERT INTO VISITOR VALUES 
             ('R���', sysdate, 'R���� �����͸� �Է��ؿ�', visitor_seq.nextval)")
dbSendUpdate (conn, "INSERT INTO VISITOR VALUES 
              ('�ϵ�', sysdate, '��뷮 ������ �л�����&ó�����', visitor_seq.nextval)")


# ������ ����
dbSendUpdate(conn,"INSERT INTO cars(speed, dist) VALUES(1,1)")
dbSendUpdate(conn,"INSERT INTO cars(speed, dist) VALUES(2,2)")
dbReadTable(conn,"CARS")
dbSendUpdate(conn,"UPDATE CARS SET DIST =DIST*100 WHERE SPEED =1")
dbReadTable(conn,"CARS")
dbSendUpdate(conn,"UPDATE CARS SET DIST =DIST*3 WHERE SPEED =1")
dbReadTable(conn,"CARS")

# ���̺� ����
dbRemoveTable(conn,"CARS")

#######################�پ��� DB ���� ������##################################
# ���� 1
df <- read.table("C:/Users/ChanWoo/Documents/R/2019_02_02 [ bike ]/product_click.log",stringsAsFactors = F)
names(df) <-c("click_time","pid")
str(df)

df$click_time <- as.character(df$click_time)
dbWriteTable(conn,"productlog",df)
result4 <-dbReadTable(conn,"PRODUCTLOG")
# ���� 2
dbWriteTable(conn,"mtcars",mtcars)
rs <- dbSendQuery(conn,"SELECT*FROM mtcars WHERE cyl=4")
dbFetch(rs)
dbClearResult(rs)

rs <- dbSendQuery(conn,"SELECT*FROM mtcars")
ret1<- dbFetch(rs,10)
ret2<- dbFetch(rs)
dbClearResult(rs)

nrow(ret1)
nrow(ret2)
