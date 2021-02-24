import sqlite3
import csv # Use this to read the csv file


def create_connection(db_file):
    """ create a database connection to the SQLite database
        specified by the db_file

    Parameters
    ----------
    Connection
    """
    pass


def update_employee_salaries(conn, increase):
    """

    Parameters
    ----------
    conn: Connection
    increase: float
    """
    pass



def get_employee_total_salary(conn):
    """
    Parameters
    ----------
    conn: Connection

    Returns
    -------
    int
    """
    pass


def get_total_projects_budget(conn):
    """
    Parameters
    ----------
    conn: Connection

    Returns
    -------
    float
    """
    pass


def calculate_income_from_parking(conn, year):
    """
    Parameters
    ----------
    conn: Connection
    year: str

    Returns
    -------
    float
    """
    pass


def get_most_profitable_parking_areas(conn):
    """
    Parameters
    ----------
    conn: Connection

    Returns
    -------
    list[tuple]

    """
    pass


def get_number_of_distinct_cars_by_area(conn):
    """
    Parameters
    ----------
    conn: Connection

    Returns
    -------
    list[tuple]

    """
    pass


def add_employee(conn, eid, firstname, lastname, birthdate, street_name, number, door, city):
    """
    Parameters
    ----------
    conn: Connection
    eid: int
    firstname: str
    lastname: str
    birthdate: datetime
    street_name: str
    number: int
    door: int
    city: str
    """
    pass

def load_neighborhoods(conn, csv_path):
    """

    Parameters
    ----------
    conn: Connection
    csv_path: str
    """
    pass