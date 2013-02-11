
#require 'nokogiri'

class ParseController  < ActionController::Base

  def main

    Parse::Mapia.process :cities
  end

  def test
    @test = Parse::Mapia.test
  end

  def view_task
    @task = Parsetask.find(params[:id])
  end

  def parse_task
    task = Parsetask.find(params[:id])

    @cities = Parse::Mapia.cities task.responce
  end
end