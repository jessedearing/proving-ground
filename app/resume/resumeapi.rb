require 'sinatra/base'
require 'yaml'
require 'erb'
require "#{Rails.root}/app/models/resume"
require 'active_support/all'
require 'xmlsimple'

class ResumeApi < Sinatra::Base
  set :views, "#{File.dirname(__FILE__)}/views"
  get '/resume' do
    accept = env['rack-accept.request']
    case
    when accept.media_type?('text/html')
      render_resume(:html)
    when accept.media_type?('text/plain')
      render_resume(:txt)
    when accept.media_type?('application/xml')
      render_resume(:xml)
    when accept.media_type?('application/json')
      render_resume(:json)
    when accept.media_type?('application/pdf')
      render_resume(:pdf)
    when accept.media_type?('application/markdown')
      render_resume(:markdown)
    when accept.media_type?('application/yaml')
      render_resume(:yaml)
    else
      render_resume
    end
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
    content_type('application/yaml')
    @resume_raw
  end

  def render_text
    content_type('text/plain')
    # come up with a different template later
    redirect to('/resume.md'), 307
  end

  def render_markdown
    content_type('application/markdown')
    erb :markdown
  end

  def render_json
    content_type('application/json')
    @resume.to_json
  end

  def render_pdf
    content_type('application/pdf')
    attachment('resume.pdf')
    @resume.to_pdf
  end

  def render_xml
    content_type('application/xml')
    XmlSimple.xml_out(@resume_yaml)
  end
end
