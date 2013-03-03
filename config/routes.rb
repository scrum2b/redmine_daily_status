get  '/projects/:project_id/daily_status'     => 'daily_statuses#index'
get  '/projects/:project_id/daily_status/:id' => 'daily_statuses#show',   :defaults => { :format => 'json' }
post '/projects/:project_id/daily_status'     => 'daily_statuses#save'

