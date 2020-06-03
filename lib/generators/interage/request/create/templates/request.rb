# frozen_string_literal: true
<%= "\n#{modulus_init.join("\n")}" if modulu_exists? %>
<%= tabs %>class <%= request_class %> < ::<%= request_extend_class %>
<%= tabs %>  private

<%= tabs %>  def key_name
<%= tabs %>    :<%= builder_class.underscore %>
<%= tabs %>  end

<%= tabs %>  def klass
<%= tabs %>    ::<%= builder_full_class %>
<%= tabs %>  end
<%= tabs %>end<%= "\n#{modules_end.join("\n")}" if modulu_exists? %>
