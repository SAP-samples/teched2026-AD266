using { ad266.workshop as db } from '../db/schema';

/**
 * OData V4 service backing Exercise 1.
 * Served by `cds watch` at http://localhost:4004/odata/v4/catalog/
 */
service CatalogService @(path: '/odata/v4/catalog') {

  @readonly
  entity Products as projection on db.Products;

  @readonly
  entity Suppliers as projection on db.Suppliers;
}
