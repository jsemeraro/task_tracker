defmodule TaskTrackerWeb.Router do
  use TaskTrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :get_current_user
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end
  
  # copied from Nat's lecture notes
  def get_current_user(conn, _params) do
    # TODO: Move this function out of the router module.
    user_id = get_session(conn, :user_id)
    user = TaskTracker.Accounts.get_user(user_id || -1)
    assign(conn, :current_user, user)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TaskTrackerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/users", UserController

    resources "/tasks", TaskController
    get "/teamtasks", TaskController, :show_ndrlng

    resources "/managers", ManagerController
    
    post "/session", SessionController, :create
    delete "/session", SessionController, :delete
  end
  
  
  # Other scopes may use custom stacks.
  scope "/api/v1", TaskTrackerWeb do
    pipe_through :api
    resources "/time_blocks", TimeBlockController, except: [:new]
    patch "/time_blocks/:id", TimeBlockController, :update
    patch "/time_blocks/:id/edit", TimeBlockController, :edit
  end
end
