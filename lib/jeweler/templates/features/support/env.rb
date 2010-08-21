<%= render_template 'bundler_setup.erb' %>

require '<%= require_name %>'

require '<%= feature_support_require %>'
<% if feature_support_extend %>

World(<%= feature_support_extend %>)
<% end %>
