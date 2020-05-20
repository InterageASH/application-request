# frozen_string_literal: true
<%= "\n#{modulus_init.join("\n")}" if modulu_exists? %>
<%= tabs %>class <%= builder_class %> < ApplicationBuilder
<%= tabs %>  attr_accessor <%= builder_accessors %>

<%= tabs %>  def requester
<%= tabs %>    @requester ||= ::<%= request_full_class %>.new
<%= tabs %>  end

<%= tabs %>  private

<%= tabs %>  def changeable_attributes
<%= tabs %>    { <%= builder_changeable_attributes %> }
<%= tabs %>  end
<%= tabs %>end<%= "\n#{modules_end.join("\n")}" if modulu_exists? %>
