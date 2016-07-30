defmodule Yaus.Router do
  use Yaus.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Yaus do
    pipe_through :browser # Use the default browser stack

    get "/", MainPageController, :index
    resources "/register", UserController, only: [:new, :create]
    resources "/short", ShortenerController, only: [:create, :index]
    get "/login", SessionController, :index
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout
    get "/edit/:link_id", LinkController, :edit
    get "/delete/:link_id", LinkController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", Yaus do
  #   pipe_through :api
  # end
end
