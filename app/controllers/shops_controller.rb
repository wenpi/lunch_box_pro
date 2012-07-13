#encoding: utf-8
class ShopsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :authenticate_admin_user!, :only => [:destroy]
  
  def index
    if params[:shop_name].blank?
      @shops =Shop.paginate(:page => params[:page] || 1, :per_page => 20)
    else
      @shops = Shop.where("name like '%#{params[:shop_name]}%' ").paginate(:page => params[:page] || 1, :per_page => 20)
    end
  end

  def create
    super
    @shop.updated_by = current_user.id
    @shop.save
  end

  def update
    @shop = Shop.find(params[:id])

    respond_to do |format|
      if @shop.update_attributes(params[:shop])
        @shop.updated_by = current_user.id
        @shop.save
        format.html { redirect_to(shop_url, :notice => '信息修改成功') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shop.errors, :status => :unprocessable_entity }
      end
    end
  end

end
