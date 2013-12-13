module UserSettingsHelper

  def javascript_include_tag_for_user_settings
    javascript_include_tag 'user_settings'
  end

  def init_user_settings
    js = <<-JAVSCRIPT.strip_heredoc
      <script type="text/javascript">
        $.userSettings = $.userSettings('#{UserSettings.base_path}');
      </script>
    JAVSCRIPT
    js.html_safe
  end

end
