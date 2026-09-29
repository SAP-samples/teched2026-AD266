namespace ad266.workshop;

using { managed, cuid } from '@sap/cds/common';

/**
 * A supplier that provides products.
 */
entity Suppliers : cuid, managed {
  name    : String(100) @title: 'Supplier';
  country : String(3)   @title: 'Country';
  products : Association to many Products
               on products.supplier = $self;
}

/**
 * A product shown in the Exercise 1 table and detail form.
 */
entity Products : cuid, managed {
  name        : String(100) @title: 'Product Name';
  description : String(500) @title: 'Description';
  category    : String(40)  @title: 'Category';
  price       : Decimal(10, 2) @title: 'Price';
  currency    : String(3)   @title: 'Currency';
  stock       : Integer     @title: 'In Stock';
  supplier    : Association to Suppliers @title: 'Supplier';
}
