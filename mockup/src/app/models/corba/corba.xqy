xquery version "1.0-ml";

module namespace corba = "http://marklogic.com/corba";

(: holds generic corba message helper code :)

(: SERVER FUNCTIONS :)

declare function corba:service($request as element(corba:request)) as element(corba:response) {
  (: TODO Introspect request and invoke relevant XQuery module :)
  let $module := $request/corba:headers/corba:module/text()
  let $interface := $request/corba:headers/corba:interface/text()
  let $operation := $request/corba:headers/corba:operation/text()
  let $operationType := $request/corba:headers/corba:operationType/text() (: blank normally (requires response) but can be oneway(fire and forget) :)
  let $ns := fn:concat('http://marklogic.com/corba/',$module,'/',$interface) (: TODO check for invalid characters in function names in XQuery :)
  let $m := fn:concat('/app/models/corba/',$module,'/',$interface,'.xqy') (: TODO check for invalid characters in function names in XQuery :)
  let $code := fn:concat('xquery version "1.0-ml"; 
import module namespace corba = "http://marklogic.com/corba" at "/app/models/corba/corba.xqy";
module namespace mod = "',$ns,'" at "',$m,'";
declare variable $request as element(corba:request) external;
mod:',$operation,'($request)')
  return
    if ("oneway" = $operationType) then
      (: invoke async :)
      xdmp:spawn(
          $code,(fn:QName($ns,"request"),$request),
          <options xmlns="xdmp:eval">
            <isolation>different-transaction</isolation>
            <prevent-deadlocks>true</prevent-deadlocks>
          </options>
        )
    else
      xdmp:eval(
          $code,(fn:QName($ns,"request"),$request),
          <options xmlns="xdmp:eval">
          </options>
        )
};








(: CLIENT FUNCTIONS :)

(: TODO :)








(: RESPONSE WRAPPER HELPERS :)
declare function corba:success($responseData?) as element(corba:response) {
    <corba:response>
      <corba:headers>
        <corba:result>SUCCESS</corba:result>
      </corba:headers>
      <corba:data>
        {$responseData}
      </corba:data>
    </corba:response>
};