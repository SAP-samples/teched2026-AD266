# Exercise 1 — Create & enhance a new SAPUI5 applicationin JavaScript (40 min)

[← Previous: Getting Started](../ex0/README.md) | [Back to Overview](../../README.md) | [Next: Exercise 2 — Convert to TypeScript →](../ex2/README.md)

In this exercise you use Claude Code to **scaffold** a new SAPUI5 application (JavaScript) and then
**enhance** it: wire it to an OData V4 service, render an entity set in a table, add a detail form,
and add translatable texts with formatting logic. Throughout, Claude Code consults the SAPUI5 API reference and the
best-practice guidelines — you learn to *drive* it and to *review* what it produces.

The backend is the CAP mock service in [`exercises/ex1/apps/cap-mock`](apps/cap-mock/README.md).

## 1.1 Start the mock OData service

Download the CAP mock service [cap-mock.zip](https://github.com/SAP-samples/teched2026-AD266/raw/main/exercises/ex1/apps/cap-mock.zip). Create a folder called `apps` on your Desktop, save the zip there. Then open a **new terminal** and run:

```bash
cd ~/Desktop/apps
tar -xf cap-mock.zip
cd cap-mock
npm install
npm run watch
```

The service boots, deploys the seed data to an in-memory database, and serves `CatalogService`:

![Terminal showing cds watch startup and a curl of the live Products data](images/01_00_cds-watch.png)

It serves at `http://localhost:4004`. The CAP welcome page lists the `CatalogService` with its
`Products` and `Suppliers` endpoints:

![CAP welcome page listing the CatalogService endpoints](images/01_01_cap-welcome.png)

Confirm the products endpoint returns data — open
`http://localhost:4004/odata/v4/catalog/Products` (tick **Pretty-print** in the browser):

![Products OData endpoint returning the seeded product data as JSON](images/01_02_products-odata.png)

This is the data your SAPUI5 application will bind to in the steps below.

## 1.2 Scaffold the app

Back in your Claude Code session navigate to the `~/Desktop/apps` folder:

> [!TIP]
> 💡 **Task:** Ask Claude Code to scaffold the application:
> ```
> Create a new SAPUI5 application in JavaScript with namespace `ad266.products` next to the `cap-mock` project.
> Wire it to the OData V4 service at `http://localhost:4004/odata/v4/catalog/` and the `Products` entity set.
> Leverage the ui5-cds-plugin (https://github.com/ui5-community/ui5-ecosystem-showcase/tree/main/packages/cds-plugin-ui5).
> ```

Inspect the generated project. Notice the modern defaults the tool applies:

- `webapp/index.html` bootstraps via `ComponentSupport` (no inline script).
- `webapp/manifest.json` declares the OData V4 data source and model.
- `webapp/Component.js`, a view, and a controller wired with `sap.ui.define`.

> [!TIP]
> 💡 **Task:** Run the app locally to see the scaffold:
> ```
> Start the SAPUI5 application.
> ```
> Open the full path (e.g. `http://localhost:4004/ad266.products/index.html`) — the dev server does not serve a
> default index.

## 1.3 Render the products in a table

> [!TIP]
> 💡 **Task:** Ask Claude Code:
> ```
> In the main view, show the `Products` entity set in a `sap.m.Table` with columns for name,
> category, price (formatted as currency) and stock. Use data binding, and load the best-practice
> table guidelines first.
> ```

Things to check as it works:

- It calls the `get_api_reference` tool of the UI5 MCP server for `sap.m.Table` / `sap.m.Column` and consults the table best-practice rules.
- The `price` column uses a built-in OData type (`sap.ui.model.odata.type.Currency` or
  `Decimal` with `formatOptions`) rather than a hand-rolled formatter.
- The binding path targets the `Products` set from the OData V4 model.

## 1.4 Add a detail form

> [!TIP]
> 💡 **Task:** Ask Claude Code:
> ```
> When a table row is selected, navigate to a details screen and show the product's details in a form: name,
> description, category, price and stock. Follow the SAPUI5 form guidelines.
> ```

Review against the guidelines: it must use `sap.ui.layout.form.Form` with a
`sap.ui.layout.form.ColumnLayout` (**never** `SimpleForm` unless you ask for it), defaulting to
2 columns on M-size.

## 1.5 Leverage translatable texts and a formatter

> [!TIP]
> 💡 **Task:** Ask Claude Code:
> ```
> Move the column headers and labels into the i18n resource bundle, and add a formatter that
> shows 'Low stock' when stock is below 50. Apply CSP-safe async module loading and keep all locale
> files in sync.
> ```

Confirm:

- New keys are added to **every** `i18n*.properties` file, not just the default bundle.
- The formatter is loaded via `sap.ui.define` (JS) and referenced from the view via `core:require`
  — no globals, no inline script.


## 1.6 Offer support for an additional language

> [!TIP]
> 💡 **Task:** Ask Claude Code:
> ```
> Add Spanish as a supported language. Translate all existing i18n keys into Spanish, register `es`
> as a supported locale in the manifest, and make sure the app still works for users who don't speak Spanish.
> ```

SAPUI5's resource bundle resolves locale files by matching the browser language against the `supportedLocales` you declare. A Spanish-speaking user gets `i18n_es.properties`; everyone else falls back to the default `i18n.properties`. Claude Code should derive the correct file name, locale code, and manifest structure from the SAPUI5 best-practice guidelines.

Confirm:
- `webapp/i18n/i18n_es.properties` is present and contains a Spanish translation for **every** key defined in `i18n.properties` — not just the keys added in this step.
- `manifest.json` → `sap.ui5/models/i18n` declares:
  - `"supportedLocales": ["en", "es", ""]` — the empty string `""` registers the default bundle.
  - `"fallbackLocale": ""` — ensures users with unsupported locales still see the default text.
- Appending `?sap-language=es` to the URL loads the Spanish texts in the running app.

## Discussion

Talk through, as a group:

- What did Claude Code get **right because it was grounded** — correct control APIs, the OData type
  instead of a custom formatter, `Form` + `ColumnLayout`, i18n across locales, CSP-safe loading?
- What still needs **human judgment** — column choice, UX layout, business meaning of "low stock",
  naming?

## Verify

- [ ] The app runs locally and shows products from the mock service.
- [ ] Selecting a row populates the detail form.
- [ ] The UI5 linter is clean on the new code:
      *Run the UI5 linter on the app and report the findings.* (you can see the `run_ui5_linter` tool call in its output).
- [ ] `manifest.json` is valid. (you can see the`run_manifest_validation` tool call in its output).

## Summary

You scaffolded and enhanced a real SAPUI5 application by driving a grounded agent, and you verified the
result with UI5 linter. In Exercise 2 you'll convert this JavaScript app to TypeScript.

---

[← Previous: Getting Started](../ex0/README.md) | [Back to Overview](../../README.md) | [Next: Exercise 2 — Convert to TypeScript →](../ex2/README.md)
