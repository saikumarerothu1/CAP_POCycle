using MasterService as service from '../../srv/service';
annotate service.Vendors with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : VendorCode,
            },
            {
                $Type : 'UI.DataField',
                Value : VendorName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Address_Street',
                Value : Address_Street,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Address_City',
                Value : Address_City,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Address_State',
                Value : Address_State,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Address_Country',
                Value : Address_Country,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Address_PostalCode',
                Value : Address_PostalCode,
            },
            {
                $Type : 'UI.DataField',
                Value : TaxId,
            },
            {
                $Type : 'UI.DataField',
                Label : 'contact_Person',
                Value : contact_Person,
            },
            {
                $Type : 'UI.DataField',
                Label : 'contact_Phone',
                Value : contact_Phone,
            },
            {
                $Type : 'UI.DataField',
                Label : 'contact_Email',
                Value : contact_Email,
            },
            {
                $Type : 'UI.DataField',
                Value : PaymentTerms,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Flag',
                Value : Flag,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : VendorCode,
        },
        {
            $Type : 'UI.DataField',
            Value : VendorName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Address_Street',
            Value : Address_Street,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Address_City',
            Value : Address_City,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Address_State',
            Value : Address_State,
        },
    ],
);

