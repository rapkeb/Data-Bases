import sqlite3
import csv  # Use this to read the csv file


def create_connection(db_file):
    con = sqlite3.connect(db_file)
    return con


def update_employee_salaries(conn, increase):
    cur = conn.cursor()
    cur.execute("""Select Employee.EID,ConstructorEmployee.SalaryPerDay
                    From Employee Join ConstructorEmployee On Employee.EID=ConstructorEmployee.EID
                    Where ((julianday('now') - julianday(Employee.BirthDate))/365) >= 50""")
    conn.commit()
    result = cur.fetchall()
    for row in result:
        idd = row[0]
        oldSalary = row[1]
        newSalary = oldSalary+((oldSalary*increase)/100)
        cur.execute("Update ConstructorEmployee SET SalaryPerDay=? Where ConstructorEmployee.Eid=?", (newSalary, idd))
    conn.commit()


def get_employee_total_salary(conn):
    cur = conn.cursor()
    cur.execute("Select sum(SalaryPerDay) From ConstructorEmployee")
    conn.commit()
    result = cur.fetchall()
    return result[0]


def get_total_projects_budget(conn):
    print("ggg")


def calculate_income_from_parking(conn, year):
    print("gg")

def get_most_profitable_parking_areas(conn):
    print("gg")


def get_number_of_distinct_cars_by_area(conn):
    cur=conn.cursor()
    cur.execute("""Select AID,Count(CID) FROM
                (
                    SELECT DISTINCT CID,AID FROM CarParking
                )
                Group By AID 
                Order BY count(CID) DESC""")
    conn.commit()
    result = []
    result = cur.fetchall()
    return result


def add_employee(conn, eid, firstname, lastname, birthdate, street_name, number, door, city):
    cur = conn.cursor()
    cur.execute("""insert Into Employee (EID,FirstName,LastName,BirthDate,StreetName,Number,Door,City) Values (?,?,?,?,?,?,?,?)""",(eid,firstname,lastname,birthdate,street_name,number,door,city))
    conn.commit()


def load_neighborhoods(conn, csv_path):
    cur = conn.cursor()
    with open(csv_path) as csv_file:
        csv_reader = csv.reader(csv_file, delimiter='\n')
        for row in csv_reader:
            values = row[0].split(",")
            cur.execute("INSERT INTO Neighborhood (NID, Name) VALUES (?,?)", (values[0], values[1]))
        conn.commit()