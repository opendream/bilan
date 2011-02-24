namespace :gettext do
  def files_to_translate
    Dir.glob("{app,lib,config,locale}/**/*.{rb,erb,haml,rhtml,slim}")
  end
end
