class UserSettingsPresenter
  attr_reader :resource

  def initialize(resource)
    @resource = resource
  end

  def as_json
    if @resource == false || @resource == true || @resource == nil
      { success:  @resource || false }
    else
      {
        success: true,
        value: @resource
      }
    end
  end
end
