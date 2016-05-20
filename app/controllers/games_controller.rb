class GamesController < ApplicationController

  def create
    @owner = User.find(session[:user_id])
    @game = Game.create(owner: @owner)
    @game.add_player(@owner)
    @game.questions << Question.limit(5).order("RANDOM()")
    redirect_to @game, layout: 'page'
  end

  def index
    render json: Game.all
  end

  def show
    @game = Game.find(params[:id])
    @user = User.find(session[:user_id])
    render layout: 'page'
  end

  def edit
    @user = User.find(session[:user_id])
    @game = Game.find(params[:id])
    @game.add_player(@user)
    redirect_to @game, layout: 'page'
  end

  def update
    @game = Game.find(params[:id])
    @user = User.find(session[:user_id])
    @game.players.delete(Player.where(user: @user))
    redirect_to @game, layout: 'page'
  end

  def play
    @game = Game.find(params[:game_id])
    @questions = @game.questions
    render json: @questions
  end

  def play_game
    @game = Game.find(params[:game_id])
    @user = current_user
    @player = Player.find_by(user: @user, game: @game)
    render layout: 'page'
  end
end
