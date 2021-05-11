module Primer
  class TaskListPreview < ViewComponent::Preview
    def default
      render(Primer::TaskList.new)
    end
  end
end
