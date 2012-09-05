class DocumentsController < ApplicationController
  if Rails.env.development? || Rails.env.tr?
    before_filter :set_user
  end

  def index
    @documents = Document.all
    render :json => @documents.collect { |p| p.to_jq_upload }.to_json
  end

  def new
    @object_new = Document.new    # needed for form_for --> gets the path
  end

  def create
    @document = Document.new(:user => current_user)
    @document.source = params[:document][:path]
    if @document.save
      respond_to do |format|
        #(html response is for browsers using iframe solution)
        format.html {
          render :json => [@document.to_jq_upload].to_json,
                 :content_type => 'text/html',
                 :layout => false
        }
        format.json {
          render :json => [@document.to_jq_upload].to_json
        }
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    render :json => true
  end

  def result
    render :layout => 'results'
  end

  private

  def set_user
    @current_user = User.first
  end
end