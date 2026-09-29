# CAP Mock Service (`exercises/ex1/apps/cap-mock`)

A minimal [SAP CAP](https://cap.cloud.sap/) project that exposes a small **OData V4** catalog
service. It backs **Exercise 1** of the AD266 workshop so the SAPUI5 application you build has a reliable,
offline data source — no external system required.

## What it exposes

`CatalogService` at **`/odata/v4/catalog`** with two read-only entity sets:

| Entity set  | Key   | Notable fields                                             |
|-------------|-------|-----------------------------------------------------------|
| `Products`  | `ID`  | `name`, `description`, `category`, `price`, `currency`, `stock`, `supplier` |
| `Suppliers` | `ID`  | `name`, `country`, `products` (to-many)                   |

Seed data lives in `db/data/*.csv` (8 products, 3 suppliers).

## Run it

From this directory:

```bash
npm install
nm run watch
```

The service starts at **`http://localhost:4004`**. Useful URLs:

- Service document: `http://localhost:4004/odata/v4/catalog/`
- Products: `http://localhost:4004/odata/v4/catalog/Products`
- Metadata: `http://localhost:4004/odata/v4/catalog/$metadata`

Inspect the services and endpoints without starting the server:

```bash
npx cds compile '*' --to serviceinfo
```

## Use it from the SAPUI5 application (Exercise 1)

When scaffolding the application with the support of the UI5 MCP server, provide:

- **OData V4 service URL:** `http://localhost:4004/odata/v4/catalog/`
- **Entity set:** `Products`

> The workshop keeps this CAP project and the SAPUI5 application separate for clarity. If you prefer the
> single-origin CAP setup (SAPUI5 application served by `cds watch` under `app/`), follow the [CAP UI5 integration](https://github.com/ui5-community/ui5-ecosystem-showcase/tree/main/packages/cds-plugin-ui5#cds-plugin-ui5)

