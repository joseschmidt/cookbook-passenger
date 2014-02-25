# encoding: utf-8
if defined?(ChefSpec)
  # cookbook:: rvm
  def create_rvm_environment(resource_name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:rvm_environment, :create, resource_name)
  end # def

  # cookbook:: rvm
  def install_rvm_global_gem(resource_name)
    ChefSpec::Matchers::ResourceMatcher
      .new(:rvm_global_gem, :install, resource_name)
  end # def

end # if
