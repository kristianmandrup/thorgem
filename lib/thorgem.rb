require 'active_support/inflector'
require 'thor'
require 'thor/group'

class Thorgem< Thor::Group
  include Thor::Actions

  # Define arguments and options
  argument :app_name

  class_option :namespace, :type => :string, :default => nil, :desc => 'namespace of thor task'

  class_option :jewel, :type => :boolean, :default => true, :aliases => ['-j'], :desc => 'create task as a jewel'  
  class_option :binaries, :type => :boolean, :default => true, :aliases => ['-b'], :desc => 'add binaries'
  class_option :rspec, :type => :boolean, :default => true, :desc => 'congigure rspec'
  class_option :wiki, :type => :boolean, :default => true, :aliases => ['-w'], :desc => 'add wiki dir'
  
  class_option :templates, :type => :boolean, :default => false, :aliases => ['-t'], :desc => 'add templates dir'
  class_option :cucumber, :type => :boolean, :default => false, :aliases => ['-c'], :desc => 'configure use of cucumber'
  class_option :signatures, :type => :boolean, :default => false, :aliases => ['-s'], :desc => 'create signature files'

  def self.source_root
    # template_path(__FILE__)
    File.expand_path(File.dirname(__FILE__) + '/../templates')
  end

  def main
    create_jewel if options[:jewel]
    create_root if !options[:jewel] 
    main_flow
  end

  protected

  def create_jewel
    run "jeweler #{app_name}"
    self.destination_root = File.expand_path(app_name, destination_root)
    FileUtils.cd(destination_root)    
  end

  def create_root
    self.destination_root = File.expand_path(app_name, destination_root)
    empty_directory '.'
    FileUtils.cd(destination_root)
  end

  def main_flow
    lib
    readme                    
    wiki if options[:wiki]    
    signatures if options[:signatures]    
    binaries if options[:binaries]
    cucumber if options[:cucumber]
    rspec if !options[:rspec] 
    licence if options[:license] 
  end
                                                
  def cucumber          
    empty_directory 'features'       
    inside 'features' do
      template 'app_name.feature', "#{app_name}.feature"
      empty_directory 'step_definitions'
      empty_directory 'support'
      inside 'support' do                       
          template 'env.rb'
      end
    end
  end

  def binaries        
    empty_directory 'bin'
    inside "bin" do      
      template 'binary.erb', "#{ns_app_name}"
      template 'binary.erb.bat', "#{ns_app_name}.bat"      
    end
  end
                                              
  def rspec                                
    empty_directory 'spec'       
    inside 'spec' do                            
      empty_directory "#{app_name}"
      template 'spec_helper.rb', "#{app_name}/spec_helper.rb"
      template 'app_name/sample_spec.rb', "#{app_name}/#{app_name}_spec.rb"
    end
  end

  def signatures
    empty_directory '_signatures'               
    inside '_signatures' do                            
      template 'APP.RUBY.TASK.THOR.signature', 'APP.RUBY.TASK.THOR.signature'       
    end
  end

  def lib
    empty_directory 'lib'
    inside 'lib' do
      template 'app_name.rb', "#{app_name}.thor"
      template 'app_name.rb', "#{app_name}.rb" if !File.exist("#{app_name}.rb") # if not jewel
      directory 'templates' if options[:templates]
    end
  end

  def wiki
    empty_directory 'wiki'
    inside 'wiki' do
      template 'home.textile'
    end
  end

  def readme
    run "rm -f README.rdoc" if File.exist? 'README.rdoc'
    template 'README.markdown'
  end

  def licence
    if yes? "Use MIT license?"
      say("WARNING: Env. variable USERNAME not set, using USERNAME = '#{ENV['USER']}' in license", :yellow) if !ENV['USERNAME'] 
      # Make a copy of the MITLICENSE file at the source root
      template "MITLICENSE"
      return 
    end
    say("Shame on you!", :red)    
  end   
  
  private

  def class_name                                          
    name = if options[:namespace]
      "#{options[:namespace]}::#{app_name}"
    else     
      app_name
    end
    name.camelize
  end
  
  def ns_app_name
    return "#{options[:namespace]}_#{app_name}" if options[:namespace]
    app_name    
  end
  
end
