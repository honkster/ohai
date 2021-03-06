#
# Author:: Adam Jacob (<adam@opscode.com>)
# Copyright:: Copyright (c) 2008 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


require File.join(File.dirname(__FILE__), '..', '..', '/spec_helper.rb')

describe Ohai::System, "plugin os" do
  before(:each) do
    @ohai = Ohai::System.new    
    @ohai.stub!(:require_plugin).and_return(true)
    @ohai[:languages] = Mash.new
    @ohai[:languages][:ruby] = Mash.new
    @ohai[:kernel] = Mash.new
    @ohai[:kernel][:release] = "kings of leon"
  end

  it "should set os_version to kernel_release" do
    @ohai._require_plugin("os")
    @ohai[:os_version].should == @ohai[:kernel][:release]
  end
  
  describe "on linux" do
    before(:each) do
      @ohai[:languages][:ruby][:host_os] = "linux"
    end
    
    it "should set the os to linux" do
      @ohai._require_plugin("os")
      @ohai[:os].should == "linux"
    end
  end
  
  describe "on darwin" do
    before(:each) do
      @ohai[:languages][:ruby][:host_os] = "darwin"
    end
    
    it "should set the os to darwin" do
      @ohai._require_plugin("os")
      @ohai[:os].should == "darwin"
    end
  end
end