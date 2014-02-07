xquery version "1.0-ml";

module namespace ext = "http://marklogic.com/rest-api/resource/corba";

import module namespace corba = "http://marklogic.com/corba" at "/app/models/corba/corba.xqy";

(: implements generic CORBA operation handling :)

declare function ext:post(
    $context as map:map,
    $params  as map:map,
    $input   as document-node()*
) as document-node()*
{
    (xdmp:set-response-code(200, "OK"),xdmp:commit(),
      document { corba:service($input/corba:request) }
    )
};
