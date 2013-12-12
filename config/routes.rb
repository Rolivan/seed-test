SeedTest::Application.routes.draw do
  root to: 'home#index'
  
  post 'home/index' => 'home#create_user'
end
