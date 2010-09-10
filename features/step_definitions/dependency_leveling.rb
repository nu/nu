require 'lib/nu/dependency_leveler'

def existing_package(name, version)
	@packages.select {|spec| spec.name == name && spec.version == version}.first
end

Given /^package "([^"]*) \((\d\.\d\.\d)\)" is installed$/ do |name, version|
	@installed_packages ||= [] << existing_package(name, version)
end

When /^package "([^"]*) \((\d\.\d\.\d)\)" is proposed$/ do |name, version|
	leveler = DependencyLeveler.new(@installed_packages)
	@result = leveler.analyze_proposal(existing_package(name, version))
end


Then /^a conflict should be detected$/ do
  @result.conflict?.should be_true
end

Then /^a conflict should not be detected$/ do
  @result.conflict?.should be_false
end

Then /^the acceptable version for package "([^"]*)" should be "(\d\.\d\.\d)"$/ do |name, version|
  row = @result.acceptable_packages.select {|item_name, item_version| item_name == name}
  row.first[:version].should eql(version)
end

Then /^the conflicting package name should be "([^"]*)"$/ do |name|
  @result.conflicting_packages.should include(name)
end

Then /^the conflicting packages should include "([^"]*)"$/ do |name|
  @result.conflicting_packages.should include(name)
end
