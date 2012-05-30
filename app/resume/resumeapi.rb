require 'sinatra/base'
require 'yaml'
require 'erb'
require "#{Rails.root}/app/models/resume"
require 'active_support/all'
require 'xmlsimple'

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
    @resume_raw = File.read "#{Rails.root.to_s}/db/resume.yaml"
    @resume_yaml = nil unless Rails.env.production?
    @resume_yaml ||= YAML.load_file("#{Rails.root.to_s}/db/resume.yaml")
    @resume = Resume.new(@resume_yaml)
    case format.to_sym
    when :html, :htm then render_html
    when :markdown, :md then render_markdown
    when :yaml, :yml then render_yaml
    when :json, :js then render_json
    when :xml then render_xml
    when :txt, :text then render_text
    when :pdf then render_pdf
    else unsupported_media_type
    end
  end

  def unsupported_media_type
    status 415
    "Unsupported media type"
  end

  def render_html
    erb :html
  end

  def render_yaml
    @resume_raw
  end

  def render_text
    # come up with a different template later
    redirect to('/resume.md'), 307
  end

  def render_markdown
    erb :markdown
  end

  def render_json
    @resume.to_json
  end

  def render_pdf
    @resume.to_pdf
  end

  def render_xml
    XmlSimple.xml_out(@resume_yaml)
  end
end
