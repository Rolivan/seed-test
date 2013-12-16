class HomeController < ApplicationController
  require 'GifbinParser'
  before_filter :define_state,  :only => [:index, :step_two, :congratulation]

  def index
    @user = User.new
  end

  def step_two
    @survey = Survey.new
  end

  def congratulation 
    @gifbin_src = GifbinParser.new().random
  end

  def save_survey
    survey = Survey.new params[:survey]
    survey.user = current_user
    @result = if survey.save
                update_state 'congratulation'
                @gifbin_src = GifbinParser.new().random
                html = render_to_string :template => "home/congratulation", :layout => false
                {ok: true, url: '/home/congratulation', state: 'congratulation', html: html}
                # render :template => :new, :layout => false
              else 
                {ok: false, messages: survey.errors.messages}
              end

    render_result
  end 

  def create_user
    user = User.new params[:user]
    @result = if user.save
                current_user user
                update_state 'survey'
                @survey = Survey.new
                html = render_to_string :template => "home/step_two", :layout => false
                {ok: true, url: '/home/survey', state: 'survey', html: html}
              else 
                {ok: false, messages: user.errors.messages}
              end
    
    render_result
  end

  def render_result
    render json: @result
  end

  def current_user(user = nil)
    session[:user_id] = user.id if user
    user = User.find_by_id session[:user_id]
  end

  def define_state
    @state = session[:state] || 'register'
    update_state @state

    stateActionMap = {
      'register' => 'index',
      'survey' => 'step_two',
      'congratulation' => 'congratulation',
    }

    direct = stateActionMap.map { |state, action| state == @state && action == params[:action] }.uniq.include? true
    redirect_to controller: 'home', action: stateActionMap[@state] unless direct
  end

  def update_state(state)
    session[:state] = state
  end
end
