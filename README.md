# Yaus
## Yet Another Url Shortener

This app helps you to shorten URLs and manage this URLs under your own account. URLs are hashed using non-cryptographic hash lib Murmur. Passwords stored using bcrypt.

To start this app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## TODO
  * Make code self-documented
  * Add url sanity check
  * Add email registation
  * Refactoring
  * Docs, docs, docs...
