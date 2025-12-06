namespace common;

type Address{
    Street: String(20);
    City:String(20);
    State:String(20);
    Country:String(20);
    PostalCode:Integer;
}

type contact{
    Person : String(20);
    Phone : String @assert.format :'^\\+?[0-9\\s()-]{7,15}$';
    Email : String(50) @assert.format : '^((?!\.)[\w\-_.]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$';
}

type post_aspect{
    verifiedat : DateTime;
    verifiedby: String(5);
}

