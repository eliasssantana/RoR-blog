class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [ :new, :create, :destroy, :edit ]

  # GET /comments or /comments.json
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  # GET /comments/1 or /comments/1.json
  def show
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    @post = @comment.post
  end

  # POST /comments or /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.anonymous = params[:comment][:anonymous]

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_comments_path , notice: "Comentado com sucesso!" }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to post_comments_path, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    @comment.anonymous = params[:comment][:anonymous]
    
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_comments_path, notice: "Comentário atualizado com sucesso!" }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to post_comments_path(@comment.post), notice: "Comentário deletado com sucesso!" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content)
    end
end
