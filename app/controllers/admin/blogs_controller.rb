class Admin::BlogsController < Admin::ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    params[:display_count] ||= 10
    @blogs = Blog.search(params[:search]).page(params[:page]).per(params[:display_count])
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to [:admin, @blog], notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to [:admin, @blog], notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to admin_blogs_url(page: params[:page]), notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def export_csv
    respond_to do |format|
      format.csv do
        send_data Blog.to_csv,
        type: 'text/csv; charset=utf-8',
        filename: "blogs_#{Time.now.strftime("%Y_%m_%d_%H_%M_%S")}.csv"
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.fetch(:blog, {}).permit(:title, :content, :is_public, :image)
    end
end
