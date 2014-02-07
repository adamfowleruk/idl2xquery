xquery version "1.0-ml";

module namespace m = "http://marklogic.com/corba/service/bank/BankAccount";

import module namespace corba = "http://marklogic.com/corba" at "/app/models/corba/corba.xqy";
declare namespace modulens = "http://marklogic.com/corba/service/bank";

(: See samples/cics-bank.idl :)
(:
exception ACCOUNT_ERROR { long errcode; string message;};
 
    // query methods
    long querybalance(in long acnum) raises (ACCOUNT_ERROR);
    string queryname(in long acnum) raises (ACCOUNT_ERROR);
    string queryaddress(in long acnum) raises (ACCOUNT_ERROR);
 
    // setter methods
    void setbalance(in long acnum, in long balance) raises (ACCOUNT_ERROR);
    void setaddress(in long acnum, in string address) raises (ACCOUNT_ERROR);
 
    // credit check
    string creditcheck(in long acnum) raises (ACCOUNT_ERROR);
 
    // create a new account
    void initialise(in long acnum, in long balance, in string name, \
                              in string address) 
      raises (ACCOUNT_ERROR);
 
    // create a new account using a structure for the input
    void initialise2(in bank::BankData allofit) raises (ACCOUNT_ERROR);
 
    // get all data back in a single structure
    bank::BankData getalldata(in long acnum) raises (ACCOUNT_ERROR);
:)

declare function m:querybalance($request as element(corba:request)) as element(corba:response) {
  let $data := $request/corba:data/m:querybalanceRequest (: acnum (long element):)
  let $acnum := $data/m:acnum/text()
  return
    corba:success(12345)
};

declare function m:queryname($request as element(corba:request)) as element(corba:response) {
  let $data := $request/corba:data/m:querynameRequest (: acnum (long element):)
  let $acnum := $data/m:acnum/text()
  return
    corba:success("Adam Fowler")
};


declare function m:queryaddress($request as element(corba:request)) as element(corba:response) {
  let $data := $request/corba:data/m:querynameRequest (: acnum (long element):)
  let $acnum := $data/m:acnum/text()
  return
    corba:success("My address")
};

declare function m:initialise2($request as element(corba:request)) as element(corba:response) {
  let $data := $request/corba:data/m:initialise2Request (: in bank::BankData allofit :)
  let $bankdata := $data/m:BankData/text()
  (:
  struct BankData {
    long acnum;
    string custname;
    string custaddr;
    long balance;
  };
  :)
  let $acnum := xs:long($bankdata/modulens:acnum)
  let $custname := $bankdata/modulens:custname/text()
  let $custaddr := $bankdata/modulens:custaddr/text()
  let $balance := xs:long($bankdata/modulens:balance)
  return
    corba:success()
};

(: TODO other methods as per IDL file :)
