SeedTest::Application.routes.draw do
  root to: 'home#index'
  
  post 'home/index' => 'home#create_user'

  get 'home/survey' => 'home#step_two'
  post 'home/survey' => 'home#save_survey'

  get 'home/congratulation' => 'home#congratulation'
  post 'home/congratulation' => 'home#congratulation'
end
