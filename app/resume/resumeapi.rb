require 'sinatra/base'
require 'yaml'
require 'erb'
require "#{Rails.root}/app/models/resume"
require 'active_support/all'

class ResumeApi < Sinatra::Base
  set :views, "#{File.dirname(__FILE__)}/views"
  get '/resume' do
    render_resume
  end
  get '/resume.:format' do
    render_resume(params[:format])
  end

  private

  def render_resume(format = :html)
    @@resume_raw = File.read "#{Rails.root.to_s}/db/resume.yaml"
    @@resume ||= YAML.load_file("#{Rails.root.to_s}/db/resume.yaml")
    @resume = Resume.new(@@resume)
    case format.to_sym
    when :html then render_html
    when :markdown, :md then render_markdown
    when :yaml, :yml then render_yaml
    when :json, :js then render_json
    when :xml then render_xml
    end
  end

  def render_html
    erb :html
  end

  def render_yaml
    @@resume_raw
  end

  def render_markdown
    erb :markdown
  end

  def render_json
    @resume.to_json
  end

  def render_xml
    @@resume.to_xml
  end
end
