# RAILS_ROOT/features/support/paths.rb
def path_to(page_name)
  case page_name

  when /homepage/
    root_path
  when /New Category/
    new_category_path

  else
    raise "Cannot convert \"#{page_name}\" to path."
  end
end