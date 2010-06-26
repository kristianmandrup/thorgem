require 'active_support/inflector'
require 'thor'
require 'thor/group'

<%= "module #{options[:namespace].camelize}" if options[:namespace] %>
class <%= app_name.camelize %> < Thor::Group
  include Thor::Actions

  # group used when displaying thor tasks with: thor list or thor -T
  <% if options[:namespace] %>
  group :<%= options[:namespace] %>
  <% end %>

  # Define arguments 
  argument :name 
  # argument :my_arg_name, :type (:string, :hash, :array, :numeric), :default, :required, :optional, :desc, :banner

  # Define options
  class_option :my_option, :type => :boolean, :default => true 
  # class_option :my_other_option, :type (:string, :hash, :array, :numeric or :boolean), :default, :required => false, :group, :aliases => '-p', :desc, :banner  

  def self.source_root                   
    # use line below when deploying the task
    # template_path(__FILE__)        
    # local_template_path(__FILE__) # tries ROOT/templates and then ROOT/lib/templates        
    File.expand_path(File.dirname(__FILE__) + '/../templates')    
  end

  def main       
    create_root
    create_optional if options[:my_option]
  end

  protected

  def create_root
    self.destination_root = File.expand_path(name, destination_root)
    empty_directory '.'
    FileUtils.cd(destination_root)
  end   
  
  def create_optional           
    empty_directory 'optional' 
    <% if options[:templates] %>                
    template 'my_template.erb', "#{name}.rb"
    inside 'optional' do
      template 'opt_template.erb', "opt_#{name}.rb"
    end
    <% end %>
  end
  
end
<%= "end" if options[:namespace] %>                  
