# Thor Gem ##

When run, it generates a new gem project with a skeleton structure for rapidly creating a Thor based gem.

## Installation ##

Thor Gem is installed as a gem and provides an executable <code>thorgem</code> to run it. 

## From github
<pre>  
$ git clone git@github.com:kristianmandrup/thorgem.git
$ rake install
</pre>

## Install directly as a gem

The quick installation alternative using the latest release on RubyGems.

<code>gem install thortask</code>

## Usage

Generate Thor gem 'mytask' skeleton structure

<pre>  
$ thortask mytask
</pre>  
  
Generate Thor gem 'mytask' in namespace 'my_namespace'. The executable will be named 'my_namespace_mytask'.
If the task is installed in the thor repository, it will can be run by thor as 'my_namespace::mytask'. 
  
<pre>  
$ thortask mytask --namespace my_namespace
</pre>  

Creates Thor gem project_creator skipping generation of skeleton for rspec and cucumber.

<pre>  
$ thortask creator --namespace project --no-rspec --skip-cucumber
</pre>  
  
Creates task project:good without any tests generated
 
## TODO

Allow templates to be deployed within `~/.thor` in a `templates` dir for each task directory.

Example deployment structure:
<pre>
.thor
  + my_task
    + templates
    - main.thor

  + my_other_task
    + templates
    - main.thor
</pre>

## Community ##

Suggestions for improvement are welcome!