xquery version "1.0-ml";

module namespace Hello = "http://marklogic.com/corba/service/HelloApp/Hello";

import module namespace corba = "http://marklogic.com/corba" at "/app/models/corba/corba.xqy";

(: File to handle the Hello interface's operations :)

declare function Hello:sayHello($request as element(corba:request)) as element(corba:response) {
  (: TODO IMPLEMENT YOUR FUNCTION HERE :)
  let $data := $request/corba:data/Hello:sayHelloRequest (: empty node :)
  return
    <corba:response>
      <corba:headers>
        <corba:result>SUCCESS</corba:result>
      </corba:headers>
      <corba:data>
        <Hello:sayHelloResponse>Hello</Hello:sayHelloResponse> <!-- could replace with corba:success("Hello") helper call -->
      </corba:data>
    </corba:response>
};

(: This is a fire and forget, so no response given - handled by calling code :)
declare function Hello:shutdown($request as element(corba:request)) {
  (: TODO IMPLEMENT YOUR FUNCTION HERE :)
  let $data := $request/corba:data/Hello:shutdownRequest (: empty node :)
  return
    ()
};
