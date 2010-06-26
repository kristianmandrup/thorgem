require 'active_support/inflector'
require 'thor'
require 'thor/group'

class Thorgem < Thor::Group
  include Thor::Actions

  # Define arguments and options
  argument :app_name
  class_option :namespace, :type => :string, :default => false, :desc => 'namespace of thor task'
  class_option :skip_rspec, :type => :boolean, :default => false, :desc => 'skip creation of rspec config'
  class_option :skip_cucumber, :type => :boolean, :default => false, :aliases => ['-c'], :desc => 'skip creation of cucumber config'
  class_option :skip_signatures, :type => :boolean, :default => false, :aliases => ['-s'], :desc => 'skip creation of signature files'
  class_option :templates, :type => :boolean, :default => false, :aliases => ['-t'], :desc => 'set to create initial templates dir' 
  class_option :binaries, :type => :boolean, :default => false, :aliases => ['-b'], :desc => 'create binaries'  

  def self.source_root
    # template_path(__FILE__)
    File.join(File.dirname(__FILE__), '..', 'templates')      
  end

  def create_root
    self.destination_root = File.expand_path(app_name, destination_root)
    empty_directory '.'
    FileUtils.cd(destination_root)
  end
                                                
  def create_cucumber_features       
    return if options[:skip_cucumber]
    empty_directory 'features'       
    inside 'features' do
      template('app_name.feature', "#{app_name}.feature")
      empty_directory 'step_definitions'
      empty_directory 'support'
      inside 'support' do                       
          template 'env.rb'
      end
    end
  end

  def create_binaries    
    return if !options[:binaries]             
    empty_directory 'bin'
    inside "bin" do      
      template 'binary', "#{app_name}"
      template 'binary.bat', "#{app_name}.bat"      
    end
  end
                                              
  def create_specs                                
    return if options[:skip_rspec]         
    empty_directory 'spec'       
    inside 'spec' do                            
      empty_directory "#{app_name}"
      template 'spec_helper.rb', "#{app_name}/spec_helper.rb"
      template 'app_name/sample_spec.rb', "#{app_name}/#{app_name}_spec.rb"
    end
  end

  def create_signature
    return if options[:skip_signatures]             
    empty_directory '_signatures'               
    inside '_signatures' do                            
      template 'APP.RUBY.TASK.THOR.signature', 'APP.RUBY.TASK.THOR.signature'       
    end
  end

  def create_lib
    empty_directory 'lib'
    inside 'lib' do
      template 'app_name.rb', "#{app_name}.thor"
      directory 'templates' if options[:templates]
    end
  end

  def copy_readme
    template 'README.markdown'
  end


  def copy_licence
    if yes?("Use MIT license?")   
                                                                                              
      if !ENV['USERNAME']
        say "WARNING: Env. variable USERNAME not set, using USERNAME = '#{ENV['USER']}' in license", :yellow   
       end

      # Make a copy of the MITLICENSE file at the source root
      template "MITLICENSE"
    else
       say "Shame on you…", :red
    end
  end 
  
end
