import ballerina/io;
import app1.utils;
import ballerinax/mysql;
import ballerina/sql;

type Customer record {|
    string name;
    string address;
|};

public function main() returns error? {
    io:println("Hello, World!");

    string hello = utils:hello("xu ren");
    io:println(hello);

    mysql:Client dbClient = check new ("localhost", "root", "root", "testing");

    sql:ParameterizedQuery q = `select * from customers`;

    stream<Customer, sql:Error?> getCusts = dbClient->query(q);

    check from Customer cust in getCusts
    do {
        io:println(cust);
    };
}
