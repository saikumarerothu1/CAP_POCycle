namespace common;

type Address{
    Street: String(20);
    City:String(20);
    State:String(20);
    Country:String(20);
    PostalCode:String(6);
}

type contact{
    Person : String(20);
    Phone : String @assert.format :'^(?:\+91)?[0-9]{10}$';
    Email : String(50) @assert.format : '^((?!\.)[\w\-_.]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$';
}

type post_aspect{
    verifiedat : DateTime;
    verifiedby: String(5);
}

