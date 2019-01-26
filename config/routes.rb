Rails.application.routes.draw do
  get '/', to: 'application#route_not_found'

  constraints(format: :json) do
    post 'login', to: 'login#login'

    scope :users do
      post 'sign_up', to: 'users#create', as: 'create_new_user'
      get '', to: 'users#show', as: 'show_current_user'
      put 'update', to: 'users#update', as: 'update_current_user'
    end

    scope :calendars do
      post '', to: 'calendars#create', as: 'create_current_user_calendar'
      get ':id', to: 'calendars#show', as: 'show_current_user_calendar'
      get 'show/my_calendars', to: 'calendars#show_user_calendars', as: 'current_user_calendars'
      get ':id/month_events', to: 'calendars#month_events', as: 'current_user_calendar_month_events'

      scope :events do
        post ':calendar_id', to: 'events#create', as: 'create_current_user_calendar_event'
        get ':calendar_id/:id', to: 'events#show', as: 'show_current_user_calendar_event'
        put ':calendar_id/:id', to: 'events#update', as: 'updates_current_user_calendar_event'
        delete ':calendar_id/:id', to: 'events#delete', as: 'deletes_current_user_calendar_event'
      end
    end
  end

  get '*unmatched_route', to: 'application#route_not_found'
end
