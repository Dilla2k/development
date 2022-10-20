import mysql.connector
from mysql.connector import errorcode
import threading
from escpos.printer import Usb
from decimal import Decimal

config = {
    'user': 'barbossa',
    'password': 'barbossa',
    'host': '192.168.23.49',
    'database': 'barbossa'
}

orderId=None

class Order:
    def __init__(self, id, table, status, price, printed, orderTime, count):
        self.id = id
        self.table = table
        self.status = status
        self.price = price
        self.printed = printed
        self.orderTime = orderTime
        self.count = count


class OrderItem:
    def __init__(self, id, orderId, itemName, price, additionalIndigrends, count, printed, countPrinted):
        self.id = id
        self.orderId = orderId
        self.itemName = itemName
        self.price = price
        self.additionalIndigrends = additionalIndigrends
        self.count = count
        self.printed = printed
        self.countPrinted = countPrinted

def takeItemName(elem):
    return elem[2]

def printPOSOverview(cnx, printer):
    try:
        orderOverviewItemList = []
        cur = cnx.cursor()
        cur.execute("SELECT * FROM orderitems;")
        result = cur.fetchall()
        for item in result:
            if "extra" in item[4]:
                itemName = item[2]+" "+item[4]
                orderItem = OrderItem(item[0],item[1],itemName,item[3],item[4],item[5],item[6],item[7])
            else:    
                orderItem = OrderItem(item[0],item[1],item[2],item[3],item[4],item[5],item[6],item[7])
            orderOverviewItemList.append(orderItem)
            
        tempList=[]
        for item in orderOverviewItemList:
            tempItem = item;
            for compareItem in orderOverviewItemList:
                if item.itemName == compareItem.itemName:
                    if item.id != compareItem.id:
                        tempItem.count = int(item.count) + int(compareItem.count)
            if not any(x.itemName == tempItem.itemName for x in tempList):
               tempList.append(tempItem)
        cur = cnx.cursor()
        cur.execute("DELETE FROM orders;")
        cnx.commit()
        cur = cnx.cursor()
        cur.execute("DELETE FROM orderitems;")
        cnx.commit()
        for item in tempList:
            printer.set(align="left")
            printer.text("{}x ".format(item.count))
            printer.text("{}\n".format(item.itemName))
        printer.cut()    
        
        
    except Exception as e:
        print("error: "+str(e))    

def printPOS(cnx, order, printer, printer2):
    try:
        orderItemList = []
        shishaItemList = []
        cur = cnx.cursor()
        if order.status==1:
            cur.execute("SELECT * FROM orderitems WHERE orderId='"+order.id+"' AND printed=0;")
        else:
            cur.execute("SELECT * FROM orderitems WHERE orderId='"+order.id+"';")    
        result = cur.fetchall()
        for item in result:
            orderItem = OrderItem(item[0],item[1],item[2],item[3],item[4],item[5],item[6],item[7])
            orderItemList.append(orderItem)
        cur = cnx.cursor()
        cur.execute("SELECT * FROM orderitems WHERE orderId='"+order.id+"' AND itemName LIKE '%Shisha%' AND printed=0;")
        result = cur.fetchall()
        for item in result:
            orderItem = OrderItem(item[0],item[1],item[2],item[3],item[4],item[5],item[6])
            shishaItemList.append(orderItem)
        
        orderTime = order.orderTime[:-4]

        printer.set(align="center", height=2)
        if order.status==0:
            printer.text("--Bestellung Tisch {}--\n\n".format(order.table))
        else:
            printer.text("--Abschluss Tisch {}--\n\n".format(order.table))    
        printer.text("{}\n\n".format(orderTime))
        for item in orderItemList:
            itemPrice= Decimal(item.price)* Decimal(item.count)
            itemCount= int(item.count)- int(item.countPrinted)
            printer.set(align="left")
            printer.text("{}x ".format(itemCount))
            #printer.set(align="center")
            printer.text("{}\n".format(item.itemName))
            
            if item.additionalIndigrends!="":
                indigrends = ""
                if "Shisha" in item.itemName:
                    indigrends = item.additionalIndigrends
                else:
                    indigrends = item.additionalIndigrends[:-5]
                #printer.set(align="center")
                printer.text("{}\n".format(indigrends))    
            printer.set(align="right")
            printer.text("{} EUR\n".format(itemPrice))
            cur = cnx.cursor()
            cur.execute("UPDATE orderitems SET printed=1, countPrinted='" +item.count+"' where id ='" +item.id+"';")
            cnx.commit()
        printer.text("\n")
        printer.set(align="right",height=2)
        printer.text("GESAMT   ")
        printer.text("{} EUR".format(order.price))
        printer.cut()
        if len(shishaItemList)>0:
            if order.status==0:
                printer2.text("--Bestellung Tisch {}--\n\n".format(order.table))
                printer2.text("{}\n\n".format(orderTime))
                for item in shishaItemList:
                    itemCount= int(item.count)- int(item.countPrinted)
                    printer2.set(align="left")
                    printer2.text("{}x ".format(itemCount))
                    #printer2.set(align="center")
                    printer2.text("{}\n".format(item.itemName))
                    if item.additionalIndigrends!="":
                        indigrends = item.additionalIndigrends
                        #printer2.set(align="center")
                        printer2.text("{}\n".format(indigrends))
                    printer2.text("\n\n")
                    cur = cnx.cursor()
                    cur.execute("UPDATE orderitems SET printed=1, countPrinted='" +item.count+"' where id ='" +item.id+"';")
                    cnx.commit()
    except Exception as e:
        print("error: "+str(e))
    
def getOrders():
  cnx = cur = None
  try:
    cnx = mysql.connector.connect(**config)
  except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print('Something is wrong with your user name or password')
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("Database does not exist")
    else:
        print(err)
  else:
    try:
        printer = Usb(0x0483, 0x5743,0,in_ep=0x81, out_ep=0x01)
        printer.charcode("EURO")
        
        printer2 = Usb(0x0456, 0x0808,0,in_ep=0x81, out_ep=0x03)
        printer2.charcode("EURO")
        
        cur = cnx.cursor()
        cur.execute("SELECT * FROM orders WHERE printed=0 ORDER BY orderTime DESC LIMIT 5;")
        result = cur.fetchall()
        if(len(result)>0):
            for item in result:
                order = Order(item[0],item[1],item[2],item[3],item[4],item[5],item[6])    
                cur = cnx.cursor()
                cur.execute("UPDATE orders SET printed=1 where id ='" +order.id+"';")
                cnx.commit()
                if order.table=="100":
                    printPOSOverview(cnx, printer)
                else:
                    printPOS(cnx, order, printer, printer2)
    except Exception as e:
        print("error: "+str(e))
    finally:
        if cur:
            cur.close()
        if cnx:
            cnx.close()

WAIT_TIME_SECONDS = 10

ticker = threading.Event()
while not ticker.wait(WAIT_TIME_SECONDS):
    getOrders()