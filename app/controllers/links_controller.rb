class LinksController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_link, only: %i[ show edit update destroy ]

  # GET /links or /links.json
  def index
    @links = Link.all
  end

  # GET /links/1 or /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = current_user.links.build
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links or /links.json
  def create
    puts("*-*-* #{__method__}  #{current_user.inspect}")

    # A few ways to do this
    #  1)
    # lp = link_params()  # validate the incoming parameters
    # lp[:user_id] = current_user.id # add user_id to the has
    # @link = Link.new(lp)  # create the new link

    # 2) uses the current_user and grabs the `links` attribute of that user and then uses the build API
    #    note build is prefered whene there are associations
    # @link = current_user.links.build(link_params())

    # 3) uses the current_user and grabs the `links` attribute of that user and then uses the new API
    @link = current_user.links.new(link_params())

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: "Link was successfully created." }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: "Link was successfully updated." }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy!

    respond_to do |format|
      format.html { redirect_to links_path, status: :see_other, notice: "Link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def like
    @link = Link.find(params[:id])
    if params[:format] == "like"
      @link.liked_by current_user
    elsif params[:format] == "unlike"
      @link.unliked_by current_user
    end
    redirect_back fallback_location: root_path
  end

  def dislike
    puts("*-*-* #{__method__}  #{current_user.inspect} #{params.inspect}")

    @link = Link.find(params[:id])
    if params[:format] == "dislike"
      @link.disliked_by current_user
    elsif params[:format] == "undislike"
      @link.undisliked_by current_user
    end
    redirect_back fallback_location: root_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def link_params
      params.expect(link: [ :title, :url ])
    end
end
