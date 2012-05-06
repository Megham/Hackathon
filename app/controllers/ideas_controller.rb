class IdeasController < ApplicationController
  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = Idea.all
    set_gmail_username
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ideas }
    end
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    @idea = Idea.find(params[:id])
    set_gmail_username
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea }
    end
  end

  # GET /ideas/new
  # GET /ideas/new.json
  def new
    @idea = Idea.new
    @idea.owner = gmail_username
    raise_error_on_intrusion

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @idea }
    end
  end

  # GET /ideas/1/edit
  def edit
    @idea = Idea.find(params[:id])
    raise_error_on_intrusion
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @idea = Idea.new(params[:idea])
    raise_error_on_intrusion

    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
        format.json { render json: @idea, status: :created, location: @idea }
      else
        format.html { render action: "new" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ideas/1
  # PUT /ideas/1.json
  def update
    @idea = Idea.find(params[:id])
    raise_error_on_intrusion

    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea = Idea.find(params[:id])
    raise_error_on_intrusion
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to ideas_url }
      format.json { head :ok }
    end
  end

  private
  def raise_error_on_intrusion
    raise t("hello") if gmail_username.nil? || @idea.owner != gmail_username 
  end

  def set_gmail_username
    @gmail_username = gmail_username
  end
end
