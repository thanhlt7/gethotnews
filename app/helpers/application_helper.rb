module ApplicationHelper
	def current_class?(test_path)
    return 'active' if request.fullpath == test_path
    ''
  end
end
