$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'gdata'
require 'hpricot'
require 'yaml'
require 'ostruct'

require File.dirname(__FILE__) + '/lib/gcal'
ActiveRecord::Base.send(:include, Gcal )
