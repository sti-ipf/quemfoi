# -*- encoding : utf-8 -*-
require 'rubygems'
require File.dirname(__FILE__)+'/../config/application'
require File.dirname(__FILE__)+'/../config/environment'


participants = Participant.all(:conditions => "unit is null OR unit = ''", :order => "name")
Util::Csv.generate(participants, 'unidade_em_branco')

