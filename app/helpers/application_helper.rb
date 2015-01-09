module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "KMSC" # xxx change to user later!
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end	

  def button_to_remove_fields(name, f)
    button_to_function(name, "remove_fields(this)")
  end

  def button_to_function(name, function=nil, html_options={})
    onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function};"
    tag(:input, html_options.merge(:type => 'button', :value => name, :onclick => onclick, :class => "btn btn-danger btn-small"))
  end  

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end  
end
