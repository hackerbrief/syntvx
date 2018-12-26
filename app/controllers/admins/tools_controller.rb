class Admins::ToolsController < Admins::AdminAppController
  before_action :set_tool, only: %i[info]

  # GET /admins/tools
  def index
    private_seo('Tools')
    @tools = Tool.admin_search(params[:term], params[:filter], params[:page])
  end

  # GET /admins/tools/:id
  def info
    respond_to :js
  end

  private

    def set_tool
      @tool = Tool.friendly.include_assoc.find(params[:id])
    end

    def admin_tools_responder(notice)
      respond_to do |format|
        format.html { redirect_to admins_tools_path }
        format.js
      end
    end

end
