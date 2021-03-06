# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show home]

  def index
    @post = Post.new
    @comment = Comment.new
    @like = Like.new    
  end

  def home; end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
      else
        format.html { redirect_to posts_path, notice: 'Content missing. Please type the content.' }
        format.json { render json: @post.errors, status: :unprocessable_entity  }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_path, notice: 'Post was successfully updated.' }
        format.json { render :index, status: :ok, location: @post }
      else
        format.html { render 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def comment
    @comment = Comment.new
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:content,
                                 :image,
                                 :comments_attributes,
                                  %i[id content image user_id])
  end

  def comment_params
    params.require(:post).permit(
      :comments_attributes, %i[content user_id]
    )
  end
end
