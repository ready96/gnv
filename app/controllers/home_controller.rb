require 'mandrill'

class HomeController < ApplicationController
  
  after_filter :dynamic_content, only: [:index, :em_home]
  after_filter :static_content, only: [:home, :connect, :about, :supplies, :quick_guide, :our_manifesto]

  def index
    if CurrentMode.isCrisisMode
      redirect_to em_home_path
    else
      redirect_to home_path
    end
  end

  def em_home
    @mode = CurrentMode.getCurrentMode
    @citizen_feed = CitizenFeed.first
  end

  def about
    @render_captcha = MailHelper::posible_attack?
  end

  def supplies
    @items = Item.find(:all, order: 'items.order ASC')
    @kits = Kit.all
  end

  empty_methods :home, :connect, :quick_guide, :our_manifesto

end
