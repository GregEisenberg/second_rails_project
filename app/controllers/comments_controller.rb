class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :set_link

  # GET link/{id}/comments or link/{id}/comments.json
  def index
    @comments = Comment.where(link_id: @link.id) # Comment.all
  end

  # GET link/{id}/comments/{id}
  def show
  end

  # GET link{id}/comments/new
  def new
    @comment = Comment.new
  end

  # GET link/{id}/comments/1/edit
  def edit
  end

  # POST link/{id}/comments or /comments.json
  def create
    puts ("*-*-*-*-*-*-*-* #{__method__}\n\tparams: #{params.inspect}")
    puts ("\t #{current_user.inspect}")

    @comment = @link.comments.new(comment_params())
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @link, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
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
      format.html { redirect_to link_comments_path, status: :see_other, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.expect(comment: [ :body, :link_id, :user_id ])
    end

    # before_action call to set_link and ensure that @link is found
    def set_link
      @link = Link.find(params[:link_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to request.referer || links_path, alert: "Link not found in  #{self.class}.#{__method__} - did a route or path get moved?? was that link_id removed??"
    end
end
