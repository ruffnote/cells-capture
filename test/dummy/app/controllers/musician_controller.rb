class MusicianController < ActionController::Base
  def index
    render :text => cell(:bassist, :promote)
  end

  def promote
    render :text => cell(:trumpeter, :promote)
  end

  def promotion
    render :text => cell(:bassist, :provoke)
  end

  def featured
  end

  def featured_with_block
  end

  def skills
    render :text => cell(:bassist, :listen)
  end

  def hamlet
  end

  attr_reader :flag
  def promotion_with_block
    html = cell(:bassist, :play) do |cell|
      @flag = cell.class
    end

    render :text => html
  end

end
