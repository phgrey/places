require 'open-uri'
class Parse::Base

  # @param [Parsetask] task - task to process

  def self.process task


    url = get_url( task)

      responce = false
      open(url){|io|responce = io.read}
      tsk = Parsetask.create(:url =>url, :responce => responce, :level => level, :lang =>lang, :source => @source)

      send(level, responce).each{|item|
        City.create(:title => item[:title]).parses.create(:external_id => item[:title], :parsetask_id => tsk.id)

    }


  end

  # @param [Parsetask] task
  def self.get_level task
    (task.item_type+'_by_'+ (task.parent.nil? ? 'main' : task.parent.item_type) ).downcase.to_sym
  end

  def self.get_url task
    @urls[get_level task].gsub('LANG', task.lang)
  end

end